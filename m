Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 10 Mar 2004 19:07:13 +0000 (GMT)
Received: from gateway-1237.mvista.com ([IPv6:::ffff:12.44.186.158]:21245 "EHLO
	orion.mvista.com") by linux-mips.org with ESMTP id <S8224952AbUCJTHM>;
	Wed, 10 Mar 2004 19:07:12 +0000
Received: from orion.mvista.com (localhost.localdomain [127.0.0.1])
	by orion.mvista.com (8.12.8/8.12.8) with ESMTP id i2AJ77x6022260;
	Wed, 10 Mar 2004 11:07:07 -0800
Received: (from jsun@localhost)
	by orion.mvista.com (8.12.8/8.12.8/Submit) id i2AJ77YP022258;
	Wed, 10 Mar 2004 11:07:07 -0800
Date: Wed, 10 Mar 2004 11:07:07 -0800
From: Jun Sun <jsun@mvista.com>
To: linux-mips@linux-mips.org
Cc: jsun@mvista.com
Subject: Re: [PATCH 2.6] make swarm compile and run again
Message-ID: <20040310190707.GC16027@mvista.com>
References: <20040310021550.GT31326@mvista.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="KsGdsel6WgEHnImy"
Content-Disposition: inline
In-Reply-To: <20040310021550.GT31326@mvista.com>
User-Agent: Mutt/1.4i
Return-Path: <jsun@orion.mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4525
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jsun@mvista.com
Precedence: bulk
X-list: linux-mips


--KsGdsel6WgEHnImy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Mar 09, 2004 at 06:15:50PM -0800, Jun Sun wrote:
> 
> Ralf,
> 
> This patch makes swarm compile and run again on 2.6.
> 
> I had to introduce a global function pointer, board_pcibios_init.
> This setup needs ioremap() which is too early for any other
> board setup hooks.
> 
> I think other boards will need this hookup too (e.g., NEC vr7701)
> 
> Does the patch look ok?
> 
> Jun
>

Looks like my snapshot is a couple of days old.  Here is the updated
patch with update config as well.

I will check in if no objections.

Jun 

--KsGdsel6WgEHnImy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="temp.patch"

diff -Nru linux/arch/mips/configs/sb1250-swarm_defconfig.orig linux/arch/mips/configs/sb1250-swarm_defconfig
--- linux/arch/mips/configs/sb1250-swarm_defconfig.orig	2004-02-22 19:14:30.000000000 -0800
+++ linux/arch/mips/configs/sb1250-swarm_defconfig	2004-03-10 11:04:09.000000000 -0800
@@ -82,12 +82,13 @@
 # CONFIG_SIBYTE_UNKNOWN is not set
 CONFIG_SIBYTE_BOARD=y
 CONFIG_SIBYTE_SB1250=y
-CONFIG_CPU_SB1_PASS_1=y
-# CONFIG_CPU_SB1_PASS_2_1250 is not set
+# CONFIG_CPU_SB1_PASS_1 is not set
+CONFIG_CPU_SB1_PASS_2_1250=y
 # CONFIG_CPU_SB1_PASS_2_2 is not set
 # CONFIG_CPU_SB1_PASS_4 is not set
 # CONFIG_CPU_SB1_PASS_2_112x is not set
 # CONFIG_CPU_SB1_PASS_3 is not set
+CONFIG_CPU_SB1_PASS_2=y
 CONFIG_SIBYTE_HAS_PCI=y
 CONFIG_SIBYTE_HAS_LDT=y
 # CONFIG_SIMULATION is not set
@@ -132,9 +133,9 @@
 # CONFIG_PAGE_SIZE_16KB is not set
 # CONFIG_PAGE_SIZE_64KB is not set
 # CONFIG_SIBYTE_DMA_PAGEOPS is not set
-# CONFIG_CPU_HAS_PREFETCH is not set
 CONFIG_VTAG_ICACHE=y
-CONFIG_SB1_PASS_1_WORKAROUNDS=y
+CONFIG_SB1_PASS_2_WORKAROUNDS=y
+CONFIG_SB1_PASS_2_1_WORKAROUNDS=y
 # CONFIG_64BIT_PHYS_ADDR is not set
 # CONFIG_CPU_ADVANCED is not set
 CONFIG_CPU_HAS_LLSC=y
@@ -316,7 +317,7 @@
 # Ethernet (10 or 100Mbit)
 #
 CONFIG_NET_ETHERNET=y
-# CONFIG_MII is not set
+CONFIG_MII=y
 CONFIG_NET_SB1250_MAC=y
 # CONFIG_HAPPYMEAL is not set
 # CONFIG_SUNGEM is not set
@@ -409,7 +410,7 @@
 # CONFIG_GAMEPORT is not set
 CONFIG_SOUND_GAMEPORT=y
 CONFIG_SERIO=y
-CONFIG_SERIO_I8042=y
+# CONFIG_SERIO_I8042 is not set
 CONFIG_SERIO_SERPORT=y
 # CONFIG_SERIO_CT82C710 is not set
 # CONFIG_SERIO_PCIPS2 is not set
@@ -439,7 +440,8 @@
 #
 # Non-8250 serial port support
 #
-# CONFIG_UNIX98_PTYS is not set
+CONFIG_UNIX98_PTYS=y
+CONFIG_UNIX98_PTY_COUNT=256
 
 #
 # Mice
@@ -542,6 +544,8 @@
 CONFIG_PROC_FS=y
 CONFIG_PROC_KCORE=y
 # CONFIG_DEVFS_FS is not set
+CONFIG_DEVPTS_FS=y
+# CONFIG_DEVPTS_FS_XATTR is not set
 # CONFIG_TMPFS is not set
 # CONFIG_HUGETLB_PAGE is not set
 CONFIG_RAMFS=y
@@ -631,6 +635,6 @@
 #
 # Library routines
 #
-# CONFIG_CRC32 is not set
+CONFIG_CRC32=y
 CONFIG_ZLIB_INFLATE=y
 CONFIG_ZLIB_DEFLATE=y
diff -Nru linux/arch/mips/pci/pci.c.orig linux/arch/mips/pci/pci.c
--- linux/arch/mips/pci/pci.c.orig	2004-03-09 17:40:10.000000000 -0800
+++ linux/arch/mips/pci/pci.c	2004-03-09 17:43:23.000000000 -0800
@@ -28,6 +28,8 @@
 
 unsigned int pci_probe = PCI_ASSIGN_ALL_BUSSES;
 
+void (*board_pcibios_init)(void) __initdata;
+
 /*
  * The PCI controller list.
  */
@@ -118,6 +120,9 @@
 	int next_busno;
 	int need_domain_info = 0;
 
+	if (board_pcibios_init)
+		board_pcibios_init();
+
 	/* Scan all of the recorded PCI controllers.  */
 	for (next_busno = 0, hose = hose_head; hose; hose = hose->next) {
 
diff -Nru linux/arch/mips/pci/pci-sb1250.c.orig linux/arch/mips/pci/pci-sb1250.c
--- linux/arch/mips/pci/pci-sb1250.c.orig	2004-03-09 16:38:36.000000000 -0800
+++ linux/arch/mips/pci/pci-sb1250.c	2004-03-09 17:39:55.000000000 -0800
@@ -84,6 +84,11 @@
 	*(u32 *) (cfg_space + (addr & ~3)) = data;
 }
 
+int pcibios_map_irq(struct pci_dev *dev, u8 slot, u8 pin)
+{
+	return dev->irq;
+}
+
 /*
  * Some checks before doing config cycles:
  * In PCI Device Mode, hide everything on bus 0 except the LDT host
@@ -194,10 +199,18 @@
 	.io_resource	= &sb1250_io_resource
 };
 
-int __init pcibios_init(void)	xxx This needs to be called somehow ...
+int __init sb1250_pcibios_init(void)
 {
 	uint32_t cmdreg;
 	uint64_t reg;
+	extern int pci_probe_only;
+
+	/* CFE will assign PCI resources */
+	pci_probe_only = 1;
+
+	/* fake resource limit to avoid errors */
+	iomem_resource.end = 0xffffffff;
+	ioport_resource.end = 0xffffffff;
 
 	cfg_space =
 	    ioremap(A_PHYS_LDTPCI_CFG_MATCH_BITS, 16 * 1024 * 1024);
diff -Nru linux/arch/mips/sibyte/sb1250/smp.c.orig linux/arch/mips/sibyte/sb1250/smp.c
--- linux/arch/mips/sibyte/sb1250/smp.c.orig	2004-03-09 16:40:21.000000000 -0800
+++ linux/arch/mips/sibyte/sb1250/smp.c	2004-03-10 10:38:32.000000000 -0800
@@ -94,5 +94,5 @@
 	 */
 
 	if (action & SMP_CALL_FUNCTION)
-		smp_call_function_interrupt(0, NULL, regs);
+		smp_call_function_interrupt();
 }
diff -Nru linux/arch/mips/sibyte/swarm/setup.c.orig linux/arch/mips/sibyte/swarm/setup.c
--- linux/arch/mips/sibyte/swarm/setup.c.orig	2004-03-09 16:40:21.000000000 -0800
+++ linux/arch/mips/sibyte/swarm/setup.c	2004-03-09 17:52:42.000000000 -0800
@@ -34,12 +34,14 @@
 #include <asm/reboot.h>
 #include <asm/time.h>
 #include <asm/traps.h>
+#include <asm/pci_channel.h>
 #include <asm/sibyte/sb1250.h>
 #include <asm/sibyte/sb1250_regs.h>
 #include <asm/sibyte/sb1250_genbus.h>
 #include <asm/sibyte/board.h>
 
 extern void sb1250_setup(void);
+extern void sb1250_pcibios_init(void);
 
 extern int xicor_probe(void);
 extern int xicor_set_time(unsigned long);
@@ -80,7 +82,7 @@
 	return (is_fixup ? MIPS_BE_FIXUP : MIPS_BE_FATAL);
 }
 
-static void __init swarm_setup(void)
+static int __init swarm_setup(void)
 {
 	extern int panic_timeout;
 
@@ -131,6 +133,12 @@
        };
        /* XXXKW for CFE, get lines/cols from environment */
 #endif
+
+#ifdef CONFIG_SIBYTE_HAS_PCI
+	board_pcibios_init = sb1250_pcibios_init;
+#endif
+
+	return 0;
 }
 
 early_initcall(swarm_setup);
diff -Nru linux/drivers/net/sb1250-mac.c.orig linux/drivers/net/sb1250-mac.c
diff -Nru linux/include/asm-mips/sibyte/board.h.orig linux/include/asm-mips/sibyte/board.h
--- linux/include/asm-mips/sibyte/board.h.orig	2004-01-05 10:48:39.000000000 -0800
+++ linux/include/asm-mips/sibyte/board.h	2004-03-09 17:52:17.000000000 -0800
@@ -56,8 +56,6 @@
 
 #else
 
-void swarm_setup(void);
-
 #ifdef LEDS_PHYS
 extern void setleds(char *str);
 #else
diff -Nru linux/include/asm-mips/pci_channel.h.orig linux/include/asm-mips/pci_channel.h
--- linux/include/asm-mips/pci_channel.h.orig	2003-11-13 18:35:35.000000000 -0800
+++ linux/include/asm-mips/pci_channel.h	2004-03-09 17:38:54.000000000 -0800
@@ -43,4 +43,10 @@
  */
 extern int pcibios_map_irq(struct pci_dev *dev, u8 slot, u8 pin);
 
+/*
+ * board pci initialization routine.  If set, it is called at the beginning
+ * of pcibios_init().
+ */
+extern void (*board_pcibios_init)(void);
+
 #endif  /* __ASM_PCI_CHANNEL_H */

--KsGdsel6WgEHnImy--
