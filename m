Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 04 Nov 2009 16:50:07 +0100 (CET)
Received: from ey-out-1920.google.com ([74.125.78.147]:29720 "EHLO
	ey-out-1920.google.com" rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org
	with ESMTP id S1493336AbZKDPt5 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 4 Nov 2009 16:49:57 +0100
Received: by ey-out-1920.google.com with SMTP id 5so1345976eyb.52
        for <multiple recipients>; Wed, 04 Nov 2009 07:49:56 -0800 (PST)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=pXg76eGKgVLobzobc1iTlMyzb4x1a8DF/jeBTMBXkbY=;
        b=NBkyM2dizG2BDe6dGW3Syh5exJfOSQyhloaThkpKkmxiKexsnYxmbwzEK+qHVzfQU8
         LNeye/Wpiq+Rp+z7leG5ltK2P2hQZCzewkOtB4TYbj6rhpNVItG9XFyo+5Pzbzj7MGrX
         /u4V4uSAr21NXFD6Wdq+qP3LvRYjj8llh9OiY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=QfFI5voY8/lL2vZ/6p8QLF/mrbpBLPUrrjmsXRfh3a59FMJnZkn+Z2LP3q5FQWlT2/
         gJO9ZhMqAVGN0l1GrnQKloG8q5EQLjwICxmamXlDd2Jt2YMK/OecfVReqskqJsxFcWKK
         /Yeo0sbAwVs1LY5QfcQ6X0++TNaKann3HUxMI=
Received: by 10.216.86.142 with SMTP id w14mr495451wee.74.1257349796606;
        Wed, 04 Nov 2009 07:49:56 -0800 (PST)
Received: from localhost.localdomain ([222.92.8.142])
        by mx.google.com with ESMTPS id x6sm3550035gvf.1.2009.11.04.07.49.50
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 04 Nov 2009 07:49:55 -0800 (PST)
From:	Wu Zhangjin <wuzhangjin@gmail.com>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	Arnaud Patard <apatard@mandriva.com>,
	Wu Zhangjin <wuzhangjin@gmail.com>, linux-mips@linux-mips.org,
	rtc-linux@googlegroups.com
Subject: [PATCH 2/2] [loongson] fuloong: add RTC_LIB Support
Date:	Wed,  4 Nov 2009 23:49:44 +0800
Message-Id: <1257349784-21444-1-git-send-email-wuzhangjin@gmail.com>
X-Mailer: git-send-email 1.6.2.1
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24679
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

of course, if udevd is installed, ignore the above user-space
configuration.

Signed-off-by: Wu Zhangjin <wuzhangjin@gmail.com>
---
 arch/mips/loongson/common/Makefile |    7 +++++
 arch/mips/loongson/common/rtc.c    |   45 ++++++++++++++++++++++++++++++++++++
 2 files changed, 52 insertions(+), 0 deletions(-)
 create mode 100644 arch/mips/loongson/common/rtc.c

diff --git a/arch/mips/loongson/common/Makefile b/arch/mips/loongson/common/Makefile
index d3138b8..d2184c8 100644
--- a/arch/mips/loongson/common/Makefile
+++ b/arch/mips/loongson/common/Makefile
@@ -16,3 +16,10 @@ obj-$(CONFIG_SERIAL_8250) += serial.o
 # space
 #
 obj-$(CONFIG_CS5536) += cs5536/
+
+#
+# Enable RTC Class support
+#
+# please enable CONFIG_RTC_DRV_CMOS
+#
+obj-$(CONFIG_RTC_DRV_CMOS) += rtc.o
diff --git a/arch/mips/loongson/common/rtc.c b/arch/mips/loongson/common/rtc.c
new file mode 100644
index 0000000..fe9464a
--- /dev/null
+++ b/arch/mips/loongson/common/rtc.c
@@ -0,0 +1,45 @@
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
-- 
1.6.2.1
