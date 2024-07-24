# ANS-C01 Certification Preparation Repository

# ![ANS-C01](https://img.shields.io/badge/ANS--C01-Preparation-blue)

## Overview
Welcome to the ANS-C01 Certification Preparation Repository. This repository contains all the resources, practice exercises, and reference materials I used while preparing for the ANS-C01 certification over the past year.

## Table of Contents
- [Introduction](#introduction)
- [Getting Started](#getting-started)
- [Repository Structure](#repository-structure)
- [Usage](#usage)
- [File Descriptions](#file-descriptions)
- [Contributing](#contributing)
- [License](#license)

## Introduction
This repository is designed to help individuals preparing for the ANS-C01 certification. It includes a variety of study materials, hands-on labs, and reference documents that cover the key topics required for the exam.

## Getting Started
To get started with this repository, you will need to clone it to your local machine and ensure you have the necessary dependencies installed.

### Prerequisites
- Git
- Python 3.x
- AWS CLI

### Installation
1. Clone the repository:
    ```bash
    git clone https://github.com/Macer-Park/macer.github.io.git
    ```
2. Navigate to the project directory:
    ```bash
    cd macer.github.io
    ```
3. Install the required dependencies:
    ```bash
    pip install -r requirements.txt
    ```

## Repository Structure
The repository is organized as follows:
- `/docs`: Documentation and study guides.
- `/exercises`: Hands-on lab exercises.
- `/scripts`: Utility scripts and automation tools.
- `/examples`: Example configurations and setups.
- `/resources`: Additional reference materials.

## Usage
Each section of the repository contains detailed instructions and materials to aid in your study and practice. Here are some key highlights:
- **Docs**: Contains detailed study guides and notes on each topic.
- **Exercises**: Practical exercises to reinforce your understanding.
- **Scripts**: Helpful scripts to automate common tasks.
- **Examples**: Real-world configurations to help understand best practices.

### Example Usage
To run a sample script from the `scripts` directory:
```bash
python scripts/sample_script.py
```

File Descriptions
This section provides a brief description of each file in the repository to help you understand their purpose and usage.

- CDN-CloudFront.yaml: AWS CloudFormation template for setting up Amazon CloudFront.
- GLN-GlobalAccelerator.yaml: AWS CloudFormation template for configuring AWS Global Accelerator.
- NCO-Connection-via-TGW.yaml: AWS CloudFormation template for establishing a connection via AWS Transit Gateway.
- NCO-S2S-VPN-config.sh: Shell script for configuring Site-to-Site VPN.
- NCO-S2S-VPN.yaml: AWS CloudFormation template for setting up Site-to-Site VPN.
- S2SVPN.pcap: Packet capture file for analyzing Site-to-Site VPN traffic.
- pingall.sh: Shell script for pinging all endpoints in a network setup.
- test.jpg: Example image file (purpose not specified).

Using CloudFormation Templates
To deploy a CloudFormation template, use the AWS CLI as follows:
```bash
aws cloudformation create-stack --stack-name my-stack --template-body file://path/to/template.yaml
```

Contributing
Contributions are welcome! If you have any improvements or additional resources to share, please follow these steps:

Fork the repository.
Create a new branch: git checkout -b feature/new-feature.
Make your changes.
Commit your changes: git commit -m 'Add new feature'.
Push to the branch: git push origin feature/new-feature.
Open a pull request.

## License
This project is licensed under the MIT License. See the LICENSE file for details.
