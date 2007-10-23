Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 23 Oct 2007 21:57:14 +0100 (BST)
Received: from atlrel9.hp.com ([156.153.255.214]:25052 "EHLO atlrel9.hp.com")
	by ftp.linux-mips.org with ESMTP id S20031722AbXJWU4M (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 23 Oct 2007 21:56:12 +0100
Received: from smtp1.fc.hp.com (smtp.cnd.hp.com [15.15.136.127])
	by atlrel9.hp.com (Postfix) with ESMTP id 021EA34B12;
	Tue, 23 Oct 2007 16:55:19 -0400 (EDT)
Received: from ldl.fc.hp.com (ldl.fc.hp.com [15.11.146.30])
	by smtp1.fc.hp.com (Postfix) with ESMTP id A00901D0DA8;
	Tue, 23 Oct 2007 20:55:19 +0000 (UTC)
Received: from localhost (ldl.fc.hp.com [127.0.0.1])
	by ldl.fc.hp.com (Postfix) with ESMTP id 6CA84134006;
	Tue, 23 Oct 2007 14:55:19 -0600 (MDT)
X-Virus-Scanned: Debian amavisd-new at ldl.fc.hp.com
Received: from ldl.fc.hp.com ([127.0.0.1])
	by localhost (ldl.fc.hp.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id vAJYh0tXgHuy; Tue, 23 Oct 2007 14:55:15 -0600 (MDT)
Received: from localhost.localdomain (lart.fc.hp.com [15.11.146.31])
	by ldl.fc.hp.com (Postfix) with ESMTP id BB402134003;
	Tue, 23 Oct 2007 14:55:15 -0600 (MDT)
Received: by localhost.localdomain (Postfix, from userid 1000)
	id B51C413F7D6; Tue, 23 Oct 2007 14:55:15 -0600 (MDT)
Message-Id: <20071023205515.406778977@ldl.fc.hp.com>
References: <20071023204843.442608289@ldl.fc.hp.com>
User-Agent: quilt/0.45-1
Date:	Tue, 23 Oct 2007 14:48:44 -0600
From:	Bjorn Helgaas <bjorn.helgaas@hp.com>
To:	Alessandro Zummo <a.zummo@towertech.it>
Cc:	Andrew Morton <akpm@linux-foundation.org>
Cc:	linux-kernel@vger.kernel.org
Cc:	linux-mips@linux-mips.org
Subject: [patch 1/2] rtc: release correct region in error path
Content-Disposition: inline; filename=rtc-factor
Return-Path: <helgaas@ldl.fc.hp.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17193
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: bjorn.helgaas@hp.com
Precedence: bulk
X-list: linux-mips

The misc_register() error path always released an I/O port region,
even if the region was memory-mapped (only mips uses memory-mapped RTC,
as far as I can see).

Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>

Index: w/drivers/char/rtc.c
===================================================================
--- w.orig/drivers/char/rtc.c	2007-10-23 09:59:33.000000000 -0600
+++ w/drivers/char/rtc.c	2007-10-23 14:41:23.000000000 -0600
@@ -918,6 +918,14 @@
 };
 #endif
 
+static void rtc_release_region(void)
+{
+	if (RTC_IOMAPPED)
+		release_region(RTC_PORT(0), RTC_IO_EXTENT);
+	else
+		release_mem_region(RTC_PORT(0), RTC_IO_EXTENT);
+}
+
 static int __init rtc_init(void)
 {
 #ifdef CONFIG_PROC_FS
@@ -992,10 +1000,7 @@
 		/* Yeah right, seeing as irq 8 doesn't even hit the bus. */
 		rtc_has_irq = 0;
 		printk(KERN_ERR "rtc: IRQ %d is not free.\n", RTC_IRQ);
-		if (RTC_IOMAPPED)
-			release_region(RTC_PORT(0), RTC_IO_EXTENT);
-		else
-			release_mem_region(RTC_PORT(0), RTC_IO_EXTENT);
+		rtc_release_region();
 		return -EIO;
 	}
 	hpet_rtc_timer_init();
@@ -1009,7 +1014,7 @@
 		free_irq(RTC_IRQ, NULL);
 		rtc_has_irq = 0;
 #endif
-		release_region(RTC_PORT(0), RTC_IO_EXTENT);
+		rtc_release_region();
 		return -ENODEV;
 	}
 
@@ -1091,10 +1096,7 @@
 	if (rtc_has_irq)
 		free_irq (rtc_irq, &rtc_port);
 #else
-	if (RTC_IOMAPPED)
-		release_region(RTC_PORT(0), RTC_IO_EXTENT);
-	else
-		release_mem_region(RTC_PORT(0), RTC_IO_EXTENT);
+	rtc_release_region();
 #ifdef RTC_IRQ
 	if (rtc_has_irq)
 		free_irq (RTC_IRQ, NULL);

--
