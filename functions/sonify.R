require(stringi)
require(tuneR)
require(seewave)

sonify <- function(name, FUN, atten = T){
  
  freq <- c(1,
            65.41, 73.42, 82.41, 98.00, 110.00,
            130.81, 146.83, 164.81, 196.00, 220.00,
            261.63, 293.66, 329.63, 392.00, 440.00,
            523.25, 587.33, 659.25, 783.99, 880,
            1046.5, 1174.659, 1318.51, 1567.982, 1760,
            2093.005)
  
  FUN <- match.fun(FUN)
  
  name <- tolower(name)
  name <- stri_trans_general(name, id = "Latin-ASCII")
  name <- gsub('[[:punct:] ]+', ' ', name)
  name_letters <- substring(name, 1:nchar(name), 1:nchar(name))
  name_letters <- as.numeric(factor(name_letters, levels = c(" ", letters)))
  name[is.na(name)] <- 1
  
  sound <- vector(mode = "integer")
  
  if(atten){
    attenuate <- seq(0,1,length.out = 22051)[-1]
    attenuate <- rev(exp(attenuate))
    attenuate <- attenuate - 1
    attenuate <- attenuate/max(attenuate)
  } else {
    attenuate = 1
    
  }
  
  
  for( i in 1: length(name_letters)){
    note <- FUN(freq[name_letters[i]], duration = 22050)@left
    note <- note * attenuate
    sound <- c(sound, note)
    
  }
  sound <- Wave(left = sound*32767, samp.rate = 44100, bit=16)
  sound
}