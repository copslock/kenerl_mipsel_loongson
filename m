Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 02 Jun 2009 16:32:09 +0100 (WEST)
Received: from mail-px0-f118.google.com ([209.85.216.118]:44316 "EHLO
	mail-px0-f118.google.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S20022109AbZFBPcD (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 2 Jun 2009 16:32:03 +0100
Received: by pxi16 with SMTP id 16so283063pxi.22
        for <multiple recipients>; Tue, 02 Jun 2009 08:31:54 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=uLnTyx11glIoFnBOX7e73SacMfVzr3qzh9G1ScZavhE=;
        b=Ycr2GsUT08PQDYSlCYL6T93B2Yqqw9px4uYaofdYUyCd3mk7pyQBnzAdpeKcSDBNn3
         x/V31sIbb4W0CdXLF/Jve5njUld1DIjgFQ9bkvZxPPlQotxFv5JXoY609ZT/KLbU67AY
         oKf7sZ98Kg4udnzqC+UuYXSAGK9v9z5+PuWug=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=xzT9gbD3dhftb5Y3pD8JQE8jDzZNhHaCV5rUVJTiO7s7Q9LC15/ZCoSxiyRwJYf2GG
         bys7XbZBWZY8ZQo2pD2MSCRxNUOWmYL5sftR/axeLqRa0BwPP42wPuoH3Yzx2RhCS2IY
         Xp8lHYNMcyWl2okACuTVEyUv3W1rC48l/ZFY0=
Received: by 10.114.160.17 with SMTP id i17mr6484314wae.125.1243956714197;
        Tue, 02 Jun 2009 08:31:54 -0700 (PDT)
Received: from localhost.localdomain ([219.246.59.144])
        by mx.google.com with ESMTPS id n9sm7152883wag.67.2009.06.02.08.31.49
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 02 Jun 2009 08:31:51 -0700 (PDT)
From:	wuzhangjin@gmail.com
To:	linux-mips@linux-mips.org, ralf@linux-mips.org
Cc:	Arnaud Patard <apatard@mandriva.com>,
	Atsushi Nemoto <anemo@mba.ocn.ne.jp>,
	yan hua <yanh@lemote.com>, Zhang Fuxin <zhangfx@lemote.com>,
	Pavel Machek <pavel@ucw.cz>, Wu Zhangjin <wuzj@lemote.com>,
	Hongbing Hu <huhb@lemote.com>
Subject: [PATCH] Hibernation Support in mips system
Date:	Tue,  2 Jun 2009 23:31:42 +0800
Message-Id: <1243956702-16276-1-git-send-email-wuzhangjin@gmail.com>
X-Mailer: git-send-email 1.6.3.1
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23181
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

Reviewed-by: Pavel Machek <pavel@ucw.cz>
Reviewed-by: yanh <yanh@lemote.com>
Reviewed-by: Arnaud Patard <apatard@mandriva.com>
Reviewed-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Signed-off-by: Wu Zhangjin <wuzj@lemote.com>
Signed-off-by: Hongbing Hu <huhb@lemote.com>
---
 arch/mips/Kconfig               |    3 ++
 arch/mips/Makefile              |    3 ++
 arch/mips/include/asm/suspend.h |    5 ++-
 arch/mips/kernel/asm-offsets.c  |   13 +++++++
 arch/mips/power/Makefile        |    1 +
 arch/mips/power/cpu.c           |   31 ++++++++++++++++++
 arch/mips/power/hibernate.S     |   67 +++++++++++++++++++++++++++++++++++++++
 7 files changed, 122 insertions(+), 1 deletions(-)
 create mode 100644 arch/mips/power/Makefile
 create mode 100644 arch/mips/power/cpu.c
 create mode 100644 arch/mips/power/hibernate.S

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index c7d1d08..4423d82 100644
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
index 6d39fdf..361a30d 100644
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
index 2562f8f..294cdb6 100644
--- a/arch/mips/include/asm/suspend.h
+++ b/arch/mips/include/asm/suspend.h
@@ -1,6 +1,9 @@
 #ifndef __ASM_SUSPEND_H
 #define __ASM_SUSPEND_H
 
-/* Somewhen...  Maybe :-)  */
+static inline int arch_prepare_suspend(void) { return 0; }
+
+/* References to section boundaries */
+extern const void __nosave_begin, __nosave_end;
 
 #endif /* __ASM_SUSPEND_H */
diff --git a/arch/mips/kernel/asm-offsets.c b/arch/mips/kernel/asm-offsets.c
index c901c22..8d006ec 100644
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
+	OFFSET(PBE_ADDRESS, pbe, address);
+	OFFSET(PBE_ORIG_ADDRESS, pbe, orig_address);
+	OFFSET(PBE_NEXT, pbe, next);
+	DEFINE(PBE_SIZE, sizeof(struct pbe));
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
index 0000000..5fe43e5
--- /dev/null
+++ b/arch/mips/power/cpu.c
@@ -0,0 +1,31 @@
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
index 0000000..4ca9149
--- /dev/null
+++ b/arch/mips/power/hibernate.S
@@ -0,0 +1,67 @@
+#incldue <linux/linkage.h>
+#include <asm/asm-offsets.h>
+#include <asm/regdef.h>
+#include <asm/asm.h>
+
+	.extern __flush_cache_all
+#ifdef CONFIG_SMP
+	.extern flush_tlb_all
+#else
+	.extern local_flush_tlb_all
+#define flush_tlb_all local_flush_tlb_all
+#endif
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
+	/* flush caches to make sure context is in memory */
+	PTR_L t0, __flush_cache_all
+	jalr t0
+	/* flush tlb entries */
+	PTR_LA t0, flush_tlb_all
+	jalr t0
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
+END(swsusp_arch_resume)
-- 
1.6.0.4
