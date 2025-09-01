# hiwitv-kiosk

A simple kiosk application for displaying a website on a Raspberry Pi.

## Description

This project provides a reliable way to launch a fullscreen Chromium browser in kiosk mode on a Raspberry Pi. It is configured to display a single, specified URL (e.g., a site hosted on GitHub Pages).

The setup uses a systemd user service to launch the browser, which is a more robust method for modern Raspberry Pi OS versions. A watchdog script is also included to ensure the kiosk browser is always running.

## Configuration

The kiosk URL is set in the `hiwitv-kiosk-browser.service` file. To change the website being displayed:

1.  Open `hiwitv-kiosk-browser.service` in a text editor.
2.  Find the line that starts with `ExecStart=`.
3.  Replace the URL (`https://match-misc.github.io/studitv-kiosk/`) with the URL you want to display.
4.  Save the file and run the `install.sh` script again, or manually copy the service file and restart the Pi.

## Raspberry Pi Kiosk Setup

This section provides instructions for setting up the kiosk on a Raspberry Pi (tested on Pi 5 with Raspberry Pi OS Bookworm).

### Prerequisites

-   Raspberry Pi with Raspberry Pi OS installed and configured.
-   A user named `pi` with sudo privileges.
-   Internet connection.
-   Git installed (`sudo apt-get install git`).

### Installation Steps

1.  **Clone the repository:**

    ```bash
    git clone https://github.com/your-username/hiwitv-kiosk.git
    cd hiwitv-kiosk
    ```

2.  **Run the installation script:**

    This single script will handle everything: set up the browser service and install the watchdog cron job.

    ```bash
    sudo ./install.sh
    ```

3.  **Reboot:**

    After the script finishes, it will ask you to reboot. Once rebooted, the kiosk will start automatically.

## Architecture

-   `hiwitv-kiosk-browser.service`: A systemd **user** service that launches the Chromium browser in kiosk mode. This is the modern approach for GUI applications.
-   `kiosk_watchdog.sh`: A script run by a cron job every minute to ensure the browser service is active.
-   `setup/`: A directory containing the installation scripts for the service and cron job.
-   `install.sh`: The main installation script.

## Troubleshooting

-   **Browser service status (run as pi user):** `systemctl --user status hiwitv-kiosk-browser.service`
-   **Watchdog logs:** `cat /tmp/hiwitv_kiosk_watchdog.log`
