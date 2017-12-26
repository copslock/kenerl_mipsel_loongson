Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 26 Dec 2017 04:27:38 +0100 (CET)
Received: from forward105o.mail.yandex.net ([37.140.190.183]:46253 "EHLO
        forward105o.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990431AbdLZD0jGzxh0 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 26 Dec 2017 04:26:39 +0100
Received: from mxback1g.mail.yandex.net (mxback1g.mail.yandex.net [IPv6:2a02:6b8:0:1472:2741:0:8b7:162])
        by forward105o.mail.yandex.net (Yandex) with ESMTP id 4E02D4442447;
        Tue, 26 Dec 2017 06:26:33 +0300 (MSK)
Received: from smtp4j.mail.yandex.net (smtp4j.mail.yandex.net [2a02:6b8:0:1619::15:6])
        by mxback1g.mail.yandex.net (nwsmtp/Yandex) with ESMTP id kV5BuIonMt-QWMG3Uev;
        Tue, 26 Dec 2017 06:26:33 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; s=mail; t=1514258793;
        bh=aPA6/1k3cImsoKuCsCQ2uNIp5izZ/Sl8+W3iDTE3QKc=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References;
        b=ry0WJaGybCs/SDrnc2vHcMXO8xjNfZIYYH0ZhX82HeBoI3XpyrRoAPhWbX/orzo/F
         7x/+KFyU8E8v9fiAWENinp4dDHJeqigGOH9PyEHPidGM0Zw6uTrXlSITJcaPOAqp5w
         P8of9GbSRdcFpIFF1oQRWqBBbpOPgrzM8YTOJAWg=
Received: by smtp4j.mail.yandex.net (nwsmtp/Yandex) with ESMTPSA id NFRULz4HAX-QSxeursg;
        Tue, 26 Dec 2017 06:26:30 +0300
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client certificate not present)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; s=mail; t=1514258791;
        bh=aPA6/1k3cImsoKuCsCQ2uNIp5izZ/Sl8+W3iDTE3QKc=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References;
        b=FrCngU/DiArX5g7d8NxHTDwEGZ85oPRwHisg5PcikgsKnf0e/nAKfP8vS97Gw6DjI
         n9xuU0P1I0gofnH1eLD1Ncm9Vhe6bi5mGNV60gOi/F9AW4m6ORrOwp4jsgj1al+xf6
         nu9U4Z6Y7fbnvNeQHg40FNmwlputijvA1AO4t9J8=
Authentication-Results: smtp4j.mail.yandex.net; dkim=pass header.i=@flygoat.com
From:   Jiaxun Yang <jiaxun.yang@flygoat.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     James Hogan <james.hogan@mips.com>,
        Huacai CHen <chenhc@lemote.com>, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org, Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: [PATCH v6 3/4] MIPS: Loongson64: Load platform device during boot
Date:   Tue, 26 Dec 2017 11:26:01 +0800
Message-Id: <20171226032602.11417-4-jiaxun.yang@flygoat.com>
X-Mailer: git-send-email 2.15.1
In-Reply-To: <20171226032602.11417-1-jiaxun.yang@flygoat.com>
References: <20171226032602.11417-1-jiaxun.yang@flygoat.com>
Return-Path: <jiaxun.yang@flygoat.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 61585
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
 arch/mips/loongson64/lemote-2f/platform.c | 25 +++++++++++++++++++++++++
 2 files changed, 26 insertions(+), 1 deletion(-)
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
index 000000000000..e0007f6c456a
--- /dev/null
+++ b/arch/mips/loongson64/lemote-2f/platform.c
@@ -0,0 +1,25 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* 
+* Copyright (C) 2017 Jiaxun Yang <jiaxun.yang@flygoat.com>
+*
+*/
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
2.15.1
