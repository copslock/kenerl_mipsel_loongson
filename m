Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 22 May 2015 17:55:24 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:33545 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27026809AbbEVPzE3t7gL (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 22 May 2015 17:55:04 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 10B0D752958BD;
        Fri, 22 May 2015 16:54:58 +0100 (IST)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Fri, 22 May 2015 16:52:55 +0100
Received: from localhost (192.168.159.131) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.210.2; Fri, 22 May
 2015 16:52:55 +0100
From:   Paul Burton <paul.burton@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     <devicetree@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Pawel Moll <pawel.moll@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ian Campbell <ijc+devicetree@hellion.org.uk>,
        Kumar Gala <galak@codeaurora.org>,
        "Paul Burton" <paul.burton@imgtec.com>,
        Andrew Bresticker <abrestic@chromium.org>,
        <linux-kernel@vger.kernel.org>,
        Markos Chandras <markos.chandras@imgtec.com>,
        Ralf Baechle <ralf@linux-mips.org>
Subject: [PATCH 03/15] MIPS: malta: basic DT plumbing
Date:   Fri, 22 May 2015 16:51:02 +0100
Message-ID: <1432309875-9712-4-git-send-email-paul.burton@imgtec.com>
X-Mailer: git-send-email 2.4.1
In-Reply-To: <1432309875-9712-1-git-send-email-paul.burton@imgtec.com>
References: <1432309875-9712-1-git-send-email-paul.burton@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.159.131]
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 47561
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: paul.burton@imgtec.com
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

Build a DT for the Malta platform into the kernel, load it & probe
devices from it. The DT is essentially empty at this point, devices
will be added in further patches.

Signed-off-by: Paul Burton <paul.burton@imgtec.com>
---

 arch/mips/Kconfig                 |  2 ++
 arch/mips/boot/dts/mti/Makefile   |  1 +
 arch/mips/boot/dts/mti/malta.dts  |  7 +++++++
 arch/mips/mti-malta/Makefile      |  2 +-
 arch/mips/mti-malta/malta-dt.c    | 34 ++++++++++++++++++++++++++++++++++
 arch/mips/mti-malta/malta-setup.c |  4 ++++
 6 files changed, 49 insertions(+), 1 deletion(-)
 create mode 100644 arch/mips/boot/dts/mti/malta.dts
 create mode 100644 arch/mips/mti-malta/malta-dt.c

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index f501665..75dd13d 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -434,6 +434,8 @@ config MIPS_MALTA
 	select SYS_SUPPORTS_MULTITHREADING
 	select SYS_SUPPORTS_SMARTMIPS
 	select SYS_SUPPORTS_ZBOOT
+	select USE_OF
+	select BUILTIN_DTB
 	help
 	  This enables support for the MIPS Technologies Malta evaluation
 	  board.
diff --git a/arch/mips/boot/dts/mti/Makefile b/arch/mips/boot/dts/mti/Makefile
index ef1f3db..144d776 100644
--- a/arch/mips/boot/dts/mti/Makefile
+++ b/arch/mips/boot/dts/mti/Makefile
@@ -1,3 +1,4 @@
+dtb-$(CONFIG_MIPS_MALTA)	+= malta.dtb
 dtb-$(CONFIG_MIPS_SEAD3)	+= sead3.dtb
 
 obj-y				+= $(patsubst %.dtb, %.dtb.o, $(dtb-y))
diff --git a/arch/mips/boot/dts/mti/malta.dts b/arch/mips/boot/dts/mti/malta.dts
new file mode 100644
index 0000000..c678115
--- /dev/null
+++ b/arch/mips/boot/dts/mti/malta.dts
@@ -0,0 +1,7 @@
+/dts-v1/;
+
+/ {
+	#address-cells = <1>;
+	#size-cells = <1>;
+	compatible = "mti,malta";
+};
diff --git a/arch/mips/mti-malta/Makefile b/arch/mips/mti-malta/Makefile
index 6510ace..ea35587 100644
--- a/arch/mips/mti-malta/Makefile
+++ b/arch/mips/mti-malta/Makefile
@@ -5,7 +5,7 @@
 # Copyright (C) 2008 Wind River Systems, Inc.
 #   written by Ralf Baechle <ralf@linux-mips.org>
 #
-obj-y				:= malta-display.o malta-init.o \
+obj-y				:= malta-display.o malta-dt.o malta-init.o \
 				   malta-int.o malta-memory.o malta-platform.o \
 				   malta-reset.o malta-setup.o malta-time.o
 
diff --git a/arch/mips/mti-malta/malta-dt.c b/arch/mips/mti-malta/malta-dt.c
new file mode 100644
index 0000000..47a2288
--- /dev/null
+++ b/arch/mips/mti-malta/malta-dt.c
@@ -0,0 +1,34 @@
+/*
+ * Copyright (C) 2015 Imagination Technologies
+ * Author: Paul Burton <paul.burton@imgtec.com>
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License as published by the
+ * Free Software Foundation; either version 2 of the License, or (at your
+ * option) any later version.
+ */
+
+#include <linux/clk-provider.h>
+#include <linux/init.h>
+#include <linux/of_fdt.h>
+#include <linux/of_platform.h>
+
+void __init device_tree_init(void)
+{
+	unflatten_and_copy_device_tree();
+}
+
+static const struct of_device_id bus_ids[] __initconst = {
+	{ .compatible = "simple-bus", },
+	{ .compatible = "isa", },
+	{},
+};
+
+static int __init publish_devices(void)
+{
+	if (!of_have_populated_dt())
+		return 0;
+
+	return of_platform_bus_probe(NULL, bus_ids, NULL);
+}
+device_initcall(publish_devices);
diff --git a/arch/mips/mti-malta/malta-setup.c b/arch/mips/mti-malta/malta-setup.c
index db7c9e5..9d1e7f5 100644
--- a/arch/mips/mti-malta/malta-setup.c
+++ b/arch/mips/mti-malta/malta-setup.c
@@ -21,6 +21,7 @@
 #include <linux/sched.h>
 #include <linux/ioport.h>
 #include <linux/irq.h>
+#include <linux/of_fdt.h>
 #include <linux/pci.h>
 #include <linux/screen_info.h>
 #include <linux/time.h>
@@ -31,6 +32,7 @@
 #include <asm/mips-boards/malta.h>
 #include <asm/mips-boards/maltaint.h>
 #include <asm/dma.h>
+#include <asm/prom.h>
 #include <asm/traps.h>
 #ifdef CONFIG_VT
 #include <linux/console.h>
@@ -249,6 +251,8 @@ void __init plat_mem_setup(void)
 {
 	unsigned int i;
 
+	__dt_setup_arch(__dtb_start);
+
 	if (config_enabled(CONFIG_EVA))
 		/* EVA has already been configured in mach-malta/kernel-init.h */
 		pr_info("Enhanced Virtual Addressing (EVA) activated\n");
-- 
2.4.1
