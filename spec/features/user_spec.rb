require 'spec_helper'

feature 'User browsing the website' do
  let!(:new_post) { Post.create(title: "Test Title", content: "I'm a dumb post.") }
  context "on homepage" do
    it "sees a list of recent posts titles" do
      visit "/"
      page.should include{ Post.all.each { |post| post.title } }
    end

    it "can click on titles of recent posts and should be on the post show page" do
      visit "/"
      click_link new_post.title
      expect(page.current_path).to eq(post_path(new_post))
    end
  end

  context "post show page" do
    it "sees title and body of the post" do
      visit "/"
      click_link new_post.title
      page.should have_content new_post.title
      page.should have_content new_post.content
    end
  end
end
