#	
#	Name:	Beauchamp, Joshua
#	Project:	5
#	Due:	05-10-2024
#	Course:	cs-2640-02-sp24
#
#	Description:	
#		The program caluclates the roots of a quadratic formula given the values for a, b,
#		and c. The program has multiple checkpoints in its computations to determine if the
#		given values can not be used in a quadratic equation, if it is just a linear equation,
#		or if the roots are imaginary. If the a, b, and c values are valid quadratic equation
#		values, then the two roots of the equation are outputted


	.data
title:	.asciiz	"Quadratic Equation Solver v0.1 by J.Beauchamp"
prompta:	.asciiz	"Enter value for a? "
promptb:	.asciiz	"Enter value for b? "
promptc:	.asciiz	"Enter value for c? "
noquad:	.asciiz	"Not a quadratic equation."
imaginrt:	.asciiz	"Roots are imaginary"
linearx:	.asciiz	"x = "
firstx:	.asciiz	"x1 = "
secondx:	.asciiz	"x2 = "

	.text
main:	
	# Outputs title
	la	$a0, title
	li	$v0, 4
	syscall

	jal	printnl
	jal	printnl

	# Reads the first double for a into $f4
	la	$a0, prompta
	li	$v0, 4
	syscall

	li	$v0, 7
	syscall

	# Moves the a value into $f4 from $f0
	mov.d	$f4, $f0

	# Reads the second double for b into $f2
	la	$a0, promptb
	li	$v0, 4
	syscall

	li	$v0, 7
	syscall

	# Moves the b value into $f2 from $f0
	mov.d	$f2, $f0

	# Reads the third double for c into $f0
	la	$a0, promptc
	li	$v0, 4
	syscall

	li	$v0, 7
	syscall

	# Checks if the values can not be a quadratic equation
	# If a value and b value are both 0, then it is not a quadratic equation
	li.d	$f6, 0.0		# Loads the zero value into $f6 for comparing
	c.eq.d	$f4, $f6		# Compares if the a value with 0
	bc1t	checkb		# Goes to second condition if a value is 0
	b	isquadratic	# Branches to check if it is quadratic if a is not 0

checkb:	c.eq.d	$f2, $f6		# Compares if the b value with 0
	bc1f	isquadratic	# Exits the program if a and b are both 0

	jal	printnl

	la	$a0, noquad
	li	$v0, 4
	syscall
	b	exit

isquadratic:

	# Checks if the equation is linear
	c.eq.d	$f4, $f6		# Compares if the a value is 0
	bc1f	notlinear		# Goes to dirsriminant if a is not 0
	c.lt.d	$f2, $f6		# Compares if the b value is not 0
	bc1t	notlinear

	neg.d	$f0, $f0		# Changes c value to negative
	div.d	$f12, $f0, $f2	# Divides c value by b value

	# Outputs the linear equation
	jal	printnl

	la	$a0, linearx
	li	$v0, 4
	syscall

	li	$v0, 3
	syscall

	b	exit

notlinear:

	# Calculates the discriminant
	li.d	$f10, 4.0

	# Calculates the b value to the power of 2
	mul.d	$f8, $f2, $f2	# Gets the b value to the power of two

	# Calulcates 4ac
	mul.d	$f10, $f10, $f4	# Multiplies the a value by 4 into $f10
	mul.d	$f10, $f10, $f0	# Multiplies 4a by c value

	# Gets the discriminat into $f8 and checks if it is less than 0
	sub.d	$f8, $f8, $f10	# Calulcates b^2 - 4ac

	li.d	$f10, 0.0
	c.lt.d	$f8, $f10		# Compares if discriminant less than 0
	bc1f	notimagin		# Outputs the roots are imaginary if discriminant less than 0

	jal	printnl

	la	$a0, imaginrt
	li	$v0, 4
	syscall

	b	exit

notimagin:
	# Gets both roots from the quadratic equation
	li.d	$f14, 2.0		# Stores 2 for computing
	mul.d	$f14, $f14, $f4	# Calulcates the denominator of the quadratic formula

	# Gets the first root by subtracting the discriminant
	sqrt.d	$f8, $f8		# Sqaure roots the discriminant
	neg.d	$f0, $f2		# Gets negative b value
	sub.d	$f12, $f0, $f8	# Calculates the numerator
	div.d	$f12, $f12, $f14	# Divides the numerator by the denominator

	# Outputs the first root
	la	$a0, firstx
	li	$v0, 4
	syscall

	li	$v0, 3
	syscall

	jal	printnl
	
	# Gets the second root by adding the discriminant
	add.d	$f12, $f0, $f8	# Calculates the numerator
	div.d	$f12, $f12, $f14	# Divides the numerator by the denominator

	# Outputs the second root
	la	$a0, secondx
	li	$v0, 4
	syscall

	li	$v0, 3
	syscall

	jal	printnl

exit:	# Exits the program
	jal	printnl

	li	$v0, 10
	syscall

	# Procedure that prints out a newline character
printnl:
	li	$a0, '\n'
	li	$v0, 11
	syscall

	jr	$ra
