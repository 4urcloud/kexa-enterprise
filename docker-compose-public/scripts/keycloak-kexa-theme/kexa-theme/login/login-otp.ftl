<#import "template.ftl" as layout>
<@layout.registrationLayout displayMessage=false displayInfo=false; section>
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
            ${msg("otpTitle")!"Enter authentication code"}
          </h1>
        </div>

        <form id="kc-otp-login-form" action="${url.loginAction}" method="post">
          <div class="${properties.kcFormGroupClass!}">
            <label for="otp" class="${properties.kcLabelClass!} kexa-body-font">${msg("otpCode")!"One-time code"}</label>
            <input id="otp" name="otp" type="text" class="${properties.kcInputClass!}" autocomplete="one-time-code"/>
          </div>
          <div id="kc-form-buttons" class="${properties.kcFormGroupClass!}">
            <input class="${properties.kcButtonClass!} ${properties.kcButtonPrimaryClass!} ${properties.kcButtonBlockClass!} ${properties.kcButtonLargeClass!} gradient-button kexa-body-font" type="submit" value="${msg("doLogIn")}" />
          </div>
        </form>
      </div>
    </div>
    <#elseif section = "info" >
    </#if>
</@layout.registrationLayout>