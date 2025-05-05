#!/usr/bin/env python3
"""Function to insert a new document in a MongoDB collection."""


def insert_school(mongo_collection, **kwargs):
    """Inserts a new document into a MongoDB collection.

    Args:
        mongo_collection: pymongo collection object.
        **kwargs: Key-value pairs representing the document fields.

    Returns:
        The _id of the newly inserted document.
    """
    return mongo_collection.insert_one(kwargs).inserted_id
