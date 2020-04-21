#!/usr/bin/env python

import yaml

service_implementations = {
    'api': 'python3-flask'
}
mode = 'debug'

template_yaml = """
version: '3.7'
services:
  api: {}
"""

def main():
    compose_data = data_from_yaml(template_yaml)

    for service, definition in compose_data['services'].items():
        implementation = service_implementations[service]
        service_path = f'{service}/{implementation}/service-{mode}.yml'
        service_yaml = yaml_from_file(service_path)
        service_data = data_from_yaml(service_yaml)
        definition.update(service_data)

    compose_yaml = yaml_from_data(compose_data)
    write_yaml_to_file('docker-compose.yml', compose_yaml)

def yaml_from_data(data):
    return yaml.dump(data, Dumper=yaml.Dumper)

def data_from_yaml(text):
    return yaml.load(text, Loader=yaml.Loader)

def yaml_from_file(path):
    file = open(path, 'r')
    text = file.read()
    file.close()
    return text

def write_yaml_to_file(path, text):
    file = open(path, 'w')
    file.write(text)
    file.close()

if __name__ == '__main__':
    main()
