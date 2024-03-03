# Use an official Ubuntu image as the base
FROM ubuntu

# Set the working directory inside the container
WORKDIR /genie-app-automation

# Copy the directories
COPY /ArgumentFiles /genie-app-automation/ArgumentFiles
COPY /Configuration /genie-app-automation/Configuration
COPY /CustomLibraries /genie-app-automation/CustomLibraries
COPY /KeywordLibraries /genie-app-automation/KeywordLibraries
COPY /TestData /genie-app-automation/TestData
COPY /TestSuites /genie-app-automation/TestSuites

# Update package list and install Python 3
RUN apt update && \
    apt install -y python3-pip

# Install PostgreSQL development package
RUN apt-get update && \
    apt-get install -y libpq-dev

#install robotframework libraries
RUN pip install robotframework
RUN pip install requests
RUN pip install robotframework-requests
RUN pip install robotframework-jsonlibrary
RUN pip install robotframework-seleniumlibrary
RUN pip install robotframework-appiumlibrary
RUN pip install robotframework-databaselibrary
RUN pip install psycopg2
RUN pip install cx_Oracle

# Expose a port on which your application will run
EXPOSE 80
EXPOSE 8080

# Define the command to run your Robot Framework tests
ENTRYPOINT ["robot", "-A", "ArgumentFiles/staging.args", "--variablefile", "TestData/Staging_Backend_TestData.py", "TestSuites/Backend/*.robot"]
#ENTRYPOINT ["robot", "-A", "ArgumentFiles/aws.args", "TestSuites/Product.robot", "TestSuites/SecurityTesting.robot"]
#ENTRYPOINT robot -A ArgumentFiles/aws.args TestSuites/Product.robot
#ENTRYPOINT ["sh", "-c", "robot -A ArgumentFiles/aws.args TestSuites/Product.robot && robot -A ArgumentFiles/aws.args TestSuites/UI.robot && robot -A ArgumentFiles/aws.args TestSuites/SecurityTesting.robot"]

