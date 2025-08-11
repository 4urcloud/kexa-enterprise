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
          <#assign __t = msg("updateProfileHtmlTitle", (realm.displayNameHtml)!"")!"">
          <#if !(__t?has_content) || __t == 'updateProfileHtmlTitle'>
            <#assign __t = msg("updateProfileTitle")!"">
          </#if>
          <#if !(__t?has_content) || __t == 'updateProfileTitle'>
            <#assign __t = msg("updateProfile")!"">
          </#if>
          <#if !(__t?has_content) || __t == 'updateProfile'>
            <#assign __t = "Update your profile">
          </#if>
          <h1 class="h1-kexa-title kexa-title-font main-title title-no-margin" style="color: black;">${kcSanitize(__t)}</h1>
        </div>

        <form id="kc-update-profile-form" action="${url.loginAction}" method="post">
          <#if attributes?? && (attributes?size > 0)>
            <#list attributes as attribute>
              <#if attribute.name == 'username' && !( (isEditUsernameAllowed?? && isEditUsernameAllowed) || (realm.editUsernameAllowed?? && realm.editUsernameAllowed) )>
              <#else>
                <div class="${properties.kcFormGroupClass!}">
                  <label for="${attribute.name}" class="${properties.kcLabelClass!} kexa-body-font">${attribute.displayName!attribute.name}</label>
                  <input 
                    type="text" 
                    id="${attribute.name}" 
                    name="${attribute.name}" 
                    class="${properties.kcInputClass!}"
                    value="${(attribute.value!'')}"
                    <#if attribute.readOnly?? && attribute.readOnly>readonly disabled</#if>
                  >
                  <#if messagesPerField.existsError(attribute.name)>
                    <span class="${properties.kcInputErrorMessageClass!}">${kcSanitize(messagesPerField.getFirstError(attribute.name))?no_esc}</span>
                  </#if>
                </div>
              </#if>
            </#list>
          <#else>
            <div class="${properties.kcFormGroupClass!}">
              <label for="firstName" class="${properties.kcLabelClass!} kexa-body-font">${msg("firstName")}</label>
              <input type="text" id="firstName" name="firstName" class="${properties.kcInputClass!}" value="${(user.firstName!'')}">
              <#if messagesPerField.existsError('firstName')>
                <span class="${properties.kcInputErrorMessageClass!}">${kcSanitize(messagesPerField.getFirstError('firstName'))?no_esc}</span>
              </#if>
            </div>

            <div class="${properties.kcFormGroupClass!}">
              <label for="lastName" class="${properties.kcLabelClass!} kexa-body-font">${msg("lastName")}</label>
              <input type="text" id="lastName" name="lastName" class="${properties.kcInputClass!}" value="${(user.lastName!'')}">
              <#if messagesPerField.existsError('lastName')>
                <span class="${properties.kcInputErrorMessageClass!}">${kcSanitize(messagesPerField.getFirstError('lastName'))?no_esc}</span>
              </#if>
            </div>

            <div class="${properties.kcFormGroupClass!}">
              <label for="email" class="${properties.kcLabelClass!} kexa-body-font">${msg("email")}</label>
              <input type="email" id="email" name="email" class="${properties.kcInputClass!}" value="${(user.email!'')}">
              <#if messagesPerField.existsError('email')>
                <span class="${properties.kcInputErrorMessageClass!}">${kcSanitize(messagesPerField.getFirstError('email'))?no_esc}</span>
              </#if>
            </div>

            <#if !realm.registrationEmailAsUsername && ( (isEditUsernameAllowed?? && isEditUsernameAllowed) || (realm.editUsernameAllowed?? && realm.editUsernameAllowed) )>
              <div class="${properties.kcFormGroupClass!}">
                <label for="username" class="${properties.kcLabelClass!} kexa-body-font">${msg("username")}</label>
                <input type="text" id="username" name="username" class="${properties.kcInputClass!}" value="${(user.username!'')}">
                <#if messagesPerField.existsError('username')>
                  <span class="${properties.kcInputErrorMessageClass!}">${kcSanitize(messagesPerField.getFirstError('username'))?no_esc}</span>
                </#if>
              </div>
            </#if>
          </#if>

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