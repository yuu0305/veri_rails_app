# app/controllers/tasks_controller.rb
class TasksController < ApplicationController
  def index
    @tasks = Task.by_priority
    @task = Task.new
  end

  def create
    @task = Task.new(task_params)

    respond_to do |format|
      if @task.save
        format.json { 
          render json: { 
            status: 'success',
            task: render_to_string(partial: 'task', locals: { task: @task }, formats: [:html]),
            message: 'Task was successfully created.'
          }
        }
      else
        format.json { 
          render json: { 
            status: 'error',
            errors: @task.errors.full_messages
          }, status: :unprocessable_entity 
        }
      end
    end
  end


  def update
    @task = Task.find(params[:id])
    
    respond_to do |format|
      if @task.update(task_params)
        format.json { 
          render json: {
            status: 'success',
            task: render_to_string(partial: 'task', locals: { task: @task }, formats: [:html]),
            message: 'Task was successfully updated.'
          }
        }
      else
        format.json { 
          render json: { 
            status: 'error',
            errors: @task.errors.full_messages 
          }, status: :unprocessable_entity 
        }
      end
    end
  end

  private

  def task_params
    params.require(:task).permit(:title, :description, :status, :priority)
  end
end
