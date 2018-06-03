require 'test_helper'

class PictureMailerTest < ActionMailer::TestCase
  test "send_new_picture" do
    mail = PictureMailer.send_new_picture
    assert_equal "Send new picture", mail.subject
    assert_equal ["to@example.org"], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end

end
