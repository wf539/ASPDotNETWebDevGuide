﻿//------------------------------------------------------------------------------
// <autogenerated>
//     This code was generated by a tool.
//     Runtime Version: 1.0.2914.16
//
//     Changes to this file may cause incorrect behavior and will be lost if 
//     the code is regenerated.
// </autogenerated>
//------------------------------------------------------------------------------

namespace bookSourceUI.WebReference1 {
    using System.Diagnostics;
    using System.Xml.Serialization;
    using System;
    using System.Web.Services.Protocols;
    using System.Web.Services;
    
    
    [System.Web.Services.WebServiceBindingAttribute(Name="adminCustomerSoap", Namespace="http://tempuri.org/")]
    public class adminCustomer : System.Web.Services.Protocols.SoapHttpClientProtocol {
        
        [System.Diagnostics.DebuggerStepThroughAttribute()]
        public adminCustomer() {
            this.Url = "http://66.129.68.165/bookSource/adminCustomer.asmx";
        }
        
        [System.Diagnostics.DebuggerStepThroughAttribute()]
        [System.Web.Services.Protocols.SoapDocumentMethodAttribute("http://tempuri.org/addCust", Use=System.Web.Services.Description.SoapBindingUse.Literal, ParameterStyle=System.Web.Services.Protocols.SoapParameterStyle.Wrapped)]
        public string addCust(string CT_FirstName, string CT_LastName, string CT_Email, string CT_Password) {
            object[] results = this.Invoke("addCust", new object[] {
                        CT_FirstName,
                        CT_LastName,
                        CT_Email,
                        CT_Password});
            return ((string)(results[0]));
        }
        
        [System.Diagnostics.DebuggerStepThroughAttribute()]
        public System.IAsyncResult BeginaddCust(string CT_FirstName, string CT_LastName, string CT_Email, string CT_Password, System.AsyncCallback callback, object asyncState) {
            return this.BeginInvoke("addCust", new object[] {
                        CT_FirstName,
                        CT_LastName,
                        CT_Email,
                        CT_Password}, callback, asyncState);
        }
        
        [System.Diagnostics.DebuggerStepThroughAttribute()]
        public string EndaddCust(System.IAsyncResult asyncResult) {
            object[] results = this.EndInvoke(asyncResult);
            return ((string)(results[0]));
        }
        
        [System.Diagnostics.DebuggerStepThroughAttribute()]
        [System.Web.Services.Protocols.SoapDocumentMethodAttribute("http://tempuri.org/removeCust", Use=System.Web.Services.Description.SoapBindingUse.Literal, ParameterStyle=System.Web.Services.Protocols.SoapParameterStyle.Wrapped)]
        public string removeCust(int CT_ID) {
            object[] results = this.Invoke("removeCust", new object[] {
                        CT_ID});
            return ((string)(results[0]));
        }
        
        [System.Diagnostics.DebuggerStepThroughAttribute()]
        public System.IAsyncResult BeginremoveCust(int CT_ID, System.AsyncCallback callback, object asyncState) {
            return this.BeginInvoke("removeCust", new object[] {
                        CT_ID}, callback, asyncState);
        }
        
        [System.Diagnostics.DebuggerStepThroughAttribute()]
        public string EndremoveCust(System.IAsyncResult asyncResult) {
            object[] results = this.EndInvoke(asyncResult);
            return ((string)(results[0]));
        }
        
        [System.Diagnostics.DebuggerStepThroughAttribute()]
        [System.Web.Services.Protocols.SoapDocumentMethodAttribute("http://tempuri.org/updateCust", Use=System.Web.Services.Description.SoapBindingUse.Literal, ParameterStyle=System.Web.Services.Protocols.SoapParameterStyle.Wrapped)]
        public string updateCust(int CT_ID, string CT_FirstName, string CT_LastName, string CT_Email, string CT_Password) {
            object[] results = this.Invoke("updateCust", new object[] {
                        CT_ID,
                        CT_FirstName,
                        CT_LastName,
                        CT_Email,
                        CT_Password});
            return ((string)(results[0]));
        }
        
        [System.Diagnostics.DebuggerStepThroughAttribute()]
        public System.IAsyncResult BeginupdateCust(int CT_ID, string CT_FirstName, string CT_LastName, string CT_Email, string CT_Password, System.AsyncCallback callback, object asyncState) {
            return this.BeginInvoke("updateCust", new object[] {
                        CT_ID,
                        CT_FirstName,
                        CT_LastName,
                        CT_Email,
                        CT_Password}, callback, asyncState);
        }
        
        [System.Diagnostics.DebuggerStepThroughAttribute()]
        public string EndupdateCust(System.IAsyncResult asyncResult) {
            object[] results = this.EndInvoke(asyncResult);
            return ((string)(results[0]));
        }
    }
}