from fastapi import FastAPI
from starlette.middleware.cors import CORSMiddleware

from common.views import item_router

app: FastAPI = FastAPI()
app.add_middleware(
    middleware_class=CORSMiddleware,
    allow_origins=['*'], allow_credentials=True,
    allow_methods=['*'], allow_headers=['*'],
)
app.include_router(
    prefix='/api', router=item_router,
)

