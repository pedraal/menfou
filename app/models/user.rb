# frozen_string_literal: true

# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  followees_count :integer          default(0)
#  followers_count :integer          default(0)
#  fuzzy_handle    :string
#  handle          :string
#  posts_count     :integer          default(0)
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  auth0_id        :string
#
class User < ApplicationRecord
  validates :handle, presence: true, uniqueness: true, length: { maximum: 25 }

  has_many :posts, dependent: :destroy
  has_many :followers, foreign_key: :followee_id, class_name: 'Follow', dependent: :destroy
  has_many :followees, foreign_key: :follower_id, class_name: 'Follow', dependent: :destroy

  before_save :set_fuzzy_handle

  def set_fuzzy_handle
    self[:fuzzy_handle] = User.cleanHandle(handle)
  end

  def self.cleanHandle(str)
    accents = {
      %w[á à â ä ã] => 'a',
      %w[Ã Ä Â À] => 'A',
      %w[é è ê ë] => 'e',
      %w[Ë É È Ê] => 'E',
      %w[í ì î ï] => 'i',
      %w[Î Ì] => 'I',
      %w[ó ò ô ö õ] => 'o',
      %w[Õ Ö Ô Ò Ó] => 'O',
      %w[ú ù û ü] => 'u',
      %w[Ú Û Ù Ü] => 'U',
      ['ç'] => 'c', ['Ç'] => 'C',
      ['ñ'] => 'n', ['Ñ'] => 'N'
    }
    accents.each do |ac, rep|
      ac.each do |s|
        str = str.gsub(s, rep)
      end
    end
    str = str.gsub(/[^a-zA-Z0-9. ]/, '')
    str = str.squeeze(' ')
    str = str.tr(' ', '-')
    str = str.gsub(/[^a-zA-Z0-9. ]/, '')
    str = str.squeeze(' ')
    str = str.tr(' ', '-')
    str = str.downcase
  end
end
