Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 10 Sep 2008 16:44:06 +0100 (BST)
Received: from mba.ocn.ne.jp ([122.1.235.107]:57580 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S23872603AbYIJPoC (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 10 Sep 2008 16:44:02 +0100
Received: from localhost.localdomain (p1216-ipad302funabasi.chiba.ocn.ne.jp [123.217.139.216])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id 97EC5AFE5; Thu, 11 Sep 2008 00:43:56 +0900 (JST)
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
To:	linux-mips@linux-mips.org
Cc:	ralf@linux-mips.org
Subject: [PATCH] TXx9: Fix RBTX4939 ethernet address initialization
Date:	Thu, 11 Sep 2008 00:44:04 +0900
Message-Id: <1221061444-7224-1-git-send-email-anemo@mba.ocn.ne.jp>
X-Mailer: git-send-email 1.5.6.3
Return-Path: <anemo@mba.ocn.ne.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20443
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

Fix location of ethernet adddress when booted from external ROM.

Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
---
This is a patch for linux-queue tree.  This patch can be folded into
the patch titled "TXx9: Add RBTX4939 board support".

 arch/mips/txx9/rbtx4939/setup.c |   13 +++++++++----
 1 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/arch/mips/txx9/rbtx4939/setup.c b/arch/mips/txx9/rbtx4939/setup.c
index 277864d..df324f8 100644
--- a/arch/mips/txx9/rbtx4939/setup.c
+++ b/arch/mips/txx9/rbtx4939/setup.c
@@ -249,16 +249,21 @@ static void __init rbtx4939_device_init(void)
 #if defined(CONFIG_TC35815) || defined(CONFIG_TC35815_MODULE)
 	int i, j;
 	unsigned char ethaddr[2][6];
+	u8 bdipsw = readb(rbtx4939_bdipsw_addr) & 0x0f;
 	for (i = 0; i < 2; i++) {
 		unsigned long area = CKSEG1 + 0x1fff0000 + (i * 0x10);
-		if (readb(rbtx4939_bdipsw_addr) & 8) {
+		if (bdipsw == 0)
+			memcpy(ethaddr[i], (void *)area, 6);
+		else {
 			u16 buf[3];
-			area -= 0x03000000;
+			if (bdipsw & 8)
+				area -= 0x03000000;
+			else
+				area -= 0x01000000;
 			for (j = 0; j < 3; j++)
 				buf[j] = le16_to_cpup((u16 *)(area + j * 2));
 			memcpy(ethaddr[i], buf, 6);
-		} else
-			memcpy(ethaddr[i], (void *)area, 6);
+		}
 	}
 	tx4939_ethaddr_init(ethaddr[0], ethaddr[1]);
 #endif
-- 
1.5.6.3
