# Function to create a directory if it doesn't exist
function Create-Directory {
    param (
        [string]$Path
    )
    if (-Not (Test-Path -Path $Path)) {
        New-Item -ItemType Directory -Path $Path
        Write-Output "Created directory: $Path"
    } else {
        Write-Output "Directory already exists: $Path"
    }
}

# Function to create the .git-templates directory
function Create-GitTemplatesDirectory {
    $gitTemplatesPath = "$env:userprofile\.git-templates"
    Create-Directory -Path $gitTemplatesPath
    return $gitTemplatesPath
}

# Function to create the hooks subdirectory
function Create-HooksDirectory {
    param (
        [string]$GitTemplatesPath
    )
    $hooksPath = "$GitTemplatesPath\hooks"
    Create-Directory -Path $hooksPath
    return $hooksPath
}

# Function to create the commit-msg file with the specified content
function Create-CommitMsgFile {
    param (
        [string]$HooksPath
    )
    $commitMsgPath = "$HooksPath\commit-msg"
    $commitMsgContent = @'
#!/bin/sh

# Get the commit message
commit_message=$(cat "$1")

echo "Commit Message is: $commit_message"

# Define the regex pattern
pattern="^[A-Z][0-9]{4}[A-Z]{2}-[0-9]+ - "

# Check if the commit message matches the pattern
if echo "$commit_message" | grep -Eq "$pattern"; then
    exit 0
else
    echo "Error: Commit message must start with a string matching the pattern 'C1234CS-5678 - <your commit message>'"
    exit 1
fi
'@

    Set-Content -Path $commitMsgPath -Value $commitMsgContent -Force
    Write-Output "Created file: $commitMsgPath with content"
}

# Main function to orchestrate the creation of directories and file
function Main {
    $gitTemplatesPath = Create-GitTemplatesDirectory
    $hooksPath = Create-HooksDirectory -GitTemplatesPath $gitTemplatesPath
    Create-CommitMsgFile -HooksPath $hooksPath
}

# Call the main function
Main
