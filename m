Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 27 Oct 2008 18:08:08 +0000 (GMT)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:23015 "EHLO
	mail3.caviumnetworks.com") by ftp.linux-mips.org with ESMTP
	id S22518269AbYJ0SH7 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 27 Oct 2008 18:07:59 +0000
Received: from exch4.caveonetworks.com (Not Verified[192.168.16.23]) by mail3.caviumnetworks.com with MailMarshal (v6,2,2,3503)
	id <B4906036e0000>; Mon, 27 Oct 2008 14:07:42 -0400
Received: from exch4.caveonetworks.com ([192.168.16.23]) by exch4.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Mon, 27 Oct 2008 11:07:39 -0700
Received: from dd1.caveonetworks.com ([64.169.86.201]) by exch4.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Mon, 27 Oct 2008 11:07:39 -0700
Message-ID: <4906036A.5010702@caviumnetworks.com>
Date:	Mon, 27 Oct 2008 11:07:38 -0700
From:	David Daney <ddaney@caviumnetworks.com>
User-Agent: Thunderbird 2.0.0.16 (X11/20080723)
MIME-Version: 1.0
To:	linux-mips <linux-mips@linux-mips.org>
CC:	"Paoletti, Tomaso" <Tomaso.Paoletti@caviumnetworks.com>
Subject: [PATCH] MIPS: move FPU emulator externs to fpu_emulator.h
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 27 Oct 2008 18:07:39.0206 (UTC) FILETIME=[E5E85660:01C9385E]
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21005
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips

MIPS: move FPU emulator externs to fpu_emulator.h

Signed-off-by: David Daney <ddaney@caviumnetworks.com>
---
 arch/mips/include/asm/fpu_emulator.h |    5 +++++
 arch/mips/kernel/traps.c             |    4 +---
 arch/mips/kernel/unaligned.c         |    2 +-
 arch/mips/math-emu/dsemul.h          |    1 -
 4 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/arch/mips/include/asm/fpu_emulator.h b/arch/mips/include/asm/fpu_emulator.h
index 2731c38..c8e1bb2 100644
--- a/arch/mips/include/asm/fpu_emulator.h
+++ b/arch/mips/include/asm/fpu_emulator.h
@@ -34,4 +34,9 @@ struct mips_fpu_emulator_stats {
 
 extern struct mips_fpu_emulator_stats fpuemustats;
 
+extern int do_dsemulret(struct pt_regs *);
+
+extern int fpu_emulator_cop1Handler(struct pt_regs *xcp,
+	struct mips_fpu_struct *ctx, int has_fpu);
+
 #endif /* _ASM_FPU_EMULATOR_H */
diff --git a/arch/mips/kernel/traps.c b/arch/mips/kernel/traps.c
index cfec89c..bf4b847 100644
--- a/arch/mips/kernel/traps.c
+++ b/arch/mips/kernel/traps.c
@@ -47,6 +47,7 @@
 #include <asm/types.h>
 #include <asm/stacktrace.h>
 #include <asm/irq.h>
+#include <asm/fpu_emulator.h>
 
 extern void check_wait(void);
 extern asmlinkage void r4k_wait(void);
@@ -75,9 +76,6 @@ extern asmlinkage void handle_dsp(void);
 extern asmlinkage void handle_mcheck(void);
 extern asmlinkage void handle_reserved(void);
 
-extern int fpu_emulator_cop1Handler(struct pt_regs *xcp,
-	struct mips_fpu_struct *ctx, int has_fpu);
-
 #ifdef CONFIG_CPU_CAVIUM_OCTEON
 extern asmlinkage void octeon_cop2_restore(struct octeon_cop2_state *task);
 #endif
diff --git a/arch/mips/kernel/unaligned.c b/arch/mips/kernel/unaligned.c
index 2070966..e4b0e39 100644
--- a/arch/mips/kernel/unaligned.c
+++ b/arch/mips/kernel/unaligned.c
@@ -84,6 +84,7 @@
 #include <asm/inst.h>
 #include <asm/uaccess.h>
 #include <asm/system.h>
+#include <asm/fpu_emulator.h>
 
 #define STR(x)  __STR(x)
 #define __STR(x)  #x
@@ -499,7 +500,6 @@ sigill:
 
 asmlinkage void do_ade(struct pt_regs *regs)
 {
-	extern int do_dsemulret(struct pt_regs *);
 	unsigned int __user *pc;
 	mm_segment_t seg;
 
diff --git a/arch/mips/math-emu/dsemul.h b/arch/mips/math-emu/dsemul.h
index 091f0e7..12e2ef1 100644
--- a/arch/mips/math-emu/dsemul.h
+++ b/arch/mips/math-emu/dsemul.h
@@ -1,5 +1,4 @@
 extern int mips_dsemul(struct pt_regs *regs, mips_instruction ir, unsigned long cpc);
-extern int do_dsemulret(struct pt_regs *xcp);
 
 /* Instruction which will always cause an address error */
 #define AdELOAD 0x8c000001	/* lw $0,1($0) */
