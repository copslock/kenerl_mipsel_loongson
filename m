Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 09 Apr 2009 06:08:23 +0100 (BST)
Received: from [222.92.8.141] ([222.92.8.141]:2526 "EHLO lemote.com")
	by ftp.linux-mips.org with ESMTP id S20022491AbZDIFIR (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 9 Apr 2009 06:08:17 +0100
Received: from localhost (localhost [127.0.0.1])
	by lemote.com (Postfix) with ESMTP id B217A3412F;
	Thu,  9 Apr 2009 13:05:18 +0800 (CST)
X-Virus-Scanned: Debian amavisd-new at lemote.com
Received: from lemote.com ([127.0.0.1])
	by localhost (www.lemote.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 2k44lsoDkmR5; Thu,  9 Apr 2009 13:05:12 +0800 (CST)
Received: from [127.0.0.1] (unknown [222.92.8.142])
	by lemote.com (Postfix) with ESMTP id E975734133;
	Thu,  9 Apr 2009 13:05:06 +0800 (CST)
Message-ID: <49DD82AF.90300@lemote.com>
Date:	Thu, 09 Apr 2009 13:07:59 +0800
From:	yanhua <yanh@lemote.com>
User-Agent: Thunderbird 2.0.0.21 (Windows/20090302)
MIME-Version: 1.0
To:	linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>,
	=?GB2312?B?xe3Bwb31?= <penglj@lemote.com>,
	"zhangfx@lemote.com" <zhangfx@lemote.com>
Subject: [PATCH 11/14] lemote: Hibernation Support in mips system
Content-Type: text/plain; charset=GB2312
Content-Transfer-Encoding: 7bit
Return-Path: <yanh@lemote.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22297
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yanh@lemote.com
Precedence: bulk
X-list: linux-mips

---
arch/mips/Kconfig | 3 +
arch/mips/Makefile | 3 +
arch/mips/include/asm/suspend.h | 2 +
arch/mips/kernel/asm-offsets.c | 13 ++++++
arch/mips/power/Makefile | 1 +
arch/mips/power/cpu.c | 48 ++++++++++++++++++++++++
arch/mips/power/hibernate.S | 78 +++++++++++++++++++++++++++++++++++++++
include/linux/suspend.h | 2 +-
8 files changed, 149 insertions(+), 1 deletions(-)
create mode 100644 arch/mips/power/Makefile
create mode 100644 arch/mips/power/cpu.c
create mode 100644 arch/mips/power/hibernate.S

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 8122fc2..0f1f9aa 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -2133,6 +2133,9 @@ endmenu

menu "Power management options"

+config ARCH_HIBERNATION_POSSIBLE
+ def_bool y
+
config ARCH_SUSPEND_POSSIBLE
def_bool y
depends on !SMP
diff --git a/arch/mips/Makefile b/arch/mips/Makefile
index 6ccfb3d..8acd1af 100644
--- a/arch/mips/Makefile
+++ b/arch/mips/Makefile
@@ -693,6 +693,9 @@ core-y += arch/mips/kernel/ arch/mips/mm/
arch/mips/math-emu/

drivers-$(CONFIG_OPROFILE) += arch/mips/oprofile/

+# suspend and hibernation support
+drivers-$(CONFIG_PM) += arch/mips/power/
+
ifdef CONFIG_LASAT
rom.bin rom.sw: vmlinux
$(Q)$(MAKE) $(build)=arch/mips/lasat/image $@
diff --git a/arch/mips/include/asm/suspend.h
b/arch/mips/include/asm/suspend.h
index 2562f8f..1d44287 100644
--- a/arch/mips/include/asm/suspend.h
+++ b/arch/mips/include/asm/suspend.h
@@ -3,4 +3,6 @@

/* Somewhen... Maybe :-) */

+static inline int arch_prepare_suspend(void) { return 0; }
+
#endif /* __ASM_SUSPEND_H */
diff --git a/arch/mips/kernel/asm-offsets.c b/arch/mips/kernel/asm-offsets.c
index c901c22..94964f5 100644
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
+ COMMENT(" Linux struct pbe offsets. ");
+ OFFSET(PBE_ADDRESS , pbe, address);
+ OFFSET(PBE_ORIG_ADDRESS , pbe, orig_address);
+ OFFSET(PBE_NEXT , pbe, next);
+ DEFINE(PBE_SIZE , sizeof(struct pbe));
+ BLANK();
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
index 0000000..b799bfe
--- /dev/null
+++ b/arch/mips/power/cpu.c
@@ -0,0 +1,48 @@
+/*
+ * Suspend support specific for mips.
+ *
+ */
+#include <linux/mm.h>
+#include <asm/mipsregs.h>
+#include <asm/page.h>
+#include <asm/suspend.h>
+
+/* References to section boundaries */
+extern const void __nosave_begin, __nosave_end;
+static uint32_t saved_status;
+unsigned long
+ saved_ra,
+ saved_sp,
+ saved_fp,
+ saved_gp,
+ saved_s0,
+ saved_s1,
+ saved_s2,
+ saved_s3,
+ saved_s4,
+ saved_s5,
+ saved_s6,
+ saved_s7,
+ saved_a0,
+ saved_a1,
+ saved_a2,
+ saved_a3,
+ saved_v0,
+ saved_v1;
+
+void save_processor_state(void)
+{
+ saved_status = read_c0_status();
+}
+
+void restore_processor_state(void)
+{
+ write_c0_status(saved_status);
+}
+
+int pfn_is_nosave(unsigned long pfn)
+{
+ unsigned long nosave_begin_pfn = __pa(&__nosave_begin) >> PAGE_SHIFT;
+ unsigned long nosave_end_pfn = PAGE_ALIGN(__pa(&__nosave_end)) >>
PAGE_SHIFT;
+ return (pfn >= nosave_begin_pfn) && (pfn < nosave_end_pfn);
+}
diff --git a/arch/mips/power/hibernate.S b/arch/mips/power/hibernate.S
new file mode 100644
index 0000000..e45ec45
--- /dev/null
+++ b/arch/mips/power/hibernate.S
@@ -0,0 +1,78 @@
+#incldue <linux/linkage.h>
+#include <asm/asm-offsets.h>
+#include <asm/regdef.h>
+#include <asm/asm.h>
+
+.text
+LEAF(swsusp_arch_suspend)
+ PTR_LA t0, saved_ra
+ PTR_S ra, (t0)
+ PTR_LA t0, saved_sp
+ PTR_S sp, (t0)
+ PTR_LA t0, saved_fp
+ PTR_S fp, (t0)
+ PTR_LA t0, saved_gp
+ PTR_S gp, (t0)
+ PTR_LA t0, saved_s0
+ PTR_S s0, (t0)
+ PTR_LA t0, saved_s1
+ PTR_S s1, (t0)
+ PTR_LA t0, saved_s2
+ PTR_S s2, (t0)
+ PTR_LA t0, saved_s3
+ PTR_S s3, (t0)
+ PTR_LA t0, saved_s4
+ PTR_S s4, (t0)
+ PTR_LA t0, saved_s5
+ PTR_S s5, (t0)
+ PTR_LA t0, saved_s6
+ PTR_S s6, (t0)
+ PTR_LA t0, saved_s7
+ PTR_S s7, (t0)
+ PTR_LA t0, saved_a0
+ PTR_S a0, (t0)
+ PTR_LA t0, saved_a1
+ PTR_S a1, (t0)
+ PTR_LA t0, saved_a2
+ PTR_S a2, (t0)
+ PTR_LA t0, saved_v1
+ PTR_S v1, (t0)
+ j swsusp_save
+ nop
+END(swsusp_arch_suspend)
+
+LEAF(swsusp_arch_resume)
+ PTR_L t0, restore_pblist
+0:
+ PTR_L t1, PBE_ADDRESS(t0) /* source */
+ PTR_L t2, PBE_ORIG_ADDRESS(t0) /* destination */
+ PTR_ADDIU t3, t1, _PAGE_SIZE
+1:
+ REG_L t8, (t1)
+ REG_S t8, (t2)
+ PTR_ADDIU t1, t1, SZREG
+ PTR_ADDIU t2, t2, SZREG
+ bne t1, t3, 1b
+ PTR_L t0, PBE_NEXT(t0)
+ bnez t0, 0b
+ //flush cache and tlb. no need?I am not sure.
+ PTR_L ra, saved_ra
+ PTR_L sp, saved_sp
+ PTR_L fp, saved_fp
+ PTR_L s0, saved_s0
+ PTR_L s1, saved_s1
+ PTR_L s2, saved_s2
+ PTR_L s3, saved_s3
+ PTR_L s4, saved_s4
+ PTR_L s5, saved_s5
+ PTR_L s6, saved_s6
+ PTR_L s7, saved_s7
+ PTR_L a0, saved_a0
+ PTR_L a1, saved_a1
+ PTR_L a2, saved_a2
+ PTR_L a3, saved_a3
+ PTR_LI v0, 0x0
+ PTR_L v1, saved_v1
+ jr ra
+ nop
+END(swsusp_arch_resume)
diff --git a/include/linux/suspend.h b/include/linux/suspend.h
index c7d9bb1..4ed4879 100644
--- a/include/linux/suspend.h
+++ b/include/linux/suspend.h
@@ -1,7 +1,7 @@
#ifndef _LINUX_SUSPEND_H
#define _LINUX_SUSPEND_H

-#if defined(CONFIG_X86) || defined(CONFIG_FRV) || defined(CONFIG_PPC32)
|| defined(CONFIG_PPC64)
+#if defined(CONFIG_X86) || defined(CONFIG_FRV) || defined(CONFIG_PPC32)
|| defined(CONFIG_PPC64) || defined(CONFIG_MIPS)
#include <asm/suspend.h>
#endif
#include <linux/swap.h>
-- 
1.5.6.5
