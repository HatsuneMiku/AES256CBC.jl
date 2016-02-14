AES256CBC
=========

[AES256CBC](https://github.com/HatsuneMiku/AES256CBC.jl)

AES256CBC encryption with Salted__(8bytes) KEY(32bytes) IV(16bytes)

It requires bug fixed OpenSSL.jl (branch _dev_aes256cbc) .

```julia
Pkg.clone("https://github.com/HatsuneMiku/OpenSSL.jl/tree/_dev_aes256cbc")
Pkg.test("OpenSSL")
Pkg.clone("https://github.com/HatsuneMiku/AES256CBC.jl")
Pkg.test("AES256CBC")
```


# functions and KEY/IV

```julia
# (key32, iv16) = genKey32Iv16(passwd, salt)
#   input:
#     passwd (any bytes) (from command line)
#     salt (8 bytes) (from Salted__????????)
#   process:
#     s1 = md5(passwd + salt)      (16 bytes)
#     s2 = md5(s1 + passwd + salt) (16 bytes)
#     s3 = md5(s2 + passwd + salt) (16 bytes)
#   output:
#     key32 = s1 + s2 (32 bytes)
#     iv16 = s3 (16 bytes)

UBytes string2bytes(s::AbstractString)
UBytes genRandUBytes(n::Int)
(UBytes, UBytes) genKey32Iv16(passwd::UBytes, salt::UBytes)
UBytes genPadding(n::Int)
UBytes encryptAES256CBC(key32::UBytes, iv16::UBytes, plain::UBytes)
UBytes decryptAES256CBC(key32::UBytes, iv16::UBytes, cipher::UBytes)
```


# Encrypt/Decrypt

```julia
using AES256CBC
# typealias UBytes Array{UInt8, 1}
plain = string2bytes("Message") # UBytes
passwd = string2bytes("Secret Passphrase") # UBytes
salt = genRandUBytes(8) # UBytes
(key32, iv16) = genKey32Iv16(passwd, salt) # (UBytes, UBytes)
encoded = encryptAES256CBC(key32, iv16, plain) # UBytes
decoded = decryptAES256CBC(key32, iv16, encoded) # UBytes
```


# Acknowledgements

now supports 32bit


# see also

[WCharUTF8](https://github.com/HatsuneMiku/WCharUTF8.jl)

[W32API](https://github.com/HatsuneMiku/W32API.jl)

[OpenSSL _dev_aes256cbc](https://github.com/HatsuneMiku/OpenSSL.jl/tree/_dev_aes256cbc)

[OpenSSL](https://github.com/HatsuneMiku/OpenSSL.jl)

[dirk OpenSSL](https://github.com/dirk/OpenSSL.jl)


# status

[![Build Status](https://travis-ci.org/HatsuneMiku/AES256CBC.jl.svg?branch=master)](https://travis-ci.org/HatsuneMiku/AES256CBC.jl)
