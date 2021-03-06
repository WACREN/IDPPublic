<%-- 
    Document   : userAdmin
    Created on : 05-Jun-2012, 18:08:34
    Author     : Marco Fargetta <marco.fargetta@ct.infn.it>
--%>

<%@include file="WEB-INF/jspf/header.jspf" %>
<%@ taglib prefix="s" uri="/struts-tags" %>
<s:if test="#session.login != 'true'">
    <jsp:forward page="login.jsp" />  
</s:if>
<s:if test="%{user.administrator == true}">

    <h2>User Account administration <a href="<s:url action='globalAdmin'/>">(Global Admin Page)</a></h2>
</s:if>
<s:else>
<h2>User Account administration</h2>
</s:else>
<div class="col-60">
    <h2>User Information</h2>

    <s:form action="" method="POST">
        <s:label label="Name" value="%{user.title} %{user.givenname} %{user.surname}"/>
        <s:label label="Username" value="%{user.username}"/>
        <s:label label="PreferredMail" value="%{user.preferredMail}"/>
        <s:label label="MailsList" value="%{user.additionalMails}"/>
    </s:form>
    <h3>Additional information</h3>
    <s:form action="ModifyUser" method="POST">
        <s:hidden name="user_cn" value="%{user.username}"/>
        <s:textfield label="Add Mail" name="newMail" value=""/>
        <s:submit name="addMail" value="Add Mail"/>
    </s:form>

    <h3>Change password</h3>               
    <s:form action="ModifyUser" method="POST">
        <s:hidden name="user_cn" value="%{user.username}"/>
        <s:password label="New Password" name="newPass" value=""/>
        <s:password label="New Password Again" name="newPassAgain" value=""/>

        <s:submit name="password" value="Change Password"/>
    </s:form>

    <p>
        We don't currently provide means to modify other information. If you move to a different
        organisation, please create a new account and let the current account to expire.
        For more information write to <a href="mailto:CHANGEME">the IdP admins</a> </p>
</div>
<div class="col-40">
    <div>
        <s:if test="%{user.active}">
            <s:if test="%{expiring}">
                <div class="centralImgContainer">
                    <img src="img/stop.png"/>
                </div>
                <p>
                    You account will expire the next <s:date name="user.expireTime" format="dd MMM"/>. If all the
                    data are correct apply for another year extension by clicking on the "Extend Account" button below.
                </p>
                <s:form action="ExtendAccount" method="POST">
                    <s:hidden name="username" value="%{user.username}"/>
                    <s:submit name="extend" value="Extend Account"/>
                </s:form>
            </s:if>
            <s:else>
                <div class="centralImgContainer">
                    <img src="img/approved.png"/>
                </div>
                <p>
                    Your account has been <b>approved until the <s:date name="user.expireTime" format="dd MMM yyyy"/></b>.
                    Before the expiration you will receive an e-mail to extend it 
                </p>
            </s:else>
        </s:if>

        <s:if test="%{!user.active}">
            <div class="col-60">
                <img src="img/padlock.png"/>            
            </div>
            <div class="col-40">
                <h2 class="problem">Account locked</h2>
            </div>
            <div style="clear: both;"></div>
            <p>
                You account has been locked because it has not been extended or for any other reasons.
            </p>

            <p>
                If the account information related to <span class="important">organisation and preferred mail are still valid</span> and
                you want to re-activate the account <b>click on the <i>Re-activate Account</i> button</b> below. You will receive an e-mail
                once the request will have been processed by the administrators. 
            </p>
            <s:form action="ReactivateUser" method="POST">
                <s:hidden name="user_cn" value="%{user.username}"/>
                <s:submit name="reactivate" value="Re-activate Account"/>
            </s:form>

        </s:if>
    </div>
</div>
<div style="clear: both;"></div>
<%@include file="WEB-INF/jspf/footer.jspf" %>
