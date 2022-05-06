class Image < Array
  MIN_LENGTH = 1
  MAX_LENGTH = 250

  def initialize(m, n)
    validate!(m, n)
    super(n) { Array.new(m).fill('O') }
  end

  private

  def validate!(m, n)
    raise 'Max size is 250x250' if m > MAX_LENGTH || n > MAX_LENGTH
    raise 'Min size is 1x1' if m < MIN_LENGTH || n < MIN_LENGTH
  end
end
