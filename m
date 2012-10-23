Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 23 Oct 2012 19:51:47 +0200 (CEST)
Received: from mail-lb0-f177.google.com ([209.85.217.177]:61911 "EHLO
        mail-lb0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6825712Ab2JWRsJLapMt (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 23 Oct 2012 19:48:09 +0200
Received: by mail-lb0-f177.google.com with SMTP id gi11so520885lbb.36
        for <multiple recipients>; Tue, 23 Oct 2012 10:48:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=xzzR0JlYdryJiWhYyiCLBhUvFCvDBovqWUei5dUqnXY=;
        b=vkY9jwmfLqK87ykW3vqhAzpUACnHdL6E7GsHeo+DYajddU099y9HTbkZJ6SejdAXwT
         det0ZWTPLVfUJ4jvHIV7ckGZtIEy2vV4Cr38f8YOCKOIG9nsUxmyG1OQp3YKfm8CX6ch
         gIhwl6ui0+I+E/9QI8sib0Vb9hiJMs4f/Qi7km2dMT5q8Ko3tn1KiqzU4Ma89axWZ+s5
         hTMlF6EUOJ2lHpFQoI0vM/vNnf0SD95SMSIBaocbsJGYxpb1VH7u8CqN+j3a8hYasgZk
         KRnaOjtr65k3D84bHdxz+V3h6HZxeC4QeWJIiXzlIX6ww5Mv79dXku2qnz4cJoVdo5EG
         em8A==
Received: by 10.112.48.74 with SMTP id j10mr5365596lbn.94.1351014488644;
        Tue, 23 Oct 2012 10:48:08 -0700 (PDT)
Received: from lazar.cs.niisi.ras.ru (t109.niisi.ras.ru. [193.232.173.109])
        by mx.google.com with ESMTPS id m6sm4260284lbh.10.2012.10.23.10.48.07
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 23 Oct 2012 10:48:07 -0700 (PDT)
From:   Antony Pavlov <antonynpavlov@gmail.com>
To:     linux-mips@linux-mips.org
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Maarten ter Huurne <maarten@treewalker.org>,
        Antony Pavlov <antonynpavlov@gmail.com>
Subject: [RFC 12/13] MIPS: JZ4750D: Add rzx50 board support
Date:   Tue, 23 Oct 2012 21:44:00 +0400
Message-Id: <1351014241-3207-13-git-send-email-antonynpavlov@gmail.com>
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <1351014241-3207-1-git-send-email-antonynpavlov@gmail.com>
References: <1351014241-3207-1-git-send-email-antonynpavlov@gmail.com>
X-archive-position: 34762
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: antonynpavlov@gmail.com
Precedence: bulk
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-Id: linux-mips <linux-mips.eddie.linux-mips.org>
X-List-ID: linux-mips <linux-mips.eddie.linux-mips.org>
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

Add support for the Ritmix RZX-50 portable game console.

Signed-off-by: Antony Pavlov <antonynpavlov@gmail.com>
---
 arch/mips/jz4750d/Kconfig       |    4 ++++
 arch/mips/jz4750d/Makefile      |    3 +++
 arch/mips/jz4750d/board-rzx50.c |   41 +++++++++++++++++++++++++++++++++++++++
 3 files changed, 48 insertions(+)
 create mode 100644 arch/mips/jz4750d/board-rzx50.c

diff --git a/arch/mips/jz4750d/Kconfig b/arch/mips/jz4750d/Kconfig
index 388eea4..243dfeb 100644
--- a/arch/mips/jz4750d/Kconfig
+++ b/arch/mips/jz4750d/Kconfig
@@ -1,5 +1,9 @@
 choice
 	prompt "Machine type"
 	depends on MACH_JZ4750D
+	default JZ4750D_RZX50
+
+config JZ4750D_RZX50
+	bool "Ritmix RZX-50"
 
 endchoice
diff --git a/arch/mips/jz4750d/Makefile b/arch/mips/jz4750d/Makefile
index 0ecfbd4..9378802 100644
--- a/arch/mips/jz4750d/Makefile
+++ b/arch/mips/jz4750d/Makefile
@@ -8,3 +8,6 @@ obj-y += prom.o irq.o time.o reset.o setup.o
 obj-y += clock.o platform.o timer.o serial.o
 
 obj-$(CONFIG_DEBUG_FS) += clock-debugfs.o
+
+# board specific support
+obj-$(CONFIG_JZ4750D_RZX50)	+= board-rzx50.o
diff --git a/arch/mips/jz4750d/board-rzx50.c b/arch/mips/jz4750d/board-rzx50.c
new file mode 100644
index 0000000..27b9e96
--- /dev/null
+++ b/arch/mips/jz4750d/board-rzx50.c
@@ -0,0 +1,41 @@
+/*
+ *  Copyright (C) 2012, Antony Pavlov <antonynpavlov@gmail.com>
+ *  Ritmix RZX-50 board setup routines.
+ *
+ *  This program is free software; you can redistribute it and/or modify it
+ *  under the terms of the GNU General Public License as published by the
+ *  Free Software Foundation; either version 2 of the License, or (at your
+ *  option) any later version.
+ *
+ */
+
+#include <linux/kernel.h>
+#include <linux/init.h>
+
+#include <asm/mach-jz4750d/platform.h>
+
+#include "serial.h"
+#include "clock.h"
+
+struct jz4750d_clock_board_data jz4750d_clock_bdata = {
+	.ext_rate = 24000000,
+	.rtc_rate = 32768,
+};
+
+static int __init rzx50_init_platform_devices(void)
+{
+	jz4750d_serial_device_register();
+
+	return 0;
+}
+
+static int __init rzx50_board_setup(void)
+{
+	printk(KERN_ERR "Ritmix RZX-50 board setup\n");
+
+	if (rzx50_init_platform_devices())
+		panic("Failed to initalize platform devices\n");
+
+	return 0;
+}
+arch_initcall(rzx50_board_setup);
-- 
1.7.10.4
