# hamming_error
A simple forward error correcting (FEC) scheme, based upon the least Hamming distance principle is implemented in verilog. FEC is a coding scheme, where error in a transmitted bit string can be corrected at the receiver end, without referring it back to the transmitter. Hamming distance between the two unmatched sequences is defined as the number of unmatched digits between two bit sequences of equal length. There are two modules. Encoder module and decoder module.\\
**Encoder module:** Generate desired codeword for a dataword, performed by module enc
**Decoder module:** Spotting the error and finding the codeword from a received word, performed by module dec
