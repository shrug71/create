class CafeInvitationMailer < ApplicationMailer
	def send_invitation(cafe_owner, random_password)
    @cafe = cafe_owner.email
    @random_password = random_password
    mail(to: @cafe, subject: "Your OTP is :") do |format|
    	format.html{render "activation_email"}
  	end
  end


end
