Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 11 Jul 2008 15:26:21 +0100 (BST)
Received: from mba.ocn.ne.jp ([122.1.235.107]:40673 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S20031095AbYGKO0R (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 11 Jul 2008 15:26:17 +0100
Received: from localhost (p1011-ipad211funabasi.chiba.ocn.ne.jp [58.91.157.11])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id E32D1AB97; Fri, 11 Jul 2008 23:26:08 +0900 (JST)
Date:	Fri, 11 Jul 2008 23:27:54 +0900 (JST)
Message-Id: <20080711.232754.07644442.anemo@mba.ocn.ne.jp>
To:	linux-mips@linux-mips.org
Cc:	ralf@linux-mips.org
Subject: [PATCH 1/2] txx9: Make single kernel can support multiple boards
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
X-archive-position: 19780
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

Make single kernel can be used on RBTX4927/37/38.  Also make
some SoC-specific code independent from board-specific code.

Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
---
 arch/mips/Kconfig                   |   67 +-------------
 arch/mips/Makefile                  |   21 +++--
 arch/mips/pci/Makefile              |    9 +-
 arch/mips/pci/fixup-jmr3927.c       |    8 +--
 arch/mips/pci/fixup-rbtx4927.c      |    8 +--
 arch/mips/pci/fixup-rbtx4938.c      |   11 +--
 arch/mips/txx9/Kconfig              |   82 ++++++++++++++++-
 arch/mips/txx9/generic/Makefile     |    4 +-
 arch/mips/txx9/generic/irq_tx4927.c |   33 +------
 arch/mips/txx9/generic/irq_tx4938.c |   31 +------
 arch/mips/txx9/generic/pci.c        |   11 +++
 arch/mips/txx9/generic/setup.c      |  169 +++++++++++++++++++++++++++++++++++
 arch/mips/txx9/jmr3927/Makefile     |    2 +-
 arch/mips/txx9/jmr3927/init.c       |   57 ------------
 arch/mips/txx9/jmr3927/irq.c        |   45 ++++-----
 arch/mips/txx9/jmr3927/prom.c       |   46 +++-------
 arch/mips/txx9/jmr3927/setup.c      |   54 +++++-------
 arch/mips/txx9/rbtx4927/irq.c       |   57 ++++++------
 arch/mips/txx9/rbtx4927/prom.c      |   52 +----------
 arch/mips/txx9/rbtx4927/setup.c     |   78 ++++++++---------
 arch/mips/txx9/rbtx4938/irq.c       |   48 ++++++----
 arch/mips/txx9/rbtx4938/prom.c      |   49 +----------
 arch/mips/txx9/rbtx4938/setup.c     |   64 +++++---------
 include/asm-mips/txx9/generic.h     |   18 ++++
 include/asm-mips/txx9/jmr3927.h     |    5 +
 include/asm-mips/txx9/rbtx4927.h    |   13 ++-
 include/asm-mips/txx9/rbtx4938.h    |   36 ++------
 include/asm-mips/txx9/tx4927.h      |   19 +---
 include/asm-mips/txx9/tx4938.h      |    8 +-
 29 files changed, 520 insertions(+), 585 deletions(-)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 591dedc..d23204e 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -552,66 +552,11 @@ config SNI_RM
 	  Technology and now in turn merged with Fujitsu.  Say Y here to
 	  support this machine type.
 
-config TOSHIBA_JMR3927
-	bool "Toshiba JMR-TX3927 board"
-	select CEVT_TXX9
-	select DMA_NONCOHERENT
-	select HW_HAS_PCI
-	select MIPS_TX3927
-	select IRQ_TXX9
-	select SWAP_IO_SPACE
-	select SYS_HAS_CPU_TX39XX
-	select SYS_SUPPORTS_32BIT_KERNEL
-	select SYS_SUPPORTS_LITTLE_ENDIAN
-	select SYS_SUPPORTS_BIG_ENDIAN
-	select GENERIC_HARDIRQS_NO__DO_IRQ
-	select GPIO_TXX9
+config MACH_TX39XX
+	bool "Toshiba TX39 series based machines"
 
-config TOSHIBA_RBTX4927
-	bool "Toshiba RBTX49[23]7 board"
-	select CEVT_R4K
-	select CSRC_R4K
-	select CEVT_TXX9
-	select DMA_NONCOHERENT
-	select HAS_TXX9_SERIAL
-	select HW_HAS_PCI
-	select IRQ_CPU
-	select IRQ_TXX9
-	select PCI_TX4927
-	select SWAP_IO_SPACE
-	select SYS_HAS_CPU_TX49XX
-	select SYS_SUPPORTS_32BIT_KERNEL
-	select SYS_SUPPORTS_64BIT_KERNEL
-	select SYS_SUPPORTS_LITTLE_ENDIAN
-	select SYS_SUPPORTS_BIG_ENDIAN
-	select SYS_SUPPORTS_KGDB
-	select GENERIC_HARDIRQS_NO__DO_IRQ
-	help
-	  This Toshiba board is based on the TX4927 processor. Say Y here to
-	  support this machine type
-
-config TOSHIBA_RBTX4938
-	bool "Toshiba RBTX4938 board"
-	select CEVT_R4K
-	select CSRC_R4K
-	select CEVT_TXX9
-	select DMA_NONCOHERENT
-	select HAS_TXX9_SERIAL
-	select HW_HAS_PCI
-	select IRQ_CPU
-	select IRQ_TXX9
-	select PCI_TX4927
-	select SWAP_IO_SPACE
-	select SYS_HAS_CPU_TX49XX
-	select SYS_SUPPORTS_32BIT_KERNEL
-	select SYS_SUPPORTS_LITTLE_ENDIAN
-	select SYS_SUPPORTS_BIG_ENDIAN
-	select SYS_SUPPORTS_KGDB
-	select GENERIC_HARDIRQS_NO__DO_IRQ
-	select GPIO_TXX9
-	help
-	  This Toshiba board is based on the TX4938 processor. Say Y here to
-	  support this machine type
+config MACH_TX49XX
+	bool "Toshiba TX49 series based machines"
 
 config WR_PPMC
 	bool "Wind River PPMC board"
@@ -889,10 +834,6 @@ config PCI_GT64XXX_PCI0
 config NO_EXCEPT_FILL
 	bool
 
-config MIPS_TX3927
-	bool
-	select HAS_TXX9_SERIAL
-
 config MIPS_RM9122
 	bool
 	select SERIAL_RM9000
diff --git a/arch/mips/Makefile b/arch/mips/Makefile
index 8e1e49c..d319cd6 100644
--- a/arch/mips/Makefile
+++ b/arch/mips/Makefile
@@ -551,29 +551,30 @@ endif
 all-$(CONFIG_SNI_RM)		:= vmlinux.ecoff
 
 #
+# Common TXx9
+#
+core-$(CONFIG_MACH_TX39XX)	+= arch/mips/txx9/generic/
+cflags-$(CONFIG_MACH_TX39XX) += -Iinclude/asm-mips/mach-jmr3927
+load-$(CONFIG_MACH_TX39XX)	+= 0xffffffff80050000
+core-$(CONFIG_MACH_TX49XX)	+= arch/mips/txx9/generic/
+cflags-$(CONFIG_MACH_TX49XX) += -Iinclude/asm-mips/mach-tx49xx
+load-$(CONFIG_MACH_TX49XX)	+= 0xffffffff80100000
+
+#
 # Toshiba JMR-TX3927 board
 #
-core-$(CONFIG_TOSHIBA_JMR3927)	+= arch/mips/txx9/jmr3927/ \
-				   arch/mips/txx9/generic/
-cflags-$(CONFIG_TOSHIBA_JMR3927) += -Iinclude/asm-mips/mach-jmr3927
-load-$(CONFIG_TOSHIBA_JMR3927)	+= 0xffffffff80050000
+core-$(CONFIG_TOSHIBA_JMR3927)	+= arch/mips/txx9/jmr3927/
 
 #
 # Toshiba RBTX4927 board or
 # Toshiba RBTX4937 board
 #
 core-$(CONFIG_TOSHIBA_RBTX4927)	+= arch/mips/txx9/rbtx4927/
-core-$(CONFIG_TOSHIBA_RBTX4927)	+= arch/mips/txx9/generic/
-cflags-$(CONFIG_TOSHIBA_RBTX4927) += -Iinclude/asm-mips/mach-tx49xx
-load-$(CONFIG_TOSHIBA_RBTX4927)	+= 0xffffffff80020000
 
 #
 # Toshiba RBTX4938 board
 #
 core-$(CONFIG_TOSHIBA_RBTX4938) += arch/mips/txx9/rbtx4938/
-core-$(CONFIG_TOSHIBA_RBTX4938) += arch/mips/txx9/generic/
-cflags-$(CONFIG_TOSHIBA_RBTX4938) += -Iinclude/asm-mips/mach-tx49xx
-load-$(CONFIG_TOSHIBA_RBTX4938) += 0xffffffff80100000
 
 cflags-y			+= -Iinclude/asm-mips/mach-generic
 drivers-$(CONFIG_PCI)		+= arch/mips/pci/
diff --git a/arch/mips/pci/Makefile b/arch/mips/pci/Makefile
index 9087648..875b643 100644
--- a/arch/mips/pci/Makefile
+++ b/arch/mips/pci/Makefile
@@ -11,11 +11,10 @@ obj-$(CONFIG_MIPS_BONITO64)	+= ops-bonito64.o
 obj-$(CONFIG_PCI_GT64XXX_PCI0)	+= ops-gt64xxx_pci0.o
 obj-$(CONFIG_MIPS_MSC)		+= ops-msc.o
 obj-$(CONFIG_MIPS_NILE4)	+= ops-nile4.o
-obj-$(CONFIG_MIPS_TX3927)	+= ops-tx3927.o
+obj-$(CONFIG_SOC_TX3927)	+= ops-tx3927.o
 obj-$(CONFIG_PCI_VR41XX)	+= ops-vr41xx.o pci-vr41xx.o
 obj-$(CONFIG_NEC_CMBVR4133)	+= fixup-vr4133.o
 obj-$(CONFIG_MARKEINS)		+= ops-emma2rh.o pci-emma2rh.o fixup-emma2rh.o
-obj-$(CONFIG_PCI_TX3927)	+= ops-tx3927.o
 obj-$(CONFIG_PCI_TX4927)	+= ops-tx4927.o
 
 #
@@ -44,8 +43,10 @@ obj-$(CONFIG_TANBAC_TB0219)	+= fixup-tb0219.o
 obj-$(CONFIG_TANBAC_TB0226)	+= fixup-tb0226.o
 obj-$(CONFIG_TANBAC_TB0287)	+= fixup-tb0287.o
 obj-$(CONFIG_TOSHIBA_JMR3927)	+= fixup-jmr3927.o
-obj-$(CONFIG_TOSHIBA_RBTX4927)	+= fixup-rbtx4927.o pci-tx4927.o pci-tx4938.o
-obj-$(CONFIG_TOSHIBA_RBTX4938)	+= fixup-rbtx4938.o pci-tx4938.o
+obj-$(CONFIG_SOC_TX4927)	+= pci-tx4927.o
+obj-$(CONFIG_SOC_TX4938)	+= pci-tx4938.o
+obj-$(CONFIG_TOSHIBA_RBTX4927)	+= fixup-rbtx4927.o
+obj-$(CONFIG_TOSHIBA_RBTX4938)	+= fixup-rbtx4938.o
 obj-$(CONFIG_VICTOR_MPC30X)	+= fixup-mpc30x.o
 obj-$(CONFIG_ZAO_CAPCELLA)	+= fixup-capcella.o
 obj-$(CONFIG_WR_PPMC)		+= fixup-wrppmc.o
diff --git a/arch/mips/pci/fixup-jmr3927.c b/arch/mips/pci/fixup-jmr3927.c
index d5edaf2..0f10695 100644
--- a/arch/mips/pci/fixup-jmr3927.c
+++ b/arch/mips/pci/fixup-jmr3927.c
@@ -31,7 +31,7 @@
 #include <asm/txx9/pci.h>
 #include <asm/txx9/jmr3927.h>
 
-int __init pcibios_map_irq(const struct pci_dev *dev, u8 slot, u8 pin)
+int __init jmr3927_pci_map_irq(const struct pci_dev *dev, u8 slot, u8 pin)
 {
 	unsigned char irq = pin;
 
@@ -77,9 +77,3 @@ int __init pcibios_map_irq(const struct pci_dev *dev, u8 slot, u8 pin)
 		irq = JMR3927_IRQ_ETHER0;
 	return irq;
 }
-
-/* Do platform specific device initialization at pci_enable_device() time */
-int pcibios_plat_dev_init(struct pci_dev *dev)
-{
-	return 0;
-}
diff --git a/arch/mips/pci/fixup-rbtx4927.c b/arch/mips/pci/fixup-rbtx4927.c
index abab485..321db26 100644
--- a/arch/mips/pci/fixup-rbtx4927.c
+++ b/arch/mips/pci/fixup-rbtx4927.c
@@ -36,7 +36,7 @@
 #include <asm/txx9/pci.h>
 #include <asm/txx9/rbtx4927.h>
 
-int __init pcibios_map_irq(const struct pci_dev *dev, u8 slot, u8 pin)
+int __init rbtx4927_pci_map_irq(const struct pci_dev *dev, u8 slot, u8 pin)
 {
 	unsigned char irq = pin;
 
@@ -71,9 +71,3 @@ int __init pcibios_map_irq(const struct pci_dev *dev, u8 slot, u8 pin)
 	}
 	return irq;
 }
-
-/* Do platform specific device initialization at pci_enable_device() time */
-int pcibios_plat_dev_init(struct pci_dev *dev)
-{
-	return 0;
-}
diff --git a/arch/mips/pci/fixup-rbtx4938.c b/arch/mips/pci/fixup-rbtx4938.c
index 39c9958..a80579a 100644
--- a/arch/mips/pci/fixup-rbtx4938.c
+++ b/arch/mips/pci/fixup-rbtx4938.c
@@ -13,7 +13,7 @@
 #include <asm/txx9/pci.h>
 #include <asm/txx9/rbtx4938.h>
 
-int __init pcibios_map_irq(const struct pci_dev *dev, u8 slot, u8 pin)
+int __init rbtx4938_pci_map_irq(const struct pci_dev *dev, u8 slot, u8 pin)
 {
 	int irq = tx4938_pcic1_map_irq(dev, slot);
 
@@ -51,12 +51,3 @@ int __init pcibios_map_irq(const struct pci_dev *dev, u8 slot, u8 pin)
 	}
 	return irq;
 }
-
-/*
- * Do platform specific device initialization at pci_enable_device() time
- */
-int pcibios_plat_dev_init(struct pci_dev *dev)
-{
-	return 0;
-}
-
diff --git a/arch/mips/txx9/Kconfig b/arch/mips/txx9/Kconfig
index b8cdb19..b92a134 100644
--- a/arch/mips/txx9/Kconfig
+++ b/arch/mips/txx9/Kconfig
@@ -1,11 +1,89 @@
+config TOSHIBA_JMR3927
+	bool "Toshiba JMR-TX3927 board"
+	depends on MACH_TX39XX
+	select SOC_TX3927
+
+config TOSHIBA_RBTX4927
+	bool "Toshiba RBTX49[23]7 board"
+	depends on MACH_TX49XX
+	select SOC_TX4927
+	help
+	  This Toshiba board is based on the TX4927 processor. Say Y here to
+	  support this machine type
+
+config TOSHIBA_RBTX4938
+	bool "Toshiba RBTX4938 board"
+	depends on MACH_TX49XX
+	select SOC_TX4938
+	help
+	  This Toshiba board is based on the TX4938 processor. Say Y here to
+	  support this machine type
+
+config SOC_TX3927
+	bool
+	select CEVT_TXX9
+	select DMA_NONCOHERENT
+	select HAS_TXX9_SERIAL
+	select HW_HAS_PCI
+	select IRQ_TXX9
+	select SWAP_IO_SPACE
+	select SYS_HAS_CPU_TX39XX
+	select SYS_SUPPORTS_32BIT_KERNEL
+	select SYS_SUPPORTS_LITTLE_ENDIAN
+	select SYS_SUPPORTS_BIG_ENDIAN
+	select GENERIC_HARDIRQS_NO__DO_IRQ
+	select GPIO_TXX9
+
+config SOC_TX4927
+	bool
+	select CEVT_R4K
+	select CSRC_R4K
+	select CEVT_TXX9
+	select DMA_NONCOHERENT
+	select HAS_TXX9_SERIAL
+	select HW_HAS_PCI
+	select IRQ_CPU
+	select IRQ_TXX9
+	select PCI_TX4927
+	select SWAP_IO_SPACE
+	select SYS_HAS_CPU_TX49XX
+	select SYS_SUPPORTS_32BIT_KERNEL
+	select SYS_SUPPORTS_64BIT_KERNEL
+	select SYS_SUPPORTS_LITTLE_ENDIAN
+	select SYS_SUPPORTS_BIG_ENDIAN
+	select SYS_SUPPORTS_KGDB
+	select GENERIC_HARDIRQS_NO__DO_IRQ
+	select GPIO_TXX9
+
+config SOC_TX4938
+	bool
+	select CEVT_R4K
+	select CSRC_R4K
+	select CEVT_TXX9
+	select DMA_NONCOHERENT
+	select HAS_TXX9_SERIAL
+	select HW_HAS_PCI
+	select IRQ_CPU
+	select IRQ_TXX9
+	select PCI_TX4927
+	select SWAP_IO_SPACE
+	select SYS_HAS_CPU_TX49XX
+	select SYS_SUPPORTS_32BIT_KERNEL
+	select SYS_SUPPORTS_64BIT_KERNEL
+	select SYS_SUPPORTS_LITTLE_ENDIAN
+	select SYS_SUPPORTS_BIG_ENDIAN
+	select SYS_SUPPORTS_KGDB
+	select GENERIC_HARDIRQS_NO__DO_IRQ
+	select GPIO_TXX9
+
 config TOSHIBA_FPCIB0
 	bool "FPCIB0 Backplane Support"
-	depends on PCI && (SYS_HAS_CPU_TX49XX || SYS_HAS_CPU_TX39XX)
+	depends on PCI && (MACH_TX39XX || MACH_TX49XX)
 	select I8259
 
 config PICMG_PCI_BACKPLANE_DEFAULT
 	bool "Support for PICMG PCI Backplane"
-	depends on PCI && (SYS_HAS_CPU_TX49XX || SYS_HAS_CPU_TX39XX)
+	depends on PCI && (MACH_TX39XX || MACH_TX49XX)
 	default y if !TOSHIBA_FPCIB0
 
 if TOSHIBA_RBTX4938
diff --git a/arch/mips/txx9/generic/Makefile b/arch/mips/txx9/generic/Makefile
index b80b6e0..668fdaa 100644
--- a/arch/mips/txx9/generic/Makefile
+++ b/arch/mips/txx9/generic/Makefile
@@ -4,8 +4,8 @@
 
 obj-y	+= setup.o
 obj-$(CONFIG_PCI)	+= pci.o
-obj-$(CONFIG_TOSHIBA_RBTX4927)	+= mem_tx4927.o irq_tx4927.o
-obj-$(CONFIG_TOSHIBA_RBTX4938)	+= mem_tx4938.o irq_tx4938.o
+obj-$(CONFIG_SOC_TX4927)	+= mem_tx4927.o irq_tx4927.o
+obj-$(CONFIG_SOC_TX4938)	+= mem_tx4938.o irq_tx4938.o
 obj-$(CONFIG_TOSHIBA_FPCIB0)	+= smsc_fdc37m81x.o
 obj-$(CONFIG_KGDB)	+= dbgio.o
 
diff --git a/arch/mips/txx9/generic/irq_tx4927.c b/arch/mips/txx9/generic/irq_tx4927.c
index 685ecc2..6377bd8 100644
--- a/arch/mips/txx9/generic/irq_tx4927.c
+++ b/arch/mips/txx9/generic/irq_tx4927.c
@@ -26,39 +26,12 @@
 #include <linux/init.h>
 #include <linux/interrupt.h>
 #include <asm/irq_cpu.h>
-#include <asm/mipsregs.h>
-#ifdef CONFIG_TOSHIBA_RBTX4927
-#include <asm/txx9/rbtx4927.h>
-#endif
+#include <asm/txx9/tx4927.h>
 
 void __init tx4927_irq_init(void)
 {
 	mips_cpu_irq_init();
 	txx9_irq_init(TX4927_IRC_REG);
-	set_irq_chained_handler(TX4927_IRQ_NEST_PIC_ON_CP0, handle_simple_irq);
-}
-
-asmlinkage void plat_irq_dispatch(void)
-{
-	unsigned int pending = read_c0_status() & read_c0_cause() & ST0_IM;
-
-	if (pending & STATUSF_IP7)			/* cpu timer */
-		do_IRQ(TX4927_IRQ_CPU_TIMER);
-	else if (pending & STATUSF_IP2) {		/* tx4927 pic */
-		int irq = txx9_irq();
-#ifdef CONFIG_TOSHIBA_RBTX4927
-		if (irq == TX4927_IRQ_NEST_EXT_ON_PIC)
-			irq = toshiba_rbtx4927_irq_nested(irq);
-#endif
-		if (unlikely(irq < 0)) {
-			spurious_interrupt();
-			return;
-		}
-		do_IRQ(irq);
-	} else if (pending & STATUSF_IP0)		/* user line 0 */
-		do_IRQ(TX4927_IRQ_USER0);
-	else if (pending & STATUSF_IP1)			/* user line 1 */
-		do_IRQ(TX4927_IRQ_USER1);
-	else
-		spurious_interrupt();
+	set_irq_chained_handler(MIPS_CPU_IRQ_BASE + TX4927_IRC_INT,
+				handle_simple_irq);
 }
diff --git a/arch/mips/txx9/generic/irq_tx4938.c b/arch/mips/txx9/generic/irq_tx4938.c
index 0886d91..5fc86c9 100644
--- a/arch/mips/txx9/generic/irq_tx4938.c
+++ b/arch/mips/txx9/generic/irq_tx4938.c
@@ -14,35 +14,12 @@
 #include <linux/init.h>
 #include <linux/interrupt.h>
 #include <asm/irq_cpu.h>
-#include <asm/mipsregs.h>
-#include <asm/txx9/rbtx4938.h>
+#include <asm/txx9/tx4938.h>
 
-void __init
-tx4938_irq_init(void)
+void __init tx4938_irq_init(void)
 {
 	mips_cpu_irq_init();
 	txx9_irq_init(TX4938_IRC_REG);
-	set_irq_chained_handler(TX4938_IRQ_NEST_PIC_ON_CP0, handle_simple_irq);
-}
-
-int toshiba_rbtx4938_irq_nested(int irq);
-
-asmlinkage void plat_irq_dispatch(void)
-{
-	unsigned int pending = read_c0_cause() & read_c0_status();
-
-	if (pending & STATUSF_IP7)
-		do_IRQ(TX4938_IRQ_CPU_TIMER);
-	else if (pending & STATUSF_IP2) {
-		int irq = txx9_irq();
-		if (irq == TX4938_IRQ_PIC_BEG + TX4938_IR_INT(0))
-			irq = toshiba_rbtx4938_irq_nested(irq);
-		if (irq >= 0)
-			do_IRQ(irq);
-		else
-			spurious_interrupt();
-	} else if (pending & STATUSF_IP1)
-		do_IRQ(TX4938_IRQ_USER1);
-	else if (pending & STATUSF_IP0)
-		do_IRQ(TX4938_IRQ_USER0);
+	set_irq_chained_handler(MIPS_CPU_IRQ_BASE + TX4938_IRC_INT,
+				handle_simple_irq);
 }
diff --git a/arch/mips/txx9/generic/pci.c b/arch/mips/txx9/generic/pci.c
index 8173faa..0b92d8c 100644
--- a/arch/mips/txx9/generic/pci.c
+++ b/arch/mips/txx9/generic/pci.c
@@ -16,6 +16,7 @@
 #include <linux/delay.h>
 #include <linux/jiffies.h>
 #include <linux/io.h>
+#include <asm/txx9/generic.h>
 #include <asm/txx9/pci.h>
 #ifdef CONFIG_TOSHIBA_FPCIB0
 #include <linux/interrupt.h>
@@ -375,3 +376,13 @@ DECLARE_PCI_FIXUP_RESUME(PCI_VENDOR_ID_EFAR, PCI_DEVICE_ID_EFAR_SLC90E66_1,
 #endif
 DECLARE_PCI_FIXUP_FINAL(PCI_ANY_ID, PCI_ANY_ID, final_fixup);
 DECLARE_PCI_FIXUP_RESUME(PCI_ANY_ID, PCI_ANY_ID, final_fixup);
+
+int pcibios_plat_dev_init(struct pci_dev *dev)
+{
+	return 0;
+}
+
+int __init pcibios_map_irq(const struct pci_dev *dev, u8 slot, u8 pin)
+{
+	return txx9_board_vec->pci_map_irq(dev, slot, pin);
+}
diff --git a/arch/mips/txx9/generic/setup.c b/arch/mips/txx9/generic/setup.c
index 46a6311..66ff74f 100644
--- a/arch/mips/txx9/generic/setup.c
+++ b/arch/mips/txx9/generic/setup.c
@@ -14,7 +14,16 @@
 #include <linux/init.h>
 #include <linux/kernel.h>
 #include <linux/types.h>
+#include <linux/interrupt.h>
+#include <linux/string.h>
+#include <linux/module.h>
+#include <linux/clk.h>
+#include <linux/err.h>
+#include <asm/bootinfo.h>
 #include <asm/txx9/generic.h>
+#ifdef CONFIG_CPU_TX49XX
+#include <asm/txx9/tx4938.h>
+#endif
 
 /* EBUSC settings of TX4927, etc. */
 struct resource txx9_ce_res[8];
@@ -49,3 +58,163 @@ txx9_reg_res_init(unsigned int pcode, unsigned long base, unsigned long size)
 unsigned int txx9_master_clock;
 unsigned int txx9_cpu_clock;
 unsigned int txx9_gbus_clock;
+
+
+/* Minimum CLK support */
+
+struct clk *clk_get(struct device *dev, const char *id)
+{
+	if (!strcmp(id, "spi-baseclk"))
+		return (struct clk *)(txx9_gbus_clock / 2 / 4);
+	if (!strcmp(id, "imbus_clk"))
+		return (struct clk *)(txx9_gbus_clock / 2);
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
+
+extern struct txx9_board_vec jmr3927_vec;
+extern struct txx9_board_vec rbtx4927_vec;
+extern struct txx9_board_vec rbtx4937_vec;
+extern struct txx9_board_vec rbtx4938_vec;
+
+/* board definitions */
+static struct txx9_board_vec *board_vecs[] __initdata = {
+#ifdef CONFIG_TOSHIBA_JMR3927
+	&jmr3927_vec,
+#endif
+#ifdef CONFIG_TOSHIBA_RBTX4927
+	&rbtx4927_vec,
+	&rbtx4937_vec,
+#endif
+#ifdef CONFIG_TOSHIBA_RBTX4938
+	&rbtx4938_vec,
+#endif
+};
+struct txx9_board_vec *txx9_board_vec __initdata;
+static char txx9_system_type[32];
+
+void __init prom_init_cmdline(void)
+{
+	int argc = (int)fw_arg0;
+	char **argv = (char **)fw_arg1;
+	int i;			/* Always ignore the "-c" at argv[0] */
+
+	/* ignore all built-in args if any f/w args given */
+	if (argc > 1)
+		*arcs_cmdline = '\0';
+
+	for (i = 1; i < argc; i++) {
+		if (i != 1)
+			strcat(arcs_cmdline, " ");
+		strcat(arcs_cmdline, argv[i]);
+	}
+}
+
+void __init prom_init(void)
+{
+	int i;
+
+#ifdef CONFIG_CPU_TX39XX
+	mips_machtype = MACH_TOSHIBA_JMR3927;
+#endif
+#ifdef CONFIG_CPU_TX49XX
+	switch (TX4938_REV_PCODE()) {
+	case 0x4927:
+		mips_machtype = MACH_TOSHIBA_RBTX4927;
+		break;
+	case 0x4937:
+		mips_machtype = MACH_TOSHIBA_RBTX4937;
+		break;
+	case 0x4938:
+		mips_machtype = MACH_TOSHIBA_RBTX4938;
+		break;
+	}
+#endif
+	for (i = 0; i < ARRAY_SIZE(board_vecs); i++) {
+		if (board_vecs[i]->type == mips_machtype) {
+			txx9_board_vec = board_vecs[i];
+			strcpy(txx9_system_type, txx9_board_vec->system);
+			return txx9_board_vec->prom_init();
+		}
+	}
+}
+
+void __init prom_free_prom_memory(void)
+{
+}
+
+const char *get_system_type(void)
+{
+	return txx9_system_type;
+}
+
+char * __init prom_getcmdline(void)
+{
+	return &(arcs_cmdline[0]);
+}
+
+/* wrappers */
+void __init plat_mem_setup(void)
+{
+	txx9_board_vec->mem_setup();
+}
+
+void __init arch_init_irq(void)
+{
+	txx9_board_vec->irq_setup();
+}
+
+void __init plat_time_init(void)
+{
+	txx9_board_vec->time_init();
+}
+
+static int __init _txx9_arch_init(void)
+{
+	if (txx9_board_vec->arch_init)
+		txx9_board_vec->arch_init();
+	return 0;
+}
+arch_initcall(_txx9_arch_init);
+
+static int __init _txx9_device_init(void)
+{
+	if (txx9_board_vec->device_init)
+		txx9_board_vec->device_init();
+	return 0;
+}
+device_initcall(_txx9_device_init);
+
+int (*txx9_irq_dispatch)(int pending);
+asmlinkage void plat_irq_dispatch(void)
+{
+	int pending = read_c0_status() & read_c0_cause() & ST0_IM;
+	int irq = txx9_irq_dispatch(pending);
+
+	if (likely(irq >= 0))
+		do_IRQ(irq);
+	else
+		spurious_interrupt();
+}
diff --git a/arch/mips/txx9/jmr3927/Makefile b/arch/mips/txx9/jmr3927/Makefile
index 5f83ea3..ba292c9 100644
--- a/arch/mips/txx9/jmr3927/Makefile
+++ b/arch/mips/txx9/jmr3927/Makefile
@@ -2,7 +2,7 @@
 # Makefile for TOSHIBA JMR-TX3927 board
 #
 
-obj-y	+= prom.o init.o irq.o setup.o
+obj-y	+= prom.o irq.o setup.o
 obj-$(CONFIG_KGDB)	+= kgdb_io.o
 
 EXTRA_CFLAGS += -Werror
diff --git a/arch/mips/txx9/jmr3927/init.c b/arch/mips/txx9/jmr3927/init.c
deleted file mode 100644
index 1bbb534..0000000
--- a/arch/mips/txx9/jmr3927/init.c
+++ /dev/null
@@ -1,57 +0,0 @@
-/*
- * Copyright 2001 MontaVista Software Inc.
- * Author: MontaVista Software, Inc.
- *              ahennessy@mvista.com
- *
- * arch/mips/jmr3927/common/init.c
- *
- * Copyright (C) 2000-2001 Toshiba Corporation
- *
- *  This program is free software; you can redistribute  it and/or modify it
- *  under  the terms of  the GNU General  Public License as published by the
- *  Free Software Foundation;  either version 2 of the  License, or (at your
- *  option) any later version.
- *
- *  THIS  SOFTWARE  IS PROVIDED   ``AS  IS'' AND   ANY  EXPRESS OR IMPLIED
- *  WARRANTIES,   INCLUDING, BUT NOT  LIMITED  TO, THE IMPLIED WARRANTIES OF
- *  MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED.  IN
- *  NO  EVENT  SHALL   THE AUTHOR  BE    LIABLE FOR ANY   DIRECT, INDIRECT,
- *  INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT
- *  NOT LIMITED   TO, PROCUREMENT OF  SUBSTITUTE GOODS  OR SERVICES; LOSS OF
- *  USE, DATA,  OR PROFITS; OR  BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON
- *  ANY THEORY OF LIABILITY, WHETHER IN  CONTRACT, STRICT LIABILITY, OR TORT
- *  (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF
- *  THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
- *
- *  You should have received a copy of the  GNU General Public License along
- *  with this program; if not, write  to the Free Software Foundation, Inc.,
- *  675 Mass Ave, Cambridge, MA 02139, USA.
- */
-#include <linux/init.h>
-#include <asm/bootinfo.h>
-#include <asm/txx9/jmr3927.h>
-
-extern void  __init prom_init_cmdline(void);
-
-const char *get_system_type(void)
-{
-	return "Toshiba"
-#ifdef CONFIG_TOSHIBA_JMR3927
-	       " JMR_TX3927"
-#endif
-	;
-}
-
-extern void puts(const char *cp);
-
-void __init prom_init(void)
-{
-#ifdef CONFIG_TOSHIBA_JMR3927
-	/* CCFG */
-	if ((tx3927_ccfgptr->ccfg & TX3927_CCFG_TLBOFF) == 0)
-		puts("Warning: TX3927 TLB off\n");
-#endif
-
-	prom_init_cmdline();
-	add_memory_region(0, JMR3927_SDRAM_SIZE, BOOT_MEM_RAM);
-}
diff --git a/arch/mips/txx9/jmr3927/irq.c b/arch/mips/txx9/jmr3927/irq.c
index b97d22e..070c9a1 100644
--- a/arch/mips/txx9/jmr3927/irq.c
+++ b/arch/mips/txx9/jmr3927/irq.c
@@ -39,6 +39,7 @@
 #include <asm/system.h>
 
 #include <asm/processor.h>
+#include <asm/txx9/generic.h>
 #include <asm/txx9/jmr3927.h>
 
 #if JMR3927_IRQ_END > NR_IRQS
@@ -77,37 +78,30 @@ static void unmask_irq_ioc(unsigned int irq)
 	(void)jmr3927_ioc_reg_in(JMR3927_IOC_REV_ADDR);
 }
 
-asmlinkage void plat_irq_dispatch(void)
-{
-	unsigned long cp0_cause = read_c0_cause();
-	int irq;
-
-	if ((cp0_cause & CAUSEF_IP7) == 0)
-		return;
-	irq = (cp0_cause >> CAUSEB_IP2) & 0x0f;
-
-	do_IRQ(irq + JMR3927_IRQ_IRC);
-}
-
-static irqreturn_t jmr3927_ioc_interrupt(int irq, void *dev_id)
+static int jmr3927_ioc_irqroute(void)
 {
 	unsigned char istat = jmr3927_ioc_reg_in(JMR3927_IOC_INTS2_ADDR);
 	int i;
 
 	for (i = 0; i < JMR3927_NR_IRQ_IOC; i++) {
-		if (istat & (1 << i)) {
-			irq = JMR3927_IRQ_IOC + i;
-			do_IRQ(irq);
-		}
+		if (istat & (1 << i))
+			return JMR3927_IRQ_IOC + i;
 	}
-	return IRQ_HANDLED;
+	return -1;
 }
 
-static struct irqaction ioc_action = {
-	.handler = jmr3927_ioc_interrupt,
-	.mask = CPU_MASK_NONE,
-	.name = "IOC",
-};
+static int jmr3927_irq_dispatch(int pending)
+{
+	int irq;
+
+	if ((pending & CAUSEF_IP7) == 0)
+		return -1;
+	irq = (pending >> CAUSEB_IP2) & 0x0f;
+	irq += JMR3927_IRQ_IRC;
+	if (irq == JMR3927_IRQ_IOCINT)
+		irq = jmr3927_ioc_irqroute();
+	return irq;
+}
 
 #ifdef CONFIG_PCI
 static irqreturn_t jmr3927_pcierr_interrupt(int irq, void *dev_id)
@@ -127,8 +121,9 @@ static struct irqaction pcierr_action = {
 
 static void __init jmr3927_irq_init(void);
 
-void __init arch_init_irq(void)
+void __init jmr3927_irq_setup(void)
 {
+	txx9_irq_dispatch = jmr3927_irq_dispatch;
 	/* Now, interrupt control disabled, */
 	/* all IRC interrupts are masked, */
 	/* all IRC interrupt mode are Low Active. */
@@ -146,7 +141,7 @@ void __init arch_init_irq(void)
 	jmr3927_irq_init();
 
 	/* setup IOC interrupt 1 (PCI, MODEM) */
-	setup_irq(JMR3927_IRQ_IOCINT, &ioc_action);
+	set_irq_chained_handler(JMR3927_IRQ_IOCINT, handle_simple_irq);
 
 #ifdef CONFIG_PCI
 	setup_irq(JMR3927_IRQ_IRC_PCI, &pcierr_action);
diff --git a/arch/mips/txx9/jmr3927/prom.c b/arch/mips/txx9/jmr3927/prom.c
index 8bc1049..2cadb42 100644
--- a/arch/mips/txx9/jmr3927/prom.c
+++ b/arch/mips/txx9/jmr3927/prom.c
@@ -35,42 +35,10 @@
  *  with this program; if not, write  to the Free Software Foundation, Inc.,
  *  675 Mass Ave, Cambridge, MA 02139, USA.
  */
-#include <linux/kernel.h>
 #include <linux/init.h>
-#include <linux/string.h>
-
 #include <asm/bootinfo.h>
-#include <asm/txx9/tx3927.h>
-
-char * __init prom_getcmdline(void)
-{
-	return &(arcs_cmdline[0]);
-}
-
-void  __init prom_init_cmdline(void)
-{
-	char *cp;
-	int actr;
-	int prom_argc = fw_arg0;
-	char **prom_argv = (char **) fw_arg1;
-
-	actr = 1; /* Always ignore argv[0] */
-
-	cp = &(arcs_cmdline[0]);
-	while(actr < prom_argc) {
-	        strcpy(cp, prom_argv[actr]);
-		cp += strlen(prom_argv[actr]);
-		*cp++ = ' ';
-		actr++;
-	}
-	if (cp != &(arcs_cmdline[0])) /* get rid of trailing space */
-		--cp;
-	*cp = '\0';
-}
-
-void __init prom_free_prom_memory(void)
-{
-}
+#include <asm/txx9/generic.h>
+#include <asm/txx9/jmr3927.h>
 
 #define TIMEOUT       0xffffff
 
@@ -96,3 +64,13 @@ puts(const char *cp)
     prom_putchar('\r');
     prom_putchar('\n');
 }
+
+void __init jmr3927_prom_init(void)
+{
+	/* CCFG */
+	if ((tx3927_ccfgptr->ccfg & TX3927_CCFG_TLBOFF) == 0)
+		puts("Warning: TX3927 TLB off\n");
+
+	prom_init_cmdline();
+	add_memory_region(0, JMR3927_SDRAM_SIZE, BOOT_MEM_RAM);
+}
diff --git a/arch/mips/txx9/jmr3927/setup.c b/arch/mips/txx9/jmr3927/setup.c
index baa8c8d..128a4ae 100644
--- a/arch/mips/txx9/jmr3927/setup.c
+++ b/arch/mips/txx9/jmr3927/setup.c
@@ -34,15 +34,16 @@
 #include <linux/delay.h>
 #include <linux/pm.h>
 #include <linux/platform_device.h>
-#include <linux/clk.h>
 #include <linux/gpio.h>
 #ifdef CONFIG_SERIAL_TXX9
 #include <linux/serial_core.h>
 #endif
 
+#include <asm/bootinfo.h>
 #include <asm/txx9tmr.h>
 #include <asm/txx9pio.h>
 #include <asm/reboot.h>
+#include <asm/txx9/generic.h>
 #include <asm/txx9/pci.h>
 #include <asm/txx9/jmr3927.h>
 #include <asm/mipsregs.h>
@@ -83,7 +84,7 @@ static void jmr3927_machine_power_off(void)
 	while (1);
 }
 
-void __init plat_time_init(void)
+static void __init jmr3927_time_init(void)
 {
 	txx9_clockevent_init(TX3927_TMR_REG(0),
 			     TXX9_IRQ_BASE + JMR3927_IRQ_IRC_TMR(0),
@@ -97,7 +98,7 @@ void __init plat_time_init(void)
 extern char * __init prom_getcmdline(void);
 static void jmr3927_board_init(void);
 
-void __init plat_mem_setup(void)
+static void __init jmr3927_mem_setup(void)
 {
 	char *argptr;
 
@@ -233,6 +234,8 @@ static void __init tx3927_setup(void)
 {
 	int i;
 
+	txx9_cpu_clock = JMR3927_CORECLK;
+	txx9_gbus_clock = JMR3927_GBUSCLK;
 	/* SDRAMC are configured by PROM */
 
 	/* ROMC */
@@ -336,7 +339,6 @@ static int __init jmr3927_rtc_init(void)
 	dev = platform_device_register_simple("rtc-ds1742", -1, &res, 1);
 	return IS_ERR(dev) ? PTR_ERR(dev) : 0;
 }
-device_initcall(jmr3927_rtc_init);
 
 /* Watchdog support */
 
@@ -356,36 +358,22 @@ static int __init jmr3927_wdt_init(void)
 {
 	return txx9_wdt_init(TX3927_TMR_REG(2));
 }
-device_initcall(jmr3927_wdt_init);
 
-/* Minimum CLK support */
-
-struct clk *clk_get(struct device *dev, const char *id)
-{
-	if (!strcmp(id, "imbus_clk"))
-		return (struct clk *)JMR3927_IMCLK;
-	return ERR_PTR(-ENOENT);
-}
-EXPORT_SYMBOL(clk_get);
-
-int clk_enable(struct clk *clk)
-{
-	return 0;
-}
-EXPORT_SYMBOL(clk_enable);
-
-void clk_disable(struct clk *clk)
+static void __init jmr3927_device_init(void)
 {
+	jmr3927_rtc_init();
+	jmr3927_wdt_init();
 }
-EXPORT_SYMBOL(clk_disable);
 
-unsigned long clk_get_rate(struct clk *clk)
-{
-	return (unsigned long)clk;
-}
-EXPORT_SYMBOL(clk_get_rate);
-
-void clk_put(struct clk *clk)
-{
-}
-EXPORT_SYMBOL(clk_put);
+struct txx9_board_vec jmr3927_vec __initdata = {
+	.type = MACH_TOSHIBA_JMR3927,
+	.system = "Toshiba JMR_TX3927",
+	.prom_init = jmr3927_prom_init,
+	.mem_setup = jmr3927_mem_setup,
+	.irq_setup = jmr3927_irq_setup,
+	.time_init = jmr3927_time_init,
+	.device_init = jmr3927_device_init,
+#ifdef CONFIG_PCI
+	.pci_map_irq = jmr3927_pci_map_irq,
+#endif
+};
diff --git a/arch/mips/txx9/rbtx4927/irq.c b/arch/mips/txx9/rbtx4927/irq.c
index bef1447..70f1321 100644
--- a/arch/mips/txx9/rbtx4927/irq.c
+++ b/arch/mips/txx9/rbtx4927/irq.c
@@ -111,17 +111,10 @@ JP7 is not bus master -- do NOT use -- only 4 pci bus master's allowed -- SouthB
 #include <linux/types.h>
 #include <linux/interrupt.h>
 #include <asm/io.h>
+#include <asm/mipsregs.h>
+#include <asm/txx9/generic.h>
 #include <asm/txx9/rbtx4927.h>
 
-#define TOSHIBA_RBTX4927_IRQ_IOC_RAW_BEG   0
-#define TOSHIBA_RBTX4927_IRQ_IOC_RAW_END   7
-
-#define TOSHIBA_RBTX4927_IRQ_IOC_BEG  ((TX4927_IRQ_PIC_END+1)+TOSHIBA_RBTX4927_IRQ_IOC_RAW_BEG)	/* 56 */
-#define TOSHIBA_RBTX4927_IRQ_IOC_END  ((TX4927_IRQ_PIC_END+1)+TOSHIBA_RBTX4927_IRQ_IOC_RAW_END)	/* 63 */
-
-#define TOSHIBA_RBTX4927_IRQ_NEST_IOC_ON_PIC TX4927_IRQ_NEST_EXT_ON_PIC
-#define TOSHIBA_RBTX4927_IRQ_NEST_ISA_ON_IOC (TOSHIBA_RBTX4927_IRQ_IOC_BEG+2)
-
 static void toshiba_rbtx4927_irq_ioc_enable(unsigned int irq);
 static void toshiba_rbtx4927_irq_ioc_disable(unsigned int irq);
 
@@ -136,34 +129,25 @@ static struct irq_chip toshiba_rbtx4927_irq_ioc_type = {
 #define TOSHIBA_RBTX4927_IOC_INTR_ENAB (void __iomem *)0xbc002000UL
 #define TOSHIBA_RBTX4927_IOC_INTR_STAT (void __iomem *)0xbc002006UL
 
-int toshiba_rbtx4927_irq_nested(int sw_irq)
+static int toshiba_rbtx4927_irq_nested(int sw_irq)
 {
 	u8 level3;
 
 	level3 = readb(TOSHIBA_RBTX4927_IOC_INTR_STAT) & 0x1f;
 	if (level3)
-		sw_irq = TOSHIBA_RBTX4927_IRQ_IOC_BEG + fls(level3) - 1;
+		sw_irq = RBTX4927_IRQ_IOC + fls(level3) - 1;
 	return (sw_irq);
 }
 
-static struct irqaction toshiba_rbtx4927_irq_ioc_action = {
-	.handler	= no_action,
-	.flags		= IRQF_SHARED,
-	.mask		= CPU_MASK_NONE,
-	.name		= TOSHIBA_RBTX4927_IOC_NAME
-};
-
 static void __init toshiba_rbtx4927_irq_ioc_init(void)
 {
 	int i;
 
-	for (i = TOSHIBA_RBTX4927_IRQ_IOC_BEG;
-	     i <= TOSHIBA_RBTX4927_IRQ_IOC_END; i++)
+	for (i = RBTX4927_IRQ_IOC;
+	     i < RBTX4927_IRQ_IOC + RBTX4927_NR_IRQ_IOC; i++)
 		set_irq_chip_and_handler(i, &toshiba_rbtx4927_irq_ioc_type,
 					 handle_level_irq);
-
-	setup_irq(TOSHIBA_RBTX4927_IRQ_NEST_IOC_ON_PIC,
-		  &toshiba_rbtx4927_irq_ioc_action);
+	set_irq_chained_handler(RBTX4927_IRQ_IOCINT, handle_simple_irq);
 }
 
 static void toshiba_rbtx4927_irq_ioc_enable(unsigned int irq)
@@ -171,7 +155,7 @@ static void toshiba_rbtx4927_irq_ioc_enable(unsigned int irq)
 	unsigned char v;
 
 	v = readb(TOSHIBA_RBTX4927_IOC_INTR_ENAB);
-	v |= (1 << (irq - TOSHIBA_RBTX4927_IRQ_IOC_BEG));
+	v |= (1 << (irq - RBTX4927_IRQ_IOC));
 	writeb(v, TOSHIBA_RBTX4927_IOC_INTR_ENAB);
 }
 
@@ -180,15 +164,34 @@ static void toshiba_rbtx4927_irq_ioc_disable(unsigned int irq)
 	unsigned char v;
 
 	v = readb(TOSHIBA_RBTX4927_IOC_INTR_ENAB);
-	v &= ~(1 << (irq - TOSHIBA_RBTX4927_IRQ_IOC_BEG));
+	v &= ~(1 << (irq - RBTX4927_IRQ_IOC));
 	writeb(v, TOSHIBA_RBTX4927_IOC_INTR_ENAB);
 	mmiowb();
 }
 
-void __init arch_init_irq(void)
+
+static int rbtx4927_irq_dispatch(int pending)
 {
-	extern void tx4927_irq_init(void);
+	int irq;
+
+	if (pending & STATUSF_IP7)			/* cpu timer */
+		irq = MIPS_CPU_IRQ_BASE + 7;
+	else if (pending & STATUSF_IP2) {		/* tx4927 pic */
+		irq = txx9_irq();
+		if (irq == RBTX4927_IRQ_IOCINT)
+			irq = toshiba_rbtx4927_irq_nested(irq);
+	} else if (pending & STATUSF_IP0)		/* user line 0 */
+		irq = MIPS_CPU_IRQ_BASE + 0;
+	else if (pending & STATUSF_IP1)			/* user line 1 */
+		irq = MIPS_CPU_IRQ_BASE + 1;
+	else
+		irq = -1;
+	return irq;
+}
 
+void __init rbtx4927_irq_setup(void)
+{
+	txx9_irq_dispatch = rbtx4927_irq_dispatch;
 	tx4927_irq_init();
 	toshiba_rbtx4927_irq_ioc_init();
 	/* Onboard 10M Ether: High Active */
diff --git a/arch/mips/txx9/rbtx4927/prom.c b/arch/mips/txx9/rbtx4927/prom.c
index 0020bbe..942e627 100644
--- a/arch/mips/txx9/rbtx4927/prom.c
+++ b/arch/mips/txx9/rbtx4927/prom.c
@@ -30,62 +30,16 @@
  *  675 Mass Ave, Cambridge, MA 02139, USA.
  */
 #include <linux/init.h>
-#include <linux/string.h>
 #include <asm/bootinfo.h>
-#include <asm/cpu.h>
-#include <asm/mipsregs.h>
-#include <asm/txx9/tx4927.h>
+#include <asm/txx9/generic.h>
+#include <asm/txx9/rbtx4927.h>
 
-void __init prom_init_cmdline(void)
-{
-	int argc = (int) fw_arg0;
-	char **argv = (char **) fw_arg1;
-	int i;			/* Always ignore the "-c" at argv[0] */
-
-	/* ignore all built-in args if any f/w args given */
-	if (argc > 1) {
-		*arcs_cmdline = '\0';
-	}
-
-	for (i = 1; i < argc; i++) {
-		if (i != 1) {
-			strcat(arcs_cmdline, " ");
-		}
-		strcat(arcs_cmdline, argv[i]);
-	}
-}
-
-void __init prom_init(void)
+void __init rbtx4927_prom_init(void)
 {
 	extern int tx4927_get_mem_size(void);
-	extern char* toshiba_name;
 	int msize;
 
 	prom_init_cmdline();
-
-	if ((read_c0_prid() & 0xff) == PRID_REV_TX4927) {
-		mips_machtype = MACH_TOSHIBA_RBTX4927;
-		toshiba_name  = "TX4927";
-	} else {
-		mips_machtype = MACH_TOSHIBA_RBTX4937;
-		toshiba_name  = "TX4937";
-	}
-
 	msize = tx4927_get_mem_size();
 	add_memory_region(0, msize << 20, BOOT_MEM_RAM);
 }
-
-void __init prom_free_prom_memory(void)
-{
-}
-
-const char *get_system_type(void)
-{
-	return "Toshiba RBTX4927/RBTX4937";
-}
-
-char * __init prom_getcmdline(void)
-{
-        return &(arcs_cmdline[0]);
-}
-
diff --git a/arch/mips/txx9/rbtx4927/setup.c b/arch/mips/txx9/rbtx4927/setup.c
index 86b870a..c3566c3 100644
--- a/arch/mips/txx9/rbtx4927/setup.c
+++ b/arch/mips/txx9/rbtx4927/setup.c
@@ -49,7 +49,6 @@
 #include <linux/interrupt.h>
 #include <linux/pm.h>
 #include <linux/platform_device.h>
-#include <linux/clk.h>
 #include <linux/delay.h>
 
 #include <asm/bootinfo.h>
@@ -76,8 +75,6 @@ char *prom_getcmdline(void);
 
 static int tx4927_ccfg_toeon = 1;
 
-char *toshiba_name = "";
-
 #ifdef CONFIG_PCI
 static void __init tx4927_pci_setup(void)
 {
@@ -171,15 +168,15 @@ static void __init tx4937_pci_setup(void)
 	}
 }
 
-static int __init rbtx4927_arch_init(void)
+static void __init rbtx4927_arch_init(void)
 {
 	if (mips_machtype == MACH_TOSHIBA_RBTX4937)
 		tx4937_pci_setup();
 	else
 		tx4927_pci_setup();
-	return 0;
 }
-arch_initcall(rbtx4927_arch_init);
+#else
+#define rbtx4927_arch_init NULL
 #endif /* CONFIG_PCI */
 
 static void __noreturn wait_forever(void)
@@ -223,14 +220,12 @@ void toshiba_rbtx4927_power_off(void)
 	/* no return */
 }
 
-void __init plat_mem_setup(void)
+static void __init rbtx4927_mem_setup(void)
 {
 	int i;
 	u32 cp0_config;
 	char *argptr;
 
-	printk("CPU is %s\n", toshiba_name);
-
 	/* f/w leaves this on at startup */
 	clear_c0_status(ST0_ERL);
 
@@ -323,7 +318,7 @@ void __init plat_mem_setup(void)
 			req.iotype = UPIO_MEM;
 			req.membase = (char *)(0xff1ff300 + i * 0x100);
 			req.mapbase = 0xff1ff300 + i * 0x100;
-			req.irq = TX4927_IRQ_PIC_BEG + 8 + i;
+			req.irq = TXX9_IRQ_BASE + TX4927_IR_SIO(i);
 			req.flags |= UPF_BUGGY_UART /*HAVE_CTS_LINE*/;
 			req.uartclk = 50000000;
 			early_serial_txx9_setup(&req);
@@ -352,7 +347,7 @@ void __init plat_mem_setup(void)
 #endif
 }
 
-void __init plat_time_init(void)
+static void __init rbtx4927_time_init(void)
 {
 	mips_hpt_frequency = txx9_cpu_clock / 2;
 	if (____raw_readq(&tx4927_ccfgptr->ccfg) & TX4927_CCFG_TINTDIS)
@@ -372,7 +367,6 @@ static int __init toshiba_rbtx4927_rtc_init(void)
 		platform_device_register_simple("rtc-ds1742", -1, &res, 1);
 	return IS_ERR(dev) ? PTR_ERR(dev) : 0;
 }
-device_initcall(toshiba_rbtx4927_rtc_init);
 
 static int __init rbtx4927_ne_init(void)
 {
@@ -391,7 +385,6 @@ static int __init rbtx4927_ne_init(void)
 						res, ARRAY_SIZE(res));
 	return IS_ERR(dev) ? PTR_ERR(dev) : 0;
 }
-device_initcall(rbtx4927_ne_init);
 
 /* Watchdog support */
 
@@ -411,36 +404,37 @@ static int __init rbtx4927_wdt_init(void)
 {
 	return txx9_wdt_init(TX4927_TMR_REG(2) & 0xfffffffffULL);
 }
-device_initcall(rbtx4927_wdt_init);
-
-/* Minimum CLK support */
-
-struct clk *clk_get(struct device *dev, const char *id)
-{
-	if (!strcmp(id, "imbus_clk"))
-		return (struct clk *)50000000;
-	return ERR_PTR(-ENOENT);
-}
-EXPORT_SYMBOL(clk_get);
-
-int clk_enable(struct clk *clk)
-{
-	return 0;
-}
-EXPORT_SYMBOL(clk_enable);
 
-void clk_disable(struct clk *clk)
+static void __init rbtx4927_device_init(void)
 {
+	toshiba_rbtx4927_rtc_init();
+	rbtx4927_ne_init();
+	rbtx4927_wdt_init();
 }
-EXPORT_SYMBOL(clk_disable);
 
-unsigned long clk_get_rate(struct clk *clk)
-{
-	return (unsigned long)clk;
-}
-EXPORT_SYMBOL(clk_get_rate);
-
-void clk_put(struct clk *clk)
-{
-}
-EXPORT_SYMBOL(clk_put);
+struct txx9_board_vec rbtx4927_vec __initdata = {
+	.type = MACH_TOSHIBA_RBTX4927,
+	.system = "Toshiba RBTX4927",
+	.prom_init = rbtx4927_prom_init,
+	.mem_setup = rbtx4927_mem_setup,
+	.irq_setup = rbtx4927_irq_setup,
+	.time_init = rbtx4927_time_init,
+	.device_init = rbtx4927_device_init,
+	.arch_init = rbtx4927_arch_init,
+#ifdef CONFIG_PCI
+	.pci_map_irq = rbtx4927_pci_map_irq,
+#endif
+};
+struct txx9_board_vec rbtx4937_vec __initdata = {
+	.type = MACH_TOSHIBA_RBTX4937,
+	.system = "Toshiba RBTX4937",
+	.prom_init = rbtx4927_prom_init,
+	.mem_setup = rbtx4927_mem_setup,
+	.irq_setup = rbtx4927_irq_setup,
+	.time_init = rbtx4927_time_init,
+	.device_init = rbtx4927_device_init,
+	.arch_init = rbtx4927_arch_init,
+#ifdef CONFIG_PCI
+	.pci_map_irq = rbtx4927_pci_map_irq,
+#endif
+};
diff --git a/arch/mips/txx9/rbtx4938/irq.c b/arch/mips/txx9/rbtx4938/irq.c
index f498482..3971a06 100644
--- a/arch/mips/txx9/rbtx4938/irq.c
+++ b/arch/mips/txx9/rbtx4938/irq.c
@@ -66,6 +66,8 @@ IRQ  Device
 */
 #include <linux/init.h>
 #include <linux/interrupt.h>
+#include <asm/mipsregs.h>
+#include <asm/txx9/generic.h>
 #include <asm/txx9/rbtx4938.h>
 
 static void toshiba_rbtx4938_irq_ioc_enable(unsigned int irq);
@@ -80,26 +82,17 @@ static struct irq_chip toshiba_rbtx4938_irq_ioc_type = {
 	.unmask = toshiba_rbtx4938_irq_ioc_enable,
 };
 
-int
-toshiba_rbtx4938_irq_nested(int sw_irq)
+static int toshiba_rbtx4938_irq_nested(int sw_irq)
 {
 	u8 level3;
 
 	level3 = readb(rbtx4938_imstat_addr);
 	if (level3)
 		/* must use fls so onboard ATA has priority */
-		sw_irq = TOSHIBA_RBTX4938_IRQ_IOC_BEG + fls(level3) - 1;
-
+		sw_irq = RBTX4938_IRQ_IOC + fls(level3) - 1;
 	return sw_irq;
 }
 
-static struct irqaction toshiba_rbtx4938_irq_ioc_action = {
-	.handler = no_action,
-	.flags = 0,
-	.mask = CPU_MASK_NONE,
-	.name = TOSHIBA_RBTX4938_IOC_NAME,
-};
-
 /**********************************************************************************/
 /* Functions for ioc                                                              */
 /**********************************************************************************/
@@ -108,13 +101,12 @@ toshiba_rbtx4938_irq_ioc_init(void)
 {
 	int i;
 
-	for (i = TOSHIBA_RBTX4938_IRQ_IOC_BEG;
-	     i <= TOSHIBA_RBTX4938_IRQ_IOC_END; i++)
+	for (i = RBTX4938_IRQ_IOC;
+	     i < RBTX4938_IRQ_IOC + RBTX4938_NR_IRQ_IOC; i++)
 		set_irq_chip_and_handler(i, &toshiba_rbtx4938_irq_ioc_type,
 					 handle_level_irq);
 
-	setup_irq(RBTX4938_IRQ_IOCINT,
-		  &toshiba_rbtx4938_irq_ioc_action);
+	set_irq_chained_handler(RBTX4938_IRQ_IOCINT, handle_simple_irq);
 }
 
 static void
@@ -123,7 +115,7 @@ toshiba_rbtx4938_irq_ioc_enable(unsigned int irq)
 	unsigned char v;
 
 	v = readb(rbtx4938_imask_addr);
-	v |= (1 << (irq - TOSHIBA_RBTX4938_IRQ_IOC_BEG));
+	v |= (1 << (irq - RBTX4938_IRQ_IOC));
 	writeb(v, rbtx4938_imask_addr);
 	mmiowb();
 }
@@ -134,15 +126,33 @@ toshiba_rbtx4938_irq_ioc_disable(unsigned int irq)
 	unsigned char v;
 
 	v = readb(rbtx4938_imask_addr);
-	v &= ~(1 << (irq - TOSHIBA_RBTX4938_IRQ_IOC_BEG));
+	v &= ~(1 << (irq - RBTX4938_IRQ_IOC));
 	writeb(v, rbtx4938_imask_addr);
 	mmiowb();
 }
 
-void __init arch_init_irq(void)
+static int rbtx4938_irq_dispatch(int pending)
 {
-	extern void tx4938_irq_init(void);
+	int irq;
+
+	if (pending & STATUSF_IP7)
+		irq = MIPS_CPU_IRQ_BASE + 7;
+	else if (pending & STATUSF_IP2) {
+		irq = txx9_irq();
+		if (irq == RBTX4938_IRQ_IOCINT)
+			irq = toshiba_rbtx4938_irq_nested(irq);
+	} else if (pending & STATUSF_IP1)
+		irq = MIPS_CPU_IRQ_BASE + 0;
+	else if (pending & STATUSF_IP0)
+		irq = MIPS_CPU_IRQ_BASE + 1;
+	else
+		irq = -1;
+	return irq;
+}
 
+void __init rbtx4938_irq_setup(void)
+{
+	txx9_irq_dispatch = rbtx4938_irq_dispatch;
 	/* Now, interrupt control disabled, */
 	/* all IRC interrupts are masked, */
 	/* all IRC interrupt mode are Low Active. */
diff --git a/arch/mips/txx9/rbtx4938/prom.c b/arch/mips/txx9/rbtx4938/prom.c
index 134fcc2..fbb3745 100644
--- a/arch/mips/txx9/rbtx4938/prom.c
+++ b/arch/mips/txx9/rbtx4938/prom.c
@@ -11,34 +11,12 @@
  */
 
 #include <linux/init.h>
-#include <linux/mm.h>
-#include <linux/sched.h>
 #include <linux/bootmem.h>
-
-#include <asm/addrspace.h>
 #include <asm/bootinfo.h>
-#include <asm/txx9/tx4938.h>
-
-void __init prom_init_cmdline(void)
-{
-	int argc = (int) fw_arg0;
-	char **argv = (char **) fw_arg1;
-	int i;
-
-	/* ignore all built-in args if any f/w args given */
-	if (argc > 1) {
-		*arcs_cmdline = '\0';
-	}
-
-	for (i = 1; i < argc; i++) {
-		if (i != 1) {
-			strcat(arcs_cmdline, " ");
-		}
-		strcat(arcs_cmdline, argv[i]);
-	}
-}
+#include <asm/txx9/generic.h>
+#include <asm/txx9/rbtx4938.h>
 
-void __init prom_init(void)
+void __init rbtx4938_prom_init(void)
 {
 	extern int tx4938_get_mem_size(void);
 	int msize;
@@ -48,25 +26,4 @@ void __init prom_init(void)
 
 	msize = tx4938_get_mem_size();
 	add_memory_region(0, msize << 20, BOOT_MEM_RAM);
-
-	return;
-}
-
-void __init prom_free_prom_memory(void)
-{
-}
-
-void __init prom_fixup_mem_map(unsigned long start, unsigned long end)
-{
-	return;
-}
-
-const char *get_system_type(void)
-{
-	return "Toshiba RBTX4938";
-}
-
-char * __init prom_getcmdline(void)
-{
-	return &(arcs_cmdline[0]);
 }
diff --git a/arch/mips/txx9/rbtx4938/setup.c b/arch/mips/txx9/rbtx4938/setup.c
index 144d2ca..8306ba3 100644
--- a/arch/mips/txx9/rbtx4938/setup.c
+++ b/arch/mips/txx9/rbtx4938/setup.c
@@ -17,7 +17,6 @@
 #include <linux/console.h>
 #include <linux/pm.h>
 #include <linux/platform_device.h>
-#include <linux/clk.h>
 #include <linux/gpio.h>
 
 #include <asm/reboot.h>
@@ -147,9 +146,9 @@ static void __init rbtx4938_pci_setup(void)
 #define	SEEPROM3_CS	1	/* IOC */
 #define	SRTC_CS	2	/* IOC */
 
-#ifdef CONFIG_PCI
 static int __init rbtx4938_ethaddr_init(void)
 {
+#ifdef CONFIG_PCI
 	unsigned char dat[17];
 	unsigned char sum;
 	int i;
@@ -179,10 +178,9 @@ static int __init rbtx4938_ethaddr_init(void)
 		    platform_device_add(pdev))
 			platform_device_put(pdev);
 	}
+#endif /* CONFIG_PCI */
 	return 0;
 }
-device_initcall(rbtx4938_ethaddr_init);
-#endif /* CONFIG_PCI */
 
 static void __init rbtx4938_spi_setup(void)
 {
@@ -366,7 +364,7 @@ void __init tx4938_board_setup(void)
 #endif
 }
 
-void __init plat_time_init(void)
+static void __init rbtx4938_time_init(void)
 {
 	mips_hpt_frequency = txx9_cpu_clock / 2;
 	if (____raw_readq(&tx4938_ccfgptr->ccfg) & TX4938_CCFG_TINTDIS)
@@ -375,7 +373,7 @@ void __init plat_time_init(void)
 				     txx9_gbus_clock / 2);
 }
 
-void __init plat_mem_setup(void)
+static void __init rbtx4938_mem_setup(void)
 {
 	unsigned long long pcfg;
 	char *argptr;
@@ -496,7 +494,6 @@ static int __init rbtx4938_ne_init(void)
 						res, ARRAY_SIZE(res));
 	return IS_ERR(dev) ? PTR_ERR(dev) : 0;
 }
-device_initcall(rbtx4938_ne_init);
 
 /* GPIO support */
 
@@ -587,14 +584,13 @@ static int __init rbtx4938_spi_init(void)
 	return 0;
 }
 
-static int __init rbtx4938_arch_init(void)
+static void __init rbtx4938_arch_init(void)
 {
 	txx9_gpio_init(TX4938_PIO_REG & 0xfffffffffULL, 0, 16);
 	gpiochip_add(&rbtx4938_spi_gpio_chip);
 	rbtx4938_pci_setup();
-	return rbtx4938_spi_init();
+	rbtx4938_spi_init();
 }
-arch_initcall(rbtx4938_arch_init);
 
 /* Watchdog support */
 
@@ -614,38 +610,24 @@ static int __init rbtx4938_wdt_init(void)
 {
 	return txx9_wdt_init(TX4938_TMR_REG(2) & 0xfffffffffULL);
 }
-device_initcall(rbtx4938_wdt_init);
-
-/* Minimum CLK support */
-
-struct clk *clk_get(struct device *dev, const char *id)
-{
-	if (!strcmp(id, "spi-baseclk"))
-		return (struct clk *)(txx9_gbus_clock / 2 / 4);
-	if (!strcmp(id, "imbus_clk"))
-		return (struct clk *)(txx9_gbus_clock / 2);
-	return ERR_PTR(-ENOENT);
-}
-EXPORT_SYMBOL(clk_get);
-
-int clk_enable(struct clk *clk)
-{
-	return 0;
-}
-EXPORT_SYMBOL(clk_enable);
-
-void clk_disable(struct clk *clk)
-{
-}
-EXPORT_SYMBOL(clk_disable);
 
-unsigned long clk_get_rate(struct clk *clk)
+static void __init rbtx4938_device_init(void)
 {
-	return (unsigned long)clk;
+	rbtx4938_ethaddr_init();
+	rbtx4938_ne_init();
+	rbtx4938_wdt_init();
 }
-EXPORT_SYMBOL(clk_get_rate);
 
-void clk_put(struct clk *clk)
-{
-}
-EXPORT_SYMBOL(clk_put);
+struct txx9_board_vec rbtx4938_vec __initdata = {
+	.type = MACH_TOSHIBA_RBTX4938,
+	.system = "Toshiba RBTX4938",
+	.prom_init = rbtx4938_prom_init,
+	.mem_setup = rbtx4938_mem_setup,
+	.irq_setup = rbtx4938_irq_setup,
+	.time_init = rbtx4938_time_init,
+	.device_init = rbtx4938_device_init,
+	.arch_init = rbtx4938_arch_init,
+#ifdef CONFIG_PCI
+	.pci_map_irq = rbtx4938_pci_map_irq,
+#endif
+};
diff --git a/include/asm-mips/txx9/generic.h b/include/asm-mips/txx9/generic.h
index 2ff6c20..6cd1477 100644
--- a/include/asm-mips/txx9/generic.h
+++ b/include/asm-mips/txx9/generic.h
@@ -20,4 +20,22 @@ extern unsigned int txx9_master_clock;
 extern unsigned int txx9_cpu_clock;
 extern unsigned int txx9_gbus_clock;
 
+struct pci_dev;
+struct txx9_board_vec {
+	unsigned long type;
+	const char *system;
+	void (*prom_init)(void);
+	void (*mem_setup)(void);
+	void (*irq_setup)(void);
+	void (*time_init)(void);
+	void (*arch_init)(void);
+	void (*device_init)(void);
+#ifdef CONFIG_PCI
+	int (*pci_map_irq)(const struct pci_dev *dev, u8 slot, u8 pin);
+#endif
+};
+extern struct txx9_board_vec *txx9_board_vec;
+extern int (*txx9_irq_dispatch)(int pending);
+void prom_init_cmdline(void);
+
 #endif /* __ASM_TXX9_GENERIC_H */
diff --git a/include/asm-mips/txx9/jmr3927.h b/include/asm-mips/txx9/jmr3927.h
index 29e5498..d6eb1b6 100644
--- a/include/asm-mips/txx9/jmr3927.h
+++ b/include/asm-mips/txx9/jmr3927.h
@@ -174,4 +174,9 @@
  *	INT[3:0]
  */
 
+void jmr3927_prom_init(void);
+void jmr3927_irq_setup(void);
+struct pci_dev;
+int jmr3927_pci_map_irq(const struct pci_dev *dev, u8 slot, u8 pin);
+
 #endif /* __ASM_TXX9_JMR3927_H */
diff --git a/include/asm-mips/txx9/rbtx4927.h b/include/asm-mips/txx9/rbtx4927.h
index 5b6f488..bf19458 100644
--- a/include/asm-mips/txx9/rbtx4927.h
+++ b/include/asm-mips/txx9/rbtx4927.h
@@ -46,12 +46,16 @@
 #define RBTX4927_INTF_PCIB	(1 << RBTX4927_INTB_PCIB)
 #define RBTX4927_INTF_PCIA	(1 << RBTX4927_INTB_PCIA)
 
-#define RBTX4927_IRQ_IOC	(TX4927_IRQ_PIC_BEG + TX4927_NUM_IR)
+#define RBTX4927_NR_IRQ_IOC	8	/* IOC */
+
+#define RBTX4927_IRQ_IOC	(TXX9_IRQ_BASE + TX4927_NUM_IR)
 #define RBTX4927_IRQ_IOC_PCID	(RBTX4927_IRQ_IOC + RBTX4927_INTB_PCID)
 #define RBTX4927_IRQ_IOC_PCIC	(RBTX4927_IRQ_IOC + RBTX4927_INTB_PCIC)
 #define RBTX4927_IRQ_IOC_PCIB	(RBTX4927_IRQ_IOC + RBTX4927_INTB_PCIB)
 #define RBTX4927_IRQ_IOC_PCIA	(RBTX4927_IRQ_IOC + RBTX4927_INTB_PCIA)
 
+#define RBTX4927_IRQ_IOCINT	(TXX9_IRQ_BASE + TX4927_IR_INT(1))
+
 #ifdef CONFIG_PCI
 #define RBTX4927_ISA_IO_OFFSET RBTX4927_PCIIO
 #else
@@ -65,8 +69,11 @@
 #define RBTX4927_SW_RESET_ENABLE_SET            0x01
 
 #define RBTX4927_RTL_8019_BASE (0x1c020280 - RBTX4927_ISA_IO_OFFSET)
-#define RBTX4927_RTL_8019_IRQ  (TX4927_IRQ_PIC_BEG + 5)
+#define RBTX4927_RTL_8019_IRQ  (TXX9_IRQ_BASE + TX4927_IR_INT(3))
 
-int toshiba_rbtx4927_irq_nested(int sw_irq);
+void rbtx4927_prom_init(void);
+void rbtx4927_irq_setup(void);
+struct pci_dev;
+int rbtx4927_pci_map_irq(const struct pci_dev *dev, u8 slot, u8 pin);
 
 #endif /* __ASM_TXX9_RBTX4927_H */
diff --git a/include/asm-mips/txx9/rbtx4938.h b/include/asm-mips/txx9/rbtx4938.h
index 8450f73..2f5d5e7 100644
--- a/include/asm-mips/txx9/rbtx4938.h
+++ b/include/asm-mips/txx9/rbtx4938.h
@@ -101,35 +101,12 @@
  * that particular IRQ on an RBTX4938 machine.  Add new 'spaces' as new
  * IRQ hardware is supported.
  */
-#define RBTX4938_NR_IRQ_LOCAL	8
-#define RBTX4938_NR_IRQ_IRC	32	/* On-Chip IRC */
 #define RBTX4938_NR_IRQ_IOC	8
 
-#define TX4938_IRQ_CP0_BEG  MIPS_CPU_IRQ_BASE
-#define TX4938_IRQ_CP0_END  (MIPS_CPU_IRQ_BASE + 8 - 1)
-
-#define TX4938_IRQ_PIC_BEG  TXX9_IRQ_BASE
-#define TX4938_IRQ_PIC_END  (TXX9_IRQ_BASE + TXx9_MAX_IR - 1)
-#define TX4938_IRQ_NEST_EXT_ON_PIC  (TX4938_IRQ_PIC_BEG+2)
-#define TX4938_IRQ_NEST_PIC_ON_CP0  (TX4938_IRQ_CP0_BEG+2)
-#define TX4938_IRQ_USER0            (TX4938_IRQ_CP0_BEG+0)
-#define TX4938_IRQ_USER1            (TX4938_IRQ_CP0_BEG+1)
-#define TX4938_IRQ_CPU_TIMER        (TX4938_IRQ_CP0_BEG+7)
-
-#define TOSHIBA_RBTX4938_IRQ_IOC_RAW_BEG   0
-#define TOSHIBA_RBTX4938_IRQ_IOC_RAW_END   7
-
-#define TOSHIBA_RBTX4938_IRQ_IOC_BEG  ((TX4938_IRQ_PIC_END+1)+TOSHIBA_RBTX4938_IRQ_IOC_RAW_BEG) /* 56 */
-#define TOSHIBA_RBTX4938_IRQ_IOC_END  ((TX4938_IRQ_PIC_END+1)+TOSHIBA_RBTX4938_IRQ_IOC_RAW_END) /* 63 */
-#define RBTX4938_IRQ_LOCAL	TX4938_IRQ_CP0_BEG
-#define RBTX4938_IRQ_IRC	(RBTX4938_IRQ_LOCAL + RBTX4938_NR_IRQ_LOCAL)
-#define RBTX4938_IRQ_IOC	(RBTX4938_IRQ_IRC + RBTX4938_NR_IRQ_IRC)
+#define RBTX4938_IRQ_IRC	TXX9_IRQ_BASE
+#define RBTX4938_IRQ_IOC	(TXX9_IRQ_BASE + TX4938_NUM_IR)
 #define RBTX4938_IRQ_END	(RBTX4938_IRQ_IOC + RBTX4938_NR_IRQ_IOC)
 
-#define RBTX4938_IRQ_LOCAL_SOFT0	(RBTX4938_IRQ_LOCAL + RBTX4938_SOFT_INT0)
-#define RBTX4938_IRQ_LOCAL_SOFT1	(RBTX4938_IRQ_LOCAL + RBTX4938_SOFT_INT1)
-#define RBTX4938_IRQ_LOCAL_IRC	(RBTX4938_IRQ_LOCAL + RBTX4938_IRC_INT)
-#define RBTX4938_IRQ_LOCAL_TIMER	(RBTX4938_IRQ_LOCAL + RBTX4938_TIMER_INT)
 #define RBTX4938_IRQ_IRC_ECCERR	(RBTX4938_IRQ_IRC + TX4938_IR_ECCERR)
 #define RBTX4938_IRQ_IRC_WTOERR	(RBTX4938_IRQ_IRC + TX4938_IR_WTOERR)
 #define RBTX4938_IRQ_IRC_INT(n)	(RBTX4938_IRQ_IRC + TX4938_IR_INT(n))
@@ -157,11 +134,16 @@
 
 
 /* IOC (PCI, etc) */
-#define RBTX4938_IRQ_IOCINT	(TX4938_IRQ_NEST_EXT_ON_PIC)
+#define RBTX4938_IRQ_IOCINT	(TXX9_IRQ_BASE + TX4938_IR_INT(0))
 /* Onboard 10M Ether */
-#define RBTX4938_IRQ_ETHER	(TX4938_IRQ_NEST_EXT_ON_PIC + 1)
+#define RBTX4938_IRQ_ETHER	(TXX9_IRQ_BASE + TX4938_IR_INT(1))
 
 #define RBTX4938_RTL_8019_BASE (RBTX4938_ETHER_ADDR - mips_io_port_base)
 #define RBTX4938_RTL_8019_IRQ  (RBTX4938_IRQ_ETHER)
 
+void rbtx4938_prom_init(void);
+void rbtx4938_irq_setup(void);
+struct pci_dev;
+int rbtx4938_pci_map_irq(const struct pci_dev *dev, u8 slot, u8 pin);
+
 #endif /* __ASM_TXX9_RBTX4938_H */
diff --git a/include/asm-mips/txx9/tx4927.h b/include/asm-mips/txx9/tx4927.h
index c0382fd..46d60af 100644
--- a/include/asm-mips/txx9/tx4927.h
+++ b/include/asm-mips/txx9/tx4927.h
@@ -32,20 +32,6 @@
 #include <asm/txx9irq.h>
 #include <asm/txx9/tx4927pcic.h>
 
-#define TX4927_IRQ_CP0_BEG  MIPS_CPU_IRQ_BASE
-#define TX4927_IRQ_CP0_END  (MIPS_CPU_IRQ_BASE + 8 - 1)
-
-#define TX4927_IRQ_PIC_BEG  TXX9_IRQ_BASE
-#define TX4927_IRQ_PIC_END  (TXX9_IRQ_BASE + TXx9_MAX_IR - 1)
-
-
-#define TX4927_IRQ_USER0	    (TX4927_IRQ_CP0_BEG+0)
-#define TX4927_IRQ_USER1	    (TX4927_IRQ_CP0_BEG+1)
-#define TX4927_IRQ_NEST_PIC_ON_CP0  (TX4927_IRQ_CP0_BEG+2)
-#define TX4927_IRQ_CPU_TIMER	    (TX4927_IRQ_CP0_BEG+7)
-
-#define TX4927_IRQ_NEST_EXT_ON_PIC  (TX4927_IRQ_PIC_BEG+3)
-
 #define TX4927_SDRAMC_REG	0xff1f8000
 #define TX4927_EBUSC_REG	0xff1f9000
 #define TX4927_PCIC_REG		0xff1fd000
@@ -54,10 +40,14 @@
 #define TX4927_NR_TMR	3
 #define TX4927_TMR_REG(ch)	(0xff1ff000 + (ch) * 0x100)
 
+#define TX4927_IR_INT(n)	(2 + (n))
+#define TX4927_IR_SIO(n)	(8 + (n))
 #define TX4927_IR_PCIC		16
 #define TX4927_IR_PCIERR	22
 #define TX4927_NUM_IR	32
 
+#define TX4927_IRC_INT	2	/* IP[2] in Status register */
+
 struct tx4927_sdramc_reg {
 	volatile unsigned long long cr[4];
 	volatile unsigned long long unused0[4];
@@ -224,5 +214,6 @@ static inline void tx4927_ccfg_change(__u64 change, __u64 new)
 
 int tx4927_report_pciclk(void);
 int tx4927_pciclk66_setup(void);
+void tx4927_irq_init(void);
 
 #endif /* __ASM_TXX9_TX4927_H */
diff --git a/include/asm-mips/txx9/tx4938.h b/include/asm-mips/txx9/tx4938.h
index 0bb8919..12de68a 100644
--- a/include/asm-mips/txx9/tx4938.h
+++ b/include/asm-mips/txx9/tx4938.h
@@ -18,11 +18,6 @@
 #define tx4938_read_nfmc(addr) (*(volatile unsigned int *)(addr))
 #define tx4938_write_nfmc(b, addr) (*(volatile unsigned int *)(addr)) = (b)
 
-#define TX4938_NR_IRQ_LOCAL     TX4938_IRQ_PIC_BEG
-
-#define TX4938_IRQ_IRC_PCIC     (TX4938_NR_IRQ_LOCAL + TX4938_IR_PCIC)
-#define TX4938_IRQ_IRC_PCIERR   (TX4938_NR_IRQ_LOCAL + TX4938_IR_PCIERR)
-
 #define TX4938_PCIIO_0 0x10000000
 #define TX4938_PCIIO_1 0x01010000
 #define TX4938_PCIMEM_0 0x08000000
@@ -271,6 +266,8 @@ struct tx4938_ccfg_reg {
 #define TX4938_IR_ETH0	TX4938_IR_INT(4)
 #define TX4938_IR_ETH1	TX4938_IR_INT(3)
 
+#define TX4938_IRC_INT	2	/* IP[2] in Status register */
+
 /*
  * CCFG
  */
@@ -463,5 +460,6 @@ void tx4938_report_pci1clk(void);
 int tx4938_pciclk66_setup(void);
 struct pci_dev;
 int tx4938_pcic1_map_irq(const struct pci_dev *dev, u8 slot);
+void tx4938_irq_init(void);
 
 #endif
