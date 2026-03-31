import java.net.URI;
import java.net.URL;
import java.net.HttpURLConnection;
import java.io.IOException;
import javax.net.ssl.*; // Required for SSL classes

public class HealthCheckSimpleNoSSL {

    // Our "non-verifying" TrustManager
    private static final TrustManager[] UNTRUSTING_TRUST_MANAGER = new TrustManager[]{
        new X509TrustManager() {
            @Override
            public java.security.cert.X509Certificate[] getAcceptedIssuers() {
                return null; // Does not accept any specific certified issuer
            }
            @Override
            public void checkClientTrusted(
                java.security.cert.X509Certificate[] certs, String authType) {
                // No-op, always trusts clients
            }
            @Override
            public void checkServerTrusted(
                java.security.cert.X509Certificate[] certs, String authType) {
                // No-op, always trusts servers (disables verification)
            }
        }
    };

    // Our "non-verifying" HostnameVerifier
    private static final HostnameVerifier UNTRUSTING_HOSTNAME_VERIFIER = (hostname, session) -> true; // Always accepts hostname

    public static void main(String[] args) {
        if (args.length == 0) {
            System.err.println("Usage: java HealthCheckSimpleNoSSL <URL>");
            System.exit(1);
        }

        try {
            URI uri = new java.net.URI(args[0]);
            URL url = uri.toURL();
            HttpURLConnection connection;

            // If HTTPS connection, apply our bypass configuration
            if (url.getProtocol().equalsIgnoreCase("https")) {
                HttpsURLConnection httpsConnection = (HttpsURLConnection) url.openConnection();

                // Initialize an SSLContext using our non-verifying TrustManager
                SSLContext sslContext = SSLContext.getInstance("TLS");
                sslContext.init(null, UNTRUSTING_TRUST_MANAGER, new java.security.SecureRandom());

                // Apply SSLContext and HostnameVerifier to this specific connection
                httpsConnection.setSSLSocketFactory(sslContext.getSocketFactory());
                httpsConnection.setHostnameVerifier(UNTRUSTING_HOSTNAME_VERIFIER);

                connection = httpsConnection;
            } else {
                // For standard HTTP connections, no SSL configuration needed
                connection = (HttpURLConnection) url.openConnection();
            }

            // Set connection timeout (optional but recommended)
            connection.setConnectTimeout(5000); // 5 seconds
            connection.setReadTimeout(5000);    // 5 seconds

            // Get the HTTP response code
            int responseCode = connection.getResponseCode();

            // Check if the response is HTTP_OK (200)
            if (responseCode == HttpURLConnection.HTTP_OK) {
                System.out.println("OK: " + args[0] + " (Code: " + responseCode + ")");
                System.exit(0);
            } else {
                System.err.println("ERROR: " + args[0] + " (Code: " + responseCode + ")");
                System.exit(1);
            }

        } catch (SSLHandshakeException e) {
            // This exception SHOULD NOT occur if configuration is correct,
            // but we keep it for diagnostic purposes.
            System.err.println("ERROR SSL Handshake (should be ignored): " + args[0] + " -> " + e.getMessage());
            System.exit(1);
        } catch (Exception e) {
            System.err.println("ERROR: " + args[0] + " (Connection issue or invalid URL: " + e.getMessage() + ")");
            System.exit(1);
        }
    }
}
