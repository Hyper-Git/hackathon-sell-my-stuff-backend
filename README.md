# Sell My Stuff Backend

Sell My Stuff Backend is a Python FastAPI service that analyzes product images and generates optimized sales listings using AWS Bedrock's Claude Sonnet 4 model. Perfect for creating compelling marketplace descriptions and price suggestions.

## Features

- 📸 Analyze product images via base64 upload
- 🤖 Generate detailed, sales-optimized descriptions using Claude Sonnet 4
- 💰 Get realistic price suggestions based on item condition and market value
- 🚀 FastAPI with automatic OpenAPI documentation
- ☁️ AWS Bedrock integration for AI processing
- 🐍 Python 3.13 with modern async/await patterns
- 🧪 Comprehensive test suite with pytest

## Frontend Project

This is the backend API for the Sell My Stuff application. The frontend React application can be found at:

- **Frontend Repository**: [Sell My Stuff - Frontend](https://github.com/breakintocloud/hackathon-sell-my-stuff-frontend)

The frontend provides a user-friendly interface for uploading images and displaying the AI-generated sales listings created by this backend service.

## Getting Started

### Prerequisites

- Python 3.13+
- pipenv
- AWS Account with Bedrock access

### 1. Clone the repository
```bash
git clone https://github.com/breakintocloud/sell-my-stuff-backend.git
cd sell-my-stuff-backend
```

### 2. Install dependencies
```bash
pipenv install --dev
```

### 3. Set up AWS credentials
Configure your AWS credentials to access Bedrock:
```bash
aws configure
```

### 4. Start the development server
```bash
pipenv run uvicorn sell_my_stuff.main:app --reload
```

Open [http://localhost:8000](http://localhost:8000) to view the API documentation.

### 5. Run tests
```bash
pipenv run pytest
```

## API Usage

### Analyze Image Endpoint

**POST** `/listings/analyze`

Analyze a product image and get a sales-optimized description and price suggestion.

**Request Body:**
```json
{
  "image": "base64_encoded_image_data"
}
```

**Response:**
```json
{
  "success": true,
  "message": "Image analyzed successfully",
  "description": "Beautiful vintage leather jacket in excellent condition...",
  "suggested_price": "$80 - $120"
}
```

### Example with curl:
```bash
curl -X POST "http://localhost:8000/listings/analyze" \
  -H "Content-Type: application/json" \
  -d '{"image": "iVBORw0KGgoAAAANSUhEUgAA..."}'
```

## Deployment

### AWS Lambda
The project includes a Lambda handler for serverless deployment:

```python
sell_my_stuff.lambda_handler.handler
```

## Tech Stack
- [FastAPI](https://fastapi.tiangolo.com/) - Modern, fast web framework
- [AWS Bedrock](https://aws.amazon.com/bedrock/) - Claude Sonnet 4 for image analysis
- [Pydantic](https://pydantic.dev/) - Data validation and settings management
- [Mangum](https://mangum.io/) - ASGI adapter for AWS Lambda
- [pytest](https://pytest.org/) - Testing framework
- [moto](https://docs.getmoto.org/) - AWS service mocking for tests

## Project Structure
```
sell_my_stuff/
├── api/
│   ├── endpoints/          # API route handlers
│   └── models/            # Pydantic models
├── main.py               # FastAPI application
└── lambda_handler.py     # AWS Lambda entry point
```

## License
MIT
