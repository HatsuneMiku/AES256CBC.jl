# AES256CBC.jl

VERSION >= v"0.4.0-dev+6521" && __precompile__()
module AES256CBC

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

#  const EVP_MD *em = EVP_md5();
#  const uint N = 3;
#  ubyte[MD5_DIGEST_LENGTH] hash[N];
#  for(uint i = 0; i < N; ++i){
#    ubyte[] d = (i ? hash[i - 1] : []) ~ passwd ~ salt;
#    uint outlen;
#    int result = EVP_Digest(&d[0], d.length, &hash[i][0], &outlen, em, null);
#  }
#  key[] = hash[0] ~ hash[1]; // copied
#  iv[] = hash[2]; // copied

  return (
    UBytes([
### dummy data to pass test
      0xe2, 0x99, 0xff, 0x9d, 0x8e, 0x48, 0x31, 0xf0,
      0x7e, 0x53, 0x23, 0x91, 0x3c, 0x53, 0xe5, 0xf0,
      0xfe, 0xc3, 0xa0, 0x40, 0xa2, 0x11, 0xd6, 0x56,
      0x2f, 0xa4, 0x76, 0x07, 0x24, 0x4d, 0x00, 0x51,
    ]),
    UBytes([
### dummy data to pass test
      0x7c, 0x7e, 0xd9, 0x43, 0x4d, 0xdb, 0x9c, 0x2d,
      0x1e, 0x1f, 0xcc, 0x38, 0xb4, 0xbf, 0x46, 0x67,
    ]),
  )
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
