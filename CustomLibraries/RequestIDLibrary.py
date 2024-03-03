from datetime import datetime

class RequestIDLibrary:
    def generate_request_id(self):
        current_time = datetime.now()
        milliseconds = current_time.timestamp() * 1000  # Convert current time to milliseconds
        request_id = int(milliseconds)  # Convert to integer for the request ID
        return request_id
    
    def get_request_id(self):
        return self.generate_request_id()

# Create an instance of RequestIDLibrary
request_id_generator = RequestIDLibrary()

# Generate a request ID by calling the method through the instance
request_id = request_id_generator.generate_request_id()
print("Generated Request ID:", request_id)

