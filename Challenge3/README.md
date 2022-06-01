**Find the value based on the key and object passed to the script**

We have a nested object, we would like a function that you pass in the object and a key and get back the value. 

Example Inputs

object = {“a”:{“b”:{“c”:”d”}}}
key = a/b/c
value = d

object = {“x”:{“y”:{“z”:”a”}}}
key = x/y/z
value = a

To execute this script, input the object and the key in the above mentioned format to print its value.

Command : **python3 obj_key_value.py**

**To run the tests:**

The test cases contains 2 Positive Use Case and 1 Negative Use Case.

Prequisite : pytest 
Steps : sudo apt install pip
         pip install pytest
         
Command to run the test:

pytest -v test_obj_key_value.py
