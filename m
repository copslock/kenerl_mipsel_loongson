Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 17 Apr 2008 21:07:47 +0100 (BST)
Received: from elvis.franken.de ([193.175.24.41]:32472 "EHLO elvis.franken.de")
	by ftp.linux-mips.org with ESMTP id S20023833AbYDQUHp (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 17 Apr 2008 21:07:45 +0100
Received: from uucp (helo=solo.franken.de)
	by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
	id 1JmaOW-0007xM-00; Thu, 17 Apr 2008 22:07:44 +0200
Received: by solo.franken.de (Postfix, from userid 1000)
	id 9914FC2BFD; Thu, 17 Apr 2008 22:07:42 +0200 (CEST)
From:	Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Subject: [PATCH] IP27: misc fixes
To:	linux-mips@linux-mips.org
cc:	ralf@linux-mips.org
Message-Id: <20080417200742.9914FC2BFD@solo.franken.de>
Date:	Thu, 17 Apr 2008 22:07:42 +0200 (CEST)
Return-Path: <tsbogend@alpha.franken.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 18954
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tsbogend@alpha.franken.de
Precedence: bulk
X-list: linux-mips

- fix PCI interrupt assignment by emulating ioc3 interrupt pin register
- use pci_probe_only mode
- select correct page size in bridge
- remove no longer needed ioc3_sio_init() code

Signed-off-by: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
---

 arch/mips/pci/ops-bridge.c     |   20 ++++++++++++++++++--
 arch/mips/pci/pci-ip27.c       |   10 ++++++++++
 arch/mips/sgi-ip27/ip27-init.c |   22 ----------------------
 3 files changed, 28 insertions(+), 24 deletions(-)

diff --git a/arch/mips/pci/ops-bridge.c b/arch/mips/pci/ops-bridge.c
index 1fa0992..b46b3e2 100644
--- a/arch/mips/pci/ops-bridge.c
+++ b/arch/mips/pci/ops-bridge.c
@@ -14,6 +14,22 @@
 #include <asm/sn/sn0/hub.h>
 
 /*
+ * Most of the IOC3 PCI config register aren't present
+ * we emulate what is needed for a normal PCI enumeration
+ */
+static u32 emulate_ioc3_cfg(int where, int size)
+{
+	if (size == 1 && where == 0x3d)
+		return 0x01;
+	else if (size == 2 && where == 0x3c)
+		return 0x0100;
+	else if (size == 4 && where == 0x3c)
+		return 0x00000100;
+
+	return 0;
+}
+
+/*
  * The Bridge ASIC supports both type 0 and type 1 access.  Type 1 is
  * not really documented, so right now I can't write code which uses it.
  * Therefore we use type 0 accesses for now even though they won't work
@@ -64,7 +80,7 @@ oh_my_gawd:
 	 * generic PCI code a chance to look at the wrong register.
 	 */
 	if ((where >= 0x14 && where < 0x40) || (where >= 0x48)) {
-		*value = 0;
+		*value = emulate_ioc3_cfg(where, size);
 		return PCIBIOS_SUCCESSFUL;
 	}
 
@@ -127,7 +143,7 @@ oh_my_gawd:
 	 * generic PCI code a chance to look at the wrong register.
 	 */
 	if ((where >= 0x14 && where < 0x40) || (where >= 0x48)) {
-		*value = 0;
+		*value = emulate_ioc3_cfg(where, size);
 		return PCIBIOS_SUCCESSFUL;
 	}
 
diff --git a/arch/mips/pci/pci-ip27.c b/arch/mips/pci/pci-ip27.c
index bb64828..b8a28b5 100644
--- a/arch/mips/pci/pci-ip27.c
+++ b/arch/mips/pci/pci-ip27.c
@@ -47,6 +47,9 @@ int __cpuinit bridge_probe(nasid_t nasid, int widget_id, int masterwid)
 	static int num_bridges = 0;
 	bridge_t *bridge;
 	int slot;
+	extern int pci_probe_only;
+
+	pci_probe_only = 1;
 
 	printk("a bridge\n");
 
@@ -100,6 +103,13 @@ int __cpuinit bridge_probe(nasid_t nasid, int widget_id, int masterwid)
 	 */
 	bridge->b_wid_control |= BRIDGE_CTRL_IO_SWAP |
 	                         BRIDGE_CTRL_MEM_SWAP;
+#ifdef CONFIG_PAGE_SIZE_4KB
+	bridge->b_wid_control &= ~BRIDGE_CTRL_PAGE_SIZE;
+#elif defined(CONFIG_PAGE_SIZE_16KB)
+	bridge->b_wid_control |= BRIDGE_CTRL_PAGE_SIZE;
+#else
+#error Fixme for page size other than 4kB and 16kB
+#endif
 
 	/*
 	 * Hmm...  IRIX sets additional bits in the address which
diff --git a/arch/mips/sgi-ip27/ip27-init.c b/arch/mips/sgi-ip27/ip27-init.c
index 7093e7c..4a500e8 100644
--- a/arch/mips/sgi-ip27/ip27-init.c
+++ b/arch/mips/sgi-ip27/ip27-init.c
@@ -161,27 +161,6 @@ cnodeid_t get_compact_nodeid(void)
 	return NASID_TO_COMPACT_NODEID(get_nasid());
 }
 
-/* Extracted from the IOC3 meta driver.  FIXME.  */
-static inline void ioc3_sio_init(void)
-{
-	struct ioc3 *ioc3;
-	nasid_t nid;
-	long loops;
-
-	nid = get_nasid();
-	ioc3 = (struct ioc3 *) KL_CONFIG_CH_CONS_INFO(nid)->memory_base;
-
-	ioc3->sscr_a = 0;			/* PIO mode for uarta.  */
-	ioc3->sscr_b = 0;			/* PIO mode for uartb.  */
-	ioc3->sio_iec = ~0;
-	ioc3->sio_ies = (SIO_IR_SA_INT | SIO_IR_SB_INT);
-
-	loops=1000000; while(loops--);
-	ioc3->sregs.uarta.iu_fcr = 0;
-	ioc3->sregs.uartb.iu_fcr = 0;
-	loops=1000000; while(loops--);
-}
-
 static inline void ioc3_eth_init(void)
 {
 	struct ioc3 *ioc3;
@@ -234,7 +213,6 @@ void __init plat_mem_setup(void)
 		panic("Kernel compiled for N mode.");
 #endif
 
-	ioc3_sio_init();
 	ioc3_eth_init();
 	per_cpu_init();
 
