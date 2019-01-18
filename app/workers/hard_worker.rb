class HardWorker
  include Sidekiq::Worker

  def perform(name)
    # Do something
    sleep(7)
    puts ">>>>>>>>>>>> terminou #{name}"
  end
end
