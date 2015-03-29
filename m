Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 29 Mar 2015 04:54:50 +0200 (CEST)
Received: from smtpbgbr2.qq.com ([54.207.22.56]:44170 "EHLO smtpbgbr2.qq.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27006694AbbC2CyqqBfqq (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sun, 29 Mar 2015 04:54:46 +0200
X-QQ-mid: bizesmtp2t1427597660t416t115
Received: from localhost.localdomain (unknown [222.92.8.142])
        by esmtp4.qq.com (ESMTP) with 
        id ; Sun, 29 Mar 2015 10:54:19 +0800 (CST)
X-QQ-SSF: 01100000002000F0FJ52B00A0000000
X-QQ-FEAT: ct8bDOb4/pUiOOxV9bIMXh7lLbp7ZVrnFI+mYs1jm8Sf4TAkSCoy/iY7VKxk1
        +TeqtYDbGu768EPJ/mEohmaPrhL3CPkwJ/wrrj5j+vf/ThPjt8aSui+2MYNBMSv5aEEllaw
        hwV0wFbo3JXe2TtssJb/mIZovlPzG9Rs3fhhd0EfmHu/1qh4kNQGnLpvQZAv9Tt4RHhGRNx
        p/+MLtU6Ee9phVuMgihQxTPrrGWBXs4hAInaZ+7frQg==
X-QQ-GoodBg: 0
From:   Huacai Chen <chenhc@lemote.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     "Steven J. Hill" <Steven.Hill@imgtec.com>,
        linux-mips@linux-mips.org, Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>,
        Huacai Chen <chenhc@lemote.com>
Subject: [PATCH V9 2/7] MIPS: Hibernate: Restructure files and functions
Date:   Sun, 29 Mar 2015 10:54:06 +0800
Message-Id: <1427597650-2368-3-git-send-email-chenhc@lemote.com>
X-Mailer: git-send-email 1.7.7.3
In-Reply-To: <1427597650-2368-1-git-send-email-chenhc@lemote.com>
References: <1427597650-2368-1-git-send-email-chenhc@lemote.com>
X-QQ-SENDSIZE: 520
X-QQ-Bgrelay: 1
Return-Path: <chenhc@lemote.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 46578
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

This patch has no functional changes, it just to keep the assembler
code to a minimum. Files and functions naming is borrowed from X86.

Signed-off-by: Huacai Chen <chenhc@lemote.com>
---
 arch/mips/power/Makefile        |    2 +-
 arch/mips/power/hibernate.S     |   63 ---------------------------------------
 arch/mips/power/hibernate.c     |   10 ++++++
 arch/mips/power/hibernate_asm.S |   61 +++++++++++++++++++++++++++++++++++++
 4 files changed, 72 insertions(+), 64 deletions(-)
 delete mode 100644 arch/mips/power/hibernate.S
 create mode 100644 arch/mips/power/hibernate.c
 create mode 100644 arch/mips/power/hibernate_asm.S

diff --git a/arch/mips/power/Makefile b/arch/mips/power/Makefile
index 73d56b8..70bd788 100644
--- a/arch/mips/power/Makefile
+++ b/arch/mips/power/Makefile
@@ -1 +1 @@
-obj-$(CONFIG_HIBERNATION) += cpu.o hibernate.o
+obj-$(CONFIG_HIBERNATION) += cpu.o hibernate.o hibernate_asm.o
diff --git a/arch/mips/power/hibernate.S b/arch/mips/power/hibernate.S
deleted file mode 100644
index e7567c8..0000000
--- a/arch/mips/power/hibernate.S
+++ /dev/null
@@ -1,63 +0,0 @@
-/*
- * Hibernation support specific for mips - temporary page tables
- *
- * Licensed under the GPLv2
- *
- * Copyright (C) 2009 Lemote Inc.
- * Author: Hu Hongbing <huhb@lemote.com>
- *	   Wu Zhangjin <wuzhangjin@gmail.com>
- */
-#include <asm/asm-offsets.h>
-#include <asm/regdef.h>
-#include <asm/asm.h>
-
-.text
-LEAF(swsusp_arch_suspend)
-	PTR_LA t0, saved_regs
-	PTR_S ra, PT_R31(t0)
-	PTR_S sp, PT_R29(t0)
-	PTR_S fp, PT_R30(t0)
-	PTR_S gp, PT_R28(t0)
-	PTR_S s0, PT_R16(t0)
-	PTR_S s1, PT_R17(t0)
-	PTR_S s2, PT_R18(t0)
-	PTR_S s3, PT_R19(t0)
-	PTR_S s4, PT_R20(t0)
-	PTR_S s5, PT_R21(t0)
-	PTR_S s6, PT_R22(t0)
-	PTR_S s7, PT_R23(t0)
-	j swsusp_save
-END(swsusp_arch_suspend)
-
-LEAF(swsusp_arch_resume)
-	/* Avoid TLB mismatch during and after kernel resume */
-	jal local_flush_tlb_all
-	PTR_L t0, restore_pblist
-0:
-	PTR_L t1, PBE_ADDRESS(t0)   /* source */
-	PTR_L t2, PBE_ORIG_ADDRESS(t0) /* destination */
-	PTR_ADDU t3, t1, _PAGE_SIZE
-1:
-	REG_L t8, (t1)
-	REG_S t8, (t2)
-	PTR_ADDIU t1, t1, SZREG
-	PTR_ADDIU t2, t2, SZREG
-	bne t1, t3, 1b
-	PTR_L t0, PBE_NEXT(t0)
-	bnez t0, 0b
-	PTR_LA t0, saved_regs
-	PTR_L ra, PT_R31(t0)
-	PTR_L sp, PT_R29(t0)
-	PTR_L fp, PT_R30(t0)
-	PTR_L gp, PT_R28(t0)
-	PTR_L s0, PT_R16(t0)
-	PTR_L s1, PT_R17(t0)
-	PTR_L s2, PT_R18(t0)
-	PTR_L s3, PT_R19(t0)
-	PTR_L s4, PT_R20(t0)
-	PTR_L s5, PT_R21(t0)
-	PTR_L s6, PT_R22(t0)
-	PTR_L s7, PT_R23(t0)
-	PTR_LI v0, 0x0
-	jr ra
-END(swsusp_arch_resume)
diff --git a/arch/mips/power/hibernate.c b/arch/mips/power/hibernate.c
new file mode 100644
index 0000000..19a9af6
--- /dev/null
+++ b/arch/mips/power/hibernate.c
@@ -0,0 +1,10 @@
+#include <asm/tlbflush.h>
+
+extern int restore_image(void);
+
+int swsusp_arch_resume(void)
+{
+	/* Avoid TLB mismatch during and after kernel resume */
+	local_flush_tlb_all();
+	return restore_image();
+}
diff --git a/arch/mips/power/hibernate_asm.S b/arch/mips/power/hibernate_asm.S
new file mode 100644
index 0000000..b1fab95
--- /dev/null
+++ b/arch/mips/power/hibernate_asm.S
@@ -0,0 +1,61 @@
+/*
+ * Hibernation support specific for mips - temporary page tables
+ *
+ * Licensed under the GPLv2
+ *
+ * Copyright (C) 2009 Lemote Inc.
+ * Author: Hu Hongbing <huhb@lemote.com>
+ *	   Wu Zhangjin <wuzhangjin@gmail.com>
+ */
+#include <asm/asm-offsets.h>
+#include <asm/regdef.h>
+#include <asm/asm.h>
+
+.text
+LEAF(swsusp_arch_suspend)
+	PTR_LA t0, saved_regs
+	PTR_S ra, PT_R31(t0)
+	PTR_S sp, PT_R29(t0)
+	PTR_S fp, PT_R30(t0)
+	PTR_S gp, PT_R28(t0)
+	PTR_S s0, PT_R16(t0)
+	PTR_S s1, PT_R17(t0)
+	PTR_S s2, PT_R18(t0)
+	PTR_S s3, PT_R19(t0)
+	PTR_S s4, PT_R20(t0)
+	PTR_S s5, PT_R21(t0)
+	PTR_S s6, PT_R22(t0)
+	PTR_S s7, PT_R23(t0)
+	j swsusp_save
+END(swsusp_arch_suspend)
+
+LEAF(restore_image)
+	PTR_L t0, restore_pblist
+0:
+	PTR_L t1, PBE_ADDRESS(t0)   /* source */
+	PTR_L t2, PBE_ORIG_ADDRESS(t0) /* destination */
+	PTR_ADDU t3, t1, _PAGE_SIZE
+1:
+	REG_L t8, (t1)
+	REG_S t8, (t2)
+	PTR_ADDIU t1, t1, SZREG
+	PTR_ADDIU t2, t2, SZREG
+	bne t1, t3, 1b
+	PTR_L t0, PBE_NEXT(t0)
+	bnez t0, 0b
+	PTR_LA t0, saved_regs
+	PTR_L ra, PT_R31(t0)
+	PTR_L sp, PT_R29(t0)
+	PTR_L fp, PT_R30(t0)
+	PTR_L gp, PT_R28(t0)
+	PTR_L s0, PT_R16(t0)
+	PTR_L s1, PT_R17(t0)
+	PTR_L s2, PT_R18(t0)
+	PTR_L s3, PT_R19(t0)
+	PTR_L s4, PT_R20(t0)
+	PTR_L s5, PT_R21(t0)
+	PTR_L s6, PT_R22(t0)
+	PTR_L s7, PT_R23(t0)
+	PTR_LI v0, 0x0
+	jr ra
+END(restore_image)
-- 
1.7.7.3
