class ErrorSerializer
  def self.not_found(id)
    {
        message: "your query could not be completed",
        error: ["no object found with id: #{id}"],
    }
  end

  def self.bad_request
    {
        message: "Record not found",
        error: "Query missing required information",
    }
  end
end
