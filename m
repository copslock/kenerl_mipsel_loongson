Return-Path: <SRS0=OeKb=W4=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91145C3A5A4
	for <linux-mips@archiver.kernel.org>; Sun,  1 Sep 2019 15:55:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3EF962339D
	for <linux-mips@archiver.kernel.org>; Sun,  1 Sep 2019 15:55:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728616AbfIAPzf (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Sun, 1 Sep 2019 11:55:35 -0400
Received: from pio-pvt-msa3.bahnhof.se ([79.136.2.42]:42214 "EHLO
        pio-pvt-msa3.bahnhof.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725954AbfIAPze (ORCPT
        <rfc822;linux-mips@vger.kernel.org>); Sun, 1 Sep 2019 11:55:34 -0400
Received: from localhost (localhost [127.0.0.1])
        by pio-pvt-msa3.bahnhof.se (Postfix) with ESMTP id D18843F684
        for <linux-mips@vger.kernel.org>; Sun,  1 Sep 2019 17:55:33 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at bahnhof.se
Received: from pio-pvt-msa3.bahnhof.se ([127.0.0.1])
        by localhost (pio-pvt-msa3.bahnhof.se [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id bH-CMv7QFr-n for <linux-mips@vger.kernel.org>;
        Sun,  1 Sep 2019 17:55:33 +0200 (CEST)
Received: from localhost (h-41-252.A163.priv.bahnhof.se [46.59.41.252])
        (Authenticated sender: mb547485)
        by pio-pvt-msa3.bahnhof.se (Postfix) with ESMTPA id 356073F615
        for <linux-mips@vger.kernel.org>; Sun,  1 Sep 2019 17:55:33 +0200 (CEST)
Date:   Sun, 1 Sep 2019 17:55:33 +0200
From:   Fredrik Noring <noring@nocrew.org>
To:     linux-mips@vger.kernel.org
Subject: [PATCH 049/120] MIPS: PS2: Power off support
Message-ID: <f8961e0b92874c58c07951430d7b8d4899feb5b2.1567326213.git.noring@nocrew.org>
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
 arch/mips/ps2/Makefile |  1 +
 arch/mips/ps2/reboot.c | 29 +++++++++++++++++++++++++++++
 2 files changed, 30 insertions(+)
 create mode 100644 arch/mips/ps2/reboot.c

diff --git a/arch/mips/ps2/Makefile b/arch/mips/ps2/Makefile
index b53bddcc8c01..6f671112fbcb 100644
--- a/arch/mips/ps2/Makefile
+++ b/arch/mips/ps2/Makefile
@@ -3,6 +3,7 @@ obj-y		+= identify.o
 obj-y		+= intc-irq.o
 obj-y		+= irq.o
 obj-y		+= memory.o
+obj-y		+= reboot.o
 obj-y		+= rom.o
 obj-m		+= rom-sysfs.o
 obj-y		+= scmd.o
diff --git a/arch/mips/ps2/reboot.c b/arch/mips/ps2/reboot.c
new file mode 100644
index 000000000000..b2a3ada5268b
--- /dev/null
+++ b/arch/mips/ps2/reboot.c
@@ -0,0 +1,29 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * PlayStation 2 power off
+ *
+ * Copyright (C) 2019 Fredrik Noring
+ */
+
+#include <linux/init.h>
+#include <linux/pm.h>
+
+#include <asm/processor.h>
+#include <asm/reboot.h>
+
+#include <asm/mach-ps2/scmd.h>
+
+static void __noreturn power_off(void)
+{
+	scmd_power_off();
+
+	cpu_relax_forever();
+}
+
+static int __init ps2_init_reboot(void)
+{
+	pm_power_off = power_off;
+
+	return 0;
+}
+subsys_initcall(ps2_init_reboot);
-- 
2.21.0

