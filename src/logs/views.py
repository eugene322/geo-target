from typing import Dict

from fastapi import APIRouter

from logs.models import Log

log_router = APIRouter()

LOG_URL: str = '/logs/'


@log_router.post(path=LOG_URL)
def send_log(log_data: Log) -> Dict:
    print(log_data)
    return log_data.dict()
