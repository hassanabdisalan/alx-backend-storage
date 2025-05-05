#!/usr/bin/env python3
"""Function that returns list of schools with a specific topic."""


def schools_by_topic(mongo_collection, topic):
    """Returns list of school documents with a specific topic.

    Args:
        mongo_collection: pymongo collection object.
        topic (str): The topic to search for.

    Returns:
        List of documents matching the topic.
    """
    return mongo_collection.find({"topics": topic})
