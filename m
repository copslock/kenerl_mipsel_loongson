Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 08 Feb 2017 02:59:07 +0100 (CET)
Received: from SMTPBG352.QQ.COM ([183.57.50.167]:57212 "EHLO smtpbg352.qq.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23992178AbdBHB6yN6gq2 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 8 Feb 2017 02:58:54 +0100
X-QQ-mid: bizesmtp3t1486519098tymr0p7la
Received: from software.domain.org (unknown [222.92.8.142])
        by esmtp4.qq.com (ESMTP) with 
        id ; Wed, 08 Feb 2017 09:58:18 +0800 (CST)
X-QQ-SSF: 01100000002000F0FH71B00A0000000
X-QQ-FEAT: r8geFCKg7naO2iaZt/cP9SI3Zp3X79feZJJvHnTBth7BI9ufBC1NrXZp2FB2P
        +YCzFns3Ygig9Hn7DC45G6n7BnAIS+CPpfFhawpE1uYzPJUarZWgx+XutngEL9adQkYQsGh
        v327DA6S0yU4lJgERFxMBk0fvChxTBDUhM4oV4Ekgealz7oigIM9zaRauS9ysZSY/r+y3HL
        3ORJRG79pkIrNsNnzOi3z6RPJJflewReaWX7qfc8gG9CVY10N0HCazB1MXGh6wao07XYeEK
        bAoxDC4xf01k4wGe7+sJXgZQwzIg3TOCIqng==
X-QQ-GoodBg: 0
From:   Binbin Zhou <zhoubb@lemote.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     John Crispin <john@phrozen.org>,
        "Steven J . Hill" <Steven.Hill@imgtec.com>,
        linux-mips@linux-mips.org, Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>,
        Kelvin Cheung <keguang.zhang@gmail.com>,
        Yang Ling <gnaygnil@gmail.com>,
        Binbin Zhou <zhoubb@lemote.com>,
        HuaCai Chen <chenhc@lemote.com>
Subject: [PATCH v5 6/8] MIPS: Loongson: Add Loongson-1A board support
Date:   Wed,  8 Feb 2017 09:57:47 +0800
Message-Id: <1486519069-9364-7-git-send-email-zhoubb@lemote.com>
X-Mailer: git-send-email 2.7.0
In-Reply-To: <1486519069-9364-1-git-send-email-zhoubb@lemote.com>
References: <1486519069-9364-1-git-send-email-zhoubb@lemote.com>
X-QQ-SENDSIZE: 520
Return-Path: <zhoubb@lemote.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56718
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
