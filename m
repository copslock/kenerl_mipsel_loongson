Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 21 Oct 2004 01:18:32 +0100 (BST)
Received: from gateway-1237.mvista.com ([IPv6:::ffff:12.44.186.158]:57849 "EHLO
	hermes.mvista.com") by linux-mips.org with ESMTP
	id <S8225240AbUJUAS1>; Thu, 21 Oct 2004 01:18:27 +0100
Received: from prometheus.mvista.com (prometheus.mvista.com [10.0.0.139])
	by hermes.mvista.com (Postfix) with ESMTP
	id 3B50618363; Wed, 20 Oct 2004 17:18:26 -0700 (PDT)
Subject: [PATCH]Check for Hypertransport Link Initialization on PMC-Sierra
	Titan before configuring the interface
From: Manish Lachwani <mlachwani@mvista.com>
To: linux-mips@linux-mips.org
Cc: ralf@linux-mips.org
Content-Type: text/plain
Organization: 
Message-Id: <1098317905.4266.18.camel@prometheus.mvista.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 20 Oct 2004 17:18:26 -0700
Content-Transfer-Encoding: 7bit
Return-Path: <mlachwani@mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6148
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mlachwani@mvista.com
Precedence: bulk
X-list: linux-mips

Hello Ralf

Attached patch checks for the Hypertransport Link Initialization before
configuring the interface. Assuming PMON did try to do link
initialization and there were no errors (like CRC etc.), the Link
register will indicate it.

Thanks
Manish Lachwani

--- arch/mips/pmc-sierra/yosemite/setup.c.orig	2004-10-20
16:51:24.000000000 -0700
+++ arch/mips/pmc-sierra/yosemite/setup.c	2004-10-20 16:58:56.000000000
-0700
@@ -191,6 +191,8 @@
 static int __init pmc_yosemite_setup(void)
 {
 	extern void pmon_smp_bootstrap(void);
+	/* Hypertransport Link initialization register */
+	unsigned long val = OCD_READ(RM9000x2_OCD_HTLINK);
 
 	board_time_init = yosemite_time_init;
 	late_time_init = py_map_ocd;
@@ -198,14 +200,21 @@
 	/* Add memory regions */
 	add_memory_region(0x00000000, 0x10000000, BOOT_MEM_RAM);
 
-#if 0 /* XXX Crash ...  */
-	OCD_WRITE(RM9000x2_OCD_HTSC,
-	          OCD_READ(RM9000x2_OCD_HTSC) | HYPERTRANSPORT_ENABLE);
-
-	/* Set the BAR. Shifted mode */
-	OCD_WRITE(RM9000x2_OCD_HTBAR0, HYPERTRANSPORT_BAR0_ADDR);
-	OCD_WRITE(RM9000x2_OCD_HTMASK0, HYPERTRANSPORT_SIZE0);
-#endif
+	if (val & 0x00000020) {
+		/*
+		 * If Hypertransport is enabled and no device is connected on
+		 * the Hypertranport interface, dont scan the interface.
+		 * Check the Link initialization register first. If the Link
+		 * is enabled, then initialize and scan the HT interface
+		 */
+		OCD_WRITE(RM9000x2_OCD_HTSC,
+		          OCD_READ(RM9000x2_OCD_HTSC) | HYPERTRANSPORT_ENABLE);
+
+		/* Set the BAR. Shifted mode */
+		OCD_WRITE(RM9000x2_OCD_HTBAR0, HYPERTRANSPORT_BAR0_ADDR);
+		OCD_WRITE(RM9000x2_OCD_HTMASK0, HYPERTRANSPORT_SIZE0);
+		OCD_WRITE(RM9000x2_OCD_HTBAA30, 0x01); /* Supports byte swap */
+	}
 
 	return 0;
 }
