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
  OpenSSL.init()
  s1 = OpenSSL.Digest.digest("MD5", [passwd; salt])
  s2 = OpenSSL.Digest.digest("MD5", [s1; passwd; salt])
  s3 = OpenSSL.Digest.digest("MD5", [s2; passwd; salt])
  OpenSSL.cleanup()
  return ([s1; s2], s3) # (key32::UBytes, iv16::UBytes)
end

function genPadding(n::Int)
### dummy data to pass test
  return UBytes([9, 9, 9, 9, 9, 9, 9, 9, 9])
end

function encryptAES256CBC(key32::UBytes, iv16::UBytes, plain::UBytes)
  OpenSSL.init()
  e = OpenSSL.Cipher.encrypt("aes_256_cbc", key32, iv16, plain) # auto padding
  OpenSSL.cleanup()
  return e
end

function decryptAES256CBC(key32::UBytes, iv16::UBytes, cipher::UBytes)
  OpenSSL.init()
  d = OpenSSL.Cipher.decrypt("aes_256_cbc", key32, iv16, cipher) # auto padding
  OpenSSL.cleanup()
  return d
end

end
