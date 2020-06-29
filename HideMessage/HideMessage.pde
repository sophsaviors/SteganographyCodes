/******************************
HIDE MESSAGE
Created by: Sofia Salvatori
License: GPL-3.0
*******************************/

/*
Configuration
*/
String inputImage = "input-demo.png";                    // choose image in which you want to hide the message
String outputImage = "output-demo.png";                  // choose name of the output image (must be png file)
String secretMessage = "write your secret message here"; // write the message to hide


PImage img = loadImage(inputImage);
img.loadPixels();

int indexPixel = 0;
// for each character of the secret message
for (int i=0; i<secretMessage.length(); i+=1) {
  // get the character in position i and convert it to binary
  char letter = secretMessage.charAt(i);
  String binaryLetter = binary(letter, 8);

  // get a pixel from the pixel array of the image 
  // get all three RGB values of the pixel and round them down to integers
  int pixel = img.pixels[indexPixel];
  int pixelRed = round(red(pixel));
  int pixelGreen = round(green(pixel));
  int pixelBlue = round(blue(pixel));

  // Red integer to binary
  String binaryRed = binary(pixelRed, 8);
  // get the first bit of the character
  char letterBit = binaryLetter.charAt(0);
  // replace the last bit of the Red binary with the first bit of the character
  String newBinaryRed = binaryRed.substring(0, 7) + letterBit;

  // do the same for Green and the second character bit 
  String binaryGreen = binary(pixelGreen, 8);
  letterBit = binaryLetter.charAt(1);
  String newBinaryGreen = binaryGreen.substring(0, 7) + letterBit;

  // do the same for Blue and the third character bit
  String binaryBlue = binary(pixelBlue, 8);
  letterBit = binaryLetter.charAt(2);
  String newBinaryBlue = binaryBlue.substring(0, 7) + letterBit;

  // convert the new binary colors to integers
  int newPixelRed = unbinary(newBinaryRed);
  int newPixelGreen = unbinary(newBinaryGreen);
  int newPixelBlue = unbinary(newBinaryBlue);
  // use the new colors to make a pixel
  int newPixel = color(newPixelRed, newPixelGreen, newPixelBlue);
  // replace the original pixel in the image with the new one
  img.pixels[indexPixel] = newPixel;

  // move to the next pixel (1 letter is hidden in 3 pixels)
  indexPixel += 1;

  // repeat the process for the next pixel
  pixel = img.pixels[indexPixel];
  pixelRed = round(red(pixel));
  pixelGreen = round(green(pixel));
  pixelBlue = round(blue(pixel));

  binaryRed = binary(pixelRed, 8);
  letterBit = binaryLetter.charAt(3);
  newBinaryRed = binaryRed.substring(0, 7) + letterBit;

  binaryGreen = binary(pixelGreen, 8);
  letterBit = binaryLetter.charAt(4);
  newBinaryGreen = binaryGreen.substring(0, 7) + letterBit;

  binaryBlue = binary(pixelBlue, 8);
  letterBit = binaryLetter.charAt(5);
  newBinaryBlue = binaryBlue.substring(0, 7) + letterBit;

  newPixelRed = unbinary(newBinaryRed);
  newPixelGreen = unbinary(newBinaryGreen);
  newPixelBlue = unbinary(newBinaryBlue);
  newPixel = color(newPixelRed, newPixelGreen, newPixelBlue);
  img.pixels[indexPixel] = newPixel;
  
  // move to the next pixel (1 letter is hidden in 3 pixels)
  indexPixel += 1;

  // repeat the process for the next pixel
  pixel = img.pixels[indexPixel];
  pixelRed = round(red(pixel));
  pixelGreen = round(green(pixel));
  pixelBlue = round(blue(pixel));

  binaryRed = binary(pixelRed, 8);
  letterBit = binaryLetter.charAt(6);
  newBinaryRed = binaryRed.substring(0, 7) + letterBit;

  binaryGreen = binary(pixelGreen, 8);
  letterBit = binaryLetter.charAt(7);
  newBinaryGreen = binaryGreen.substring(0, 7) + letterBit;
  
  // use the last bit of the Blue color to tell if this is the last character
  // 1 = last character
  // 0 = continue message
  binaryBlue = binary(pixelBlue, 8);
  if (i == secretMessage.length()-1) { 
    newBinaryBlue = binaryBlue.substring(0, 7) + "1";
  } else { 
    newBinaryBlue = binaryBlue.substring(0, 7) + "0";
  }

  newPixelRed = unbinary(newBinaryRed);
  newPixelGreen = unbinary(newBinaryGreen);
  newPixelBlue = unbinary(newBinaryBlue);
  newPixel = color(newPixelRed, newPixelGreen, newPixelBlue);
  img.pixels[indexPixel] = newPixel;
  
  // move to the next group of three pixels (3 pixels to hide 1 character)
  indexPixel += 1;
}

// update the image pixels with the modified ones and save the image
img.updatePixels();
img.save(outputImage);
