<%@ Page Title="About" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="About.aspx.cs" Inherits="ContactsTask.About" %>


<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <link rel="stylesheet" href="/Content/Gradient.css">
    <link rel="stylesheet" href="/Content/Button.css">

    <style>
        table{
            border-collapse:collapse;
            width:100%;
        }
        th,td
        {
            text-align:left;
            padding:8px;
        }
        th{
            background-color:#4CAF50;
            color:white;
        }
        tr:nth-child(even)
        {
            background-color:#f2f2f2;

        }
        tr.separator{
            border-top:1px solid #ddd;
            border-bottom:1px solid;
        }
        .auto-style1 {
            height: 36px;
        }

    </style>
     
<script type="text/javascript">
    function clientValidate(sender, args) {
        if (args.Value.length < 3 || args.Value.length > 20) {
            args.IsValid = false;
        }
    }
</script> 
   
    <div class="container">
        <div class="modal fade" id="mymodal" data-backdrop="false" role="dialog">
            <div class=" modal-dialog modal-dailog-centered">
                <div class="modal-content">
                    <div class="modal -header">
                        <h4 class="modal-title">Add New\Update Record</h4>
                        <asp:Label ID="lblmsg" Text="" runat="server" />
                        <button type="button" class="close" data-dismiss="modal">&times;</button>
                    </div>
                    <div class="modal-body">
                        <label>Name</label>
                        <asp:TextBox ID="txtName" CssClass="form-control" placeholder="Name" runat="server" />
                        <label>MobilePhone</label>
                        <asp:TextBox ID="txtMobilePhone" CssClass="form-control" placeholder="MobilePhone" runat="server"/>
                        <label>JobTitle</label>
                        <asp:TextBox ID="txtJobTitle" CssClass="form-control" placeholder="JobTitle" runat="server" />
                        <label>BirthDate</label>                        
                        <asp:TextBox ID="txtBirthDate" CssClass="form-control" placeholder="BirthDate" TextMode="Date" runat="server" />                            
                     <asp:HiddenField  ID="hdid"  runat="server"/>
                        

                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-danger" data-dismiss="modal">Close</button>
                        <asp:Button ID="btnsave" CssClass="btn btn-primary" OnClick="SaveButton_Click" Text="Save" runat="server" />
                    </div>
                </div>

            </div>

        </div>
    </div>
 

    <section Id="section">
        <div class="row match-height">
            <div class="col-12">
                <div class="card">
                    <div class="card-header">
                         <asp:Button Text="Open Modal" ID="modal" class="button" OnClick="ModalButton_Click" runat="server" />

                         <asp:CustomValidator ID="CustomValidator1" runat="server" ClientValidationFunction="clientValidate" ControlToValidate="txtName" Display="Dynamic" Text="The text length should be between 3 and 20">
                         </asp:CustomValidator>
                        <asp:RegularExpressionValidator ID="RegularExpressionValidator2" runat="server" ErrorMessage="Enter valid Phone number. Correct format [0-9]{12}" ControlToValidate="txtMobilePhone" ValidationExpression="^([0-9]{12})$" ></asp:RegularExpressionValidator> 

                    </div>
                    <div class="card-content">
                        <div class="card-body">
                            <div class="row">
                                <div class="col-md-12 col-12">

                                    <table>
                                        <asp:Repeater ID="rptr1" DataSourceID="ds1" runat="server">
                                            <HeaderTemplate>
                                                <tr>
                                                    <th>Id</th>
                                                    <th>Name</th>
                                                    <th>MobilePhone</th>
                                                    <th>JobTitle</th>
                                                    <th>BirthDate</th>                                              

                                                </tr>
                                            </HeaderTemplate>
                                            <ItemTemplate>

                                                <tr class="separator">
                                                    <td> <%# Eval("Id") %></td>
                                                    <td> <%# Eval("Name") %></td>
                                                    <td> <%# Eval("MobilePhone") %></td>
                                                    <td> <%# Eval("JobTitle") %></td>
                                                    <td> <%# Eval("BirthDate") %></td>                                                    

                                                    <td>
                                                         <asp:LinkButton ID="btnupdate" CommandName="Update" OnCommand="UpdateButton_Command" CommandArgument='<%#Eval("Id") %>' CssClass="btn btn-sm brn-primary"  runat="server" ><i  class="glyphicon glyphicon-pencil"></i></asp:LinkButton>

                                                        <asp:LinkButton CommandName="Delete" ID="btndlt" CommandArgument='<%#Eval("Id") %>' 
                                                            OnClientClick="return confirm('Are you sure you want to delete this !');"
                                                            OnCommand="DeleteButton_Command" CssClass="btn btn-sm brn-danger" runat="server" ><i  class="glyphicon glyphicon-trash"></i></asp:LinkButton>


                                                    </td>
                                                </tr>


                                            </ItemTemplate>
                                        </asp:Repeater>
                                    </table>
                                </div>
                            </div>

                        </div>

                    </div>
                </div>

            </div>

        </div>

    </section>
    <asp:SqlDataSource ID="ds1"
       ConnectionString="<%$ConnectionStrings:connection_ %>"  runat="server"
        SelectCommand="SELECT * FROM Contacts"
        />



</asp:Content>
