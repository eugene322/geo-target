from typing import Dict

from fastapi import APIRouter

item_router = APIRouter()

ITEM_URL: str = '/items/'


@item_router.get(path=ITEM_URL)
def read_items() -> Dict:
    return {}
