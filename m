Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 30 Mar 2011 09:28:12 +0200 (CEST)
Received: from nbd.name ([46.4.11.11]:45657 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1491079Ab1C3H0w (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 30 Mar 2011 09:26:52 +0200
From:   John Crispin <blogic@openwrt.org>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     John Crispin <blogic@openwrt.org>,
        Ralph Hempel <ralph.hempel@lantiq.com>,
        Gabor Juhos <juhosg@openwrt.org>, linux-mips@linux-mips.org
Subject: [PATCH V5 08/10] MIPS: lantiq: add mips_machine support
Date:   Wed, 30 Mar 2011 09:27:54 +0200
Message-Id: <1301470076-17279-9-git-send-email-blogic@openwrt.org>
X-Mailer: git-send-email 1.7.2.3
In-Reply-To: <1301470076-17279-1-git-send-email-blogic@openwrt.org>
References: <1301470076-17279-1-git-send-email-blogic@openwrt.org>
Return-Path: <blogic@openwrt.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 29624
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
index e1ba7d0..4317500 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -228,6 +228,7 @@ config LANTIQ
 	select SWAP_IO_SPACE
 	select BOOT_RAW
 	select HAVE_CLK
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
index edeb076..bf35435 100644
--- a/arch/mips/lantiq/setup.c
+++ b/arch/mips/lantiq/setup.c
@@ -14,6 +14,9 @@
 
 #include <lantiq_soc.h>
 
+#include "machtypes.h"
+#include "devices.h"
+
 void __init
 plat_mem_setup(void)
 {
@@ -45,3 +48,25 @@ plat_mem_setup(void)
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
