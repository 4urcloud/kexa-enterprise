import java.net.URI;
import java.net.URL;
import java.net.HttpURLConnection;
import java.io.IOException;
import javax.net.ssl.*; // Required for the SSL classes

public class HealthCheckSimpleNoSSL {

    // Our non-verifying TrustManager
    private static final TrustManager[] UNTRUSTING_TRUST_MANAGER = new TrustManager[]{
        new X509TrustManager() {
            @Override
            public java.security.cert.X509Certificate[] getAcceptedIssuers() {
                return null; // Accepts no specific certified issuer
            }
            @Override
            public void checkClientTrusted(
                java.security.cert.X509Certificate[] certs, String authType) {
                // Ne fait rien, accepte toujours les clients
            }
            @Override
            public void checkServerTrusted(
                java.security.cert.X509Certificate[] certs, String authType) {
                // Does nothing, always accepts servers (disables verification)
            }
        }
    };

    // Our non-verifying HostnameVerifier
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

                // Initialize an SSLContext that uses our non-verifying TrustManager
                SSLContext sslContext = SSLContext.getInstance("TLS"); // Use TLS for modern compatibility
                sslContext.init(null, UNTRUSTING_TRUST_MANAGER, new java.security.SecureRandom());

                // Apply the SSLContext and HostnameVerifier to this specific connection
                httpsConnection.setSSLSocketFactory(sslContext.getSocketFactory());
                httpsConnection.setHostnameVerifier(UNTRUSTING_HOSTNAME_VERIFIER);

                connection = httpsConnection; // Use the configured HTTPS connection
            } else {
                // Standard HTTP connections need no SSL configuration
                connection = (HttpURLConnection) url.openConnection();
            }

            // Set a connection timeout (optional but recommended)
            connection.setConnectTimeout(5000); // 5 seconds
            connection.setReadTimeout(5000);    // 5 seconds

            // Get the HTTP response code
            int responseCode = connection.getResponseCode();

            // Check whether the response is HTTP_OK (200)
            if (responseCode == HttpURLConnection.HTTP_OK) {
                System.out.println("OK: " + args[0] + " (Code: " + responseCode + ")");
                System.exit(0);
            } else {
                System.err.println("ERROR: " + args[0] + " (Code: " + responseCode + ")");
                System.exit(1);
            }

        } catch (SSLHandshakeException e) {
            // This exception should NOT happen when the configuration is correct,
            // but keep it for diagnostics just in case.
            System.err.println("SSL handshake ERROR (should have been ignored): " + args[0] + " -> " + e.getMessage());
            System.exit(1);
        } catch (Exception e) {
            System.err.println("ERROR: " + args[0] + " (Connection problem or invalid URL: " + e.getMessage() + ")");
            System.exit(1);
        }
    }
}