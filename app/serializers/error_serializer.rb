class ErrorSerializer
  def self.not_found(id)
    { data: { message: "Error: Search not completed"},
      error: ["no record found with id: #{id}"]
        }
  end

  def self.bad_request
    {error: 'Missing information', status: :not_found, code: 400, message: "Error: Bad Request" }
  end
end
