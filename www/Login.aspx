<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <link href="css/ionic.css" rel="stylesheet" />
    <script src="JS/JQuery.js" type="text/javascript"></script>
    <title>XBS Login</title>
    <script type="text/javascript">
        var Type;
        var Url;
        var Data;
        var ContentType;
        var DataType;
        var ProcessData;
        var method;
        //Generic function to call WCF  Service
        function CallService() {
            $.support.cors = true;
            alert("CallService");
            $.ajax({
                type: Type, //GET or POST or PUT or DELETE verb
                url: Url, // Location of the service
                data: Data, //Data sent to server
                contentType: ContentType, // content type sent to server
                dataType: DataType, //Expected data format from server
                processdata: ProcessData, //True or False
                success: function (msg) {//On Successfull service call
                    ServiceSucceeded(msg);
                },
                error: ServiceFailed// When Service call fails
            });
        }

        function ServiceFailed(result) {
            alert('test');
            alert('Service call failed: ' + result.status + '' + result.statusText);
            Type = null;
            Url = null;
            Data = null;
            ContentType = null;
            DataType = null;
            ProcessData = null;
        }
            
        function GetEmployee() {
            alert("test");
            var uesrid = "1";
            Type = "POST";
            Url = "http://122.166.232.27:8090/XBSService/Service1.svc";
            Data = { 'userName': "" + document.getElementById('txtName').value + "", 'password': "" + document.getElementById('txtPwd').value + "" },
            DataType = "jsonp"; ProcessData = false;
            method = "getLoginInfo";
            CallService();
            return false;
        }

        function ServiceSucceeded(result) {
            if (DataType == "jsonp") {
                if (method == "CreateEmployee") {
                    alert(result);
                }
                else {
                    resultObject = result.GetEmployeeResult;
                    var string = result
                    alert(string);
                }
            }
        }

        function ServiceFailed(xhr) {
            alert(xhr.responseText);
            if (xhr.responseText) {
                var err = xhr.responseText;
                if (err)
                    error(err);
                else
                    error({ Message: "Unknown server error." })
            }
            return;
        }

        $(document).ready(
         function () {
             try {
                 //makeCall();
             } catch (exception) {
                 alert('ex' + exception.message);
             }
         }
        );

        function makeCall() {
            var proxy = new JsonpAjaxService.Service1();
            proxy.set_enableJsonp(true);
            proxy.GetCustomer(onSuccess, onFail, null);
        }

        // This function is called when the result from the service call is received
        function onSuccess(result) {
            alert(result.Name + " " + result.Address);
        }

        // This function is called if the service call fails
        function onFail() {
            alert("Error");
        }
    </script>
</head>
<body>
  <ion-header-bar>
  <h1 class="title">XBS Login</h1>
  </ion-header-bar>
    <ion-content>
  <form ng-submit="doLogin()" runat="server">
  <div class="list">
      <label class="item item-input">
           <input type="text" placeholder="Userame" id="txtName">
      </label>
      <label class="item item-input">
          <input type="password" ng-model="loginData.password" placeholder="Password" id="txtPwd">
      </label>
      <label class="item">
           <button class="button button-block button-positive" type="submit" onclick="javasctipt: return GetEmployee();">Log in</button>
       </label>
    </div>
    <asp:ScriptManager ID="ScriptManager1" runat="server">
        <Services>
            <asp:ServiceReference Path="http://122.166.232.27:8090/XBSService/Service1.svc" />
        </Services>
    </asp:ScriptManager>
  </form>
</ion-content>
</body>
</html>
