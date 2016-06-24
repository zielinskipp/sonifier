# Sonifier


### What is it?

This Shiny app is a final project in **Developing Data Products** course on
**Coursera.org** platform. 

It's not really much about data itself. It takes your name as an input and
sonify it. It basically assigns frequencies to letters and generates a sequence
of sound based on these frequencies. 

### Input

The app allows to control 2 parametes:
* Text, that will be sonified
* Type of signal to be generated. The functions used comes form turnR package

Sonify!! button runs the script. When generated, the file can be downloaded in 
*.wav* format. 

### Output:

After generation of a file the audio tag should appear. In not visible after few
seconds since clicking the button, try to use differen browser (
I was not working on Safari and sometimes Firefox didn't displayed audiotag).

Underneath the audiotag, spectrogram of the sonified version of the input will be
displayed.

### In between

For every letter, specific frequency is assigned. The frequencies come
form C-major pentatonic scale. Character *a* is the lowest frequency and with
every letter the frequency increases. There is no difference between upper and lower
case characters. The spaces, punctuation and numbers are interpreted as pauses, however
this effect is achieved by assigning low frequency beyond human hearing range.
Diacritic charactes are translated to the closest letter in `letters` vecotr.

The are 4 possible waveforms:
* Sine wave
* Pulse wave
* Sawtooth wave
* Square wave

### Resources

 Sueur J., Aubin T., Simonis C. (2008). Seewave: a free modular tool for sound analysis and
  synthesis. Bioacoustics, 18: 213-226
  
   Uwe Ligges, Sebastian Krey, Olaf Mersmann, and Sarah Schnackenberg (2013). tuneR: Analysis of
  music. URL: http://r-forge.r-project.org/projects/tuner/.
  
  Winston Chang, Joe Cheng, JJ Allaire, Yihui Xie and Jonathan McPherson (2016). shiny: Web
  Application Framework for R. R package version 0.13.2. http://CRAN.R-project.org/package=shiny
  
  Gagolewski M., Tartanus B. (2015). R package stringi: Character string processing facilities.
  http://stringi.rexamine.com/. DOI:10.5281/zenodo.19071
