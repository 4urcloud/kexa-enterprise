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
            ${msg("updatePasswordTitle")!"Update your password"}
          </h1>
        </div>

        <form id="kc-passwd-update-form" action="${url.loginAction}" method="post">
            <div class="${properties.kcFormGroupClass!}">
                <label for="password-new" class="${properties.kcLabelClass!} kexa-body-font">${msg("passwordNew")}</label>
                <input type="password" id="password-new" name="password-new" class="${properties.kcInputClass!}" autocomplete="new-password">
                <#if messagesPerField.existsError('password')>
                    <span class="${properties.kcInputErrorMessageClass!}">${kcSanitize(messagesPerField.getFirstError('password'))?no_esc}</span>
                </#if>
            </div>

            <div class="${properties.kcFormGroupClass!}">
                <label for="password-confirm" class="${properties.kcLabelClass!} kexa-body-font">${msg("passwordConfirm")}</label>
                <input type="password" id="password-confirm" name="password-confirm" class="${properties.kcInputClass!}" autocomplete="new-password">
                <#if messagesPerField.existsError('password-confirm')>
                    <span class="${properties.kcInputErrorMessageClass!}">${kcSanitize(messagesPerField.getFirstError('password-confirm'))?no_esc}</span>
                </#if>
            </div>

            <div id="kc-form-buttons" class="${properties.kcFormGroupClass!}">
                <input class="${properties.kcButtonClass!} ${properties.kcButtonPrimaryClass!} ${properties.kcButtonBlockClass!} ${properties.kcButtonLargeClass!} gradient-button kexa-body-font" type="submit" value="${msg("doSubmit")}" />
                <#if isAppInitiatedAction??>
                    <a class="btn btn-default kexa-body-font" href="${url.loginAction}?cancel_aia=true">${msg("doCancel")}</a>
                </#if>
            </div>
        </form>
      </div>
    </div>
    <#elseif section = "info" >
    </#if>
</@layout.registrationLayout>