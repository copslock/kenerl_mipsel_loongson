Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 10 Aug 2009 21:43:37 +0200 (CEST)
Received: from mail-ew0-f216.google.com ([209.85.219.216]:35323 "EHLO
	mail-ew0-f216.google.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1493419AbZHJTnK (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 10 Aug 2009 21:43:10 +0200
Received: by ewy12 with SMTP id 12so3914060ewy.0
        for <multiple recipients>; Mon, 10 Aug 2009 12:43:04 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:from:date:subject
         :mime-version:x-uid:x-length:to:cc:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=oF1JAQpfebkPA64dkIQLJv08KEWCf5X9c8/bQKnm5cU=;
        b=WZmjFdHI0b73CeWTXRDezCnkqGw/nkWxHGjrIOn0ZtyzBaiAD6tGVYQArrCpCuhqqh
         8gqigAULY1JNgy/bAIwTNSb/tnzypwljWk3cbZQbGt+oDiISa4l7A8zl18edVtGi1ks3
         dP9mBgrMlbOXeFtu3BP8Qz1b/4soN6uSK2I3Y=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:from:date:subject:mime-version:x-uid:x-length:to:cc
         :content-type:content-transfer-encoding:content-disposition
         :message-id;
        b=Aua4sWE4koTInpiaGF5S57nt9wl8bH+KukrBP1SEyIDP3dGER4lbG7Mo/sPBdJ9SrN
         36ueATLAEn9XPtY/RMcRdVQAqO8gOyE2KGp8owBidnhAEOUJI0nMkRsfJjZ5wgjRqZrl
         bXaBAm6LDi/QvOaxqUw1M+861IvrK8gl9RcjU=
Received: by 10.210.87.11 with SMTP id k11mr2873605ebb.68.1249933384670;
        Mon, 10 Aug 2009 12:43:04 -0700 (PDT)
Received: from lenovo.mimichou.home (florian.mimichou.net [82.241.112.26])
        by mx.google.com with ESMTPS id 7sm163185eyg.5.2009.08.10.12.43.02
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 10 Aug 2009 12:43:03 -0700 (PDT)
From:	Florian Fainelli <florian@openwrt.org>
Date:	Mon, 10 Aug 2009 21:42:59 +0200
Subject: [PATCH 2/2] bcm63xx: prepare for watchdog support
MIME-Version: 1.0
X-UID:	1207
X-Length: 2676
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	linux-mips@linux-mips.org, Maxime Bizon <mbizon@freebox.fr>
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200908102143.01124.florian@openwrt.org>
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23885
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: florian@openwrt.org
Precedence: bulk
X-list: linux-mips

This patch prepares the board code to register
a bcm63xx_wdt platform_device that we are going to
use in a subsequent patch.

Signed-off-by: Florian Fainelli <florian@openwrt.org>
---
diff --git a/arch/mips/bcm63xx/Makefile b/arch/mips/bcm63xx/Makefile
index 70ba038..a4abc11 100644
--- a/arch/mips/bcm63xx/Makefile
+++ b/arch/mips/bcm63xx/Makefile
@@ -5,6 +5,7 @@ obj-y		+= dev-usb-ohci.o
 obj-y		+= dev-usb-ehci.o
 obj-y		+= dev-enet.o
 obj-y		+= dev-dsp.o
+obj-y		+= dev-wdt.o
 obj-$(CONFIG_EARLY_PRINTK)	+= early_printk.o
 
 obj-y		+= boards/
diff --git a/arch/mips/bcm63xx/dev-wdt.c b/arch/mips/bcm63xx/dev-wdt.c
new file mode 100644
index 0000000..045bae0
--- /dev/null
+++ b/arch/mips/bcm63xx/dev-wdt.c
@@ -0,0 +1,37 @@
+/*
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ *
+ * Copyright (C) 2008 Florian Fainelli <florian@openwrt.org> 
+ */
+
+#include <linux/init.h>
+#include <linux/kernel.h>
+#include <linux/platform_device.h>
+#include <bcm63xx_cpu.h>
+
+static struct resource wdt_resources[] = {
+	{
+		.start		= -1, /* filled at runtime */
+		.end		= -1, /* filled at runtime */
+		.flags		= IORESOURCE_MEM,
+	},
+};
+
+static struct platform_device bcm63xx_wdt_device = {
+	.name		= "bcm63xx-wdt",
+	.id		= 0,
+	.num_resources	= ARRAY_SIZE(wdt_resources),
+	.resource	= wdt_resources,
+};
+
+int __init bcm63xx_wdt_register(void)
+{
+	wdt_resources[0].start = bcm63xx_regset_address(RSET_WDT);
+	wdt_resources[0].end = wdt_resources[0].start;
+	wdt_resources[0].end += RSET_WDT_SIZE - 1;
+
+	return platform_device_register(&bcm63xx_wdt_device);
+}
+arch_initcall(bcm63xx_wdt_register);
