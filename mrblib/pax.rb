class PAX
  Network = ::Network
  IO      = ::IO

  class Display
    def self.clear
      ::IO.display_clear
    end

    def self.clear_line(line)
      ::IO.display_clear_line line
    end
  end

  class System
    DEFAULT_BACKLIGHT = 1
    def self.serial
      PAX._serial
    end

    def self.backlight=(level)
      PAX._backlight = level
    end

    def self.backlight
      DEFAULT_BACKLIGHT
    end

    def self.battery
      PAX._battery
    end
  end

  # Method should be implemented on platform class
  #  class Platform
  #    def self.start file
  #      require 'da_funk.mrb'
  #      require '<platform.mrb>'
  #
  #      app = Device::Support.path_to_class file
  #
  #      app.call
  #    end
  #  end
  def self.start(file = "main.mrb")
    # TODO ./file has some leak problem after 4 tries
    begin
      # Library responsable for common code and API syntax for the user
      require "da_funk.mrb"
      # Platform library responsible for implement the adapter for DaFunk
      # class Device #DaFunk abstraction
      #   self.adapter = 
      require "pax.mrb"
      require file

      # Method to contantize name of file, example:
      #   main.mrb/main.rb - Main
      app = Device::Support.path_to_class file

      loop do
        # Main should implement method call
        #  method call was need to avoid memory leak on irep table
        app.call
      end
    rescue => @exception
      puts "#{@exception.class}: #{@exception.message}"
      puts "#{@exception.backtrace[0..2].join("\n")}"
      IO.getc
      return nil
    end
  end
end