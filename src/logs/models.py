from enum import Enum
from typing import Dict

from pydantic import BaseModel


class LogType(str, Enum):
    user_location = 'user_location'


class Log(BaseModel):
    log_type: LogType
    data: Dict
