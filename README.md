# secure-journaling



Create Facial Recognition Screen

    Access key
    Flash Message
    Redirect to the Journal SCreen    
Test Screen 
    Get Photo 
    Send it to lambda 
    Flash boolean and confidence score 
    IF True 

Create Journaling Screen 
    Loading Screen
    Check access token and the regular token
    Get journals
    
Get Info on Journaling screen
Add authentication on journaling screen 








Whats left:
Facial Recognition
    Add to s3
    DetectFaces -> reds data and indexes info 
    detect_faces_auth -> compares image to one saved and returns whether it is authenticated 

Login/Sign Up/Auth 
    
Screens
Documentation



For Facial REcognition 
1. Upload photo to s3 with cpecific name 
2. When that is finished call the index face to actually save the facial data
3. 


Facial Verification process
take in the user object 
pass in uid and photo
index face if uid is not found in collection 
check similarity if uid is found in collection
generate access code {access_code:"",expiration: unix expiration} and save in dynamodb if successful 
return access code to user 

To validate on the journals page
verify the aws code, if successful validate the access_code
For access code, check if expirtaion is legit, and then check if the access code and the uid match in dynamodb, if so update the expiration to be an hour later







Screens:
Login 
Create Account
Facial Recognition 
Journals Home Page 




Future Work
Google Calendar
    Create Google Calendar Event
    Get Google Calendar Events
Sentiment Analysis on journal entries

