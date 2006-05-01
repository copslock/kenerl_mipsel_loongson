Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 01 May 2006 14:46:11 +0100 (BST)
Received: from fencepost.gnu.org ([199.232.76.164]:63373 "EHLO
	fencepost.gnu.org") by ftp.linux-mips.org with ESMTP
	id S8133397AbWEANp6 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 1 May 2006 14:45:58 +0100
Received: from hvr by fencepost.gnu.org with local (Exim 4.34)
	id 1FaYil-0007A8-HB; Mon, 01 May 2006 09:45:51 -0400
To:	jgarzik@pobox.com
Cc:	netdev@vger.kernel.org, linux-mips@linux-mips.org,
	sshtylyov@ru.mvista.com
From:	Herbert Valerio Riedel <hvr@gnu.org>
Date:	Mon May 1 15:37:09 2006 +0200
Subject: [PATCH] au1000_eth.c: use ether_crc() from <linux/crc32.h>
Message-Id: <E1FaYil-0007A8-HB@fencepost.gnu.org>
Return-Path: <hvr@gnu.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11250
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: hvr@gnu.org
Precedence: bulk
X-list: linux-mips

since the au1000 driver already selects the CRC32 routines, simply replace
the internal ether_crc() implementation with the semantically equivalent
one from <linux/crc32.h>

Signed-off-by: Herbert Valerio Riedel <hvr@gnu.org>


---

 drivers/net/au1000_eth.c |   18 +-----------------
 1 files changed, 1 insertions(+), 17 deletions(-)

9360df5368deaaaa8fc7dcaacf9b7ca446af94c4
diff --git a/drivers/net/au1000_eth.c b/drivers/net/au1000_eth.c
index 29adebb..0823cb8 100644
--- a/drivers/net/au1000_eth.c
+++ b/drivers/net/au1000_eth.c
@@ -52,6 +52,7 @@
 #include <linux/mii.h>
 #include <linux/skbuff.h>
 #include <linux/delay.h>
+#include <linux/crc32.h>
 #include <asm/mipsregs.h>
 #include <asm/irq.h>
 #include <asm/io.h>
@@ -2070,23 +2071,6 @@ static void au1000_tx_timeout(struct net
 	netif_wake_queue(dev);
 }
 
-
-static unsigned const ethernet_polynomial = 0x04c11db7U;
-static inline u32 ether_crc(int length, unsigned char *data)
-{
-    int crc = -1;
-
-    while(--length >= 0) {
-		unsigned char current_octet = *data++;
-		int bit;
-		for (bit = 0; bit < 8; bit++, current_octet >>= 1)
-			crc = (crc << 1) ^
-				((crc < 0) ^ (current_octet & 1) ? 
-				 ethernet_polynomial : 0);
-    }
-    return crc;
-}
-
 static void set_rx_mode(struct net_device *dev)
 {
 	struct au1000_private *aup = (struct au1000_private *) dev->priv;
-- 
1.2.6
