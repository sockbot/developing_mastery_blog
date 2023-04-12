class PasswordResetTokensController < ApplicationController
    
  skip_before_action :authenticate!, only: [:new, :create]

  def new
  end

  def create
    user = User.find_by_email(params[:email])
    user.regenerate_password_reset_token
    if user.save
      flash[:notice] = "New password reset token created."
      send_password_reset_email(user)
      redirect_to login_path
    else
      flash[:alert] = "Couldn't regenerate password reset token. Try again"
      render :new, status: :unprocessable_entity
    end
  end

  private

  def send_password_reset_email(user)
    client = Aws::SES::Client.new(
      region: "us-west-2", 
      access_key_id: Rails.application.credentials[:aws][:access_key_id], 
      secret_access_key: Rails.application.credentials[:aws][:secret_access_key]
    )
      
    begin
      client.send_email(
        destination: {
          to_addresses: [user.email]
        },
        message: {
          body: {
            text: {
              data: "Your password reset token is #{user.password_reset_token}"
            }
          },
          subject: {
            data: "DM Blog - Reset your password"
          }
        },
        source: "dmblog@sockbot.com",
      )
      puts "Email sent to #{user.email}"
    rescue Aws::SES::Errors::ServiceError => error
      puts "Email not sent. Error message: #{error}"
    end  
  end
end