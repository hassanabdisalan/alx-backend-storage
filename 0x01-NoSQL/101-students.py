#!/usr/bin/env python3
"""
This script provides the functionality to get all students sorted by their average score.
"""

def top_students(mongo_collection):
    """
    Returns all students sorted by their average score.
    The average score is included as 'averageScore' in each student document.
    """
    students = mongo_collection.find()

    # Add averageScore to each student
    for student in students:
        topics = student.get('topics')
        if topics:
            total_score = sum(topic['score'] for topic in topics)
            average_score = total_score / len(topics)
            student['averageScore'] = average_score
        else:
            student['averageScore'] = 0

    # Sort the students by their average score in descending order
    sorted_students = sorted(students, key=lambda x: x['averageScore'], reverse=True)

    return sorted_students
