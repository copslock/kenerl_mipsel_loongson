Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 12 Nov 2010 22:53:45 +0100 (CET)
Received: from phoenix3.szarvasnet.hu ([87.101.127.16]:56923 "EHLO
        phoenix3.szarvasnet.hu" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492161Ab0KLVvz (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 12 Nov 2010 22:51:55 +0100
Received: from mail.szarvas.hu (localhost [127.0.0.1])
        by phoenix3.szarvasnet.hu (Postfix) with SMTP id D5DB541C005;
        Fri, 12 Nov 2010 22:51:49 +0100 (CET)
Received: from localhost.localdomain (catvpool-576570d8.szarvasnet.hu [87.101.112.216])
        by phoenix3.szarvasnet.hu (Postfix) with ESMTP id 44B49270001;
        Fri, 12 Nov 2010 22:51:49 +0100 (CET)
From:   Gabor Juhos <juhosg@openwrt.org>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org, "Luis R. Rodriguez" <mcgrof@gmail.com>,
        Cliff Holden <Cliff.Holden@Atheros.com>,
        Imre Kaloz <kaloz@openwrt.org>,
        Gabor Juhos <juhosg@openwrt.org>
Subject: [RFC 04/18] MIPS: ath79: utilize the MIPS multi-machine support
Date:   Fri, 12 Nov 2010 22:51:10 +0100
Message-Id: <1289598684-30624-5-git-send-email-juhosg@openwrt.org>
X-Mailer: git-send-email 1.7.2.1
In-Reply-To: <1289598684-30624-1-git-send-email-juhosg@openwrt.org>
References: <1289598684-30624-1-git-send-email-juhosg@openwrt.org>
X-VBMS: A1226B73416 | phoenix3 | 127.0.0.1 |  | <juhosg@openwrt.org> | 
Return-Path: <juhosg@openwrt.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 28370
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: juhosg@openwrt.org
Precedence: bulk
X-list: linux-mips

Signed-off-by: Gabor Juhos <juhosg@openwrt.org>
---
 arch/mips/Kconfig           |    1 +
 arch/mips/ath79/machtypes.h |   21 +++++++++++++++++++++
 arch/mips/ath79/setup.c     |   15 +++++++++++++++
 3 files changed, 37 insertions(+), 0 deletions(-)
 create mode 100644 arch/mips/ath79/machtypes.h

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 436fc24..7307e62 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -66,6 +66,7 @@ config ATH79
 	select CSRC_R4K
 	select DMA_NONCOHERENT
 	select IRQ_CPU
+	select MIPS_MACHINE
 	select SYS_HAS_CPU_MIPS32_R2
 	select SYS_HAS_EARLY_PRINTK
 	select SYS_SUPPORTS_32BIT_KERNEL
diff --git a/arch/mips/ath79/machtypes.h b/arch/mips/ath79/machtypes.h
new file mode 100644
index 0000000..fac0e26
--- /dev/null
+++ b/arch/mips/ath79/machtypes.h
@@ -0,0 +1,21 @@
+/*
+ *  Atheros AR71XX/AR724X/AR913X machine type definitions
+ *
+ *  Copyright (C) 2008-2010 Gabor Juhos <juhosg@openwrt.org>
+ *  Copyright (C) 2008 Imre Kaloz <kaloz@openwrt.org>
+ *
+ *  This program is free software; you can redistribute it and/or modify it
+ *  under the terms of the GNU General Public License version 2 as published
+ *  by the Free Software Foundation.
+ */
+
+#ifndef _ATH79_MACHTYPE_H
+#define _ATH79_MACHTYPE_H
+
+#include <asm/mips_machine.h>
+
+enum ath79_mach_type {
+	ATH79_MACH_GENERIC = 0,
+};
+
+#endif /* _ATH79_MACHTYPE_H */
diff --git a/arch/mips/ath79/setup.c b/arch/mips/ath79/setup.c
index c1a95e1..b36f9f2 100644
--- a/arch/mips/ath79/setup.c
+++ b/arch/mips/ath79/setup.c
@@ -18,11 +18,13 @@
 #include <asm/bootinfo.h>
 #include <asm/time.h>		/* for mips_hpt_frequency */
 #include <asm/reboot.h>		/* for _machine_{restart,halt} */
+#include <asm/mips_machine.h>
 
 #include <asm/mach-ath79/ath79.h>
 #include <asm/mach-ath79/ar71xx_regs.h>
 #include "common.h"
 #include "dev-uart.h"
+#include "machtypes.h"
 
 #define ATH79_SYS_TYPE_LEN	64
 
@@ -257,7 +259,20 @@ static int __init ath79_setup(void)
 {
 	ath79_gpio_init();
 	ath79_register_uart();
+
+	mips_machine_setup();
+
 	return 0;
 }
 
 arch_initcall(ath79_setup);
+
+static void __init ath79_generic_init(void)
+{
+	/* Nothing to do */
+}
+
+MIPS_MACHINE(ATH79_MACH_GENERIC,
+	     "Generic",
+	     "Generic AR71XX/AR724X/AR913X based board",
+	     ath79_generic_init);
-- 
1.7.2.1
