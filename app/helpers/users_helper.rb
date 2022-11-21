# frozen_string_literal: true

module UsersHelper
  def user_handle(user)
    "@#{user.handle}"
  end

  def user_avatar(user)
    "https://source.boringavatars.com/beam/120/#{ERB::Util.url_encode(user.handle)}?colors=264653,2a9d8f,e9c46a,f4a261,e76f51"
  end

  def user_avatar_tag(user)
    tag.img src: user_avatar(user), alt: "Avatar de #{user.handle}", class: 'avatar', class: 'aspect-square w-10 inline'
  end

  def user_big_avatar_tag(user)
    tag.img src: user_avatar(user), alt: "Avatar de #{user.handle}", class: 'avatar', class: 'aspect-square w-20 inline'
  end
end
