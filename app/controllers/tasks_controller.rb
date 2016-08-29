class TasksController < ApplicationController
  include Authenticable
  before_action :set_task, except: [:index, :create]
  before_action :authenticate_with_token

  def index
    @tasks = Task.all
    render json: @tasks
  end

  def show
    render json: @task
  end

  def create
    @task = Task.new(task_params)
    @task.users << @current_user

    if @task.save
      render json: @task, status: :created, location: @task
    else
      render json: @task.errors, status: :unprocessable_entity
    end
  end

  def assign_task
    render json: {status: 400, error: "User not found"}, status: 400 and return unless User.exists?(params[:user_id])

    @user = User.find_by(id: params[:user_id])
    @task.users << @user 

    if @task.save
      render json: @task, status: :created, location: @task
    else
      render json: @task.errors, status: :unprocessable_entity
    end
  end

  def unassign_task
    render json: {status: 400, error: "User not found"}, status: 400 and return unless User.exists?(params[:user_id])

    @user = User.find_by(id: params[:user_id])
    @task.users.delete(@user)

    if @task.save
      render json: @task, status: :created, location: @task
    else
      render json: @task.errors, status: :unprocessable_entity
    end
  end

  def update
    if @task.update(task_params)
      render json: @task
    else
      render json: @task.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @task.destroy
  end

  private
    def set_task
      @task = Task.find(params[:id])
    end

    def task_params
      params.fetch(:task, {}).permit(:user_id, :title, :description)
    end
end
