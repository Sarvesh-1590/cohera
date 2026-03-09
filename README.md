# Cohera CRM

![Cohera CRM Dashboard](C:\Users\sarve\.gemini\antigravity\brain\2dede58e-b7c0-420f-a7bc-1547bbed6044\cohera_dashboard_1773158342844.png)

## Topics

1. [Introduction](#introduction)
2. [Documentation](#documentation)
3. [Requirements](#requirements)
4. [Installation & Configuration](#installation-and-configuration)

### Introduction

**Cohera CRM** is a hand-tailored CRM framework built on some of the hottest open-source technologies such as Laravel (a PHP framework) and Vue.js (a progressive Javascript framework).

It features a complete customer lifecycle management solution for SMEs and Enterprises.

It packs in lots of features that will allow your E-Commerce business to scale in no time:

-   Descriptive and Simple Admin Panel.
-   Admin Dashboard.
-   Custom Attributes.
-   Built on Modular Approach.

**For Developers**:
Take advantage of two of the hottest frameworks used in this project -- Laravel and Vue.js -- both of which have been used in Cohera CRM.

### Documentation

Please refer to the internal documentation for Cohera CRM setup and usage guides.

### Requirements

-   **SERVER**: Apache 2 or NGINX.
-   **RAM**: 3 GB or higher.
-   **PHP**: 8.1 or higher
-   **For MySQL users**: 5.7.23 or higher.
-   **For MariaDB users**: 10.2.7 or Higher.
-   **Node**: 8.11.3 LTS or higher.
-   **Composer**: 2.5 or higher

### Installation and Configuration

##### Execute these commands below, in order

```bash
composer create-project
```

-   Find **.env** file in root directory and change the **APP_URL** param to your **domain**.

-   Also, Configure the **Mail** and **Database** parameters inside **.env** file.

```bash
php artisan cohera-crm:install
```

**To execute Cohera**:

##### On server:

Warning: Before going into production mode we recommend you uninstall developer dependencies.
In order to do that, run the command below:

> composer install --no-dev

```text
Open the specified entry point in your hosts file in your browser or make an entry in hosts file if not done.
```

##### On local:

```bash
php artisan route:clear
php artisan serve
```

**How to log in as admin:**

> _http(s)://example.com/admin/login_

```text
email: admin@example.com
password: admin123
```
