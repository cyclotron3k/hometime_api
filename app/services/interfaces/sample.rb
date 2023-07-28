class Sample < ParserBase

  def create_entities!
    ActiveRecord::Base.transaction do
      # Build the necessary entities here
      # Raise an exception on failure to save
    end
    true
  end

  private

  SCHEMA = {
    # Define json schema here
  }

end
