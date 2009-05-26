Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 26 May 2009 20:12:41 +0100 (BST)
Received: from mail-pz0-f202.google.com ([209.85.222.202]:39835 "EHLO
	mail-pz0-f202.google.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S20024704AbZEZTKR (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 26 May 2009 20:10:17 +0100
Received: by mail-pz0-f202.google.com with SMTP id 40so3721137pzk.22
        for <multiple recipients>; Tue, 26 May 2009 12:10:16 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=JNx10U8Yww3yczUv77QB41EypJykshhUnBDanKLb/To=;
        b=WLEj8q5eMwgu+NdaU3d5isoro66ECmv6KWf8Ktgrtt+6Kl68OMdsbpS4gv7Gz19Lor
         ZbxEj08lW7i3fV1LhACvemNKZlS3H431uD+YcYWc6M2vAR5CavuFELlFxF2WPl7iQekC
         Eu4MWGEC5KCs8fjaMsRs/OG0sbm4Paw3iaMFs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=E1Z54pEsQ7iBcgplXs54aFAJP2fsh4/d2qH64lymo/sUni3JxvZMh21YSzQwHiXP/4
         TLAlYxz4b6cRoZuSWUXbiBJA9n/FpAG4DtQR9FUAtuS++OfSPmcBGcIfWLFbRnFKWso9
         9gW47UoE39wRIkbvCdu3tJbj9sUcGUGOqzI+w=
Received: by 10.114.111.1 with SMTP id j1mr17166421wac.79.1243365015601;
        Tue, 26 May 2009 12:10:15 -0700 (PDT)
Received: from localhost.localdomain ([219.246.59.144])
        by mx.google.com with ESMTPS id m17sm12000172waf.68.2009.05.26.12.10.10
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 26 May 2009 12:10:14 -0700 (PDT)
From:	wuzhangjin@gmail.com
To:	linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>
Cc:	Wu Zhangjin <wuzj@lemote.com>, Yan Hua <yanh@lemote.com>,
	Philippe Vachon <philippe@cowpig.ca>,
	Zhang Le <r0bertz@gentoo.org>,
	Zhang Fuxin <zhangfx@lemote.com>,
	loongson-dev <loongson-dev@googlegroups.com>,
	Nicholas Mc Guire <der.herr@hofr.at>,
	Liu Junliang <liujl@lemote.com>,
	Erwan Lerale <erwan@thiscow.com>
Subject: [loongson-PATCH-v2 23/23] Hibernation Support in mips system
Date:	Wed, 27 May 2009 03:10:05 +0800
Message-Id: <1483a7cb0f587bd329ea3ca8d3af2881afadaf5e.1243362545.git.wuzj@lemote.com>
X-Mailer: git-send-email 1.6.3.1
In-Reply-To: <cover.1243362545.git.wuzj@lemote.com>
References: <cover.1243362545.git.wuzj@lemote.com>
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22997
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips

From: Wu Zhangjin <wuzj@lemote.com>

This is originally pulled from the to-mips branch of
http://dev.lemote.com/code/linux_loongson, only a few coding style
tuning under the support of script/checkpatch.pl

as the feedback from Atsushi Nemoto,Yanhua and Pavel Machek, some changes
have been done by Hu Hongbing(the original author of mips-specific STD)
from Lemote.com. this patch apply the changes, which include:

Signed-off-by: Wu Zhangjin <wuzj@lemote.com>
---
 arch/mips/Kconfig               |    3 ++
 arch/mips/Makefile              |    3 ++
 arch/mips/include/asm/suspend.h |    2 +-
 arch/mips/kernel/asm-offsets.c  |   13 ++++++++
 arch/mips/power/Makefile        |    1 +
 arch/mips/power/cpu.c           |   34 +++++++++++++++++++++
 arch/mips/power/hibernate.S     |   61 +++++++++++++++++++++++++++++++++++++++
 7 files changed, 116 insertions(+), 1 deletions(-)
 create mode 100644 arch/mips/power/Makefile
 create mode 100644 arch/mips/power/cpu.c
 create mode 100644 arch/mips/power/hibernate.S

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index aa8cd64..dec0c55 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -2128,6 +2128,9 @@ endmenu
 
 menu "Power management options"
 
+config ARCH_HIBERNATION_POSSIBLE
+	def_bool y
+
 config ARCH_SUSPEND_POSSIBLE
 	def_bool y
 	depends on !SMP
diff --git a/arch/mips/Makefile b/arch/mips/Makefile
index 1ee5504..246d3e2 100644
--- a/arch/mips/Makefile
+++ b/arch/mips/Makefile
@@ -685,6 +685,9 @@ core-y			+= arch/mips/kernel/ arch/mips/mm/ arch/mips/math-emu/
 
 drivers-$(CONFIG_OPROFILE)	+= arch/mips/oprofile/
 
+# suspend and hibernation support
+drivers-$(CONFIG_PM)	+= arch/mips/power/
+
 ifdef CONFIG_LASAT
 rom.bin rom.sw: vmlinux
 	$(Q)$(MAKE) $(build)=arch/mips/lasat/image $@
diff --git a/arch/mips/include/asm/suspend.h b/arch/mips/include/asm/suspend.h
index 2562f8f..1b5e73f 100644
--- a/arch/mips/include/asm/suspend.h
+++ b/arch/mips/include/asm/suspend.h
@@ -1,6 +1,6 @@
 #ifndef __ASM_SUSPEND_H
 #define __ASM_SUSPEND_H
 
-/* Somewhen...  Maybe :-)  */
+static inline int arch_prepare_suspend(void) { return 0; }
 
 #endif /* __ASM_SUSPEND_H */
diff --git a/arch/mips/kernel/asm-offsets.c b/arch/mips/kernel/asm-offsets.c
index c901c22..26f5ef3 100644
--- a/arch/mips/kernel/asm-offsets.c
+++ b/arch/mips/kernel/asm-offsets.c
@@ -14,6 +14,7 @@
 #include <linux/mm.h>
 #include <linux/interrupt.h>
 #include <linux/kbuild.h>
+#include <linux/suspend.h>
 #include <asm/ptrace.h>
 #include <asm/processor.h>
 
@@ -326,3 +327,15 @@ void output_octeon_cop2_state_defines(void)
 	BLANK();
 }
 #endif
+
+#ifdef CONFIG_HIBERNATION
+void output_pbe_defines(void)
+{
+	COMMENT(" Linux struct pbe offsets. ");
+	OFFSET(PBE_ADDRESS , pbe, address);
+	OFFSET(PBE_ORIG_ADDRESS  , pbe, orig_address);
+	OFFSET(PBE_NEXT  , pbe, next);
+	DEFINE(PBE_SIZE  , sizeof(struct pbe));
+	BLANK();
+}
+#endif
diff --git a/arch/mips/power/Makefile b/arch/mips/power/Makefile
new file mode 100644
index 0000000..73d56b8
--- /dev/null
+++ b/arch/mips/power/Makefile
@@ -0,0 +1 @@
+obj-$(CONFIG_HIBERNATION) += cpu.o hibernate.o
diff --git a/arch/mips/power/cpu.c b/arch/mips/power/cpu.c
new file mode 100644
index 0000000..1c1d726
--- /dev/null
+++ b/arch/mips/power/cpu.c
@@ -0,0 +1,34 @@
+/*
+ * Suspend support specific for mips.
+ *
+ */
+#include <linux/mm.h>
+#include <linux/suspend.h>
+#include <asm/mipsregs.h>
+#include <asm/page.h>
+#include <asm/suspend.h>
+#include <asm/ptrace.h>
+
+/* References to section boundaries */
+extern const void __nosave_begin, __nosave_end;
+
+static uint32_t saved_status;
+struct pt_regs saved_regs;
+
+void save_processor_state(void)
+{
+	saved_status = read_c0_status();
+}
+
+void restore_processor_state(void)
+{
+	write_c0_status(saved_status);
+}
+
+int pfn_is_nosave(unsigned long pfn)
+{
+	unsigned long nosave_begin_pfn = PFN_DOWN(__pa(&__nosave_begin));
+	unsigned long nosave_end_pfn = PFN_UP(__pa(&__nosave_end));
+
+	return	(pfn >= nosave_begin_pfn) && (pfn < nosave_end_pfn);
+}
diff --git a/arch/mips/power/hibernate.S b/arch/mips/power/hibernate.S
new file mode 100644
index 0000000..9dbe48e
--- /dev/null
+++ b/arch/mips/power/hibernate.S
@@ -0,0 +1,61 @@
+#incldue <linux/linkage.h>
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
+	PTR_S a0, PT_R4(t0)
+	PTR_S a1, PT_R5(t0)
+	PTR_S a2, PT_R6(t0)
+	PTR_S v1, PT_R3(t0)
+	j swsusp_save
+END(swsusp_arch_suspend)
+
+LEAF(swsusp_arch_resume)
+	PTR_L t0, restore_pblist
+0:
+	PTR_L t1, PBE_ADDRESS(t0)   /* source */
+	PTR_L t2, PBE_ORIG_ADDRESS(t0) /* destination */
+	PTR_ADDIU t3, t1, _PAGE_SIZE
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
+	PTR_L s0, PT_R16(t0)
+	PTR_L s1, PT_R17(t0)
+	PTR_L s2, PT_R18(t0)
+	PTR_L s3, PT_R19(t0)
+	PTR_L s4, PT_R20(t0)
+	PTR_L s5, PT_R21(t0)
+	PTR_L s6, PT_R22(t0)
+	PTR_L s7, PT_R23(t0)
+	PTR_L a0, PT_R4(t0)
+	PTR_L a1, PT_R5(t0)
+	PTR_L a2, PT_R6(t0)
+	PTR_L a3, PT_R7(t0)
+	PTR_LI v0, 0x0
+	PTR_L v1, PT_R3(t0)
+	jr ra
+END(swsusp_arch_resume)
-- 
1.6.0.4
