# Preview all emails at http://localhost:3000/rails/mailers/picture_mailer
class PictureMailerPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/picture_mailer/send_new_picture
  def send_new_picture
    PictureMailer.send_new_picture
  end

end
