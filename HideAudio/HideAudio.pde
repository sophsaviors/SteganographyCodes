/******************************
 HIDE AUDIO
 Created by: Sofia Salvatori
 License: GPL-3.0
 *******************************/

/*
Configuration
 */
String inputImage = "input-image.png";  // choose image in which you want to hide the audio
String inputAudio = "input-audio.mp3";  // choose the audio to hide
String outputImage = "output-image.png"; // choose the name of the output file (must be png file)


byte audio[] = loadBytes(inputAudio); 
PImage img = loadImage(inputImage);
img.loadPixels();

int indexPixel = 0;
// for each byte of the audio
for (int i=0; i<audio.length; i+=1) {
  // get an audio byte from the array (index i)
  byte audioByte = audio[i];
  // convert it to a binary sequence
  String binaryAudioByte = binary(audioByte, 8);

  // get a pixel from the array of pixels of the image
  int pixel = img.pixels[indexPixel];
  // get the RGB values of the pixel and round them down to integers
  int pixelRed = round(red(pixel));
  int pixelGreen = round(green(pixel));
  int pixelBlue = round(blue(pixel));

  // convert Red to a binary sequence
  String binaryRed = binary(pixelRed, 8);
  // get the first bit of the audio byte
  char audioBit = binaryAudioByte.charAt(0);
  // replace the last bit of the Red bit sequence with the first bit of the audio byte
  String newBinaryRed = binaryRed.substring(0, 7) + audioBit;

  // repeat the process for the the other colors
  String binaryGreen = binary(pixelGreen, 8);
  audioBit = binaryAudioByte.charAt(1);
  String newBinaryGreen = binaryGreen.substring(0, 7) + audioBit;

  String binaryBlue = binary(pixelBlue, 8);
  audioBit = binaryAudioByte.charAt(2);
  String newBinaryBlue = binaryBlue.substring(0, 7) + audioBit;
  
  // convert the new binary colors to integers
  int newPixelRed = unbinary(newBinaryRed);
  int newPixelGreen = unbinary(newBinaryGreen);
  int newPixelBlue = unbinary(newBinaryBlue);
  // use the new colors to make a pixel
  int newPixel = color(newPixelRed, newPixelGreen, newPixelBlue);
  // replace the original pixel in the image with the new one
  img.pixels[indexPixel] = newPixel;

  // move to the next pixel (1 audio byte is hidden in 3 pixels)
  indexPixel += 1;
  
  // repeat the process for the next pixel
  pixel = img.pixels[indexPixel];
  pixelRed = round(red(pixel));
  pixelGreen = round(green(pixel));
  pixelBlue = round(blue(pixel));

  binaryRed = binary(pixelRed, 8);
  audioBit = binaryAudioByte.charAt(3);
  newBinaryRed = binaryRed.substring(0, 7) + audioBit;

  binaryGreen = binary(pixelGreen, 8);
  audioBit = binaryAudioByte.charAt(4);
  newBinaryGreen = binaryGreen.substring(0, 7) + audioBit;

  binaryBlue = binary(pixelBlue, 8);
  audioBit = binaryAudioByte.charAt(5);
  newBinaryBlue = binaryBlue.substring(0, 7) + audioBit;

  newPixelRed = unbinary(newBinaryRed);
  newPixelGreen = unbinary(newBinaryGreen);
  newPixelBlue = unbinary(newBinaryBlue);
  newPixel = color(newPixelRed, newPixelGreen, newPixelBlue);
  img.pixels[indexPixel] = newPixel;
  
  // move to the next pixel (1 audio byte is hidden in 3 pixels)
  indexPixel += 1;

  // repeat the process for the next pixel
  pixel = img.pixels[indexPixel];
  pixelRed = round(red(pixel));
  pixelGreen = round(green(pixel));
  pixelBlue = round(blue(pixel));

  binaryRed = binary(pixelRed, 8);
  audioBit = binaryAudioByte.charAt(6);
  newBinaryRed = binaryRed.substring(0, 7) + audioBit;

  binaryGreen = binary(pixelGreen, 8);
  audioBit = binaryAudioByte.charAt(7);
  newBinaryGreen = binaryGreen.substring(0, 7) + audioBit;

  // use the last bit of the Blue color to tell if the audio in finished
  // 1 = finished
  // 0 = continue
  binaryBlue = binary(pixelBlue, 8);
  if (i == audio.length-1) { 
    newBinaryBlue = binaryBlue.substring(0, 7) + "1";
  } else { 
    newBinaryBlue = binaryBlue.substring(0, 7) + "0";
  }

  newPixelRed = unbinary(newBinaryRed);
  newPixelGreen = unbinary(newBinaryGreen);
  newPixelBlue = unbinary(newBinaryBlue);
  newPixel = color(newPixelRed, newPixelGreen, newPixelBlue);
  img.pixels[indexPixel] = newPixel;
  
  // move to the next group of three pixels (1 audio byte is hidden in 3 pixels)
  indexPixel += 1;
}

// update the image pixels with the modified ones and save the image
img.updatePixels();
img.save(outputImage);
