AES256CBC
=========

[AES256CBC](https://github.com/HatsuneMiku/AES256CBC.jl)

AES256CBC encryption with Salted__(8bytes) KEY(32bytes) IV(16bytes)

# Encrypt

```julia
key32iv16 = GetKey32Iv16(Pwd::Array{UInt8, 1}, Salt::Array{UInt8, 1}) # Array{UInt8, 1}
enc = Encrypt(Key32::Array{UInt8, 1}, Iv16::Array{UInt8, 1},
  PlainText::Array{UInt8, 1}) # encripted Array{UInt8, 1}
```


# Acknowledgements

now supports 32bit


# see also

[WCharUTF8](https://github.com/HatsuneMiku/WCharUTF8.jl)
[W32API](https://github.com/HatsuneMiku/W32API.jl)

# status

[![Build Status](https://travis-ci.org/HatsuneMiku/AES256CBC.jl.svg?branch=master)](https://travis-ci.org/HatsuneMiku/AES256CBC.jl)
