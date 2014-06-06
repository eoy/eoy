class Post < ActiveRecord::Base
  extend FriendlyId
  friendly_id :slug_candidates, use: :slugged
  validates_presence_of :title, :body

  belongs_to :user

  def slug_candidates
    [
      :title,
    ]
  end

  def content
    MarkdownService.new.render(body)
  end
end
