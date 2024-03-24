page 50000 "S3 Amazon Setup"
{
    ApplicationArea = All;
    Caption = 'S3 Amazon Setup';
    PageType = Card;
    SourceTable = "S3 Amazon Setup";
    UsageCategory = Administration;

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';

                field("Rest API Url"; Rec."Rest API Url")
                {
                    ToolTip = 'Specifies the value of the Rest API Url field.';
                }
                field("Acces Key"; Rec."Acces Key")
                {
                    ToolTip = 'Specifies the value of the Acces Key field.';
                    ExtendedDatatype = Masked;
                }
                field("Secret Key"; Rec."Secret Key")
                {
                    ToolTip = 'Specifies the value of the Secret Key field.';
                    ExtendedDatatype = Masked;
                }
                field("Bucket Name"; Rec."Bucket Name")
                {
                    ToolTip = 'Specifies the value of the Bucket Name field.';
                }
                field("Region End Point"; Rec."Region End Point")
                {
                    ToolTip = 'Specifies the value of the Region End Point field.';
                }
            }
            group(Audit)
            {
                Caption = 'Audit';

                field(SystemCreatedAt; Rec.SystemCreatedAt)
                {
                    ToolTip = 'Specifies the value of the SystemCreatedAt field.';
                }
                field(SystemCreatedBy; Rec.SystemCreatedBy)
                {
                    ToolTip = 'Specifies the value of the SystemCreatedBy field.';
                }
                field(SystemId; Rec.SystemId)
                {
                    ToolTip = 'Specifies the value of the SystemId field.';
                }
                field(SystemModifiedAt; Rec.SystemModifiedAt)
                {
                    ToolTip = 'Specifies the value of the SystemModifiedAt field.';
                }
                field(SystemModifiedBy; Rec.SystemModifiedBy)
                {
                    ToolTip = 'Specifies the value of the SystemModifiedBy field.';
                }
            }
        }
    }

    trigger OnOpenPage()
    begin
        if not Rec.Get() then begin
            Rec.Init();
            Rec.Insert();
        end;
    end;
}
