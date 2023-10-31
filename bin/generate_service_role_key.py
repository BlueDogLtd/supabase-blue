import sys
import jwt
import datetime

def generate_jwt(secret):
    payload = {
        "role": "service_role",
        "iss": "supabase",
        "iat": datetime.datetime.utcnow(),
        "exp": datetime.datetime.utcnow() + datetime.timedelta(days=45)
    }
    encoded_jwt = jwt.encode(payload, secret, algorithm="HS256")
    return encoded_jwt

if __name__ == "__main__":
    if len(sys.argv) != 2:
        print("Usage: generate_jwt.py <JWT_SECRET>")
        sys.exit(1)
    secret = sys.argv[1]
    print(generate_jwt(secret))

