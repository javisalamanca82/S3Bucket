codeunit 50002 "S3 Management"
{
    procedure SendFileToS3RestAPI(Instr: InStream; FileName: Text)
    var
        S3AmazonSetup: Record "S3 Amazon Setup";
        TempBlob: Record "Upgrade Blob Storage" temporary;
        PayloadOutStream: OutStream;
        HttpClient: HttpClient;
        HttpContent: HttpContent;
        HttpHeaders: HttpHeaders;
        HttpRequest: HttpRequestMessage;
        HttpResponse: HttpResponseMessage;
        CR: Char;
        LF: Char;
        NewLine: Text;
        PayloadInstream: InStream;
        RestAPIUrl: Label '%1/%2/%3';
        Url: Text;
    begin
        CR := 13;
        LF := 10;
        NewLine += '' + CR + LF;

        S3AmazonSetup.Get();
        Url := StrSubstNo(RestAPIUrl, S3AmazonSetup."Rest API Url", S3AmazonSetup."Bucket Name", FileName);

        HttpContent.GetHeaders(HttpHeaders);
        HttpHeaders.Clear();
        HttpHeaders.Add('Content-Type', 'multipart/form-data;boundary=boundary');

        TempBlob.Blob.CreateOutStream(PayloadOutStream);
        CopyStream(PayloadOutStream, Instr);
        TempBlob.Blob.CreateInStream(PayloadInStream);
        HttpContent.WriteFrom(PayloadInStream);

        HttpRequest.Content := HttpContent;
        HttpRequest.SetRequestUri(Url);
        HttpRequest.Method := 'PUT';
        HttpClient.Send(HttpRequest, HttpResponse);

        if not HttpResponse.IsSuccessStatusCode() then
            Error('Failed to upload the file.');

    end;

    procedure SendFileToS3DotNet(ServerFileName: Text; FileKey: Text)
    var
        S3AmazonSetup: Record "S3 Amazon Setup";
        S3Client: DotNet AmazonS3Client;
        PutObjectRequest: DotNet PutObjectRequest;
        RegionEndPoint: DotNet RegioinEndPoint;
    begin
        S3AmazonSetup.Get();

        S3Client := S3Client.AmazonS3Client(S3AmazonSetup."Acces Key", S3AmazonSetup."Secret Key", RegionEndPoint.GetBySystemName(S3AmazonSetup."Region End Point"));

        PutObjectRequest := PutObjectRequest.PutObjectRequest();
        PutObjectRequest.BucketName := S3AmazonSetup."Bucket Name";
        PutObjectRequest."Key" := FileKey;
        PutObjectRequest.FilePath := ServerFileName;

        S3Client.PutObject(PutObjectRequest);
    end;
}
