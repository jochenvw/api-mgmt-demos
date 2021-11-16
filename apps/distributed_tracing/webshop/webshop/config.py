import os
import dotenv

dotenv.load_dotenv()


class Config:
    SHIPMENTS_ENDPOINT = os.environ.get("SHIPMENTS_ENDPOINT")
    PAYMENTS_ENDPOINT = os.environ.get("PAYMENTS_ENDPOINT")
    APPINSIGHTS_CONNECTION_STRING = os.environ.get(
        "APPINSIGHTS_CONNECTION_STRING")
