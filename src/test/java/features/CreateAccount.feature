 #  Activity
    #Send request to /api/accounts/add-primary-account
    # Status should be 201 and response contain email entity
 @Regression
 Feature: Create Account Feature
   @NewAccount_1
   Scenario: Create new account
     Given url BASE_URL
     Given path "/api/accounts/add-primary-account"
     * def email = "mohammad_instructor2517@tekschool.us"
     Given request
        """
        {
          "email": "#(email)",
          "firstName": "Crystal",
          "lastName": "Marry",
          "title": "Ms.",
          "gender": "Female",
          "maritalStatus": "Single",
          "employmentStatus": "Software Developer",
          "dateOfBirth": "1989-03-12"
        }
        """
     When method post
     Then print response
     Then status 201
     Then assert response.email == email
     * def createdAccountId = response.id
     * def tokenGenerationResult = callonce read('GenerateSupervisorToken.feature')
     * def validToken = "Bearer " + tokenGenerationResult.response.token
     Given path "/api/accounts/delete-account"
     Given param primaryPersonId = createdAccountId
     Given header Authorization = validToken
     When method delete
     Then status 202