USE DATABASE LA_DB;
USE SCHEMA LA_SCHEMA;


-- Step 1: Create a secret to securely store GitHub credentials

CREATE OR REPLACE SECRET my_github_secret
  TYPE = PASSWORD
  USERNAME = 'Learn.Anywhere1'
  PASSWORD = '';

 
 -- Step 2: Create API Integration for Git
 
CREATE OR REPLACE API INTEGRATION  learn_git
    API_PROVIDER = git_https_api
    -- allowed orgs and repositories
    API_ALLOWED_PREFIXES = ('https://github.com/LearnAnywhere1')    
    ENABLED = TRUE         -- -- Enable the integration
    allowed_authentication_secrets = (my_github_secret);

-- Step 3: Verify API integrations

    SHOW API INTEGRATIONS;


-- Step 4: Create a Git Repository object in Snowflake

    CREATE OR REPLACE GIT REPOSITORY  git_integration_demo1
    API_INTEGRATION = learn_git
    ORIGIN = 'https://github.com/LearnAnywhere1/SNOW.git';

-- Step 5: List contents of the Git branch

LS @git_integration_demo1/branches/main;

-- Step 6: Execute SQL script directly from Git repository

EXECUTE IMMEDIATE FROM @git_integration_demo/branches/main/sample_new;

