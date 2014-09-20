class Hand

  attr_reader :color, :cards, :value, :type, :face_values

  HAND_VALUES = { top: 0, joot: 1, color: 2, run: 3, double_run: 4, trial: 5 }

  def initialize(cards=[])
    @cards = cards
    sort_cards
    @value = determine_hand_value
    @type = HAND_VALUES.key(@value).to_s
    decorate_type
  end

  def sort_cards
    @cards.sort! { |c1, c2| c1.face_value <=> c2.face_value }
  end

  def decorate_type
    case @type
    when "trial"
      @color = "red"
    when "double_run"
      @color = "magenta"
    when "run"
      @color = "cyan"
    when "color"
      @color = "green"
    when "joot"
      @color = "yellow"
    when "top"
      @color = "gray"
    end
  end

  # if both have same hands, showing player looses
  def is_greater_than?(hand)
    if @value == hand.value
      if @value == HAND_VALUES[:joot]
        # compare the joots (i.e. the duplicates in the array)
        @face_values.detect{ |e| @face_values.count(e) > 1 } > hand.face_values.detect{ |e| hand.face_values.count(e) > 1 }
      elsif @value == HAND_VALUES[:color] || @value == HAND_VALUES[:top]
        @face_values.zip(hand.face_values).each do |first, second|
          next if first == second
          return first > second
        end
        # if all the cards are same
        return false
      else
        @face_values.inject(:+) > hand.face_values.inject(:+)
      end
    else
      @value > hand.value
    end
  end

  private

  def determine_hand_value
    @face_values = @cards.map(&:face_value)
    @suit_values = @cards.map(&:suit_value)
    return HAND_VALUES[:trial] if is_trial?
    return HAND_VALUES[:double_run] if is_double_run?
    return HAND_VALUES[:run] if is_run?
    return HAND_VALUES[:color] if is_color?
    return HAND_VALUES[:joot] if is_joot?
    return HAND_VALUES[:top]
  end

  def is_trial?
    @face_values.uniq.length == 1
  end

  def is_double_run?
    is_run? && is_color?
  end

  def is_run?
    # Special case for Ekka ? :( [2,3,14]
    return true if (@face_values <=> [2,3,14]) == 0
    (@face_values.last - @face_values.at(1) == 1) && (@face_values.at(1) - @face_values.first == 1)
  end

  def is_color?
    @suit_values.uniq.length == 1
  end

  def is_joot?
    @face_values.uniq.length == 2
  end

end

