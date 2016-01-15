require "rails_helper"

RSpec.describe VoteMailerJob do
  let(:voter) { double("Voter", name: "Mr Voter") }
  let(:movie) { double("Movie", user: fake_user, title: "Grease") }
  let(:fake_mail) { double("Mail", deliver: nil) }
  let(:fake_user) { double("User", name: "Mr Fake", email: "fake@user.com") }

  context "Type is :like" do
    it "Calls VoteMailer.like_email" do
      allow(VoteMailer).to receive(:like_email) { fake_mail }
      expect(VoteMailer).to receive(:like_email).once
      subject.perform(:like, voter, movie)
    end

    it "Sends the email" do
      expect {
        subject.perform(:like, voter, movie)
      }.to change { ActionMailer::Base.deliveries.count }.by(1)
    end
  end

  context "Type is :hate" do
    it "Calls VoteMailer.hate_email" do
      allow(VoteMailer).to receive(:hate_email) { fake_mail }
      expect(VoteMailer).to receive(:hate_email).once
      subject.perform(:hate, voter, movie)
    end

    it "Sends the email" do
      expect {
        subject.perform(:hate, voter, movie)
      }.to change { ActionMailer::Base.deliveries.count }.by(1)
    end
  end

  context "Type is wrong" do
    it "Raises error" do
      expect{
        subject.perform(:bobbins, voter, movie)
      }.to raise_error("VoteMailer.perform: type must be one of :like, :hate")
    end
  end
end
