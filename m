Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 29 Aug 2017 10:40:43 +0200 (CEST)
Received: from SMTPBG352.QQ.COM ([183.57.50.167]:36165 "EHLO smtpbg352.qq.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23994915AbdH2IiyX0edD (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 29 Aug 2017 10:38:54 +0200
X-QQ-mid: bizesmtp5t1503995881tc62rka0c
Received: from software.domain.org (unknown [222.92.8.142])
        by esmtp4.qq.com (ESMTP) with 
        id ; Tue, 29 Aug 2017 16:38:00 +0800 (CST)
X-QQ-SSF: 01100000008000F0FJF1B00A0000000
X-QQ-FEAT: sbrYme1FedzHaqidAQN1u0H/dnXk/QoDalhKkI9tU0GO2UKSgodlWZL8h/zul
        kvniibmWXevuwVrUvV/2lhExlxZx9sfeC/c2tv9IDmF/gotBmsHqhOIoXh9ttlrGJine+ym
        bFpEt0w13x4CeFUS+Tw0FdGk6xM7OotQTgjkoY9ZMxBNu49Ob3xHSLJ5mS6pOAu2gvHq0F3
        BJuXYWZOd3SE6ynFX2r6coA2NNXuCXKYZrDat16Xek8NpYMNF8hDk6uqzijzEiDOS3zwCXg
        BvC3yINgoTE70XcGhxaoc3hRjmdrI1SLS/V1bcqW5xhH7eRgBkDODKoEY=
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
        Stephen Boyd <sboyd@codeaurora.org>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-mips@linux-mips.org, linux-clk@vger.kernel.org,
        Binbin Zhou <zhoubb@lemote.com>,
        HuaCai Chen <chenhc@lemote.com>
Subject: [PATCH RESEND v8 6/9] MIPS: Loongson: Add Loongson-1A board support
Date:   Tue, 29 Aug 2017 16:38:43 +0800
Message-Id: <1503995926-17125-7-git-send-email-zhoubb@lemote.com>
X-Mailer: git-send-email 2.7.0
In-Reply-To: <1503995926-17125-1-git-send-email-zhoubb@lemote.com>
References: <1503995926-17125-1-git-send-email-zhoubb@lemote.com>
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:lemote.com:qybgweb:qybgweb7
Return-Path: <zhoubb@lemote.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 59848
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
2.9.4
