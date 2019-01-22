Return-Path: <SRS0=jHXZ=P6=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DD25C282C3
	for <linux-mips@archiver.kernel.org>; Tue, 22 Jan 2019 13:12:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D2DB721726
	for <linux-mips@archiver.kernel.org>; Tue, 22 Jan 2019 13:12:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=flygoat.com header.i=@flygoat.com header.b="t2/rxjyw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728492AbfAVNMC (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Tue, 22 Jan 2019 08:12:02 -0500
Received: from forward102j.mail.yandex.net ([5.45.198.243]:47078 "EHLO
        forward102j.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728305AbfAVNMC (ORCPT
        <rfc822;linux-mips@vger.kernel.org>);
        Tue, 22 Jan 2019 08:12:02 -0500
X-Greylist: delayed 347 seconds by postgrey-1.27 at vger.kernel.org; Tue, 22 Jan 2019 08:12:01 EST
Received: from mxback9j.mail.yandex.net (mxback9j.mail.yandex.net [IPv6:2a02:6b8:0:1619::112])
        by forward102j.mail.yandex.net (Yandex) with ESMTP id D8D81F22096;
        Tue, 22 Jan 2019 16:06:12 +0300 (MSK)
Received: from smtp3p.mail.yandex.net (smtp3p.mail.yandex.net [2a02:6b8:0:1472:2741:0:8b6:8])
        by mxback9j.mail.yandex.net (nwsmtp/Yandex) with ESMTP id XO4y2NgwwV-6CAGar0W;
        Tue, 22 Jan 2019 16:06:12 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; s=mail; t=1548162372;
        bh=biQ3k1UH7uX5Tl/x3Ok/jTKPVsSaR/YJwnXsyqAvbts=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References;
        b=t2/rxjywTGulUFirHl48q3NJrmMm/HChA1yB/K9ECZxT1h7InYqptHrkL1keFIH0h
         cmt30/Of6QKX8pizNPxAN7cmuiFz84uGsv06/QPLYvHhyEcSLuhHun4jptqc9JAlJJ
         +tyneg9wCateXQB6hzzzNPbTk3WUDK5uUFjKO8YI=
Authentication-Results: mxback9j.mail.yandex.net; dkim=pass header.i=@flygoat.com
Received: by smtp3p.mail.yandex.net (nwsmtp/Yandex) with ESMTPSA id nEDDgaQwiv-5heeFDpQ;
        Tue, 22 Jan 2019 16:06:03 +0300
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client certificate not present)
From:   Jiaxun Yang <jiaxun.yang@flygoat.com>
To:     linux-mips@vger.kernel.org
Cc:     keguang.zhang@gmail.com, paul.burton@mips.com,
        Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: [PATCH 3/6] MIPS: Loongson32: Revert ISA level to MIPS32R2
Date:   Tue, 22 Jan 2019 21:04:12 +0800
Message-Id: <20190122130415.3440-3-jiaxun.yang@flygoat.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190122130415.3440-1-jiaxun.yang@flygoat.com>
References: <20190122130415.3440-1-jiaxun.yang@flygoat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-mips-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mips.vger.kernel.org>
X-Mailing-List: linux-mips@vger.kernel.org

GS232 core have implemented all necessary mips32r2 instructions.
Serval missing FP instructions can be emulated by kernel.

The issue of di instruction have been solved.
Thus we revert the ISA level back to MIPS32R2.

Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
---
 arch/mips/Kconfig             | 2 +-
 arch/mips/loongson32/Platform | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 787290781b8c..5f6cf6fe6382 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -1866,7 +1866,7 @@ config CPU_LOONGSON2
 config CPU_LOONGSON1
 	bool
 	select CPU_MIPS32
-	select CPU_MIPSR1
+	select CPU_MIPSR2
 	select CPU_HAS_PREFETCH
 	select CPU_HAS_LOAD_STORE_LR
 	select CPU_SUPPORTS_32BIT_KERNEL
diff --git a/arch/mips/loongson32/Platform b/arch/mips/loongson32/Platform
index a0dbb3b2f2de..0db38f64f571 100644
--- a/arch/mips/loongson32/Platform
+++ b/arch/mips/loongson32/Platform
@@ -1,4 +1,4 @@
-cflags-$(CONFIG_CPU_LOONGSON1)		+= -march=mips32 -Wa,--trap
+cflags-$(CONFIG_CPU_LOONGSON1)		+= -march=mips32r2 -Wa,--trap
 platform-$(CONFIG_MACH_LOONGSON32)	+= loongson32/
 cflags-$(CONFIG_MACH_LOONGSON32)	+= -I$(srctree)/arch/mips/include/asm/mach-loongson32
 load-$(CONFIG_CPU_LOONGSON1)		+= 0xffffffff80100000
-- 
2.20.1

