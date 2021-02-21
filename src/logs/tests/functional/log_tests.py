from typing import Dict

from requests import Response
from starlette.testclient import TestClient

from logs.views import LOG_URL
from core.tests.constants import API_URL


def test_log_sended(client: TestClient) -> None:
    log_data: Dict = {
        'log_type': 'user_location',
        'data': {'lat': 99, 'long': 10}
    }
    response: Response = client.post(url=f'{API_URL}{LOG_URL}', json=log_data)
    assert response.status_code == 201
    assert response.json() == log_data
