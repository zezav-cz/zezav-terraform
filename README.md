# Zezav Cloud Infrastructure - Provisioning

![CI Pipeline](https://github.com/zezavcloud/terraform/actions/workflows/checks.yml/badge.svg)

## Introduction

Welcome to the **Zezav Cloud Infrastructure** provisioning repository. This is a personal project used to manage my slowly growing infrastructure, where I host various services for my personal needs. This repository specifically handles the provisioning of cloud resources (such as Hetzner Cloud servers, DNS, and SSH keys) using OpenTofu.

## Getting Started & Development

This project utilizes a modern development stack to ensure consistency and reliability:

- **Mise**: Used for tool versioning and task running.
- **Lefthook**: Used for managing Git hooks.
- **Dagger**: Used for CI/CD pipelines.
- **OpenTofu**: Used as the Infrastructure as Code (IaC) tool.

### Initialization Steps

To get started with development, follow these steps to initialize your environment:

1. Install the required tools using Mise:
   ```bash
   mise install
   ```
2. Install lefthook git hooks:
   ```bash
   lefthook install
   ```
3. Initialize the OpenTofu project:
   ```bash
   mise run init
   ```

### OpenTofu & Mise Tasks

Instead of running `tofu` commands directly, this project uses `mise` tasks to ensure the correct environment and dependencies are used. You can view all available tasks in the `mise.toml` file.

## Repository Structure

Here is a brief overview of the main directories and files in this repository:

- `src/`: Contains all the OpenTofu configuration files (`.tf` files) for provisioning servers, DNS, and SSH keys.
- `mise.toml`: Defines the required tool versions and project tasks.
- `lefthook.yml`: Configuration for pre-commit Git hooks (formatting and linting).
- `dagger.json`: Dagger CI/CD pipeline definitions.

## Usage

Here are a couple of practical examples of how to run OpenTofu tasks within this project:

**Generate an execution plan:**

```bash
mise run plan
```

**Apply the infrastructure changes:**

```bash
mise run apply
```

**Format and lint the code:**

```bash
mise run fmt
mise run lint
```

## Disclaimer

Please note that this is a personal project running on fairly limited resources. It is **not** meant to be a highly available (HA) production setup, but rather a functional environment for personal use and experimentation.

## License

This project is licensed under the [Apache License 2.0](LICENSE).
