class ErrorSerializer
  def self.not_found(id)
    { message: "Error: Search not completed",
          errors: ["no record found with id: #{id}"],
        }
  end
end
