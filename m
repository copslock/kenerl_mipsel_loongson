Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 16 Feb 2017 10:14:40 +0100 (CET)
Received: from SMTPBG252.QQ.COM ([183.60.52.105]:36025 "EHLO smtpbg252.qq.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23991932AbdBPJNxJCBiN (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 16 Feb 2017 10:13:53 +0100
X-QQ-mid: bizesmtp1t1487236402ti94n168j
Received: from software.domain.org (unknown [222.92.8.142])
        by esmtp4.qq.com (ESMTP) with 
        id ; Thu, 16 Feb 2017 17:13:21 +0800 (CST)
X-QQ-SSF: 01100000002000F0FH61B00A0000000
X-QQ-FEAT: mAJfWfDYrJPNunW2KwA9d+z8aBnQmD/uJyuu3Ouq7yEnJbv+NGzw2BFwSgmE4
        dvbz6esjHWlypVusDCr/h/68igI2L03fCsa+fMLTLU+e02qrtRu3PPIeJPmhXqjYEg1WnQ4
        E5BIa5O9nuc+Hv+kka736O7/bxERtcGYgqovai+kLRAY43ivkVFfMHRvXrMLJarxL6/OGWm
        VbgvhMsAIIBvvOhUREpHWK3grJrZXloHJ33ulzlHrJa1p6mAPP23jHPC7WTajBtwwNnVq7I
        T13INzLRKZQBZ4Zllye6LRsC7TkApzgKUuZwHGj/rBoogbojHlBXHU8mE=
X-QQ-GoodBg: 0
From:   Binbin Zhou <zhoubb@lemote.com>
To:     Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <james.hogan@imgtec.com>
Cc:     John Crispin <john@phrozen.org>,
        "Steven J . Hill" <Steven.Hill@imgtec.com>,
        Aurelien Jarno <aurelien@aurel32.net>,
        Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>,
        Kelvin Cheung <keguang.zhang@gmail.com>,
        Yang Ling <gnaygnil@gmail.com>,
        =?UTF-8?q?=E8=B0=A2=E8=87=B4=E9=82=A6?= <Yeking@Red54.com>,
        linux-mips@linux-mips.org, Binbin Zhou <zhoubb@lemote.com>,
        HuaCai Chen <chenhc@lemote.com>
Subject: [PATCH RESEND v5 6/8] MIPS: Loongson: Add Loongson-1A board support
Date:   Thu, 16 Feb 2017 17:13:19 +0800
Message-Id: <1487236401-3071-7-git-send-email-zhoubb@lemote.com>
X-Mailer: git-send-email 2.7.0
In-Reply-To: <1487236401-3071-1-git-send-email-zhoubb@lemote.com>
References: <1487236401-3071-1-git-send-email-zhoubb@lemote.com>
X-QQ-SENDSIZE: 520
Return-Path: <zhoubb@lemote.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56840
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: zhoubb@lemote.com
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

Register basic devices for Loongson-1A, and setup clk for UART.

Signed-off-by: Binbin Zhou <zhoubb@lemote.com>
Signed-off-by: HuaCai Chen <chenhc@lemote.com>
---
 arch/mips/loongson32/Makefile      |  6 ++++++
 arch/mips/loongson32/ls1a/Makefile |  5 +++++
 arch/mips/loongson32/ls1a/board.c  | 31 +++++++++++++++++++++++++++++++
 3 files changed, 42 insertions(+)
 create mode 100644 arch/mips/loongson32/ls1a/Makefile
 create mode 100644 arch/mips/loongson32/ls1a/board.c

diff --git a/arch/mips/loongson32/Makefile b/arch/mips/loongson32/Makefile
index 1ab2c5b..cd1f597 100644
--- a/arch/mips/loongson32/Makefile
+++ b/arch/mips/loongson32/Makefile
@@ -5,6 +5,12 @@
 obj-$(CONFIG_MACH_LOONGSON32) += common/
 
 #
+# Loongson LS1A board
+#
+
+obj-$(CONFIG_LOONGSON1_LS1A)  += ls1a/
+
+#
 # Loongson LS1B board
 #
 
diff --git a/arch/mips/loongson32/ls1a/Makefile b/arch/mips/loongson32/ls1a/Makefile
new file mode 100644
index 0000000..dc23a9a
--- /dev/null
+++ b/arch/mips/loongson32/ls1a/Makefile
@@ -0,0 +1,5 @@
+#
+# Makefile for loongson1A based machines.
+#
+
+obj-y += board.o
diff --git a/arch/mips/loongson32/ls1a/board.c b/arch/mips/loongson32/ls1a/board.c
new file mode 100644
index 0000000..7993f6c
--- /dev/null
+++ b/arch/mips/loongson32/ls1a/board.c
@@ -0,0 +1,31 @@
+/*
+ * Copyright (c) 2016 Binbin Zhou <zhoubb@lemote.com>
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License as published by the
+ * Free Software Foundation; either version 2 of the License, or (at your
+ * option) any later version.
+ */
+
+#include <platform.h>
+
+static struct platform_device *ls1a_platform_devices[] __initdata = {
+	&ls1x_uart_pdev,
+	&ls1x_eth0_pdev,
+	&ls1x_eth1_pdev,
+	&ls1x_rtc_pdev,
+	&ls1x_wdt_pdev,
+	&ls1x_ahci_pdev,
+	&ls1x_ohci_pdev,
+};
+
+static int __init ls1a_platform_init(void)
+{
+	ls1x_serial_set_uartclk(&ls1x_uart_pdev);
+	ls1x_rtc_set_extclk(&ls1x_rtc_pdev);
+
+	return platform_add_devices(ls1a_platform_devices,
+				   ARRAY_SIZE(ls1a_platform_devices));
+}
+
+arch_initcall(ls1a_platform_init);
-- 
2.9.3
