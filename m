Return-Path: <SRS0=OeKb=W4=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1E06C3A5A4
	for <linux-mips@archiver.kernel.org>; Sun,  1 Sep 2019 16:36:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A9D621874
	for <linux-mips@archiver.kernel.org>; Sun,  1 Sep 2019 16:36:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728672AbfIAQgW (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Sun, 1 Sep 2019 12:36:22 -0400
Received: from pio-pvt-msa2.bahnhof.se ([79.136.2.41]:33552 "EHLO
        pio-pvt-msa2.bahnhof.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726727AbfIAQgW (ORCPT
        <rfc822;linux-mips@vger.kernel.org>); Sun, 1 Sep 2019 12:36:22 -0400
Received: from localhost (localhost [127.0.0.1])
        by pio-pvt-msa2.bahnhof.se (Postfix) with ESMTP id 3BDA33FBF6
        for <linux-mips@vger.kernel.org>; Sun,  1 Sep 2019 18:36:20 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at bahnhof.se
Received: from pio-pvt-msa2.bahnhof.se ([127.0.0.1])
        by localhost (pio-pvt-msa2.bahnhof.se [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id Pa0a8E4AXjw2 for <linux-mips@vger.kernel.org>;
        Sun,  1 Sep 2019 18:36:19 +0200 (CEST)
Received: from localhost (h-41-252.A163.priv.bahnhof.se [46.59.41.252])
        (Authenticated sender: mb547485)
        by pio-pvt-msa2.bahnhof.se (Postfix) with ESMTPA id 9B3583F52B
        for <linux-mips@vger.kernel.org>; Sun,  1 Sep 2019 18:36:19 +0200 (CEST)
Date:   Sun, 1 Sep 2019 18:36:19 +0200
From:   Fredrik Noring <noring@nocrew.org>
To:     linux-mips@vger.kernel.org
Subject: [PATCH 118/120] MIPS: PS2: Define the PlayStation 2 platform
Message-ID: <c0e5a1bfb9ed6f89025e6e4c8aa70979d83ae40f.1567326213.git.noring@nocrew.org>
References: <cover.1567326213.git.noring@nocrew.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1567326213.git.noring@nocrew.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-mips-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mips.vger.kernel.org>
X-Mailing-List: linux-mips@vger.kernel.org

Signed-off-by: Fredrik Noring <noring@nocrew.org>
---
 arch/mips/Kbuild.platforms |  1 +
 arch/mips/ps2/Makefile     |  1 +
 arch/mips/ps2/Platform     |  7 +++++++
 arch/mips/ps2/prom.c       | 18 ++++++++++++++++++
 4 files changed, 27 insertions(+)
 create mode 100644 arch/mips/ps2/Platform
 create mode 100644 arch/mips/ps2/prom.c

diff --git a/arch/mips/Kbuild.platforms b/arch/mips/Kbuild.platforms
index 0de839882106..84be263f44d2 100644
--- a/arch/mips/Kbuild.platforms
+++ b/arch/mips/Kbuild.platforms
@@ -24,6 +24,7 @@ platforms += netlogic
 platforms += paravirt
 platforms += pic32
 platforms += pistachio
+platforms += ps2
 platforms += pmcs-msp71xx
 platforms += pnx833x
 platforms += ralink
diff --git a/arch/mips/ps2/Makefile b/arch/mips/ps2/Makefile
index 925952a83625..dbc1bdbac2a8 100644
--- a/arch/mips/ps2/Makefile
+++ b/arch/mips/ps2/Makefile
@@ -4,6 +4,7 @@ obj-y		+= identify.o
 obj-y		+= intc-irq.o
 obj-y		+= irq.o
 obj-y		+= memory.o
+obj-y		+= prom.o
 obj-y		+= reboot.o
 obj-y		+= rom.o
 obj-m		+= rom-sysfs.o
diff --git a/arch/mips/ps2/Platform b/arch/mips/ps2/Platform
new file mode 100644
index 000000000000..5e9695f86b99
--- /dev/null
+++ b/arch/mips/ps2/Platform
@@ -0,0 +1,7 @@
+#
+# PlayStation 2
+#
+platform-$(CONFIG_SONY_PS2)	+= ps2/
+cflags-$(CONFIG_SONY_PS2)	+= -I$(srctree)/arch/mips/include/asm/mach-ps2
+load-$(CONFIG_SONY_PS2)		+= 0x80010000
+zload-$(CONFIG_SONY_PS2)	+= 0x00800000
diff --git a/arch/mips/ps2/prom.c b/arch/mips/ps2/prom.c
new file mode 100644
index 000000000000..f4d594c4457e
--- /dev/null
+++ b/arch/mips/ps2/prom.c
@@ -0,0 +1,18 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * PlayStation 2 PROM handling
+ */
+
+#include <linux/module.h>
+
+void prom_putchar(char c)
+{
+}
+
+void __init prom_init(void)
+{
+}
+
+void __init prom_free_prom_memory(void)
+{
+}
-- 
2.21.0

