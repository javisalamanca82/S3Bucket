report 50000 "S3 Bucket Upload File"
{
    ApplicationArea = All;
    Caption = 'S3 Bucket Upload File';
    UsageCategory = Tasks;
    ProcessingOnly = true;

    requestpage
    {
        layout
        {
            area(content)
            {
                group(GroupName)
                {
                    field(UploadType; UploadType)
                    {
                        Caption = 'Upload Type';
                        ToolTip = 'Defines the type of upload for the selected file';
                    }

                    field(ServerFileName; ServerFileName)
                    {
                        Caption = 'File Path';
                        ToolTip = 'File to upload to S3 Bucket';
                        AssistEdit = true;
                        Editable = false;

                        trigger OnAssistEdit()
                        var
                            DialogTitleTxt: Label 'Select file to upload to S3';
                        begin
                            case UploadType of
                                UploadType::DotNet:
                                    ServerFileName := FileManagement.UploadFile(DialogTitleTxt, '');
                                UploadType::"Rest API":
                                    File.UploadIntoStream(DialogTitleTxt, '', '', ServerFileName, Instr);
                            end;
                        end;
                    }
                }
            }
        }
    }

    trigger OnPostReport()
    var
        S3Management: Codeunit "S3 Management";
    begin
        case UploadType of
            UploadType::DotNet:
                S3Management.SendFileToS3DotNet(ServerFileName, FileManagement.GetFileName(ServerFileName));
            UploadType::"Rest API":
                S3Management.SendFileToS3RestAPI(Instr, ServerFileName);
        end;
    end;

    var
        FileManagement: Codeunit "File Management";
        ServerFileName: Text;
        UploadType: Option DotNet,"Rest API";
        Instr: InStream;
}
