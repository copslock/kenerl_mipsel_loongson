Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 20 May 2009 22:53:06 +0100 (BST)
Received: from mail-pz0-f202.google.com ([209.85.222.202]:50693 "EHLO
	mail-pz0-f202.google.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S20025173AbZETVxA (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 20 May 2009 22:53:00 +0100
Received: by pzk40 with SMTP id 40so625001pzk.22
        for <multiple recipients>; Wed, 20 May 2009 14:52:53 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=DEBRdaL0wPcLwCuexPQ3i37tPY2Ljg5qz8DcVgYBqT4=;
        b=OYZFP25r6DI7hIQ49LTJ7VJv9Y3hrw7qYE15hvJMGk/wvpmIP4EPMRBesy/ShwOchJ
         1yCuuvyyJ80IZM31oCRSyT3buKXgurpjhYaU2QX9bDlYSGApi1CF8SxPaSy3cy1y6gmY
         o3Jp+eAutlca6XRhuRT1vZD2vz4XDpBX/SWaI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=dzylfglyFtsQnPbTyY/5J9rXl7sTYUPIqvlLJ4Iekpi4OPG0xZSmZ9/bRg9QBscoST
         ZMMLPBCqinnRbnx9pJdSfxRTvmLAYpcmGGT8QSnozmCV3a3dv15IjVyaWDgYld09gu+a
         ye/XjS7VnhvXvPiBPTdzADOcVhtgdC5/zA6Vk=
Received: by 10.114.208.20 with SMTP id f20mr3604099wag.46.1242856373108;
        Wed, 20 May 2009 14:52:53 -0700 (PDT)
Received: from localhost.localdomain ([222.92.8.142])
        by mx.google.com with ESMTPS id d20sm3341671waa.47.2009.05.20.14.52.46
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 20 May 2009 14:52:52 -0700 (PDT)
From:	wuzhangjin@gmail.com
To:	linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>,
	rtc-linux@googlegroups.com
Cc:	Wu Zhangjin <wuzhangjin@gmail.com>, Yan hua <yanh@lemote.com>,
	Philippe Vachon <philippe@cowpig.ca>,
	Zhang Le <r0bertz@gentoo.org>,
	Zhang Fuxin <zhangfx@lemote.com>,
	Arnaud Patard <apatard@mandriva.com>,
	loongson-dev@googlegroups.com, gnewsense-dev@nongnu.org,
	Nicholas Mc Guire <hofrat@hofr.at>,
	Liu Junliang <liujl@lemote.com>,
	Erwan Lerale <erwan@thiscow.com>
Subject: [loongson-PATCH-v1 09/27] enable Real Time Clock Support for fuloong(2e)
Date:	Thu, 21 May 2009 05:52:39 +0800
Message-Id: <3d13efa122929c5de37175a6da07b3bd856ab226.1242855716.git.wuzhangjin@gmail.com>
X-Mailer: git-send-email 1.6.2.1
In-Reply-To: <cover.1242855716.git.wuzhangjin@gmail.com>
References: <cover.1242855716.git.wuzhangjin@gmail.com>
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22873
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips

From: Wu Zhangjin <wuzhangjin@gmail.com>

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
index b6d35f5..b24181e 100644
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
1.6.2.1
