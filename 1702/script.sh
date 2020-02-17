pdftotext -layout s1.pdf s1.data.txt
pdftotext -layout s2.pdf s2.data.txt


#cat s2.data.txt

#get only register numbers from students.txt
reg_data=`cut -d' ' -f1 students.txt`
#cat s1.data.txt


IFS=$'\n'

#convert register numbers to array
reg_data=( $reg_data )


extractGrade1(){

	grep ${reg_data[$1]} s1.data.txt > person.data.txt
	grep -A1 ${reg_data[$1]} s1.data.txt | grep -v ${reg_data[$1]} >> person.data.txt


	O=`grep -o '(O)' person.data.txt | wc -l`
	A=`grep -o '(A)' person.data.txt | wc -l`
	AP=`grep -o '(A+)' person.data.txt | wc -l`
	B=`grep -o '(B)' person.data.txt | wc -l`
	BP=`grep -o '(B+)' person.data.txt | wc -l`
	C=`grep -o '(C)' person.data.txt | wc -l`
	P=`grep -o '(P)' person.data.txt | wc -l`
	F=`grep -o '(F)' person.data.txt | wc -l`
	FE=`grep -o '(FE)' person.data.txt | wc -l`
	AB=`grep -o '(Absent)' person.data.txt | wc -l`
	I=`grep -o '(I)' person.data.txt | wc -l`


	sgpa1=`awk "BEGIN {print (($O*10) +($AP*9)+($A*8.5)+($BP*8)+($B*7)+($C*6)+($P*5) )/9}"`

	failed1=$(($F+$FE+$AB+$I)) 
	
}

extractGrade2(){
	#grep ${reg_data[$1]} s2.data.txt > person.data.txt
	grep -A1 ${reg_data[$1]} s2.data.txt > person.data.txt


	O=`grep -o '(O)' person.data.txt | wc -l`
	A=`grep -o '(A)' person.data.txt | wc -l`
	AP=`grep -o '(A+)' person.data.txt | wc -l`
	B=`grep -o '(B)' person.data.txt | wc -l`
	BP=`grep -o '(B+)' person.data.txt | wc -l`
	C=`grep -o '(C)' person.data.txt | wc -l`
	P=`grep -o '(P)' person.data.txt | wc -l`
	F=`grep -o '(F)' person.data.txt | wc -l`
	FE=`grep -o '(FE)' person.data.txt | wc -l`
	AB=`grep -o '(Absent)' person.data.txt | wc -l`
	I=`grep -o '(I)' person.data.txt | wc -l`


	sgpa2=`awk "BEGIN {print (($O*10) +($AP*9)+($A*8.5)+($BP*8)+($B*7)+($C*6)+($P*5) )/9}"`

	failed2=$(($F+$FE+$AB+$I))

}


downloadProgress(){
	

	
	for no in ${!reg_data[@]}; do
		extractGrade1 $no
		extractGrade2 $no
		
		details=`grep ${reg_data[no]} students.txt`

		if [ $failed1 -gt 0 ] || [ $failed2 -gt 0 ]
		then
			echo $details failed -$failed1 -$failed2

		else	
			cgpa=`awk "BEGIN {print ($sgpa1+$sgpa2)/2}"`

			echo $details $sgpa1 $sgpa2 $cgpa
		fi
	done

	#tail -n1 results.data.txt | grep -o " " | wc -l

	#sort -k 5 results.data.txt

}

test(){
	

	students=`cut -d" " -f2- students.txt`
	students=( $students )

	
	for no in ${!reg_data[@]}; do
		extractGrade1 $no
		extractGrade2 $no
		
		details=`grep ${reg_data[no]} students.txt`

		if [ $failed1 -gt 0 ] || [ $failed2 -gt 0 ]
		then
			echo ${reg_data[no]} failed -$failed1 -$failed2

		else	
			cgpa=`awk "BEGIN {print ($sgpa1+$sgpa2)/2}"`

			echo ${reg_data[no]} $sgpa1 $sgpa2 $cgpa
		fi
	done > results.data.txt


	sort -k4 -r results.data.txt > results1.data.txt




	regno=( `cut -d" " -f1 results1.data.txt` )
	results=( `cut -d" " -f2- results1.data.txt` )



	echo "(reg_no, name, s1_result-sgpa, s2_result-sgpa, cgpa)"

	for no in ${!regno[@]}; do
	
		grep ${regno[no]} students.txt > person.data.txt

		names=`cut -d" " -f2- person.data.txt`
		

		echo ${regno[no]} $names ${results[no]}
	done | tee results.txt


}


#downloadProgress
test

rm *.data.txt
