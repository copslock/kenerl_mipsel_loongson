Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 03 Jun 2009 15:18:17 +0100 (WEST)
Received: from mail-px0-f186.google.com ([209.85.216.186]:33284 "EHLO
	mail-px0-f186.google.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S20022866AbZFCOSL (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 3 Jun 2009 15:18:11 +0100
Received: by pxi16 with SMTP id 16so9204pxi.22
        for <multiple recipients>; Wed, 03 Jun 2009 07:18:03 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=V1LgB9XskjSTTyR7Hy7TZWcBxlhxfuYl4pMEHulMd4A=;
        b=Aa1hB/DSHqTcQ7qonhXW29qSATuf0acBcRZVUlJmIW1/pZi7d94ryBjn0e3WnEKD7c
         lDIdatCUWHK2vcfU8lO8FbipMJdT5L5JoOZx2deG5Z7ZwtWeSvztZHCmACXdobi727I/
         GhjX8C5AR56+iTCs9sLyH9N4tydhplYusxXA8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=LekjN+KZRTNh4B5g1u4P6Id5LUTEb7aYCp+5sI5QGms4KpXO3Lrzn4C5L/EMwzLsrJ
         y8EM56sQNxoMugrz7jAgWPo7VrNj8ucmfAPS892uaJ3amJ7dHQEY6otRXoQPlR5aRIhK
         BkMPuCOT5gED8MDTrBDaRJQOvPlu4PTVR6iJY=
Received: by 10.115.14.15 with SMTP id r15mr1607071wai.107.1244038680601;
        Wed, 03 Jun 2009 07:18:00 -0700 (PDT)
Received: from localhost.localdomain ([202.201.14.140])
        by mx.google.com with ESMTPS id n40sm9034457wag.65.2009.06.03.07.17.53
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 03 Jun 2009 07:17:59 -0700 (PDT)
From:	wuzhangjin@gmail.com
To:	linux-mips@linux-mips.org, ralf@linux-mips.org
Cc:	Arnaud Patard <apatard@mandriva.com>,
	Atsushi Nemoto <anemo@mba.ocn.ne.jp>,
	Yan Hua <yanh@lemote.com>, Zhang Fuxin <zhangfx@lemote.com>,
	Pavel Machek <pavel@ucw.cz>, Wu Zhangjin <wuzj@lemote.com>,
	Hu Hongbing <huhb@lemote.com>
Subject: [PATCH-v1] Hibernation Support in mips system
Date:	Wed,  3 Jun 2009 22:17:40 +0800
Message-Id: <6b7278ff10d7c4f9d819792de8742f65147c6855.1244038584.git.wuzj@lemote.com>
X-Mailer: git-send-email 1.6.3.1
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23218
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips

From: Wu Zhangjin <wuzj@lemote.com>

This is pulled from the to-mips branch of
http://dev.lemote.com/code/linux_loongson, the original author is Hu
Hongbing from www.lemote.com

according to the feedback from Atsushi Nemoto, Arnaud Patard, Yanhua,
Pavel Machek and Ralf Baechle. I removed the a0-a7,v1 registers
saving/restoring, added cache/tlb flushing and fpu,dsp registers
saving/restoring, and also tuned some coding style problem with the
support of scripts/checkpatch.pl.

Reviewed-by: Pavel Machek <pavel@ucw.cz>
Reviewed-by: Yan Hua <yanh@lemote.com>
Reviewed-by: Arnaud Patard <apatard@mandriva.com>
Reviewed-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Signed-off-by: Wu Zhangjin <wuzj@lemote.com>
Signed-off-by: Hu Hongbing <huhb@lemote.com>
---
 arch/mips/Kconfig               |    3 ++
 arch/mips/Makefile              |    3 ++
 arch/mips/include/asm/suspend.h |    5 ++-
 arch/mips/kernel/asm-offsets.c  |   13 +++++++
 arch/mips/power/Makefile        |    1 +
 arch/mips/power/cpu.c           |   41 +++++++++++++++++++++++
 arch/mips/power/hibernate.S     |   70 +++++++++++++++++++++++++++++++++++++++
 7 files changed, 135 insertions(+), 1 deletions(-)
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
index 0000000..30fd6b5
--- /dev/null
+++ b/arch/mips/power/cpu.c
@@ -0,0 +1,41 @@
+/*
+ * Suspend support specific for mips.
+ *
+ * Copyright (C) 2009 Lemote Inc. & Insititute of Computing Technology
+ * Author: Hu Hongbing <huhb@lemote.com>
+ *         Wu Zhangjin <wuzj@lemote.com>
+ */
+#include <asm/suspend.h>
+#include <asm/fpu.h>
+#include <asm/dsp.h>
+
+static u32 saved_status;
+struct pt_regs saved_regs;
+
+void save_processor_state(void)
+{
+	saved_status = read_c0_status();
+
+	if (is_fpu_owner())
+		save_fp(current);
+	if (cpu_has_dsp)
+		save_dsp(current);
+}
+
+void restore_processor_state(void)
+{
+	write_c0_status(saved_status);
+
+	if (is_fpu_owner())
+		restore_fp(current);
+	if (cpu_has_dsp)
+		restore_dsp(current);
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
index 0000000..f7c78ff
--- /dev/null
+++ b/arch/mips/power/hibernate.S
@@ -0,0 +1,70 @@
+/*
+ * Hibernation support specific for mips - temporary page tables
+ *
+ * Distribute under GPLv2
+ *
+ * Copyright (C) 2009 Lemote Inc. & Insititute of Computing Technology
+ * Author: Hu Hongbing <huhb@lemote.com>
+ *         Wu Zhangjin <wuzj@lemote.com>
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
+#ifdef CONFIG_SMP
+	jal	flush_tlb_all
+#else
+	jal	local_flush_tlb_all
+#endif
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
