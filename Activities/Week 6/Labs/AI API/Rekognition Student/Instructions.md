# Lab: Visitor Analytics with AWS Rekognition, S3, and Glue
### Business Case: Park Visitor Insights

Welcome! You are a data engineer working for a national park. The park's marketing and operations teams want to better understand their visitors to improve services and outreach. They have collected thousands of photos of cars in the parking lots and have a key question: "Where are our visitors driving from?"

Your mission is to build an automated data pipeline to analyze these images. The specific requirements are:

1. Store the raw images in the cloud.
2. Use AI to automatically extract the State and Car Make from each image. For privacy reasons, you must not store the license plate number itself.
3. Store the processed, structured data in a query-friendly format.
4. Make this data discoverable and available for analysis by the marketing team using standard SQL tools.

__Tech Stack:__
* Amazon S3: For scalable object storage.
* AWS Rekognition: For AI-powered image analysis.
* AWS Glue: To catalog our data for easy querying.


## Part 1: Upload Raw Images to S3
First, we need a central, secure location to store our raw image files. Amazon S3 is the perfect tool for this. We will create a unique S3 bucket and upload our images to a specific folder path.

__Instructions__

* Write the Python code to upload each file. Use a loop to find all `.jpg` files in your local images directory and upload them to the specified S3 path: `TECHCATALYST-RAW/YOURNAME/AI/IMAGES_RAW/`
* You can use either `Boto3` or `awswrangler` for this task.
* Make sure only `.jpg` files are uploaded 

## Part 2: Analyze Images with Rekognition
Now that our images are in S3, we can point AWS Rekognition directly to them. This is more efficient than reading them locally and sending the bytes over the network. We will extract the text, process it to find the state and make, and store the results in a Pandas DataFrame.

__Instructions__

* List the uploaded images. Use the s3_client to list all objects in the `AI/IMAGES_RAW`folder.
* Call Rekognition for each image. Loop through the list of S3 objects and call `detect_text`, referencing the image by its `bucket` and `key`.
* Process the text. Use logic described previously to find the state and car make from the detected words.
* Append the results to a list, including the `S3 URI` of the image for traceability.

**Tips**: 
You will need to use 
```python
rekognition_client.detect_text(
        Image={'S3Object': {'Bucket': S3_BUCKET_NAME, 'Name': s3_key}}
    )
```
instead of 

```python
with open('Images/b7e7072fc29fd465.jpg', 'rb') as image_file:
    response = rekognition_client.detect_text(
                            Image={'Bytes': image_file.read()}
                            )
```


## Part 3: Store results in S3 as a Parquet File
Raw text files (like CSVs) are good, but columnar formats like Parquet are much more efficient for analytics. They are faster to query and take up less space. We will save our DataFrame as a Parquet file and upload it to a "processed" folder in S3 `TECHCATALYST-RAW/YOURNAME/AI/IMAGES_PROCESSED/`.

* Figure out how you can save the plots (The Bar charts and Pie charts) and have them uploaded as `.jpg` images to the `/IMAGES_PROCESSED/` folder along with the `parquet` file. (YOU CAN SAVE AS CSV OR PARQUET. )

__Instructions__

* Save the output DataFrame as a Parquet file to the new S3 location. DataFrame will contain S3 File path for each image (that’s the image Key), State, and Car Make.
* Create plots (Pie charts and bar charts as shown below) using `DataFrame.plot()` 
  * **Hint**: `DataFrame.value_counts()`
  * Figure out how you can save the plot as a `.jpg`

## Example output

![image-20250805131438819](images/image-20250805131438819.png)

![image-20250805131514425](images/image-20250805131514425.png)

![image-20250805131536034](images/image-20250805131536034.png)

