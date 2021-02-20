from pytest import fixture
from starlette.testclient import TestClient

from core.main import app


@fixture
def client() -> TestClient:
    return TestClient(app=app)
