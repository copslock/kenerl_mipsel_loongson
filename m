Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 07 Apr 2014 19:54:07 +0200 (CEST)
Received: from mail-ee0-f46.google.com ([74.125.83.46]:48498 "EHLO
        mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6816886AbaDGRxpERwxD (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 7 Apr 2014 19:53:45 +0200
Received: by mail-ee0-f46.google.com with SMTP id t10so873564eei.5
        for <linux-mips@linux-mips.org>; Mon, 07 Apr 2014 10:53:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=xB8jo1lv3psyaifZo49Kodrak0oZBixoG23KzyRtweA=;
        b=HlhT/kQO3qsPXRlUQUEgxtfFEk0Wy1GUJszDPQmipHiLwhI7D7Ud6U0uz2pnsZN5rT
         7EOC4Jn4iDDSTZFFoRndgND/Ux6FKmmKMUzdJxgrHfy/4+OrAtmdNfsig9VZo8sLJnh1
         KcD9AwK2e8UEg+kiXW1id2rzKTMn2Dwe2RDGLVAxTcnZUSqMmDisa5lZyvzYI+u+/9gL
         EEqcA3Vvr6YOIyg6/VqU0L9U2W9G2031ne1Q1+dreSf96jBKpxTf71T7FdOx6MAox2Yv
         PFtLXoLKmSuwsKYmEQIl6D5CNuWVseIOgnpy+qWfIh2cA9q2cMS9Mp+P+6Ij4YN609aM
         2jRg==
X-Received: by 10.15.45.130 with SMTP id b2mr4275073eew.28.1396893219756;
        Mon, 07 Apr 2014 10:53:39 -0700 (PDT)
Received: from localhost.localdomain (p57A35EBE.dip0.t-ipconnect.de. [87.163.94.190])
        by mx.google.com with ESMTPSA id q41sm43179642eez.7.2014.04.07.10.53.38
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 07 Apr 2014 10:53:39 -0700 (PDT)
From:   Manuel Lauss <manuel.lauss@gmail.com>
To:     Linux-MIPS <linux-mips@linux-mips.org>
Cc:     Manuel Lauss <manuel.lauss@gmail.com>
Subject: [RFC PATCH v5 2/2] MIPS: optional floating point support
Date:   Mon,  7 Apr 2014 19:53:34 +0200
Message-Id: <1396893214-298664-2-git-send-email-manuel.lauss@gmail.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1396893214-298664-1-git-send-email-manuel.lauss@gmail.com>
References: <1396893214-298664-1-git-send-email-manuel.lauss@gmail.com>
Return-Path: <manuel.lauss@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 39686
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

Makes floating point support a selectable kernel option. Disabling
this option will make the kernel 50kB lighter and kill all float
uses with an illegal instruction exception.

Signed-off-by: Manuel Lauss <manuel.lauss@gmail.com>
---
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
 arch/mips/include/asm/fpu.h          | 20 +++++++++++---------
 arch/mips/include/asm/fpu_emulator.h | 15 +++++++++++++++
 4 files changed, 38 insertions(+), 10 deletions(-)

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
index 4d86b72..f0ea5ae 100644
--- a/arch/mips/include/asm/fpu.h
+++ b/arch/mips/include/asm/fpu.h
@@ -155,16 +155,18 @@ static inline int init_fpu(void)
 {
 	int ret = 0;
 
-	preempt_disable();
-	if (cpu_has_fpu) {
-		ret = __own_fpu();
-		if (!ret)
-			_init_fpu();
-	} else {
-		fpu_emulator_init_fpu();
-	}
+	if (IS_ENABLED(CONFIG_MIPS_FPU_SUPPORT)) {
+		preempt_disable();
+		if (cpu_has_fpu) {
+			ret = __own_fpu();
+			if (!ret)
+				_init_fpu();
+		} else
+			fpu_emulator_init_fpu();
+		preempt_enable();
+	} else
+		ret = SIGILL;
 
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
