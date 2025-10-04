from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware

from sell_my_stuff.api.api import router

app = FastAPI(title="Sell My Stuff", description="Analyze items and generate sales listings")

# Add CORS middleware with explicit configuration
app.add_middleware(
    CORSMiddleware,
    allow_origins=[
        "https://due1iq48gx435.cloudfront.net",
        "http://localhost:5173",
        "http://localhost:3000",
    ],
    allow_credentials=True,
    allow_methods=["GET", "POST", "PUT", "DELETE", "OPTIONS"],
    allow_headers=["Content-Type", "x-api-key", "Authorization"],
)

@app.get("/")
async def root():
    return {"message": "Sell My Stuff API - Use /listings/analyze to analyze images"}

app.include_router(router)