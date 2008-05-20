##
# ForumPostsController tests
# Author: Les Freeman (lesliefreeman3@gmail.com)
# Created on: 5/16/08
# Updated on: 5/16/08
#


require File.dirname(__FILE__) + '/../test_helper'

class ForumPostsControllerTest < ActionController::TestCase
  
  include ForumsTestHelper
  
  ##
  # :index
  
  should "not respond to index" do
    assert !ForumPostsController.new.respond_to?(:index)
  end
  
  ##
  # :show
  
  should "not respond to show" do
    assert !ForumPostsController.new.respond_to?(:show)
  end
  
  ##
  # :new
  
  should "not respond to new" do
    assert !ForumPostsController.new.respond_to?(:new)
  end
  
  ##
  # create

  should "not create a new forum post for guest" do
    assert_nothing_raised do
      assert_no_difference "ForumPost.count" do
        post :create, {:forum_id => forum_topics(:one).forum.id, 
                       :topic_id => forum_topics(:one).id,
                       :forum_post => valid_forum_post_attributes}
        assert_response 302
        assert_redirected_to :login_path
      end
    end
  end

  should "create a new forum post for :user" do
    assert_nothing_raised do
      assert_difference "ForumPost.count" do
        post :create, {:forum_id => forum_topics(:one).forum.id, 
                       :topic_id => forum_topics(:one).id,
                       :forum_post => valid_forum_post_attributes}, {:user => profiles(:user).id}
        assert_redirected_to :controller => 'forum_topics', :action => 'show', :id => forum_topics(:one).to_param
      end
    end
  end

  should "create a new forum post for :admin" do
    assert_nothing_raised do
      assert_difference "ForumPost.count" do
        post :create, {:forum_id => forum_topics(:one).forum.id, 
                       :topic_id => forum_topics(:one).id,
                       :forum_post => valid_forum_post_attributes}, {:user => profiles(:admin).id}
        assert_redirected_to :controller => 'forum_topics', :action => 'show', :id => forum_topics(:one).to_param
      end
    end
  end
  
  ##
  # :edit

  should "not get edit for guest" do
    assert_nothing_raised do
      get :edit, {:forum_id => forum_topics(:one).forum.id, 
                  :topic_id => forum_topics(:one).id,
                  :id => forum_topics(:one).id}
      assert_response 302
      assert_redirected_to :login_path
    end
  end

  should "not get edit for :user" do
    assert_nothing_raised do
      get :edit, {:forum_id => forum_topics(:one).forum.id, 
                  :topic_id => forum_topics(:one).id,
                  :id => forum_topics(:one).id}, {:user => profiles(:user).id}
      assert_response 302
      assert flash[:error]
    end
  end

  should "get edit for :admin" do
    assert_nothing_raised do
      get :edit, {:forum_id => forum_topics(:one).forum.id, 
                  :topic_id => forum_topics(:one).id,
                  :id => forum_topics(:one).id}, {:user => profiles(:admin).id}
      assert_response 200
      assert_template 'edit'
    end
  end
  
  ##
  # :update

  should "not update a forum post for guest" do
    assert_nothing_raised do
      put :update, {:forum_id => forum_posts(:one).topic.forum.id, 
                    :topic_id => forum_posts(:one).topic.id,
                    :id => forum_posts(:one).id,
                    :post => valid_forum_post_attributes}
      assert_response 302
      assert_redirected_to :login_path
    end
  end

  should "not update a forum post for :user" do
    assert_nothing_raised do
      put :update, {:forum_id => forum_posts(:one).topic.forum.id, 
                    :topic_id => forum_posts(:one).topic.id,
                    :id => forum_posts(:one).id,
                    :post => valid_forum_post_attributes}, {:user => profiles(:user).id}
      assert_response 302
      assert flash[:error]
    end
  end

  should "update a forum post for :admin" do
    assert_nothing_raised do
      put :update, {:forum_id => forum_posts(:one).topic.forum.id, 
                    :topic_id => forum_posts(:one).topic.id,
                    :id => forum_posts(:one).id,
                    :post => valid_forum_post_attributes}, {:user => profiles(:admin).id}
      assert_redirected_to :controller => 'forum_topics', :action => 'show', :id => forum_topics(:one).to_param
    end
  end
  
  ##
  # :destroy

  should "not destroy a forum post for guest" do
    assert_nothing_raised do
        assert_no_difference "ForumPost.count" do
        delete :destroy, {:forum_id => forum_posts(:one).topic.forum.id, 
                          :topic_id => forum_posts(:one).topic.id,
                          :id => forum_posts(:one).id}
        assert_response 302
        assert_redirected_to :login_path
      end
    end
  end

  should "not destroy a forum post for :user" do
    assert_nothing_raised do
      assert_no_difference "ForumPost.count" do
        delete :destroy, {:forum_id => forum_posts(:one).topic.forum.id, 
                          :topic_id => forum_posts(:one).topic.id,
                          :id => forum_posts(:one).id}, {:user => profiles(:user).id}
        assert_response 302
        assert flash[:error]
      end
    end
  end

  should "destroy a forum post for :admin" do
    assert_nothing_raised do
      assert_difference "ForumPost.count", -1 do
        delete :destroy, {:forum_id => forum_posts(:one).topic.forum.id, 
                          :topic_id => forum_posts(:one).topic.id,
                          :id => forum_posts(:one).id}, {:user => profiles(:admin).id}
        assert_redirected_to :controller => 'forum_topics', :action => 'show', :id => forum_posts(:one).topic.to_param
      end
    end
  end
  
end
