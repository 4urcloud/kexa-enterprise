<#if message?has_content>
  <div class="alert alert-${message.type}">
    ${kcSanitize(message.summary)!}
  </div>
</#if>
