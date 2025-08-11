<#import "template.ftl" as layout>
<@layout.registrationLayout displayMessage=false displayInfo=false; section>
    <#if section = "header">
    <#elseif section = "form">
    <div id="kc-form" class="page-container">
      <div id="kc-form-wrapper" class="GlassEffect__container GlassEffect__large">
        <div class="kexa-logo-container">
          <img src="${url.resourcesPath}/img/kexa-no-background-color.png" alt="Kexa Logo" class="kexa-logo" />
        </div>
        <#if message?has_content>
          <#include "message.ftl">
        </#if>

        <div class="kexa-title-container">
          <h1 class="h1-kexa-title kexa-title-font main-title title-no-margin" style="color: black;">
            ${msg("termsTitle")!"Terms and Conditions"}
          </h1>
        </div>
        <div class="kexa-body-font" style="max-height: 50vh; overflow: auto; padding: 1rem; background-color: rgba(255,255,255,0.95); border-radius: 8px; border: 1px solid rgba(0,0,0,0.1);">
          ${kcSanitize(msg("termsTextHtml"))?no_esc}
        </div>
        <form id="kc-terms-form" action="${url.loginAction}" method="post">
          <div id="kc-form-buttons" class="${properties.kcFormGroupClass!}" style="margin-top: 1rem;">
            <input class="${properties.kcButtonClass!} ${properties.kcButtonPrimaryClass!} ${properties.kcButtonBlockClass!} ${properties.kcButtonLargeClass!} gradient-button kexa-body-font" name="accept" id="kc-accept" type="submit" value="${msg("doAccept")}"/>
            <a class="btn btn-default kexa-body-font" href="${url.loginAction}?cancel_aia=true">${msg("doDecline")}</a>
          </div>
        </form>
      </div>
    </div>
    <#elseif section = "info" >
    </#if>
</@layout.registrationLayout>