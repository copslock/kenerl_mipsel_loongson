Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 25 Dec 2007 18:00:26 +0000 (GMT)
Received: from rtsoft3.corbina.net ([85.21.88.6]:26200 "EHLO
	buildserver.ru.mvista.com") by ftp.linux-mips.org with ESMTP
	id S28576632AbXLYSAR (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 25 Dec 2007 18:00:17 +0000
Received: from wasted.dev.rtsoft.ru (unknown [10.150.0.9])
	by buildserver.ru.mvista.com (Postfix) with ESMTP
	id 3BD5A8816; Tue, 25 Dec 2007 23:00:16 +0400 (SAMT)
From:	Sergei Shtylyov <sshtylyov@ru.mvista.com>
Organization: MontaVista Software Inc.
To:	ralf@linux-mips.org
Subject: [PATCH] Alchemy: fix modpost warning
Date:	Tue, 25 Dec 2007 21:00:45 +0300
User-Agent: KMail/1.5
Cc:	linux-mips@linux-mips.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200712252100.47365.sshtylyov@ru.mvista.com>
Return-Path: <sshtylyov@ru.mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17880
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sshtylyov@ru.mvista.com
Precedence: bulk
X-list: linux-mips

WARNING: vmlinux.o(.text+0x1ca608): Section mismatch: reference to .init.text:
add_wired_entry (between 'config_access' and 'config_read')

by refactoring the code calling add_wired_entry() from config_access() to
a separate function which is called from aau1x_pci_setup(). While at it:

- make some unnecassarily global variables 'static';

- fix the letter case, whitespace, etc. in the comments...

Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

 arch/mips/au1000/common/pci.c |    8 ++++--
 arch/mips/pci/ops-au1000.c    |   53 ++++++++++++++++++++----------------------
 2 files changed, 32 insertions(+), 29 deletions(-)

Index: linux-2.6/arch/mips/au1000/common/pci.c
===================================================================
--- linux-2.6.orig/arch/mips/au1000/common/pci.c
+++ linux-2.6/arch/mips/au1000/common/pci.c
@@ -1,8 +1,8 @@
 /*
  * BRIEF MODULE DESCRIPTION
- *	Alchemy/AMD Au1x00 pci support.
+ *	Alchemy/AMD Au1x00 PCI support.
  *
- * Copyright 2001,2002,2003 MontaVista Software Inc.
+ * Copyright 2001-2003, 2007 MontaVista Software Inc.
  * Author: MontaVista Software, Inc.
  *         	ppopov@mvista.com or source@mvista.com
  *
@@ -66,6 +66,8 @@ static unsigned long virt_io_addr;
 
 static int __init au1x_pci_setup(void)
 {
+	extern void au1x_pci_cfg_init(void);
+
 #if defined(CONFIG_SOC_AU1500) || defined(CONFIG_SOC_AU1550)
 	virt_io_addr = (unsigned long)ioremap(Au1500_PCI_IO_START,
 			Au1500_PCI_IO_END - Au1500_PCI_IO_START + 1);
@@ -94,6 +96,8 @@ static int __init au1x_pci_setup(void)
 	set_io_port_base(virt_io_addr);
 #endif
 
+	au1x_pci_cfg_init();
+
 	register_pci_controller(&au1x_controller);
 	return 0;
 }
Index: linux-2.6/arch/mips/pci/ops-au1000.c
===================================================================
--- linux-2.6.orig/arch/mips/pci/ops-au1000.c
+++ linux-2.6/arch/mips/pci/ops-au1000.c
@@ -1,8 +1,8 @@
 /*
  * BRIEF MODULE DESCRIPTION
- *	Alchemy/AMD Au1x00 pci support.
+ *	Alchemy/AMD Au1x00 PCI support.
  *
- * Copyright 2001,2002,2003 MontaVista Software Inc.
+ * Copyright 2001-2003, 2007 MontaVista Software Inc.
  * Author: MontaVista Software, Inc.
  *         	ppopov@mvista.com or source@mvista.com
  *
@@ -69,10 +69,27 @@ void mod_wired_entry(int entry, unsigned
 	write_c0_pagemask(old_pagemask);
 }
 
-struct vm_struct *pci_cfg_vm;
+static struct vm_struct *pci_cfg_vm;
 static int pci_cfg_wired_entry;
-static int first_cfg = 1;
-unsigned long last_entryLo0, last_entryLo1;
+static unsigned long last_entryLo0, last_entryLo1;
+
+/*
+ * We can't ioremap the entire pci config space because it's too large.
+ * Nor can we call ioremap dynamically because some device drivers use
+ * the PCI config routines from within interrupt handlers and that
+ * becomes a problem in get_vm_area().  We use one wired TLB to handle
+ * all config accesses for all busses.
+ */
+void __init au1x_pci_cfg_init(void)
+{
+	/* Reserve a wired entry for PCI config accesses */
+	pci_cfg_vm = get_vm_area(0x2000, VM_IOREMAP);
+	if (!pci_cfg_vm)
+		panic(KERN_ERR "PCI unable to get vm area\n");
+	pci_cfg_wired_entry = read_c0_wired();
+	add_wired_entry(0, 0, (unsigned long)pci_cfg_vm->addr, PM_4K);
+	last_entryLo0 = last_entryLo1 = 0xffffffff;
+}
 
 static int config_access(unsigned char access_type, struct pci_bus *bus,
 			 unsigned int dev_fn, unsigned char where,
@@ -97,27 +114,6 @@ static int config_access(unsigned char a
 			Au1500_PCI_STATCMD);
 	au_sync_udelay(1);
 
-	/*
-	 * We can't ioremap the entire pci config space because it's
-	 * too large. Nor can we call ioremap dynamically because some
-	 * device drivers use the pci config routines from within
-	 * interrupt handlers and that becomes a problem in get_vm_area().
-	 * We use one wired tlb to handle all config accesses for all
-	 * busses. To improve performance, if the current device
-	 * is the same as the last device accessed, we don't touch the
-	 * tlb.
-	 */
-	if (first_cfg) {
-		/* reserve a wired entry for pci config accesses */
-		first_cfg = 0;
-		pci_cfg_vm = get_vm_area(0x2000, VM_IOREMAP);
-		if (!pci_cfg_vm)
-			panic(KERN_ERR "PCI unable to get vm area\n");
-		pci_cfg_wired_entry = read_c0_wired();
-		add_wired_entry(0, 0, (unsigned long)pci_cfg_vm->addr, PM_4K);
-		last_entryLo0  = last_entryLo1 = 0xffffffff;
-	}
-
 	/* Allow board vendors to implement their own off-chip idsel.
 	 * If it doesn't succeed, may as well bail out at this point.
 	 */
@@ -144,9 +140,12 @@ static int config_access(unsigned char a
 	/* page boundary */
 	cfg_base = cfg_base & PAGE_MASK;
 
+	/*
+	 * To improve performance, if the current device is the same as
+	 * the last device accessed, we don't touch the TLB.
+	 */
 	entryLo0 = (6 << 26)  | (cfg_base >> 6) | (2 << 3) | 7;
 	entryLo1 = (6 << 26)  | (cfg_base >> 6) | (0x1000 >> 6) | (2 << 3) | 7;
-
 	if ((entryLo0 != last_entryLo0) || (entryLo1 != last_entryLo1)) {
 		mod_wired_entry(pci_cfg_wired_entry, entryLo0, entryLo1,
 				(unsigned long)pci_cfg_vm->addr, PM_4K);
