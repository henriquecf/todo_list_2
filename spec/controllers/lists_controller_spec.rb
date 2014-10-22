require 'rails_helper'

# This spec was generated by rspec-rails when you ran the scaffold generator.
# It demonstrates how one might use RSpec to specify the controller code that
# was generated by Rails when you ran the scaffold generator.
#
# It assumes that the implementation code is generated by the rails scaffold
# generator.  If you are using any extension libraries to generate different
# controller code, this generated spec may or may not pass.
#
# It only uses APIs available in rails and/or rspec-rails.  There are a number
# of tools you can use to make these specs even more expressive, but we're
# sticking to rails and rspec-rails APIs to keep things simple and stable.
#
# Compared to earlier versions of this generator, there is very limited use of
# stubs and message expectations in this spec.  Stubs are only used when there
# is no simpler way to get a handle on the object needed for the example.
# Message expectations are only used when there is no simpler way to specify
# that an instance is receiving a specific message.

RSpec.describe ListsController, :type => :controller do

  def login_user(email)
    allow_message_expectations_on_nil
    user = User.create!(email: email, password: " test1234")
    allow(request.env['warden']).to receive(:authenticate!).and_return(user)
    allow(controller).to receive(:current_user) { user }
    return user
  end

  before :each do
    @user = login_user "test@example.com"
  end

  # This should return the minimal set of attributes required to create a valid
  # List. As you add validations to List, be sure to
  # adjust the attributes here as well.
  let(:valid_attributes) {
    {name: "List", is_private: true, user: @user}
  }

  let(:invalid_attributes) {
    {name: "", is_private: false}
  }

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # ListsController. Be sure to keep this updated too.
  let(:valid_session) { {} }

  describe "GET index" do
    it "assigns all lists as @lists" do
      list = List.create! valid_attributes
      list.is_private = false
      list.save
      get :index, {user_id: @user.id}, valid_session
      expect(assigns(:lists)).to eq([list])
    end

    it "should not assign private lists if the user is not the owner" do
      List.create! valid_attributes
      public_list = List.create!({name: "public list", is_private: false, user: @user})
      login_user "another@example.com"
      get :index, {user_id: @user.id}, valid_session
      expect(assigns(:lists)).to eq([public_list])
    end
  end

  describe "GET show" do
    it "assigns the requested list as @list" do
      list = List.create! valid_attributes
      get :show, {:id => list.to_param, user_id: @user.id}, valid_session
      expect(assigns(:list)).to eq(list)
    end

    it "should not be visible to another user" do
      list = List.create! valid_attributes
      user = login_user "another@example.com"
      get :show, {:id => list.to_param}, valid_session
      expect(response).to redirect_to(user_lists_path(user))
    end

    it "should assign favorited as false by default" do
      list = List.create! valid_attributes
      get :show, {:id => list.to_param}, valid_session
      expect(assigns(:favorited)).to be_falsey
    end

    it "should assign favorited as true when it was marked" do
      list = List.create! valid_attributes
      fav = list.favorites.find_or_create_by(user: @user)
      fav.mark
      fav.save!
      get :show, {id: list.to_param}, valid_session
      expect(assigns(:favorited)).to be_truthy
    end
  end

  describe "GET new" do
    it "assigns a new list as @list" do
      get :new, {}, valid_session
      expect(assigns(:list)).to be_a_new(List)
    end

    it "assigns a new task in @list.tasks" do
      get :new, {}, valid_session
      expect(assigns(:list).tasks.first).to be_a_new(Task)
    end
  end

  describe "GET edit" do
    it "assigns the requested list as @list" do
      list = List.create! valid_attributes
      get :edit, {:id => list.to_param}, valid_session
      expect(assigns(:list)).to eq(list)
    end

    it "should not allow edition by another user" do
      list = List.create! valid_attributes
      user = login_user 'another@example.com'
      get :edit, {:id => list.to_param}, valid_session
      expect(response).to redirect_to(user_lists_path(user))
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new List" do
        expect {
          post :create, {:list => valid_attributes}, valid_session
        }.to change(List, :count).by(1)
      end

      it "assigns a newly created list as @list" do
        post :create, {:list => valid_attributes}, valid_session
        expect(assigns(:list)).to be_a(List)
        expect(assigns(:list)).to be_persisted
      end

      it "redirects to the created list" do
        post :create, {:list => valid_attributes}, valid_session
        expect(response).to redirect_to(List.last)
      end

      it "assigns list to current user" do
        post :create, {:list => valid_attributes}, valid_session
        expect(assigns(:list).user).to eq(@user)
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved list as @list" do
        post :create, {:list => invalid_attributes}, valid_session
        expect(assigns(:list)).to be_a_new(List)
      end

      it "re-renders the 'new' template" do
        post :create, {:list => invalid_attributes}, valid_session
        expect(response).to render_template("new")
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      let(:new_attributes) {
        {name: "Updated list", is_private: false}
      }

      it "updates the requested list" do
        list = List.create! valid_attributes
        put :update, {:id => list.to_param, :list => new_attributes}, valid_session
        list.reload
        expect(assigns(:list)).to eq(list)
      end

      it "assigns the requested list as @list" do
        list = List.create! valid_attributes
        put :update, {:id => list.to_param, :list => valid_attributes}, valid_session
        expect(assigns(:list)).to eq(list)
      end

      it "redirects to the list" do
        list = List.create! valid_attributes
        put :update, {:id => list.to_param, :list => valid_attributes}, valid_session
        expect(response).to redirect_to(list)
      end

      it "should not let another user update" do
        list = List.create! valid_attributes
        user = login_user 'another@example.com'
        put :update, {:id => list.to_param, :list => valid_attributes}, valid_session
        expect(response).to redirect_to(user_lists_path(user))
      end
    end

    describe "with invalid params" do
      it "assigns the list as @list" do
        list = List.create! valid_attributes
        put :update, {:id => list.to_param, :list => invalid_attributes}, valid_session
        expect(assigns(:list)).to eq(list)
      end

      it "re-renders the 'edit' template" do
        list = List.create! valid_attributes
        put :update, {:id => list.to_param, :list => invalid_attributes}, valid_session
        expect(response).to render_template("edit")
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested list" do
      list = List.create! valid_attributes
      expect {
        delete :destroy, {:id => list.to_param}, valid_session
      }.to change(List, :count).by(-1)
    end

    it "redirects to the lists list" do
      list = List.create! valid_attributes
      delete :destroy, {:id => list.to_param}, valid_session
      expect(response).to redirect_to(user_lists_path(@user))
    end

    it "should not let another user delete" do
      list = List.create! valid_attributes
      user = login_user 'another@example.com'
      delete :destroy, {:id => list.to_param}, valid_session
      expect(response).to redirect_to(user_lists_path(user))
    end
  end

  describe "GET mark_as_favorite" do
    before :each do
      @list = List.create! valid_attributes
    end
    it "should assign list to user favorites" do
      get :mark_as_favorite, id: @list.id
      expect(@user.favorites).to eq(@list.favorites)
    end
    it "should redirect back to the list" do
      get :mark_as_favorite, id: @list.id
      expect(response).to redirect_to(list_path(@list))
    end
  end

  describe "GET favorites" do
    before :each do
      @list = List.create! valid_attributes
      @list2 = List.create! valid_attributes
      @list3 = List.create! valid_attributes
    end

    it "should retrive my favorites" do
      fav = @list.favorites.find_or_create_by(user: @user)
      fav.mark
      get :favorites, {}, valid_session
      expect(assigns(:lists)).to eq([@list])
    end

    it "should not retrieve lists that are not marked" do
      @list.favorites.find_or_create_by(user: @user)
      get :favorites, {}, valid_session
      expect(assigns(:lists)).to eq([])
    end

    it "should not retrieve lists from other users" do
      fav = @list.favorites.find_or_create_by(user: @user)
      fav.mark
      user = login_user 'other@example.com'
      fav2 = @list2.favorites.find_or_create_by(user: user)
      fav2.mark
      get :favorites, {}, valid_session
      expect(assigns(:lists)).to eq([@list2])
    end
  end

  describe "GET public" do
    it "should assign public lists to @lists" do
      List.create! valid_attributes
      list2 = List.create! valid_attributes
      List.create! valid_attributes
      list2.is_private = false
      list2.save
      get :public, {}, valid_session
      expect(assigns(:lists)).to eq([list2])
    end
  end
end
