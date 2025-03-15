## Deploying a Node.js Application on AWS EC2

This guide walks you through deploying a Node.js application on an AWS EC2 instance.

### Testing the Project Locally

1.  **Clone the repository:**

    ```bash
    git clone https://github.com/N1T5H/Deploy_NodeJs_in-AWS.git
    cd AWS-Session
    ```

2.  **Set up environment variables:**

    Create a `.env` file in the project root with the following variables:

    ```
    DOMAIN=""
    PORT=3000
    STATIC_DIR="./client"
    PUBLISHABLE_KEY="" # Your Stripe publishable key
    SECRET_KEY=""      # Your Stripe secret key
    ```

    *   **Note:** Obtain your Stripe API keys from the [Stripe dashboard](https://dashboard.stripe.com/).

3.  **Install dependencies and start the project:**

    ```bash
    npm install
    npm run start
    ```

### Setting Up an AWS EC2 Instance

1.  **Create an IAM user:**
    *   Grant the user Admin permissions.
    *   Choose "Password" as the Access Type.
    *   Log in to your AWS Console with the created user.

2.  **Create an EC2 instance:**
    *   Select Ubuntu as the OS image.
    *   Create a new key pair (download the `.pem` file). Keep this file secure!
    *   Choose `t2.micro` as the instance type.

3.  **Connect to the instance via SSH:**

    ```bash
    ssh -i <your_key_pair>.pem ubuntu@<your_ec2_instance_public_ip>
    ```

### Configuring Ubuntu on the Remote VM

1.  **Update packages:**

    ```bash
    sudo apt update
    ```

2.  **Install Git:**

    Follow this [DigitalOcean guide](https://www.digitalocean.com/community/tutorials/how-to-install-git-on-ubuntu-22-04).

3.  **Install Node.js and npm:**

    Follow this [DigitalOcean guide](https://www.digitalocean.com/community/tutorials/how-to-install-node-js-on-ubuntu-22-04).

### Deploying the Project on AWS

1.  **Clone the repository on the remote VM:**

    ```bash
    git clone https://github.com/verma-kunal/AWS-Session.git
    cd AWS-Session
    ```

2.  **Set up environment variables on the remote VM:**

    Create a `.env` file with the same variables as before.

    *   **Important:** Set up an [Elastic IP Address](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/elastic-ip-addresses-eip.html) for your EC2 instance. This Elastic IP will be your `DOMAIN`.

3.  **Install dependencies and start the project:**

    ```bash
    npm install
    npm run start
    ```

4.  **Configure Inbound Rules:**
    *   Edit the security group associated with your EC2 instance to allow traffic on the specified port (e.g., port `3000`).

### Success!

Your Node.js project is now deployed on AWS EC2.  Access it via your Elastic IP address.

Citations:
https://github.com/verma-kunal/AWS-Session.git
