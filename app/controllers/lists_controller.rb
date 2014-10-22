class ListsController < ApplicationController
  before_action :set_list, only: [:show, :edit, :update, :destroy, :mark_as_favorite]
  before_action :limit_private_lists, only: [:show, :edit, :update, :destroy]
  before_action :set_favorite, only: [:show, :mark_as_favorite]

  def index
    user = User.find(params[:user_id])
    condition = {user: user}
    unless user == current_user
      condition.merge!({is_private: false})
    end
    @lists = List.where(condition)
    respond_with(@lists)
  end

  def favorites
    @title = 'Favorites'
    @lists = current_user.favorites.where(marked: true).collect { |fav| fav.list }
    render 'lists'
  end

  def show
    @favorited = @favorite.marked
    respond_with(@list)
  end

  def new
    @list = List.new
    @list.tasks.build
    respond_with(@list)
  end

  def edit
  end

  def create
    @list = List.new(list_params)
    @list.user = current_user
    @list.save
    respond_with(@list)
  end

  def update
    @list.update(list_params)
    respond_with(@list)
  end

  def destroy
    @list.destroy

    respond_to do |format|
      format.html { redirect_to user_lists_path(current_user), notice: 'List was successfully destroyed.' }
    end
  end

  def mark_as_favorite
    @favorite.mark
    message = @favorite.marked ? 'Marked as favorite' : 'Removed from favorites'
    redirect_to @list, notice: message
  end

  protected

    def limit_private_lists
      unless current_user == @list.user
        if @list.is_private
          redirect_to user_lists_path(current_user), alert: "Unauthorized access"
          false
        end
      end
    end

  private
    def set_list
      @list = List.find(params[:id])
    end

    def list_params
      params.require(:list).permit(:name, :is_private, tasks_attributes: [:id, :task_name, :done, :_destroy])
    end

    def set_favorite
      @favorite = @list.favorites.find_or_create_by(user: current_user)
    end
end
