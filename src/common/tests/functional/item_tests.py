from requests import Response
from starlette.testclient import TestClient

from common.views import ITEM_URL
from core.tests.constants import API_URL


def test_items_get_200(client: TestClient) -> None:
    response: Response = client.get(url=f'{API_URL}{ITEM_URL}')
    assert response.status_code == 200
    assert response.json() == {}
