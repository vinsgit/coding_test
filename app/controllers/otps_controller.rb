class OtpsController < ApplicationController
  skip_before_action :verify_authenticity_token

  def request_otp
    sid = Otp.trigger_sms_and_return_sid params.dig(:verification, :phone_number)
    if sid
      render json: { status: true, sid: sid}
    else
      render json: { status: false, msg: "Empty SID returned"}
    end
  end
end
