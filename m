Return-Path: <SRS0=zZS8=QE=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD414C282C8
	for <linux-mips@archiver.kernel.org>; Mon, 28 Jan 2019 15:22:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C6182087E
	for <linux-mips@archiver.kernel.org>; Mon, 28 Jan 2019 15:22:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=flygoat.com header.i=@flygoat.com header.b="lVlQUqnY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726694AbfA1PWD (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Mon, 28 Jan 2019 10:22:03 -0500
Received: from forward106p.mail.yandex.net ([77.88.28.109]:50588 "EHLO
        forward106p.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726266AbfA1PWD (ORCPT
        <rfc822;linux-mips@vger.kernel.org>);
        Mon, 28 Jan 2019 10:22:03 -0500
Received: from mxback23g.mail.yandex.net (mxback23g.mail.yandex.net [IPv6:2a02:6b8:0:1472:2741:0:8b7:323])
        by forward106p.mail.yandex.net (Yandex) with ESMTP id 24A8D1C81EC9;
        Mon, 28 Jan 2019 18:21:58 +0300 (MSK)
Received: from smtp4o.mail.yandex.net (smtp4o.mail.yandex.net [2a02:6b8:0:1a2d::28])
        by mxback23g.mail.yandex.net (nwsmtp/Yandex) with ESMTP id Zuwt4kDr65-LvgWilBE;
        Mon, 28 Jan 2019 18:21:58 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; s=mail; t=1548688918;
        bh=TuBMlX5/v7jXm2kI9MQ+sU2l18YHTG4NcoeL70x9Veg=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References;
        b=lVlQUqnYAInIlTPZ8lerYN64DvsRl68n1GjwUc85JkoX7lRvWfeAVjJ7Y2utlB7P1
         5DtPEuJZp6rLucB6riPa4MwyyxqvLL/yMPc62gD64awj92Lmaz54L+Ki/ZeNeFFdw8
         9ts0l261EyJ1ZXlztZU+UmjG+EJ7C8ogmOEloUu0=
Authentication-Results: mxback23g.mail.yandex.net; dkim=pass header.i=@flygoat.com
Received: by smtp4o.mail.yandex.net (nwsmtp/Yandex) with ESMTPSA id EWlCXSEkWL-LmniBhea;
        Mon, 28 Jan 2019 18:21:56 +0300
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client certificate not present)
From:   Jiaxun Yang <jiaxun.yang@flygoat.com>
To:     linux-mips@vger.kernel.org
Cc:     mturquette@baylibre.com, sboyd@kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        robh+dt@kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org, Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: [PATCH v2 3/3] dt-bindings: clock: Add loongson-1 clock bindings
Date:   Mon, 28 Jan 2019 23:20:52 +0800
Message-Id: <20190128152052.3047-4-jiaxun.yang@flygoat.com>
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

Loongson-1 is a series of MIPS MCUs.
This patch add the clock bindings for loongson-1b and
loongson-1c clock subsystem.

Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
---
 .../bindings/clock/loongson1-clock.txt        | 11 ++++++++++
 include/dt-bindings/clock/ls1b-clock.h        | 20 +++++++++++++++++++
 include/dt-bindings/clock/ls1c-clock.h        | 17 ++++++++++++++++
 3 files changed, 48 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/loongson1-clock.txt
 create mode 100644 include/dt-bindings/clock/ls1b-clock.h
 create mode 100644 include/dt-bindings/clock/ls1c-clock.h

diff --git a/Documentation/devicetree/bindings/clock/loongson1-clock.txt b/Documentation/devicetree/bindings/clock/loongson1-clock.txt
new file mode 100644
index 000000000000..f0119fbd0851
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/loongson1-clock.txt
@@ -0,0 +1,11 @@
+* Clock bindings for Loongson-1 MCUs
+
+Required properties:
+- compatible: Should be "loongson,ls1c-clock" or "loongson,ls1b-clock"
+- reg: Address and length of the register set
+- #clock-cells: Should be <1>
+- clocks: list of input clocks
+
+The clock consumer should specify the desired clock by having the clock
+ID in its "clocks" phandle cell. See include/dt-bindings/clock/ls1c-clock.h
+or include/dt-bindings/clock/ls1b-clock.h for the full list of clocks.
diff --git a/include/dt-bindings/clock/ls1b-clock.h b/include/dt-bindings/clock/ls1b-clock.h
new file mode 100644
index 000000000000..814227842ae0
--- /dev/null
+++ b/include/dt-bindings/clock/ls1b-clock.h
@@ -0,0 +1,20 @@
+// SPDX-License-Identifier:	GPL-2.0
+/*
+ * Copyright (C) 2019 Jiaxun Yang <jiaxun.yang@flygoat.com>
+ *
+ */
+
+#ifndef __DT_BINDINGS_CLOCK_LS1B_CLOCK_H__
+#define __DT_BINDINGS_CLOCK_LS1B_CLOCK_H__
+
+#define LS1B_CLK_PLL 0
+#define LS1B_CLK_CPU_DIV 1
+#define LS1B_CLK_CPU 2
+#define LS1B_CLK_DC_DIV 3
+#define LS1B_CLK_DC 4
+#define LS1B_CLK_DDR_DIV 5
+#define LS1B_CLK_DDR 6
+#define LS1B_CLK_AHB 7
+#define LS1B_CLK_APB 8
+
+#endif /* __DT_BINDINGS_CLOCK_LS1B_CLOCK_H__ */
diff --git a/include/dt-bindings/clock/ls1c-clock.h b/include/dt-bindings/clock/ls1c-clock.h
new file mode 100644
index 000000000000..40f386cb92ce
--- /dev/null
+++ b/include/dt-bindings/clock/ls1c-clock.h
@@ -0,0 +1,17 @@
+// SPDX-License-Identifier:	GPL-2.0
+/*
+ * Copyright (C) 2019 Jiaxun Yang <jiaxun.yang@flygoat.com>
+ *
+ */
+
+#ifndef __DT_BINDINGS_CLOCK_LS1C_CLOCK_H__
+#define __DT_BINDINGS_CLOCK_LS1C_CLOCK_H__
+
+#define LS1C_CLK_PLL 0
+#define LS1C_CLK_CPU 1
+#define LS1C_CLK_DC 2
+#define LS1C_CLK_DDR 3
+#define LS1C_CLK_AHB 4
+#define LS1C_CLK_APB 5
+
+#endif /* __DT_BINDINGS_CLOCK_LS1C_CLOCK_H__ */
-- 
2.20.1

