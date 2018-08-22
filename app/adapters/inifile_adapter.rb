class InifileAdapter
  def load_data(path)
    parse_data(read_data(path))
  end

  def save_data(path, data)
    write_data(path, data)
  end

  private

  def parse_data(data)
    IniParse.parse(data)
  end

  def read_data(path)
    File.read(path)
  rescue Errno::ENOENT
    raise ScanResults::DataNotFound
  end

  def write_data(path, data)
    File.open(path, 'w+') do |file|
      file.write(data)
    end
  end
end
