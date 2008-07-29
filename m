Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 29 Jul 2008 14:08:28 +0100 (BST)
Received: from mba.ocn.ne.jp ([122.1.235.107]:240 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S20025519AbYG2NIS (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 29 Jul 2008 14:08:18 +0100
Received: from localhost (p7108-ipad203funabasi.chiba.ocn.ne.jp [222.146.86.108])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id 67A02A9FC; Tue, 29 Jul 2008 22:08:10 +0900 (JST)
Date:	Tue, 29 Jul 2008 22:10:08 +0900 (JST)
Message-Id: <20080729.221008.102581021.anemo@mba.ocn.ne.jp>
To:	linux-mips@linux-mips.org
Cc:	ralf@linux-mips.org
Subject: [PATCH 1/3] txx9: Support early_printk
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
X-archive-position: 20014
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

Kill jmr3927-specific prom_putchar and add txx9-generic prom_putchar
to support early_printk.

Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
---
This patch can be applied on top of my txx9 patch series and mips-kgdb patches.

 arch/mips/txx9/Kconfig          |    3 +++
 arch/mips/txx9/generic/setup.c  |   31 +++++++++++++++++++++++++++++++
 arch/mips/txx9/jmr3927/prom.c   |   17 +----------------
 arch/mips/txx9/rbtx4927/prom.c  |    1 +
 arch/mips/txx9/rbtx4938/prom.c  |    1 +
 include/asm-mips/txx9/generic.h |    9 +++++++++
 6 files changed, 46 insertions(+), 16 deletions(-)

diff --git a/arch/mips/txx9/Kconfig b/arch/mips/txx9/Kconfig
index 7acdedd..caec917 100644
--- a/arch/mips/txx9/Kconfig
+++ b/arch/mips/txx9/Kconfig
@@ -30,6 +30,7 @@ config SOC_TX3927
 	select IRQ_TXX9
 	select SWAP_IO_SPACE
 	select SYS_HAS_CPU_TX39XX
+	select SYS_HAS_EARLY_PRINTK
 	select SYS_SUPPORTS_32BIT_KERNEL
 	select SYS_SUPPORTS_LITTLE_ENDIAN
 	select SYS_SUPPORTS_BIG_ENDIAN
@@ -49,6 +50,7 @@ config SOC_TX4927
 	select PCI_TX4927
 	select SWAP_IO_SPACE
 	select SYS_HAS_CPU_TX49XX
+	select SYS_HAS_EARLY_PRINTK
 	select SYS_SUPPORTS_32BIT_KERNEL
 	select SYS_SUPPORTS_64BIT_KERNEL
 	select SYS_SUPPORTS_LITTLE_ENDIAN
@@ -69,6 +71,7 @@ config SOC_TX4938
 	select PCI_TX4927
 	select SWAP_IO_SPACE
 	select SYS_HAS_CPU_TX49XX
+	select SYS_HAS_EARLY_PRINTK
 	select SYS_SUPPORTS_32BIT_KERNEL
 	select SYS_SUPPORTS_64BIT_KERNEL
 	select SYS_SUPPORTS_LITTLE_ENDIAN
diff --git a/arch/mips/txx9/generic/setup.c b/arch/mips/txx9/generic/setup.c
index 94ce1a5..1bc57d0 100644
--- a/arch/mips/txx9/generic/setup.c
+++ b/arch/mips/txx9/generic/setup.c
@@ -271,6 +271,37 @@ void __init txx9_sio_init(unsigned long baseaddr, int irq,
 #endif /* CONFIG_SERIAL_TXX9 */
 }
 
+#ifdef CONFIG_EARLY_PRINTK
+static void __init null_prom_putchar(char c)
+{
+}
+void (*txx9_prom_putchar)(char c) __initdata = null_prom_putchar;
+
+void __init prom_putchar(char c)
+{
+	txx9_prom_putchar(c);
+}
+
+static void __iomem *early_txx9_sio_port;
+
+static void __init early_txx9_sio_putchar(char c)
+{
+#define TXX9_SICISR	0x0c
+#define TXX9_SITFIFO	0x1c
+#define TXX9_SICISR_TXALS	0x00000002
+	while (!(__raw_readl(early_txx9_sio_port + TXX9_SICISR) &
+		 TXX9_SICISR_TXALS))
+		;
+	__raw_writel(c, early_txx9_sio_port + TXX9_SITFIFO);
+}
+
+void __init txx9_sio_putchar_init(unsigned long baseaddr)
+{
+	early_txx9_sio_port = ioremap(baseaddr, 0x24);
+	txx9_prom_putchar = early_txx9_sio_putchar;
+}
+#endif /* CONFIG_EARLY_PRINTK */
+
 /* wrappers */
 void __init plat_mem_setup(void)
 {
diff --git a/arch/mips/txx9/jmr3927/prom.c b/arch/mips/txx9/jmr3927/prom.c
index 23df38c..70c4c8e 100644
--- a/arch/mips/txx9/jmr3927/prom.c
+++ b/arch/mips/txx9/jmr3927/prom.c
@@ -41,22 +41,6 @@
 #include <asm/txx9/generic.h>
 #include <asm/txx9/jmr3927.h>
 
-#define TIMEOUT       0xffffff
-
-void
-prom_putchar(char c)
-{
-        int i = 0;
-
-        do {
-            i++;
-            if (i>TIMEOUT)
-                break;
-        } while (!(tx3927_sioptr(1)->cisr & TXx927_SICISR_TXALS));
-	tx3927_sioptr(1)->tfifo = c;
-	return;
-}
-
 void __init jmr3927_prom_init(void)
 {
 	/* CCFG */
@@ -65,4 +49,5 @@ void __init jmr3927_prom_init(void)
 
 	prom_init_cmdline();
 	add_memory_region(0, JMR3927_SDRAM_SIZE, BOOT_MEM_RAM);
+	txx9_sio_putchar_init(TX3927_SIO_REG(1));
 }
diff --git a/arch/mips/txx9/rbtx4927/prom.c b/arch/mips/txx9/rbtx4927/prom.c
index 5c0de54..1dc0a5b 100644
--- a/arch/mips/txx9/rbtx4927/prom.c
+++ b/arch/mips/txx9/rbtx4927/prom.c
@@ -38,4 +38,5 @@ void __init rbtx4927_prom_init(void)
 {
 	prom_init_cmdline();
 	add_memory_region(0, tx4927_get_mem_size(), BOOT_MEM_RAM);
+	txx9_sio_putchar_init(TX4927_SIO_REG(0) & 0xfffffffffULL);
 }
diff --git a/arch/mips/txx9/rbtx4938/prom.c b/arch/mips/txx9/rbtx4938/prom.c
index ee18951..d73123c 100644
--- a/arch/mips/txx9/rbtx4938/prom.c
+++ b/arch/mips/txx9/rbtx4938/prom.c
@@ -22,4 +22,5 @@ void __init rbtx4938_prom_init(void)
 	prom_init_cmdline();
 #endif
 	add_memory_region(0, tx4938_get_mem_size(), BOOT_MEM_RAM);
+	txx9_sio_putchar_init(TX4938_SIO_REG(0) & 0xfffffffffULL);
 }
diff --git a/include/asm-mips/txx9/generic.h b/include/asm-mips/txx9/generic.h
index a295aaa..5b1ccf9 100644
--- a/include/asm-mips/txx9/generic.h
+++ b/include/asm-mips/txx9/generic.h
@@ -49,5 +49,14 @@ void txx9_spi_init(int busid, unsigned long base, int irq);
 void txx9_ethaddr_init(unsigned int id, unsigned char *ethaddr);
 void txx9_sio_init(unsigned long baseaddr, int irq,
 		   unsigned int line, unsigned int sclk, int nocts);
+void prom_putchar(char c);
+#ifdef CONFIG_EARLY_PRINTK
+extern void (*txx9_prom_putchar)(char c);
+void txx9_sio_putchar_init(unsigned long baseaddr);
+#else
+static inline void txx9_sio_putchar_init(unsigned long baseaddr)
+{
+}
+#endif
 
 #endif /* __ASM_TXX9_GENERIC_H */
-- 
1.5.5.5
