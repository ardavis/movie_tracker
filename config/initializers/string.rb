class String

  # Keep a copy of the old "to_i" method
  alias old_to_i to_i

  # Override the "to_i" method entirely
  def to_i
    gsub!(',', '') if include?(',')
    old_to_i
  end

end