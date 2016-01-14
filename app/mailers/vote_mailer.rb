class VoteMailer < ActionMailer::Base
  def like_email(voter, movie)
    @voter = voter
    @movie = movie
    mail(to: @movie.user.email, subject: "Someone likes your movie")
  end

  def hate_email(voter, movie)
    @voter = voter
    @movie = movie
    mail(to: @movie.user.email, subject: "Someone hates your movie")
  end
end
