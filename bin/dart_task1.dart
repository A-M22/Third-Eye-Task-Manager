//removing Repeated values from giving list
List<int> removeRepetition(List<int> input)
{
  input=input.toSet().toList();
  return input;
}

void main()
{
  List<int> finalNumbers=[5,2,8,2,10,5,7,4,8,6];
  List<int> evenNumbers;
  int listTotal=0;
  int max=0;
  int min=0;

  //remove repeated values
  finalNumbers=removeRepetition(finalNumbers);
  

  //sort numbers from lowest to greatest
  finalNumbers.sort();
  

  //extracting the even numbers
  evenNumbers=finalNumbers.where((number)=>number%2==0).toList();
 

  //calculating the total
  for(int i=0;i<finalNumbers.length;i++)
  {
    listTotal+=finalNumbers[i];
  }

  //assigning max and min values from the list
  max=finalNumbers.last;
  min=finalNumbers.first;

  print("\nafter cleaning repeated values: $finalNumbers \n");
  print("Sorted Numbers from lowest to greater: $finalNumbers\n");
  print("even Numbers: $evenNumbers\n");
  print("List Total: $listTotal\n");
  print('minimum value in the list: $min \nmaximum value in the list: $max\n');

  


}