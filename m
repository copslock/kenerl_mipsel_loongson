Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 15 May 2009 23:06:15 +0100 (BST)
Received: from wf-out-1314.google.com ([209.85.200.172]:6659 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org
	with ESMTP id S20023334AbZEOWGJ (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 15 May 2009 23:06:09 +0100
Received: by wf-out-1314.google.com with SMTP id 28so1224650wfa.21
        for <multiple recipients>; Fri, 15 May 2009 15:06:06 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:subject:from:reply-to:to:cc
         :content-type:organization:date:message-id:mime-version:x-mailer
         :content-transfer-encoding;
        bh=S+52GHd0HjCIa5LlVy+tyUWfN+UhMYcHdqA/pQJjDts=;
        b=YSO8e6t4aV5EFFPQD1in6ahq41yHO4burA/myUCa50k5OEIibzU9jaH4XPggU7OYmM
         qWD7uR4I0VNZwpL8A9wfm3+A3ynVKMoCt0UvHYKUz8BDlmM7RN8vFOXcfqez/U5RjEfa
         YSet01icDw/Oh9BV3HNMNvul5w6Oua8LKsfMI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:from:reply-to:to:cc:content-type:organization:date
         :message-id:mime-version:x-mailer:content-transfer-encoding;
        b=huHS9OLtcw5m7alaRUdMNkY+5FESnmcHNACd51oAwRITw8rGMTPA0AC+m6782uzqMW
         hcuN26Iz29w4gExwiBra2V+xNVNxSK8Yp2PpmOfrxOw7MVEdBoCg/FVvGXKZ21fldmgq
         JqxWY2RnwxYd7Zx6Adeg+6ABmsVvT6wKquHnE=
Received: by 10.142.114.15 with SMTP id m15mr1192932wfc.58.1242425166871;
        Fri, 15 May 2009 15:06:06 -0700 (PDT)
Received: from ?172.16.2.101? ([222.92.8.142])
        by mx.google.com with ESMTPS id 20sm3532986wfi.20.2009.05.15.15.06.03
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 15 May 2009 15:06:06 -0700 (PDT)
Subject: [PATCH 09/30] loongson: enable Real Time Clock Support
From:	Wu Zhangjin <wuzhangjin@gmail.com>
Reply-To: wuzhangjin@gmail.com
To:	linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>
Cc:	Arnaud Patard <apatard@mandriva.com>,
	loongson-dev@googlegroups.com, zhangfx@lemote.com, yanh@lemote.com,
	Philippe Vachon <philippe@cowpig.ca>,
	Zhang Le <r0bertz@gentoo.org>, Erwan Lerale <erwan@thiscow.com>
Content-Type: text/plain
Organization: DSLab, Lanzhou University, China
Date:	Sat, 16 May 2009 06:06:00 +0800
Message-Id: <1242425160.10164.150.camel@falcon>
Mime-Version: 1.0
X-Mailer: Evolution 2.24.3 
Content-Transfer-Encoding: 7bit
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22746
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips

>From 1a13dd55ecc7d3d886cbf39e43acdd0585ca5285 Mon Sep 17 00:00:00 2001
From: Wu Zhangjin <wuzhangjin@gmail.com>
Date: Sat, 16 May 2009 00:51:39 +0800
Subject: [PATCH 09/30] loongson: enable Real Time Clock Support of
fuloong(2e)

by default, RTC_LIB is selected by MIPS, but if RTC_LIB is enabled,
Enhanced Real Time Clock Support(RTC) will be disabled, so, to enable
it, not select RTC_LIB in LEMOTE_FULOONG2E will fix this problem.

RTC support is needed by some tools like hwclock, if you want hwclock
work well, these two jobs need to do:

kernel configuration:

Device Drivers --->
Character devices --->
<*> Enhanced Real Time Clock Support (legacy PC RTC driver)

user-space configuration:

$ mknod /dev/rtc c 10 135

there is another RTC support in linux, whose kernel option is RTC_CLASS,
it should be fixed for fuloong(2e) via enabling the binary mode and
register the RTC device resource.

to make hwclock work with it normally, please do:

kernel configuration:

Device Drivers --->
<*> Real Time Clock --->
	<*>   PC-style 'CMOS'

user-space configuration:

$ mknod /dev/rtc0 c 254 0

/dev/rtc0 is the default RTC device file.
---
 arch/mips/Kconfig                      |    2 +-
 arch/mips/loongson/fuloong-2e/Makefile |    7 ++++
 arch/mips/loongson/fuloong-2e/rtc.c    |   54
++++++++++++++++++++++++++++++++
 drivers/rtc/rtc-cmos.c                 |    2 +-
 4 files changed, 63 insertions(+), 2 deletions(-)
 create mode 100644 arch/mips/loongson/fuloong-2e/rtc.c

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index d9ecb44..974ce41 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -6,7 +6,7 @@ config MIPS
 	select HAVE_ARCH_KGDB
 	# Horrible source of confusion.  Die, die, die ...
 	select EMBEDDED
-	select RTC_LIB
+	select RTC_LIB if !LEMOTE_FULOONG2E
 
 mainmenu "Linux/MIPS Kernel Configuration"
 
diff --git a/arch/mips/loongson/fuloong-2e/Makefile
b/arch/mips/loongson/fuloong-2e/Makefile
index 88002a6..2ab49cb 100644
--- a/arch/mips/loongson/fuloong-2e/Makefile
+++ b/arch/mips/loongson/fuloong-2e/Makefile
@@ -10,4 +10,11 @@ obj-y += setup.o init.o cmdline.o time.o reset.o
irq.o \
 #
 obj-$(CONFIG_EARLY_PRINTK) += early_printk.o
 
+#
+# Enable RTC Class support
+#
+# please enable CONFIG_RTC_DRV_CMOS
+#
+obj-$(CONFIG_RTC_DRV_CMOS) += rtc.o
+
 EXTRA_CFLAGS += -Werror
diff --git a/arch/mips/loongson/fuloong-2e/rtc.c
b/arch/mips/loongson/fuloong-2e/rtc.c
new file mode 100644
index 0000000..c2f413f
--- /dev/null
+++ b/arch/mips/loongson/fuloong-2e/rtc.c
@@ -0,0 +1,54 @@
+/*
+ *  Registration of Cobalt RTC platform device.
+ *
+ *  Copyright (C) 2007  Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
+ *  Copyright (C) 2009  Wu Zhangjin <wuzj@lemote.com>
+ *
+ *  This program is free software; you can redistribute it and/or
modify
+ *  it under the terms of the GNU General Public License as published
by
+ *  the Free Software Foundation; either version 2 of the License, or
+ *  (at your option) any later version.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program; if not, write to the Free Software
+ *  Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA
02110-1301  USA
+ */
+
+#include <linux/init.h>
+#include <linux/ioport.h>
+#include <linux/mc146818rtc.h>
+#include <linux/platform_device.h>
+
+static struct resource rtc_cmos_resource[] = {
+	{
+		.start	= RTC_PORT(0),
+		.end	= RTC_PORT(1),
+		.flags	= IORESOURCE_IO,
+	},
+	{
+		.start	= RTC_IRQ,
+		.end	= RTC_IRQ,
+		.flags	= IORESOURCE_IRQ,
+	},
+};
+
+static struct platform_device rtc_cmos_device = { 
+        .name           = "rtc_cmos",
+        .id             = -1,
+        .num_resources  = ARRAY_SIZE(rtc_cmos_resource),
+        .resource       = rtc_cmos_resource
+};
+
+static __init int rtc_cmos_init(void)
+{
+	platform_device_register(&rtc_cmos_device);
+
+	return 0;
+}
+
+device_initcall(rtc_cmos_init);
diff --git a/drivers/rtc/rtc-cmos.c b/drivers/rtc/rtc-cmos.c
index b6d35f5..1718526 100644
--- a/drivers/rtc/rtc-cmos.c
+++ b/drivers/rtc/rtc-cmos.c
@@ -757,7 +757,7 @@ cmos_do_probe(struct device *dev, struct resource
*ports, int rtc_irq)
 	 * <asm-generic/rtc.h> doesn't know 12-hour mode either.
 	 */
 	if (is_valid_irq(rtc_irq) &&
-	    (!(rtc_control & RTC_24H) || (rtc_control & (RTC_DM_BINARY)))) {
+	    (!(rtc_control & RTC_24H))) {
 		dev_dbg(dev, "only 24-hr BCD mode supported\n");
 		retval = -ENXIO;
 		goto cleanup1;
-- 
1.6.2.1
