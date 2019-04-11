Return-Path: <SRS0=fNfu=SN=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09C86C10F13
	for <linux-mips@archiver.kernel.org>; Thu, 11 Apr 2019 12:20:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C7E832083E
	for <linux-mips@archiver.kernel.org>; Thu, 11 Apr 2019 12:20:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=flygoat.com header.i=@flygoat.com header.b="iSer/s1R"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726137AbfDKMUV (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Thu, 11 Apr 2019 08:20:21 -0400
Received: from forward100o.mail.yandex.net ([37.140.190.180]:36429 "EHLO
        forward100o.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726121AbfDKMUV (ORCPT
        <rfc822;linux-mips@vger.kernel.org>);
        Thu, 11 Apr 2019 08:20:21 -0400
Received: from mxback14o.mail.yandex.net (mxback14o.mail.yandex.net [IPv6:2a02:6b8:0:1a2d::65])
        by forward100o.mail.yandex.net (Yandex) with ESMTP id 14AD24AC1457;
        Thu, 11 Apr 2019 15:20:17 +0300 (MSK)
Received: from smtp2o.mail.yandex.net (smtp2o.mail.yandex.net [2a02:6b8:0:1a2d::26])
        by mxback14o.mail.yandex.net (nwsmtp/Yandex) with ESMTP id VYVbauxjfv-JrsCn9Rw;
        Thu, 11 Apr 2019 15:19:53 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; s=mail; t=1554985194;
        bh=fxCHmvLBhwkZ3rIsYVTN1zM6tZ4SPM6NEtNIOEXuyos=;
        h=In-Reply-To:Subject:To:From:Message-Id:Cc:References:Date;
        b=iSer/s1R4bQgKnM0F1v54pZPH1rjbqIjl/40V+CKJoJ8eFSjXbN3XxKLABSY+ALAO
         i3yeAnOnqt7vmB6n0YfIkFWf2W3mH1vELrINKOF72KfWT3x6rpncpdSnqJoOd1lEou
         T5r9w/sFGfsG+K7envSWp9HUy220iceWWSzZ6Gew=
Authentication-Results: mxback14o.mail.yandex.net; dkim=pass header.i=@flygoat.com
Received: by smtp2o.mail.yandex.net (nwsmtp/Yandex) with ESMTPSA id QbB7ClwXzg-JlCmbnE0;
        Thu, 11 Apr 2019 15:19:51 +0300
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client certificate not present)
From:   Jiaxun Yang <jiaxun.yang@flygoat.com>
To:     linux-mips@vger.kernel.org
Cc:     devicetree@vger.kernel.org, paul.burton@mips.com,
        robh+dt@kernel.org, Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: [PATCH v2 3/6] MIPS: Loongson32: Kconfig merge CPU_LOONGSON1B&C
Date:   Thu, 11 Apr 2019 20:19:12 +0800
Message-Id: <20190411121915.8040-4-jiaxun.yang@flygoat.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190411121915.8040-1-jiaxun.yang@flygoat.com>
References: <20190312091520.8863-2-jiaxun.yang@flygoat.com>
 <20190411121915.8040-1-jiaxun.yang@flygoat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-mips-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mips.vger.kernel.org>
X-Mailing-List: linux-mips@vger.kernel.org

Loongson-1B&C have totally identical GS232 core, so merge
them into same CPU config.

Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
---
 arch/mips/Kconfig                | 38 +++++++++-----------------------
 arch/mips/include/asm/cpu-type.h |  3 +--
 arch/mips/loongson32/Kconfig     |  4 ++--
 3 files changed, 14 insertions(+), 31 deletions(-)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 15f8cc3c965f..ac0b93e57ca3 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -1429,26 +1429,22 @@ config CPU_LOONGSON2F
 	  have a similar programming interface with FPGA northbridge used in
 	  Loongson2E.
 
-config CPU_LOONGSON1B
-	bool "Loongson 1B"
-	depends on SYS_HAS_CPU_LOONGSON1B
-	select CPU_LOONGSON1
+config CPU_LOONGSON1
+	bool "Loongson 1"
+	depends on SYS_HAS_CPU_LOONGSON1
+	select CPU_MIPS32
+	select CPU_MIPSR2
+	select CPU_HAS_PREFETCH
+	select CPU_HAS_LOAD_STORE_LR
+	select CPU_SUPPORTS_32BIT_KERNEL
+	select CPU_SUPPORTS_HIGHMEM
+	select CPU_SUPPORTS_CPUFREQ
 	select LEDS_GPIO_REGISTER
 	help
 	  The Loongson 1B is a 32-bit SoC, which implements the MIPS32
 	  Release 1 instruction set and part of the MIPS32 Release 2
 	  instruction set.
 
-config CPU_LOONGSON1C
-	bool "Loongson 1C"
-	depends on SYS_HAS_CPU_LOONGSON1C
-	select CPU_LOONGSON1
-	select LEDS_GPIO_REGISTER
-	help
-	  The Loongson 1C is a 32-bit SoC, which implements the MIPS32
-	  Release 1 instruction set and part of the MIPS32 Release 2
-	  instruction set.
-
 config CPU_MIPS32_R1
 	bool "MIPS32 Release 1"
 	depends on SYS_HAS_CPU_MIPS32_R1
@@ -1866,15 +1862,6 @@ config CPU_LOONGSON2
 	select ARCH_HAS_PHYS_TO_DMA
 	select CPU_HAS_LOAD_STORE_LR
 
-config CPU_LOONGSON1
-	bool
-	select CPU_MIPS32
-	select CPU_MIPSR2
-	select CPU_HAS_PREFETCH
-	select CPU_HAS_LOAD_STORE_LR
-	select CPU_SUPPORTS_32BIT_KERNEL
-	select CPU_SUPPORTS_HIGHMEM
-	select CPU_SUPPORTS_CPUFREQ
 
 config CPU_BMIPS32_3300
 	select SMP_UP if SMP
@@ -1914,10 +1901,7 @@ config SYS_HAS_CPU_LOONGSON2F
 	select CPU_SUPPORTS_ADDRWINCFG if 64BIT
 	select CPU_SUPPORTS_UNCACHED_ACCELERATED
 
-config SYS_HAS_CPU_LOONGSON1B
-	bool
-
-config SYS_HAS_CPU_LOONGSON1C
+config SYS_HAS_CPU_LOONGSON1
 	bool
 
 config SYS_HAS_CPU_MIPS32_R1
diff --git a/arch/mips/include/asm/cpu-type.h b/arch/mips/include/asm/cpu-type.h
index a45af3de075d..ee17f02419a3 100644
--- a/arch/mips/include/asm/cpu-type.h
+++ b/arch/mips/include/asm/cpu-type.h
@@ -24,8 +24,7 @@ static inline int __pure __get_cpu_type(const int cpu_type)
 	case CPU_LOONGSON3:
 #endif
 
-#if defined(CONFIG_SYS_HAS_CPU_LOONGSON1B) || \
-    defined(CONFIG_SYS_HAS_CPU_LOONGSON1C)
+#if defined(CONFIG_SYS_HAS_CPU_LOONGSON1)
 	case CPU_LOONGSON1:
 #endif
 
diff --git a/arch/mips/loongson32/Kconfig b/arch/mips/loongson32/Kconfig
index 6dacc1438906..a0a00c3e2187 100644
--- a/arch/mips/loongson32/Kconfig
+++ b/arch/mips/loongson32/Kconfig
@@ -8,7 +8,7 @@ config LOONGSON1_LS1B
 	bool "Loongson LS1B board"
 	select CEVT_R4K if !MIPS_EXTERNAL_TIMER
 	select CSRC_R4K if !MIPS_EXTERNAL_TIMER
-	select SYS_HAS_CPU_LOONGSON1B
+	select SYS_HAS_CPU_LOONGSON1
 	select DMA_NONCOHERENT
 	select BOOT_ELF32
 	select IRQ_MIPS_CPU
@@ -23,7 +23,7 @@ config LOONGSON1_LS1C
 	bool "Loongson LS1C board"
 	select CEVT_R4K if !MIPS_EXTERNAL_TIMER
 	select CSRC_R4K if !MIPS_EXTERNAL_TIMER
-	select SYS_HAS_CPU_LOONGSON1C
+	select SYS_HAS_CPU_LOONGSON1
 	select DMA_NONCOHERENT
 	select BOOT_ELF32
 	select IRQ_MIPS_CPU
-- 
2.21.0

