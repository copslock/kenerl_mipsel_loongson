Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 24 Nov 2004 18:22:09 +0000 (GMT)
Received: from gateway-1237.mvista.com ([IPv6:::ffff:12.44.186.158]:3318 "EHLO
	prometheus.mvista.com") by linux-mips.org with ESMTP
	id <S8225005AbUKXSWE>; Wed, 24 Nov 2004 18:22:04 +0000
Received: from prometheus.mvista.com (localhost.localdomain [127.0.0.1])
	by prometheus.mvista.com (8.12.8/8.12.8) with ESMTP id iAOIM2dh015926;
	Wed, 24 Nov 2004 10:22:02 -0800
Received: (from mlachwani@localhost)
	by prometheus.mvista.com (8.12.8/8.12.8/Submit) id iAOIM259015924;
	Wed, 24 Nov 2004 10:22:02 -0800
Date: Wed, 24 Nov 2004 10:22:02 -0800
From: Manish Lachwani <mlachwani@prometheus.mvista.com>
To: linux-mips@linux-mips.org
Cc: ralf@linux-mips.org
Subject: [PATCH] Minor fixups for Ocelot-3 board
Message-ID: <20041124182202.GA15917@prometheus.mvista.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="1yeeQ81UyVL57Vl7"
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Return-Path: <mlachwani@prometheus.mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6438
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mlachwani@prometheus.mvista.com
Precedence: bulk
X-list: linux-mips


--1yeeQ81UyVL57Vl7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Ralf,

Attached patch fixes minor issues with the Momentum Ocelot-3
code. Please review ...

Thanks
Manish Lachwani


--1yeeQ81UyVL57Vl7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="common_mips_ocelot3_minor.patch"

Index: linux/arch/mips/momentum/ocelot_3/prom.c
===================================================================
--- linux.orig/arch/mips/momentum/ocelot_3/prom.c
+++ linux/arch/mips/momentum/ocelot_3/prom.c
@@ -28,7 +28,6 @@
 
 #include <asm/addrspace.h>
 #include <asm/bootinfo.h>
-#include <asm/mv64340.h>
 #include <asm/pmon.h>
 #include "ocelot_3_fpga.h"
 
@@ -36,7 +35,7 @@
 extern unsigned long marvell_base;
 extern unsigned long cpu_clock;
 
-#ifdef CONFIG_MV64340_ETH
+#ifdef CONFIG_MV643XX_ETH
 extern unsigned char prom_mac_addr_base[6];
 #endif
 
@@ -45,7 +44,7 @@
 	return "Momentum Ocelot-3";
 }
 
-#ifdef CONFIG_MV64340_ETH
+#ifdef CONFIG_MV643XX_ETH
 void burn_clocks(void)
 {
 	int i;
@@ -230,7 +229,7 @@
 	mips_machgroup = MACH_GROUP_MOMENCO;
 	mips_machtype = MACH_MOMENCO_OCELOT_3;
 
-#ifdef CONFIG_MV64340_ETH
+#ifdef CONFIG_MV643XX_ETH
 	/* get the base MAC address for on-board ethernet ports */
 	get_mac(prom_mac_addr_base);
 #endif
Index: linux/arch/mips/kernel/irq-mv6434x.c
===================================================================
--- linux.orig/arch/mips/kernel/irq-mv6434x.c
+++ linux/arch/mips/kernel/irq-mv6434x.c
@@ -16,7 +16,7 @@
 #include <linux/kernel_stat.h>
 #include <asm/io.h>
 #include <asm/irq.h>
-#include <asm/mv64340.h>
+#include <linux/mv643xx.h>
 
 static unsigned int irq_base;
 
Index: linux/arch/mips/pci/fixup-ocelot3.c
===================================================================
--- linux.orig/arch/mips/pci/fixup-ocelot3.c
+++ linux/arch/mips/pci/fixup-ocelot3.c
@@ -14,6 +14,15 @@
 #include <linux/pci.h>
 #include <asm/mipsregs.h>
 
+/* 
+ * Do platform specific device initialization at 
+ * pci_enable_device() time 
+ */
+int pcibios_plat_dev_init(struct pci_dev *dev)
+{
+	return 0;
+}
+
 int __init pcibios_map_irq(struct pci_dev *dev, u8 slot, u8 pin)
 {
 	int bus = dev->bus->number;

--1yeeQ81UyVL57Vl7--
