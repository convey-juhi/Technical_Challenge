# This script contains the test cases for the obj_key_value.py Python script

import obj_key_value ;

#Positive Test Case 1
def test_objectKeyValue_case1():
    input_values = ['{"a":{"b":{"c":"d"}}}', 'a/b/c']
    output = []

    def mock_input(s):
        output.append(s)
        return input_values.pop(0)
    obj_key_value.input = mock_input
    obj_key_value.print = lambda s : output.append(s)

    output = obj_key_value.objectKeyValue()
    assert output == 'd'

#Positive Test case 2
def test_objectKeyValue_case2():
    input_values = ['{"x":{"y":{"z":"a"}}}', 'x/y/z']
    output = []

    def mock_input(s):
        output.append(s)
        return input_values.pop(0)
    obj_key_value.input = mock_input
    obj_key_value.print = lambda s : output.append(s)

    output = obj_key_value.objectKeyValue()
    assert output == 'a'

#Negative Test Case
def test_objectKeyValue_case3():
    input_values = ['{"x":{"y":{"z":"a"}}}', 'y/z']
    output = []

    def mock_input(s):
        output.append(s)
        return input_values.pop(0)
    obj_key_value.input = mock_input
    obj_key_value.print = lambda s : output.append(s)

    output = obj_key_value.objectKeyValue()
    assert output != 'a'
