Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 07 Jul 2007 15:57:53 +0100 (BST)
Received: from mba.ocn.ne.jp ([122.1.175.29]:8388 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S20023028AbXGGO5v (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sat, 7 Jul 2007 15:57:51 +0100
Received: from localhost (p2176-ipad32funabasi.chiba.ocn.ne.jp [221.189.134.176])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id 899C9AF49; Sat,  7 Jul 2007 23:56:29 +0900 (JST)
Date:	Sat, 07 Jul 2007 23:57:20 +0900 (JST)
Message-Id: <20070707.235720.92586759.anemo@mba.ocn.ne.jp>
To:	linux-mips@linux-mips.org
Cc:	ralf@linux-mips.org
Subject: [PATCH] rbtx4938: Provide minimum CLK API implementation
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
X-Fingerprint: 6ACA 1623 39BD 9A94 9B1A  B746 CA77 FE94 2874 D52F
X-Pgp-Public-Key: http://wwwkeys.pgp.net/pks/lookup?op=get&search=0x2874D52F
X-Mailer: Mew version 5.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <anemo@mba.ocn.ne.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15648
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

Implement a minimum CLK API to pass a base clock to spi_txx9 driver.
This patch also remove old hack (abusing resource framework) which was
only for preliminary version of the spi_txx9 driver.

Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
---
This patch can be folded into a patch in linux-queue tree titled:
"[MIPS] rbtx4938: Convert SPI codes to use generic SPI drivers"

 arch/mips/tx4938/toshiba_rbtx4938/setup.c |   37 +++++++++++++++++++++++++---
 1 files changed, 33 insertions(+), 4 deletions(-)

diff --git a/arch/mips/tx4938/toshiba_rbtx4938/setup.c b/arch/mips/tx4938/toshiba_rbtx4938/setup.c
index 330ee43..361d89a 100644
--- a/arch/mips/tx4938/toshiba_rbtx4938/setup.c
+++ b/arch/mips/tx4938/toshiba_rbtx4938/setup.c
@@ -20,6 +20,7 @@
 #include <linux/pci.h>
 #include <linux/pm.h>
 #include <linux/platform_device.h>
+#include <linux/clk.h>
 
 #include <asm/wbflush.h>
 #include <asm/reboot.h>
@@ -1121,10 +1122,6 @@ static void __init txx9_spi_init(unsigned long base, int irq)
 		}, {
 			.start	= irq,
 			.flags	= IORESOURCE_IRQ,
-		}, {
-			.name	= "baseclk",
-			.start	= txx9_gbus_clock / 2 / 4,
-			.flags	= IORESOURCE_IRQ,
 		},
 	};
 	platform_device_register_simple("txx9spi", 0,
@@ -1149,3 +1146,35 @@ static int __init rbtx4938_spi_init(void)
 	return 0;
 }
 arch_initcall(rbtx4938_spi_init);
+
+/* Minimum CLK support */
+
+struct clk *clk_get(struct device *dev, const char *id)
+{
+	if (!strcmp(id, "spi-baseclk"))
+		return (struct clk *)(txx9_gbus_clock / 2 / 4);
+	return ERR_PTR(-ENOENT);
+}
+EXPORT_SYMBOL(clk_get);
+
+int clk_enable(struct clk *clk)
+{
+	return 0;
+}
+EXPORT_SYMBOL(clk_enable);
+
+void clk_disable(struct clk *clk)
+{
+}
+EXPORT_SYMBOL(clk_disable);
+
+unsigned long clk_get_rate(struct clk *clk)
+{
+	return (unsigned long)clk;
+}
+EXPORT_SYMBOL(clk_get_rate);
+
+void clk_put(struct clk *clk)
+{
+}
+EXPORT_SYMBOL(clk_put);
