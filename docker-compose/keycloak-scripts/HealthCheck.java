import java.net.URI;
import java.net.URL;
import java.net.HttpURLConnection;
import java.io.IOException;
import javax.net.ssl.*; // Nécessaire pour les classes SSL

public class HealthCheckSimpleNoSSL {

    // Notre TrustManager "non vérificateur"
    private static final TrustManager[] UNTRUSTING_TRUST_MANAGER = new TrustManager[]{
        new X509TrustManager() {
            @Override
            public java.security.cert.X509Certificate[] getAcceptedIssuers() {
                return null; // N'accepte aucun émetteur certifié spécifique
            }
            @Override
            public void checkClientTrusted(
                java.security.cert.X509Certificate[] certs, String authType) {
                // Ne fait rien, accepte toujours les clients
            }
            @Override
            public void checkServerTrusted(
                java.security.cert.X509Certificate[] certs, String authType) {
                // Ne fait rien, accepte toujours les serveurs (désactive la vérification)
            }
        }
    };

    // Notre HostnameVerifier "non vérificateur"
    private static final HostnameVerifier UNTRUSTING_HOSTNAME_VERIFIER = (hostname, session) -> true; // Accepte toujours le nom d'hôte

    public static void main(String[] args) {
        if (args.length == 0) {
            System.err.println("Usage: java HealthCheckSimpleNoSSL <URL>");
            System.exit(1);
        }

        try {
            URI uri = new java.net.URI(args[0]);
            URL url = uri.toURL();
            HttpURLConnection connection;

            // Si c'est une connexion HTTPS, appliquer notre configuration de contournement
            if (url.getProtocol().equalsIgnoreCase("https")) {
                HttpsURLConnection httpsConnection = (HttpsURLConnection) url.openConnection();

                // Initialiser un SSLContext qui utilise notre TrustManager non vérificateur
                SSLContext sslContext = SSLContext.getInstance("TLS"); // Utilisez TLS pour la compatibilité moderne
                sslContext.init(null, UNTRUSTING_TRUST_MANAGER, new java.security.SecureRandom());

                // Appliquer le SSLContext et le HostnameVerifier à cette connexion spécifique
                httpsConnection.setSSLSocketFactory(sslContext.getSocketFactory());
                httpsConnection.setHostnameVerifier(UNTRUSTING_HOSTNAME_VERIFIER);

                connection = httpsConnection; // Utiliser la connexion HTTPS configurée
            } else {
                // Pour les connexions HTTP standard, pas de configuration SSL nécessaire
                connection = (HttpURLConnection) url.openConnection();
            }

            // Définir un timeout de connexion (optionnel, mais recommandé)
            connection.setConnectTimeout(5000); // 5 secondes
            connection.setReadTimeout(5000);    // 5 secondes

            // Obtenir le code de réponse HTTP
            int responseCode = connection.getResponseCode();

            // Vérifier si la réponse est HTTP_OK (200)
            if (responseCode == HttpURLConnection.HTTP_OK) {
                System.out.println("OK: " + args[0] + " (Code: " + responseCode + ")");
                System.exit(0);
            } else {
                System.err.println("ERREUR: " + args[0] + " (Code: " + responseCode + ")");
                System.exit(1);
            }

        } catch (SSLHandshakeException e) {
            // Cette exception NE DEVRAIT PAS se produire si la configuration est correcte,
            // mais on la garde juste au cas où pour un diagnostic.
            System.err.println("ERREUR SSL Handshake (devrait être ignoré): " + args[0] + " -> " + e.getMessage());
            System.exit(1);
        } catch (Exception e) {
            System.err.println("ERREUR: " + args[0] + " (Problème de connexion ou URL invalide: " + e.getMessage() + ")");
            System.exit(1);
        }
    }
}