class BusinessSettingsController < ApplicationController
  def edit
    @business = current_business
  end

  def update
    @business = current_business
    if @business.update(business_params)
      redirect_to invoices_path, notice: "Business settings updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def business_params
    params.require(:business_setting).permit(
      :name, :tagline, :address, :registration_number,
      :registration_label, :phone, :email, :currency,
      :payment_terms_days, :footer_note
    )
  end
end
