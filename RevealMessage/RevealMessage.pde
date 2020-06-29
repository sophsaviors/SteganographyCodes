/******************************
REVEAL MESSAGE
Created by: Sofia Salvatori
License: GPL-3.0
*******************************/

/*
Configuration
*/
String inputImage = "input-demo.png"; // choose the image in which the message is hidden



PImage img = loadImage(inputImage);
img.loadPixels();
// create an empty string which will contain the characters composing the message
String secretMessage = "";

// for each group of three pixels (3 pixels contain 1 character)
for (int i=0; i<img.pixels.length; i+=3) {
  // create an empty string which will contain the binary sequence of a character
  String binaryLetter = ""; 

  // get the first pixel of the group and its RGB values
  int pixel = img.pixels[i];
  int pixelRed = round(red(pixel));
  int pixelGreen = round(green(pixel));
  int pixelBlue = round(blue(pixel));

  // convert Red to a binary sequence
  String binaryRed = binary(pixelRed, 8);
  // get the last bit of the Red binary sequence
  // and add it to the binary sequence of the character
  binaryLetter = binaryLetter + binaryRed.charAt(7);

  // repeat the process for the other colors
  String binaryGreen = binary(pixelGreen, 8);
  binaryLetter = binaryLetter + binaryGreen.charAt(7);
  
  String binaryBlue = binary(pixelBlue, 8);
  binaryLetter = binaryLetter + binaryBlue.charAt(7);

  // get the second pixel of the group 
  // repeat the process done for the first pixel
  pixel = img.pixels[i + 1];
  pixelRed = round(red(pixel));
  pixelGreen = round(green(pixel));
  pixelBlue = round(blue(pixel));

  binaryRed = binary(pixelRed, 8);
  binaryLetter = binaryLetter + binaryRed.charAt(7);

  binaryGreen = binary(pixelGreen, 8);
  binaryLetter = binaryLetter + binaryGreen.charAt(7);

  binaryBlue = binary(pixelBlue, 8);
  binaryLetter = binaryLetter + binaryBlue.charAt(7);

  // get the third pixel of the group
  // repeat the process done for the two pixels before
  pixel = img.pixels[i + 2];
  pixelRed = round(red(pixel));
  pixelGreen = round(green(pixel));
  pixelBlue = round(blue(pixel));

  binaryRed = binary(pixelRed, 8);
  binaryLetter = binaryLetter + binaryRed.charAt(7);

  binaryGreen = binary(pixelGreen, 8);
  binaryLetter = binaryLetter + binaryGreen.charAt(7);
  
  // convert the 8 bits of the character to its decimal value
  char letter = char(unbinary(binaryLetter));
  // add the character to the message string
  secretMessage = secretMessage + letter;
  
  // use Blue of the third pixel to check if the message is finished
  // 0 = continue message
  // 1 = message finished
  binaryBlue = binary(pixelBlue, 8);
  if (binaryBlue.charAt(7) == '1') {
    break; // stop immediately the for cycle
  } 
}

// print the complete message
println("The secret message is: '" + secretMessage + "'");
