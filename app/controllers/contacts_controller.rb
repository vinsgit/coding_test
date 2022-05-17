class ContactsController < ApplicationController
    skip_before_action :verify_authenticity_token
    def create
        result = Otp.verify_by(params[:sid], params[:verification_code])
        @res = if result
                  record = Person.create(permitted_contacts_params)
                  record.present?
               else
                  false
               end
        render plain: "Success"
    end

    def new
        @contact = Person.new
    end

    private
    def permitted_contacts_params
        params.require(:person).permit(*%w{name phone_number email available_on})
    end
end
