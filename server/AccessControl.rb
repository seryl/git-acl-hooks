class String
  def starts_with?(prefix)
    prefix = prefix.to_s
    self[0, prefix.length] == prefix
  end
end

def create_acl_map(acl_file)
  acl_file = File.read(acl_file).split("\n")\
    .reject { |line| line == '' or
    line.starts_with? "#" or
    line.starts_with? "[" }
  access = Hash.new
  
  current_match = nil
  current_access = nil
  acl_file.each do |line|
    read_len = line.index('#')
    if read_len.nil?
        read_len = line.length
    end

    if line.starts_with? "match = "
      current_match = line[8..read_len]
      access[current_match] = Hash.new
      re = /#{current_match}/
      access[current_match]["regex"] = re
      
    elsif line.starts_with? "access = "
      current_access = line[9..read_len]
      access[current_match][current_access] = Hash.new
      access[current_match][current_access] = ['*']
       
    elsif line.starts_with? "users = "
      users = line[8..read_len].split(" ")
      if current_access and current_match
        access[current_match][current_access] = Hash.new
        access[current_match][current_access] = users
      end
    end
  end
  access
end

