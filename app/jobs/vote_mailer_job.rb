class VoteMailerJob
  include SuckerPunch::Job

  def perform(type, voter, movie)
    case type
    when :like then VoteMailer.like_email(voter, movie).deliver
    when :hate then VoteMailer.hate_email(voter, movie).deliver
    else raise "VoteMailer.perform: type must be one of :like, :hate"
    end
  end
end
