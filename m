Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 23 Oct 2007 21:56:44 +0100 (BST)
Received: from atlrel7.hp.com ([156.153.255.213]:45702 "EHLO atlrel7.hp.com")
	by ftp.linux-mips.org with ESMTP id S20031720AbXJWU4F (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 23 Oct 2007 21:56:05 +0100
Received: from smtp1.fc.hp.com (smtp.fc.hp.com [15.15.136.127])
	by atlrel7.hp.com (Postfix) with ESMTP id A863A34D93;
	Tue, 23 Oct 2007 16:55:18 -0400 (EDT)
Received: from ldl.fc.hp.com (ldl.fc.hp.com [15.11.146.30])
	by smtp1.fc.hp.com (Postfix) with ESMTP id 7908E1D0DA7;
	Tue, 23 Oct 2007 20:55:18 +0000 (UTC)
Received: from localhost (ldl.fc.hp.com [127.0.0.1])
	by ldl.fc.hp.com (Postfix) with ESMTP id 46FFA134006;
	Tue, 23 Oct 2007 14:55:18 -0600 (MDT)
X-Virus-Scanned: Debian amavisd-new at ldl.fc.hp.com
Received: from ldl.fc.hp.com ([127.0.0.1])
	by localhost (ldl.fc.hp.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Kc9pYB5mgWGW; Tue, 23 Oct 2007 14:55:16 -0600 (MDT)
Received: from localhost.localdomain (lart.fc.hp.com [15.11.146.31])
	by ldl.fc.hp.com (Postfix) with ESMTP id 00F0C134004;
	Tue, 23 Oct 2007 14:55:16 -0600 (MDT)
Received: by localhost.localdomain (Postfix, from userid 1000)
	id EF29613F7D5; Tue, 23 Oct 2007 14:55:15 -0600 (MDT)
Message-Id: <20071023205515.775882722@ldl.fc.hp.com>
References: <20071023204843.442608289@ldl.fc.hp.com>
User-Agent: quilt/0.45-1
Date:	Tue, 23 Oct 2007 14:48:45 -0600
From:	Bjorn Helgaas <bjorn.helgaas@hp.com>
To:	Alessandro Zummo <a.zummo@towertech.it>
Cc:	Andrew Morton <akpm@linux-foundation.org>
Cc:	linux-kernel@vger.kernel.org
Cc:	linux-mips@linux-mips.org
Subject: [patch 2/2] rtc: fallback to requesting only the ports we actually use
Content-Disposition: inline; filename=rtc-resource-size
Return-Path: <helgaas@ldl.fc.hp.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17192
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: bjorn.helgaas@hp.com
Precedence: bulk
X-list: linux-mips

Firmware like PNPBIOS or ACPI can report the address space consumed by the
RTC.  The actual space consumed may be less than the size (RTC_IO_EXTENT)
assumed by the RTC driver.

The PNP core doesn't request resources yet, but I'd like to make it do so.
If/when it does, the RTC_IO_EXTENT request may fail, which prevents the RTC
driver from loading.

Since we only use the RTC index and data registers at RTC_PORT(0) and
RTC_PORT(1), we can fall back to requesting just enough space for those.

If the PNP core requests resources, this results in typical I/O port usage
like this:

    0070-0073 : 00:06		<-- PNP device 00:06 responds to 70-73
      0070-0071 : rtc		<-- RTC driver uses only 70-71

instead of the current:

    0070-0077 : rtc		<-- RTC_IO_EXTENT == 8

Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>

Index: w/drivers/char/rtc.c
===================================================================
--- w.orig/drivers/char/rtc.c	2007-10-23 14:41:23.000000000 -0600
+++ w/drivers/char/rtc.c	2007-10-23 14:41:30.000000000 -0600
@@ -918,12 +918,29 @@
 };
 #endif
 
+static resource_size_t rtc_size;
+
+static struct resource * __init rtc_request_region(resource_size_t size)
+{
+	struct resource *r;
+
+	if (RTC_IOMAPPED)
+		r = request_region(RTC_PORT(0), size, "rtc");
+	else
+		r = request_mem_region(RTC_PORT(0), size, "rtc");
+
+	if (r)
+		rtc_size = size;
+
+	return r;
+}
+
 static void rtc_release_region(void)
 {
 	if (RTC_IOMAPPED)
-		release_region(RTC_PORT(0), RTC_IO_EXTENT);
+		release_region(RTC_PORT(0), rtc_size);
 	else
-		release_mem_region(RTC_PORT(0), RTC_IO_EXTENT);
+		release_mem_region(RTC_PORT(0), rtc_size);
 }
 
 static int __init rtc_init(void)
@@ -976,10 +993,17 @@
 	}
 no_irq:
 #else
-	if (RTC_IOMAPPED)
-		r = request_region(RTC_PORT(0), RTC_IO_EXTENT, "rtc");
-	else
-		r = request_mem_region(RTC_PORT(0), RTC_IO_EXTENT, "rtc");
+	r = rtc_request_region(RTC_IO_EXTENT);
+
+	/*
+	 * If we've already requested a smaller range (for example, because
+	 * PNPBIOS or ACPI told us how the device is configured), the request
+	 * above might fail because it's too big.
+	 *
+	 * If so, request just the range we actually use.
+	 */
+	if (!r)
+		r = rtc_request_region(RTC_IO_EXTENT_USED);
 	if (!r) {
 #ifdef RTC_IRQ
 		rtc_has_irq = 0;
Index: w/include/linux/mc146818rtc.h
===================================================================
--- w.orig/include/linux/mc146818rtc.h	2007-10-23 14:41:23.000000000 -0600
+++ w/include/linux/mc146818rtc.h	2007-10-23 14:41:30.000000000 -0600
@@ -109,8 +109,11 @@
 #ifndef ARCH_RTC_LOCATION	/* Override by <asm/mc146818rtc.h>? */
 
 #define RTC_IO_EXTENT	0x8
+#define RTC_IO_EXTENT_USED	0x2
 #define RTC_IOMAPPED	1	/* Default to I/O mapping. */
 
+#else
+#define RTC_IO_EXTENT_USED      RTC_IO_EXTENT
 #endif /* ARCH_RTC_LOCATION */
 
 #endif /* _MC146818RTC_H */

--
