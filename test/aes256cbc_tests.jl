# aes256cbc_tests.jl

import AES256CBC
using Formatting
using Base.Test

test_pwd = "Secret Passphrase"
test_salt = "a3e550e89e70996c" # must be random UBytes by genRandUBytes(8)
expected_k = "e299ff9d8e4831f07e5323913c53e5f0fec3a040a211d6562fa47607244d0051"
expected_i = "7c7ed9434ddb9c2d1e1fcc38b4bf4667" # initial value

test_data = [
  ( # test short
    "Message", # auto padding
    "da8aab1b904205a7e49c1ecc7118a8f4",
    "da8aab1b904205a7e49c1ecc7118a8f4", # last iv
  ),( # test long
    "Message\t\t\t\t\t\t\t\t\t", # with self padding
    "da8aab1b904205a7e49c1ecc7118a8f4804bef7be79216196739de7845da182d",
    "804bef7be79216196739de7845da182d", # last iv
  )]

@test AES256CBC.string2bytes("abC") == AES256CBC.UBytes([0x61, 0x62, 0x43])
println(format("genPadding(0) == [{:s}]", AES256CBC.genPadding(0)))
@test AES256CBC.genPadding(1) == AES256CBC.UBytes([1])
@test AES256CBC.genPadding(5) == Array{UInt8, 1}([5, 5, 5, 5, 5])
@test AES256CBC.genPadding(9) == Array{UInt8, 1}([9, 9, 9, 9, 9, 9, 9, 9, 9])
println(format("genPadding(16) == [{:s}]", AES256CBC.genPadding(16)))
salt = AES256CBC.genRandUBytes(8)
println(format("genRandUBytes(8) == [{:s}]", bytes2hex(salt)))
salt = AES256CBC.genRandUBytes(8)
println(format("genRandUBytes(8) == [{:s}]", bytes2hex(salt)))
salt = AES256CBC.genRandUBytes(8)
println(format("genRandUBytes(8) == [{:s}]", bytes2hex(salt)))
salt = hex2bytes(test_salt) # replace for test
println(format("salt[{:s}]", bytes2hex(salt)))
(key32, iv16) = AES256CBC.genKey32Iv16(AES256CBC.string2bytes(test_pwd), salt)
println(format("key32[{:s}]\niv16[{:s}]", bytes2hex(key32), bytes2hex(iv16)))
@test key32 == hex2bytes(expected_k)
@test iv16 == hex2bytes(expected_i)

for (i, (test_plain, expected_enc, expected_liv)) in enumerate(test_data)
  println(i)
  # i == 1 && begin println("*** skip ***"); continue end # skip short test

  encoded = AES256CBC.encryptAES256CBC(key32, iv16,
    AES256CBC.string2bytes(test_plain))
  println(format("encoded[{:s}]", bytes2hex(encoded)))
  @test encoded == hex2bytes(expected_enc)
  decoded = AES256CBC.decryptAES256CBC(key32, iv16, encoded)
  println(format("decoded[{:s}]", bytes2hex(decoded)))
  @test decoded == AES256CBC.string2bytes(test_plain)
  println(format("decoded[{:s}]", bytestring(decoded)))
  @test bytestring(decoded) == test_plain
end
