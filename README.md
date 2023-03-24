# Cleverlance App – Image Feature


## BDD Specs

### Story: Customer requests to see image

### Narrative #1

> As an online customer
I want the app to load an image
So I can view it

#### Scenarios (Acceptance criteria)

```
Given the customer has connectivity
And the customer inputs a correct username/password
When the customer requests to see the image
Then the app should display the image from remote

Given the customer has connectivity
And the customer inputs an incorrect username/password
When the customer requests to see the image
Then the app should display an error message

Given the customer doesn't have connectivity
When the customer requests to see the image
Then the app should display an error message
```


## Use Cases

### Load Image Data From Remote Use Case

#### Data:
- URL
- Username
- Password

#### Primary course (happy path):
1. Execute "Load Image Data" command with above data.
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
