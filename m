Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 29 Jul 2008 09:11:04 +0100 (BST)
Received: from fnoeppeil48.netpark.at ([217.175.205.176]:5091 "EHLO
	roarinelk.homelinux.net") by ftp.linux-mips.org with ESMTP
	id S20022988AbYG2IKy (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 29 Jul 2008 09:10:54 +0100
Received: (qmail 5193 invoked by uid 1000); 29 Jul 2008 10:10:49 +0200
Date:	Tue, 29 Jul 2008 10:10:49 +0200
From:	Manuel Lauss <mano@roarinelk.homelinux.net>
To:	Pierre Ossman <drzeus@drzeus.cx>
Cc:	Sergei Shtylyov <sshtylyov@ru.mvista.com>,
	linux-mips@linux-mips.org
Subject: [PATCH v2] au1xmmc: raise segment size limit.
Message-ID: <20080729081049.GB3908@roarinelk.homelinux.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.16 (2007-06-09)
Return-Path: <mano@roarinelk.homelinux.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20011
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mano@roarinelk.homelinux.net
Precedence: bulk
X-list: linux-mips

Hello Pierre, 

This is a new version of the previous patch with fixed commit text.

Please apply this patch as it fixes an oops when MMC-DMA and network
traffic are active at the same time;  this seems to be a 2.6.27-only bug
as the current au1xmmc source work fine on 2.6.26.

Thank you,
	Manuel Lauss

--- 

Raise the DMA block size limit from 2048 bytes to the maximum supported
by the DMA controllers on the chip (64KB on Au1100, 4MB on Au1200).

This gives a very small performance boost and apparently fixes an oops
when MMC-DMA and network traffic are active at the same time.

Signed-off-by: Manuel Lauss <mano@roarinelk.homelinux.net>
---
 drivers/mmc/host/au1xmmc.c |    8 +++++++-
 1 files changed, 7 insertions(+), 1 deletions(-)

diff --git a/drivers/mmc/host/au1xmmc.c b/drivers/mmc/host/au1xmmc.c
index 99b2091..d3f5561 100644
--- a/drivers/mmc/host/au1xmmc.c
+++ b/drivers/mmc/host/au1xmmc.c
@@ -61,7 +61,13 @@
 
 /* Hardware definitions */
 #define AU1XMMC_DESCRIPTOR_COUNT 1
-#define AU1XMMC_DESCRIPTOR_SIZE  2048
+
+/* max DMA seg size: 64KB on Au1100, 4MB on Au1200 */
+#ifdef CONFIG_SOC_AU1100
+#define AU1XMMC_DESCRIPTOR_SIZE 0x0000ffff
+#else	/* Au1200 */
+#define AU1XMMC_DESCRIPTOR_SIZE 0x003fffff
+#endif
 
 #define AU1XMMC_OCR (MMC_VDD_27_28 | MMC_VDD_28_29 | MMC_VDD_29_30 | \
 		     MMC_VDD_30_31 | MMC_VDD_31_32 | MMC_VDD_32_33 | \
-- 
1.5.6.3
