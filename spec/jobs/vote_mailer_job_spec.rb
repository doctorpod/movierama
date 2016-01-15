require "rails_helper"

RSpec.describe VoteMailerJob do
  let(:voter) { double("Voter") }
  let(:movie) { double("Movie") }
  let(:fake_mail) { double("FakeMail", deliver: nil) }

  context "Type is :like" do
    before do
      allow(VoteMailer).to receive(:like_email) { fake_mail }
    end

    it "Calls VoteMailer.like_email" do
      expect(VoteMailer).to receive(:like_email).once
      subject.perform(:like, voter, movie)
    end
  end

  context "Type is :hate" do
    before do
      allow(VoteMailer).to receive(:hate_email) { fake_mail }
    end

    it "Calls VoteMailer.hate_email" do
      expect(VoteMailer).to receive(:hate_email).once
      subject.perform(:hate, voter, movie)
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
