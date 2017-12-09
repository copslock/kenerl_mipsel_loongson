Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 09 Dec 2017 07:52:19 +0100 (CET)
Received: from forward104p.mail.yandex.net ([77.88.28.107]:33959 "EHLO
        forward104p.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990508AbdLIGupL895O (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 9 Dec 2017 07:50:45 +0100
Received: from mxback8j.mail.yandex.net (mxback8j.mail.yandex.net [IPv6:2a02:6b8:0:1619::111])
        by forward104p.mail.yandex.net (Yandex) with ESMTP id B8CA2183C0A;
        Sat,  9 Dec 2017 09:50:39 +0300 (MSK)
Received: from smtp3o.mail.yandex.net (smtp3o.mail.yandex.net [2a02:6b8:0:1a2d::27])
        by mxback8j.mail.yandex.net (nwsmtp/Yandex) with ESMTP id 5X7RM8vCBp-odkqKM65;
        Sat, 09 Dec 2017 09:50:39 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; s=mail; t=1512802239;
        bh=seLlQXE+rGngYPAW7VMtOoVoLGDbRswfjcv+qBOQ8p8=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References;
        b=TGNZYxON5nBPUDFuJjchz8oDeRs1QNYw23Hb8c7J93arsuCtvy6+b+EQz5nBEUAlO
         RBKORD6KOnWbKjbqPRBGT6EgLsHS+TRZ3xrDR726tZXb0KD1OH65IlLoFfjNyMMEh4
         ALeGuuYxnQx/BiVVs49eqkeooN/S36pqf0atDmRE=
Received: by smtp3o.mail.yandex.net (nwsmtp/Yandex) with ESMTPSA id jBC3v0GG1J-oap4twBR;
        Sat, 09 Dec 2017 09:50:38 +0300
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client certificate not present)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; s=mail; t=1512802238;
        bh=seLlQXE+rGngYPAW7VMtOoVoLGDbRswfjcv+qBOQ8p8=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References;
        b=R54VJo7QUXplO2uoTgDvhuD2uBmJFXzpkuDtop+BmbGWDljQSyXQNiDspDLrbSw1J
         dCGhnsyBQrkrXjzvW279IGDg24mqlRI9rW2E/ivyWLMNFUh3QFij4hjzVKAeXYUCLW
         UXtiRp05fVO1Fgk811gSkZFSLiihTAqcAxxrmKmo=
Authentication-Results: smtp3o.mail.yandex.net; dkim=pass header.i=@flygoat.com
From:   Jiaxun Yang <jiaxun.yang@flygoat.com>
To:     James Hogan <james.hogan@mips.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org, Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: [PATCH v4 4/5] MIPS: Loongson64: Load platform device during boot
Date:   Sat,  9 Dec 2017 14:49:52 +0800
Message-Id: <20171209064953.8984-5-jiaxun.yang@flygoat.com>
X-Mailer: git-send-email 2.15.0
In-Reply-To: <20171209064953.8984-1-jiaxun.yang@flygoat.com>
References: <20171209064953.8984-1-jiaxun.yang@flygoat.com>
Return-Path: <jiaxun.yang@flygoat.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 61388
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
 arch/mips/loongson64/lemote-2f/platform.c | 29 +++++++++++++++++++++++++++++
 2 files changed, 30 insertions(+), 1 deletion(-)
 create mode 100755 arch/mips/loongson64/lemote-2f/platform.c

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
new file mode 100755
index 000000000000..c7de7d621075
--- /dev/null
+++ b/arch/mips/loongson64/lemote-2f/platform.c
@@ -0,0 +1,29 @@
+/*
+ * Copyright (C) 2017 Jiaxun Yang.
+ * Author: Jiaxun Yang, jiaxun.yang@flygoat.com
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
+static int __init lemote2f_platform_init(void)
+{
+	if (mips_machtype != MACH_LEMOTE_YL2F89)
+		return -ENODEV;
+	
+	return platform_device_register(&yeeloong_pdev);
+}
+
+arch_initcall(lemote2f_platform_init);
-- 
2.15.0
