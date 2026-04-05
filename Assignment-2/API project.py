#aim of this project is to to get the current location of ISS (international space station) spacecraft orbiting around the earth gathering various data 
import requests
import csv 
import time
import webbrowser

 #this url contains the data with the current location of the ISS in json format. 
api_url = 'http://api.open-notify.org/iss-now.json' 

def get_iss_location(api_url):
    #getting the data from the url and storing it in a variable called response
    response = requests.get(api_url) 

    #using the .json() method to read the response body and parse it as json and then convert into a python dictionary.
    object = response.json()

    lat =(object['iss_position']['latitude']) 
    long = (object['iss_position']['longitude'])  
    timestamp = (object['timestamp']) 

    return lat, long, timestamp   
lat, long, timestamp = get_iss_location(api_url)
print(lat, long, timestamp)
print(timestamp)

#use the latitude and longitude values to create a url that will open the location on the map marking it. 
#url adjusted using strings because I am concatenating these values 
url = 'https://www.openstreetmap.org/?mlat=' + str(lat) + '&mlon=' + str(long) + '#map=2/' + str(lat) + '/' + str(long)

#this wil open the url with the marker loated on the map to see if the current position of international space station live
webbrowser.open_new(url)

#use function to save data as csv file and add delay to show the changes in the values as the station is moving.
def save_data(filename, range_input, delay, lat, long):
    success = True

    try:
        with open(filename, "w", newline="") as file:
            writer = csv.writer(file)
            writer.writerow(["lat", "lon", "timestamp"])

            for _ in range(range_input):
                result = lat, long, timestamp

                if result:
                    writer.writerow(result)
                else:
                    print("Could not get ISS data")
                    success = False
                # Adding delay so that the csv data show the changes in the values as the staton is moving
                time.sleep(delay)

    # Show error message if it cannot save the data to a file
    except Exception:
        print("Could not saving file")
        success = False

    print("Successfuly saved" if success else "Failed to save ")

#calling the save function with chosen parameters
save_data("ISS_data.csv", 4, 2, lat, long)


