#!/bin/bash
#
# this script demonstrates doing arithmetic

# Task 1: Remove the assignments of numbers to the first and second number variables. Use one or more read commands to get 3 numbers from the user.
# Task 2: Change the output to only show:
#    the sum of the 3 numbers with a label
#    the product of the 3 numbers with a label

echo "Enter the first number:"
read firstnum
echo "Enter the second number:"
read secondnum
echo "Enter the third number:"
read thirdnum
sum=$((firstnum + secondnum + thirdnum))
product=$((firstnum * secondnum * thirdnum))
#fpdividend=$(awk "BEGIN{printf \"%.2f\", $firstnum/$secondnum}")

#cat <<EOF
#$firstnum plus $secondnum is $sum
#$firstnum divided by $secondnum is $dividend
#  - More precisely, it is $fpdividend
#EOF
echo "Sum of the three numbers: $sum"
echo "Product of the three numbers: $product"
