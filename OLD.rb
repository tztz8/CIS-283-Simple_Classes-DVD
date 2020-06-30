# class DVD_Player
#   # 2hr in sec is 7200
#   @@max_length_of_dvd = 7200
#   def initialize()
#     @play_flag = false
#     @has_dvd = false
#     @length_of_dvd = 0
#     @timer = Timer.new(@@max_length_of_dvd)
#   end
#   def insert_disk(length_in_sec)
#     if (length_in_sec > @@max_length_of_dvd)
#       puts "DVD length is too long"
#     else
#       @has_dvd = true
#       @length_of_dvd = length_in_sec
#       @timer = Timer.new(length_in_sec)
#     end
#   end
#   def play_disk()
#     @
#   end
# end

# class Timer
#   def initialize(length)
#     @length = length
#     @time_start = 0
#     @time_stop = 0
#   end
#   def start()
#     @time_start = Time.now - (@time_start-@time_stop)
#   end
#   def stop()
#     @time_stop = Time.now
#     return self.length_left()
#   end
#   def length_left()
#     if !self.timer_is_over?
#       return @length - (@time_stop - @time_start)
#     else
#       return 0
#     end
#   end
#   def timer_is_over?()
#     if (@time_stop - @time_start) <= length_left
#       return false
#     else
#       return true
#     end
#   end
# end
#
# puts "Making Timer with length 100"
# t = Timer.new(100)
# puts "Starting Timer"
# t.start
# puts "Wait for 10 sec"
# wait
#
if true
elsif (false)

end