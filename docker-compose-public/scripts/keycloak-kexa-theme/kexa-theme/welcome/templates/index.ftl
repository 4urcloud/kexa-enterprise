<#import "template.ftl" as layout>
<@layout.mainLayout active='home' bodyClass='home'>
    <div class="container-fluid">
        <div class="row">
            <div class="col-sm-10 col-sm-offset-1 col-md-8 col-md-offset-2 col-lg-8 col-lg-offset-2">
                <div class="welcome-header">
                    <img src="${url.resourcesPath}/img/kexa-no-background-color.png" alt="Kexa" class="kc-logo">
                    <h1>${msg("welcomeTitle")}</h1>
                    <p class="title">${msg("welcomeIntroMessage")}</p>
                </div>
                
                <div id="welcome-primary-link">
                    <h3><a href="${properties.adminUrl!"../admin/"}">${msg("adminConsoleTitle")}</a></h3>
                    <p>${msg("adminConsoleDescription")}</p>
                </div>
                
                <div id="welcome-secondary-links">
                    <h3><a href="${properties.documentationUrl!"https://www.keycloak.org/documentation.html"}">${msg("documentationTitle")}</a></h3>
                    <p>${msg("documentationDescription")}</p>
                </div>
            </div>
        </div>
    </div>
</@layout.mainLayout>