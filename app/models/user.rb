# == Schema Information
#
# Table name: users
#
#  id           :integer          not null, primary key
#  auth0_data   :json
#  fuzzy_handle :string
#  handle       :string
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  auth0_id     :string
#
class User < ApplicationRecord
  validates :handle, presence: true, uniqueness: true, length: { maximum: 25 }

  has_many :posts, dependent: :destroy
  has_many :follows, foreign_key: :follower_id, dependent: :destroy
  has_many :followees, through: :follows, source: :followee
  has_many :inverse_follows, foreign_key: :followee_id, class_name: 'Follow', dependent: :destroy
  has_many :followers, through: :inverse_follows, source: :follower


  before_save :set_fuzzy_handle

  def set_fuzzy_handle
    self[:fuzzy_handle] = User.cleanHandle(handle)
  end

  def self.cleanHandle(str)
    accents = {
      ['á','à','â','ä','ã'] => 'a',
      ['Ã','Ä','Â','À'] => 'A',
      ['é','è','ê','ë'] => 'e',
      ['Ë','É','È','Ê'] => 'E',
      ['í','ì','î','ï'] => 'i',
      ['Î','Ì'] => 'I',
      ['ó','ò','ô','ö','õ'] => 'o',
      ['Õ','Ö','Ô','Ò','Ó'] => 'O',
      ['ú','ù','û','ü'] => 'u',
      ['Ú','Û','Ù','Ü'] => 'U',
      ['ç'] => 'c', ['Ç'] => 'C',
      ['ñ'] => 'n', ['Ñ'] => 'N'
    }
    accents.each do |ac,rep|
      ac.each do |s|
        str = str.gsub(s, rep)
      end
    end
    str = str.gsub(/[^a-zA-Z0-9\. ]/,"")
    str = str.gsub(/[ ]+/," ")
    str = str.gsub(/ /,"-")
    str = str.gsub(/[^a-zA-Z0-9\. ]/,"")
    str = str.gsub(/[ ]+/," ")
    str = str.gsub(/ /,"-")
    str = str.downcase
  end
end
