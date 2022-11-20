# frozen_string_literal: true

module PostsHelper
  def relative_post_timestamp(post)
    created_at_from_now = Time.current - post.created_at
    if created_at_from_now < 1.minute
      "#{(created_at_from_now / 1.second).to_i}sec."
    elsif created_at_from_now < 1.hour
      "#{(created_at_from_now / 1.minute).to_i}min."
    elsif created_at_from_now < 1.day
      "#{(created_at_from_now / 1.hour).to_i}h."
    else
      "#{(created_at_from_now / 1.day).to_i}j."
    end
  end
end
