class TestJob
  include Sidekiq::Job

  def perform(*args)
    Book.create(title: Faker::Book.title, author: Faker::Book.author, description: Faker::Quote.fortune_cookie, user_id: 2)
  end
end
