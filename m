Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 13 Apr 2014 02:27:48 +0200 (CEST)
Received: from mail-pd0-f171.google.com ([209.85.192.171]:34430 "EHLO
        mail-pd0-f171.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6832653AbaDMAZedcsPw (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 13 Apr 2014 02:25:34 +0200
Received: by mail-pd0-f171.google.com with SMTP id r10so6705460pdi.16
        for <multiple recipients>; Sat, 12 Apr 2014 17:25:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=LlOE57YNuRzDkiWABcinkmjCmdSc5PvMHjfpX1DWiu4=;
        b=chJGZgH75pVNWIYN1vzZuC3lB2Mg6cQFJF/mHvXBPxNHOZdQWrgBDASyzO02j1SdnM
         3/FssXEKKvQlXDbAaRU63FXjZ/MTt2lHqakux8nMC+XY0yoKftY0GTN0UN/Q+B0W25ZL
         Uw5r4q4HA48KDDjHKFSY0ItiRwQvRAZnhXQ2QQ0hnpTiAQgNZzlF/WT/WQNLB6pEPAFT
         78usuRzGeepoMX+lFB79Y8DDkzsCQ8abKDr1Qp5qvfwKlYbqXUs2vT/MjNYUHAAJOlZ6
         dp2KBM8AoIQpT4+VVpd2eu9KiHGXm7L+x4XWSiMJ2MZ661RLwXuKjLlaFy6zmMA+JvcW
         JLbg==
X-Received: by 10.66.216.137 with SMTP id oq9mr35475134pac.97.1397348728341;
        Sat, 12 Apr 2014 17:25:28 -0700 (PDT)
Received: from localhost.localdomain ([222.92.8.142])
        by mx.google.com with ESMTPSA id sh5sm24474879pbc.21.2014.04.12.17.25.22
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Sat, 12 Apr 2014 17:25:27 -0700 (PDT)
From:   Huacai Chen <chenhc@lemote.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     John Crispin <john@phrozen.org>,
        "Steven J. Hill" <Steven.Hill@imgtec.com>,
        Aurelien Jarno <aurelien@aurel32.net>,
        linux-mips@linux-mips.org, Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>,
        Huacai Chen <chenhc@lemote.com>
Subject: [PATCH V2 7/8] MIPS: Loongson-3: Enable the COP2 usage
Date:   Sun, 13 Apr 2014 08:24:21 +0800
Message-Id: <1397348662-22502-8-git-send-email-chenhc@lemote.com>
X-Mailer: git-send-email 1.7.7.3
In-Reply-To: <1397348662-22502-1-git-send-email-chenhc@lemote.com>
References: <1397348662-22502-1-git-send-email-chenhc@lemote.com>
Return-Path: <chenhuacai@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 39790
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: chenhc@lemote.com
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

Loongson-3 has some specific instructions (MMI/SIMD) in coprocessor 2.
COP2 isn't independent because it share COP1 (FPU)'s registers. This
patch enable the COP2 usage so user-space programs can use the MMI/SIMD
instructions. When COP2 exception happens, we enable both COP1 (FPU)
and COP2, only in this way the fp context can be saved and restored
correctly.

Signed-off-by: Huacai Chen <chenhc@lemote.com>
---
 arch/mips/include/asm/cop2.h            |    8 ++++
 arch/mips/loongson/loongson-3/Makefile  |    2 +-
 arch/mips/loongson/loongson-3/cop2-ex.c |   63 +++++++++++++++++++++++++++++++
 3 files changed, 72 insertions(+), 1 deletions(-)
 create mode 100644 arch/mips/loongson/loongson-3/cop2-ex.c

diff --git a/arch/mips/include/asm/cop2.h b/arch/mips/include/asm/cop2.h
index c1516cc..d035298 100644
--- a/arch/mips/include/asm/cop2.h
+++ b/arch/mips/include/asm/cop2.h
@@ -32,6 +32,14 @@ extern void nlm_cop2_restore(struct nlm_cop2_state *);
 #define cop2_present		1
 #define cop2_lazy_restore	0
 
+#elif defined(CONFIG_CPU_LOONGSON3)
+
+#define cop2_save(r)
+#define cop2_restore(r)
+
+#define cop2_present		1
+#define cop2_lazy_restore	1
+
 #else
 
 #define cop2_present		0
diff --git a/arch/mips/loongson/loongson-3/Makefile b/arch/mips/loongson/loongson-3/Makefile
index 471b0f2a..b4df775 100644
--- a/arch/mips/loongson/loongson-3/Makefile
+++ b/arch/mips/loongson/loongson-3/Makefile
@@ -1,7 +1,7 @@
 #
 # Makefile for Loongson-3 family machines
 #
-obj-y			+= irq.o
+obj-y			+= irq.o cop2-ex.o
 
 obj-$(CONFIG_SMP)	+= smp.o
 
diff --git a/arch/mips/loongson/loongson-3/cop2-ex.c b/arch/mips/loongson/loongson-3/cop2-ex.c
new file mode 100644
index 0000000..9182e8d
--- /dev/null
+++ b/arch/mips/loongson/loongson-3/cop2-ex.c
@@ -0,0 +1,63 @@
+/*
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ *
+ * Copyright (C) 2014 Lemote Corporation.
+ *   written by Huacai Chen <chenhc@lemote.com>
+ *
+ * based on arch/mips/cavium-octeon/cpu.c
+ * Copyright (C) 2009 Wind River Systems,
+ *   written by Ralf Baechle <ralf@linux-mips.org>
+ */
+#include <linux/init.h>
+#include <linux/sched.h>
+#include <linux/notifier.h>
+
+#include <asm/fpu.h>
+#include <asm/cop2.h>
+#include <asm/current.h>
+#include <asm/mipsregs.h>
+
+static int loongson_cu2_call(struct notifier_block *nfb, unsigned long action,
+	void *data)
+{
+	int fpu_enabled;
+	int fr = !test_thread_flag(TIF_32BIT_FPREGS);
+
+	switch (action) {
+	case CU2_EXCEPTION:
+		preempt_disable();
+		fpu_enabled = read_c0_status() & ST0_CU1;
+		if (!fr)
+			set_c0_status(ST0_CU1 | ST0_CU2);
+		else
+			set_c0_status(ST0_CU1 | ST0_CU2 | ST0_FR);
+		enable_fpu_hazard();
+		KSTK_STATUS(current) |= (ST0_CU1 | ST0_CU2);
+		if (fr)
+			KSTK_STATUS(current) |= ST0_FR;
+		else
+			KSTK_STATUS(current) &= ~ST0_FR;
+		/* If FPU is enabled, we needn't init or restore fp */
+		if(!fpu_enabled) {
+			set_thread_flag(TIF_USEDFPU);
+			if (!used_math()) {
+				_init_fpu();
+				set_used_math();
+			} else
+				_restore_fp(current);
+		}
+		preempt_enable();
+
+		return NOTIFY_STOP;	/* Don't call default notifier */
+	}
+
+	return NOTIFY_OK;		/* Let default notifier send signals */
+}
+
+static int __init loongson_cu2_setup(void)
+{
+	return cu2_notifier(loongson_cu2_call, 0);
+}
+early_initcall(loongson_cu2_setup);
-- 
1.7.7.3
