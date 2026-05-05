class InvoicesController < ApplicationController
  before_action :set_invoice, only: %i[show edit update destroy pdf]

  def index
    @invoices = Current.user.invoices
                       .includes(:client, :line_items)
                       .by_status(params[:status])
                       .search(params[:q])
                       .recent_first
  end

  def show
    @business = current_business
  end

  def new
    @invoice = Current.user.invoices.build(
      client_id: params[:client_id],
      invoice_date: Date.current,
      tax_label: "Aruba Health Tax/Fees",
      tax_amount: 0.0
    )
    @invoice.line_items.build
  end

  def create
    @invoice = Current.user.invoices.build(invoice_params)

    if @invoice.save
      redirect_to @invoice, notice: "Invoice created successfully."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @invoice.line_items.build if @invoice.line_items.empty?
  end

  def update
    if @invoice.update(invoice_params)
      redirect_to @invoice, notice: "Invoice updated successfully."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @invoice.destroy
    redirect_to invoices_path, notice: "Invoice deleted."
  end

  # PDF export — renders the invoice HTML template through headless Chrome
  def pdf
    @business = current_business

    # 1. Render the invoice as a full HTML string (using the PDF layout)
    html = render_to_string(
      template: "invoices/pdf",
      layout: "pdf",
      locals: { invoice: @invoice, business: @business }
    )

    # 2. Pass the HTML to Grover, which opens headless Chrome,
    #    loads the HTML, and prints it to PDF
    pdf = Grover.new(html, format: "A4", print_background: true).to_pdf

    # 3. Send the PDF bytes as a response
    send_data pdf,
      filename: "#{@invoice.invoice_number}.pdf",
      type: "application/pdf",
      disposition: "inline"  # opens in browser; use "attachment" to force download
  end

  private

  def set_invoice
    @invoice = Current.user.invoices.includes(:client, :line_items).find(params[:id])
  end

  # Strong params — note line_items_attributes with :id and :_destroy
  # for nested attribute support
  def invoice_params
    params.require(:invoice).permit(
      :client_id, :invoice_date, :status,
      :event_type, :event_location, :event_date,
      :schedule_notes, :tax_label, :tax_amount,
      line_items_attributes: %i[id description quantity unit_price position _destroy]
    )
  end
end
