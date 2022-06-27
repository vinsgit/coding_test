class ContactsController < ApplicationController
  include Pagy::Backend

  skip_before_action :verify_authenticity_token
  
  def index
      @pagy, @contacts = pagy(Contact.all)
  end

  def create
    result = Otp.verify_by(params[:sid], params[:verification_code])
    @res =
      if result
        record = Contact.create(permitted_contacts_params)
        record.present?
      else
        false
      end
    render plain: @res ? "Success" : "Error"
  end

  def new
      @contact = Contact.new
  end

  def search
      contacts = Contact.search_by_fuzzy_name(params[:name])
      render json: contacts
  end

  private

  def permitted_contacts_params
      params.require(:contact).permit(*%w{name phone_number email available_on role})
  end
end
