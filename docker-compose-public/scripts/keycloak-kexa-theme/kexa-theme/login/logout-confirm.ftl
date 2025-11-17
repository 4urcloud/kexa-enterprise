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
            ${msg("logoutConfirmTitle")!"Sign out"}
          </h1>
        </div>
        <div class="introduction-text kexa-body-font">
          ${msg("logoutConfirmHeader")!"Do you really want to sign out?"}
        </div>
        <form id="kc-logout-form" action="${url.logoutConfirmAction}" method="post">
          <div id="kc-form-buttons" class="${properties.kcFormGroupClass!}">
            <input type="hidden" name="session_code" value="${logoutConfirm.code!''}" />
            <input name="confirm" id="kc-logout" class="${properties.kcButtonClass!} ${properties.kcButtonPrimaryClass!} ${properties.kcButtonBlockClass!} ${properties.kcButtonLargeClass!} gradient-button kexa-body-font" type="submit" value="${msg("doLogout")}" />
            <a class="btn btn-default kexa-body-font" href="${url.logoutConfirmAction}?cancel=true">${msg("doCancel")}</a>
          </div>
        </form>
      </div>
    </div>
    <#elseif section = "info" >
    </#if>
</@layout.registrationLayout>