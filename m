Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 24 May 2015 17:31:53 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:5834 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27006783AbbEXPbggz1k8 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 24 May 2015 17:31:36 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 8751A4274D16;
        Sun, 24 May 2015 16:31:30 +0100 (IST)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Sun, 24 May 2015 16:29:28 +0100
Received: from localhost (192.168.159.140) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.210.2; Sun, 24 May
 2015 16:29:17 +0100
From:   Paul Burton <paul.burton@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Paul Burton <paul.burton@imgtec.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Ralf Baechle <ralf@linux-mips.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v5 32/37] MIPS: JZ4740: only detect RAM size if not specified in DT
Date:   Sun, 24 May 2015 16:11:42 +0100
Message-ID: <1432480307-23789-33-git-send-email-paul.burton@imgtec.com>
X-Mailer: git-send-email 2.4.1
In-Reply-To: <1432480307-23789-1-git-send-email-paul.burton@imgtec.com>
References: <1432480307-23789-1-git-send-email-paul.burton@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.159.140]
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 47636
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: paul.burton@imgtec.com
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

Allow a devicetree to specify the memory present in the system rather
than probing it from the memory controller. This both saves the probing
for systems where the amount of memory is fixed, and will simplify the
bringup of later Ingenic SoCs where the memory controller register
layout differs.

Signed-off-by: Paul Burton <paul.burton@imgtec.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
---

Changes in v5: None
Changes in v4: None
Changes in v3:
- Rebase.

Changes in v2: None

 arch/mips/Kconfig         | 1 +
 arch/mips/jz4740/Makefile | 2 ++
 arch/mips/jz4740/setup.c  | 8 +++++++-
 3 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index e3c859c..f07a213 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -301,6 +301,7 @@ config MACH_INGENIC
 	select GENERIC_IRQ_CHIP
 	select BUILTIN_DTB
 	select USE_OF
+	select LIBFDT
 
 config LANTIQ
 	bool "Lantiq based platforms"
diff --git a/arch/mips/jz4740/Makefile b/arch/mips/jz4740/Makefile
index 7636432..70a9578 100644
--- a/arch/mips/jz4740/Makefile
+++ b/arch/mips/jz4740/Makefile
@@ -7,6 +7,8 @@
 obj-y += prom.o time.o reset.o setup.o \
 	gpio.o platform.o timer.o serial.o
 
+CFLAGS_setup.o = -I$(src)/../../../scripts/dtc/libfdt
+
 # board specific support
 
 obj-$(CONFIG_JZ4740_QI_LB60)	+= board-qi_lb60.o
diff --git a/arch/mips/jz4740/setup.c b/arch/mips/jz4740/setup.c
index 8c08d7d..1bed3cb 100644
--- a/arch/mips/jz4740/setup.c
+++ b/arch/mips/jz4740/setup.c
@@ -18,6 +18,7 @@
 #include <linux/io.h>
 #include <linux/irqchip.h>
 #include <linux/kernel.h>
+#include <linux/libfdt.h>
 #include <linux/of_fdt.h>
 #include <linux/of_platform.h>
 
@@ -55,9 +56,14 @@ static void __init jz4740_detect_mem(void)
 
 void __init plat_mem_setup(void)
 {
+	int offset;
+
 	jz4740_reset_init();
-	jz4740_detect_mem();
 	__dt_setup_arch(__dtb_start);
+
+	offset = fdt_path_offset(__dtb_start, "/memory");
+	if (offset < 0)
+		jz4740_detect_mem();
 }
 
 void __init device_tree_init(void)
-- 
2.4.1
