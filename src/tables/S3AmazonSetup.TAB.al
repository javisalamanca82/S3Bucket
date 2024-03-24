table 50000 "S3 Amazon Setup"
{
    Caption = 'S3 Amazon Setup';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Primary Key"; Code[10])
        {
            Caption = 'Primary Key';
        }
        field(2; "Rest API Url"; Text[1024])
        {
            Caption = 'Rest API Url';
        }
        field(3; "Acces Key"; Text[250])
        {
            Caption = 'Acces Key';
        }
        field(4; "Secret Key"; Text[1024])
        {
            Caption = 'Secret Key';
        }
        field(5; "Bucket Name"; Text[50])
        {
            Caption = 'Bucket Name';
        }
        field(6; "Region End Point"; Text[50])
        {
            Caption = 'Region End Point';
        }
    }
    keys
    {
        key(PK; "Primary Key")
        {
            Clustered = true;
        }
    }
}
