class ContactsController < ApplicationController
  respond_to :json

  def create
    respond_with Contact.create(model_params)
  end

  def update
    respond_with Contact.update(params[:id], model_params)
  end

  def destroy
    respond_with Contact.destroy(params[:id])
  end

  private

  def model_params
    params.require(:contact).permit(:name, :phone)
  end
end
