Terraform Functions
------------------
- Docs: https://developer.hashicorp.com/terraform/language/functions
- Docs: https://developer.hashicorp.com/terraform/language/expressions/function-calls
- The Terraform language includes a number of built-in functions that you can call from within expressions to transform and combine values. 
- The Terraform language does not support user-defined functions, and so only the functions built in to the language are available for use.
- The general syntax for function calls is a function name followed by comma-separated arguments in parentheses:

        max(5, 12, 9)
- You can experiment with the behavior of Terraform's built-in functions from the Terraform expression console, by running the `terraform console` command:
- Console loads the state associated with configuration directory by default allowing us to load any value currently stores in it .
- It also lodas the variables defined in configuration.
- This allows to exeperiemnt with function and interpolation that can be later used in configuration files.

Commonly used function:
----------------------
- Numeric functions
- String functions
- Collection functions
- Type Conversion functions

Numeric functions:
- max()
- min()
- ceil()
- floor()
- This can be used with variables as below
        
        #variables.tf
        variable "num" {
            type=set(number)
            default=[235,-9,0,1]
            description= "A set of numbers"
        }

        #terraform console
        max(var.num...)
        # this triple dot is expansion symbol to seperate the variables in arguments to function

String Functions
----------------
- split(), splits the string in list with given seperator
- lower()
- upper()
- title()
- substr()
- join()

Collection Functions
--------------------
- Collection functions are related to set, list and map
- length()
- index()
- element()
- contains()
- keys()
- values()
- lookup()

Conditional Expressions and Operators
-------------------------------------
- +, -, *, /, ==, >, <, >=, <=,  &&, ||, !, 
- conditial used as belwo

        condition? true value: false valueexit

Terraform Workspace
====================