require 'rails_helper'

RSpec.feature 'User Integration', type: :feature do
  let!(:user) { create(:user) }

  scenario 'User index page' do
    visit users_path

    expect(page).to have_content(user.name)
    expect(page).to have_selector("img.img-thumbnail")
    expect(page).to have_content("Number of posts: #{user.posts_counter}")

    click_link user.name
    expect(current_path).to eq(user_path(user))
  end

  scenario 'User show page' do
    visit user_path(user)

    expect(page).to have_selector("img.img-thumbnail")
    expect(page).to have_content(user.name)
    expect(page).to have_content("Number of posts: #{user.posts_counter}")
    expect(page).to have_content(user.bio)

    if user.posts.any?
      user.posts.limit(3).each do |post|
        expect(page).to have_content(post.title)
      end

      expect(page).to have_link('See all Posts', href: user_posts_path(user))
      click_link user.posts.first.title
      expect(current_path).to eq(user_post_path(user, user.posts.first))
    # else
    #   # Handle the case when the user has no posts
    #   # For example, you can add an expectation or a message indicating that there are no posts.
    #   expect(page).to have_text("This user has no posts.")
    end
  end
  
end
