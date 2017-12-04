Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 04 Dec 2017 10:25:21 +0100 (CET)
Received: from forward101p.mail.yandex.net ([IPv6:2a02:6b8:0:1472:2741:0:8b7:101]:37949
        "EHLO forward101p.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990410AbdLDJX5RNzYM (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 4 Dec 2017 10:23:57 +0100
Received: from mxback12j.mail.yandex.net (mxback12j.mail.yandex.net [IPv6:2a02:6b8:0:1619::87])
        by forward101p.mail.yandex.net (Yandex) with ESMTP id A0CB46A80D4D;
        Mon,  4 Dec 2017 12:23:48 +0300 (MSK)
Received: from smtp3p.mail.yandex.net (smtp3p.mail.yandex.net [2a02:6b8:0:1472:2741:0:8b6:8])
        by mxback12j.mail.yandex.net (nwsmtp/Yandex) with ESMTP id GiMpTJDMep-Nk90T5iX;
        Mon, 04 Dec 2017 12:23:47 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; s=mail; t=1512379427;
        bh=JffbL3OKsZ5EgD+y4JOXLvIEr8/hCd/M1itAcWjj/vg=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References;
        b=kW+As9oxENULhn6SBLcwXmu4usYsNTlU5wAP6bi1awW51EnITm8LmggllTwoq3rjT
         JjLfPJcyupCN5iVhbxWL3woWVDhd93bde1s1r4n0wqo5xO5CHp0fCyxyBWjJ/Kbc5a
         D2vFe9wwt3EB21PcF8xG6LAeFb95JC2Bl2et+hSg=
Received: by smtp3p.mail.yandex.net (nwsmtp/Yandex) with ESMTPSA id 99BorI3ZLs-NhPSLm1Z;
        Mon, 04 Dec 2017 12:23:45 +0300
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client certificate not present)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; s=mail; t=1512379426;
        bh=JffbL3OKsZ5EgD+y4JOXLvIEr8/hCd/M1itAcWjj/vg=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References;
        b=lF0CT0n1QaBPiKvl8Saag6I7yhpTrWhdXGiGB/yMswkLEsFgtbIKvJ6JwqwIHaIkk
         bx2jHYprfVRlvuYU2ZXuDfOA1n/PrdEDxITEq907FspyIMQXq/9Z2rvt7vKFtBoN6H
         M38zjjGDW7wPj8Kll2npDOh1kxiFlxT7De04G0V4=
Authentication-Results: smtp3p.mail.yandex.net; dkim=pass header.i=@flygoat.com
From:   Jiaxun Yang <jiaxun.yang@flygoat.com>
To:     James Hogan <james.hogan@mips.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org, Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: [PATCH RESEND v3 4/4] MIPS: Loongson64: Load platform device during boot
Date:   Mon,  4 Dec 2017 17:23:12 +0800
Message-Id: <20171204092312.11256-5-jiaxun.yang@flygoat.com>
X-Mailer: git-send-email 2.15.0
In-Reply-To: <20171204092312.11256-1-jiaxun.yang@flygoat.com>
References: <20171204092312.11256-1-jiaxun.yang@flygoat.com>
Return-Path: <jiaxun.yang@flygoat.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 61286
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jiaxun.yang@flygoat.com
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

This patch just add pdev during boot to load the platform driver

Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
---
 arch/mips/loongson64/lemote-2f/Makefile   |  2 +-
 arch/mips/loongson64/lemote-2f/platform.c | 27 +++++++++++++++++++++++++++
 2 files changed, 28 insertions(+), 1 deletion(-)
 create mode 100644 arch/mips/loongson64/lemote-2f/platform.c

diff --git a/arch/mips/loongson64/lemote-2f/Makefile b/arch/mips/loongson64/lemote-2f/Makefile
index 08b8abcbfef5..31c90737b98c 100644
--- a/arch/mips/loongson64/lemote-2f/Makefile
+++ b/arch/mips/loongson64/lemote-2f/Makefile
@@ -2,7 +2,7 @@
 # Makefile for lemote loongson2f family machines
 #
 
-obj-y += clock.o machtype.o irq.o reset.o ec_kb3310b.o
+obj-y += clock.o machtype.o irq.o reset.o ec_kb3310b.o platform.o
 
 #
 # Suspend Support
diff --git a/arch/mips/loongson64/lemote-2f/platform.c b/arch/mips/loongson64/lemote-2f/platform.c
new file mode 100644
index 000000000000..46922f730a64
--- /dev/null
+++ b/arch/mips/loongson64/lemote-2f/platform.c
@@ -0,0 +1,27 @@
+/*
+ * Copyright (C) 2017 Jiaxun Yang.
+ * Author: Jiaxun Yang, jiaxun.yang@flygoat.com
+
+ * Copyright (C) 2009 Lemote Inc.
+ * Author: Wu Zhangjin, wuzhangjin@gmail.com
+ *
+ * This program is free software; you can redistribute  it and/or modify it
+ * under  the terms of  the GNU General  Public License as published by the
+ * Free Software Foundation;  either version 2 of the  License, or (at your
+ * option) any later version.
+ */
+
+#include <linux/err.h>
+#include <linux/platform_device.h>
+
+#include <asm/bootinfo.h>
+
+static int __init lemote2f_platform_init(void)
+{
+	if (mips_machtype != MACH_LEMOTE_YL2F89)
+		return -ENODEV;
+
+	return platform_device_register_simple("yeeloong_laptop", -1, NULL, 0);
+}
+
+arch_initcall(lemote2f_platform_init);
\ No newline at end of file
-- 
2.15.0
