# Context

## Project scope

This project serves as an example of how to use Terraform to deploy a simple CRUD API to an AWS environment, using services such as EC2, RDS and CloudWatch, in a way that is repeatable and easily scalable. It requires very little input from the user, and can be deployed and destroyed with a single command. 

## Example application used

The application itself used is a FastAPI application that simulates a backend for a gym membership system, which holds data of members (name, phone number, etc.), plans (type, price, date of creation, etc.) and the subscriptions themselves (member, plan, start date, end date, etc.), in a MySQL database. It can be found at https://github.com/MekhyW/Gym-CRUD

We can suppose a hypothetical scenario where a gym business located in the United States uses a backend to serve several different applications, such as a mobile app for members, an internal app for employees, a website for the business, microsservices for other applications, etc. In this scenario, we suppose that the business chain is considerably successful and although the traffic average is not very high, there are several peaks of high traffic with hundreds of logged members simultaneously and thousands of requests per minute.


# Architecture in the cloud

## Diagram

The following diagram (made using the Brainboard tool https://www.brainboard.co/) shows the architecture created on AWS by the Terraform scripts:

![Architecture](img/Brainboard%20-%20ATFC%20with%20bucket.png)

## Technical decisions

.


# How to use

.


# Cost analysis

## Estimation using AWS calculator

.

## Real cost on worst expected load

.


# Possible improvements

.