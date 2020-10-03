class TasksController < ApplicationController
  
  def index
    @tasklists =  Task.all
  end

  def show
    @tasklist = Task.find(params[:id])
  end

  def new
    @tasklist = Task.new
  end

  def create
    @tasklist = Task.new(tasklist_params)

    if @tasklist.save
      flash[:success] = 'タスク が正常に投稿されました'
      redirect_to @tasklist
    else
      flash.now[:danger] = 'タスク が投稿されませんでした'
      render :new
    end
  end

  def edit
    @tasklist = Task.find(params[:id])
  end

  def update
    @tasklist = Task.find(params[:id])

    if @tasklist.update(tasklist_params)
      flash[:success] = 'タスク は正常に更新されました'
      redirect_to @tasklist
    else
      flash.now[:danger] = 'タスク は更新されませんでした'
      render :edit
    end
    
  end

  def destroy
    @tasklist = Task.find(params[:id])
    @tasklist.destroy

    flash[:success] = 'タスク は正常に削除されました'
    redirect_to tasks_url
  end
end


  private

  # Strong Parameter
  def tasklist_params
    params.require(:task).permit(:content)
  end