Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 24 Jun 2006 02:46:54 +0100 (BST)
Received: from mother.pmc-sierra.com ([216.241.224.12]:33205 "HELO
	mother.pmc-sierra.bc.ca") by ftp.linux-mips.org with SMTP
	id S8133862AbWFXBqn (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sat, 24 Jun 2006 02:46:43 +0100
Received: (qmail 5675 invoked by uid 101); 24 Jun 2006 01:46:37 -0000
Received: from unknown (HELO ogyruan.pmc-sierra.bc.ca) (216.241.226.236)
  by mother.pmc-sierra.com with SMTP; 24 Jun 2006 01:46:37 -0000
Received: from bby1exi01.pmc_nt.nt.pmc-sierra.bc.ca (bby1exi01.pmc-sierra.bc.ca [216.241.231.251])
	by ogyruan.pmc-sierra.bc.ca (8.13.3/8.12.7) with ESMTP id k5O1kauf001843;
	Fri, 23 Jun 2006 18:46:36 -0700
Received: by bby1exi01.pmc-sierra.bc.ca with Internet Mail Service (5.5.2656.59)
	id <JPF7KJHS>; Fri, 23 Jun 2006 18:46:36 -0700
Message-ID: <C28979E4F697C249ABDA83AC0C33CDF8143EF6@sjc1exm07.pmc_nt.nt.pmc-sierra.bc.ca>
From:	Kiran Thota <Kiran_Thota@pmc-sierra.com>
To:	ralf@linux-mips.org, linux-mips@linux-mips.org
Cc:	Raj Palani <Rajesh_Palani@pmc-sierra.com>
Subject: [PATCH 2/6]  Sequoia PCI
Date:	Fri, 23 Jun 2006 18:46:27 -0700
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2656.59)
Content-Type: text/plain
Return-Path: <Kiran_Thota@pmc-sierra.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11844
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Kiran_Thota@pmc-sierra.com
Precedence: bulk
X-list: linux-mips


- Add irq mapping for PCI
- Add PCI for Sequoia in Makefile
- Add PCI ops
- Add PCI setup and functions

Signed-Off-By: Kiran Kumar Thota <kiran_thota@pmc-sierra.com>


diff -Naur a/arch/mips/pci/fixup-sequoia.c b/arch/mips/pci/fixup-sequoia.c
--- a/arch/mips/pci/fixup-sequoia.c	1969-12-31 16:00:00.000000000 -0800
+++ b/arch/mips/pci/fixup-sequoia.c	2006-06-22 11:48:21.000000000 -0700
@@ -0,0 +1,43 @@
+/*
+ * Copyright 2006 PMC-Sierra
+ * Author: PMC Sierra Inc (thotakir@pmc-sierra.com)
+ *
+ */
+
+#include <linux/types.h>
+#include <linux/pci.h>
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <asm/pci.h>
+
+
+int __init pcibios_map_irq(struct pci_dev *dev, u8 slot, u8 pin)
+{
+        if (pin == 0)
+                return -1;
+
+	if ((dev->bus->number == 0) &&
+                        (slot== 2)) {
+                        /* bus 0, slot 0 */
+                        return 11;
+                } else if ((dev->bus->number == 0) &&
+                        (slot == 3)) {
+                        /* bus 0, slot 1 */
+                        return 12;
+                } else if ((dev->bus->number == 1) &&
+                        (slot == 2)) {
+                        /* bus 1, slot 0 */
+                        return 13;
+                } else if ((dev->bus->number == 1) &&
+                        (slot == 3)) {
+                        /* bus 1, slot 1 */
+                        return 14;
+                }
+}
+
+/* Do platform specific device initialization at pci_enable_device() time */
+int pcibios_plat_dev_init(struct pci_dev *dev)
+{
+        return 0;
+}
+
diff -Naur a/arch/mips/pci/Makefile b/arch/mips/pci/Makefile
--- a/arch/mips/pci/Makefile	2005-07-11 11:28:10.000000000 -0700
+++ b/arch/mips/pci/Makefile	2006-06-22 11:48:21.000000000 -0700
@@ -42,6 +42,8 @@
 obj-$(CONFIG_MOMENCO_OCELOT_G)	+= fixup-ocelot-g.o pci-ocelot-g.o
 obj-$(CONFIG_PMC_YOSEMITE)	+= fixup-yosemite.o ops-titan.o ops-titan-ht.o \
 				   pci-yosemite.o
+obj-$(CONFIG_PMC_SEQUOIA)       += fixup-sequoia.o ops-sequoia.o pci-sequoia.o
+
 obj-$(CONFIG_SGI_IP27)		+= pci-ip27.o
 obj-$(CONFIG_SGI_IP32)		+= fixup-ip32.o ops-mace.o pci-ip32.o
 obj-$(CONFIG_SIBYTE_SB1250)	+= fixup-sb1250.o pci-sb1250.o
diff -Naur a/arch/mips/pci/ops-sequoia.c b/arch/mips/pci/ops-sequoia.c
--- a/arch/mips/pci/ops-sequoia.c	1969-12-31 16:00:00.000000000 -0800
+++ b/arch/mips/pci/ops-sequoia.c	2006-06-22 14:51:08.000000000 -0700
@@ -0,0 +1,187 @@
+/*
+ * Copyright 2006 PMC-Sierra
+ * Author: PMC Sierra Inc (thotakir@pmc-sierra.com)
+ *
+ */
+
+#include <linux/config.h>
+#include <linux/types.h>
+#include <linux/pci.h>
+#include <linux/kernel.h>
+#include <linux/slab.h>
+#include <linux/version.h>
+#include <asm/pci.h>
+#include <asm/io.h>
+
+#include <linux/init.h>
+#include <asm/pmc_sequoia.h>
+
+
+void sequoia_pcibios_fixup_bus(struct pci_bus* c);
+
+
+/*
+ * Sequoia PCI Config Read Byte
+ */
+static int sequoia_pci_read_config(struct pci_bus *bus,
+	unsigned int devfn, int offset, int size, u32* val)
+{
+        int dev, busno, func;
+        uint32_t address_reg, data_reg;
+        uint32_t address, data = 0;
+
+	int local_busno = 0; 
+
+        busno = bus->number;
+        dev = PCI_SLOT(devfn);
+        func = PCI_FUNC(devfn);
+
+	address_reg = RM9150_PCI_CONFIG_ADDR;
+        data_reg = RM9150_PCI_CONFIG_DATA;        
+
+        address = (local_busno << 16) | (dev << 11) | (func << 8) |
+                (offset & 0xfc) | 0x80000000;
+
+        /* start the configuration cycle */
+	if (busno == 0)
+            SEQUOIA_PCI0_WRITE(address_reg, address);
+	else
+	    SEQUOIA_PCI1_WRITE(address_reg, address);
+
+        /* read the data */
+	switch (size) {
+	case 1:
+	
+	        if (busno == 0)
+	        {
+	            data = SEQUOIA_PCI0_READ(data_reg);
+		    *val = (data >> ((offset & 3) << 3)) & 0xff;
+	        }
+		else
+	        {
+	            data = SEQUOIA_PCI1_READ(data_reg);
+		    *val = (data >> ((offset & 3) << 3)) & 0xff;
+	        }
+		break;
+
+        case 2:
+	
+	        if (busno == 0)
+	        {
+	            data = SEQUOIA_PCI0_READ(data_reg);		           
+		    *val = (data >> ((offset & 3) << 3)) & 0xffff;		    		
+	        }
+	        else
+	        {
+	            data = SEQUOIA_PCI1_READ(data_reg);
+		    *val = (data >> ((offset & 3) << 3)) & 0xffff;
+	        }	
+                break;
+
+        case 4:
+		if (busno == 0)
+                    *val = SEQUOIA_PCI0_READ(data_reg);
+		else
+		    *val = SEQUOIA_PCI1_READ(data_reg);
+                break;
+        }
+
+        return PCIBIOS_SUCCESSFUL;
+}
+
+/*
+ * Sequoia PCI Config Byte Write
+ */
+static int sequoia_pci_write_config(struct pci_bus *bus,
+	unsigned int devfn, int offset, int size, u32 val)
+{
+        int dev, busno, func;
+        uint32_t address_reg, data_reg;
+        uint32_t address, data = 0;
+
+	int local_busno = 0;
+
+        busno = bus->number;
+        dev = PCI_SLOT(devfn);
+        func = PCI_FUNC(devfn);        
+
+	address_reg = RM9150_PCI_CONFIG_ADDR;
+        data_reg = RM9150_PCI_CONFIG_DATA;
+
+        address = (local_busno << 16) | (dev << 11) | (func << 8) |
+                (offset & 0xfc) | 0x80000000;
+
+        /* start the configuration cycle */
+	if (busno == 0)
+	    SEQUOIA_PCI0_WRITE(address_reg, address);
+	else
+            SEQUOIA_PCI1_WRITE(address_reg, address);
+
+        /* write the data */
+	switch (size) {
+	case 1:
+	  if (busno == 0)
+	    {
+	        /* read the data first */
+	        data = SEQUOIA_PCI0_READ(data_reg);
+		data = (data & ~(0xff << ((offset & 3) << 3))) |
+                    (val << ((offset & 3) << 3));
+
+		/* write the data */
+		SEQUOIA_PCI0_WRITE(data_reg, data);
+	    }
+	  else
+	    {
+	        /* read the data first */
+	        data = SEQUOIA_PCI1_READ(data_reg);
+		data = (data & ~(0xff << ((offset & 3) << 3))) |
+                    (val << ((offset & 3) << 3));
+
+		/* write the data */
+		SEQUOIA_PCI1_WRITE(data_reg, data);
+	    }	 
+		break;
+	case 2:
+	  if (busno == 0)
+	    {
+	        /* read the data first */
+                data = SEQUOIA_PCI0_READ(data_reg);
+	        data = (data & ~(0xffff << ((offset & 3) << 3))) |
+                    (val << ((offset & 3) << 3));
+
+                /* write the data */
+                SEQUOIA_PCI0_WRITE(data_reg, data);
+	    }
+	  else
+	    {
+	        /* read the data first */
+                data = SEQUOIA_PCI1_READ(data_reg);
+	        data = (data & ~(0xffff << ((offset & 3) << 3))) |
+                    (val << ((offset & 3) << 3));
+
+                /* write the data */
+                SEQUOIA_PCI1_WRITE(data_reg, data);
+	    }	
+                break;
+	case 4:
+		if (busno == 0)
+                    SEQUOIA_PCI0_WRITE(data_reg, val);
+                else
+                    SEQUOIA_PCI1_WRITE(data_reg, val);
+                break;
+	}
+
+        return PCIBIOS_SUCCESSFUL;
+}
+
+/*
+ * Sequoia PCI structure
+ */
+struct pci_ops sequoia_pci_ops = {
+        sequoia_pci_read_config,
+        sequoia_pci_write_config,
+};
+
+struct pci_fixup pcibios_fixups[] = {
+        {0}
+};
diff -Naur a/arch/mips/pci/pci-sequoia.c b/arch/mips/pci/pci-sequoia.c
--- a/arch/mips/pci/pci-sequoia.c	1969-12-31 16:00:00.000000000 -0800
+++ b/arch/mips/pci/pci-sequoia.c	2006-06-22 11:48:21.000000000 -0700
@@ -0,0 +1,78 @@
+/*
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ *
+ * Copyright (C) 2004 by Ralf Baechle (ralf@linux-mips.org)
+ */
+#include <linux/init.h>
+#include <linux/kernel.h>
+#include <linux/types.h>
+#include <linux/pci.h>
+#include <asm/gt64240.h>
+#include <asm/pmc_sequoia.h>
+
+
+extern struct pci_ops sequoia_pci_ops;
+
+static struct resource py_mem_resource0 = {
+	"Sequoia PCI MEM", SEQUOIA_PCI0_MEM_BASE, 
+	SEQUOIA_PCI0_MEM_BASE+SEQUOIA_PCI0_MEM_SIZE-1, IORESOURCE_MEM
+};
+
+static struct resource py_mem_resource1 = {
+        "Sequoia PCI MEM", SEQUOIA_PCI1_MEM_BASE,
+        SEQUOIA_PCI1_MEM_BASE+SEQUOIA_PCI1_MEM_SIZE-1, IORESOURCE_MEM
+};
+
+/*
+ * PMON really reserves 16MB of I/O port space but that's stupid, nothing
+ * needs that much since allocations are limited to 256 bytes per device
+ * anyway.  So we just claim 64kB here.
+ */
+#define SEQUOIA_IO_SIZE	0x0000ffffUL
+
+static struct resource py_io_resource0 = {
+        "Sequoia IO MEM", SEQUOIA_PCI0_IO_BASE, 
+	SEQUOIA_PCI0_IO_BASE + SEQUOIA_PCI0_IO_SIZE - 1, IORESOURCE_IO,
+};
+
+static struct resource py_io_resource1 = {
+        "Sequoia IO MEM", SEQUOIA_PCI1_IO_BASE,
+        SEQUOIA_PCI1_IO_BASE + SEQUOIA_PCI1_IO_SIZE - 1, IORESOURCE_IO,
+};
+
+static struct pci_controller py_controller0 = {
+	.pci_ops	= &sequoia_pci_ops,
+	.mem_resource	= &py_mem_resource0,
+	.mem_offset	= 0x00000000UL,
+	.io_resource	= &py_io_resource0,
+	.io_offset	= 0x00000000UL
+};
+
+static struct pci_controller py_controller1 = {
+        .pci_ops        = &sequoia_pci_ops,
+        .mem_resource   = &py_mem_resource1,
+        .mem_offset     = 0x00000000UL,
+        .io_resource    = &py_io_resource1,
+        .io_offset      = 0x00000000UL
+};
+
+static char ioremap_failed[] __initdata = "Could not ioremap I/O port range";
+
+static int __init pmc_sequoia_setup(void)
+{
+	unsigned long io_v_base;
+
+	set_io_port_base(0);
+
+	ioport_resource.end = SEQUOIA_PCI1_IO_BASE + SEQUOIA_PCI1_IO_SIZE - 1;
+
+	register_pci_controller(&py_controller0);
+	register_pci_controller(&py_controller1);
+
+	return 0;
+}
+
+arch_initcall(pmc_sequoia_setup);
+
