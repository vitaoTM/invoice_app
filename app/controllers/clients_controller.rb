class ClientsController < ApplicationController
  before_action :set_client, only: %i[show edit update destroy]

  def index
    @clients = Current.user.clients.ordered.search(params[:q])
  end

  def show
    @invoices = @client.invoices.recent_first
  end

  def new
    @client = Current.user.clients.build
  end

  def create
    @client = Current.user.clients.build(client_params)

    if @client.save
      respond_to do |format|
        format.html { redirect_to clients_path, notice: "Client created." }
        format.turbo_stream { flash.now[:notice] = "Client created." }
      end

    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit; end

  def update
    if @client.update(client_params)
      redirect_to clients_path, notice: "Client updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    respond_to do |format|
      if @client.destroy
        format.html { redirect_to clients_path, notice: "Client deleted." }
        format.turbo_stream { flash.now[:notice] = "Client deleted." }
      else
        format.html { redirect_to clients_path, alert: "Cannot delete a client that has invoices." }
        format.turbo_stream { flash.now[:alert] = "Cannot delete a client that has invoices." }
      end
    end
  end

  private

  def set_client
    @client = Current.user.clients.find(params[:id])
  end

  def client_params
    params.require(:client).permit(:name, :country, :phone, :email, :notes)
  end
end
