#####################################################################
#
#  Name:        Timbre Freeman
#  Assignment:  Simple Classes - DVD
#  Date:        02/05/2020
#  Class:       CIS 283
#  Description: emulate the dvd player using a simple class and menu
#
#####################################################################

$debug = false

# DVD Class
class DVD
  # max dvd length is 2hr
  # hr * 60 = min * 60 = sec
  @@max_length_hr = 2
  @@max_length = @@max_length_hr*60*60
  def self.max_length
    @@max_length
  end
  def self.max_length_hr
    @@max_length_hr
  end

  # getters
  attr_reader :length, :blank, :title

  def initialize(title, length = @@max_length, blank = false)
    # movie title
    @title = title
    # how long is the movie
    self.length = length
    @blank = blank
  end

  # getters
  def length_hr
    # sec/60=min/60=hr
    (@length/60)/60
  end

  private
      def length=(length)
        if length > @@max_length
          puts "time can not be longer then #{@@max_length_hr}hr(#{@@max_length}sec)"
          @length = @@max_length
        else
          @length = length
        end
      end
end

# DVD Player Class
class DVD_Player
  attr_reader :dvd
  def initialize(dvd = DVD.new("No DVD", 0, true))
    @dvd = dvd
    @dvd_time_move = 0
    @time_start = 0
  end

  # Methods
  # Insert Disk
  def insert_disk(dvd)
    old_dvd = self.eject_disk()
    @dvd = dvd
    @dvd_time_move = 0
    return old_dvd
  end

  # Play Disk
  def play_disk()
    @time_start = Time.now.to_i
  end

  # Rewind Disk (number of seconds)
  def rewind_disk(time_going_back)
    if (@dvd_time_move - time_going_back) > 0
      @dvd_time_move = @dvd_time_move - time_going_back
    else
      @dvd_time_move = 0
    end
  end

  # Fast Forward Disk  (number of seconds)
  def fast_forward_disk(time_going_forward)
    if (@dvd_time_move - time_going_forward) < @dvd.length
      @dvd_time_move = @dvd_time_move + time_going_forward
    else
      @dvd_time_move = @dvd.length
    end
  end

  # Stop playing
  def stop_playing()
    @dvd_time_move = 0
    @time_start = 0
  end

  # Eject Disk
  def eject_disk()
    dvd = @dvd
    @dvd = DVD.new("No DVD", 0, true)
    @time_start = 0
    @dvd_time_move = 0
    return dvd
  end

  def time_left
    if (@time_start == 0)
      return @dvd.length - @dvd_time_move
    else
      time_now = Time.now.to_i
      #  Time that has pass by             Time of the DVD - Time we skip
      if (time_now - @time_start) >= (@dvd.length - @dvd_time_move)
        return 0
      elsif (time_now - @time_start) < (@dvd.length - @dvd_time_move)
        return (@dvd.length - ((time_now - @time_start) + @dvd_time_move))
      end
    end
  end
  def time_left_min
    return (self.time_left/60.to_f).ceil
  end

  def playing?
    if (@time_start == 0)
      return false
    else
      return true
    end
  end

  def movie_end_message(use_dvd_player_message = true)
    if (self.playing?)
      if (self.time_left == 0)
        puts "" if use_dvd_player_message
        puts "***The movie is over - Stopping Movie***" if use_dvd_player_message
        self.stop_playing
        puts "***Done***" if use_dvd_player_message
        return true
      else
        return false
      end
    else
      return false
    end
  end
end

# menu
def menu(items = Array.new(2){"continue"})
  input_works = false
  while !input_works
    for i in 0...items.length
      puts "#{i+1})  #{items[i]}"
    end
    print "Enter option(1-#{items.length}): "
    user_input = gets.chomp.to_i
    puts ""
    if (user_input > 0) && (user_input <= items.length)
      input_works = true
      return user_input
    else
      puts "Error: must pick a option"
    end
  end
  return user_input
end

# make a dvd's
# puts "Max DVD length is #{DVD.max_length_hr}hr(#{DVD.max_length}sec)" if $debug
# fun_dvd = DVD.new("fun", 1.5*60*60)
# puts "The dvd \"#{fun_dvd.title}\" is #{fun_dvd.length_hr}hr(#{fun_dvd.length}sec)" if $debug
# puts "Is the DVD \"#{fun_dvd.title}\" blank? #{fun_dvd.blank}" if $debug
dvds = [
    DVD.new("Alien", (1*60*60)+(56*60)),
    DVD.new("Bedtime Stories", (1*60*60)+(39*60)),
    DVD.new("City of Ember", (1*60*60)+(35*60)),
    DVD.new("Flubber", (1*60*60)+(33*60))
]

# Start a DVD Player
dvd_player = DVD_Player.new()
# Start a menu
run = true
movie_end_thre = Thread.new {
  while (run)
    dvd_player.movie_end_message
    sleep(1)
  end
}
while run
  puts "DVD Menu"
  user_option = menu(["Insert Disk","Play Disk","Rewind Disk","Fast Forward Disk",
                      "Stop Disk","Eject Disk","Show Current Disk Status","QUIT"])
  # 1)	Insert Disk
  if (user_option == 1)
    if (!dvd_player.dvd.blank)
      time_left = dvd_player.time_left_min
      puts "Ejecting disk #{dvd_player.eject_disk.title} at #{time_left}min left"
      puts "Done"
    end
    dvd_titles = []
    dvds.each do |dvd|
      dvd_titles.push(dvd.title + " (Length of " + dvd.length.to_s + "sec)")
    end
    puts "Chose a dvd"
    dvd_number = menu(dvd_titles)
    puts "Inserting DVD #{dvds[dvd_number-1].title}"
    dvd_player.insert_disk(dvds[dvd_number-1])
  # 2)	Play Disk
  elsif (user_option == 2)
    puts "Playing disk #{dvd_player.dvd.title}"
    dvd_player.play_disk
  # 3)	Rewind Disk
  elsif (user_option == 3)
    print "How far back do you want to go in sec? (ex 20): "
    dvd_player.rewind_disk(gets.chomp.to_i)
    puts ""
    puts "Time left in #{dvd_player.dvd.title} is #{dvd_player.time_left_min}min"
  # 4)	Fast Forward Disk
  elsif (user_option == 4)
    print "How far forward do you want to go in sec? (ex 20): "
    dvd_player.fast_forward_disk(gets.chomp.to_i)
    puts ""
    puts "Time left in #{dvd_player.dvd.title} is #{dvd_player.time_left_min}min"
  # 5)	Stop Disk
  elsif (user_option == 5)
    puts "Stoping #{dvd_player.dvd.title} at #{dvd_player.time_left_min}min left"
    dvd_player.stop_playing
  # 6)	Eject Disk
  elsif (user_option == 6)
    time_left = dvd_player.time_left_min
    puts "Ejecting disk #{dvd_player.eject_disk.title} at #{time_left}min left"
  # 7)	Show Current Disk Status
  elsif (user_option == 7)
    if !(dvd_player.dvd.blank)
      puts "DVD Title: #{dvd_player.dvd.title}"
      puts "DVD length: #{dvd_player.dvd.length} sec"
      puts "Playing: #{dvd_player.playing?}"
      puts "Time left in Film: #{dvd_player.time_left_min} min (#{dvd_player.time_left} sec)"
    else
      puts "No DVD"
    end
    print "DVD choices are: | "
    dvds.each do |dvd|
      print  dvd.title + " | "
    end
    puts ""
  # 8)	QUIT
  elsif (user_option == 8)
    run = false
    break
  end
  print "Done - Press enter to continue"
  gets.chomp
  puts ""
end
movie_end_thre.exit