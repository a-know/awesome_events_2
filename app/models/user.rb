class User < ApplicationRecord
  before_destroy :check_all_events_finished

  has_many :created_events, class_name: "Event", foreign_key: "owner_id", dependent: :nullify
  has_many :tickets, dependent: :nullify
  has_many :participating_events, through: :tickets, source: :event # https://railsguides.jp/association_basics.html

  def self.find_or_create_from_auth_hash!(auth_hash)
    provider = auth_hash[:provider]
    uid = auth_hash[:uid]
    nickname = auth_hash[:info][:nickname]
    image_url = auth_hash[:info][:image]

    User.find_or_create_by!(provider: provider, uid: uid) do |user|
      user.name = nickname
      user.image_url = image_url
    end
  end

  private

  def check_all_events_finished
    now = Time.zone.now

    if created_events.where(":now < end_at", now: now).exists?
      errors[:base] << "Non-ended public event exists."
    end

    if participating_events.where(":now < end_at", now: now).exists?
      errors[:base] << "Non-ended event you participate exists."
    end

    throw(:abort) unless errors.empty? # https://qiita.com/___dera/items/6a73e84a183a706e4d39
  end
end
