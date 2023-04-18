Configuration Create_Share {
    #Import-DscResource -ModuleName xSmbShare

    Node $NodeName {
        xSmbShare MySMBShare {
            Ensure = "Present"
            Name = "MyFileShare"
            Path = "C:\Shared"
            ReadAccess = "User1"
            FullAccess = "User2"
            Description = "This is an updated description for this share"
        }
    }
}