Return-Path: <SRS0=OeKb=W4=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22189C3A5A7
	for <linux-mips@archiver.kernel.org>; Sun,  1 Sep 2019 15:46:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 026C221897
	for <linux-mips@archiver.kernel.org>; Sun,  1 Sep 2019 15:46:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728980AbfIAPq5 (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Sun, 1 Sep 2019 11:46:57 -0400
Received: from pio-pvt-msa1.bahnhof.se ([79.136.2.40]:56630 "EHLO
        pio-pvt-msa1.bahnhof.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728900AbfIAPq5 (ORCPT
        <rfc822;linux-mips@vger.kernel.org>); Sun, 1 Sep 2019 11:46:57 -0400
Received: from localhost (localhost [127.0.0.1])
        by pio-pvt-msa1.bahnhof.se (Postfix) with ESMTP id 8D67240F37
        for <linux-mips@vger.kernel.org>; Sun,  1 Sep 2019 17:46:55 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at bahnhof.se
Received: from pio-pvt-msa1.bahnhof.se ([127.0.0.1])
        by localhost (pio-pvt-msa1.bahnhof.se [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id Kho4OY3DZPGg for <linux-mips@vger.kernel.org>;
        Sun,  1 Sep 2019 17:46:54 +0200 (CEST)
Received: from localhost (h-41-252.A163.priv.bahnhof.se [46.59.41.252])
        (Authenticated sender: mb547485)
        by pio-pvt-msa1.bahnhof.se (Postfix) with ESMTPA id E209740C35
        for <linux-mips@vger.kernel.org>; Sun,  1 Sep 2019 17:46:54 +0200 (CEST)
Date:   Sun, 1 Sep 2019 17:46:54 +0200
From:   Fredrik Noring <noring@nocrew.org>
To:     linux-mips@vger.kernel.org
Subject: [PATCH 024/120] MIPS: PS2: Define PlayStation 2 I/O port, ROM and
 RAM address spaces
Message-ID: <c7147838400b6c5e181c000c48f51e5348d02b64.1567326213.git.noring@nocrew.org>
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
 arch/mips/include/asm/mach-ps2/rom.h | 17 +++++++++++++++++
 arch/mips/ps2/Makefile               |  1 +
 arch/mips/ps2/memory.c               | 27 +++++++++++++++++++++++++++
 3 files changed, 45 insertions(+)
 create mode 100644 arch/mips/include/asm/mach-ps2/rom.h
 create mode 100644 arch/mips/ps2/Makefile
 create mode 100644 arch/mips/ps2/memory.c

diff --git a/arch/mips/include/asm/mach-ps2/rom.h b/arch/mips/include/asm/mach-ps2/rom.h
new file mode 100644
index 000000000000..6760be183696
--- /dev/null
+++ b/arch/mips/include/asm/mach-ps2/rom.h
@@ -0,0 +1,17 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * PlayStation 2 read-only memory (ROM)
+ *
+ * Copyright (C) 2019 Fredrik Noring
+ */
+
+#ifndef __ASM_MACH_PS2_ROM_H
+#define __ASM_MACH_PS2_ROM_H
+
+#define ROM0_BASE	0x1fc00000	/* ROM0 base address (boot) */
+#define ROM0_SIZE	0x400000	/* ROM0 maximum size */
+
+#define ROM1_BASE	0x1e000000	/* ROM1 base address (DVD) */
+#define ROM1_SIZE	0x100000	/* ROM1 maximum size */
+
+#endif /* __ASM_MACH_PS2_ROM_H */
diff --git a/arch/mips/ps2/Makefile b/arch/mips/ps2/Makefile
new file mode 100644
index 000000000000..24d537d2fb9f
--- /dev/null
+++ b/arch/mips/ps2/Makefile
@@ -0,0 +1 @@
+obj-y		+= memory.o
diff --git a/arch/mips/ps2/memory.c b/arch/mips/ps2/memory.c
new file mode 100644
index 000000000000..66ca37f38330
--- /dev/null
+++ b/arch/mips/ps2/memory.c
@@ -0,0 +1,27 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * PlayStation 2 memory
+ *
+ * Copyright (C) 2019 Fredrik Noring
+ */
+
+#include <linux/init.h>
+#include <linux/ioport.h>
+#include <linux/types.h>
+
+#include <asm/bootinfo.h>
+
+void __init plat_mem_setup(void)
+{
+	ioport_resource.start = 0x10000000;
+	ioport_resource.end   = 0x1fffffff;
+
+	iomem_resource.start = 0x00000000;
+	iomem_resource.end   = KSEG2 - 1;
+
+	add_memory_region(0x00000000, 0x02000000, BOOT_MEM_RAM);
+	add_memory_region(ROM0_BASE, ROM0_SIZE, BOOT_MEM_ROM_DATA);
+	add_memory_region(ROM1_BASE, ROM1_SIZE, BOOT_MEM_ROM_DATA);
+
+	set_io_port_base(CKSEG1);	/* KSEG1 is uncached */
+}
-- 
2.21.0

