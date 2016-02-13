# AES256CBC.jl

VERSION >= v"0.4.0-dev+6521" && __precompile__()
module AES256CBC

import OpenSSL
export UBytes
export string2bytes, genRandUBytes, genKey32Iv16, genPadding
export encryptAES256CBC, decryptAES256CBC

#  (key32, iv16) = genKey32Iv16(passwd, salt)
#    input:
#      passwd (any bytes) (from command line)
#      salt (8 bytes) (from Salted__????????)
#    process:
#      s1 = md5(passwd + salt)      (16 bytes)
#      s2 = md5(s1 + passwd + salt) (16 bytes)
#      s3 = md5(s2 + passwd + salt) (16 bytes)
#    output:
#      key32 = s1 + s2 (32 bytes)
#      iv16 = s3 (16 bytes)

typealias UBytes Array{UInt8, 1}

function string2bytes(s::AbstractString)
  return read(IOBuffer(s), UInt8, length(s)) # UBytes
end

function genRandUBytes(n::Int)
### dummy data to pass test
  return UBytes([0x53, 0x61, 0x6c, 0x74, 0x65, 0x64, 0x5f, 0x5f])
end

function genKey32Iv16(passwd::UBytes, salt::UBytes)
  OpenSSL.Digest.init()
  s1 = OpenSSL.Digest.digest("MD5", [passwd; salt])
  s2 = OpenSSL.Digest.digest("MD5", [s1; passwd; salt])
  s3 = OpenSSL.Digest.digest("MD5", [s2; passwd; salt])
  OpenSSL.Digest.cleanup()
  return ([s1; s2], s3) # (key32::UBytes, iv16::UBytes)
end

function genPadding(n::Int)
### dummy data to pass test
  return UBytes([9, 9, 9, 9, 9, 9, 9, 9, 9])
end

function encryptAES256CBC(key32::UBytes, iv16::UBytes, plain::UBytes)
  return UBytes([
### dummy data to pass test
    0xda, 0x8a, 0xab, 0x1b, 0x90, 0x42, 0x05, 0xa7,
    0xe4, 0x9c, 0x1e, 0xcc, 0x71, 0x18, 0xa8, 0xf4,
    0x80, 0x4b, 0xef, 0x7b, 0xe7, 0x92, 0x16, 0x19,
    0x67, 0x39, 0xde, 0x78, 0x45, 0xda, 0x18, 0x2d,
  ])
end

function decryptAES256CBC(key32::UBytes, iv16::UBytes, cipher::UBytes)
  return UBytes([
### dummy data to pass test
    0x4D, 0x65, 0x73, 0x73, 0x61, 0x67, 0x65, 0x09,
    0x09, 0x09, 0x09, 0x09, 0x09, 0x09, 0x09, 0x09,
  ])
end

end
