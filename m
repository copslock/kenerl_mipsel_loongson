Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 06 Jun 2003 19:01:11 +0100 (BST)
Received: from www.clearcore.com ([IPv6:::ffff:69.20.152.109]:62108 "HELO
	clearcore.com") by linux-mips.org with SMTP id <S8225352AbTFFSBH>;
	Fri, 6 Jun 2003 19:01:07 +0100
Received: (qmail 17900 invoked by uid 501); 6 Jun 2003 18:01:02 -0000
Date: 6 Jun 2003 18:01:02 -0000
Message-ID: <20030606180102.17899.qmail@clearcore.com>
From: Joe George <joeg@clearcore.com>
To: ppopov@mvista.com
CC: linux-mips@linux-mips.org, ralf@linux-mips.org
Subject: [RFC] Au1x00 Ethernet driver
Reply-to: joeg@clearcore.com
Return-Path: <joeg@clearcore.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2554
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: joeg@clearcore.com
Precedence: bulk
X-list: linux-mips


The Au1x00 SOCs allow the highest number ethernet interface
to be disabled and some of the signals to be used as GPIOs.

The patch below detects if the interface is enabled and
ignores it if it is disabled.  It is part of what I need.

Our boards do not contain the phy for either ethernet
channel and may be used with 0, 1, or 2 ethernet interfaces.
The phys are on separate boards.

If I do not install a phy on an interface I get an oops, so
it doesn't look like everything that was setup in anticipation
of finding the phy gets taken back down correctly.


<4>eth0: Au1xxx ethernet found at 0xb0500000, irq 28
<3>eth0: No MII transceivers found!
<3>eth0: au1000_probe1 failed.  Returns 0
<4>eth0: Au1xxx ethernet found at 0xb0510000, irq 29
<6>eth0: Broadcom BCM5221 10/100 BaseT PHY at phy address 0
<6>eth0: Using Broadcom BCM5221 10/100 BaseT PHY as default
.
.
.
<1>Unable to handle kernel paging request at virtual address 00000002, epc == 8024e140, ra == 8024ea34
<4>Oops in fault.c::do_page_fault, line 206:
.
.
.

I would like to use the same kernel for all cases and use phy
detection to configure the interfaces.  So I'm really asking if
phy detection is acceptable for inclusion in the kernel?  If so,
I'll try to come up with acceptable patches.

More generally, I'm wondering whether using autodetection for
configuration is desirable as there are a number of other areas
where I'd like to see it used.

Joe


--- linux-mips-cvs24/drivers/net/au1000_eth.c	Mon Jun  2 21:35:28 2003
+++ tst_mips24/drivers/net/au1000_eth.c	Wed Jun  4 17:51:46 2003
@@ -54,6 +54,7 @@
 #include <asm/io.h>
 
 #include <asm/au1000.h>
+#include <asm/cpu.h>
 #include "au1000_eth.h"
 
 #ifdef AU1000_ETH_DEBUG
@@ -109,27 +110,6 @@ extern char * __init prom_getcmdline(voi
  */
 
 
-/*
- * Base address and interupt of the Au1xxx ethernet macs
- */
-static struct au1if {
-	unsigned int port;
-	int irq;
-} au1x00_iflist[] = {
-#if defined(CONFIG_SOC_AU1000)
-		{AU1000_ETH0_BASE, AU1000_ETH0_IRQ}, 
-		{AU1000_ETH1_BASE, AU1000_ETH1_IRQ}
-#elif defined(CONFIG_SOC_AU1500)
-		{AU1500_ETH0_BASE, AU1000_ETH0_IRQ}, 
-		{AU1500_ETH1_BASE, AU1000_ETH1_IRQ}
-#elif defined(CONFIG_SOC_AU1100)
-		{AU1000_ETH0_BASE, AU1000_ETH0_IRQ}, 
-#else
-#error "Unsupported Au1x00 CPU"
-#endif
-	};
-#define NUM_INTERFACES (sizeof(au1x00_iflist) / sizeof(struct au1if))
-
 static char version[] __devinitdata =
     "au1000eth.c:1.1 ppopov@mvista.com\n";
 
@@ -1003,17 +983,40 @@ setup_hw_rings(struct au1000_private *au
 	}
 }
 
+/*
+ * Setup the base address and interupt of the Au1xxx ethernet macs
+ * based on cpu type and whether the interface is enabled in sys_pinfunc
+ * register. The last interface is enabled if SYS_PF_NI2 (bit 4) is 0.
+ */
 static int __init au1000_init_module(void)
 {
-	int i;
-	int base_addr, irq;
-
-	for (i=0; i<NUM_INTERFACES; i++) {
-		base_addr = au1x00_iflist[i].port;
-		irq = au1x00_iflist[i].irq;
-		if (au1000_probe1(NULL, base_addr, irq, i) != 0) {
+	struct cpuinfo_mips *c = &current_cpu_data;
+	int base_addr[2], irq[2], num_ifs, i;
+	int ni = (int)((au_readl(SYS_PINFUNC) & (u32)(SYS_PF_NI2)) >> 4);
+
+	irq[0] = AU1000_ETH0_IRQ;
+	irq[1] = AU1000_ETH1_IRQ;
+	switch (c->cputype) {
+	case CPU_AU1000:
+		num_ifs = 2 - ni;
+		base_addr[0] = AU1000_ETH0_BASE;
+		base_addr[1] = AU1000_ETH1_BASE;
+		break;
+	case CPU_AU1100:
+		num_ifs = 1 - ni;
+		base_addr[0] = AU1000_ETH0_BASE;
+		break;
+	case CPU_AU1500:
+		num_ifs = 2 - ni;
+		base_addr[0] = AU1500_ETH0_BASE;
+		base_addr[1] = AU1500_ETH1_BASE;
+		break;
+	default:
+		num_ifs = 0;
+	}
+	for(i = 0; i < num_ifs; i++) {
+		if (au1000_probe1(NULL, base_addr[i], irq[i], i) != 0)
 			return -ENODEV;
-		}
 	}
 	return 0;
 }
