Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 09 May 2011 18:47:43 +0200 (CEST)
Received: from nbd.name ([46.4.11.11]:45252 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1491037Ab1EIQrj (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 9 May 2011 18:47:39 +0200
From:   John Crispin <blogic@openwrt.org>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     John Crispin <blogic@openwrt.org>, linux-mips@linux-mips.org
Subject: [PATCH 4/4] MIPS: lantiq: add a soc specific setup function
Date:   Mon,  9 May 2011 18:49:10 +0200
Message-Id: <1304959750-8557-5-git-send-email-blogic@openwrt.org>
X-Mailer: git-send-email 1.7.2.3
In-Reply-To: <1304959750-8557-1-git-send-email-blogic@openwrt.org>
References: <1304959750-8557-1-git-send-email-blogic@openwrt.org>
Return-Path: <blogic@openwrt.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 29884
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: blogic@openwrt.org
Precedence: bulk
X-list: linux-mips

Add a setup-<SOC>.c file for every xway variant. This file is responsible for
registering the basic platform devices, that are always present.

Signed-off-by: John Crispin <blogic@openwrt.org>
Cc: linux-mips@linux-mips.org
---
 arch/mips/lantiq/prom.h            |    1 +
 arch/mips/lantiq/setup.c           |    4 ++--
 arch/mips/lantiq/xway/Makefile     |    4 ++--
 arch/mips/lantiq/xway/setup-ase.c  |   19 +++++++++++++++++++
 arch/mips/lantiq/xway/setup-xway.c |   20 ++++++++++++++++++++
 5 files changed, 44 insertions(+), 4 deletions(-)
 create mode 100644 arch/mips/lantiq/xway/setup-ase.c
 create mode 100644 arch/mips/lantiq/xway/setup-xway.c

diff --git a/arch/mips/lantiq/prom.h b/arch/mips/lantiq/prom.h
index 4165ad1..b4229d9 100644
--- a/arch/mips/lantiq/prom.h
+++ b/arch/mips/lantiq/prom.h
@@ -20,5 +20,6 @@ struct ltq_soc_info {
 };
 
 extern void ltq_soc_detect(struct ltq_soc_info *i);
+extern void ltq_soc_setup(void);
 
 #endif
diff --git a/arch/mips/lantiq/setup.c b/arch/mips/lantiq/setup.c
index 1d99b2b..2f27f58 100644
--- a/arch/mips/lantiq/setup.c
+++ b/arch/mips/lantiq/setup.c
@@ -16,6 +16,7 @@
 
 #include "machtypes.h"
 #include "devices.h"
+#include "prom.h"
 
 void __init plat_mem_setup(void)
 {
@@ -45,8 +46,7 @@ void __init plat_mem_setup(void)
 static int __init
 lantiq_setup(void)
 {
-	ltq_register_asc(0);
-	ltq_register_asc(1);
+	ltq_soc_setup();
 	mips_machine_setup();
 	return 0;
 }
diff --git a/arch/mips/lantiq/xway/Makefile b/arch/mips/lantiq/xway/Makefile
index d88a3e8..c517f2e 100644
--- a/arch/mips/lantiq/xway/Makefile
+++ b/arch/mips/lantiq/xway/Makefile
@@ -1,7 +1,7 @@
 obj-y := pmu.o ebu.o reset.o gpio.o gpio_stp.o gpio_ebu.o devices.o dma.o
 
-obj-$(CONFIG_SOC_XWAY) += clk-xway.o prom-xway.o
-obj-$(CONFIG_SOC_AMAZON_SE) += clk-ase.o prom-ase.o
+obj-$(CONFIG_SOC_XWAY) += clk-xway.o prom-xway.o setup-xway.o
+obj-$(CONFIG_SOC_AMAZON_SE) += clk-ase.o prom-ase.o setup-ase.o
 
 obj-$(CONFIG_LANTIQ_MACH_EASY50712) += mach-easy50712.o
 obj-$(CONFIG_LANTIQ_MACH_EASY50601) += mach-easy50601.o
diff --git a/arch/mips/lantiq/xway/setup-ase.c b/arch/mips/lantiq/xway/setup-ase.c
new file mode 100644
index 0000000..f6f3267
--- /dev/null
+++ b/arch/mips/lantiq/xway/setup-ase.c
@@ -0,0 +1,19 @@
+/*
+ *  This program is free software; you can redistribute it and/or modify it
+ *  under the terms of the GNU General Public License version 2 as published
+ *  by the Free Software Foundation.
+ *
+ *  Copyright (C) 2011 John Crispin <blogic@openwrt.org>
+ */
+
+#include <lantiq_soc.h>
+
+#include "../prom.h"
+#include "devices.h"
+
+void __init ltq_soc_setup(void)
+{
+	ltq_register_ase_asc();
+	ltq_register_gpio();
+	ltq_register_wdt();
+}
diff --git a/arch/mips/lantiq/xway/setup-xway.c b/arch/mips/lantiq/xway/setup-xway.c
new file mode 100644
index 0000000..c292f64
--- /dev/null
+++ b/arch/mips/lantiq/xway/setup-xway.c
@@ -0,0 +1,20 @@
+/*
+ *  This program is free software; you can redistribute it and/or modify it
+ *  under the terms of the GNU General Public License version 2 as published
+ *  by the Free Software Foundation.
+ *
+ *  Copyright (C) 2011 John Crispin <blogic@openwrt.org>
+ */
+
+#include <lantiq_soc.h>
+
+#include "../prom.h"
+#include "devices.h"
+
+void __init ltq_soc_setup(void)
+{
+	ltq_register_asc(0);
+	ltq_register_asc(1);
+	ltq_register_gpio();
+	ltq_register_wdt();
+}
-- 
1.7.2.3
