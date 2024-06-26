class Group < ApplicationRecord
  has_many :group_users, dependent: :destroy
  belongs_to :owner, class_name: 'User'
  has_many :users, through: :group_users, source: :user
  has_many :permits, dependent: :destroy
  has_many :post_tags, dependent: :destroy
  has_many :tags, through: :post_workout_tags
  
  has_many :tags, dependent: :destroy

  validates :name, presence: true, length: { maximum: 20 }
  validates :introduction, presence: true, length: { maximum: 200 }
  has_one_attached :group_image
  
  def is_owned_by?(user)
    owner.id == user.id
  end
  
  def includesUser?(user)
    group_users.exists?(user_id: user.id)
  end
  
  def get_group_image(width, height)
    unless group_image.attached?
      file_path = Rails.root.join('app/assets/images/no_image.jpg')
      group_image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
    group_image.variant(resize_to_limit: [width, height]).processed
  end
  
  def self.search_for(content)
    if content.present?
      Group.where('name LIKE ?', '%'+content+'%')
    else
      Group.none
    end
  end
end
