class String

  # Keep a copy of the old "to_i" method
  alias old_to_i to_i

  # Override the "to_i" method entirely
  def to_i(base=10)
    gsub!(',', '') if include?(',')
    old_to_i(base)
  end

end