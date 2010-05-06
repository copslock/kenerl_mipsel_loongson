Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 06 May 2010 19:32:28 +0200 (CEST)
Received: from mail-pz0-f186.google.com ([209.85.222.186]:33357 "EHLO
        mail-pz0-f186.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492684Ab0EFRaX (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 6 May 2010 19:30:23 +0200
Received: by mail-pz0-f186.google.com with SMTP id 16so91263pzk.22
        for <multiple recipients>; Thu, 06 May 2010 10:30:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:in-reply-to:references;
        bh=yMzvNXuJKNUj5XHgV5B4sd3f5lEpkN5Ftd/gFplTDMk=;
        b=u0jmIsFnbzXnZZV9z1nn73EDg8j1m66KLeeEi+hzIQrDJt/ZWcH+3E83rLjlu+1daj
         Ang9zCvdqakmWv68sKDR71cKJ/eTVTtL0wyNlQ3y2u0Fpfuz8s7wxjfTz2iIC1J7t7zs
         Zbe3LIu78vqMT0oXU9hysAnQyngJ5UPv+s8y0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=iLJwAyzwl5hlpkeiysfQC2fMlXeTbIL4DazTbjalmh/TTnvRXJk8PUXP3u4mfbltcW
         WgTjk76PnloIgHd4NtDFx+h38DrBdDh+eC9msZ9xagl60TRsSG6VgkkVuoZ1FQb5TS/A
         grd+2iwxLzE8J0RORRaAT42dzuQPf5Bopl8G4=
Received: by 10.114.189.14 with SMTP id m14mr1233021waf.12.1273167022895;
        Thu, 06 May 2010 10:30:22 -0700 (PDT)
Received: from localhost.localdomain ([202.201.14.140])
        by mx.google.com with ESMTPS id r20sm5257084wam.5.2010.05.06.10.30.20
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 06 May 2010 10:30:21 -0700 (PDT)
From:   Wu Zhangjin <wuzhangjin@gmail.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org, Wu Zhangjin <wuzhangjin@gmail.com>
Subject: [PATCH 5/5] Oprofile: Loongson: Cleanup the comments
Date:   Fri,  7 May 2010 01:29:48 +0800
Message-Id: <f5683f39548a7bfa6a45cdc154a1885fed95d8d3.1273166351.git.wuzhangjin@gmail.com>
X-Mailer: git-send-email 1.7.0
In-Reply-To: <cover.1273165681.git.wuzhangjin@gmail.com>
References: <cover.1273165681.git.wuzhangjin@gmail.com>
In-Reply-To: <cover.1273166351.git.wuzhangjin@gmail.com>
References: <cover.1273166351.git.wuzhangjin@gmail.com>
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26636
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips

From: Wu Zhangjin <wuzhangjin@gmail.com>

This patch removes some out-of-date comments and unneeded blank lines.

Signed-off-by: Wu Zhangjin <wuzhangjin@gmail.com>
---
 arch/mips/oprofile/op_model_loongson2.c |   25 +++++--------------------
 1 files changed, 5 insertions(+), 20 deletions(-)

diff --git a/arch/mips/oprofile/op_model_loongson2.c b/arch/mips/oprofile/op_model_loongson2.c
index 23f7e13..60d3ea6 100644
--- a/arch/mips/oprofile/op_model_loongson2.c
+++ b/arch/mips/oprofile/op_model_loongson2.c
@@ -8,7 +8,6 @@
  * This file is subject to the terms and conditions of the GNU General Public
  * License.  See the file "COPYING" in the main directory of this archive
  * for more details.
- *
  */
 #include <linux/init.h>
 #include <linux/oprofile.h>
@@ -17,11 +16,6 @@
 #include <loongson.h>			/* LOONGSON2_PERFCNT_IRQ */
 #include "op_impl.h"
 
-/*
- * a patch should be sent to oprofile with the loongson-specific support.
- * otherwise, the oprofile tool will not recognize this and complain about
- * "cpu_type 'unset' is not valid".
- */
 #define LOONGSON2_CPU_TYPE	"mips/loongson2"
 
 #define LOONGSON2_PERFCNT_OVERFLOW		(1ULL   << 31)
@@ -34,7 +28,6 @@
 #define LOONGSON2_PERFCTRL_EVENT(idx, event) \
 	(((event) & 0x0f) << ((idx) ? 9 : 5))
 
-/* Loongson2 performance counter register */
 #define read_c0_perfctrl() __read_64bit_c0_register($24, 0)
 #define write_c0_perfctrl(val) __write_64bit_c0_register($24, 0, val)
 #define read_c0_perfcnt() __read_64bit_c0_register($25, 0)
@@ -49,7 +42,6 @@ static struct loongson2_register_config {
 
 static char *oprofid = "LoongsonPerf";
 static irqreturn_t loongson2_perfcount_handler(int irq, void *dev_id);
-/* Compute all of the registers in preparation for enabling profiling.  */
 
 static void reset_counters(void *arg)
 {
@@ -63,8 +55,11 @@ static void loongson2_reg_setup(struct op_counter_config *cfg)
 
 	reg.reset_counter1 = 0;
 	reg.reset_counter2 = 0;
-	/* Compute the performance counter ctrl word.  */
-	/* For now count kernel and user mode */
+
+	/*
+	 * Compute the performance counter ctrl word.
+	 * For now, count kernel and user mode.
+	 */
 	if (cfg[0].enabled) {
 		ctrl |= LOONGSON2_PERFCTRL_EVENT(0, cfg[0].event);
 		reg.reset_counter1 = 0x80000000ULL - cfg[0].count;
@@ -87,11 +82,8 @@ static void loongson2_reg_setup(struct op_counter_config *cfg)
 
 	reg.cnt1_enabled = cfg[0].enabled;
 	reg.cnt2_enabled = cfg[1].enabled;
-
 }
 
-/* Program all of the registers in preparation for enabling profiling.  */
-
 static void loongson2_cpu_setup(void *args)
 {
 	write_c0_perfcnt((reg.reset_counter2 << 32) | reg.reset_counter1);
@@ -117,13 +109,6 @@ static irqreturn_t loongson2_perfcount_handler(int irq, void *dev_id)
 	struct pt_regs *regs = get_irq_regs();
 	int enabled;
 
-	/*
-	 * LOONGSON2 defines two 32-bit performance counters.
-	 * To avoid a race updating the registers we need to stop the counters
-	 * while we're messing with
-	 * them ...
-	 */
-
 	/* Check whether the irq belongs to me */
 	enabled = read_c0_perfctrl() & LOONGSON2_PERFCTRL_ENABLE;
 	if (!enabled)
-- 
1.7.0
