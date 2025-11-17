<#macro mainLayout active bodyClass="">
<!doctype html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
    <meta name="robots" content="noindex, nofollow">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    
    <title>Welcome to Kexa</title>
    <link rel="icon" href="${url.resourcesPath}/img/kexa-no-background-color.png" />
    
    <#if properties.stylesCommon?has_content>
        <#list properties.stylesCommon?split(' ') as style>
            <link href="${url.resourcesCommonPath}/${style}" rel="stylesheet" />
        </#list>
    </#if>
    <#if properties.styles?has_content>
        <#list properties.styles?split(' ') as style>
            <link href="${url.resourcesPath}/${style}" rel="stylesheet" />
        </#list>
    </#if>
    
    <style>
        body {
            background-color: #f9f9f9;
            font-family: 'Open Sans', sans-serif;
        }
        .kc-logo {
            width: 120px;
            height: auto;
            margin-bottom: 20px;
        }
        .welcome-header {
            text-align: center;
            margin-bottom: 40px;
        }
        .welcome-header h1 {
            color: #333;
        }
        .title {
            color: #666;
        }
    </style>
</head>

<body class="admin-console user ${bodyClass}">
    <#nested "header">
    <div id="kc-content">
        <#nested>
    </div>
</body>
</html>
</#macro>