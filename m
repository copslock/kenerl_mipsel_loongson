Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 13 Mar 2003 20:04:50 +0000 (GMT)
Received: from pasmtp.tele.dk ([IPv6:::ffff:193.162.159.95]:28165 "EHLO
	pasmtp.tele.dk") by linux-mips.org with ESMTP id <S8225223AbTCMUEu>;
	Thu, 13 Mar 2003 20:04:50 +0000
Received: from ekner.info (0x83a4a968.virnxx10.adsl-dhcp.tele.dk [131.164.169.104])
	by pasmtp.tele.dk (Postfix) with ESMTP id B6370B6A9
	for <linux-mips@linux-mips.org>; Thu, 13 Mar 2003 21:04:46 +0100 (CET)
Message-ID: <3E70E52E.B6FF1C2A@ekner.info>
Date: Thu, 13 Mar 2003 21:08:15 +0100
From: Hartvig Ekner <hartvig@ekner.info>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.18-19.7.x i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linux MIPS mailing list <linux-mips@linux-mips.org>
Subject: Patches for Au1000: PCI int problem, DB1500 board reset & ethernet
Content-Type: multipart/mixed;
 boundary="------------28C30766B1EB581C0E18AA6B"
Return-Path: <hartvig@ekner.info>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1738
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: hartvig@ekner.info
Precedence: bulk
X-list: linux-mips

This is a multi-part message in MIME format.
--------------28C30766B1EB581C0E18AA6B
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Hi,

The first patch below fixes interrupt setup for DB1500. The PCI interrupts were polarized wrongly, causing a deadlock when used.
The second patch adds board reset using HW register for DB1500.
The third patch reverses interrupt handling order for RX & TX to minimize packet loss in high-load situations.

/Hartvig



--------------28C30766B1EB581C0E18AA6B
Content-Type: text/plain; charset=us-ascii;
 name="IRQ_patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="IRQ_patch"

Index: irq.c
===================================================================
RCS file: /home/cvs/linux/arch/mips/au1000/common/irq.c,v
retrieving revision 1.11.2.14
diff -u -r1.11.2.14 irq.c
--- irq.c	26 Feb 2003 21:14:24 -0000	1.11.2.14
+++ irq.c	13 Mar 2003 19:45:57 -0000
@@ -430,14 +430,10 @@
 			case AU1000_IRDA_RX_INT:
 
 			case AU1000_MAC0_DMA_INT:
-#if defined(CONFIG_MIPS_PB1000) || defined(CONFIG_MIPS_DB1000) || defined(CONFIG_MIPS_DB1500)
-			case AU1000_MAC1_DMA_INT:
-#endif
-#ifdef CONFIG_MIPS_PB1500
+#if defined(CONFIG_MIPS_PB1000) || defined(CONFIG_MIPS_DB1000) || defined(CONFIG_MIPS_PB1500) || defined(CONFIG_MIPS_DB1500)
 			case AU1000_MAC1_DMA_INT:
 #endif
 			case AU1500_GPIO_204:
-
 				setup_local_irq(i, INTC_INT_HIGH_LEVEL, 0);
 				irq_desc[i].handler = &level_irq_type;
 				break;
@@ -446,7 +442,7 @@
 			case AU1000_GPIO_15:
 #endif
 		        case AU1000_USB_HOST_INT:
-#ifdef CONFIG_MIPS_PB1500
+#if defined(CONFIG_MIPS_PB1500) || defined(CONFIG_MIPS_DB1500)
 			case AU1000_PCI_INTA:
 			case AU1000_PCI_INTB:
 			case AU1000_PCI_INTC:
@@ -488,9 +484,9 @@
 			case AU1000_RTC_MATCH0_INT:
 			case AU1000_RTC_MATCH1_INT:
 			case AU1000_RTC_MATCH2_INT:
-			        setup_local_irq(i, INTC_INT_RISE_EDGE, 0);
-                                irq_desc[i].handler = &rise_edge_irq_type;
-                                break;
+				setup_local_irq(i, INTC_INT_RISE_EDGE, 0);
+				irq_desc[i].handler = &rise_edge_irq_type;
+				break;
 
 				 // Careful if you change match 2 request!
 				 // The interrupt handler is called directly

--------------28C30766B1EB581C0E18AA6B
Content-Type: text/plain; charset=us-ascii;
 name="RESET_patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="RESET_patch"

Index: reset.c
===================================================================
RCS file: /home/cvs/linux/arch/mips/au1000/common/reset.c,v
retrieving revision 1.2.2.8
diff -u -r1.2.2.8 reset.c
--- reset.c	11 Dec 2002 06:12:29 -0000	1.2.2.8
+++ reset.c	13 Mar 2003 19:46:03 -0000
@@ -111,15 +111,13 @@
 	set_c0_config(CONF_CM_UNCACHED);
 	flush_cache_all();
 	write_c0_wired(0);
- 
-#ifdef CONFIG_MIPS_PB1500
-	au_writel(0x00000000, 0xAE00001C);
-#endif
 
-#ifdef CONFIG_MIPS_PB1100
+#if defined(CONFIG_MIPS_PB1500) || defined(CONFIG_MIPS_PB1100) || defined(CONFIG_MIPS_DB1500)
+	/* Do a HW reset if the board can do it */
+
 	au_writel(0x00000000, 0xAE00001C);
 #endif
- 
+
 	__asm__ __volatile__("jr\t%0"::"r"(0xbfc00000));
 }
 

--------------28C30766B1EB581C0E18AA6B
Content-Type: text/plain; charset=us-ascii;
 name="ETH_patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="ETH_patch"

Index: au1000_eth.c
===================================================================
RCS file: /home/cvs/linux/drivers/net/au1000_eth.c,v
retrieving revision 1.5.2.15
diff -u -r1.5.2.15 au1000_eth.c
--- au1000_eth.c	3 Mar 2003 06:40:30 -0000	1.5.2.15
+++ au1000_eth.c	13 Mar 2003 20:01:51 -0000
@@ -1414,8 +1414,11 @@
 		printk(KERN_ERR "%s: isr: null dev ptr\n", dev->name);
 		return;
 	}
-	au1000_tx_ack(dev);
+
+	/* Handle RX interrupts first to minimize chance of overrun */
+
 	au1000_rx(dev);
+	au1000_tx_ack(dev);
 }
 
 

--------------28C30766B1EB581C0E18AA6B--
