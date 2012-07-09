Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 09 Jul 2012 04:48:04 +0200 (CEST)
Received: from [69.28.251.93] ([69.28.251.93]:45206 "EHLO b32.net"
        rhost-flags-FAIL-FAIL-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1903438Ab2GICrz (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 9 Jul 2012 04:47:55 +0200
Received: (qmail 24390 invoked from network); 9 Jul 2012 02:47:51 -0000
Received: from unknown (HELO vps-1001064-677.cp.jvds.com) (127.0.0.1)
  by 127.0.0.1 with (DHE-RSA-AES128-SHA encrypted) SMTP; 9 Jul 2012 02:47:51 -0000
Received: by vps-1001064-677.cp.jvds.com (sSMTP sendmail emulation); Sun, 08 Jul 2012 19:47:51 -0700
From:   Kevin Cernekee <cernekee@gmail.com>
To:     ralf@linux-mips.org
Cc:     <ffainelli@freebox.fr>, <mbizon@freebox.fr>,
        <jonas.gorski@gmail.com>, <linux-mips@linux-mips.org>
Subject: [PATCH V2 2/7] MIPS: BCM63XX: Move DMA descriptor definition into
 common header file
Date:   Sun, 08 Jul 2012 19:41:18 -0700
Message-Id: <a4b88fe5a7ef864d5adce1145d8bbf6c@localhost>
User-Agent: vim 7.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-archive-position: 33884
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: cernekee@gmail.com
Precedence: bulk
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-Id: linux-mips <linux-mips.eddie.linux-mips.org>
X-List-ID: linux-mips <linux-mips.eddie.linux-mips.org>
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

The "IUDMA" engine used by bcm63xx_enet is also used by other blocks,
such as the USB 2.0 device.  Move the definitions into a common file so
that they do not need to be duplicated in each driver.

Signed-off-by: Kevin Cernekee <cernekee@gmail.com>
---
 arch/mips/include/asm/mach-bcm63xx/bcm63xx_iudma.h | 34 ++++++++++++++++++++++
 drivers/net/ethernet/broadcom/bcm63xx_enet.h       | 30 +------------------
 2 files changed, 35 insertions(+), 29 deletions(-)
 create mode 100644 arch/mips/include/asm/mach-bcm63xx/bcm63xx_iudma.h

V2:

Move this into a separate, non-enet-related header file.

I'll submit another patch to rename "enet" / "DMADESC" to "IUDMA" after
Maxime's enetsw patches are merged.

diff --git a/arch/mips/include/asm/mach-bcm63xx/bcm63xx_iudma.h b/arch/mips/include/asm/mach-bcm63xx/bcm63xx_iudma.h
new file mode 100644
index 0000000..358cf28
--- /dev/null
+++ b/arch/mips/include/asm/mach-bcm63xx/bcm63xx_iudma.h
@@ -0,0 +1,34 @@
+#ifndef BCM63XX_IUDMA_H_
+#define BCM63XX_IUDMA_H_
+
+#include <linux/types.h>
+
+/*
+ * rx/tx dma descriptor
+ */
+struct bcm_enet_desc {
+	u32 len_stat;
+	u32 address;
+};
+
+#define DMADESC_LENGTH_SHIFT	16
+#define DMADESC_LENGTH_MASK	(0xfff << DMADESC_LENGTH_SHIFT)
+#define DMADESC_OWNER_MASK	(1 << 15)
+#define DMADESC_EOP_MASK	(1 << 14)
+#define DMADESC_SOP_MASK	(1 << 13)
+#define DMADESC_ESOP_MASK	(DMADESC_EOP_MASK | DMADESC_SOP_MASK)
+#define DMADESC_WRAP_MASK	(1 << 12)
+
+#define DMADESC_UNDER_MASK	(1 << 9)
+#define DMADESC_APPEND_CRC	(1 << 8)
+#define DMADESC_OVSIZE_MASK	(1 << 4)
+#define DMADESC_RXER_MASK	(1 << 2)
+#define DMADESC_CRC_MASK	(1 << 1)
+#define DMADESC_OV_MASK		(1 << 0)
+#define DMADESC_ERR_MASK	(DMADESC_UNDER_MASK | \
+				DMADESC_OVSIZE_MASK | \
+				DMADESC_RXER_MASK | \
+				DMADESC_CRC_MASK | \
+				DMADESC_OV_MASK)
+
+#endif /* ! BCM63XX_IUDMA_H_ */
diff --git a/drivers/net/ethernet/broadcom/bcm63xx_enet.h b/drivers/net/ethernet/broadcom/bcm63xx_enet.h
index 0e3048b..133d585 100644
--- a/drivers/net/ethernet/broadcom/bcm63xx_enet.h
+++ b/drivers/net/ethernet/broadcom/bcm63xx_enet.h
@@ -10,6 +10,7 @@
 #include <bcm63xx_regs.h>
 #include <bcm63xx_irq.h>
 #include <bcm63xx_io.h>
+#include <bcm63xx_iudma.h>
 
 /* default number of descriptor */
 #define BCMENET_DEF_RX_DESC	64
@@ -31,35 +32,6 @@
 #define BCMENET_MAX_MTU		2046
 
 /*
- * rx/tx dma descriptor
- */
-struct bcm_enet_desc {
-	u32 len_stat;
-	u32 address;
-};
-
-#define DMADESC_LENGTH_SHIFT	16
-#define DMADESC_LENGTH_MASK	(0xfff << DMADESC_LENGTH_SHIFT)
-#define DMADESC_OWNER_MASK	(1 << 15)
-#define DMADESC_EOP_MASK	(1 << 14)
-#define DMADESC_SOP_MASK	(1 << 13)
-#define DMADESC_ESOP_MASK	(DMADESC_EOP_MASK | DMADESC_SOP_MASK)
-#define DMADESC_WRAP_MASK	(1 << 12)
-
-#define DMADESC_UNDER_MASK	(1 << 9)
-#define DMADESC_APPEND_CRC	(1 << 8)
-#define DMADESC_OVSIZE_MASK	(1 << 4)
-#define DMADESC_RXER_MASK	(1 << 2)
-#define DMADESC_CRC_MASK	(1 << 1)
-#define DMADESC_OV_MASK		(1 << 0)
-#define DMADESC_ERR_MASK	(DMADESC_UNDER_MASK | \
-				DMADESC_OVSIZE_MASK | \
-				DMADESC_RXER_MASK | \
-				DMADESC_CRC_MASK | \
-				DMADESC_OV_MASK)
-
-
-/*
  * MIB Counters register definitions
 */
 #define ETH_MIB_TX_GD_OCTETS			0
-- 
1.7.11.1
