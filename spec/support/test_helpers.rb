def random_string(length = 20)
  (0..length).map{ rand(36).to_s(36) }.join
end