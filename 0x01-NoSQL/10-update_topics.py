#!/usr/bin/env python3
"""Function to update topics of a school document based on name."""


def update_topics(mongo_collection, name, topics):
    """Updates the topics field of a school document by name.

    Args:
        mongo_collection: pymongo collection object.
        name (str): The name of the school to update.
        topics (list of str): The new list of topics.
    """
    mongo_collection.update_many(
        {"name": name},
        {"$set": {"topics": topics}}
    )
