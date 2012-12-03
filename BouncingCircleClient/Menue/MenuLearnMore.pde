

// Tools for "Learn More" 

void textLearnMoreOnScreen() {
  String a = textLearnMore();
  a = a.replaceAll("#", "\n");
  a += "                          - Press mouse button to continue.";
  textLeading(25);
  text(a, 9, 10);
}
//
void printLearnMore() {
  String a = textLearnMore();
  String[] list = split(a, '#');
  for (int i=0; i<list.length;i++) {
    println(list[i]);
  }
}
//
String textLearnMore() {
  // the sign # is used as line break here  
  String a=""; 
  a+="#"+"Menue Test ";
  a+="#"+"";
  a+="#"+"Menue Test provides a general ";
  a+="#"+"structure for a Menue and a program with states.";
  a+="#"+"Here you can enter a help text.";
  a+="#"+"#";
  return (a);
}
//

