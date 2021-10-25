from users.repo import Repo
from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware
import uvicorn
from pydantic import BaseModel

class User(BaseModel):
    firstname: str
    lastname: str

app = FastAPI()
app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

@app.get("/")
async def get():
    return "basic rest api"

@app.get("/users")
async def get_users():
    return Repo.get_users()

@app.get("/users/{user_id}")
async def get_user(user_id):
    return Repo.get(user_id)

@app.post("/users")
async def add_user(user: User):
    user = Repo.add(user.firstname, user.lastname)
    return user 


if __name__ == "__main__":
    uvicorn.run(app)