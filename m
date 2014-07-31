Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 31 Jul 2014 03:06:55 +0200 (CEST)
Received: from mail-pa0-f50.google.com ([209.85.220.50]:36931 "EHLO
        mail-pa0-f50.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6860095AbaGaBGwNu7vn (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 31 Jul 2014 03:06:52 +0200
Received: by mail-pa0-f50.google.com with SMTP id et14so2569430pad.9
        for <multiple recipients>; Wed, 30 Jul 2014 18:06:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id;
        bh=FEJAYoCRDydAXyYA38gx7XA5LOF33UoCQ36NjwoC230=;
        b=APjRT600kuYTCxdZDeKklsHu+CMqRVVT3iWCnH8V9BRRyGe/PttvhIRQBd+faXjk2z
         mwqPoeNpIj4yABfYUEm+0pfKYbOfXji9jQtcmUm0w8+GFW65up2XXOV1sghteTqFLee3
         WwVyyoA0h0UfVykC338j0yCwhzNB13Q7SNh/q5tGcF+WCQvcztfatJ9QFyUR0ViKWSlu
         KNciPle5EA185p+nODno8kusT6omc5l6STOCghw0DYSVocjS88XaX2RfuWk7VYNjRcel
         hyltLr11fzLHN4trOCNG/hVEwZas3JIR302cMHX/hREAxfrTvPpO2N3VkpbtnsqkFjbF
         GtKg==
X-Received: by 10.66.189.66 with SMTP id gg2mr656562pac.103.1406768805563;
        Wed, 30 Jul 2014 18:06:45 -0700 (PDT)
Received: from localhost.localdomain ([222.92.8.142])
        by mx.google.com with ESMTPSA id h2sm5566877pdo.17.2014.07.30.18.06.37
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Wed, 30 Jul 2014 18:06:44 -0700 (PDT)
From:   Huacai Chen <chenhc@lemote.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     John Crispin <john@phrozen.org>,
        "Steven J. Hill" <Steven.Hill@imgtec.com>,
        Aurelien Jarno <aurelien@aurel32.net>,
        linux-mips@linux-mips.org, Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>,
        Huacai Chen <chenhc@lemote.com>
Subject: [PATCH V4] MIPS: Loongson-3: Enable the COP2 usage
Date:   Thu, 31 Jul 2014 09:06:22 +0800
Message-Id: <1406768782-14644-1-git-send-email-chenhc@lemote.com>
X-Mailer: git-send-email 1.7.7.3
Return-Path: <chenhuacai@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 41831
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

V4: Make it work fine in preemptible kernel.

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
index 0000000..c1e9503
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
+	int fpu_owned;
+	int fr = !test_thread_flag(TIF_32BIT_FPREGS);
+
+	switch (action) {
+	case CU2_EXCEPTION:
+		preempt_disable();
+		fpu_owned = __is_fpu_owner();
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
+		/* If FPU is owned, we needn't init or restore fp */
+		if(!fpu_owned) {
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
