Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 07 Apr 2014 12:57:42 +0200 (CEST)
Received: from mail-ee0-f41.google.com ([74.125.83.41]:45601 "EHLO
        mail-ee0-f41.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6816686AbaDGK5OwMp8i (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 7 Apr 2014 12:57:14 +0200
Received: by mail-ee0-f41.google.com with SMTP id t10so510528eei.0
        for <linux-mips@linux-mips.org>; Mon, 07 Apr 2014 03:57:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=je45l3cfejgXfHKjTmhgtkXNMqG0jdld0MR9QMCLE98=;
        b=NyWioldnZqBXcAS3boOTV3ovZpoA511deYuaAO2P2u+QHYrarlN55TH6GX2dMXk58n
         Y5txwIWxDfFsofnVUlPu/bWzcersu8CgTNT8tjD5pHGj4r/83CAIn+jUlQwx7/VxHqKi
         EcnDumgsAaZP8/NPklUpFsmlycjT18pYVWNKoj8+46RUH1yRd7sfJZ6cc39sLSSkD1S3
         dPVSR6O1iJwl8lmdeQxUpwZ2o83uJCcelSDyP5rkWb4QfGv5/7XJqfrhTo+pfFD1s1sQ
         eJBH2LSzc/NM2mENWKD3gOX2kOer4AgdfGhii1eD5QT8I/x5J7NCkV924BR5H+TY1I+h
         mV+w==
X-Received: by 10.15.68.136 with SMTP id w8mr1988627eex.5.1396868229535;
        Mon, 07 Apr 2014 03:57:09 -0700 (PDT)
Received: from localhost.localdomain (p57A35EBE.dip0.t-ipconnect.de. [87.163.94.190])
        by mx.google.com with ESMTPSA id a42sm41067311ees.10.2014.04.07.03.57.08
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 07 Apr 2014 03:57:08 -0700 (PDT)
From:   Manuel Lauss <manuel.lauss@gmail.com>
To:     Linux-MIPS <linux-mips@linux-mips.org>
Cc:     Manuel Lauss <manuel.lauss@gmail.com>
Subject: [RFC PATCH v4 2/2] MIPS: make FPU emulator optional
Date:   Mon,  7 Apr 2014 12:57:04 +0200
Message-Id: <1396868224-252888-2-git-send-email-manuel.lauss@gmail.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1396868224-252888-1-git-send-email-manuel.lauss@gmail.com>
References: <1396868224-252888-1-git-send-email-manuel.lauss@gmail.com>
Return-Path: <manuel.lauss@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 39676
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

Disabling the emulator shrinks vmlinux by about 54kBytes (32bit,
optimizing for size).

Signed-off-by: Manuel Lauss <manuel.lauss@gmail.com>
---
v4: rediffed because of patch 1/2, should now work with micromips as well
v3: updated patch description with size savings.
v2: incorporated changes suggested by Jonas Gorski
    force the fpu emulator on for micromips: relocating the parts
    of the mmips code in the emulator to other areas would be a
    much larger change; I went the cheap route instead with this.

 arch/mips/Kbuild                     |  2 +-
 arch/mips/Kconfig                    | 14 ++++++++++++++
 arch/mips/include/asm/fpu.h          |  5 +++--
 arch/mips/include/asm/fpu_emulator.h | 15 +++++++++++++++
 4 files changed, 33 insertions(+), 3 deletions(-)

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
index 9b53358..3924396 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -2482,6 +2482,20 @@ config MIPS_O32_FP64_SUPPORT
 
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
index 283e6f3..df0ca0c 100644
--- a/arch/mips/include/asm/fpu_emulator.h
+++ b/arch/mips/include/asm/fpu_emulator.h
@@ -27,6 +27,7 @@
 #include <asm/inst.h>
 #include <asm/local.h>
 
+#ifdef CONFIG_MIPS_FPU_EMULATOR
 #ifdef CONFIG_DEBUG_FS
 
 struct mips_fpu_emulator_stats {
@@ -57,6 +58,20 @@ extern int do_dsemulret(struct pt_regs *xcp);
 extern int fpu_emulator_cop1Handler(struct pt_regs *xcp,
 				    struct mips_fpu_struct *ctx, int has_fpu,
 				    void *__user *fault_addr);
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
+#endif	/* CONFIG_MIPS_FPU_EMULATOR */
+
 int process_fpemu_return(int sig, void __user *fault_addr);
 
 /*
-- 
1.9.1
