class Otp < ApplicationRecord

  # {
  #   "verification": {
  #       "code": "3538"
  #   }
  # }
  # https://sms.miaowu.org/sms_verifier/<sid>
  # 
  # 
  # Res
  # {
  #   "status": true,
  #   "sid": "SM75557c07e2cc4a83b28c3692d9af474a"
  # }
  def self.verify_by sid, code
    res = HTTParty.put("https://sms.miaowu.org/sms_verifier/#{sid}", body: {"verification" => { "code" => code }})
    sid_in_res = JSON.parse(res.body).dig("sid") rescue nil 
    sid_in_res && sid == sid_in_res
  end

  # https://sms.miaowu.org/sms_verifier
  # {
  #   "verification": {
  #       "phone_number": "18780186992",
  #       "country_code": "cn"
  #   }
  # }
  # 
  # 
  # Res
  # {
  #   "sid": "SM75557c07e2cc4a83b28c3692d9af474a"
  # }
      
  def self.trigger_sms_and_return_sid phone_number
    data = { "verification" => {'phone_number' => phone_number, "country_code" => 'cn'} }
    HTTParty.post("https://sms.miaowu.org/sms_verifier", body: data).dig("sid") if phone_number.present?
  end

end
