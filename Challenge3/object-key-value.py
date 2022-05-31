import json ;

# Get the object and key as the input
inputObject = input('Please enter the object in the form of key-value pair ')
inputKey = input('Please enter the key to find its value ')

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

# Print the value of the object
print(currentObject)