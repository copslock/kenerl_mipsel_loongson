Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 06 Apr 2014 00:52:26 +0200 (CEST)
Received: from mail-we0-f170.google.com ([74.125.82.170]:52125 "EHLO
        mail-we0-f170.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6816414AbaDEWwYlChd3 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 6 Apr 2014 00:52:24 +0200
Received: by mail-we0-f170.google.com with SMTP id w61so5123648wes.1
        for <linux-mips@linux-mips.org>; Sat, 05 Apr 2014 15:52:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=ACjRDflIhhjGgdh2FnwJcfw9CJSGRNIXr/F/fSkkxss=;
        b=pWHQb937NzDFIdCQBlH7f8r9YzVnHwFFvSrfLa9amB5BHUVadJ2lzQlJBXS5TvrVnL
         YzUzqdShwLEHKHV5OPlqZq4Nb3OUZ7fa9rk/+CZg/OB/VsYofHLtj+cPTmeXbkjACbII
         nDYn0eweFa3vCRhPG25/SheczaSbFwQFA9ebGpTA7YkSqeYRIEpN9FpL7fa0RfHdDeQr
         6qwPBv2a8eOgYj2MZ9NDWJ22+yAEIYxLiLZCEMwbrUCA8tF7rKCgBeQA/H2ocdKEL7Mg
         tcBsD0JRBT2vrLH6uC9nkgMGF7mptp/9tMGt2uLKy4rdKquVqfOGQq1ilG63jdInDNuo
         jXKg==
X-Received: by 10.194.118.163 with SMTP id kn3mr30622406wjb.77.1396738339283;
        Sat, 05 Apr 2014 15:52:19 -0700 (PDT)
Received: from localhost.localdomain (p57A35A0F.dip0.t-ipconnect.de. [87.163.90.15])
        by mx.google.com with ESMTPSA id x45sm30116427eeu.23.2014.04.05.15.52.18
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 05 Apr 2014 15:52:18 -0700 (PDT)
From:   Manuel Lauss <manuel.lauss@gmail.com>
To:     Linux-MIPS <linux-mips@linux-mips.org>
Cc:     Manuel Lauss <manuel.lauss@gmail.com>
Subject: [RFC PATCH] MIPS: make FPU emulator optional
Date:   Sun,  6 Apr 2014 00:52:15 +0200
Message-Id: <1396738335-475011-1-git-send-email-manuel.lauss@gmail.com>
X-Mailer: git-send-email 1.9.1
Return-Path: <manuel.lauss@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 39660
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: manuel.lauss@gmail.com
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

Add a config option to disable the FPU emulator.
Saves around 56kB on 32bit, and kills FPU users with SIGILL.

Signed-off-by: Manuel Lauss <manuel.lauss@gmail.com>
---
 arch/mips/Kbuild                     |  2 ++
 arch/mips/Kconfig                    | 14 ++++++++++++++
 arch/mips/include/asm/fpu.h          |  2 ++
 arch/mips/include/asm/fpu_emulator.h | 24 +++++++++++++++++++++++-
 4 files changed, 41 insertions(+), 1 deletion(-)

diff --git a/arch/mips/Kbuild b/arch/mips/Kbuild
index d2cfe45..da76dc0 100644
--- a/arch/mips/Kbuild
+++ b/arch/mips/Kbuild
@@ -16,7 +16,9 @@ obj- := $(platform-)
 
 obj-y += kernel/
 obj-y += mm/
+ifdef CONFIG_MIPS_FPU_EMULATOR
 obj-y += math-emu/
+endif
 
 ifdef CONFIG_KVM
 obj-y += kvm/
diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 9b53358..9a8d7ed 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -2482,6 +2482,20 @@ config MIPS_O32_FP64_SUPPORT
 
 	  If unsure, say N.
 
+config MIPS_FPU_EMULATOR
+	bool "Support for MIPS FPU Emulator"
+	default y
+	help
+	  This option lets you disable the built-in MIPS FPU (Cop1)
+	  Emulator.  This emulator executes floating-point instructions on
+	  processors which don't have a built-in floating point unit.
+	  It is generally a very good idea to keep this support built in,
+	  only disable it if you have a complete soft-float userland.
+	  Any use of floating point operations in userspace will result in
+	  the process being killed with an illegal instruction exception.
+
+	  Say Y, please.
+
 config USE_OF
 	bool
 	select OF
diff --git a/arch/mips/include/asm/fpu.h b/arch/mips/include/asm/fpu.h
index 4d86b72..d6c3d97 100644
--- a/arch/mips/include/asm/fpu.h
+++ b/arch/mips/include/asm/fpu.h
@@ -161,7 +161,9 @@ static inline int init_fpu(void)
 		if (!ret)
 			_init_fpu();
 	} else {
+#ifdef CONFIG_MIPS_FPU_EMULATOR
 		fpu_emulator_init_fpu();
+#endif
 	}
 
 	preempt_enable();
diff --git a/arch/mips/include/asm/fpu_emulator.h b/arch/mips/include/asm/fpu_emulator.h
index 2abb587..b2c1524 100644
--- a/arch/mips/include/asm/fpu_emulator.h
+++ b/arch/mips/include/asm/fpu_emulator.h
@@ -53,13 +53,35 @@ do {									\
 
 extern int mips_dsemul(struct pt_regs *regs, mips_instruction ir,
 	unsigned long cpc);
+int process_fpemu_return(int sig, void __user *fault_addr);
+
+#ifdef CONFIG_MIPS_FPU_EMULATOR
 extern int do_dsemulret(struct pt_regs *xcp);
 extern int fpu_emulator_cop1Handler(struct pt_regs *xcp,
 				    struct mips_fpu_struct *ctx, int has_fpu,
 				    void *__user *fault_addr);
-int process_fpemu_return(int sig, void __user *fault_addr);
 int mm_isBranchInstr(struct pt_regs *regs, struct mm_decoded_insn dec_insn,
 		     unsigned long *contpc);
+#else	/* no CONFIG_MIPS_FPU_EMULATOR */
+static inline int do_dsemulret(struct pt_regs *xcp)
+{
+	return 0;	/* 0 means error, should never get here anyway */
+}
+
+static inline int fpu_emulator_cop1Handler(struct pt_regs *xcp,
+				struct mips_fpu_struct *ctx, int has_fpu,
+				void *__user *fault_addr)
+{
+	return SIGILL;	/* we don't speak MIPS FPU */
+}
+
+static inline int mm_isBranchInstr(struct pt_regs *regs,
+				   struct mm_decoded_insn dec_insn,
+				   unsigned long *contpc)
+{
+	return 0;
+}
+#endif	/* CONFIG_MIPS_FPU_EMULATOR */
 
 /*
  * Instruction inserted following the badinst to further tag the sequence
-- 
1.9.1
