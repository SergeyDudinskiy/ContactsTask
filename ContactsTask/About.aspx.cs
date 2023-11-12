using System;
using System.Collections.Generic;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace ContactsTask
{
    public partial class About : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void ModalButton_Click(object sender, EventArgs e)
        {
            string script = "$('#mymodal').modal('show');";
            ClientScript.RegisterStartupScript(GetType(),"Popup",script,true);
        }

        string errorMessage;
        string id;

        protected void SaveButton_Click(object sender, EventArgs e)
        {
            if (!string.IsNullOrEmpty(hdid.Value))
            {
                errorMessage = Requests.Request("UPDATE Contacts SET Name = '" + txtName.Text + "', MobilePhone = '" + txtMobilePhone.Text + "', JobTitle = '" + txtJobTitle.Text +
                    "', BirthDate = '" + txtBirthDate.Text + "' WHERE Id = " + hdid.Value);
           
                ShowResultsAfterRequest("updat");
            }
            else
            {
                errorMessage = Requests.Request("INSERT INTO Contacts (Name, MobilePhone, JobTitle, BirthDate)" +
                    " VALUES ('" + txtName.Text + "', '" + txtMobilePhone.Text + "', '" + txtJobTitle.Text + "', '" + txtBirthDate.Text + "')");

                ShowResultsAfterRequest("insert");
            }

            string script = "$('#mymodal').modal('show');";
            ClientScript.RegisterStartupScript(GetType(), "Popup", script, true);
            rptr1.DataBind();
            txtName.Text = txtMobilePhone.Text = txtJobTitle.Text = txtBirthDate.Text = "";
            id = null;
        }

        private void ShowResultsAfterRequest(string typeOperation)
        {
            if (errorMessage == "")
            {
                lblmsg.Text = "Data successfully " + typeOperation + "ed";
            }
            else
            {
                lblmsg.Text = "Error during " + typeOperation + "ing data";
            }
        }

        protected void DeleteButton_Command(object sender, CommandEventArgs e)
        {
            string id = e.CommandArgument.ToString();  
            errorMessage = Requests.Request("DELETE FROM Contacts WHERE Id = " + id);
            ShowResultsAfterRequest("delet");
            rptr1.DataBind();
        }

        protected void UpdateButton_Command(object sender, CommandEventArgs e)
        {
            id = e.CommandArgument.ToString();
            hdid.Value = id;
            List<string> list = Requests.GetList("SELECT * FROM Contacts WHERE Id = " + id);

            if (list != null)
            {
                txtName.Text = list[1];
                txtMobilePhone.Text = list[2];
                txtJobTitle.Text = list[3];
                DateTime dateTime = Convert.ToDateTime(list[4]);
                txtBirthDate.Text = string.Format("{0:yyyy-MM-dd}", dateTime);
                rptr1.DataBind();
                ScriptManager.RegisterStartupScript(this, GetType(), "OpenModalScript", "$('#mymodal').modal('show');", true);
            }
            else
            {
                ShowResultsAfterRequest("updat");
            }            
        }
    }
}