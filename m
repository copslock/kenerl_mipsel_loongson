Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 30 Apr 2008 20:24:17 +0100 (BST)
Received: from rtsoft3.corbina.net ([85.21.88.6]:58817 "EHLO
	buildserver.ru.mvista.com") by ftp.linux-mips.org with ESMTP
	id S30617931AbYD3TYN (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 30 Apr 2008 20:24:13 +0100
Received: from wasted.dev.rtsoft.ru (unknown [10.150.0.9])
	by buildserver.ru.mvista.com (Postfix) with ESMTP
	id EF6998815; Thu,  1 May 2008 00:24:05 +0500 (SAMST)
From:	Sergei Shtylyov <sshtylyov@ru.mvista.com>
Organization: MontaVista Software Inc.
To:	ralf@linux-mips.org
Subject: [PATCH 3/11] Alchemy PCI code style cleanup
Date:	Wed, 30 Apr 2008 23:23:27 +0400
User-Agent: KMail/1.5
Cc:	linux-mips@linux-mips.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200804302323.27714.sshtylyov@ru.mvista.com>
Return-Path: <sshtylyov@ru.mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 19056
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sshtylyov@ru.mvista.com
Precedence: bulk
X-list: linux-mips

Fix 15 errors and 4 warnings given by checkpatch.pl:

- space between the asterisk and variable name;

- space after opening and before closing parentheses;

- leading spaces instead of tabs;

- printk() without KERN_* facility level;

- unnecessary braces for single-statement block;

- line over 80 characters.

In addition to these changes, also do the following:

- combine the nested 'if' statements into one when possible;

- remove needless parentheses;

- add missing and remove excess spaces between operator and its operands;

- fix printk() format specifiers mismatching the argument types;

- put the function's result type and name/parameters on the same line;

- insert missing and remove excess new lines;

- properly indent multi-line expressions;

- make the multi-line comment style consistent with the kernel style elsewhere
  by adding empty first line;

- fix typos, capitalize acronyms, etc. in the comments;

- update MontaVista copyright;

- remove Pete Popov's old email address...

Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

 arch/mips/pci/fixup-au1000.c |    7 +-
 arch/mips/pci/ops-au1000.c   |  117 +++++++++++++++++++------------------------
 2 files changed, 57 insertions(+), 67 deletions(-)

Index: linux-2.6/arch/mips/pci/fixup-au1000.c
===================================================================
--- linux-2.6.orig/arch/mips/pci/fixup-au1000.c
+++ linux-2.6/arch/mips/pci/fixup-au1000.c
@@ -1,10 +1,9 @@
 /*
  * BRIEF MODULE DESCRIPTION
- *	Board specific pci fixups.
+ *	Board specific PCI fixups.
  *
- * Copyright 2001-2003 MontaVista Software Inc.
- * Author: MontaVista Software, Inc.
- *         	ppopov@mvista.com or source@mvista.com
+ * Copyright 2001-2003, 2008 MontaVista Software Inc.
+ * Author: MontaVista Software, Inc. <source@mvista.com>
  *
  *  This program is free software; you can redistribute  it and/or modify it
  *  under  the terms of  the GNU General  Public License as published by the
Index: linux-2.6/arch/mips/pci/ops-au1000.c
===================================================================
--- linux-2.6.orig/arch/mips/pci/ops-au1000.c
+++ linux-2.6/arch/mips/pci/ops-au1000.c
@@ -1,10 +1,9 @@
 /*
  * BRIEF MODULE DESCRIPTION
- *	Alchemy/AMD Au1x00 PCI support.
+ *	Alchemy/AMD Au1xx0 PCI support.
  *
- * Copyright 2001-2003, 2007 MontaVista Software Inc.
- * Author: MontaVista Software, Inc.
- *         	ppopov@mvista.com or source@mvista.com
+ * Copyright 2001-2003, 2007-2008 MontaVista Software Inc.
+ * Author: MontaVista Software, Inc. <source@mvista.com>
  *
  *  Support for all devices (greater than 16) added by David Gathright.
  *
@@ -28,6 +27,7 @@
  *  with this program; if not, write  to the Free Software Foundation, Inc.,
  *  675 Mass Ave, Cambridge, MA 02139, USA.
  */
+
 #include <linux/types.h>
 #include <linux/pci.h>
 #include <linux/kernel.h>
@@ -36,9 +36,9 @@
 
 #include <asm/mach-au1x00/au1000.h>
 
-#undef DEBUG
-#ifdef DEBUG
-#define DBG(x...) printk(x)
+#undef	DEBUG
+#ifdef	DEBUG
+#define DBG(x...) printk(KERN_DEBUG x)
 #else
 #define DBG(x...)
 #endif
@@ -46,7 +46,6 @@
 #define PCI_ACCESS_READ  0
 #define PCI_ACCESS_WRITE 1
 
-
 int (*board_pci_idsel)(unsigned int devsel, int assert);
 
 void mod_wired_entry(int entry, unsigned long entrylo0,
@@ -92,10 +91,9 @@ void __init au1x_pci_cfg_init(void)
 }
 
 static int config_access(unsigned char access_type, struct pci_bus *bus,
-			 unsigned int dev_fn, unsigned char where,
-			 u32 * data)
+			 unsigned int dev_fn, unsigned char where, u32 *data)
 {
-#if defined( CONFIG_SOC_AU1500 ) || defined( CONFIG_SOC_AU1550 )
+#if defined(CONFIG_SOC_AU1500) || defined(CONFIG_SOC_AU1550)
 	unsigned int device = PCI_SLOT(dev_fn);
 	unsigned int function = PCI_FUNC(dev_fn);
 	unsigned long offset, status;
@@ -114,38 +112,36 @@ static int config_access(unsigned char a
 			Au1500_PCI_STATCMD);
 	au_sync_udelay(1);
 
-	/* Allow board vendors to implement their own off-chip idsel.
+	/*
+	 * Allow board vendors to implement their own off-chip IDSEL.
 	 * If it doesn't succeed, may as well bail out at this point.
 	 */
-	if (board_pci_idsel) {
-		if (board_pci_idsel(device, 1) == 0) {
-			*data = 0xffffffff;
-			local_irq_restore(flags);
-			return -1;
-		}
+	if (board_pci_idsel && board_pci_idsel(device, 1) == 0) {
+		*data = 0xffffffff;
+		local_irq_restore(flags);
+		return -1;
 	}
 
-        /* setup the config window */
-        if (bus->number == 0) {
-                cfg_base = ((1<<device)<<11);
-        } else {
-                cfg_base = 0x80000000 | (bus->number<<16) | (device<<11);
-        }
-
-        /* setup the lower bits of the 36 bit address */
-        offset = (function << 8) | (where & ~0x3);
-	/* pick up any address that falls below the page mask */
+	/* Setup the config window */
+	if (bus->number == 0)
+		cfg_base = (1 << device) << 11;
+	else
+		cfg_base = 0x80000000 | (bus->number << 16) | (device << 11);
+
+	/* Setup the lower bits of the 36-bit address */
+	offset = (function << 8) | (where & ~0x3);
+	/* Pick up any address that falls below the page mask */
 	offset |= cfg_base & ~PAGE_MASK;
 
-	/* page boundary */
+	/* Page boundary */
 	cfg_base = cfg_base & PAGE_MASK;
 
 	/*
 	 * To improve performance, if the current device is the same as
 	 * the last device accessed, we don't touch the TLB.
 	 */
-	entryLo0 = (6 << 26)  | (cfg_base >> 6) | (2 << 3) | 7;
-	entryLo1 = (6 << 26)  | (cfg_base >> 6) | (0x1000 >> 6) | (2 << 3) | 7;
+	entryLo0 = (6 << 26) | (cfg_base >> 6) | (2 << 3) | 7;
+	entryLo1 = (6 << 26) | (cfg_base >> 6) | (0x1000 >> 6) | (2 << 3) | 7;
 	if ((entryLo0 != last_entryLo0) || (entryLo1 != last_entryLo1)) {
 		mod_wired_entry(pci_cfg_wired_entry, entryLo0, entryLo1,
 				(unsigned long)pci_cfg_vm->addr, PM_4K);
@@ -153,38 +149,37 @@ static int config_access(unsigned char a
 		last_entryLo1 = entryLo1;
 	}
 
-	if (access_type == PCI_ACCESS_WRITE) {
+	if (access_type == PCI_ACCESS_WRITE)
 		au_writel(*data, (int)(pci_cfg_vm->addr + offset));
-	} else {
+	else
 		*data = au_readl((int)(pci_cfg_vm->addr + offset));
-	}
+
 	au_sync_udelay(2);
 
-	DBG("cfg_access %d bus->number %d dev %d at %x *data %x conf %x\n",
-			access_type, bus->number, device, where, *data, offset);
+	DBG("cfg_access %d bus->number %u dev %u at %x *data %x conf %lx\n",
+	    access_type, bus->number, device, where, *data, offset);
 
-	/* check master abort */
+	/* Check master abort */
 	status = au_readl(Au1500_PCI_STATCMD);
 
-	if (status & (1<<29)) {
+	if (status & (1 << 29)) {
 		*data = 0xffffffff;
 		error = -1;
 		DBG("Au1x Master Abort\n");
 	} else if ((status >> 28) & 0xf) {
-		DBG("PCI ERR detected: device %d, status %x\n", device, ((status >> 28) & 0xf));
+		DBG("PCI ERR detected: device %u, status %lx\n",
+		    device, (status >> 28) & 0xf);
 
-		/* clear errors */
+		/* Clear errors */
 		au_writel(status & 0xf000ffff, Au1500_PCI_STATCMD);
 
 		*data = 0xffffffff;
 		error = -1;
 	}
 
-	/* Take away the idsel.
-	*/
-	if (board_pci_idsel) {
+	/* Take away the IDSEL. */
+	if (board_pci_idsel)
 		(void)board_pci_idsel(device, 0);
-	}
 
 	local_irq_restore(flags);
 	return error;
@@ -192,7 +187,7 @@ static int config_access(unsigned char a
 }
 
 static int read_config_byte(struct pci_bus *bus, unsigned int devfn,
-			    int where, u8 * val)
+			    int where,	u8 *val)
 {
 	u32 data;
 	int ret;
@@ -206,9 +201,8 @@ static int read_config_byte(struct pci_b
 	return ret;
 }
 
-
 static int read_config_word(struct pci_bus *bus, unsigned int devfn,
-			    int where, u16 * val)
+			    int where, u16 *val)
 {
 	u32 data;
 	int ret;
@@ -221,7 +215,7 @@ static int read_config_word(struct pci_b
 }
 
 static int read_config_dword(struct pci_bus *bus, unsigned int devfn,
-			     int where, u32 * val)
+			     int where, u32 *val)
 {
 	int ret;
 
@@ -229,9 +223,8 @@ static int read_config_dword(struct pci_
 	return ret;
 }
 
-static int
-write_config_byte(struct pci_bus *bus, unsigned int devfn, int where,
-		  u8 val)
+static int write_config_byte(struct pci_bus *bus, unsigned int devfn,
+			     int where, u8 val)
 {
 	u32 data = 0;
 
@@ -239,7 +232,7 @@ write_config_byte(struct pci_bus *bus, u
 		return -1;
 
 	data = (data & ~(0xff << ((where & 3) << 3))) |
-	    (val << ((where & 3) << 3));
+	       (val << ((where & 3) << 3));
 
 	if (config_access(PCI_ACCESS_WRITE, bus, devfn, where, &data))
 		return -1;
@@ -247,9 +240,8 @@ write_config_byte(struct pci_bus *bus, u
 	return PCIBIOS_SUCCESSFUL;
 }
 
-static int
-write_config_word(struct pci_bus *bus, unsigned int devfn, int where,
-		  u16 val)
+static int write_config_word(struct pci_bus *bus, unsigned int devfn,
+			     int where, u16 val)
 {
 	u32 data = 0;
 
@@ -257,18 +249,16 @@ write_config_word(struct pci_bus *bus, u
 		return -1;
 
 	data = (data & ~(0xffff << ((where & 3) << 3))) |
-	    (val << ((where & 3) << 3));
+	       (val << ((where & 3) << 3));
 
 	if (config_access(PCI_ACCESS_WRITE, bus, devfn, where, &data))
 		return -1;
 
-
 	return PCIBIOS_SUCCESSFUL;
 }
 
-static int
-write_config_dword(struct pci_bus *bus, unsigned int devfn, int where,
-		   u32 val)
+static int write_config_dword(struct pci_bus *bus, unsigned int devfn,
+			      int where, u32 val)
 {
 	if (config_access(PCI_ACCESS_WRITE, bus, devfn, where, &val))
 		return -1;
@@ -277,18 +267,20 @@ write_config_dword(struct pci_bus *bus, 
 }
 
 static int config_read(struct pci_bus *bus, unsigned int devfn,
-		       int where, int size, u32 * val)
+		       int where, int size, u32 *val)
 {
 	switch (size) {
 	case 1: {
 			u8 _val;
 			int rc = read_config_byte(bus, devfn, where, &_val);
+
 			*val = _val;
 			return rc;
 		}
-       case 2: {
+	case 2: {
 			u16 _val;
 			int rc = read_config_word(bus, devfn, where, &_val);
+
 			*val = _val;
 			return rc;
 		}
@@ -310,7 +302,6 @@ static int config_write(struct pci_bus *
 	}
 }
 
-
 struct pci_ops au1x_pci_ops = {
 	config_read,
 	config_write
