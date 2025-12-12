# virtual_environment_automation

This project was inspired by a task where I automated the activation of a Python virtual environment using a simple Bash script (https://github.com/Adedola52/virtual_environment_setup
). In this project, I decided to take it a step further;

**Picture this:** A new employee joins the company, ready to get to work. Every employee is already added as a user on the company server, and they are given the necessary permissions to read, write, and execute files in the setup directory. That means, they can easily access the folders and scripts required for environments activation.

Instead of manually installing dependencies or creating environments from scratch, the team uses a setup script that handles everything. All the employee needs to do is run a simple command in their terminal and include one argument ( the specific environment they want to activate)

## What the script does:
This script supports multiple virtual environments by using an argument-based approach. The user simply provides the environment name as an argument when running the script.

The script then automatically:
- Activates the specified virtual environment
- Installs the required dependencies for that environment

Example environments in this project:

- payments → for payment-related projects
- notification → for emails, notifications, and related projects

Here’s a full breakdown of how it works:
- Checks for python3-venv
    - The script first checks if python3-venv is installed on the system. If it’s missing, the script installs it automatically

- Validates the environment argument
Using conditional statements, the script checks the environment type passed into the command
    - If the environment name matches one of the predefined options in the script, it proceeds
    - If the name is misspelled or not defined in the script, it logs a message asking the user to confirm the environment name and then exits gracefully

- Handles existing vs. new environments.
The script checks whether the environment folder already exists:
    - If it exists: the script simply activates it using source venv_name/bin/activate
    - If it doesn’t exist: the script creates the environment folder, sets it up, and then activates it

- Upgrades the package manager (pip) and installs all dependencies required for the specific environment passed in the argument

- Checks for a .gitignore file inside the environment  
    - If it does not exist, the script automatically creates one and populates it with the standard files and folders that should be ignored

All these steps are written as separate functions, with a main function that orchestrates the entire flow by calling each function in the correct order

## Error Handling
The script is designed to stop immediately when an error occurs.
Using set -e, Bash exits as soon as any command fails, preventing the script from continuing with invalid or incomplete actions.


## Logging

At every key step in the script where an action is performed, a logging statement is included to capture the output of that process. This makes it easier to track what the script is doing and helps with troubleshooting, if anything goes wrong, the log provides a clear trail that makes the issue easier to identify and resolve.
Additionally, colored log messages feature were added to improve readability in the terminal. This helps users quickly differentiate between info messages, success messages, warnings, and errors while the script runs.

## Conclusion

In conclusion, this script ensures:
- **Reusability:** Running the script multiple times does not break anything or create duplicate files. With the use of helper functions in the helper script, it avoids hard-coding and keeps everything flexible
- **Clear structure:** Functions are used to organize the code logically and keep each task separated
- **Condition checks:** Conditional checks help the script decide whether to create resources or skip actions that already exist
- **Helpful logging:** Clear messages are logged at every important step so the user understands what the script is doing
- **Proper error handling:** The script exits immediately when it detects an invalid argument or incorrect input

You can replicate this project by:

- Cloning this repo:
```
git clone 
```
- cd into the directory:
```
cd virtual_environment_automation
```
- Before activating the virtual environment of choice, review the dependencies in requirements.txt. If the listed packages meet your needs, proceed to activate the environment. If not, update requirements.txt first, then activate the environment. Activate the environment using:
```
source setup.sh payments_venv
```

![Alt text](https://github.com/Adedola52/virtual_environment_automation/blob/main/image/env_bootstrapper.png)
