class SeiProcessesController < ApplicationController
  before_action :set_sei_process, only: [:show, :edit, :update, :destroy]

  ##
  # Ação index da classe SeiProcess.
  # Renderiza a view index, que exibe os processos e solicitações criados (dependente do usuário que está logado).
  # GET /sei_processes
  def index
    # Filtra solicitações baseadas nos estados marcados como visíveis
    @all_statuses = SeiProcess.all_statuses
    session[:statuses] = params[:statuses] || session[:statuses] || @all_statuses.zip([]).to_h
    @status_filter = session[:statuses].keys
    
    # Lista todas as solicitações de credenciamento para um administrador
    if current_user.role == "administrator"
      @sei_processes = SeiProcess.where(status: @status_filter)
    # Lista as solicitações próprias para um professor
    else
      @my_processes = SeiProcess.where(user_id: current_user.id, status: @status_filter)
    end
  end

  ##
  # Ação show da classe SeiProcess. Mostra detalhes de um registro criado.
  # GET /sei_processes/1
  def show
  end

  ##
  # Ação new da classe SeiProcess. Renderiza página para criação de um registro.
  # Recebe também o registro Requisitos de Credenciamento para exibição na view new.
  # GET /sei_processes/new
  def new
    # Renderiza Requisitos de Credenciamento, caso existam, na página de criação de processo ou de abrir solicitação de credenciamento
    @requirements = Requirement.find_by(title: 'Requisitos de Credenciamento')
    @sei_process = SeiProcess.new
  end

  ##
  # Ação edit da classe SeiProcess. Renderiza página para atualizar um registro.
  # GET /sei_processes/1/edit
  def edit
  end

  ##
  # Método responsável por criar um registro com os dados inseridos na view new.
  # Recebe os dados da view new e faz o tratamento para decidir se o registro é válido ou não.
  # Redireciona para a view index caso os dados sejam válidos.
  # POST /sei_processes
  def create
    # Faz correções de entradas inválidas baseando-se nos dados do usuário logado
    mandatory_params = {'user_id' => current_user.id, 'status' => 'Espera', 'code' => '0'}
    @sei_process = SeiProcess.new(sei_process_params.merge(mandatory_params))

    respond_to do |format|
      # Quando condições da model forem cumpridas, cria um novo registro no banco, redireciona para pagina index da tabela atual e mostra uma mensagem de sucesso 
      if @sei_process.save
        format.html { redirect_to sei_processes_url, notice: 'Processo aberto com sucesso!' }
      # Mostra uma mensagem de erro se condições da model não forem cumpridas
      else
        format.html { render :new }
      end
    end
  end

  ##
  # Método responsável por atualizar um registro com os dados inseridos na view edit.
  # Recebe os dados da view edit e faz o tratamento dos dados modificados pelo usuário.
  # Caso os dados sejam válidos, o registro é atualizado no banco e um novo registro de Accreditation correspondente é criado e o usuário é redirecionado para a view index.
  # PATCH/PUT /sei_processes/1
  def update
    respond_to do |format|
      # Quando condições da model forem cumpridas, atualiza o registro no banco, redireciona para pagina index da tabela atual e mostra uma mensagem de sucesso 
      if @sei_process.update(sei_process_params)
        format.html { redirect_to sei_processes_url, notice: 'Processo atualizado com sucesso!' }

        # Cria o credenciamento correspondente aa solicitação aprovada
        if @sei_process.status == 'Aprovado' && (Accreditation.find_by(sei_process: @sei_process.id) == nil)
          Accreditation.create!(user_id: @sei_process.user_id, sei_process_id: @sei_process.id)
        end

      # Mostra uma mensagem de erro se condições da model não forem cumpridas
      else
        format.html { render :edit }
      end
    end
  end

  ##
  # Método responsável por excluir um registro salvo na tabela.
  # Redireciona para a view index.
  # DELETE /sei_processes/1
  def destroy
    respond_to do |format|
      # Mensagem de sucesso ao excluir processo ou solicitação quando condições da model forem cumpridas
      if @sei_process.destroy
        format.html { redirect_to sei_processes_url, notice: 'Processo excluído com sucesso!' }
      # Mensagem de erro se condições da model não forem cumpridas
      else
        format.html { redirect_to sei_processes_url, notice: 'Erro: não foi possível excluir o processo!' }
      end
    end
  end

  private
    # Define parametros de Processo
    def set_sei_process
      @sei_process = SeiProcess.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def sei_process_params
      params.require(:sei_process).permit(:user_id, :status, :code, documents: [])
    end
end
