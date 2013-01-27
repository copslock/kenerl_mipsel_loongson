Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 27 Jan 2013 19:08:05 +0100 (CET)
Received: from nbd.name ([46.4.11.11]:41587 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6833514Ab3A0SGt6G6lM (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sun, 27 Jan 2013 19:06:49 +0100
From:   John Crispin <blogic@openwrt.org>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org, John Crispin <blogic@openwrt.org>
Subject: [PATCH V2 04/10] MIPS: ralink: adds prom and cmdline code
Date:   Sun, 27 Jan 2013 19:03:56 +0100
Message-Id: <1359309842-31925-5-git-send-email-blogic@openwrt.org>
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <1359309842-31925-1-git-send-email-blogic@openwrt.org>
References: <1359309842-31925-1-git-send-email-blogic@openwrt.org>
X-archive-position: 35572
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

Add minimal code to handle commandlines.

Signed-off-by: John Crispin <blogic@openwrt.org>
---
 arch/mips/ralink/prom.c |   69 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 69 insertions(+)
 create mode 100644 arch/mips/ralink/prom.c

diff --git a/arch/mips/ralink/prom.c b/arch/mips/ralink/prom.c
new file mode 100644
index 0000000..9c64f02
--- /dev/null
+++ b/arch/mips/ralink/prom.c
@@ -0,0 +1,69 @@
+/*
+ *  This program is free software; you can redistribute it and/or modify it
+ *  under the terms of the GNU General Public License version 2 as published
+ *  by the Free Software Foundation.
+ *
+ *  Copyright (C) 2009 Gabor Juhos <juhosg@openwrt.org>
+ *  Copyright (C) 2010 Joonas Lahtinen <joonas.lahtinen@gmail.com>
+ *  Copyright (C) 2013 John Crispin <blogic@openwrt.org>
+ */
+
+#include <linux/string.h>
+#include <linux/of_fdt.h>
+#include <linux/of_platform.h>
+
+#include <asm/bootinfo.h>
+#include <asm/addrspace.h>
+
+#include "common.h"
+
+struct ralink_soc_info soc_info;
+
+const char *get_system_type(void)
+{
+	return soc_info.sys_type;
+}
+
+static __init void prom_init_cmdline(int argc, char **argv)
+{
+	int i;
+
+	pr_debug("prom: fw_arg0=%08x fw_arg1=%08x fw_arg2=%08x fw_arg3=%08x\n",
+	       (unsigned int)fw_arg0, (unsigned int)fw_arg1,
+	       (unsigned int)fw_arg2, (unsigned int)fw_arg3);
+
+	argc = fw_arg0;
+	argv = (char **) KSEG1ADDR(fw_arg1);
+
+	if (!argv) {
+		pr_debug("argv=%p is invalid, skipping\n",
+		       argv);
+		return;
+	}
+
+	for (i = 0; i < argc; i++) {
+		char *p = (char *) KSEG1ADDR(argv[i]);
+
+		if (CPHYSADDR(p) && *p) {
+			pr_debug("argv[%d]: %s\n", i, p);
+			strlcat(arcs_cmdline, " ", sizeof(arcs_cmdline));
+			strlcat(arcs_cmdline, p, sizeof(arcs_cmdline));
+		}
+	}
+}
+
+void __init prom_init(void)
+{
+	int argc;
+	char **argv;
+
+	prom_soc_init(&soc_info);
+
+	pr_info("SoC Type: %s\n", get_system_type());
+
+	prom_init_cmdline(argc, argv);
+}
+
+void __init prom_free_prom_memory(void)
+{
+}
-- 
1.7.10.4
