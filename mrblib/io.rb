class PAX
  IO = ::IO

  class IO
    DEFAULT_TIMEOUT = 30000

    class << self
      attr_accessor :timeout
    end

    # milliseconds
    self.timeout = DEFAULT_TIMEOUT

    def self.get_string(min, max, mode = IO_INPUT_LETTERS)
      PAX._gets(min, max, input_type(mode), Screen.y, Screen.x)
    end
  end
end