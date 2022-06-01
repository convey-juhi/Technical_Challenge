# This script calculates the key based on the Object and Key passed to it.

import json ;

# Get the object and key as the input
inputObject = input('Please enter the object in the form of key-value pair ')
inputKey = input('Please enter the key to find its value ')

# Function which find thes value based on input object and key provided.
def objectKeyValue(inputObject,inputKey):
    # Converts the JSON object into Python dict
    currentObject = json.loads(inputObject)

    # Splits the key based on the delimiter
    keySplit = inputKey.split("/")

    # Traverses through the keys to get the value of the object
    for i in keySplit:
        if (i in currentObject.keys()):
            currentObject = currentObject[i];
        else:
            print('Invalid key entered')
            quit()
    return(currentObject)

# Print the value of the object
print(objectKeyValue(inputObject,inputKey))
