Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 05 Jan 2011 20:58:54 +0100 (CET)
Received: from nbd.name ([46.4.11.11]:35696 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1490993Ab1AETzj (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 5 Jan 2011 20:55:39 +0100
From:   John Crispin <blogic@openwrt.org>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     John Crispin <blogic@openwrt.org>,
        Ralph Hempel <ralph.hempel@lantiq.com>,
        Gabor Juhos <juhosg@openwrt.org>, linux-mips@linux-mips.org
Subject: [PATCH 09/10] MIPS: lantiq: add mips_machine support
Date:   Wed,  5 Jan 2011 20:56:18 +0100
Message-Id: <1294257379-417-10-git-send-email-blogic@openwrt.org>
X-Mailer: git-send-email 1.7.2.3
In-Reply-To: <1294257379-417-1-git-send-email-blogic@openwrt.org>
References: <1294257379-417-1-git-send-email-blogic@openwrt.org>
Return-Path: <blogic@openwrt.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 28852
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: blogic@openwrt.org
Precedence: bulk
X-list: linux-mips

This patch adds support for Gabor's mips_machine patch.

Signed-off-by: John Crispin <blogic@openwrt.org>
Signed-off-by: Ralph Hempel <ralph.hempel@lantiq.com>
Cc: Gabor Juhos <juhosg@openwrt.org>
Cc: linux-mips@linux-mips.org
---
 arch/mips/Kconfig            |    1 +
 arch/mips/lantiq/machtypes.h |   18 ++++++++++++++++++
 arch/mips/lantiq/setup.c     |   25 +++++++++++++++++++++++++
 3 files changed, 44 insertions(+), 0 deletions(-)
 create mode 100644 arch/mips/lantiq/machtypes.h

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 9d3fd89..ee5dccf 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -207,6 +207,7 @@ config LANTIQ
 	select ARCH_REQUIRE_GPIOLIB
 	select SWAP_IO_SPACE
 	select BOOT_RAW
+	select MIPS_MACHINE
 
 config LASAT
 	bool "LASAT Networks platforms"
diff --git a/arch/mips/lantiq/machtypes.h b/arch/mips/lantiq/machtypes.h
new file mode 100644
index 0000000..ffcacfc
--- /dev/null
+++ b/arch/mips/lantiq/machtypes.h
@@ -0,0 +1,18 @@
+/*
+ *  This program is free software; you can redistribute it and/or modify it
+ *  under the terms of the GNU General Public License version 2 as published
+ *  by the Free Software Foundation.
+ *
+ *  Copyright (C) 2010 John Crispin <blogic@openwrt.org>
+ */
+
+#ifndef _LANTIQ_MACH_H__
+#define _LANTIQ_MACH_H__
+
+#include <asm/mips_machine.h>
+
+enum lantiq_mach_type {
+	LTQ_MACH_GENERIC = 0,
+};
+
+#endif
diff --git a/arch/mips/lantiq/setup.c b/arch/mips/lantiq/setup.c
index f0f74d2..b30567e 100644
--- a/arch/mips/lantiq/setup.c
+++ b/arch/mips/lantiq/setup.c
@@ -14,6 +14,9 @@
 
 #include <lantiq.h>
 
+#include "machtypes.h"
+#include "devices.h"
+
 void __init
 plat_mem_setup(void)
 {
@@ -43,3 +46,25 @@ plat_mem_setup(void)
 	memsize *= 1024 * 1024;
 	add_memory_region(0x00000000, memsize, BOOT_MEM_RAM);
 }
+
+static int __init
+lantiq_setup(void)
+{
+	ltq_register_asc(0);
+	ltq_register_asc(1);
+	mips_machine_setup();
+	return 0;
+}
+
+arch_initcall(lantiq_setup);
+
+static void __init
+lantiq_generic_init(void)
+{
+	/* Nothing to do */
+}
+
+MIPS_MACHINE(LTQ_MACH_GENERIC,
+	     "Generic",
+	     "Generic Lantiq based board",
+	     lantiq_generic_init);
-- 
1.7.2.3
