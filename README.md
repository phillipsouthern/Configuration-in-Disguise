# Configuration-in-Disguise

This repo shows the demo from the session "Configuration in Disguise".  The slide deck is also included in the Presentation folder. 

In this session we discussed how configuration on the Salesforce.com platform can impact and have a lasting relationship with development (code).  Specifically we talked about Custom Settings, Custom Labels, Field Sets, and Flow.  

Demos:

Contact Campaign Member Edit

In our demo we built a Visualforce page that was related to a button on the Contact screen.  That page displayed a contact with a table of all the campaign members it was associated to.  The page and Apex controller relied on Custom Settings, Field Sets, and a Custom Label to display items on the screen.  Please check the Presentation for explaination and examples.

Account Health Status

In this demo we showed a Visualforce page and Apex controller that took in data from a user and then sent that information to a Flow.  The Flow determined what to do with the data, in this case we inserted a Case, and then sent back the Id of the record to send the user to.  Please check the Presentation for explanation and example.
