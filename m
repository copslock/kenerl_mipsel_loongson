Return-Path: <SRS0=jHXZ=P6=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37922C282C3
	for <linux-mips@archiver.kernel.org>; Tue, 22 Jan 2019 13:12:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 068DA21726
	for <linux-mips@archiver.kernel.org>; Tue, 22 Jan 2019 13:12:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=flygoat.com header.i=@flygoat.com header.b="czuNKMiK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728486AbfAVNMH (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Tue, 22 Jan 2019 08:12:07 -0500
Received: from forward101o.mail.yandex.net ([37.140.190.181]:52405 "EHLO
        forward101o.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728305AbfAVNMH (ORCPT
        <rfc822;linux-mips@vger.kernel.org>);
        Tue, 22 Jan 2019 08:12:07 -0500
Received: from mxback7g.mail.yandex.net (mxback7g.mail.yandex.net [IPv6:2a02:6b8:0:1472:2741:0:8b7:168])
        by forward101o.mail.yandex.net (Yandex) with ESMTP id 739423C01864;
        Tue, 22 Jan 2019 16:06:24 +0300 (MSK)
Received: from smtp3p.mail.yandex.net (smtp3p.mail.yandex.net [2a02:6b8:0:1472:2741:0:8b6:8])
        by mxback7g.mail.yandex.net (nwsmtp/Yandex) with ESMTP id sau7Mk13Ba-6OKu9ZPb;
        Tue, 22 Jan 2019 16:06:24 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; s=mail; t=1548162384;
        bh=pqqm05iMBuZF8YCzrghS6KXuTd0gu3xVBHG21EEKUNI=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References;
        b=czuNKMiKGcgZ54oYz8+CFX03+TKxYnVQ8klePUS8tMGqf345RpEA+BEvUpSzksAme
         KSkm7kKnwbYZ6T0NiqfBfse6bMjaD0gAPvgOr7hENVgIAWalj5UET29N96b2D46IdG
         duYdIz4qCvxo8qb7hnMis4aXLnxtBDdICXLRqVPM=
Authentication-Results: mxback7g.mail.yandex.net; dkim=pass header.i=@flygoat.com
Received: by smtp3p.mail.yandex.net (nwsmtp/Yandex) with ESMTPSA id nEDDgaQwiv-6DeGg2oU;
        Tue, 22 Jan 2019 16:06:21 +0300
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client certificate not present)
From:   Jiaxun Yang <jiaxun.yang@flygoat.com>
To:     linux-mips@vger.kernel.org
Cc:     keguang.zhang@gmail.com, paul.burton@mips.com,
        Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: [PATCH 4/6] MIPS: Loongson32: clarify we don't support MIPS16 and merge configs
Date:   Tue, 22 Jan 2019 21:04:13 +0800
Message-Id: <20190122130415.3440-4-jiaxun.yang@flygoat.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190122130415.3440-1-jiaxun.yang@flygoat.com>
References: <20190122130415.3440-1-jiaxun.yang@flygoat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-mips-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mips.vger.kernel.org>
X-Mailing-List: linux-mips@vger.kernel.org

Accorading to GS232 core user's manual, it doesn't support MIPS16.

Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
---
 arch/mips/Kconfig            |  4 ++++
 arch/mips/loongson32/Kconfig | 15 ---------------
 2 files changed, 4 insertions(+), 15 deletions(-)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 5f6cf6fe6382..d4c01f9baf19 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -1870,6 +1870,10 @@ config CPU_LOONGSON1
 	select CPU_HAS_PREFETCH
 	select CPU_HAS_LOAD_STORE_LR
 	select CPU_SUPPORTS_32BIT_KERNEL
+	select IRQ_MIPS_CPU
+	select DMA_NONCOHERENT
+	select BOOT_ELF32
+	select SYS_SUPPORTS_LITTLE_ENDIAN
 	select CPU_SUPPORTS_HIGHMEM
 	select CPU_SUPPORTS_CPUFREQ
 
diff --git a/arch/mips/loongson32/Kconfig b/arch/mips/loongson32/Kconfig
index 462b126f45aa..b4eed5b59b39 100644
--- a/arch/mips/loongson32/Kconfig
+++ b/arch/mips/loongson32/Kconfig
@@ -9,13 +9,6 @@ config LOONGSON1_LS1B
 	select CEVT_R4K if !MIPS_EXTERNAL_TIMER
 	select CSRC_R4K if !MIPS_EXTERNAL_TIMER
 	select SYS_HAS_CPU_LOONGSON1B
-	select DMA_NONCOHERENT
-	select BOOT_ELF32
-	select IRQ_MIPS_CPU
-	select SYS_SUPPORTS_32BIT_KERNEL
-	select SYS_SUPPORTS_LITTLE_ENDIAN
-	select SYS_SUPPORTS_HIGHMEM
-	select SYS_SUPPORTS_MIPS16
 	select SYS_HAS_EARLY_PRINTK
 	select USE_GENERIC_EARLY_PRINTK_8250
 	select COMMON_CLK
@@ -24,14 +17,6 @@ config LOONGSON1_LS1C
 	bool "Loongson LS1C board"
 	select CEVT_R4K if !MIPS_EXTERNAL_TIMER
 	select CSRC_R4K if !MIPS_EXTERNAL_TIMER
-	select SYS_HAS_CPU_LOONGSON1C
-	select DMA_NONCOHERENT
-	select BOOT_ELF32
-	select IRQ_MIPS_CPU
-	select SYS_SUPPORTS_32BIT_KERNEL
-	select SYS_SUPPORTS_LITTLE_ENDIAN
-	select SYS_SUPPORTS_HIGHMEM
-	select SYS_SUPPORTS_MIPS16
 	select SYS_HAS_EARLY_PRINTK
 	select USE_GENERIC_EARLY_PRINTK_8250
 	select COMMON_CLK
-- 
2.20.1

