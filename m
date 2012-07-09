Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 09 Jul 2012 04:48:32 +0200 (CEST)
Received: from [69.28.251.93] ([69.28.251.93]:45214 "EHLO b32.net"
        rhost-flags-FAIL-FAIL-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1903471Ab2GICr5 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 9 Jul 2012 04:47:57 +0200
Received: (qmail 24398 invoked from network); 9 Jul 2012 02:47:54 -0000
Received: from unknown (HELO vps-1001064-677.cp.jvds.com) (127.0.0.1)
  by 127.0.0.1 with (DHE-RSA-AES128-SHA encrypted) SMTP; 9 Jul 2012 02:47:54 -0000
Received: by vps-1001064-677.cp.jvds.com (sSMTP sendmail emulation); Sun, 08 Jul 2012 19:47:54 -0700
From:   Kevin Cernekee <cernekee@gmail.com>
To:     ralf@linux-mips.org
Cc:     <ffainelli@freebox.fr>, <mbizon@freebox.fr>,
        <jonas.gorski@gmail.com>, <linux-mips@linux-mips.org>
Subject: [PATCH V2 3/7] MIPS: BCM63XX: Add new IUDMA definitions needed for USBD
Date:   Sun, 08 Jul 2012 19:41:19 -0700
Message-Id: <8dea894598ce64bd8834a48e395dcd07@localhost>
In-Reply-To: <a4b88fe5a7ef864d5adce1145d8bbf6c@localhost>
References: <a4b88fe5a7ef864d5adce1145d8bbf6c@localhost>
User-Agent: vim 7.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-archive-position: 33885
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

Signed-off-by: Kevin Cernekee <cernekee@gmail.com>
---
 arch/mips/include/asm/mach-bcm63xx/bcm63xx_iudma.h |  4 ++++
 arch/mips/include/asm/mach-bcm63xx/bcm63xx_regs.h  | 12 ++++++++++--
 2 files changed, 14 insertions(+), 2 deletions(-)

V2:

These go into bcm63xx_iudma.h now; see previous post.

Add BUFHALT bit.

Use ENETDMAC_* instead of ENETDMA_* where warranted (the constants are
identical, name change only).

diff --git a/arch/mips/include/asm/mach-bcm63xx/bcm63xx_iudma.h b/arch/mips/include/asm/mach-bcm63xx/bcm63xx_iudma.h
index 358cf28..a5bbff3 100644
--- a/arch/mips/include/asm/mach-bcm63xx/bcm63xx_iudma.h
+++ b/arch/mips/include/asm/mach-bcm63xx/bcm63xx_iudma.h
@@ -11,6 +11,7 @@ struct bcm_enet_desc {
 	u32 address;
 };
 
+/* control */
 #define DMADESC_LENGTH_SHIFT	16
 #define DMADESC_LENGTH_MASK	(0xfff << DMADESC_LENGTH_SHIFT)
 #define DMADESC_OWNER_MASK	(1 << 15)
@@ -18,7 +19,10 @@ struct bcm_enet_desc {
 #define DMADESC_SOP_MASK	(1 << 13)
 #define DMADESC_ESOP_MASK	(DMADESC_EOP_MASK | DMADESC_SOP_MASK)
 #define DMADESC_WRAP_MASK	(1 << 12)
+#define DMADESC_USB_NOZERO_MASK	(1 << 1)
+#define DMADESC_USB_ZERO_MASK	(1 << 0)
 
+/* status */
 #define DMADESC_UNDER_MASK	(1 << 9)
 #define DMADESC_APPEND_CRC	(1 << 8)
 #define DMADESC_OVSIZE_MASK	(1 << 4)
diff --git a/arch/mips/include/asm/mach-bcm63xx/bcm63xx_regs.h b/arch/mips/include/asm/mach-bcm63xx/bcm63xx_regs.h
index 4ccc2a7..7a10112 100644
--- a/arch/mips/include/asm/mach-bcm63xx/bcm63xx_regs.h
+++ b/arch/mips/include/asm/mach-bcm63xx/bcm63xx_regs.h
@@ -670,6 +670,12 @@
 #define ENETDMA_BUFALLOC_FORCE_SHIFT	31
 #define ENETDMA_BUFALLOC_FORCE_MASK	(1 << ENETDMA_BUFALLOC_FORCE_SHIFT)
 
+/* Global interrupt status */
+#define ENETDMA_GLB_IRQSTAT_REG		(0x40)
+
+/* Global interrupt mask */
+#define ENETDMA_GLB_IRQMASK_REG		(0x44)
+
 /* Channel Configuration register */
 #define ENETDMA_CHANCFG_REG(x)		(0x100 + (x) * 0x10)
 #define ENETDMA_CHANCFG_EN_SHIFT	0
@@ -709,9 +715,11 @@
 /* Channel Configuration register */
 #define ENETDMAC_CHANCFG_REG(x)		((x) * 0x10)
 #define ENETDMAC_CHANCFG_EN_SHIFT	0
-#define ENETDMAC_CHANCFG_EN_MASK	(1 << ENETDMA_CHANCFG_EN_SHIFT)
+#define ENETDMAC_CHANCFG_EN_MASK	(1 << ENETDMAC_CHANCFG_EN_SHIFT)
 #define ENETDMAC_CHANCFG_PKTHALT_SHIFT	1
-#define ENETDMAC_CHANCFG_PKTHALT_MASK	(1 << ENETDMA_CHANCFG_PKTHALT_SHIFT)
+#define ENETDMAC_CHANCFG_PKTHALT_MASK	(1 << ENETDMAC_CHANCFG_PKTHALT_SHIFT)
+#define ENETDMAC_CHANCFG_BUFHALT_SHIFT	2
+#define ENETDMAC_CHANCFG_BUFHALT_MASK	(1 << ENETDMAC_CHANCFG_BUFHALT_SHIFT)
 
 /* Interrupt Control/Status register */
 #define ENETDMAC_IR_REG(x)		(0x4 + (x) * 0x10)
-- 
1.7.11.1
