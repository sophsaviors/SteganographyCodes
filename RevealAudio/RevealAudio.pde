/******************************
REVEAL AUDIO
Created by: Sofia Salvatori
License: GPL-3.0
*******************************/

/*
Configuration
*/
String inputImage = "input-image.png";   // choose the image in which the audio is hidden
String outputAudio = "output-audio.mp3"; // choose the output audio name 



PImage img = loadImage(inputImage);
img.loadPixels();
// create a new array list which will contain the bytes composing the audio
// array list needed because of the unknown number of audio bytes
ArrayList<Byte> audio = new ArrayList<Byte>();

// for each group of three pixels (3 pixels contain 1 audio byte)
for (int i=0; i<img.pixels.length; i+=3) {
  // create an empty string which will contain the binary sequence of an audio byte
  String binaryAudioByte = ""; 

  // get the first pixel of the group and its RGB values
  int pixel = img.pixels[i];
  int pixelRed = round(red(pixel));
  int pixelGreen = round(green(pixel));
  int pixelBlue = round(blue(pixel));

  // convert Red to a binary sequence
  String binaryRed = binary(pixelRed, 8);
  // get the last bit of the Red binary sequence
  // and add it to the binary sequence of the audio byte
  binaryAudioByte = binaryAudioByte + binaryRed.charAt(7);

  // repeat the process for the other colors
  String binaryGreen = binary(pixelGreen, 8);
  binaryAudioByte = binaryAudioByte + binaryGreen.charAt(7);

  String binaryBlue = binary(pixelBlue, 8);
  binaryAudioByte = binaryAudioByte + binaryBlue.charAt(7);

  // get the second pixel of the group 
  // repeat the process done for the first pixel
  pixel = img.pixels[i + 1];
  pixelRed = round(red(pixel));
  pixelGreen = round(green(pixel));
  pixelBlue = round(blue(pixel));

  binaryRed = binary(pixelRed, 8);
  binaryAudioByte = binaryAudioByte + binaryRed.charAt(7);

  binaryGreen = binary(pixelGreen, 8);
  binaryAudioByte = binaryAudioByte + binaryGreen.charAt(7);

  binaryBlue = binary(pixelBlue, 8);
  binaryAudioByte = binaryAudioByte + binaryBlue.charAt(7);

  // get the third pixel of the group
  // repeat the process done for the two pixels before
  pixel = img.pixels[i + 2];
  pixelRed = round(red(pixel));
  pixelGreen = round(green(pixel));
  pixelBlue = round(blue(pixel));

  binaryRed = binary(pixelRed, 8);
  binaryAudioByte = binaryAudioByte + binaryRed.charAt(7);

  binaryGreen = binary(pixelGreen, 8);
  binaryAudioByte = binaryAudioByte + binaryGreen.charAt(7);
  
  // convert the 8 bits of the audio byte to its decimal value
  byte audioByte = byte(unbinary(binaryAudioByte));
  // add the audio byte to the audio array list 
  audio.add(audioByte);

  // use Blue of the third pixel to check if the audio is finished
  // 0 = continue
  // 1 = finished
  binaryBlue = binary(pixelBlue, 8);
  if (binaryBlue.charAt(7) == '1') {
    break; // stop immediately the for cycle
  }
}

// create an array of bytes long as the array list 
byte audioBytes[] = new byte[audio.size()];
// copy all the bytes from the array list to the array
for (int i=0; i<audio.size(); i+=1) {
  audioBytes[i] = audio.get(i);
}

// save the hidden audio
saveBytes(outputAudio, audioBytes);
