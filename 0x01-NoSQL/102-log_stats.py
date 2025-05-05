#!/usr/bin/env python3
"""
This script provides stats about the Nginx logs stored in MongoDB.
It prints out various stats including the top 10 most present IPs.
"""
from pymongo import MongoClient


def print_nginx_stats():
    """
    Retrieves and prints the Nginx log statistics:
    - total logs count
    - count for each HTTP method (GET, POST, PUT, PATCH, DELETE)
    - count of logs where method=GET and path=/status
    - top 10 most frequent IPs
    """
    client = MongoClient()
    db = client.logs
    nginx_collection = db.nginx

    # Total logs count
    total_logs = nginx_collection.count_documents({})
    print(f"{total_logs} logs")

    # Methods counts
    methods = ["GET", "POST", "PUT", "PATCH", "DELETE"]
    print("Methods:")
    for method in methods:
        method_count = nginx_collection.count_documents({"method": method})
        print(f"\tmethod {method}: {method_count}")

    # Count logs with method=GET and path=/status
    status_check = nginx_collection.count_documents({"method": "GET", "path": "/status"})
    print(f"{status_check} status check")

    # Top 10 most frequent IPs
    print("IPs:")
    # Aggregation pipeline to count IPs
    ip_counts = nginx_collection.aggregate([
        {"$group": {"_id": "$ip", "count": {"$sum": 1}}},
        {"$sort": {"count": -1}},
        {"$limit": 10}
    ])

    # Print the top 10 IPs
    for ip in ip_counts:
        print(f"\t{ip['_id']}: {ip['count']}")


if __name__ == "__main__":
    print_nginx_stats()
