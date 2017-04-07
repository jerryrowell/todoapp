require 'test_helper'

class TodosTest < ActionDispatch::IntegrationTest
  
  def setup
    @user = User.create!(name: "jerry", email: "jerry@example.com")
    @todo = Todo.create(name: "Lunch", description: "I will eat lunch out", user: @user)
    @todo2 = Todo.create(name: "Dinner", description: "I will eat dinner in", user: @user)
  end
  
  test "should get todos index" do
    get todos_path
    assert_response :success
  end
  
  test "should get todos listing" do
    get todos_path
    assert_template 'todos/index'
    assert_select "a[href=?]", todo_path(@todo), text: @todo.name
    assert_select "a[href=?]", todo_path(@todo2), text: @todo2.name
  end
  
  test "should get todo show" do
    get todo_path(@todo)
    assert_template'todos/show'
    assert_match @todo.name, response.body
    assert_match @todo.description, response.body
    
    assert_select 'a[href=?]', edit_todo_path(@todo), text: "Edit this todo"
    assert_select 'a[href=?]', todo_path(@todo), text: "Delete this todo"
    assert_select 'a[href=?]', todos_path, text: "Back to todo listing"
  end
  
  test "create new valid todo" do 
    get new_todo_path
    assert_template 'todos/new'
    name_of_todo="Breakfast"
    description_of_todo= "I had eggs"
    assert_difference 'Todo.count', 1 do
      post todos_path, params:{todo: {name: name_of_todo, description: description_of_todo}}
    end
    follow_redirect!
    assert_match name_of_todo.capitalize, response.body
    assert_match description_of_todo, response.body
  end
  
  test "reject invalid todo submission" do
    get new_todo_path
    assert_template 'todos/new'
    assert_no_difference 'Todo.count' do
      post todos_path, params:{todo: {name: " ", description: " "}}
    end
    assert_template 'todos/new'
    assert_select 'h2.panel-title'
    assert_select 'div.panel-body'
  end
  
end
