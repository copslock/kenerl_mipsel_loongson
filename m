Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 23 Jun 2012 07:25:07 +0200 (CEST)
Received: from [69.28.251.93] ([69.28.251.93]:53282 "EHLO b32.net"
        rhost-flags-FAIL-FAIL-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1903664Ab2FWFXv (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sat, 23 Jun 2012 07:23:51 +0200
Received: (qmail 25617 invoked from network); 23 Jun 2012 05:23:48 -0000
Received: from unknown (HELO vps-1001064-677.cp.jvds.com) (127.0.0.1)
  by 127.0.0.1 with (DHE-RSA-AES128-SHA encrypted) SMTP; 23 Jun 2012 05:23:48 -0000
Received: by vps-1001064-677.cp.jvds.com (sSMTP sendmail emulation); Fri, 22 Jun 2012 22:23:48 -0700
From:   Kevin Cernekee <cernekee@gmail.com>
To:     ralf@linux-mips.org
Cc:     <ffainelli@freebox.fr>, <mbizon@freebox.fr>,
        <jonas.gorski@gmail.com>, <linux-mips@linux-mips.org>
Subject: [PATCH 3/7] MIPS: BCM63XX: Add new IUDMA definitions needed for USBD
Date:   Fri, 22 Jun 2012 22:14:53 -0700
Message-Id: <2f601e4f177d650124f87540921d069b@localhost>
In-Reply-To: <0f67eabbb0d5c59add27e42a08b94944@localhost>
References: <0f67eabbb0d5c59add27e42a08b94944@localhost>
User-Agent: vim 7.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-archive-position: 33792
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
 arch/mips/include/asm/mach-bcm63xx/bcm63xx_dev_enet.h | 3 +++
 arch/mips/include/asm/mach-bcm63xx/bcm63xx_regs.h     | 6 ++++++
 2 files changed, 9 insertions(+)

diff --git a/arch/mips/include/asm/mach-bcm63xx/bcm63xx_dev_enet.h b/arch/mips/include/asm/mach-bcm63xx/bcm63xx_dev_enet.h
index d12a439..b1e6026 100644
--- a/arch/mips/include/asm/mach-bcm63xx/bcm63xx_dev_enet.h
+++ b/arch/mips/include/asm/mach-bcm63xx/bcm63xx_dev_enet.h
@@ -50,6 +50,7 @@ struct bcm_enet_desc {
 	u32 address;
 };
 
+/* control */
 #define DMADESC_LENGTH_SHIFT	16
 #define DMADESC_LENGTH_MASK	(0xfff << DMADESC_LENGTH_SHIFT)
 #define DMADESC_OWNER_MASK	(1 << 15)
@@ -57,7 +58,9 @@ struct bcm_enet_desc {
 #define DMADESC_SOP_MASK	(1 << 13)
 #define DMADESC_ESOP_MASK	(DMADESC_EOP_MASK | DMADESC_SOP_MASK)
 #define DMADESC_WRAP_MASK	(1 << 12)
+#define DMADESC_USB_ZERO_MASK	(1 << 0)
 
+/* status */
 #define DMADESC_UNDER_MASK	(1 << 9)
 #define DMADESC_APPEND_CRC	(1 << 8)
 #define DMADESC_OVSIZE_MASK	(1 << 4)
diff --git a/arch/mips/include/asm/mach-bcm63xx/bcm63xx_regs.h b/arch/mips/include/asm/mach-bcm63xx/bcm63xx_regs.h
index 4ccc2a7..b970940 100644
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
-- 
1.7.11.1
