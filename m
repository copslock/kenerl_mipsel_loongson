Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 23 Nov 2016 14:47:45 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:12182 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23993048AbcKWNoKE4tQG (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 23 Nov 2016 14:44:10 +0100
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id D4FAB84ED53E6;
        Wed, 23 Nov 2016 13:44:00 +0000 (GMT)
Received: from WR-NOWAKOWSKI.kl.imgtec.org (10.80.2.5) by
 HHMAIL01.hh.imgtec.org (10.100.10.21) with Microsoft SMTP Server (TLS) id
 14.3.294.0; Wed, 23 Nov 2016 13:44:03 +0000
From:   Marcin Nowakowski <marcin.nowakowski@imgtec.com>
To:     Ralf Baechle <ralf@linux-mips.org>, <linux-mips@linux-mips.org>
Subject: [PATCH 10/10] MIPS: generic/kexec: add support for a DTB passed in a separate buffer
Date:   Wed, 23 Nov 2016 14:43:52 +0100
Message-ID: <1479908632-30392-11-git-send-email-marcin.nowakowski@imgtec.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1479908632-30392-1-git-send-email-marcin.nowakowski@imgtec.com>
References: <1479908632-30392-1-git-send-email-marcin.nowakowski@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.2.5]
Return-Path: <Marcin.Nowakowski@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 55880
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: marcin.nowakowski@imgtec.com
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

Signed-off-by: Marcin Nowakowski <marcin.nowakowski@imgtec.com>
---
 arch/mips/generic/Makefile |  1 +
 arch/mips/generic/kexec.c  | 45 +++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 46 insertions(+)
 create mode 100644 arch/mips/generic/kexec.c

diff --git a/arch/mips/generic/Makefile b/arch/mips/generic/Makefile
index 7c66494..acb9b6d 100644
--- a/arch/mips/generic/Makefile
+++ b/arch/mips/generic/Makefile
@@ -13,3 +13,4 @@ obj-y += irq.o
 obj-y += proc.o
 
 obj-$(CONFIG_LEGACY_BOARD_SEAD3)	+= board-sead3.o
+obj-$(CONFIG_KEXEC)			+= kexec.o
diff --git a/arch/mips/generic/kexec.c b/arch/mips/generic/kexec.c
new file mode 100644
index 0000000..61f812b
--- /dev/null
+++ b/arch/mips/generic/kexec.c
@@ -0,0 +1,45 @@
+/*
+ * Copyright (C) 2016 Imagination Technologies
+ * Author: Marcin Nowakowski <marcin.nowakowski@imgtec.com>
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License as published by the
+ * Free Software Foundation; either version 2 of the License, or (at your
+ * option) any later version.
+ */
+
+#include <linux/kexec.h>
+#include <linux/libfdt.h>
+#include <linux/uaccess.h>
+
+static int generic_kexec_prepare(struct kimage *image)
+{
+	int i;
+
+	for (i = 0; i < image->nr_segments; i++) {
+		struct fdt_header fdt;
+
+		if (image->segment[i].memsz <= sizeof(fdt))
+			continue;
+
+		if (copy_from_user(&fdt, image->segment[i].buf, sizeof(fdt)))
+			continue;
+
+		if (fdt_check_header(&fdt))
+			continue;
+
+		kexec_args[0] = -2;
+		kexec_args[1] = (unsigned long)
+			phys_to_virt((unsigned long)image->segment[i].mem);
+		break;
+	}
+	return 0;
+}
+
+static int __init register_generic_kexec(void)
+{
+	_machine_kexec_prepare = generic_kexec_prepare;
+	return 0;
+}
+arch_initcall(register_generic_kexec);
+
-- 
2.7.4
