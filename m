Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 14 Nov 2017 02:28:56 +0100 (CET)
Received: from forward105p.mail.yandex.net ([77.88.28.108]:52155 "EHLO
        forward105p.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990436AbdKNB1zjFhFW (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 14 Nov 2017 02:27:55 +0100
Received: from mxback10o.mail.yandex.net (mxback10o.mail.yandex.net [IPv6:2a02:6b8:0:1a2d::24])
        by forward105p.mail.yandex.net (Yandex) with ESMTP id EF6FF4081E22;
        Tue, 14 Nov 2017 04:27:49 +0300 (MSK)
Received: from smtp4j.mail.yandex.net (smtp4j.mail.yandex.net [2a02:6b8:0:1619::15:6])
        by mxback10o.mail.yandex.net (nwsmtp/Yandex) with ESMTP id OzAI0f1goB-Rn2ikAdc;
        Tue, 14 Nov 2017 04:27:49 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; s=mail; t=1510622869;
        bh=kSArB5RwVrVE0eWZKFqvfrGVxCjShAZRswKa/+N+q3Q=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References;
        b=E81DVs9ycsV9drnpxlZ359B9DYTn+E5RTV2f+rrKFK8nSEBIIgKG5Ot7SM7rOckAz
         hd947apzcex79e9NoMxlY2+Y0wAtTHnCQRXd1K42/UtwaQET0uATDIhSPQ87vIMtLY
         aVqZRRIf8/hKv2smJK958naK47EqOXVxesLQeJdo=
Received: by smtp4j.mail.yandex.net (nwsmtp/Yandex) with ESMTPSA id 7l823DlZ0a-RjhqqLeI;
        Tue, 14 Nov 2017 04:27:48 +0300
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client certificate not present)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; s=mail; t=1510622869;
        bh=kSArB5RwVrVE0eWZKFqvfrGVxCjShAZRswKa/+N+q3Q=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References;
        b=E81DVs9ycsV9drnpxlZ359B9DYTn+E5RTV2f+rrKFK8nSEBIIgKG5Ot7SM7rOckAz
         hd947apzcex79e9NoMxlY2+Y0wAtTHnCQRXd1K42/UtwaQET0uATDIhSPQ87vIMtLY
         aVqZRRIf8/hKv2smJK958naK47EqOXVxesLQeJdo=
Authentication-Results: smtp4j.mail.yandex.net; dkim=pass header.i=@flygoat.com
From:   Jiaxun Yang <jiaxun.yang@flygoat.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
        Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: [PATCH v2 4/4] MIPS: Loongson64: Load platform device during boot
Date:   Tue, 14 Nov 2017 09:26:49 +0800
Message-Id: <20171114012649.29625-4-jiaxun.yang@flygoat.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20171114012649.29625-1-jiaxun.yang@flygoat.com>
References: <20171114012649.29625-1-jiaxun.yang@flygoat.com>
Return-Path: <jiaxun.yang@flygoat.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60890
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
