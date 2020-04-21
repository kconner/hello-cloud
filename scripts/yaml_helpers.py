import yaml

def from_data(data):
    return yaml.dump(data, Dumper=yaml.Dumper)

def to_data(text):
    return yaml.load(text, Loader=yaml.Loader)

def from_file(path):
    file = open(path, 'r')
    text = file.read()
    file.close()
    return text

def write_to_file(path, text):
    file = open(path, 'w')
    file.write(text)
    file.close()

