class Admin::ProgramsController < Admin::ApplicationController
  before_action :set_admin_program, only: [:show, :edit, :update, :destroy]

  # GET /admin/programs
  # GET /admin/programs.json
  def index
    @admin_programs = Program.all
  end

  # GET /admin/programs/1
  # GET /admin/programs/1.json
  def show
  end

  # GET /admin/programs/new
  def new
    @admin_program = Program.new
  end

  # GET /admin/programs/1/edit
  def edit
  end

  def create
    chm = CommandHistoryManager.get_instance()

    program = Program.new(admin_program_params)
    command = CreateProgramCommand.new(program)

    if CommandRunner.execute(command)
      chm.register_command(command)
      redirect_to [:admin, program], notice: 'Program was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /admin/programs/1
  def update
    if @admin_program.update(admin_program_params)
      redirect_to [:admin, @admin_program], notice: 'Program was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /admin/programs/1
  def destroy
    @admin_program.destroy
    redirect_to admin_programs_url, notice: 'Program was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_admin_program
      @admin_program = Program.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def admin_program_params
      params.require(:program).permit(:name)
    end
end