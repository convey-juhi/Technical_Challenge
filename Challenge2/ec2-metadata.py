# This script calculates the metadata of an EC2 instance. To get the complete metadata enter "null"
# It will also get the value of the key based on the key entered.

import json ;
import requests ;

# Base URL to get the keys
baseUrl='http://169.254.169.254/latest/meta-data/' ;

# This function get the values for the key and stores them in JSON format
def createMetaDataJSONRecursively(subUrl) :
  currentUrl = baseUrl + subUrl ;
  jsonStructure = {};
  metaData = requests.get(currentUrl) ;
  keys= metaData.text.splitlines() ;
  for k in keys :
    if k[len(k)-1] == '/' :
      jsonStructure[k[:-1]] = createMetaDataJSONRecursively(subUrl+ k);
    else :
      value =requests.get(currentUrl + k).text ;
      try:
        jsonStructure[k] =json.loads(value) ;
      except ValueError:
        jsonStructure[k] = value ;
     
  return jsonStructure ;

# Get the key as an input from the user and print the corresponding value
inputKey = input('enter key') ;
inputKey=inputKey.strip();
print('inputKey is = ',inputKey)
result=createMetaDataJSONRecursively('') ;

# if the key is null print the entire json
if(inputKey != 'null'):
  try :
    print(result[inputKey]);
  except KeyError :
    print('key not found') ;
else :
  print(json.dumps(result,indent=4)) ;

