Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 06 May 2010 19:32:04 +0200 (CEST)
Received: from mail-pz0-f186.google.com ([209.85.222.186]:33357 "EHLO
        mail-pz0-f186.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492679Ab0EFRaU (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 6 May 2010 19:30:20 +0200
Received: by mail-pz0-f186.google.com with SMTP id 16so91263pzk.22
        for <multiple recipients>; Thu, 06 May 2010 10:30:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:in-reply-to:references;
        bh=yAIMCVcVTtGN31ufVFeEefyyZ/MwPMtxPT9suL9rmxg=;
        b=hN4F5tkUotXEy9Cn+7+t5gguWACfDHFndHvNeXnMKluRI4MYt157BkIUlfF3XdXsx5
         iPMs/Ha0TD3lEBell6Fly2kYeYXWzkgrbboCxf7VJjpHD2NatvjDQfdyEQ4BRpMBl33I
         iyPouC/gs1SLuCnekSKc1X3vpwh3LNHh3EEB0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=TO+O9iq8fzg0idjeBZpXkucGb4ZT6P8eGtUKzfUJV94EPAWihBxbYqpm7cRqbzQuCe
         Az5GQCbcJiS4Wa2kpPT8sPaNV7gDhgkd2FGo+R7J8Cv9gIZx+QAMmxhHlGZB0jAYCp/+
         Hjg1wFTaun5zCq8pvM25kPmZHFdJSeVly7plU=
Received: by 10.114.18.7 with SMTP id 7mr2531889war.127.1273167019371;
        Thu, 06 May 2010 10:30:19 -0700 (PDT)
Received: from localhost.localdomain ([202.201.14.140])
        by mx.google.com with ESMTPS id r20sm5257084wam.5.2010.05.06.10.30.17
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 06 May 2010 10:30:18 -0700 (PDT)
From:   Wu Zhangjin <wuzhangjin@gmail.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org, Wu Zhangjin <wuzhangjin@gmail.com>
Subject: [PATCH 4/5] Oprofile: Loongson: Cleanup of the macros
Date:   Fri,  7 May 2010 01:29:47 +0800
Message-Id: <128dc97848b717b4a0b11ba481a602ba144249a6.1273166351.git.wuzhangjin@gmail.com>
X-Mailer: git-send-email 1.7.0
In-Reply-To: <cover.1273165681.git.wuzhangjin@gmail.com>
References: <cover.1273165681.git.wuzhangjin@gmail.com>
In-Reply-To: <cover.1273166351.git.wuzhangjin@gmail.com>
References: <cover.1273166351.git.wuzhangjin@gmail.com>
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26635
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips

From: Wu Zhangjin <wuzhangjin@gmail.com>

The _EXL, _KERNEL ... bits are in the performance control register, so,
use _PERFCTRL prefix instead of _PERFCNT. BTW: to make the macro
readable, use _ENABLE instead of _INT_EN to describe the interrupt
enable bit.

Signed-off-by: Wu Zhangjin <wuzhangjin@gmail.com>
---
 arch/mips/oprofile/op_model_loongson2.c |   22 +++++++++++-----------
 1 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/arch/mips/oprofile/op_model_loongson2.c b/arch/mips/oprofile/op_model_loongson2.c
index a03894e..23f7e13 100644
--- a/arch/mips/oprofile/op_model_loongson2.c
+++ b/arch/mips/oprofile/op_model_loongson2.c
@@ -24,16 +24,16 @@
  */
 #define LOONGSON2_CPU_TYPE	"mips/loongson2"
 
+#define LOONGSON2_PERFCNT_OVERFLOW		(1ULL   << 31)
+
+#define LOONGSON2_PERFCTRL_EXL			(1UL	<<  0)
+#define LOONGSON2_PERFCTRL_KERNEL		(1UL    <<  1)
+#define LOONGSON2_PERFCTRL_SUPERVISOR		(1UL    <<  2)
+#define LOONGSON2_PERFCTRL_USER			(1UL    <<  3)
+#define LOONGSON2_PERFCTRL_ENABLE		(1UL    <<  4)
 #define LOONGSON2_PERFCTRL_EVENT(idx, event) \
 	(((event) & 0x0f) << ((idx) ? 9 : 5))
 
-#define LOONGSON2_PERFCNT_EXL			(1UL	<<  0)
-#define LOONGSON2_PERFCNT_KERNEL		(1UL    <<  1)
-#define LOONGSON2_PERFCNT_SUPERVISOR	(1UL    <<  2)
-#define LOONGSON2_PERFCNT_USER			(1UL    <<  3)
-#define LOONGSON2_PERFCNT_INT_EN		(1UL    <<  4)
-#define LOONGSON2_PERFCNT_OVERFLOW		(1ULL   << 31)
-
 /* Loongson2 performance counter register */
 #define read_c0_perfctrl() __read_64bit_c0_register($24, 0)
 #define write_c0_perfctrl(val) __write_64bit_c0_register($24, 0, val)
@@ -76,11 +76,11 @@ static void loongson2_reg_setup(struct op_counter_config *cfg)
 	}
 
 	if (cfg[0].enabled || cfg[1].enabled) {
-		ctrl |= LOONGSON2_PERFCNT_EXL | LOONGSON2_PERFCNT_INT_EN;
+		ctrl |= LOONGSON2_PERFCTRL_EXL | LOONGSON2_PERFCTRL_ENABLE;
 		if (cfg[0].kernel || cfg[1].kernel)
-			ctrl |= LOONGSON2_PERFCNT_KERNEL;
+			ctrl |= LOONGSON2_PERFCTRL_KERNEL;
 		if (cfg[0].user || cfg[1].user)
-			ctrl |= LOONGSON2_PERFCNT_USER;
+			ctrl |= LOONGSON2_PERFCTRL_USER;
 	}
 
 	reg.ctrl = ctrl;
@@ -125,7 +125,7 @@ static irqreturn_t loongson2_perfcount_handler(int irq, void *dev_id)
 	 */
 
 	/* Check whether the irq belongs to me */
-	enabled = read_c0_perfctrl() & LOONGSON2_PERFCNT_INT_EN;
+	enabled = read_c0_perfctrl() & LOONGSON2_PERFCTRL_ENABLE;
 	if (!enabled)
 		return IRQ_NONE;
 	enabled = reg.cnt1_enabled | reg.cnt2_enabled;
-- 
1.7.0
