dotnet
{
    assembly("AWSSDK.S3")
    {
        PublicKeyToken = '885c28607f98e604';

        type(Amazon.S3.Model.GetObjectResponse; GetObjectResponse) { }
        type(Amazon.S3.Model.PutObjectRequest; PutObjectRequest) { }
        type(Amazon.S3.Model.PutObjectResponse; PutObjectResponse) { }
        type(Amazon.S3.Model.ListObjectsV2Request; ListObjcstsV2Request) { }
        type(Amazon.S3.AmazonS3Client; AmazonS3Client) { }
        type(Amazon.S3.Model.S3Object; S3Object) { }
    }

    assembly("AWSSDK.Core")
    {
        PublicKeyToken = '885c28607f98e604';

        type(Amazon.RegionEndpoint; RegioinEndPoint) { }
    }
}