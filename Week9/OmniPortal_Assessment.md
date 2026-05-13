# OMNI-PORTAL ASSESSMENT REPORT
**Operator: Willie ** **Deadline:** April 5 @ 11:59 PM 

## PHASE 1: AUTH BYPASS (SQLi)
* **Payload Used:** [' OR 1=1 --]
* **Result: SUPPORT_TIER_1_SECRET_TOKEN** Successfully bypassed login and obtained 'auth_token' cookie.

## PHASE 2: CLIENT-SIDE HIJACK (XSS)
* **Stored XSS Payload:** [<script>alert(document.cookie)</script>]
* **Secret Cookie Captured:** [SUPPORT_TIER_1_SECRET_TOKEN]

## PHASE 3: API ENUMERATION (BOLA)
* **Insecure Order ID:** [501 ]
* **Confidential Data Leaked:** [{"amount":"$15,000.00","details":"Confidential Server Lease","order_id":501}]

## PHASE 4: THE REMEDIATION
* **Fix for SQLi:** Used parameterized queries. Send the query structure to the database first then send user input separately. The database will treat the input as literal text which will help prevent executing the OR logic. 
* **Fix for XSS:** Output encoding has to be used. Before the server sends data to the browser it needs to convert special characters into "safe" HTML entity equivalents. The browser will be able to display the text for user to read but not execute it as a script.
* **Fix for API BOLA:** Object-level authorization needs to be implemented. The server has to look at the Auth Token and the request of the user. The server will allow for authorization by querying the database to see if the user is the owner of request. 
