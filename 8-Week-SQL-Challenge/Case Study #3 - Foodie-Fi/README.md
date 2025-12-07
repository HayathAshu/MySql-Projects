# 🍽️ 8 Week SQL Challenge - Case Study #3: Foodie-Fi

## 📘 About the Project

This project is part of the **[#8WeekSQLChallenge](https://8weeksqlchallenge.com/)** by **Danny Ma**, focusing on developing strong SQL and analytical thinking skills through real-world business problems.

In **Case Study #3 - Foodie-Fi**, the fictional company provides a **subscription-based streaming platform for food videos**. The aim of this project is to explore customer onboarding journeys, subscription patterns, upgrade/downgrade behavior, churn analysis, and payment simulations.

---

## 🧠 Problem Statement

Foodie-Fi offers different subscription plans, and management wants to:
1. Understand customer behavior and onboarding journeys.
2. Measure churn and retention rates.
3. Identify upgrade trends to higher plans.
4. Simulate a 2020 payments table based on given business rules.

---

## 🗂️ Dataset Overview

The case study contains **two key tables**:

### **1️⃣ plans**
| Column Name | Description |
|--------------|-------------|
| plan_id | Unique ID for each subscription plan |
| plan_name | Type of plan (trial, basic monthly, pro monthly, annual, churn) |
| price | Price of the plan in USD |

### **2️⃣ subscriptions**
| Column Name | Description |
|--------------|-------------|
| customer_id | Unique customer identifier |
| plan_id | Customer’s subscribed plan ID |
| start_date | Date when the customer started the plan |
