class ErrorSerializer
  def self.not_found(id)
    { data: { message: "Error: Search not completed",
            errors: ["no record found with id: #{id}"],
            }
        }
  end

  def self.bad_request
    {status: :not_found, code: 400, message: "Error: Bad Request" }
  end
end
