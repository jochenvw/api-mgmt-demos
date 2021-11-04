import os
import dotenv

dotenv.load_dotenv()


class Config:
    PAYMENTS_ENDPOINT = os.environ.get("PAYMENTS_ENDPOINT")
    APPINSIGHTS_CONNECTION_STRING = os.environ.get(
        "APPINSIGHTS_CONNECTION_STRING")
