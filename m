Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 17 Jul 2008 16:42:07 +0100 (BST)
Received: from mba.ocn.ne.jp ([122.1.235.107]:10963 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S28585301AbYGQPmE (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 17 Jul 2008 16:42:04 +0100
Received: from localhost (p3135-ipad307funabasi.chiba.ocn.ne.jp [123.217.181.135])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id A138FAB9A; Fri, 18 Jul 2008 00:41:58 +0900 (JST)
Date:	Fri, 18 Jul 2008 00:43:48 +0900 (JST)
Message-Id: <20080718.004348.41011911.anemo@mba.ocn.ne.jp>
To:	linux-mips@linux-mips.org
Cc:	ralf@linux-mips.org
Subject: [PATCH] txx9: miscellaneous build fixes
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
X-archive-position: 19876
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

* Fix build if only RBTX4927 or RBTX4938 was selected.
* Move gpio helpers to generic part.
* Select SOC_TX4938 for RBTX4927/37 board.
* Fix parent of rbtx4938_fpga_resource.

Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
---
 arch/mips/txx9/Kconfig          |    2 ++
 arch/mips/txx9/generic/setup.c  |   20 ++++++++++++++++++++
 arch/mips/txx9/rbtx4938/setup.c |   14 +-------------
 3 files changed, 23 insertions(+), 13 deletions(-)

diff --git a/arch/mips/txx9/Kconfig b/arch/mips/txx9/Kconfig
index b92a134..6de4c5a 100644
--- a/arch/mips/txx9/Kconfig
+++ b/arch/mips/txx9/Kconfig
@@ -7,6 +7,8 @@ config TOSHIBA_RBTX4927
 	bool "Toshiba RBTX49[23]7 board"
 	depends on MACH_TX49XX
 	select SOC_TX4927
+	# TX4937 is subset of TX4938
+	select SOC_TX4938
 	help
 	  This Toshiba board is based on the TX4927 processor. Say Y here to
 	  support this machine type
diff --git a/arch/mips/txx9/generic/setup.c b/arch/mips/txx9/generic/setup.c
index 5afc5d5..8caef07 100644
--- a/arch/mips/txx9/generic/setup.c
+++ b/arch/mips/txx9/generic/setup.c
@@ -94,6 +94,22 @@ void clk_put(struct clk *clk)
 }
 EXPORT_SYMBOL(clk_put);
 
+/* GPIO support */
+
+#ifdef CONFIG_GENERIC_GPIO
+int gpio_to_irq(unsigned gpio)
+{
+	return -EINVAL;
+}
+EXPORT_SYMBOL(gpio_to_irq);
+
+int irq_to_gpio(unsigned irq)
+{
+	return -EINVAL;
+}
+EXPORT_SYMBOL(irq_to_gpio);
+#endif
+
 extern struct txx9_board_vec jmr3927_vec;
 extern struct txx9_board_vec rbtx4927_vec;
 extern struct txx9_board_vec rbtx4937_vec;
@@ -126,15 +142,19 @@ void __init prom_init(void)
 #endif
 #ifdef CONFIG_CPU_TX49XX
 	switch (TX4938_REV_PCODE()) {
+#ifdef CONFIG_TOSHIBA_RBTX4927
 	case 0x4927:
 		txx9_board_vec = &rbtx4927_vec;
 		break;
 	case 0x4937:
 		txx9_board_vec = &rbtx4937_vec;
 		break;
+#endif
+#ifdef CONFIG_TOSHIBA_RBTX4938
 	case 0x4938:
 		txx9_board_vec = &rbtx4938_vec;
 		break;
+#endif
 	}
 #endif
 
diff --git a/arch/mips/txx9/rbtx4938/setup.c b/arch/mips/txx9/rbtx4938/setup.c
index aaa987a..c2da923 100644
--- a/arch/mips/txx9/rbtx4938/setup.c
+++ b/arch/mips/txx9/rbtx4938/setup.c
@@ -457,7 +457,7 @@ static void __init rbtx4938_mem_setup(void)
 	rbtx4938_fpga_resource.start = CPHYSADDR(RBTX4938_FPGA_REG_ADDR);
 	rbtx4938_fpga_resource.end = CPHYSADDR(RBTX4938_FPGA_REG_ADDR) + 0xffff;
 	rbtx4938_fpga_resource.flags = IORESOURCE_MEM | IORESOURCE_BUSY;
-	if (request_resource(&iomem_resource, &rbtx4938_fpga_resource))
+	if (request_resource(&txx9_ce_res[2], &rbtx4938_fpga_resource))
 		printk("request resource for fpga failed\n");
 
 	_machine_restart = rbtx4938_machine_restart;
@@ -488,18 +488,6 @@ static int __init rbtx4938_ne_init(void)
 	return IS_ERR(dev) ? PTR_ERR(dev) : 0;
 }
 
-/* GPIO support */
-
-int gpio_to_irq(unsigned gpio)
-{
-	return -EINVAL;
-}
-
-int irq_to_gpio(unsigned irq)
-{
-	return -EINVAL;
-}
-
 static DEFINE_SPINLOCK(rbtx4938_spi_gpio_lock);
 
 static void rbtx4938_spi_gpio_set(struct gpio_chip *chip, unsigned int offset,
