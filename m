Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 20 Dec 2014 02:54:20 +0100 (CET)
Received: from mail-ig0-f171.google.com ([209.85.213.171]:64228 "EHLO
        mail-ig0-f171.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27009308AbaLTBwwlDWCC (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 20 Dec 2014 02:52:52 +0100
Received: by mail-ig0-f171.google.com with SMTP id z20so1593992igj.16;
        Fri, 19 Dec 2014 17:52:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=YKif2mOdQawjGMokmJbTWQhWOQ8HD0antzjE8OzLS9I=;
        b=kqDE7MOWcb1/3U35aAv8bRZ8U3KZrgwLO551ClDQBb8OwTqyhyXCsecqbOpS2kxLRA
         3JZ0VunTGsfbDybbdCrBmZ80kOBM+vYRwqPciDECB3ZdEIWl/hQVIVwYFkIKYPj049+L
         TQBND4yoH2wIVxxFIAh56nKg9CrNX9nSVhhC/ijEvreYjEVA0HiSBdwqrabnUdn/1VI0
         NjaXVfsgmDBl6uQhsFN1SPeUnrmDTiAS5Tgtt4NosEdKzcLT80v8J5Fon3zsJXeIAoH/
         vNlokDb3aM42AlyAFOq+ZKsT1UF2X3u96J063n66tUdMfupAK/nuXp93bWLBTMGpl6IM
         Ci1w==
X-Received: by 10.107.6.196 with SMTP id f65mr10616969ioi.54.1419040366866;
        Fri, 19 Dec 2014 17:52:46 -0800 (PST)
Received: from dl.caveonetworks.com (64.2.3.194.ptr.us.xo.net. [64.2.3.194])
        by mx.google.com with ESMTPSA id l3sm1700052igj.9.2014.12.19.17.52.45
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Fri, 19 Dec 2014 17:52:46 -0800 (PST)
Received: from dl.caveonetworks.com (localhost.localdomain [127.0.0.1])
        by dl.caveonetworks.com (8.14.5/8.14.5) with ESMTP id sBK1qi56008558;
        Fri, 19 Dec 2014 17:52:44 -0800
Received: (from ddaney@localhost)
        by dl.caveonetworks.com (8.14.5/8.14.5/Submit) id sBK1qipd008557;
        Fri, 19 Dec 2014 17:52:44 -0800
From:   David Daney <ddaney.cavm@gmail.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org
Cc:     David Daney <david.daney@cavium.com>
Subject: [RFC PATCH v2 4/5] MIPS: Add full ISA emulator.
Date:   Fri, 19 Dec 2014 17:52:39 -0800
Message-Id: <1419040360-8502-5-git-send-email-ddaney.cavm@gmail.com>
X-Mailer: git-send-email 1.7.11.7
In-Reply-To: <1419040360-8502-1-git-send-email-ddaney.cavm@gmail.com>
References: <1419040360-8502-1-git-send-email-ddaney.cavm@gmail.com>
Return-Path: <ddaney.cavm@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 44870
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney.cavm@gmail.com
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

From: David Daney <david.daney@cavium.com>

Used in follow-on patch to replace FPU delay-slot instruction
execution on stack.

Signed-off-by: David Daney <david.daney@cavium.com>
---
 arch/mips/kernel/Makefile    |    2 +-
 arch/mips/kernel/insn-emul.c | 1543 ++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 1544 insertions(+), 1 deletion(-)
 create mode 100644 arch/mips/kernel/insn-emul.c

diff --git a/arch/mips/kernel/Makefile b/arch/mips/kernel/Makefile
index 92987d1..44c0670 100644
--- a/arch/mips/kernel/Makefile
+++ b/arch/mips/kernel/Makefile
@@ -7,7 +7,7 @@ extra-y		:= head.o vmlinux.lds
 obj-y		+= cpu-probe.o branch.o elf.o entry.o genex.o idle.o irq.o \
 		   process.o prom.o ptrace.o reset.o setup.o signal.o \
 		   syscall.o time.o topology.o traps.o unaligned.o watch.o \
-		   vdso.o
+		   vdso.o insn-emul.o
 
 ifdef CONFIG_FUNCTION_TRACER
 CFLAGS_REMOVE_ftrace.o = -pg
diff --git a/arch/mips/kernel/insn-emul.c b/arch/mips/kernel/insn-emul.c
new file mode 100644
index 0000000..4d484bb
--- /dev/null
+++ b/arch/mips/kernel/insn-emul.c
@@ -0,0 +1,1543 @@
+/*
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ *
+ * Copyright (C) 2014 Cavium, Inc.
+ */
+
+#include <linux/sched.h>
+
+#include <asm/inst.h>
+#include <asm/ptrace.h>
+#include <asm/barrier.h>
+#include <asm/signal.h>
+#include <asm/uaccess.h>
+#include <asm/cacheflush.h>
+
+/*
+  Missing instructions:
+
+  LDL
+  LDR
+  LWL
+  LWR
+  SDL
+  SDR
+  SWL
+  SWR
+  SYSCALL
+
+Cavium/OCTEON-III
+  EXTS
+  EXTS32
+  CINS
+  CINS32
+  DPOP
+  POP
+  SEQ
+  SEQI
+  SNE
+  SNEI
+  SAA
+  SAAD
+  LBX
+  LBUX
+  LHX
+  LHUX
+  LWX
+  LWUX
+  LDX
+  LAA
+  LAAD
+  LAW
+  LAWD
+  LAI
+  LAID
+  LAD
+  LADD
+  LAS
+  LASD
+  LAC
+  LACD
+  ZCB
+  ZCBT
+
+ */
+
+struct mips_fault_info {
+	void *__user *fault_addr;
+	int si_code;
+};
+
+static int mips64_spec_emul(struct pt_regs *regs, mips_instruction ir,
+			    struct mips_fault_info *mfi)
+{
+#ifndef CONFIG_64BIT
+	return SIGILL;
+#else
+	union mips_instruction insn;
+	int sa;
+	u64 rs64, rt64, rd64;
+	s64 rt64s, rd64s;
+	u64 t1_64, t2_64;
+
+	insn.word = ir;
+	sa = 0;
+	rt64 = regs->regs[insn.r_format.rt];
+
+	switch (insn.r_format.func) {
+	case dsll32_op:
+		sa = 32;
+		/* Fall through. */
+	case dsll_op:
+		sa += insn.r_format.re;
+		if (insn.r_format.rs != 0)
+			return SIGILL;
+		if (insn.r_format.rd == 0)
+			return 0; /* ignore result "NOP" */
+		rd64 = rt64 << sa;
+		regs->regs[insn.r_format.rd] = rd64;
+		return 0;
+	case dsllv_op:
+		if (insn.r_format.re != 0)
+			return SIGILL;
+		if (insn.r_format.rd == 0)
+			return 0; /* ignore result "NOP" */
+		rs64 = regs->regs[insn.r_format.rs];
+		sa = rs64 & 0x3f;
+		rd64 = rt64 << sa;
+		regs->regs[insn.r_format.rd] = rd64;
+		return 0;
+	case dsrl32_op:
+		sa = 32;
+		/* Fall through. */
+	case dsrl_op:
+		sa += insn.r_format.re;
+		if (insn.r_format.rs == 0) {
+			/* DSRL(32) */
+			if (insn.r_format.rd == 0)
+				return 0; /* ignore result */
+			rd64 = rt64 >> sa;
+			regs->regs[insn.r_format.rd] = rd64;
+			return 0;
+		} else if (insn.r_format.rs == 1) {
+			/* DROTR(32) */
+			if (insn.r_format.rd == 0)
+				return 0; /* ignore result */
+			rd64 = (rt64 >> sa) | (rt64 << (64 - sa));
+			regs->regs[insn.r_format.rd] = rd64;
+			return 0;
+		}
+		return SIGILL;
+	case dsrlv_op:
+		rs64 = regs->regs[insn.r_format.rs];
+		sa = rs64 & 0x3f;
+		if (insn.r_format.re == 0) {
+			/* DSRLV */
+			if (insn.r_format.rd == 0)
+				return 0; /* ignore result */
+			rd64 = rt64 >> sa;
+			regs->regs[insn.r_format.rd] = rd64;
+			return 0;
+		} else if (insn.r_format.re == 1) {
+			/* DROTRV */
+			if (insn.r_format.rd == 0)
+				return 0; /* ignore result */
+			rd64 = (rt64 >> sa) | (rt64 << (64 - sa));
+			regs->regs[insn.r_format.rd] = rd64;
+			return 0;
+		}
+		return SIGILL;
+	case dsra32_op:
+		sa = 32;
+		/* Fall through. */
+	case dsra_op:
+		sa += insn.r_format.re;
+		if (insn.r_format.rs != 0)
+			return SIGILL;
+		if (insn.r_format.rd == 0)
+			return 0; /* ignore result */
+		rt64s = rt64;
+		rd64s = rt64s >> sa;
+		regs->regs[insn.r_format.rd] = rd64s;
+		return 0;
+	case dsrav_op:
+		if (insn.r_format.re != 0)
+			return SIGILL;
+		if (insn.r_format.rd == 0)
+			return 0; /* ignore result */
+		rs64 = regs->regs[insn.r_format.rs];
+		rt64s = rt64;
+		sa = rs64 & 0x3f;
+		rd64s = rt64s >> sa;
+		regs->regs[insn.r_format.rd] = rd64s;
+		return 0;
+	case dadd_op:
+	case daddu_op:
+		if (insn.r_format.re != 0)
+			return SIGILL;
+		rs64 = regs->regs[insn.r_format.rs];
+		rd64 = rs64 + rt64;
+		if (insn.r_format.func == dadd_op) {
+			/* Check for overflow */
+			int ss = (rs64 >> 63) & 1;
+			int ts = (rt64 >> 63) & 1;
+			int ds = (rd64 >> 63) & 1;
+
+			if (ss == ts && ss != ds) {
+				mfi->si_code = FPE_INTOVF;
+				return SIGFPE;
+			}
+		}
+		if (insn.r_format.rd == 0)
+			return 0; /* ignore result */
+		regs->regs[insn.r_format.rd] = rd64;
+		return 0;
+	case dsub_op:
+	case dsubu_op:
+		if (insn.r_format.re != 0)
+			return SIGILL;
+		rs64 = regs->regs[insn.r_format.rs];
+		rd64 = rs64 - rt64;
+		if (insn.r_format.func == dsub_op) {
+			/* Check for overflow */
+			int ss = (rs64 >> 63) & 1;
+			int ts = (rt64 >> 63) & 1;
+			int ds = (rd64 >> 63) & 1;
+
+			if (ss != ts && ss != ds) {
+				mfi->si_code = FPE_INTOVF;
+				return SIGFPE;
+			}
+		}
+		if (insn.r_format.rd == 0)
+			return 0; /* ignore result */
+		regs->regs[insn.r_format.rd] = rd64;
+		return 0;
+	case dmult_op:
+		if (insn.r_format.re != 0 || insn.r_format.rd != 0)
+			return SIGILL;
+		rs64 = regs->regs[insn.r_format.rs];
+		__asm__ ("dmult	%[rs], %[rt]\n"
+			 "	mfhi	%[hi]\n"
+			 "	mflo	%[lo]"
+			 :
+			 [lo] "=r" (t1_64), [hi] "=r" (t2_64) :
+			 [rs] "r" (rs64), [rt] "r" (rt64) :
+			 "hi", "lo");
+		regs->lo = t1_64;
+		regs->hi = t2_64;
+		return 0;
+	case dmultu_op:
+		if (insn.r_format.re != 0 || insn.r_format.rd != 0)
+			return SIGILL;
+		rs64 = regs->regs[insn.r_format.rs];
+		__asm__ ("dmultu	%[rs], %[rt]\n"
+			 "	mfhi	%[hi]\n"
+			 "	mflo	%[lo]"
+			 :
+			 [lo] "=r" (t1_64), [hi] "=r" (t2_64) :
+			 [rs] "r" (rs64), [rt] "r" (rt64) :
+			 "hi", "lo");
+		regs->lo = t1_64;
+		regs->hi = t2_64;
+		return 0;
+	case ddiv_op:
+		if (insn.r_format.re != 0 || insn.r_format.rd != 0)
+			return SIGILL;
+		rs64 = regs->regs[insn.r_format.rs];
+		__asm__ ("ddiv	%[rs], %[rt]\n"
+			 "	mfhi	%[hi]\n"
+			 "	mflo	%[lo]"
+			 :
+			 [lo] "=r" (t1_64), [hi] "=r" (t2_64) :
+			 [rs] "r" (rs64), [rt] "r" (rt64) :
+			 "hi", "lo");
+		regs->lo = t1_64;
+		regs->hi = t2_64;
+		return 0;
+	case ddivu_op:
+		if (insn.r_format.re != 0 || insn.r_format.rd != 0)
+			return SIGILL;
+		rs64 = regs->regs[insn.r_format.rs];
+		__asm__ ("ddivu	%[rs], %[rt]\n"
+			 "	mfhi	%[hi]\n"
+			 "	mflo	%[lo]"
+			 :
+			 [lo] "=r" (t1_64), [hi] "=r" (t2_64) :
+			 [rs] "r" (rs64), [rt] "r" (rt64) :
+			 "hi", "lo");
+		regs->lo = t1_64;
+		regs->hi = t2_64;
+		return 0;
+	default:
+		return SIGILL;
+	}
+#endif /* CONFIG_64BIT */
+}
+
+static int mips_assert_trap(struct pt_regs *regs, unsigned int code,
+			    struct mips_fault_info *mfi)
+{
+	switch (code) {
+	case BRK_OVERFLOW:
+		mfi->si_code = FPE_INTOVF;
+		*mfi->fault_addr = (void *)regs->cp0_epc;
+		return SIGFPE;
+	case BRK_DIVZERO:
+		mfi->si_code = FPE_INTDIV;
+		*mfi->fault_addr = (void *)regs->cp0_epc;
+		return SIGFPE;
+	default:
+		return SIGTRAP;
+	}
+}
+
+static int mips_spec_emul(struct pt_regs *regs, mips_instruction ir,
+			  struct mips_fault_info *mfi)
+{
+	union mips_instruction insn;
+	u32 rs32, rt32, rd32;
+	u64 t1_64, t2_64;
+	s64 t1_64s, t2_64s;
+	u32 t1_32, t2_32;
+	s32 t1_32s, t2_32s;
+	s32 rs32s, rt32s, rd32s;
+	int sa;
+	long rss, rts;
+	unsigned long rsu, rtu;
+
+	insn.word = ir;
+	switch (insn.r_format.func) {
+	case sll_op:
+		if (insn.r_format.rs != 0)
+			return SIGILL;
+		if (insn.r_format.rd == 0)
+			return 0; /* ignore result "NOP" */
+		rt32 = regs->regs[insn.r_format.rt];
+		sa = insn.r_format.re;
+		rd32 = rt32 << sa;
+		regs->regs[insn.r_format.rd] = (long)(s32)rd32;
+		return 0;
+	case srl_op:
+		if (insn.r_format.rs == 0) {
+			/* SRL */
+			if (insn.r_format.rd == 0)
+				return 0; /* ignore result */
+			rt32 = regs->regs[insn.r_format.rt];
+			rd32 = rt32 >> insn.r_format.re;
+			regs->regs[insn.r_format.rd] = (long)(s32)rd32;
+			return 0;
+		} else if (insn.r_format.rs == 1) {
+			/* ROTR */
+			if (insn.r_format.rd == 0)
+				return 0; /* ignore result */
+			rt32 = regs->regs[insn.r_format.rt];
+			sa = insn.r_format.re;
+			rd32 = (rt32 >> sa) | (rt32 << (32 - sa));
+			regs->regs[insn.r_format.rd] = (long)(s32)rd32;
+			return 0;
+		}
+		return SIGILL;
+	case sra_op:
+		if (insn.r_format.rs != 0)
+			return SIGILL;
+		if (insn.r_format.rd == 0)
+			return 0; /* ignore result */
+		rt32s = regs->regs[insn.r_format.rt];
+		sa = insn.r_format.re;
+		rd32s = rt32s >> sa;
+		regs->regs[insn.r_format.rd] = (long)rd32s;
+		return 0;
+	case sllv_op:
+		if (insn.r_format.re != 0)
+			return SIGILL;
+		if (insn.r_format.rd == 0)
+			return 0; /* ignore result */
+		rs32 = regs->regs[insn.r_format.rs];
+		rt32 = regs->regs[insn.r_format.rt];
+		sa = rs32 & 0x1f;
+		rd32 = rt32 << sa;
+		regs->regs[insn.r_format.rd] = (long)(s32)rd32;
+		return 0;
+	case srlv_op:
+		if (insn.r_format.re == 0) {
+			/* SRLV */
+			if (insn.r_format.rd == 0)
+				return 0; /* ignore result */
+			rs32 = regs->regs[insn.r_format.rs];
+			rt32 = regs->regs[insn.r_format.rt];
+			sa = rs32 & 0x1f;
+			rd32 = rt32 >> sa;
+			regs->regs[insn.r_format.rd] = (long)(s32)rd32;
+			return 0;
+		} else if (insn.r_format.re == 1) {
+			/* ROTRV */
+			if (insn.r_format.rd == 0)
+				return 0; /* ignore result */
+			rs32 = regs->regs[insn.r_format.rs];
+			rt32 = regs->regs[insn.r_format.rt];
+			sa = rs32 & 0x1f;
+			rd32 = (rt32 >> sa) | (rt32 << (32 - sa));
+			regs->regs[insn.r_format.rd] = (long)(s32)rd32;
+			return 0;
+		}
+		return SIGILL;
+	case srav_op:
+		if (insn.r_format.re != 0)
+			return SIGILL;
+		if (insn.r_format.rd == 0)
+			return 0; /* ignore result */
+		rs32 = regs->regs[insn.r_format.rs];
+		rt32s = regs->regs[insn.r_format.rt];
+		sa = rs32 & 0x1f;
+		rd32s = rt32s >> sa;
+		regs->regs[insn.r_format.rd] = (long)rd32s;
+		return 0;
+	case movz_op:
+		if (insn.r_format.rs != 0)
+			return SIGILL;
+		if (insn.r_format.rd == 0)
+			return 0; /* ignore result */
+		if (regs->regs[insn.r_format.rt] == 0)
+			regs->regs[insn.r_format.rd] = regs->regs[insn.r_format.rs];
+		return 0;
+	case movn_op:
+		if (insn.r_format.rs != 0)
+			return SIGILL;
+		if (insn.r_format.rd == 0)
+			return 0; /* ignore result */
+		if (regs->regs[insn.r_format.rt] != 0)
+			regs->regs[insn.r_format.rd] = regs->regs[insn.r_format.rs];
+		return 0;
+	case sync_op:
+		mb(); /* an mb() is a SYNC */
+		return 0;
+	case mfhi_op:
+		if (insn.r_format.rs != 0 || insn.r_format.rt != 0 || insn.r_format.re != 0)
+			return SIGILL;
+		if (insn.r_format.rd == 0)
+			return 0; /* ignore result */
+		regs->regs[insn.r_format.rd] = regs->hi;
+		return 0;
+	case mthi_op:
+		if (insn.r_format.rt != 0 || insn.r_format.rd != 0 || insn.r_format.re != 0)
+			return SIGILL;
+		if (insn.r_format.rd == 0)
+			regs->hi = 0;
+		regs->hi = regs->regs[insn.r_format.rs];
+		return 0;
+	case mflo_op:
+		if (insn.r_format.rs != 0 || insn.r_format.rt != 0 || insn.r_format.re != 0)
+			return SIGILL;
+		if (insn.r_format.rd == 0)
+			return 0; /* ignore result */
+		regs->regs[insn.r_format.rd] = regs->lo;
+		return 0;
+	case mtlo_op:
+		if (insn.r_format.rt != 0 || insn.r_format.rd != 0 || insn.r_format.re != 0)
+			return SIGILL;
+		if (insn.r_format.rd == 0)
+			regs->lo = 0;
+		regs->lo = regs->regs[insn.r_format.rs];
+		return 0;
+	case mult_op:
+		if (insn.r_format.rd != 0 || insn.r_format.re != 0)
+			return SIGILL;
+		rs32s = regs->regs[insn.r_format.rs];
+		rt32s = regs->regs[insn.r_format.rt];
+		t1_64s = rs32s;
+		t2_64s = rt32s;
+		t1_64s *= t2_64s;
+		t1_64 = t1_64s;
+		t1_32 = t1_64 >> 32;
+		t2_32 = t1_64 & 0xffffffffu;
+		regs->lo = (long)(s32)t2_32;
+		regs->hi = (long)(s32)t1_32;
+		return 0;
+	case multu_op:
+		if (insn.r_format.rd != 0 || insn.r_format.re != 0)
+			return SIGILL;
+		rs32 = regs->regs[insn.r_format.rs];
+		rt32 = regs->regs[insn.r_format.rt];
+		t1_64 = rs32;
+		t2_64 = rt32;
+		t1_64 *= t2_64;
+		t1_32 = t1_64 >> 32;
+		t2_32 = t1_64 & 0xffffffffu;
+		regs->lo = (long)(s32)t2_32;
+		regs->hi = (long)(s32)t1_32;
+		return 0;
+	case div_op:
+		if (insn.r_format.rd != 0 || insn.r_format.re != 0)
+			return SIGILL;
+		rs32s = regs->regs[insn.r_format.rs];
+		rt32s = regs->regs[insn.r_format.rt];
+		if (rt32s == 0)
+			return 0; /* Undefined on div/zero, do nothing */
+		t1_32s = rs32s / rt32s;
+		t2_32s = rs32s % rt32s;
+		regs->lo = (long)t1_32s;
+		regs->hi = (long)t2_32s;
+		return 0;
+	case divu_op:
+		if (insn.r_format.rd != 0 || insn.r_format.re != 0)
+			return SIGILL;
+		rs32 = regs->regs[insn.r_format.rs];
+		rt32 = regs->regs[insn.r_format.rt];
+		if (rt32 == 0)
+			return 0; /* Undefined on div/zero, do nothing */
+		t1_32 = rs32 / rt32;
+		t2_32 = rs32 % rt32;
+		regs->lo = (long)(s32)t1_32;
+		regs->hi = (long)(s32)t2_32;
+		return 0;
+	case add_op:
+	case addu_op:
+		if (insn.r_format.re != 0)
+			return SIGILL;
+		rs32 = regs->regs[insn.r_format.rs];
+		rt32 = regs->regs[insn.r_format.rt];
+		rd32 = rs32 + rt32;
+		if (insn.r_format.func == add_op) {
+			/* Check for overflow */
+			int ss = (rs32 >> 31) & 1;
+			int ts = (rt32 >> 31) & 1;
+			int ds = (rd32 >> 31) & 1;
+
+			if (ss == ts && ss != ds) {
+				mfi->si_code = FPE_INTOVF;
+				return SIGFPE;
+			}
+		}
+		if (insn.r_format.rd == 0)
+			return 0; /* ignore result */
+		regs->regs[insn.r_format.rd] = (long)(s32)rd32;
+		return 0;
+	case sub_op:
+	case subu_op:
+		if (insn.r_format.re != 0)
+			return SIGILL;
+		rs32 = regs->regs[insn.r_format.rs];
+		rt32 = regs->regs[insn.r_format.rt];
+		rd32 = rs32 - rt32;
+		if (insn.r_format.func == sub_op) {
+			/* Check for overflow */
+			int ss = (rs32 >> 31) & 1;
+			int ts = (rt32 >> 31) & 1;
+			int ds = (rd32 >> 31) & 1;
+
+			if (ss != ts && ss != ds) {
+				mfi->si_code = FPE_INTOVF;
+				return SIGFPE;
+			}
+		}
+		if (insn.r_format.rd == 0)
+			return 0; /* ignore result */
+		regs->regs[insn.r_format.rd] = (long)(s32)rd32;
+		return 0;
+	case and_op:
+		if (insn.r_format.re != 0)
+			return SIGILL;
+		if (insn.r_format.rd == 0)
+			return 0; /* ignore result */
+		regs->regs[insn.r_format.rd] =
+			regs->regs[insn.r_format.rs] & regs->regs[insn.r_format.rt];
+		return 0;
+	case or_op:
+		if (insn.r_format.re != 0)
+			return SIGILL;
+		if (insn.r_format.rd == 0)
+			return 0; /* ignore result */
+		regs->regs[insn.r_format.rd] =
+			regs->regs[insn.r_format.rs] | regs->regs[insn.r_format.rt];
+		return 0;
+	case xor_op:
+		if (insn.r_format.re != 0)
+			return SIGILL;
+		if (insn.r_format.rd == 0)
+			return 0; /* ignore result */
+		regs->regs[insn.r_format.rd] =
+			regs->regs[insn.r_format.rs] ^ regs->regs[insn.r_format.rt];
+		return 0;
+	case nor_op:
+		if (insn.r_format.re != 0)
+			return SIGILL;
+		if (insn.r_format.rd == 0)
+			return 0; /* ignore result */
+		regs->regs[insn.r_format.rd] =
+			~(regs->regs[insn.r_format.rs] | regs->regs[insn.r_format.rt]);
+		return 0;
+	case slt_op:
+		if (insn.r_format.re != 0)
+			return SIGILL;
+		if (insn.r_format.rd == 0)
+			return 0; /* ignore result */
+		regs->regs[insn.r_format.rd] =
+			((long)regs->regs[insn.r_format.rs]) < ((long)regs->regs[insn.r_format.rt]) ? 1 : 0;
+		return 0;
+	case sltu_op:
+		if (insn.r_format.re != 0)
+			return SIGILL;
+		if (insn.r_format.rd == 0)
+			return 0; /* ignore result */
+		regs->regs[insn.r_format.rd] =
+			regs->regs[insn.r_format.rs] < regs->regs[insn.r_format.rt] ? 1 : 0;
+		return 0;
+	case teq_op:
+		rss = regs->regs[insn.t_format.rs];
+		rts = regs->regs[insn.t_format.rt];
+		if (rss == rts)
+			mips_assert_trap(regs, insn.t_format.code, mfi);
+		else
+			return 0;
+	case tne_op:
+		rss = regs->regs[insn.t_format.rs];
+		rts = regs->regs[insn.t_format.rt];
+		if (rss != rts)
+			mips_assert_trap(regs, insn.t_format.code, mfi);
+		else
+			return 0;
+	case tge_op:
+		rss = regs->regs[insn.t_format.rs];
+		rts = regs->regs[insn.t_format.rt];
+		if (rss >= rts)
+			mips_assert_trap(regs, insn.t_format.code, mfi);
+		else
+			return 0;
+	case tgeu_op:
+		rsu = regs->regs[insn.t_format.rs];
+		rtu = regs->regs[insn.t_format.rt];
+		if (rsu >= rtu)
+			mips_assert_trap(regs, insn.t_format.code, mfi);
+		else
+			return 0;
+	case tlt_op:
+		rss = regs->regs[insn.t_format.rs];
+		rts = regs->regs[insn.t_format.rt];
+		if (rss < rts)
+			mips_assert_trap(regs, insn.t_format.code, mfi);
+		else
+			return 0;
+	case tltu_op:
+		rsu = regs->regs[insn.t_format.rs];
+		rtu = regs->regs[insn.t_format.rt];
+		if (rsu < rtu)
+			mips_assert_trap(regs, insn.t_format.code, mfi);
+		else
+			return 0;
+	case break_op:
+		rsu = insn.b_format.code;
+		/*
+		 * do_bp() in traps.c tells us why we process the
+		 * 'code' like this.
+		 */
+		if (rsu >= (1 << 10))
+			rsu >>= 10;
+		return mips_assert_trap(regs, rsu, mfi);
+	case dsllv_op:
+	case dsrlv_op:
+	case dsrav_op:
+	case dmult_op:
+	case dmultu_op:
+	case ddiv_op:
+	case ddivu_op:
+	case dadd_op:
+	case daddu_op:
+	case dsub_op:
+	case dsubu_op:
+	case dsll_op:
+	case dsrl_op:
+	case dsra_op:
+	case dsll32_op:
+	case dsrl32_op:
+	case dsra32_op:
+		return mips64_spec_emul(regs, ir, mfi);
+	default:
+		return SIGILL;
+	}
+}
+
+static int mips_imm_emul(struct pt_regs *regs, mips_instruction ir,
+			 struct mips_fault_info *mfi)
+{
+	union mips_instruction insn;
+	u32 rs32, rt32;
+	s32 rs32s;
+	u32 t1_32;
+	s32 t1_32s;
+	unsigned long t1;
+
+	insn.word = ir;
+	switch (insn.i_format.opcode) {
+	case addi_op:
+	case addiu_op:
+		rs32 = regs->regs[insn.i_format.rs];
+		t1_32s = insn.i_format.simmediate;
+		t1_32 = t1_32s;
+		rt32 = rs32 + t1_32;
+		if (insn.i_format.opcode == addi_op) {
+			/* Check for overflow */
+			int ss = (rs32 >> 31) & 1;
+			int is = (t1_32 >> 31) & 1;
+			int ts = (rt32 >> 31) & 1;
+
+			if (ss == is && ss != ts) {
+				mfi->si_code = FPE_INTOVF;
+				return SIGFPE;
+			}
+		}
+		if (insn.i_format.rt == 0)
+			return 0; /* ignore result */
+		regs->regs[insn.i_format.rt] = (long)(s32)rt32;
+		return 0;
+	case slti_op:
+		if (insn.i_format.rt == 0)
+			return 0; /* ignore result */
+		rs32s = regs->regs[insn.i_format.rs];
+		t1_32s = insn.i_format.simmediate;
+		regs->regs[insn.i_format.rt] = rs32s > t1_32s ? 1 : 0;
+		return 0;
+	case sltiu_op:
+		if (insn.i_format.rt == 0)
+			return 0; /* ignore result */
+		rs32 = regs->regs[insn.i_format.rs];
+		t1_32s = insn.i_format.simmediate;
+		t1_32 = t1_32s;
+		regs->regs[insn.i_format.rt] = rs32 > t1_32 ? 1 : 0;
+		return 0;
+	case andi_op:
+		if (insn.u_format.rt == 0)
+			return 0; /* ignore result */
+		rs32 = regs->regs[insn.u_format.rs];
+		t1 = insn.u_format.uimmediate;
+		regs->regs[insn.u_format.rt] = t1 & regs->regs[insn.u_format.rs];
+		return 0;
+	case ori_op:
+		if (insn.u_format.rt == 0)
+			return 0; /* ignore result */
+		rs32 = regs->regs[insn.u_format.rs];
+		t1 = insn.u_format.uimmediate;
+		regs->regs[insn.u_format.rt] = t1 | regs->regs[insn.u_format.rs];
+		return 0;
+	case xori_op:
+		if (insn.u_format.rt == 0)
+			return 0; /* ignore result */
+		rs32 = regs->regs[insn.u_format.rs];
+		t1 = insn.u_format.uimmediate;
+		regs->regs[insn.u_format.rt] = t1 ^ regs->regs[insn.u_format.rs];
+		return 0;
+	case lui_op:
+		if (insn.u_format.rs != 0)
+			return SIGILL;
+		if (insn.u_format.rt == 0)
+			return 0; /* ignore result */
+		t1_32 = insn.u_format.uimmediate;
+		t1_32 <<= 16;
+		regs->regs[insn.u_format.rt] = (long)(s32)t1_32;
+		return 0;
+	default:
+		return SIGILL;
+	}
+}
+
+static int mips64_imm_emul(struct pt_regs *regs, mips_instruction ir,
+			   struct mips_fault_info *mfi)
+{
+#ifndef CONFIG_64BIT
+	return SIGILL;
+#else
+	union mips_instruction insn;
+	u64 rs64, rt64;
+	s64 t1_64s;
+	u64 t1_64;
+
+	insn.word = ir;
+	switch (insn.i_format.opcode) {
+	case daddi_op:
+	case daddiu_op:
+		rs64 = regs->regs[insn.i_format.rs];
+		t1_64s = insn.i_format.simmediate;
+		t1_64 = t1_64s;
+		rt64 = rs64 + t1_64;
+		if (insn.i_format.opcode == daddi_op) {
+			/* Check for overflow */
+			int ss = (rs64 >> 63) & 1;
+			int is = (t1_64 >> 63) & 1;
+			int ts = (rt64 >> 63) & 1;
+
+			if (ss == is && ss != ts) {
+				mfi->si_code = FPE_INTOVF;
+				return SIGFPE;
+			}
+		}
+		if (insn.i_format.rt == 0)
+			return 0; /* ignore result */
+		regs->regs[insn.i_format.rt] = rt64;
+		return 0;
+	default:
+		return SIGILL;
+	}
+#endif /* CONFIG_64BIT */
+}
+
+static int mips64_spec2_emul(struct pt_regs *regs, mips_instruction ir)
+{
+#ifndef CONFIG_64BIT
+	return SIGILL;
+#else
+	union mips_instruction insn;
+	u64 t1_64, t2_64;
+	u64 rs64;
+	int i;
+
+	insn.word = ir;
+	switch (insn.r_format.func) {
+	case dclz_op:
+	case dclo_op:
+		t2_64 = (insn.r_format.func == dclz_op) ? 0 : 1;
+		if (insn.r_format.re != 0)
+			return SIGILL;
+		if (insn.r_format.rd == 0)
+			return 0; /* ignore result */
+		rs64 = regs->regs[insn.r_format.rs];
+		t1_64 = 0;
+		for (i = 63; i <= 0; i--) {
+			if (((rs64 >> i) & 1) == t2_64)
+				t1_64++;
+			else
+				break;
+		}
+		regs->regs[insn.r_format.rd] = t1_64;
+		return 0;
+	default:
+		return SIGILL;
+	}
+	return 0;
+#endif /* CONFIG_64BIT */
+}
+
+static int mips_spec2_emul(struct pt_regs *regs, mips_instruction ir)
+{
+	union mips_instruction insn;
+	s32 rs32s, rt32s;
+	u32 rs32, rt32;
+	s64 t1_64s, t2_64s;
+	u64 t1_64, t2_64, t3_64;
+	u32 t1_32, t2_32;
+	int i;
+
+	insn.word = ir;
+	switch (insn.r_format.func) {
+	case madd_op:
+	case msub_op:
+
+		if (insn.r_format.re != 0 || insn.r_format.rd != 0)
+			return SIGILL;
+		rs32s = regs->regs[insn.r_format.rs];
+		rt32s = regs->regs[insn.r_format.rt];
+		t1_64s = rs32s;
+		t2_64s = rt32s;
+		t1_64s = t1_64s * t2_64s;	/* Product */
+		t1_32 = regs->hi;
+		t2_32 = regs->lo;
+		t1_64 = t1_32;
+		t2_64 = t2_32;
+		t1_64 = (t1_64 << 32) | t2_64;
+		t2_64s = t1_64;			/* (hi, lo) */
+		if (insn.r_format.func == madd_op)
+			t2_64s = t2_64s + t1_64s; /* (hi, lo) + Product */
+		else
+			t2_64s = t2_64s - t1_64s; /* (hi, lo) - Product */
+		t1_64 = t2_64s;
+
+		t2_64 = t1_64 & 0xffffffffu;
+		t1_64 = t1_64 >> 32;
+		t1_32 = t1_64;
+		t2_32 = t2_64;
+		regs->hi = (long)(s32)t1_32;
+		regs->lo = (long)(s32)t2_32;
+		return 0;
+
+	case maddu_op:
+	case msubu_op:
+		if (insn.r_format.re != 0 || insn.r_format.rd != 0)
+			return SIGILL;
+		rs32 = regs->regs[insn.r_format.rs];
+		rt32 = regs->regs[insn.r_format.rt];
+		t1_64 = rs32;
+		t2_64 = rt32;
+		t1_64 = t1_64 * t2_64;		/* Product */
+		t1_32 = regs->hi;
+		t2_32 = regs->lo;
+		t2_64 = t1_32;
+		t3_64 = t2_32;
+		t2_64 = (t2_64 << 32) | t3_64;	/* (hi, lo) */
+
+		if (insn.r_format.func == maddu_op)
+			t1_64 = t2_64 + t1_64;	/* (hi, lo) + Product */
+		else
+			t1_64 = t2_64 - t1_64;	/* (hi, lo) - Product */
+
+		t2_64 = t1_64 & 0xffffffffu;
+		t1_64 = t1_64 >> 32;
+		t1_32 = t1_64;
+		t2_32 = t2_64;
+		regs->hi = (long)(s32)t1_32;
+		regs->lo = (long)(s32)t2_32;
+		return 0;
+
+	case mul_op:
+		if (insn.r_format.re != 0)
+			return SIGILL;
+		if (insn.r_format.rd == 0)
+			return 0; /* ignore result */
+		rs32s = regs->regs[insn.r_format.rs];
+		rt32s = regs->regs[insn.r_format.rt];
+		t1_64s = rs32s;
+		t2_64s = rt32s;
+		t1_64s = t1_64s * t2_64s;
+		t1_64 = t1_64s;
+		t1_32 = t1_64;
+		regs->regs[insn.r_format.rd] = (long)(s32)t1_32;
+		return 0;
+
+	case clz_op:
+	case clo_op:
+		t2_32 = (insn.r_format.func == clz_op) ? 0 : 1;
+		if (insn.r_format.re != 0)
+			return SIGILL;
+		if (insn.r_format.rd == 0)
+			return 0; /* ignore result */
+		rs32 = regs->regs[insn.r_format.rs];
+		t1_32 = 0;
+		for (i = 31; i <= 0; i--) {
+			if (((rs32 >> i) & 1) == t2_32)
+				t1_32++;
+			else
+				break;
+		}
+		regs->regs[insn.r_format.rd] = t1_32;
+		return 0;
+
+	case dclz_op:
+	case dclo_op:
+		return mips64_spec2_emul(regs, ir);
+	default:
+		return SIGILL;
+	}
+}
+
+static int mips64_spec3_emul(struct pt_regs *regs, mips_instruction ir)
+{
+#ifndef CONFIG_64BIT
+	return SIGILL;
+#else
+	union mips_instruction insn;
+	u64 rs64, rt64, mask, t64;
+	int pos, size;
+
+	insn.word = ir;
+	rs64 = regs->regs[insn.r_format.rs];
+
+	switch (insn.r_format.func) {
+	case dextm_op:
+		pos = insn.r_format.re;
+		size = insn.r_format.rd + 33;
+		goto extract;
+	case dextu_op:
+		pos = insn.r_format.re + 32;
+		size = insn.r_format.rd + 1;
+		goto extract;
+	case dext_op:
+		pos = insn.r_format.re;
+		size = insn.r_format.rd + 1;
+extract:
+		rt64 = (rs64 >> pos) & (0xffffffffffffffffull >> (64 - size));
+		regs->regs[insn.r_format.rt] = rt64;
+		return 0;
+	case dinsm_op:
+		pos = insn.r_format.re;
+		size = insn.r_format.rd + 33 - pos;
+		goto insert;
+	case dinsu_op:
+		pos = insn.r_format.re + 32;
+		size = insn.r_format.rd + 33 - pos;
+		goto insert;
+	case dins_op:
+		pos = insn.r_format.re;
+		size = insn.r_format.rd + 1 - pos;
+insert:
+		mask = (0xffffffffffffffffull >> (64 - size));
+		t64 = rs64 & mask;
+		mask <<= pos;
+		mask = ~mask;
+		t64 <<= pos;
+		rt64 = regs->regs[insn.r_format.rt];
+		rt64 = (rt64 & mask) | t64;
+		regs->regs[insn.r_format.rt] = rt64;
+		return 0;
+	default:
+		return SIGILL;
+	}
+#endif /* CONFIG_64BIT */
+}
+
+static int mips_bshfl_emul(struct pt_regs *regs, mips_instruction ir)
+{
+	union mips_instruction insn;
+	u32 rt32, rd32;
+	s8 t8s;
+	s16 t16s;
+
+	insn.word = ir;
+	if (insn.r_format.rs != 0)
+		return SIGILL;
+
+	switch (insn.r_format.re) {
+	case wsbh_op:
+		if (insn.r_format.rd == 0)
+			return 0; /* ignore result */
+		rt32 = regs->regs[insn.r_format.rt];
+		rd32 = ((rt32 >> 8) & 0x00ff00ffu) | ((rt32 << 8) & 0xff00ff00u);
+		regs->regs[insn.r_format.rd] = (long)(s32)rd32;
+		return 0;
+	case seb_op:
+		if (insn.r_format.rd == 0)
+			return 0; /* ignore result */
+		t8s = regs->regs[insn.r_format.rt];
+		regs->regs[insn.r_format.rd] = (long)t8s;
+		return 0;
+	case seh_op:
+		if (insn.r_format.rd == 0)
+			return 0; /* ignore result */
+		t16s = regs->regs[insn.r_format.rt];
+		regs->regs[insn.r_format.rd] = (long)t16s;
+		return 0;
+	default:
+		return SIGILL;
+	}
+}
+
+static int mips_dbshfl_emul(struct pt_regs *regs, mips_instruction ir)
+{
+#ifndef CONFIG_64BIT
+	return SIGILL;
+#else
+	u64 rt64, rd64;
+	union mips_instruction insn;
+
+	insn.word = ir;
+	if (insn.r_format.rs != 0)
+		return SIGILL;
+	switch (insn.r_format.re) {
+	case wsbh_op: /* DSBH */
+		if (insn.r_format.rd == 0)
+			return 0; /* ignore result */
+		rt64 = regs->regs[insn.r_format.rt];
+		rd64 =	((rt64 << 8) & 0xff00ff00ff00ff00ull) |
+			((rt64 >> 8) & 0x00ff00ff00ff00ffull);
+		regs->regs[insn.r_format.rd] = rd64;
+		return 0;
+	case dshd_op:
+		if (insn.r_format.rd == 0)
+			return 0; /* ignore result */
+		rt64 = regs->regs[insn.r_format.rt];
+		rd64 =	((rt64 << 48) & 0xffff000000000000ull) |
+			((rt64 << 16) & 0x0000ffff00000000ull) |
+			((rt64 >> 16) & 0x00000000ffff0000ull) |
+			((rt64 >> 48) & 0x000000000000ffffull);
+		regs->regs[insn.r_format.rd] = rd64;
+		return 0;
+	default:
+		return SIGILL;
+	}
+#endif /* CONFIG_64BIT */
+}
+
+static int mips_rdhwr_emul(struct pt_regs *regs, mips_instruction ir)
+{
+	union mips_instruction insn;
+	int rt;
+	unsigned long v32;
+
+	insn.word = ir;
+	if (insn.r_format.re != 0 || insn.r_format.re != 0)
+		return SIGILL;
+	rt = insn.r_format.rt;
+
+	switch (insn.r_format.rd) {
+	case 0: /* EBase[CPUNum]*/
+		if (cpu_has_mips_r2) {
+			regs->regs[rt] = read_c0_ebase() & 0x3ff;
+				return 0;
+		} else {
+			return SIGILL;
+		}
+	case 1: /* SYNCI_Step */
+		if (cpu_has_mips_r2) {
+			__asm__(".set	push\n"
+				"	.set	mips32r2\n"
+				"	rdhwr	%[v], $1\n"
+				"	.set	pop" : [v] "=r" (v32));
+			regs->regs[rt] = v32;
+			return 0;
+		} else {
+			return SIGILL;
+		}
+	case 2: /* Count */
+		regs->regs[rt] = (long)(s32)read_c0_count();
+		return 0;
+	case 3: /* CCRes */
+		if (cpu_has_mips_r2) {
+			__asm__(".set	push\n"
+				"	.set	mips32r2\n"
+				"	rdhwr	%[v], $3\n"
+				"	.set	pop" : [v] "=r" (v32));
+			regs->regs[rt] = v32;
+			return 0;
+		} else {
+			return SIGILL;
+		}
+	case 29: /* UserLocal */
+		regs->regs[rt] = task_thread_info(current)->tp_value;
+		return 0;
+	default:
+		return SIGILL;
+	}
+}
+
+static int mips_spec3_emul(struct pt_regs *regs, mips_instruction ir)
+{
+	union mips_instruction insn;
+	u32 rs32, rt32;
+	u32 t1_32;
+
+	insn.word = ir;
+	switch (insn.r_format.func) {
+	case ext_op:
+		if (insn.r_format.rt == 0)
+			return 0; /* ignore result */
+		rs32 = regs->regs[insn.r_format.rs];
+		rt32 = rs32 >> insn.r_format.re;
+		rt32 = rt32 & (0xffffffffu >> (31 - insn.r_format.rd));
+		regs->regs[insn.r_format.rt] = (long)(s32)rt32;
+		return 0;
+	case ins_op:
+		if (insn.r_format.rt == 0)
+			return 0; /* ignore result */
+		t1_32 = 0xffffffffu >> (31 - insn.r_format.rd + insn.r_format.re);
+		t1_32 = t1_32 << insn.r_format.re; /* Mask */
+		rs32 = regs->regs[insn.r_format.rs];
+		rt32 = regs->regs[insn.r_format.rt];
+		rt32 = (rt32 & ~t1_32);
+		rs32 = (rs32 << insn.r_format.re) & t1_32;
+		rt32 = rt32 | rs32;
+		regs->regs[insn.r_format.rt] = (long)(s32)rt32;
+		return 0;
+	case bshfl_op:
+		return  mips_bshfl_emul(regs, ir);
+	case dbshfl_op:
+		return  mips_dbshfl_emul(regs, ir);
+	case rdhwr_op:
+		return mips_rdhwr_emul(regs, ir);
+	case dextm_op:
+	case dextu_op:
+	case dext_op:
+	case dinsm_op:
+	case dinsu_op:
+	case dins_op:
+		return mips64_spec3_emul(regs, ir);
+	default:
+		return SIGILL;
+	}
+}
+
+static int mips_load_emul(struct pt_regs *regs, mips_instruction ir,
+			  struct mips_fault_info *mfi)
+{
+	s8 __user *va8s;
+	s16 __user *va16s;
+	s32 __user *va32s;
+	u8 __user *va8;
+	u16 __user *va16;
+	union mips_instruction insn;
+	long base;
+	s8 t8s;
+	u8 t8;
+	s16 t16s;
+	u16 t16;
+	s32 t32s;
+
+	insn.word = ir;
+
+	base = regs->regs[insn.i_format.rs];
+	base = base + insn.i_format.simmediate;
+
+	switch (insn.i_format.opcode) {
+	case lb_op:
+		va8s = (s8 __user *)base;
+		if (!access_ok(VERIFY_READ, va8s, sizeof(t8s))) {
+			*mfi->fault_addr = va8s;
+			return SIGBUS;
+		}
+		if (__get_user_nocheck(t8s, va8s, sizeof(t8s))) {
+			*mfi->fault_addr = va8s;
+			return SIGSEGV;
+		}
+		if (insn.i_format.rt == 0)
+			return 0; /* ignore result */
+		regs->regs[insn.i_format.rt] = (long)t8s;
+		return 0;
+	case lh_op:
+		va16s = (s16 __user *)base;
+		if (!access_ok(VERIFY_READ, va16s, sizeof(t16s))) {
+			*mfi->fault_addr = va16s;
+			return SIGBUS;
+		}
+		if (__get_user_nocheck(t16s, va16s, sizeof(t16s))) {
+			*mfi->fault_addr = va16s;
+			return SIGSEGV;
+		}
+		if (insn.i_format.rt == 0)
+			return 0; /* ignore result */
+		regs->regs[insn.i_format.rt] = (long)t16s;
+		return 0;
+	case ll_op:
+		/*
+		 * Treat LL as LW, we are doing an ERET so once in
+		 * user space the result is the same.
+		 *
+		 * Fall through...
+		 */
+	case lw_op:
+		va32s = (s32 __user *)base;
+		if (!access_ok(VERIFY_READ, va32s, sizeof(t32s))) {
+			*mfi->fault_addr = va32s;
+			return SIGBUS;
+		}
+		if (__get_user_nocheck(t32s, va32s, sizeof(t32s))) {
+			*mfi->fault_addr = va32s;
+			return SIGSEGV;
+		}
+		if (insn.i_format.rt == 0)
+			return 0; /* ignore result */
+		regs->regs[insn.i_format.rt] = (long)t32s;
+		return 0;
+	case lbu_op:
+		va8 = (u8 __user *)base;
+		if (!access_ok(VERIFY_READ, va8, sizeof(t8))) {
+			*mfi->fault_addr = va8;
+			return SIGBUS;
+		}
+		if (__get_user_nocheck(t8, va8, sizeof(t8))) {
+			*mfi->fault_addr = va8;
+			return SIGSEGV;
+		}
+		if (insn.i_format.rt == 0)
+			return 0; /* ignore result */
+		regs->regs[insn.i_format.rt] = t8;
+		return 0;
+	case lhu_op:
+		va16 = (u16 __user *)base;
+		if (!access_ok(VERIFY_READ, va16, sizeof(t16))) {
+			*mfi->fault_addr = va16;
+			return SIGBUS;
+		}
+		if (__get_user_nocheck(t16, va16, sizeof(t16))) {
+			*mfi->fault_addr = va16;
+			return SIGSEGV;
+		}
+		if (insn.i_format.rt == 0)
+			return 0; /* ignore result */
+		regs->regs[insn.i_format.rt] = t16;
+		return 0;
+	default:
+		return SIGILL;
+	}
+}
+
+static int mips_store_emul(struct pt_regs *regs, mips_instruction ir,
+			   struct mips_fault_info *mfi)
+{
+	u8 __user *va8;
+	u16 __user *va16;
+	u32 __user *va32;
+	u8 t8;
+	u16 t16;
+	u32 t32;
+	union mips_instruction insn;
+	long base;
+
+	insn.word = ir;
+
+	base = regs->regs[insn.i_format.rs];
+	base = base + insn.i_format.simmediate;
+
+	switch (insn.i_format.opcode) {
+	case sb_op:
+		va8 = (u8 __user *)base;
+		if (!access_ok(VERIFY_WRITE, va8, sizeof(t8))) {
+			*mfi->fault_addr = va8;
+			return SIGBUS;
+		}
+		t8 = (u8)regs->regs[insn.i_format.rt];
+		if (__put_user_nocheck(t8, va8, sizeof(t8))) {
+			*mfi->fault_addr = va8;
+			return SIGSEGV;
+		}
+		return 0;
+	case sh_op:
+		va16 = (u16 __user *)base;
+		if (!access_ok(VERIFY_WRITE, va16, sizeof(t16))) {
+			*mfi->fault_addr = va16;
+			return SIGBUS;
+		}
+		t16 = (u16)regs->regs[insn.i_format.rt];
+		if (__put_user_nocheck(t16, va16, sizeof(t16))) {
+			*mfi->fault_addr = va16;
+			return SIGSEGV;
+		}
+		return 0;
+	case sw_op:
+		va32 = (u32 __user *)base;
+		if (!access_ok(VERIFY_WRITE, va32, sizeof(t32))) {
+			*mfi->fault_addr = va32;
+			return SIGBUS;
+		}
+		t32 = (u32)regs->regs[insn.i_format.rt];
+		if (__put_user_nocheck(t32, va32, sizeof(t32))) {
+			*mfi->fault_addr = va32;
+			return SIGSEGV;
+		}
+		return 0;
+	default:
+		return SIGILL;
+	}
+}
+
+static int mips64_load_emul(struct pt_regs *regs, mips_instruction ir,
+			    struct mips_fault_info *mfi)
+{
+#ifndef CONFIG_64BIT
+	return SIGILL;
+#else
+	union mips_instruction insn;
+	long base;
+	u64 __user *va64;
+	s32 __user *va32s;
+	u64 t64;
+	s32 t32s;
+
+	insn.word = ir;
+
+	base = regs->regs[insn.i_format.rs];
+	base = base + insn.i_format.simmediate;
+
+	switch (insn.i_format.opcode) {
+	case lld_op:
+		/*
+		 * Treat LLD as LD, we are doing an ERET so once in
+		 * user space the result is the same.
+		 *
+		 * Fall through...
+		 */
+	case ld_op:
+		va64 = (u64 __user *)base;
+		if (!access_ok(VERIFY_READ, va64, sizeof(t64))) {
+			*mfi->fault_addr = va64;
+			return SIGBUS;
+		}
+		if (__get_user_nocheck(t64, va64, sizeof(t64))) {
+			*mfi->fault_addr = va64;
+			return SIGSEGV;
+		}
+		if (insn.i_format.rt == 0)
+			return 0; /* ignore result */
+		regs->regs[insn.i_format.rt] = t64;
+		return 0;
+	case lwu_op:
+		va32s = (s32 __user *)base;
+		if (!access_ok(VERIFY_READ, va32s, sizeof(t32s))) {
+			*mfi->fault_addr = va32s;
+			return SIGBUS;
+		}
+		if (__get_user_nocheck(t32s, va32s, sizeof(t32s))) {
+			*mfi->fault_addr = va32s;
+			return SIGSEGV;
+		}
+		if (insn.i_format.rt == 0)
+			return 0; /* ignore result */
+		regs->regs[insn.i_format.rt] = (long)t32s;
+		return 0;
+	default:
+		return SIGILL;
+	}
+#endif /* CONFIG_64BIT */
+}
+
+static int mips64_store_emul(struct pt_regs *regs, mips_instruction ir,
+			     struct mips_fault_info *mfi)
+{
+#ifndef CONFIG_64BIT
+	return SIGILL;
+#else
+	u64 __user *va64;
+	u64 t64;
+	union mips_instruction insn;
+	long base;
+
+	insn.word = ir;
+
+	base = regs->regs[insn.i_format.rs];
+	base = base + insn.i_format.simmediate;
+
+	va64 = (u64 __user *)base;
+	if (!access_ok(VERIFY_WRITE, va64, sizeof(t64))) {
+		*mfi->fault_addr = va64;
+		return SIGBUS;
+	}
+	t64 = regs->regs[insn.i_format.rt];
+	if (__put_user_nocheck(t64, va64, sizeof(t64))) {
+		*mfi->fault_addr = va64;
+		return SIGSEGV;
+	}
+	return 0;
+#endif /* CONFIG_64BIT */
+}
+
+static int mips_sc_emul(struct pt_regs *regs, mips_instruction ir,
+			struct mips_fault_info *mfi)
+{
+	union mips_instruction insn;
+
+	insn.word = ir;
+
+#ifndef CONFIG_64BIT
+	if (insn.i_format.opcode == scd_op)
+		return SIGILL;
+#endif
+	/* All SC and SCD always fail under emulation, and this is fine. */
+	if (insn.i_format.rt)
+		regs->regs[insn.i_format.rt] = 0;
+
+	return 0;
+}
+
+static int mips_regimm_emul(struct pt_regs *regs, mips_instruction ir,
+			struct mips_fault_info *mfi)
+{
+	union mips_instruction insn;
+	long simmediate, sreg;
+	long uimmediate, ureg;
+
+	insn.word = ir;
+	switch (insn.i_format.rt) {
+	case tgei_op:
+		simmediate = insn.i_format.simmediate;
+		sreg = regs->regs[insn.i_format.rs];
+		if (sreg >= simmediate)
+			return mips_assert_trap(regs, 0, mfi);
+		else
+			return 0;
+	case tgeiu_op:
+		simmediate = insn.i_format.simmediate;
+		uimmediate = simmediate;
+		ureg = regs->regs[insn.i_format.rs];
+		if (ureg >= uimmediate)
+			return mips_assert_trap(regs, 0, mfi);
+		else
+			return 0;
+	case tlti_op:
+		simmediate = insn.i_format.simmediate;
+		sreg = regs->regs[insn.i_format.rs];
+		if (sreg < simmediate)
+			return mips_assert_trap(regs, 0, mfi);
+		else
+			return 0;
+	case tltiu_op:
+		simmediate = insn.i_format.simmediate;
+		uimmediate = simmediate;
+		ureg = regs->regs[insn.i_format.rs];
+		if (ureg < uimmediate)
+			return mips_assert_trap(regs, 0, mfi);
+		else
+			return 0;
+	case teqi_op:
+		simmediate = insn.i_format.simmediate;
+		sreg = regs->regs[insn.i_format.rs];
+		if (sreg == simmediate)
+			return mips_assert_trap(regs, 0, mfi);
+		else
+			return 0;
+	case tnei_op:
+		simmediate = insn.i_format.simmediate;
+		sreg = regs->regs[insn.i_format.rs];
+		if (sreg != simmediate)
+			return mips_assert_trap(regs, 0, mfi);
+		else
+			return 0;
+	case op_synci:
+		__flush_cache_all();
+		return 0;
+	default:
+		return SIGILL;
+	}
+}
+
+int mips_insn_emul(struct pt_regs *regs, mips_instruction ir,
+		   void *__user *fault_addr)
+{
+	struct mips_fault_info mfi;
+
+	mfi.fault_addr = fault_addr;
+	mfi.si_code = -1;
+
+	switch (MIPSInst_OPCODE(ir)) {
+	case spec_op:
+		return mips_spec_emul(regs, ir, &mfi);
+	case bcond_op:
+		return mips_regimm_emul(regs, ir, &mfi);
+	case addi_op:
+	case addiu_op:
+	case slti_op:
+	case sltiu_op:
+	case andi_op:
+	case ori_op:
+	case xori_op:
+	case lui_op:
+		return mips_imm_emul(regs, ir, &mfi);
+	case daddi_op:
+	case daddiu_op:
+		return mips64_imm_emul(regs, ir, &mfi);
+	case spec2_op:
+		return mips_spec2_emul(regs, ir);
+	case spec3_op:
+		return mips_spec3_emul(regs, ir);
+	case lb_op:
+	case lh_op:
+	case lw_op:
+	case lbu_op:
+	case lhu_op:
+	case ll_op:
+		return mips_load_emul(regs, ir, &mfi);
+	case sb_op:
+	case sh_op:
+	case sw_op:
+		return mips_store_emul(regs, ir, &mfi);
+	case lwu_op:
+	case ld_op:
+	case lld_op:
+		return mips64_load_emul(regs, ir, &mfi);
+	case sd_op:
+		return mips64_store_emul(regs, ir, &mfi);
+	case pref_op:
+		return 0; /* OK to ignore PREF */
+	case sc_op:
+	case scd_op:
+		return mips_sc_emul(regs, ir, &mfi);
+	default:
+		return SIGILL;
+	}
+}
-- 
1.7.11.7
