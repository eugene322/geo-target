from sys import path

from starlette.config import Config

path.append('/src')

config: Config = Config(env_file='/src/core/.env')
