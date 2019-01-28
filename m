Return-Path: <SRS0=zZS8=QE=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFA6DC282C8
	for <linux-mips@archiver.kernel.org>; Mon, 28 Jan 2019 15:21:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 97B062087E
	for <linux-mips@archiver.kernel.org>; Mon, 28 Jan 2019 15:21:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=flygoat.com header.i=@flygoat.com header.b="wGjTxoAf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726735AbfA1PVk (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Mon, 28 Jan 2019 10:21:40 -0500
Received: from forward104o.mail.yandex.net ([37.140.190.179]:40861 "EHLO
        forward104o.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726647AbfA1PVk (ORCPT
        <rfc822;linux-mips@vger.kernel.org>);
        Mon, 28 Jan 2019 10:21:40 -0500
Received: from mxback4g.mail.yandex.net (mxback4g.mail.yandex.net [IPv6:2a02:6b8:0:1472:2741:0:8b7:165])
        by forward104o.mail.yandex.net (Yandex) with ESMTP id 68708942187;
        Mon, 28 Jan 2019 18:21:35 +0300 (MSK)
Received: from smtp4o.mail.yandex.net (smtp4o.mail.yandex.net [2a02:6b8:0:1a2d::28])
        by mxback4g.mail.yandex.net (nwsmtp/Yandex) with ESMTP id f4jiajaC1H-LZgW64Sq;
        Mon, 28 Jan 2019 18:21:35 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; s=mail; t=1548688895;
        bh=2wiqs9zxe3W64theQBSX1Wi8qaLxM4kryOcr6IFsFbg=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References;
        b=wGjTxoAfKZgej0qzkjD5ccJLZGL99KMm1oaJRSvfDoPbpiFbDKK0gSBECH6VODyS7
         cXumRvlCm8+zfPpo2MkP+tR6sfoEam9NB4/uQwW6ywhxGKQCEd4h1EdnE13ZL6YPwJ
         pbAZqJvuSsAIBTRTT6SA+14vWqdfolwC03tI+4qQ=
Authentication-Results: mxback4g.mail.yandex.net; dkim=pass header.i=@flygoat.com
Received: by smtp4o.mail.yandex.net (nwsmtp/Yandex) with ESMTPSA id EWlCXSEkWL-LLnWmkYK;
        Mon, 28 Jan 2019 18:21:31 +0300
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client certificate not present)
From:   Jiaxun Yang <jiaxun.yang@flygoat.com>
To:     linux-mips@vger.kernel.org
Cc:     mturquette@baylibre.com, sboyd@kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        robh+dt@kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org, Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: [PATCH v2 1/3] clk: loongson1: add configuration option for loongson1 clks
Date:   Mon, 28 Jan 2019 23:20:50 +0800
Message-Id: <20190128152052.3047-2-jiaxun.yang@flygoat.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190128152052.3047-1-jiaxun.yang@flygoat.com>
References: <20190125133413.4130-1-jiaxun.yang@flygoat.com>
 <20190128152052.3047-1-jiaxun.yang@flygoat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-mips-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mips.vger.kernel.org>
X-Mailing-List: linux-mips@vger.kernel.org

The patch introduces options for loongson1 clocks so we can
select the driver we need.

Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
---
 drivers/clk/Kconfig            |  1 +
 drivers/clk/Makefile           |  2 +-
 drivers/clk/loongson1/Kconfig  | 27 +++++++++++++++++++++++++++
 drivers/clk/loongson1/Makefile |  7 ++++---
 4 files changed, 33 insertions(+), 4 deletions(-)
 create mode 100644 drivers/clk/loongson1/Kconfig

diff --git a/drivers/clk/Kconfig b/drivers/clk/Kconfig
index e5b2fe80eab4..136d3d73c6df 100644
--- a/drivers/clk/Kconfig
+++ b/drivers/clk/Kconfig
@@ -298,6 +298,7 @@ source "drivers/clk/imgtec/Kconfig"
 source "drivers/clk/imx/Kconfig"
 source "drivers/clk/ingenic/Kconfig"
 source "drivers/clk/keystone/Kconfig"
+source "drivers/clk/loongson1/Kconfig"
 source "drivers/clk/mediatek/Kconfig"
 source "drivers/clk/meson/Kconfig"
 source "drivers/clk/mvebu/Kconfig"
diff --git a/drivers/clk/Makefile b/drivers/clk/Makefile
index 8a9440a97500..7d29e545caf0 100644
--- a/drivers/clk/Makefile
+++ b/drivers/clk/Makefile
@@ -76,7 +76,7 @@ obj-y					+= imx/
 obj-y					+= ingenic/
 obj-$(CONFIG_ARCH_K3)			+= keystone/
 obj-$(CONFIG_ARCH_KEYSTONE)		+= keystone/
-obj-$(CONFIG_MACH_LOONGSON32)		+= loongson1/
+obj-y					+= loongson1/
 obj-y					+= mediatek/
 obj-$(CONFIG_COMMON_CLK_AMLOGIC)	+= meson/
 obj-$(CONFIG_MACH_PIC32)		+= microchip/
diff --git a/drivers/clk/loongson1/Kconfig b/drivers/clk/loongson1/Kconfig
new file mode 100644
index 000000000000..e2220332d797
--- /dev/null
+++ b/drivers/clk/loongson1/Kconfig
@@ -0,0 +1,27 @@
+menu "Loongson-1 Clock drivers"
+	depends on MACH_LOONGSON32
+
+config LOONGSON1_CLOCK_COMMON
+	bool
+
+config LOONGSON1_CLOCK_LS1B
+	bool "Loongson 1B driver"
+	default y
+	select LOONGSON1_CLOCK_COMMON
+	help
+	  Support the clocks provided by the clock hardware on Loongson-1B
+	  and compatible SoCs.
+
+	  If building for a Loongson-1B SoC, you want to say Y here.
+
+config LOONGSON1_CLOCK_LS1C
+	bool "Loongson 1C driver"
+	default y
+	select LOONGSON1_CLOCK_COMMON
+	help
+	  Support the clocks provided by the clock hardware on Loongson-1C
+	  and compatible SoCs.
+
+	  If building for a Loongson-1C SoC, you want to say Y here.
+
+endmenu
diff --git a/drivers/clk/loongson1/Makefile b/drivers/clk/loongson1/Makefile
index b7f6a16390e0..9240189183ff 100644
--- a/drivers/clk/loongson1/Makefile
+++ b/drivers/clk/loongson1/Makefile
@@ -1,3 +1,4 @@
-obj-y				+= clk.o
-obj-$(CONFIG_LOONGSON1_LS1B)	+= clk-loongson1b.o
-obj-$(CONFIG_LOONGSON1_LS1C)	+= clk-loongson1c.o
+# SPDX-License-Identifier: GPL-2.0
+obj-$(CONFIG_LOONGSON1_CLOCK_COMMON)	+= clk.o
+obj-$(CONFIG_LOONGSON1_CLOCK_LS1B)	+= clk-loongson1b.o
+obj-$(CONFIG_LOONGSON1_CLOCK_LS1C)	+= clk-loongson1c.o
-- 
2.20.1

