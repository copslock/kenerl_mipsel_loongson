Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 23 Jun 2012 07:24:42 +0200 (CEST)
Received: from [69.28.251.93] ([69.28.251.93]:53272 "EHLO b32.net"
        rhost-flags-FAIL-FAIL-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1903384Ab2FWFXs (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sat, 23 Jun 2012 07:23:48 +0200
Received: (qmail 25609 invoked from network); 23 Jun 2012 05:23:45 -0000
Received: from unknown (HELO vps-1001064-677.cp.jvds.com) (127.0.0.1)
  by 127.0.0.1 with (DHE-RSA-AES128-SHA encrypted) SMTP; 23 Jun 2012 05:23:45 -0000
Received: by vps-1001064-677.cp.jvds.com (sSMTP sendmail emulation); Fri, 22 Jun 2012 22:23:45 -0700
From:   Kevin Cernekee <cernekee@gmail.com>
To:     ralf@linux-mips.org
Cc:     <ffainelli@freebox.fr>, <mbizon@freebox.fr>,
        <jonas.gorski@gmail.com>, <linux-mips@linux-mips.org>
Subject: [PATCH 2/7] MIPS: BCM63XX: Move DMA descriptor definition into
 common header file
Date:   Fri, 22 Jun 2012 22:14:52 -0700
Message-Id: <3c614d8672835e3950bddd7adbcecf05@localhost>
In-Reply-To: <0f67eabbb0d5c59add27e42a08b94944@localhost>
References: <0f67eabbb0d5c59add27e42a08b94944@localhost>
User-Agent: vim 7.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-archive-position: 33791
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
 .../include/asm/mach-bcm63xx/bcm63xx_dev_enet.h    | 29 +++++++++++++++++++++
 drivers/net/ethernet/broadcom/bcm63xx_enet.h       | 30 +---------------------
 2 files changed, 30 insertions(+), 29 deletions(-)

diff --git a/arch/mips/include/asm/mach-bcm63xx/bcm63xx_dev_enet.h b/arch/mips/include/asm/mach-bcm63xx/bcm63xx_dev_enet.h
index d53f611..650604e 100644
--- a/arch/mips/include/asm/mach-bcm63xx/bcm63xx_dev_enet.h
+++ b/arch/mips/include/asm/mach-bcm63xx/bcm63xx_dev_enet.h
@@ -3,6 +3,7 @@
 
 #include <linux/if_ether.h>
 #include <linux/init.h>
+#include <linux/types.h>
 
 /*
  * on board ethernet platform data
@@ -42,4 +43,32 @@ struct bcm63xx_enet_platform_data {
 int __init bcm63xx_enet_register(int unit,
 				 const struct bcm63xx_enet_platform_data *pd);
 
+/*
+ * rx/tx iudma descriptor
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
 #endif /* ! BCM63XX_DEV_ENET_H_ */
diff --git a/drivers/net/ethernet/broadcom/bcm63xx_enet.h b/drivers/net/ethernet/broadcom/bcm63xx_enet.h
index 0e3048b..df19535 100644
--- a/drivers/net/ethernet/broadcom/bcm63xx_enet.h
+++ b/drivers/net/ethernet/broadcom/bcm63xx_enet.h
@@ -10,6 +10,7 @@
 #include <bcm63xx_regs.h>
 #include <bcm63xx_irq.h>
 #include <bcm63xx_io.h>
+#include <bcm63xx_dev_enet.h>
 
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
