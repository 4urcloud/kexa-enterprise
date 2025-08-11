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
            ${msg("registerTitle")!"Create your Kexa account"}
          </h1>
        </div>
        
        <form id="kc-register-form" action="${url.registrationAction}" method="post">
            <div class="${properties.kcFormGroupClass!}">
                <label for="firstName" class="${properties.kcLabelClass!} kexa-body-font">${msg("firstName")}</label>
                <input type="text" id="firstName" class="${properties.kcInputClass!}" name="firstName" value="${(register.firstName!'')}">
                <#if messagesPerField.existsError('firstName')>
                    <span class="${properties.kcInputErrorMessageClass!}">${kcSanitize(messagesPerField.getFirstError('firstName'))?no_esc}</span>
                </#if>
            </div>

            <div class="${properties.kcFormGroupClass!}">
                <label for="lastName" class="${properties.kcLabelClass!} kexa-body-font">${msg("lastName")}</label>
                <input type="text" id="lastName" class="${properties.kcInputClass!}" name="lastName" value="${(register.lastName!'')}">
                <#if messagesPerField.existsError('lastName')>
                    <span class="${properties.kcInputErrorMessageClass!}">${kcSanitize(messagesPerField.getFirstError('lastName'))?no_esc}</span>
                </#if>
            </div>

            <div class="${properties.kcFormGroupClass!}">
                <label for="email" class="${properties.kcLabelClass!} kexa-body-font">${msg("email")}</label>
                <input type="email" id="email" class="${properties.kcInputClass!}" name="email" value="${(register.email!'')}">
                <#if messagesPerField.existsError('email')>
                    <span class="${properties.kcInputErrorMessageClass!}">${kcSanitize(messagesPerField.getFirstError('email'))?no_esc}</span>
                </#if>
            </div>

            <#if !realm.registrationEmailAsUsername>
            <div class="${properties.kcFormGroupClass!}">
                <label for="username" class="${properties.kcLabelClass!} kexa-body-font">${msg("username")}</label>
                <input type="text" id="username" class="${properties.kcInputClass!}" name="username" value="${(register.username!'')}">
                <#if messagesPerField.existsError('username')>
                    <span class="${properties.kcInputErrorMessageClass!}">${kcSanitize(messagesPerField.getFirstError('username'))?no_esc}</span>
                </#if>
            </div>
            </#if>

            <#if passwordRequired??>
            <div class="${properties.kcFormGroupClass!}">
                <label for="password" class="${properties.kcLabelClass!} kexa-body-font">${msg("password")}</label>
                <input type="password" id="password" class="${properties.kcInputClass!}" name="password" autocomplete="new-password">
                <#if messagesPerField.existsError('password')>
                    <span class="${properties.kcInputErrorMessageClass!}">${kcSanitize(messagesPerField.getFirstError('password'))?no_esc}</span>
                </#if>
            </div>

            <#if passwordConfirmRequired??>
            <div class="${properties.kcFormGroupClass!}">
                <label for="password-confirm" class="${properties.kcLabelClass!} kexa-body-font">${msg("passwordConfirm")}</label>
                <input type="password" id="password-confirm" class="${properties.kcInputClass!}" name="password-confirm" autocomplete="new-password">
                <#if messagesPerField.existsError('password-confirm')>
                    <span class="${properties.kcInputErrorMessageClass!}">${kcSanitize(messagesPerField.getFirstError('password-confirm'))?no_esc}</span>
                </#if>
            </div>
            </#if>
            </#if>

            <div id="kc-form-buttons" class="${properties.kcFormGroupClass!}">
                <input class="${properties.kcButtonClass!} ${properties.kcButtonPrimaryClass!} ${properties.kcButtonBlockClass!} ${properties.kcButtonLargeClass!} gradient-button kexa-body-font" type="submit" value="${msg("doRegister")}" />
            </div>
        </form>
      </div>
    </div>
    <#elseif section = "info" >
    </#if>
</@layout.registrationLayout>