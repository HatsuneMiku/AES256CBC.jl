module AES256CBC

function GetKey32Iv16(Pwd::Array{UInt8, 1}, Salt::Array{UInt8, 1})
  return Array{UInt8, 1}([
    0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
    0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
    0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
  ])
end

function Encrypt(Key32::Array{UInt8, 1}, Iv16::Array{UInt8, 1},
  PlainText::Array{UInt8, 1})

  return Array{UInt8, 1}([
    0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
  ])
end

end
