class Card

  attr_reader :face_value, :suit_value, :value, :color, :image

  def initialize(suit_value, face_value)
    @suit_value = suit_value
    @suit = SUITS.key(suit_value)
    @face_value = face_value
    @face = FACES.key(face_value)
    decorate_suit
    decorate_face
    # Formula to give each card a value from 1 to 52
    # @value = @suit_value * 13 + @face_value - 14
  end

  def decorate_suit
    case @suit
    when "Vote"
      @color = "yellow"
      @image = "\u2660"
    when "Ita"
      @color = "magenta"
      @image = "\u2666"
    when "Chidi"
      @color = "gray"
      @image = "\u2663"
    when "Paane"
      @color = "red"
      @image = "\u2665"
    end
  end

  def decorate_face
    case @face_value
    when 11
      @face_char = "J"
    when 12
      @face_char = "Q"
    when 13
      @face_char = "K"
    when 14
      @face_char = "A"
    else
      @face_char = @face_value.to_s
    end
  end

  def picturize
    "#{@face_char}#{@image}"
  end

  def humanize
    "#{@suit} ko #{@face}"
  end

  def computerize
    "(#{@suit_value}, #{@face_value})"
  end

end
