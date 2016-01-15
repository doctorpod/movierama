require 'rails_helper'

RSpec.describe "vote_mailer/like_email.html.haml", :type => :view do
  let(:fake_user) { double("User", name: "Jon Jaws") }

  it "Displays correct message" do
    assign(:movie, double("Movie", user: fake_user, title: "Jaws"))
    assign(:voter, double("Voter", name: "Jaws Liker"))

    render

    expect(response.body).to match /Dear\nJon Jaws/m
    expect(response.body).to match /Jaws Liker\nlikes your movie:\nJaws/
  end
end
