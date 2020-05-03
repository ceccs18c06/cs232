

addition(){
	echo $1 + $2 = $(($1 + $2))
}

subtraction(){
	echo "$1 - $2 = $(($1 - $2))"
}

multiplication(){
	echo "$1 x $2 = $(($1 * $2))"
}

division(){
	echo $1 / $2 = $(($1 / $2))
}


calc(){

	echo "Enter two numbers: "
	read n1 
	read n2

	case $1 in
		
		"add")
			addition $n1 $n2
			;;	

		"sub")
			subtraction $n1 $n2
			;;

		"mul") 
			multiplication $n1 $n2
			;;
		"div")
			division $n1 $n2
			;;
			
	esac
}

main(){


	echo -e "Calculator Program\n\n";

	echo -e "Enter 1 to perform addition\n";
	echo -e "Enter 2 to perform subtraction\n";
	echo -e "Enter 3 to perform multiplication\n";
	echo -e "Enter 4 to perform division\n";

	read ch


	case $ch in

		1)
			calc "add"
			;;
		2)
			calc "sub"
			;;
		3)
			calc "mul"
			;;
		4)	
			calc "div"
			;;
		*)
			echo "Invalid Option"
			;;
	esac


}


main
