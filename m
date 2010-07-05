Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 05 Jul 2010 22:11:31 +0200 (CEST)
Received: from chipmunk.wormnet.eu ([195.195.131.226]:48274 "EHLO
        chipmunk.wormnet.eu" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S1491096Ab0GEUL1 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 5 Jul 2010 22:11:27 +0200
Received: by chipmunk.wormnet.eu (Postfix, from userid 1000)
        id 0DE9287BA8; Mon,  5 Jul 2010 21:11:26 +0100 (BST)
Date:   Mon, 5 Jul 2010 21:11:26 +0100
From:   Alexander Clouter <alex@digriz.org.uk>
To:     linux-mips@linux-mips.org
Cc:     florian@openwrt.org
Subject: [PATCH] MIPS: AR7: rewrite of cpmac_get_mac()
Message-ID: <20100705201125.GL24655@chipmunk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Organization: diGriz
X-URL:  http://www.digriz.org.uk/
X-JabberID: alex@digriz.org.uk
User-Agent: Mutt/1.5.18 (2008-05-17)
Return-Path: <alex@digriz.org.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 27327
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: alex@digriz.org.uk
Precedence: bulk
X-list: linux-mips

Shamelessly stealing wisdom from pasemi_mac.c, I found char2hex() could
be replaced with a single call to sscanf(), looks cleaner to me at
least.  The result is 100 bytes trimmed off the size of a compiled
cpmac_get_mac() and as an extra bonus it grumbles and gracefully fails
over to using random_ether_addr() when an attempt to parse an invalid
MAC address is made.

Signed-off-by: Alexander Clouter <alex@digriz.org.uk>
---
 arch/mips/ar7/platform.c |   42 +++++++++++++++---------------------------
 1 files changed, 15 insertions(+), 27 deletions(-)

diff --git a/arch/mips/ar7/platform.c b/arch/mips/ar7/platform.c
index 8f31d1d..0da5b2b 100644
--- a/arch/mips/ar7/platform.c
+++ b/arch/mips/ar7/platform.c
@@ -292,40 +292,28 @@ static struct platform_device cpmac_high = {
 	.num_resources	= ARRAY_SIZE(cpmac_high_res),
 };
 
-static inline unsigned char char2hex(char h)
+static void __init cpmac_get_mac(int instance, unsigned char *dev_addr)
 {
-	switch (h) {
-	case '0': case '1': case '2': case '3': case '4':
-	case '5': case '6': case '7': case '8': case '9':
-		return h - '0';
-	case 'A': case 'B': case 'C': case 'D': case 'E': case 'F':
-		return h - 'A' + 10;
-	case 'a': case 'b': case 'c': case 'd': case 'e': case 'f':
-		return h - 'a' + 10;
-	default:
-		return 0;
-	}
-}
-
-static void cpmac_get_mac(int instance, unsigned char *dev_addr)
-{
-	int i;
-	char name[5], default_mac[ETH_ALEN], *mac;
+	char name[5], *mac;
 
-	mac = NULL;
 	sprintf(name, "mac%c", 'a' + instance);
 	mac = prom_getenv(name);
-	if (!mac) {
+	if (!mac && instance) {
 		sprintf(name, "mac%c", 'a');
 		mac = prom_getenv(name);
 	}
-	if (!mac) {
-		random_ether_addr(default_mac);
-		mac = default_mac;
-	}
-	for (i = 0; i < 6; i++)
-		dev_addr[i] = (char2hex(mac[i * 3]) << 4) +
-			char2hex(mac[i * 3 + 1]);
+
+	if (mac) {
+		if (sscanf(mac, "%hhx:%hhx:%hhx:%hhx:%hhx:%hhx",
+					&dev_addr[0], &dev_addr[1],
+					&dev_addr[2], &dev_addr[3],
+					&dev_addr[4], &dev_addr[5]) != 6) {
+			pr_warning("cannot parse mac address, "
+					"using random address\n");
+			random_ether_addr(dev_addr);
+		}
+	} else
+		random_ether_addr(dev_addr);
 }
 
 /*****************************************************************************
-- 
1.7.1
