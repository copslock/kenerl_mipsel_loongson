Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 05 Nov 2009 02:24:35 +0100 (CET)
Received: from mail-pw0-f45.google.com ([209.85.160.45]:58138 "EHLO
	mail-pw0-f45.google.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1494105AbZKEBY2 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 5 Nov 2009 02:24:28 +0100
Received: by pwi11 with SMTP id 11so3666014pwi.24
        for <multiple recipients>; Wed, 04 Nov 2009 17:24:22 -0800 (PST)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=2on5FOJXrA9KtJSD8vnSTyMwTNogkrYX6cvxtxNM7HM=;
        b=tLGadlXgxRvYF76J7TIiZj2JGZQUj/EQ8zETB9kDBYhH1qJQjErUBfSJ6VAyGPaeDo
         fnSpHq/xSC7PHRNlUFLyMLs7AbgWEJ9X+3DWYfNkEJfzX1POddvUB1tP9sWfjrn3cSey
         7NpiMj3z+90vsDmuV63H91/6eLKh7hE4wPk3Y=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=l3PF5DlqtudQ9IM79d8fI+Lx1HkML2t89cDsjw+JVFh/+MTwMugzFVDna9GDDY8UzJ
         gcvrLcylSshJpbuEO3oDGdQcCQjlupDzlFNd+iMFiJbLt99lemupPZZjta8hqsg7daQF
         T5Uoz5YH5vNUnxaE30PSqU+TLBR5Ghb4A9SrU=
Received: by 10.114.7.39 with SMTP id 39mr3497440wag.188.1257384261352;
        Wed, 04 Nov 2009 17:24:21 -0800 (PST)
Received: from localhost.localdomain ([222.92.8.142])
        by mx.google.com with ESMTPS id 23sm913705pzk.0.2009.11.04.17.24.16
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 04 Nov 2009 17:24:20 -0800 (PST)
From:	Wu Zhangjin <wuzhangjin@gmail.com>
To:	Ralf Baechle <ralf@linux-mips.org>,
	Arnaud Patard <apatard@mandriva.com>
Cc:	linux-mips@linux-mips.org, rtc-linux@googlegroups.com,
	Paul Gortmaker <p_gortmaker@yahoo.com>,
	Alessandro Zummo <a.zummo@towertech.it>,
	Wu Zhangjin <wuzhangjin@gmail.com>
Subject: [PATCH v1 3/3] [loongson] RTC: Registration of Loongson RTC platform device
Date:	Thu,  5 Nov 2009 09:24:10 +0800
Message-Id: <a597312c16b5cf32621a25e8444d15d23726727f.1257383766.git.wuzhangjin@gmail.com>
X-Mailer: git-send-email 1.6.2.1
In-Reply-To: <cover.1257383766.git.wuzhangjin@gmail.com>
References: <cover.1257383766.git.wuzhangjin@gmail.com>
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24689
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips

This patch add the RTC_LIB support for fuloong2e,fuloong2f.

To make hwclock work with it normally, please do:

kernel configuration:

Device Drivers --->
<*> Real Time Clock --->
	<*>   PC-style 'CMOS'

user-space configuration:

$ mknod /dev/rtc0 c 254 0

/dev/rtc0 is the default RTC device file.

Of course, if udevd installed, ignore the above user-space
configuration.

Signed-off-by: Wu Zhangjin <wuzhangjin@gmail.com>
---
 arch/mips/loongson/common/Makefile |    6 +++++
 arch/mips/loongson/common/rtc.c    |   43 ++++++++++++++++++++++++++++++++++++
 2 files changed, 49 insertions(+), 0 deletions(-)
 create mode 100644 arch/mips/loongson/common/rtc.c

diff --git a/arch/mips/loongson/common/Makefile b/arch/mips/loongson/common/Makefile
index d21d116..d1bd38c 100644
--- a/arch/mips/loongson/common/Makefile
+++ b/arch/mips/loongson/common/Makefile
@@ -10,3 +10,9 @@ obj-y += setup.o init.o cmdline.o env.o time.o reset.o irq.o \
 #
 obj-$(CONFIG_EARLY_PRINTK) += early_printk.o
 obj-$(CONFIG_SERIAL_8250) += serial.o
+
+# Enable RTC Class support
+#
+# please enable CONFIG_RTC_DRV_CMOS
+#
+obj-$(CONFIG_RTC_DRV_CMOS) += rtc.o
diff --git a/arch/mips/loongson/common/rtc.c b/arch/mips/loongson/common/rtc.c
new file mode 100644
index 0000000..1f88791
--- /dev/null
+++ b/arch/mips/loongson/common/rtc.c
@@ -0,0 +1,43 @@
+/*
+ *  Registration of Loongson RTC platform device.
+ *
+ *  Copyright (C) 2007  Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
+ *  Copyright (C) 2009  Wu Zhangjin <wuzj@lemote.com>
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by
+ *  the Free Software Foundation; either version 2 of the License, or
+ *  (at your option) any later version.
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
+	return platform_device_register(&rtc_cmos_device);
+}
+
+device_initcall(rtc_cmos_init);
-- 
1.6.2.1
