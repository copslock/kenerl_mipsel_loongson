Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 24 Jul 2010 03:22:42 +0200 (CEST)
Received: from mail-pv0-f177.google.com ([74.125.83.177]:53559 "EHLO
        mail-pv0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492616Ab0GXBWf (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 24 Jul 2010 03:22:35 +0200
Received: by pvf33 with SMTP id 33so4667692pvf.36
        for <multiple recipients>; Fri, 23 Jul 2010 18:22:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:in-reply-to:references;
        bh=SMkINm7oc3XoinQ+9LSwvtpaSlM2WwLIYQ4l51GtpzE=;
        b=mUrQbwbQ80J8z48f1dvVh9POs1Xb1j7QT6nX1/Kc0VDi5W1vKSkRCk5tCI6O2VC/uR
         6ImU0sCw1Ar9GR4Z3GjllFB4VtGDVU5OBwziqtt6SH00hKcOCt7GHnyKku42FgvLudLR
         6dy82m2D3A6GqKLzMly4DPqDDuzIFaViwH9t8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=HonQ3tJiFz6gfGP2sTsZdHblYxDlUSVPbfz92BEewomNjtUHK1wLdzNt1z3E67ufOx
         dSlQlWIdG6bBWZ3FqAZpX71dcpY+TOR+3AJAZO121WN+oOd6FUohJaO2AJF/gBICpEDF
         OwY5zJ6qumQNyZT5xHyxnN6mAQoM8uwUpe6k4=
Received: by 10.142.215.6 with SMTP id n6mr4989089wfg.161.1279934547929;
        Fri, 23 Jul 2010 18:22:27 -0700 (PDT)
Received: from localhost.localdomain ([182.18.29.11])
        by mx.google.com with ESMTPS id f2sm936892wfp.11.2010.07.23.18.22.26
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 23 Jul 2010 18:22:27 -0700 (PDT)
From:   Wu Zhangjin <wuzhangjin@gmail.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org, Wu Zhangjin <wuzhangjin@gmail.com>
Subject: [PATCH 2/3] MIPS: Loongson: Oprofile: add a new do_perfcnt_IRQ()
Date:   Sat, 24 Jul 2010 09:22:14 +0800
Message-Id: <d746f27619a6cb66ec4bca85e9f2bc57b3504d75.1279934355.git.wuzhangjin@gmail.com>
X-Mailer: git-send-email 1.7.0.4
In-Reply-To: <881c93ee3de32e7809f5ac05d0086bc525af57a9.1279934355.git.wuzhangjin@gmail.com>
References: <881c93ee3de32e7809f5ac05d0086bc525af57a9.1279934355.git.wuzhangjin@gmail.com>
In-Reply-To: <cover.1279934355.git.wuzhangjin@gmail.com>
References: <cover.1279934355.git.wuzhangjin@gmail.com>
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 27463
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips

From: Wu Zhangjin <wuzhangjin@gmail.com>

On FuLoong-2F platform, the IP6 is shared by the performance counter
overflow interrupt and the bonito northbridge interrupt, we only enable
the calling to do_IRQ() when the oprofile is enabled(Y|M) to reduce
overhead.

This patch adds an inline function do_perfcnt_IRQ() to hide the #if's ,
which can be shared by the other Loongson machines, i.e. gdium.

Signed-off-by: Wu Zhangjin <wuzhangjin@gmail.com>
---
 arch/mips/include/asm/mach-loongson/loongson.h |    8 ++++++++
 arch/mips/loongson/fuloong-2e/irq.c            |    2 +-
 arch/mips/loongson/lemote-2f/irq.c             |    4 +---
 3 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/arch/mips/include/asm/mach-loongson/loongson.h b/arch/mips/include/asm/mach-loongson/loongson.h
index ef81d9c..0781e1a 100644
--- a/arch/mips/include/asm/mach-loongson/loongson.h
+++ b/arch/mips/include/asm/mach-loongson/loongson.h
@@ -68,6 +68,14 @@ extern int mach_i8259_irq(void);
 #define LOONGSON_IRQ_BASE	32
 #define LOONGSON2_PERFCNT_IRQ	(MIPS_CPU_IRQ_BASE + 6) /* cpu perf counter */
 
+#include <linux/interrupt.h>
+static inline void do_perfcnt_IRQ(void)
+{
+#if defined(CONFIG_OPROFILE) || defined(CONFIG_OPROFILE_MODULE)
+	do_IRQ(LOONGSON2_PERFCNT_IRQ);
+#endif
+}
+
 #define LOONGSON_FLASH_BASE	0x1c000000
 #define LOONGSON_FLASH_SIZE	0x02000000	/* 32M */
 #define LOONGSON_FLASH_TOP	(LOONGSON_FLASH_BASE+LOONGSON_FLASH_SIZE-1)
diff --git a/arch/mips/loongson/fuloong-2e/irq.c b/arch/mips/loongson/fuloong-2e/irq.c
index 99e08c3..d61a042 100644
--- a/arch/mips/loongson/fuloong-2e/irq.c
+++ b/arch/mips/loongson/fuloong-2e/irq.c
@@ -30,7 +30,7 @@ asmlinkage void mach_irq_dispatch(unsigned int pending)
 	if (pending & CAUSEF_IP7)
 		do_IRQ(MIPS_CPU_IRQ_BASE + 7);
 	else if (pending & CAUSEF_IP6) /* perf counter loverflow */
-		do_IRQ(LOONGSON2_PERFCNT_IRQ);
+		do_perfcnt_IRQ();
 	else if (pending & CAUSEF_IP5)
 		i8259_irqdispatch();
 	else if (pending & CAUSEF_IP2)
diff --git a/arch/mips/loongson/lemote-2f/irq.c b/arch/mips/loongson/lemote-2f/irq.c
index c6db7e7..71347d7 100644
--- a/arch/mips/loongson/lemote-2f/irq.c
+++ b/arch/mips/loongson/lemote-2f/irq.c
@@ -79,9 +79,7 @@ void mach_irq_dispatch(unsigned int pending)
 	if (pending & CAUSEF_IP7)
 		do_IRQ(LOONGSON_TIMER_IRQ);
 	else if (pending & CAUSEF_IP6) {	/* North Bridge, Perf counter */
-#if defined(CONFIG_OPROFILE) || defined(CONFIG_OPROFILE_MODULE)
-		do_IRQ(LOONGSON2_PERFCNT_IRQ);
-#endif
+		do_perfcnt_IRQ();
 		bonito_irqdispatch();
 	} else if (pending & CAUSEF_IP3)	/* CPU UART */
 		do_IRQ(LOONGSON_UART_IRQ);
-- 
1.7.0.4
