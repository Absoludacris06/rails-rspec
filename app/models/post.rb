class Post < ActiveRecord::Base
  attr_accessible :title, :content, :is_published

  scope :recent, order: "created_at DESC", limit: 5

  before_save :titleize_title, :slugify_slug

  validates_presence_of :title, :content

  private

  def titleize_title
    self.title = title.titleize
  end

  def slugify_slug #refactor this! ugly!
    if self.title.match(/[!.,?*@#\$\^]/)
      self.slug = title.downcase.gsub!(/[!.,?*@#\$\^]+/, '').split(' ').join('-')
    else
      self.slug = title.downcase.split(' ').join('-')
    end
  end

end
