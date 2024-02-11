class TasksController < ApplicationController
  before_action :set_task, only: %i[ show edit update destroy assign_user add_child]

  # GET /tasks or /tasks.json
  def index
    @tasks = Task.all
  end

  # GET /tasks/1 or /tasks/1.json
  def show
  end

  # GET /tasks/new
  def new
    @task = Task.new
  end

  # GET /tasks/1/edit
  def edit
  end

  # POST /tasks or /tasks.json
  def create
    @task = Task.new(task_params)

    respond_to do |format|
      if @task.save
        format.html { redirect_to task_url(@task), notice: "Task was successfully created." }
        format.json { render :show, status: :created, location: @task }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /tasks/1 or /tasks/1.json
  def update
    respond_to do |format|
      if @task.update(task_params)
        format.html { redirect_to task_url(@task), notice: "Task was successfully updated." }
        format.json { render :show, status: :ok, location: @task }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tasks/1 or /tasks/1.json
  def destroy
    @task.destroy!

    respond_to do |format|
      format.html { redirect_to tasks_url, notice: "Task was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def assign_user
    @user = User.find(params[:user_id])
    @task.user = @user
    if @task.save
      redirect_to @task, notice: 'User was successfully assigned.'
    else
      redirect_to @task, alert: 'There was an error assigning the user.'
    end
  end

  def add_child
    child_task = @task.children.new(task_params)
    child_task.project = @task.project
    if child_task.save
      render json: { status: 'success', message: 'Child task was successfully added.' }
    else
      render json: { status: 'error', message: 'There was a problem adding the child task.', errors: child_task.errors }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_task
      @task = Task.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def task_params
      params.require(:task).permit(:name, :description, :project_id, :user_id)
    end
end
