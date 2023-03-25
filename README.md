# Cleverlance App – Sign In Feature


## BDD Specs

### Story: Customer requests to sign in

### Narrative #1

> As an online customer
I want the app to let me sign in
So I can view the image

#### Scenarios (Acceptance criteria)

```
Given the customer has connectivity
And the customer inputs a correct username/password
When the customer requests to sign in
Then the app should display the image from remote

Given the customer has connectivity
And the customer inputs an incorrect username/password
When the customer requests to sign in
Then the app should display an error message

Given the customer doesn't have connectivity
When the customer requests to sign in
Then the app should display an error message
```


## Use Cases

### Sign In Use Case

#### Data:
- URL
- Username
- Password

#### Primary course (happy path):
1. Execute "SignIn" command with above data.
2. System downloads data from the URL.
3. System process downloaded data.
4. System delivers image data.

#### Cancel course:
1. System does not deliver image data nor error.

#### Invalid data – error course (sad path):
1. System delivers invalid data error.

#### No connectivity – error course (sad path):
1. System delivers connectivity error.

---

## Model Specs

### Image

| Property      | Type                |
|---------------|---------------------|
| `data`        | `Data`              |

### Payload contract

- Username is sent in the body of the message as POST parameter with key username.
- Password must be hashed with SHA-1 and sent in a header field named
authorization.
- The response contains Base64-encoded picture.

```
POST /download/bootcamp/image.php HTTP/1.1
Authorization: 27d941d0a9d7be4441961c164847186841da68c6
Content-Type: application/x-www-form-urlencoded
Host: mobility.cleverlance.com
```
