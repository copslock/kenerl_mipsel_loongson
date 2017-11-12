Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 12 Nov 2017 07:38:23 +0100 (CET)
Received: from forward101j.mail.yandex.net ([IPv6:2a02:6b8:0:801:2::101]:42234
        "EHLO forward101j.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990513AbdKLGhK2BlnX (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 12 Nov 2017 07:37:10 +0100
Received: from mxback10g.mail.yandex.net (mxback10g.mail.yandex.net [IPv6:2a02:6b8:0:1472:2741:0:8b7:171])
        by forward101j.mail.yandex.net (Yandex) with ESMTP id B111B12436ED;
        Sun, 12 Nov 2017 09:37:04 +0300 (MSK)
Received: from smtp1p.mail.yandex.net (smtp1p.mail.yandex.net [2a02:6b8:0:1472:2741:0:8b6:6])
        by mxback10g.mail.yandex.net (nwsmtp/Yandex) with ESMTP id UzWTLKuelQ-b4xOWSdu;
        Sun, 12 Nov 2017 09:37:04 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; s=mail; t=1510468624;
        bh=uGonCiff3obAsU//+GriYfJlaKB//dL+X8iBlx5SFwA=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References;
        b=PbxJ+M6eXNoxq3rkfYy83s0Vy+7t2Hm4LhHDIkEV9rt3SVirHN3NW6O8+dS6Qggzl
         cn+UVH8ki3gN4pCIQniyIy6bPUA8Yzn3ryjuEHq2Pty7PxYtOcYb3OzzPxqcbAYZkD
         PVKZchhqqk+6d9CqUrbm16eN7P16jiBqv6xuwrYk=
Received: by smtp1p.mail.yandex.net (nwsmtp/Yandex) with ESMTPSA id 0pMwdlaAMA-b1ZuO4gG;
        Sun, 12 Nov 2017 09:37:03 +0300
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client certificate not present)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; s=mail; t=1510468624;
        bh=uGonCiff3obAsU//+GriYfJlaKB//dL+X8iBlx5SFwA=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References;
        b=PbxJ+M6eXNoxq3rkfYy83s0Vy+7t2Hm4LhHDIkEV9rt3SVirHN3NW6O8+dS6Qggzl
         cn+UVH8ki3gN4pCIQniyIy6bPUA8Yzn3ryjuEHq2Pty7PxYtOcYb3OzzPxqcbAYZkD
         PVKZchhqqk+6d9CqUrbm16eN7P16jiBqv6xuwrYk=
Authentication-Results: smtp1p.mail.yandex.net; dkim=pass header.i=@flygoat.com
From:   jiaxun.yang@flygoat.com
To:     ralf@linux-mips.org
Cc:     linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
        Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: [PATCH 4/4] MIPS: Loongson64: Load platform device during boot This patch just add pdev during boot to load the platform driver
Date:   Sun, 12 Nov 2017 14:36:17 +0800
Message-Id: <20171112063617.26546-4-jiaxun.yang@flygoat.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20171112063617.26546-1-jiaxun.yang@flygoat.com>
References: <20171112063617.26546-1-jiaxun.yang@flygoat.com>
Return-Path: <jiaxun.yang@flygoat.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60841
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

From: Jiaxun Yang <jiaxun.yang@flygoat.com>

Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
---
 arch/mips/loongson64/lemote-2f/Makefile   |  2 +-
 arch/mips/loongson64/lemote-2f/platform.c | 45 +++++++++++++++++++++++++++++++
 2 files changed, 46 insertions(+), 1 deletion(-)
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
index 000000000000..c36efcccb9a9
--- /dev/null
+++ b/arch/mips/loongson64/lemote-2f/platform.c
@@ -0,0 +1,45 @@
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
+static struct platform_device yeeloong_pdev = {
+	.name = "yeeloong_laptop",
+	.id = -1,
+};
+
+
+static int __init lemote2f_platform_init(void)
+{
+	struct platform_device *pdev = NULL;
+
+	switch (mips_machtype) {
+	case MACH_LEMOTE_YL2F89:
+		pdev = &yeeloong_pdev;
+		break;
+
+	default:
+		break;
+
+	}
+
+	if (pdev != NULL)
+		return platform_device_register(pdev);
+
+	return -ENODEV;
+}
+
+arch_initcall(lemote2f_platform_init);
-- 
2.14.1
