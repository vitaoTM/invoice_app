class ClientsController < ApplicationController
  before_action :set_client, only: %i[show edit update destroy]

  def index
    @clients = Client.order(:name)
  end

  def show
    @invoices = @client.invoices.recent_first
  end

  def new
    @client = Client.new
  end

  def create
    @client = Client.new(client_params)

    if @client.save
      redirect_to clients_path, notice: "Client created."
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
    if @client.destroy
      redirect_to clients_path, notice: "Client deleted."
    else
      redirect_to clients_path, alert: "Cannot delete client with invoices."
    end
  end

  private

  def set_client
    @client = Client.find(params[:id])
  end

  def client_params
    params.require(:client).permit(:name, :country, :phone, :email, :notes)
  end
end
