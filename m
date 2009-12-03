Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 03 Dec 2009 02:56:01 +0100 (CET)
Received: from mail-gx0-f210.google.com ([209.85.217.210]:34040 "EHLO
        mail-gx0-f210.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1494255AbZLCBz4 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 3 Dec 2009 02:55:56 +0100
Received: by gxk2 with SMTP id 2so755477gxk.4
        for <multiple recipients>; Wed, 02 Dec 2009 17:55:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=xgKRLfnovxtK4d6Lc689pYEGGX8JwWTvdoOrGozrHgY=;
        b=lhy2kxdworoFSNU/BmnZ7dwjnw+Cf0EXEmGp+JLt+7WOsnuHuIwIHLphkjIvWAl9f+
         e2bY0tMMfregdpRJ+gXneECfIlGFysCVq/7oje/kGUEkMimFynHxfFn2sJnHh/ywiIFF
         zHbnfCv47BNJ7lNyTiWIwsYZ0XzT8MfB1R1W0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=bApjx7v6BhDhgHkAC8xJ+la1XFwns0fcKN7h7eh8+j+LqH3cnt8Tc99vsaDI+vxjQw
         HphCq2dQY7U7JZQsTzvpniqKRPiKhR9zeKdnkKUwGVRX3U/w/UXON7gK1/zcuylrAO8J
         Er1KP1GuJnwlyhGV/N/A2a0EpgamEIczFjAho=
Received: by 10.151.1.32 with SMTP id d32mr1616968ybi.333.1259805348084;
        Wed, 02 Dec 2009 17:55:48 -0800 (PST)
Received: from localhost.localdomain ([222.92.8.142])
        by mx.google.com with ESMTPS id 22sm649059ywh.0.2009.12.02.17.55.42
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 02 Dec 2009 17:55:47 -0800 (PST)
From:   Wu Zhangjin <wuzhangjin@gmail.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Dave Jones <davej@redhat.com>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        cpufreq@vger.kernel.org, Wu Zhangjin <wuzhangjin@gmail.com>
Subject: [PATCH v0] Loongson2: CPUFreq: add support to load module automatically
Date:   Thu,  3 Dec 2009 09:55:33 +0800
Message-Id: <8421507f5dfc1a70d1dba92ad7604a8bfaa5a447.1259805106.git.wuzhangjin@gmail.com>
X-Mailer: git-send-email 1.6.2.1
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 25283
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips

This patch registers a loongson2_cpufreq platform device, make the
CPUFreq support for loongson2 as a platform driver, and then bind them
together via the platform_device_id to allow it be loaded automatically
when booting. With this support, there is no need to add the module name
into /etc/modules.

Signed-off-by: Wu Zhangjin <wuzhangjin@gmail.com>
---
 arch/mips/include/asm/cpu.h                  |    2 +
 arch/mips/kernel/cpufreq/loongson2_cpufreq.c |   35 ++++++++++++++++++++++---
 arch/mips/loongson/common/Makefile           |    2 +-
 arch/mips/loongson/common/platform.c         |   32 +++++++++++++++++++++++
 4 files changed, 65 insertions(+), 6 deletions(-)
 create mode 100644 arch/mips/loongson/common/platform.c

diff --git a/arch/mips/include/asm/cpu.h b/arch/mips/include/asm/cpu.h
index 4b96d1a..cf373a9 100644
--- a/arch/mips/include/asm/cpu.h
+++ b/arch/mips/include/asm/cpu.h
@@ -154,6 +154,8 @@
 #define PRID_REV_VR4181A	0x0070	/* Same as VR4122 */
 #define PRID_REV_VR4130		0x0080
 #define PRID_REV_34K_V1_0_2	0x0022
+#define PRID_REV_LOONGSON2E	0x0002
+#define PRID_REV_LOONGSON2F	0x0003
 
 /*
  * Older processors used to encode processor version and revision in two
diff --git a/arch/mips/kernel/cpufreq/loongson2_cpufreq.c b/arch/mips/kernel/cpufreq/loongson2_cpufreq.c
index 7232dcb..2f6a0b1 100644
--- a/arch/mips/kernel/cpufreq/loongson2_cpufreq.c
+++ b/arch/mips/kernel/cpufreq/loongson2_cpufreq.c
@@ -15,6 +15,7 @@
 #include <linux/err.h>
 #include <linux/sched.h>	/* set_cpus_allowed() */
 #include <linux/delay.h>
+#include <linux/platform_device.h>
 
 #include <asm/clock.h>
 
@@ -163,23 +164,45 @@ static struct cpufreq_driver loongson2_cpufreq_driver = {
 	.attr = loongson2_table_attr,
 };
 
+static struct platform_device_id platform_device_ids[] = {
+	{
+		.name = "loongson2_cpufreq",
+	},
+	{}
+};
+
+MODULE_DEVICE_TABLE(platform, platform_device_ids);
+
+static struct platform_driver platform_driver = {
+	.driver = {
+		.name = "loongson2_cpufreq",
+		.owner = THIS_MODULE,
+	},
+	.id_table = platform_device_ids,
+};
+
 static int __init cpufreq_init(void)
 {
-	int result;
+	int ret;
+
+	/* Register platform stuff */
+	ret = platform_driver_register(&platform_driver);
+	if (ret)
+		return ret;
 
-	printk(KERN_INFO "cpufreq: Loongson-2F CPU frequency driver.\n");
+	pr_info("cpufreq: Loongson-2F CPU frequency driver.\n");
 
 	cpufreq_register_notifier(&loongson2_cpufreq_notifier_block,
 				  CPUFREQ_TRANSITION_NOTIFIER);
 
-	result = cpufreq_register_driver(&loongson2_cpufreq_driver);
+	ret = cpufreq_register_driver(&loongson2_cpufreq_driver);
 
-	if (!result && !nowait) {
+	if (!ret && !nowait) {
 		saved_cpu_wait = cpu_wait;
 		cpu_wait = loongson2_cpu_wait;
 	}
 
-	return result;
+	return ret;
 }
 
 static void __exit cpufreq_exit(void)
@@ -189,6 +212,8 @@ static void __exit cpufreq_exit(void)
 	cpufreq_unregister_driver(&loongson2_cpufreq_driver);
 	cpufreq_unregister_notifier(&loongson2_cpufreq_notifier_block,
 				    CPUFREQ_TRANSITION_NOTIFIER);
+
+	platform_driver_unregister(&platform_driver);
 }
 
 module_init(cpufreq_init);
diff --git a/arch/mips/loongson/common/Makefile b/arch/mips/loongson/common/Makefile
index 01fc2f3..7668c4d 100644
--- a/arch/mips/loongson/common/Makefile
+++ b/arch/mips/loongson/common/Makefile
@@ -3,7 +3,7 @@
 #
 
 obj-y += setup.o init.o cmdline.o env.o time.o reset.o irq.o \
-    pci.o bonito-irq.o mem.o machtype.o
+    pci.o bonito-irq.o mem.o machtype.o platform.o
 
 #
 # Serial port support
diff --git a/arch/mips/loongson/common/platform.c b/arch/mips/loongson/common/platform.c
new file mode 100644
index 0000000..fdb24fd
--- /dev/null
+++ b/arch/mips/loongson/common/platform.c
@@ -0,0 +1,32 @@
+/*
+ * Copyright (C) 2009 Lemote Inc.
+ * Author: Wu Zhangjin, wuzj@lemote.com
+ *
+ * This program is free software; you can redistribute  it and/or modify it
+ * under  the terms of  the GNU General  Public License as published by the
+ * Free Software Foundation;  either version 2 of the  License, or (at your
+ * option) any later version.
+ */
+
+#include <linux/err.h>
+#include <linux/platform_device.h>
+
+#include <asm/bootinfo.h>
+
+static struct platform_device loongson2_cpufreq_device = {
+	.name = "loongson2_cpufreq",
+	.id = -1,
+};
+
+static int __init loongson2_cpufreq_init(void)
+{
+	struct cpuinfo_mips *c = &current_cpu_data;
+
+	/* Only 2F revision and it's successors support CPUFreq */
+	if ((c->processor_id & PRID_REV_MASK) >= PRID_REV_LOONGSON2F)
+		return platform_device_register(&loongson2_cpufreq_device);
+
+	return -ENODEV;
+}
+
+arch_initcall(loongson2_cpufreq_init);
-- 
1.6.2.1
