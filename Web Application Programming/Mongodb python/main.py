import pymongo

if __name__ == "__main__":
    client = pymongo.MongoClient("mongodb://localhost:27017/")
    
    db = client["test-database"]              # Database
    posts = db["test-collection"]             # Collection
    
    print("Collection selected")
    
    post_id = posts.insert_one({
        "name": "John",
        "age": 30
    }).inserted_id
    
    print("Inserted ID:", post_id)
