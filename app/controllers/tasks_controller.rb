class TasksController < ApplicationController
  before_action :correct_user, only: [:show, :edit,:destroy]
  
  def index
   @tasks = Task.all.page(params[:page]).per(10)
  end

  def show
    @task = Task.find(params[:id])
  end

  def new
    @task = Task.new
  end

  def create
    @task = current_user.tasks.build(tasklist_params)
    if @task.save
      flash[:success] = 'タスク が正常に追加されました'
      redirect_to @task
    else
      @task = current_user.tasks.order(id: :desc).take(params[:page])
      flash.now[:danger] = 'タスク が作成されませんでした'
      render :new
    end
  end

  def edit
    @task = Task.find(params[:id])
  end

  def update
    @task = Task.find(params[:id])

    if @task.update(tasklist_params)
      flash[:success] = 'タスク は正常に更新されました'
      redirect_to @task
    else
      flash.now[:danger] = 'タスク は更新されませんでした'
      render :edit
    end
    
  end

  def destroy
    @task = Task.find(params[:id])
    @task.destroy

    flash[:success] = 'タスク は正常に削除されました'
    redirect_to tasks_url
  
  end
  
  
  private
  
 
  def tasklist_params
    params.require(:task).permit(:content, :status, :user)
  end
  
  def correct_user
    @task = current_user.tasks.find_by(id: params[:id])
    unless @task
      redirect_to root_url
    end
  end
  
 

end

  
