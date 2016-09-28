# Spring Boot based REST service with Spring Security OAuth2

This is a simple REST service that provides a single RESTful endpoint protected by OAuth 2.

## How to build and run

Just run with maven

```
mvn clean package spring-boot:run
```

## How to use

Open http://localhost:8080/greeting in your browser or some HTTP client (like a Postman).

You receive the following JSON response, which indicates you are not authorized to access the resource:

```
{
  "error": "unauthorized",
  "error_description": "An Authentication object was not found in the SecurityContext"
}
```

In order to access the protected resource, you must first request an access token via the OAuth. 
Request OAuth authorization:

```
curl -X POST -vu clientapp:123456 http://localhost:8080/oauth/token -H "Accept: application/json" -d "password=spring&username=admin&grant_type=password&scope=read%20write&client_secret=123456&client_id=clientapp"
```

A successful authorization results in the following JSON response:

```
{
  "access_token": "ff16372e-38a7-4e29-88c2-1fb92897f558",
  "token_type": "bearer",
  "refresh_token": "f554d386-0b0a-461b-bdb2-292831cecd57",
  "expires_in": 43199,
  "scope": "read write"
}
```

Use the access_token returned in the previous request to make the authorized request to the protected endpoint:

```
curl http://localhost:8080/greeting -H "Authorization: Bearer ff16372e-38a7-4e29-88c2-1fb92897f558"
```

If the request is successful, you will see the following JSON response:

```
{
  "id": 1,
  "content": "Hello, Roy!"
}
```

After the specified time period, the access_token will expire. Use the refresh_token that was returned in the original OAuth authorization to retrieve a new access_token:

```
curl -X POST -vu clientapp:123456 http://localhost:8080/oauth/token -H "Accept: application/json" -d "grant_type=refresh_token&refresh_token=f554d386-0b0a-461b-bdb2-292831cecd57&client_secret=123456&client_id=clientapp"
```
