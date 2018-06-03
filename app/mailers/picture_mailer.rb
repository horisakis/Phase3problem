class PictureMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.picture_mailer.send_new_picture.subject
  #
  def send_new_picture(picture)
    @picture = picture

    mail to: "to@example.org", subject: "画像が投稿されれました"
  end
end
