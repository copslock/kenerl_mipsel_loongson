Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 26 May 2009 20:06:09 +0100 (BST)
Received: from mail-px0-f119.google.com ([209.85.216.119]:35559 "EHLO
	mail-px0-f119.google.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S20024661AbZEZTF4 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 26 May 2009 20:05:56 +0100
Received: by pxi17 with SMTP id 17so3789088pxi.22
        for <multiple recipients>; Tue, 26 May 2009 12:05:50 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=w8CcwpuRdezyOhMtc030IpNyb/hSUy2JaEq2t5fvSPM=;
        b=p8hlNYigcz2euaoSAXcL9GMrBKYx4UXxuGdqK7cUQO/6WNHpo/BarYZZlerYr9yNIP
         Kn1xczDhxWB3djIDpSwcixbpM+cTGDyG/IFvBRBTmLPZO5ZiB6PU/TPoOieRWq9VlDOK
         Qj9OI67BAl+phYqTbXvfBae2VHnGmm/acN9tI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=RWBYF1EfUZpq7uUydPP7GOkMXQj3k9fXG5t0Lq0qq1Iif2FsNbRS6NZWvQ+f35ddps
         I71KyVlrQbTsYVMVviYTPcM7CHCLl8QzuOp/pgn7VzwikH0uI5LAruUGZPZViXhv1yZV
         A6RZRG3ql2waKBys2mgPpD4mUneThXOrfEUQE=
Received: by 10.114.198.5 with SMTP id v5mr17908335waf.131.1243364749823;
        Tue, 26 May 2009 12:05:49 -0700 (PDT)
Received: from localhost.localdomain ([219.246.59.144])
        by mx.google.com with ESMTPS id j28sm1063486waf.58.2009.05.26.12.05.44
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 26 May 2009 12:05:48 -0700 (PDT)
From:	wuzhangjin@gmail.com
To:	linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>
Cc:	Wu Zhangjin <wuzj@lemote.com>, Yan Hua <yanh@lemote.com>,
	Philippe Vachon <philippe@cowpig.ca>,
	Zhang Le <r0bertz@gentoo.org>,
	Zhang Fuxin <zhangfx@lemote.com>,
	loongson-dev <loongson-dev@googlegroups.com>,
	Nicholas Mc Guire <der.herr@hofr.at>,
	Liu Junliang <liujl@lemote.com>,
	Erwan Lerale <erwan@thiscow.com>,
	Wu Zhangjin <wuzhangjin@gmail.com>
Subject: [loongson-PATCH-v2 08/23] enable Real Time Clock Support for fuloong(2e)
Date:	Wed, 27 May 2009 03:05:40 +0800
Message-Id: <96d2075c49547f8a09ee3f472a69dbefb5dc40e0.1243362545.git.wuzj@lemote.com>
X-Mailer: git-send-email 1.6.3.1
In-Reply-To: <cover.1243362545.git.wuzj@lemote.com>
References: <cover.1243362545.git.wuzj@lemote.com>
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22982
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips

From: Wu Zhangjin <wuzj@lemote.com>

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

and there is another RTC support in linux, whose kernel option is
RTC_CLASS, it should be fixed for fuloong(2e) via enabling the binary
mode in driver/rtc/rtc-cmos.c and register the RTC device resource in a
machine specific rtc.c

to make hwclock work with it normally, please do:

kernel configuration:

Device Drivers --->
<*> Real Time Clock --->
	<*>   PC-style 'CMOS'

user-space configuration:

$ mknod /dev/rtc0 c 254 0

/dev/rtc0 is the default RTC device file.

Signed-off-by: Wu Zhangjin <wuzhangjin@gmail.com>
---
 arch/mips/Kconfig                      |    2 +-
 arch/mips/loongson/fuloong-2e/Makefile |    7 ++++
 arch/mips/loongson/fuloong-2e/rtc.c    |   55 ++++++++++++++++++++++++++++++++
 drivers/rtc/rtc-cmos.c                 |    8 ++--
 4 files changed, 67 insertions(+), 5 deletions(-)
 create mode 100644 arch/mips/loongson/fuloong-2e/rtc.c

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 7897861..4a7e61f 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -6,7 +6,7 @@ config MIPS
 	select HAVE_ARCH_KGDB
 	# Horrible source of confusion.  Die, die, die ...
 	select EMBEDDED
-	select RTC_LIB
+	select RTC_LIB if !LEMOTE_FULOONG2E
 
 mainmenu "Linux/MIPS Kernel Configuration"
 
diff --git a/arch/mips/loongson/fuloong-2e/Makefile b/arch/mips/loongson/fuloong-2e/Makefile
index 035e04c..76904da 100644
--- a/arch/mips/loongson/fuloong-2e/Makefile
+++ b/arch/mips/loongson/fuloong-2e/Makefile
@@ -10,4 +10,11 @@ obj-y += setup.o init.o cmdline.o time.o reset.o irq.o \
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
diff --git a/arch/mips/loongson/fuloong-2e/rtc.c b/arch/mips/loongson/fuloong-2e/rtc.c
new file mode 100644
index 0000000..469ada8
--- /dev/null
+++ b/arch/mips/loongson/fuloong-2e/rtc.c
@@ -0,0 +1,55 @@
+/*
+ *  Registration of Cobalt RTC platform device.
+ *
+ *  Copyright (C) 2007  Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
+ *  Copyright (C) 2009  Wu Zhangjin <wuzj@lemote.com>
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by
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
+ *  Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston,
+ *  MA 02110-1301 USA
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
+	.name		= "rtc_cmos",
+	.id		= -1,
+	.num_resources	= ARRAY_SIZE(rtc_cmos_resource),
+	.resource	= rtc_cmos_resource
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
index 23e10b6..6f32ac5 100644
--- a/drivers/rtc/rtc-cmos.c
+++ b/drivers/rtc/rtc-cmos.c
@@ -691,7 +691,8 @@ cmos_do_probe(struct device *dev, struct resource *ports, int rtc_irq)
 	 */
 #if	defined(CONFIG_ATARI)
 	address_space = 64;
-#elif defined(__i386__) || defined(__x86_64__) || defined(__arm__) || defined(__sparc__)
+#elif defined(__i386__) || defined(__x86_64__) || defined(__arm__) \
+			|| defined(__sparc__) || defined(__mips__)
 	address_space = 128;
 #else
 #warning Assuming 128 bytes of RTC+NVRAM address space, not 64 bytes.
@@ -756,9 +757,8 @@ cmos_do_probe(struct device *dev, struct resource *ports, int rtc_irq)
 	/* FIXME teach the alarm code how to handle binary mode;
 	 * <asm-generic/rtc.h> doesn't know 12-hour mode either.
 	 */
-	if (is_valid_irq(rtc_irq) &&
-	    (!(rtc_control & RTC_24H) || (rtc_control & (RTC_DM_BINARY)))) {
-		dev_dbg(dev, "only 24-hr BCD mode supported\n");
+	if (is_valid_irq(rtc_irq) && !(rtc_control & RTC_24H)) {
+		dev_dbg(dev, "only 24-hr supported\n");
 		retval = -ENXIO;
 		goto cleanup1;
 	}
-- 
1.6.0.4
