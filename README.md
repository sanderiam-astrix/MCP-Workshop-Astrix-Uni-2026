# MCP Workshop Lab Materials

This repository contains the lab materials for the Astrix MCP Workshop. Choose your lab environment based on your setup preferences.

## Lab Choices

You have two main options for participating in the labs:

### Option 1: Astrix-Supplied Lab
Use the hosted lab environment provided by Astrix (runs Docker Compose on a hosted EC2 instance).

### Option 2: Bring Your Own (BYO)
Set up your own lab environment. Three sub-options are available:
- **Claude Desktop + AccuWeather API**: Use Claude Desktop with the AccuWeather developer API
- **Docker Compose**: Use Docker Compose with the Astrix lab configuration
- **Custom Tools**: Bring your own MCP-compatible tools (no advance instructions provided)

## Repository Structure

### Main Directory Files
The files in the main directory (`docker-compose.yml`, `pg-init/`, `pull-ollama-model.sh`) are used by both:
- Astrix-supplied labs (hosted Docker Compose environment)
- BYO Docker Compose labs

### MCP Configuration Files
Two sets of MCP configuration files are provided:

- **`claude-desktop-lab-mcp-config-files/`**: Configuration files for Claude Desktop labs
  - Used by: Claude Desktop + AccuWeather API 

- **`docker-compose-lab-mcp-config-files/`**: Configuration files for Docker Compose labs
  - Used by: Docker Compose labs (both Astrix-supplied and BYO)

Each directory contains both `WORKING` and `SECRETWRAPPED` versions of the configuration files for use during different phases of the workshop.

NOTE: DO NOT USE ANY OF THE DOCKER IMAGES IN A PRODUCTION SETTING. These have been built with the express purpose of demonstrating and insecure, bad state configuration. There is no data worth stealing in them right now, but if you put some there, you're asking for trouble!
