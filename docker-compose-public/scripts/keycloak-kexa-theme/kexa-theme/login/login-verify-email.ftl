<#import "template.ftl" as layout>
<@layout.registrationLayout displayMessage=false displayInfo=true; section>
    <#if section = "header">
    <#elseif section = "form">
    <div id="kc-form" class="page-container">
      <div id="kc-form-wrapper" class="GlassEffect__container GlassEffect__medium">
        <div class="kexa-logo-container">
          <img src="${url.resourcesPath}/img/kexa-no-background-color.png" alt="Kexa Logo" class="kexa-logo" />
        </div>
        <#if message?has_content>
          <#include "message.ftl">
        </#if>

        <div class="kexa-title-container">
          <h1 class="h1-kexa-title kexa-title-font main-title title-no-margin" style="color: black;">
            ${msg("emailVerifyTitle")!"Verify your email"}
          </h1>
        </div>
        <div class="introduction-text kexa-body-font">
          ${msg("emailVerifyInstruction1")!"We sent a verification email. Please check your inbox."}
        </div>
        <form id="kc-verify-email-form" action="${url.loginAction}" method="post">
            <div id="kc-form-buttons" class="${properties.kcFormGroupClass!}">
                <input type="submit" name="resend" id="kc-resend" class="${properties.kcButtonClass!} ${properties.kcButtonPrimaryClass!} ${properties.kcButtonBlockClass!} ${properties.kcButtonLargeClass!} gradient-button kexa-body-font" value="${msg("emailResend")!"Resend email"}"/>
            </div>
        </form>
      </div>
    </div>
    <#elseif section = "info" >
    </#if>
</@layout.registrationLayout>