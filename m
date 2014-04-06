Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 06 Apr 2014 12:52:01 +0200 (CEST)
Received: from mail-wi0-f176.google.com ([209.85.212.176]:58662 "EHLO
        mail-wi0-f176.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6816414AbaDFKv7pWw9A (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 6 Apr 2014 12:51:59 +0200
Received: by mail-wi0-f176.google.com with SMTP id r20so3542336wiv.15
        for <linux-mips@linux-mips.org>; Sun, 06 Apr 2014 03:51:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=AUKaRD8smcfzz06xDQ4HETpqyCcGCTUXH4vyblEM8Z0=;
        b=Upom5so67ppCq3HY9EcZD0xPYEHhdBB+m4Urb7hjxGTq5YkSr+wUD/LdXyK1ezAQh0
         IKyzRX9zhLtZeuzkbFLpAue9KKGwbvrq2ov/80OEmwN//T6d8weEHvWCWmZZPvtPXlJu
         2MLMu7g1P92WyO0FbAuhZ+BPcKBvgBudeOeJSBmOIoKSSiQ+86UwgyTTdHfcRLKpLrkN
         M1jTKfAtiaJ8i9T/5xW+URkwaukKENYYXJo5ZVturfw3FJEK0j1irnHmAG80OLyCXlB6
         VbPBDrUSTfwNcJeY0+KVbH67hd1eROjWbFQRBXyhzcc3Ne76bn83CgtI+WOKy/proVJX
         GGfw==
X-Received: by 10.180.19.69 with SMTP id c5mr17970897wie.7.1396781514312;
        Sun, 06 Apr 2014 03:51:54 -0700 (PDT)
Received: from localhost.localdomain (p57A3584A.dip0.t-ipconnect.de. [87.163.88.74])
        by mx.google.com with ESMTPSA id a4sm33602814eep.12.2014.04.06.03.51.53
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 06 Apr 2014 03:51:53 -0700 (PDT)
From:   Manuel Lauss <manuel.lauss@gmail.com>
To:     Linux-MIPS <linux-mips@linux-mips.org>
Cc:     Manuel Lauss <manuel.lauss@gmail.com>
Subject: [RFC PATCH v2] MIPS: make FPU emulator optional
Date:   Sun,  6 Apr 2014 12:51:48 +0200
Message-Id: <1396781508-622215-1-git-send-email-manuel.lauss@gmail.com>
X-Mailer: git-send-email 1.9.1
Return-Path: <manuel.lauss@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 39664
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

This small patch makes the MIPS FPU emulator optional. The kernel
kills float-users on systems without a hardware FPU by sending a SIGILL.

The Emulator can't be turned off on systems which support microMIPS
because parts of the microMIPS support code live in the emu code.

Signed-off-by: Manuel Lauss <manuel.lauss@gmail.com>
---
v2: incorporated changes suggested by Hauke Mehrtens,
    force the fpu emulator on for micromips: relocating the parts
    of the mmips code in the emulator to other areas would be a
    much larger change; I went the cheap route instead with this.

Disabling the emulator saves about 54kBytes (32bit, optimizing for size).

 arch/mips/Kbuild                     |  2 +-
 arch/mips/Kconfig                    | 15 +++++++++++++++
 arch/mips/include/asm/fpu.h          |  5 +++--
 arch/mips/include/asm/fpu_emulator.h | 27 ++++++++++++++++++++++++++-
 4 files changed, 45 insertions(+), 4 deletions(-)

diff --git a/arch/mips/Kbuild b/arch/mips/Kbuild
index d2cfe45..426c264 100644
--- a/arch/mips/Kbuild
+++ b/arch/mips/Kbuild
@@ -16,7 +16,7 @@ obj- := $(platform-)
 
 obj-y += kernel/
 obj-y += mm/
-obj-y += math-emu/
+obj-$(CONFIG_MIPS_FPU_EMULATOR) += math-emu/
 
 ifdef CONFIG_KVM
 obj-y += kvm/
diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 9b53358..e9dd80e 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -2208,6 +2208,7 @@ config SYS_SUPPORTS_SMARTMIPS
 
 config SYS_SUPPORTS_MICROMIPS
 	bool
+	select MIPS_FPU_EMULATOR	# houses tiny parts of the mmips code
 
 config CPU_SUPPORTS_MSA
 	bool
@@ -2482,6 +2483,20 @@ config MIPS_O32_FP64_SUPPORT
 
 	  If unsure, say N.
 
+config MIPS_FPU_EMULATOR
+	bool "MIPS FPU Emulator"
+	default y
+	help
+	  This option lets you disable the built-in MIPS FPU (Coprocessor 1)
+	  emulator, which handles floating-point instructions on processors
+	  without a hardware FPU.  It is generally a good idea to keep the
+	  emulator built-in, unless you are perfectly sure you have a
+	  complete soft-float environment.  With the emulator disabled, all
+	  users of float operations will be killed with an illegal instr-
+	  uction exception.
+
+	  Say Y, please.
+
 config USE_OF
 	bool
 	select OF
diff --git a/arch/mips/include/asm/fpu.h b/arch/mips/include/asm/fpu.h
index 4d86b72..c5203bb 100644
--- a/arch/mips/include/asm/fpu.h
+++ b/arch/mips/include/asm/fpu.h
@@ -160,9 +160,10 @@ static inline int init_fpu(void)
 		ret = __own_fpu();
 		if (!ret)
 			_init_fpu();
-	} else {
+	} else if (IS_ENABLED(CONFIG_MIPS_FPU_EMULATOR))
 		fpu_emulator_init_fpu();
-	}
+	else
+		ret = SIGILL;
 
 	preempt_enable();
 	return ret;
diff --git a/arch/mips/include/asm/fpu_emulator.h b/arch/mips/include/asm/fpu_emulator.h
index 2abb587..26a71ba 100644
--- a/arch/mips/include/asm/fpu_emulator.h
+++ b/arch/mips/include/asm/fpu_emulator.h
@@ -27,6 +27,7 @@
 #include <asm/inst.h>
 #include <asm/local.h>
 
+#ifdef CONFIG_MIPS_FPU_EMULATOR
 #ifdef CONFIG_DEBUG_FS
 
 struct mips_fpu_emulator_stats {
@@ -57,9 +58,33 @@ extern int do_dsemulret(struct pt_regs *xcp);
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
+	BUG();		/* should never ever get here */
+	return 0;
+}
+#endif	/* CONFIG_MIPS_FPU_EMULATOR */
+
+
+int process_fpemu_return(int sig, void __user *fault_addr);
+
 
 /*
  * Instruction inserted following the badinst to further tag the sequence
-- 
1.9.1
