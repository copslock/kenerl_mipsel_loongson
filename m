Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 08 Apr 2014 13:38:35 +0200 (CEST)
Received: from mail-ee0-f44.google.com ([74.125.83.44]:64147 "EHLO
        mail-ee0-f44.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6821088AbaDHLiKfwqhb (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 8 Apr 2014 13:38:10 +0200
Received: by mail-ee0-f44.google.com with SMTP id e49so564529eek.31
        for <linux-mips@linux-mips.org>; Tue, 08 Apr 2014 04:38:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=5MVcw9mu/TCtfurR1MrD9UVYrQUD0IAL/j7brP8QgLQ=;
        b=kuz9COQnov8zq1TILUVEGrOPrEdGd5mCI2jM+XbMWEIKHKgNYI3wTohDolZrIMNIWk
         DLgqx5Or6/ATo3S7Pf1SE/EmL+Ps3YJsyAq3Ruzt+eu3xlmICp9YefUfy6lViVt/9iRq
         itIqpa4FpNOBxoqHzGaTpIeQM0snp3FP+4WNZaFJKWCjz1R1dzcJojfRaVqRcntwh61a
         eyPqUWPfGEQ6mIl5kHl/jEr0unMqMuRGO7A8S9IV98MYhLq6OLOOD1s2z8/T1n/xznH3
         AoQt0xyiajtZg7MV+3aMAbtbQzZgGJIvLagO3qBo/2qYAoYZkaH7ViG1y9jWAfTJbKK2
         jNUA==
X-Received: by 10.15.60.199 with SMTP id g47mr4030563eex.37.1396957084350;
        Tue, 08 Apr 2014 04:38:04 -0700 (PDT)
Received: from localhost.localdomain (p4FD8D7E8.dip0.t-ipconnect.de. [79.216.215.232])
        by mx.google.com with ESMTPSA id o5sm4121006eeg.8.2014.04.08.04.38.03
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 08 Apr 2014 04:38:03 -0700 (PDT)
From:   Manuel Lauss <manuel.lauss@gmail.com>
To:     Linux-MIPS <linux-mips@linux-mips.org>
Cc:     Manuel Lauss <manuel.lauss@gmail.com>
Subject: [PATCH v7 2/2] MIPS: optional floating point support
Date:   Tue,  8 Apr 2014 13:37:59 +0200
Message-Id: <1396957079-403359-2-git-send-email-manuel.lauss@gmail.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1396957079-403359-1-git-send-email-manuel.lauss@gmail.com>
References: <1396957079-403359-1-git-send-email-manuel.lauss@gmail.com>
Return-Path: <manuel.lauss@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 39706
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

This small patch makes the floating point support and the FPU-emulator
optional.  A Warning will be printed once when first use of floating
point is detected.

Disabling fpu support shrinks vmlinux by about 54kBytes (32bit,
optimizing for size), and it is mainly useful for embedded devices
which have no need for float math (e.g. routers).

Signed-off-by: Manuel Lauss <manuel.lauss@gmail.com>
---
v7: codingstyle, checkpatch (Jonas Gorski)
v6: complain in kernel log about first attempted use of float ops.
v5: now disable float support completely to avoid sudden program crashes
    on buggy fpus when the fpu emulator cannot take over (suggested by
    Paul Burton).
v4: rediffed because of patch 1/2, should now work with micromips as well
v3: updated patch description with size savings.
v2: incorporated changes suggested by Jonas Gorski
    force the fpu emulator on for micromips: relocating the parts
    of the mmips code in the emulator to other areas would be a
    much larger change; I went the cheap route instead with this.

 arch/mips/Kbuild                     |  2 +-
 arch/mips/Kconfig                    | 11 +++++++++++
 arch/mips/include/asm/fpu.h          | 24 ++++++++++++++++--------
 arch/mips/include/asm/fpu_emulator.h | 15 +++++++++++++++
 4 files changed, 43 insertions(+), 9 deletions(-)

diff --git a/arch/mips/Kbuild b/arch/mips/Kbuild
index d2cfe45..730e0a7 100644
--- a/arch/mips/Kbuild
+++ b/arch/mips/Kbuild
@@ -16,7 +16,7 @@ obj- := $(platform-)
 
 obj-y += kernel/
 obj-y += mm/
-obj-y += math-emu/
+obj-$(CONFIG_MIPS_FPU_SUPPORT) += math-emu/
 
 ifdef CONFIG_KVM
 obj-y += kvm/
diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 9b53358..c8040db 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -2482,6 +2482,17 @@ config MIPS_O32_FP64_SUPPORT
 
 	  If unsure, say N.
 
+config MIPS_FPU_SUPPORT
+	bool "MIPS FPU Support"
+	default y
+	help
+	  Support for floating point registers and FP-hardware, and also
+	  the in-kernel FPU emulator.  Disabling this option will result
+	  in all uses of floating point hardware to be killed with an
+	  illegal instruction exception, and about a 50kB smaller kernel.
+
+	  Say Y.
+
 config USE_OF
 	bool
 	select OF
diff --git a/arch/mips/include/asm/fpu.h b/arch/mips/include/asm/fpu.h
index 4d86b72..954f52d 100644
--- a/arch/mips/include/asm/fpu.h
+++ b/arch/mips/include/asm/fpu.h
@@ -155,16 +155,24 @@ static inline int init_fpu(void)
 {
 	int ret = 0;
 
-	preempt_disable();
-	if (cpu_has_fpu) {
-		ret = __own_fpu();
-		if (!ret)
-			_init_fpu();
+	if (IS_ENABLED(CONFIG_MIPS_FPU_SUPPORT)) {
+		preempt_disable();
+		if (cpu_has_fpu) {
+			ret = __own_fpu();
+			if (!ret)
+				_init_fpu();
+		} else {
+			fpu_emulator_init_fpu();
+		}
+		preempt_enable();
 	} else {
-		fpu_emulator_init_fpu();
+		static int first = 1;
+		if (likely(first)) {
+			first = 0;
+			pr_err("FPU support disabled, but FPU use detected!\n");
+		}
+		ret = SIGILL;
 	}
-
-	preempt_enable();
 	return ret;
 }
 
diff --git a/arch/mips/include/asm/fpu_emulator.h b/arch/mips/include/asm/fpu_emulator.h
index 283e6f3..552a054 100644
--- a/arch/mips/include/asm/fpu_emulator.h
+++ b/arch/mips/include/asm/fpu_emulator.h
@@ -27,6 +27,7 @@
 #include <asm/inst.h>
 #include <asm/local.h>
 
+#ifdef CONFIG_MIPS_FPU_SUPPORT
 #ifdef CONFIG_DEBUG_FS
 
 struct mips_fpu_emulator_stats {
@@ -57,6 +58,20 @@ extern int do_dsemulret(struct pt_regs *xcp);
 extern int fpu_emulator_cop1Handler(struct pt_regs *xcp,
 				    struct mips_fpu_struct *ctx, int has_fpu,
 				    void *__user *fault_addr);
+#else	/* no CONFIG_MIPS_FPU_SUPPORT */
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
+#endif	/* CONFIG_MIPS_FPU_SUPPORT */
+
 int process_fpemu_return(int sig, void __user *fault_addr);
 
 /*
-- 
1.9.1
