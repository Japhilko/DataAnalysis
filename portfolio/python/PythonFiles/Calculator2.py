def add(num1,num2):
	return num1 + num2
	
def main():
	operation = input("What do you want to do (+,-,*,/)")
	if(operation != '+' and operatopn !='-' and operatopn !='*' and operatopn !='/'):
		print("Enter valid operation")
	else:	
		val1 = int(input("Pleas type a nr"))
		val2 = int(input("Pleas type a nr"))
		if(operation == '+'):
			print(add(val1, val2))
			
main()
