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
            ${msg("errorTitle")!"Something went wrong"}
          </h1>
        </div>
        <#if client??>
        <div id="kc-form-buttons" class="${properties.kcFormGroupClass!}">
          <a id="backToApplication" class="btn btn-primary gradient-button kexa-body-font" href="${client.baseUrl!''}">${msg("backToApplication")!"Back"}</a>
        </div>
        </#if>
      </div>
    </div>
    <#elseif section = "info" >
    </#if>
</@layout.registrationLayout>