#!/usr/bin/env python

from argparse import ArgumentParser
from sys import argv
from os import listdir
from os.path import isfile, join
import yaml_helpers as yaml

def main():
    services = ['api']
    shell_arguments = argv[1:]

    write_docker_compose_yaml(*parse_arguments(services, shell_arguments))

def parse_arguments(services, shell_arguments):
    parser = argument_parser(services)
    parsed_arguments = parser.parse_args(shell_arguments)
    parsed_arguments_dict = vars(parsed_arguments)

    mode = parsed_arguments.mode
    services_and_implementations = [
        (s, parsed_arguments_dict[s]) for s in services
    ]

    return mode, services_and_implementations

def argument_parser(services):
    parser = ArgumentParser(
        description='Select an app configuration and write docker-compose.yml'
    )

    parser.add_argument(
        '--mode',
        choices=['debug', 'release'],
        required=True,
        help='whether to run the app in debug or release mode'
    )

    for service in services:
        parser.add_argument(
            f'--{service}',
            choices=service_implementation_choices(service),
            required=True,
            help=f'{service} implementation to include in the app'
        )

    return parser

def service_implementation_choices(service):
    path = service
    return [f for f in listdir(path) if not isfile(join(path, f))]

def write_docker_compose_yaml(mode, services_and_implementations):
    template_yaml = """
    version: '3.7'
    services: {}
    """

    compose_data = yaml.to_data(template_yaml)

    for service, implementation in services_and_implementations:
        service_path = f'{service}/{implementation}/service-{mode}.yml'
        service_yaml = yaml.from_file(service_path)
        service_data = yaml.to_data(service_yaml)
        compose_data['services'][service] = service_data

    compose_yaml = yaml.from_data(compose_data)
    yaml.write_to_file('docker-compose.yml', compose_yaml)

if __name__ == '__main__':
    main()
