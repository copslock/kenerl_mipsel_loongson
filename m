Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 04 Feb 2015 16:27:20 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:4290 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27012488AbbBDPWlnHQam (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 4 Feb 2015 16:22:41 +0100
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id AE220FDE1F16B;
        Wed,  4 Feb 2015 15:22:38 +0000 (GMT)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Wed, 4 Feb 2015 15:22:41 +0000
Received: from zkakakhel-linux.le.imgtec.org (192.168.154.89) by
 LEMAIL01.le.imgtec.org (192.168.152.62) with Microsoft SMTP Server (TLS) id
 14.3.210.2; Wed, 4 Feb 2015 15:22:40 +0000
From:   Zubair Lutfullah Kakakhel <Zubair.Kakakhel@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     <devicetree@vger.kernel.org>, <linux-serial@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <Zubair.Kakakhel@imgtec.com>,
        <gregkh@linuxfoundation.org>, <mturquette@linaro.org>,
        <sboyd@codeaurora.org>, <ralf@linux-mips.org>, <jslaby@suse.cz>,
        <tglx@linutronix.de>, <jason@lakedaemon.net>, <lars@metafoo.de>,
        <paul.burton@imgtec.com>
Subject: [PATCH_V2 21/34] MIPS: jz4740: only detect RAM size if not specified in DT
Date:   Wed, 4 Feb 2015 15:21:50 +0000
Message-ID: <1423063323-19419-22-git-send-email-Zubair.Kakakhel@imgtec.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1423063323-19419-1-git-send-email-Zubair.Kakakhel@imgtec.com>
References: <1423063323-19419-1-git-send-email-Zubair.Kakakhel@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.154.89]
Return-Path: <Zubair.Kakakhel@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 45670
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Zubair.Kakakhel@imgtec.com
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

From: Paul Burton <paul.burton@imgtec.com>

Allow a devicetree to specify the memory present in the system rather
than probing it from the memory controller. This both saves the probing
for systems where the amount of memory is fixed, and will simplify the
bringup of later jz47xx series SoCs where the memory controller register
layout differs.

Signed-off-by: Paul Burton <paul.burton@imgtec.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>
---
 arch/mips/Kconfig         | 1 +
 arch/mips/jz4740/Makefile | 2 ++
 arch/mips/jz4740/setup.c  | 8 +++++++-
 3 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 8b377a7..ef82cd3 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -290,6 +290,7 @@ config MACH_JZ4740
 	select GENERIC_IRQ_CHIP
 	select BUILTIN_DTB
 	select USE_OF
+	select LIBFDT
 
 config LANTIQ
 	bool "Lantiq based platforms"
diff --git a/arch/mips/jz4740/Makefile b/arch/mips/jz4740/Makefile
index 61168a2..340dc16 100644
--- a/arch/mips/jz4740/Makefile
+++ b/arch/mips/jz4740/Makefile
@@ -7,6 +7,8 @@
 obj-y += prom.o irq.o time.o reset.o setup.o \
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
1.9.1
