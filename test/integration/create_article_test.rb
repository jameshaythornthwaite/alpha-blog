require 'test_helper'

class CreateArticleTest < ActionDispatch::IntegrationTest
  def setup
    @user = User.create(username: "John", email: "john@exmaple.com", password: "password", admin: false)
    @useradmin = User.create(username: "John", email: "john@exmaple.com", password: "password", admin: false)
    @category = Category.create(name: "Sports")
  end

  test "create new article" do
    sign_in_as(@user,"password")
    get new_article_path
    assert_template "articles/new"
    assert_difference "Article.count", 1 do
      post_via_redirect articles_path, article: { title: "Test Article", description: "Test Article long description", category_ids: ["1", ""]}
    end
    assert_template "articles/show"
    assert_match "Test Article", response.body
  end
end
