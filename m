Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 23 Jan 2013 13:10:01 +0100 (CET)
Received: from nbd.name ([46.4.11.11]:52016 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6833392Ab3AWMInEEPyI (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 23 Jan 2013 13:08:43 +0100
From:   John Crispin <blogic@openwrt.org>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org, John Crispin <blogic@openwrt.org>
Subject: [RFC 04/11] MIPS: ralink: adds reset code
Date:   Wed, 23 Jan 2013 13:05:48 +0100
Message-Id: <1358942755-25371-5-git-send-email-blogic@openwrt.org>
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <1358942755-25371-1-git-send-email-blogic@openwrt.org>
References: <1358942755-25371-1-git-send-email-blogic@openwrt.org>
X-archive-position: 35510
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: blogic@openwrt.org
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

Resetting these SoCs requires no real magic. The code is straight forward.

Signed-off-by: John Crispin <blogic@openwrt.org>
---
 arch/mips/ralink/reset.c |   44 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 44 insertions(+)
 create mode 100644 arch/mips/ralink/reset.c

diff --git a/arch/mips/ralink/reset.c b/arch/mips/ralink/reset.c
new file mode 100644
index 0000000..22120e5
--- /dev/null
+++ b/arch/mips/ralink/reset.c
@@ -0,0 +1,44 @@
+/*
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License version 2 as published
+ * by the Free Software Foundation.
+ *
+ * Copyright (C) 2008-2009 Gabor Juhos <juhosg@openwrt.org>
+ * Copyright (C) 2008 Imre Kaloz <kaloz@openwrt.org>
+ * Copyright (C) 2013 John Crispin <blogic@openwrt.org>
+ */
+
+#include <linux/pm.h>
+#include <linux/io.h>
+
+#include <asm/reboot.h>
+
+#include <asm/mach-ralink/ralink_regs.h>
+
+/* Reset Control */
+#define SYSC_REG_RESET_CTRL     0x034
+#define RSTCTL_RESET_SYSTEM     BIT(0)
+
+static void ralink_restart(char *command)
+{
+	local_irq_disable();
+	rt_sysc_w32(RSTCTL_RESET_SYSTEM, SYSC_REG_RESET_CTRL);
+	unreachable();
+}
+
+static void ralink_halt(void)
+{
+	local_irq_disable();
+	unreachable();
+}
+
+static int __init mips_reboot_setup(void)
+{
+	_machine_restart = ralink_restart;
+	_machine_halt = ralink_halt;
+	pm_power_off = ralink_halt;
+
+	return 0;
+}
+
+arch_initcall(mips_reboot_setup);
-- 
1.7.10.4
