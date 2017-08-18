Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 18 Aug 2017 15:22:01 +0200 (CEST)
Received: from mx2.rt-rk.com ([89.216.37.149]:46404 "EHLO mail.rt-rk.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23994910AbdHRNUotqru9 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 18 Aug 2017 15:20:44 +0200
Received: from localhost (localhost [127.0.0.1])
        by mail.rt-rk.com (Postfix) with ESMTP id DF87A1A1DF4;
        Fri, 18 Aug 2017 15:20:38 +0200 (CEST)
X-Virus-Scanned: amavisd-new at rt-rk.com
Received: from rtrkw197-lin.domain.local (unknown [10.10.13.95])
        by mail.rt-rk.com (Postfix) with ESMTPSA id AF83F1A1D54;
        Fri, 18 Aug 2017 15:20:38 +0200 (CEST)
From:   Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
To:     linux-mips@linux-mips.org
Cc:     Aleksandar Markovic <aleksandar.markovic@imgtec.com>,
        Miodrag Dinic <miodrag.dinic@imgtec.com>,
        Goran Ferenc <goran.ferenc@imgtec.com>,
        Bo Hu <bohu@google.com>,
        Douglas Leung <douglas.leung@imgtec.com>,
        James Hogan <james.hogan@imgtec.com>,
        Jin Qian <jinqian@google.com>, linux-kernel@vger.kernel.org,
        "Maciej W. Rozycki" <macro@imgtec.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Paul Burton <paul.burton@imgtec.com>,
        Petar Jovanovic <petar.jovanovic@imgtec.com>,
        Raghu Gandham <raghu.gandham@imgtec.com>,
        Ralf Baechle <ralf@linux-mips.org>
Subject: [PATCH 6/6] MIPS: math-emu: Add FP emu debugfs stats for individual instructions
Date:   Fri, 18 Aug 2017 15:17:35 +0200
Message-Id: <1503062286-27030-7-git-send-email-aleksandar.markovic@rt-rk.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1503062286-27030-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1503062286-27030-1-git-send-email-aleksandar.markovic@rt-rk.com>
Return-Path: <aleksandar.markovic@rt-rk.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 59662
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: aleksandar.markovic@rt-rk.com
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

From: Aleksandar Markovic <aleksandar.markovic@imgtec.com>

Add FP emulation debugfs statistics for individual instructions. The
counters are placed in a separate directory called "instructions".
The default full path of this directory is
"/sys/kernel/debug/mips/fpuemustats/instructions"."

One example of usage:

mips_host::/sys/kernel/debug/mips/fpuemustats/instructions # grep "" *

The shortened output of this command is:

abs.d:34
abs.s:5711
add.d:10401
add.s:399307
bc1eqz:3199
...
...
...
sub.s:167211
trunc.l.d:375
trunc.l.s:8054
trunc.w.d:421
trunc.w.s:27032

The limitation of this patch is that it handles R6 FP emulation
instructions only. There are altogether 114 handled instructions.

Signed-off-by: Miodrag Dinic <miodrag.dinic@imgtec.com>
Signed-off-by: Goran Ferenc <goran.ferenc@imgtec.com>
Signed-off-by: Aleksandar Markovic <aleksandar.markovic@imgtec.com>
---
 arch/mips/include/asm/fpu_emulator.h | 115 ++++++++++++++
 arch/mips/math-emu/cp1emu.c          | 258 ++++++++++++++++++++++++++++++++
 arch/mips/math-emu/me-debugfs.c      | 281 ++++++++++++++++++++++++++++++++++-
 3 files changed, 650 insertions(+), 4 deletions(-)

diff --git a/arch/mips/include/asm/fpu_emulator.h b/arch/mips/include/asm/fpu_emulator.h
index 7f5cf1f..c7544de 100644
--- a/arch/mips/include/asm/fpu_emulator.h
+++ b/arch/mips/include/asm/fpu_emulator.h
@@ -46,6 +46,121 @@ struct mips_fpu_emulator_stats {
 	unsigned long ieee754_zerodiv;
 	unsigned long ieee754_invalidop;
 	unsigned long ds_emul;
+
+	unsigned long abs_s;
+	unsigned long abs_d;
+	unsigned long add_s;
+	unsigned long add_d;
+	unsigned long bc1eqz;
+	unsigned long bc1nez;
+	unsigned long ceil_w_s;
+	unsigned long ceil_w_d;
+	unsigned long ceil_l_s;
+	unsigned long ceil_l_d;
+	unsigned long class_s;
+	unsigned long class_d;
+	unsigned long cmp_af_s;
+	unsigned long cmp_af_d;
+	unsigned long cmp_eq_s;
+	unsigned long cmp_eq_d;
+	unsigned long cmp_le_s;
+	unsigned long cmp_le_d;
+	unsigned long cmp_lt_s;
+	unsigned long cmp_lt_d;
+	unsigned long cmp_ne_s;
+	unsigned long cmp_ne_d;
+	unsigned long cmp_or_s;
+	unsigned long cmp_or_d;
+	unsigned long cmp_ueq_s;
+	unsigned long cmp_ueq_d;
+	unsigned long cmp_ule_s;
+	unsigned long cmp_ule_d;
+	unsigned long cmp_ult_s;
+	unsigned long cmp_ult_d;
+	unsigned long cmp_un_s;
+	unsigned long cmp_un_d;
+	unsigned long cmp_une_s;
+	unsigned long cmp_une_d;
+	unsigned long cmp_saf_s;
+	unsigned long cmp_saf_d;
+	unsigned long cmp_seq_s;
+	unsigned long cmp_seq_d;
+	unsigned long cmp_sle_s;
+	unsigned long cmp_sle_d;
+	unsigned long cmp_slt_s;
+	unsigned long cmp_slt_d;
+	unsigned long cmp_sne_s;
+	unsigned long cmp_sne_d;
+	unsigned long cmp_sor_s;
+	unsigned long cmp_sor_d;
+	unsigned long cmp_sueq_s;
+	unsigned long cmp_sueq_d;
+	unsigned long cmp_sule_s;
+	unsigned long cmp_sule_d;
+	unsigned long cmp_sult_s;
+	unsigned long cmp_sult_d;
+	unsigned long cmp_sun_s;
+	unsigned long cmp_sun_d;
+	unsigned long cmp_sune_s;
+	unsigned long cmp_sune_d;
+	unsigned long cvt_d_l;
+	unsigned long cvt_d_s;
+	unsigned long cvt_d_w;
+	unsigned long cvt_l_s;
+	unsigned long cvt_l_d;
+	unsigned long cvt_s_d;
+	unsigned long cvt_s_l;
+	unsigned long cvt_s_w;
+	unsigned long cvt_w_s;
+	unsigned long cvt_w_d;
+	unsigned long div_s;
+	unsigned long div_d;
+	unsigned long floor_w_s;
+	unsigned long floor_w_d;
+	unsigned long floor_l_s;
+	unsigned long floor_l_d;
+	unsigned long maddf_s;
+	unsigned long maddf_d;
+	unsigned long max_s;
+	unsigned long max_d;
+	unsigned long maxa_s;
+	unsigned long maxa_d;
+	unsigned long min_s;
+	unsigned long min_d;
+	unsigned long mina_s;
+	unsigned long mina_d;
+	unsigned long mov_s;
+	unsigned long mov_d;
+	unsigned long msubf_s;
+	unsigned long msubf_d;
+	unsigned long mul_s;
+	unsigned long mul_d;
+	unsigned long neg_s;
+	unsigned long neg_d;
+	unsigned long recip_s;
+	unsigned long recip_d;
+	unsigned long rint_s;
+	unsigned long rint_d;
+	unsigned long round_w_s;
+	unsigned long round_w_d;
+	unsigned long round_l_s;
+	unsigned long round_l_d;
+	unsigned long rsqrt_s;
+	unsigned long rsqrt_d;
+	unsigned long sel_s;
+	unsigned long sel_d;
+	unsigned long seleqz_s;
+	unsigned long seleqz_d;
+	unsigned long selnez_s;
+	unsigned long selnez_d;
+	unsigned long sqrt_s;
+	unsigned long sqrt_d;
+	unsigned long sub_s;
+	unsigned long sub_d;
+	unsigned long trunc_w_s;
+	unsigned long trunc_w_d;
+	unsigned long trunc_l_s;
+	unsigned long trunc_l_d;
 };
 
 DECLARE_PER_CPU(struct mips_fpu_emulator_stats, fpuemustats);
diff --git a/arch/mips/math-emu/cp1emu.c b/arch/mips/math-emu/cp1emu.c
index 40c74e1..b1aeb62 100644
--- a/arch/mips/math-emu/cp1emu.c
+++ b/arch/mips/math-emu/cp1emu.c
@@ -1195,9 +1195,11 @@ static int cop1Emulate(struct pt_regs *xcp, struct mips_fpu_struct *ctx,
 			bit0 = get_fpr32(fpr, 0) & 0x1;
 			switch (MIPSInst_RS(ir)) {
 			case bc1eqz_op:
+				MIPS_FPU_EMU_INC_STATS(bc1eqz);
 				cond = bit0 == 0;
 				break;
 			case bc1nez_op:
+				MIPS_FPU_EMU_INC_STATS(bc1nez);
 				cond = bit0 != 0;
 				break;
 			}
@@ -1683,15 +1685,19 @@ static int fpu_emu(struct pt_regs *xcp, struct mips_fpu_struct *ctx,
 		switch (MIPSInst_FUNC(ir)) {
 			/* binary ops */
 		case fadd_op:
+			MIPS_FPU_EMU_INC_STATS(add_s);
 			handler.b = ieee754sp_add;
 			goto scopbop;
 		case fsub_op:
+			MIPS_FPU_EMU_INC_STATS(sub_s);
 			handler.b = ieee754sp_sub;
 			goto scopbop;
 		case fmul_op:
+			MIPS_FPU_EMU_INC_STATS(mul_s);
 			handler.b = ieee754sp_mul;
 			goto scopbop;
 		case fdiv_op:
+			MIPS_FPU_EMU_INC_STATS(div_s);
 			handler.b = ieee754sp_div;
 			goto scopbop;
 
@@ -1700,6 +1706,7 @@ static int fpu_emu(struct pt_regs *xcp, struct mips_fpu_struct *ctx,
 			if (!cpu_has_mips_2_3_4_5_r)
 				return SIGILL;
 
+			MIPS_FPU_EMU_INC_STATS(sqrt_s);
 			handler.u = ieee754sp_sqrt;
 			goto scopuop;
 
@@ -1712,6 +1719,7 @@ static int fpu_emu(struct pt_regs *xcp, struct mips_fpu_struct *ctx,
 			if (!cpu_has_mips_4_5_64_r2_r6)
 				return SIGILL;
 
+			MIPS_FPU_EMU_INC_STATS(rsqrt_s);
 			handler.u = fpemu_sp_rsqrt;
 			goto scopuop;
 
@@ -1719,6 +1727,7 @@ static int fpu_emu(struct pt_regs *xcp, struct mips_fpu_struct *ctx,
 			if (!cpu_has_mips_4_5_64_r2_r6)
 				return SIGILL;
 
+			MIPS_FPU_EMU_INC_STATS(recip_s);
 			handler.u = fpemu_sp_recip;
 			goto scopuop;
 
@@ -1755,6 +1764,7 @@ static int fpu_emu(struct pt_regs *xcp, struct mips_fpu_struct *ctx,
 			if (!cpu_has_mips_r6)
 				return SIGILL;
 
+			MIPS_FPU_EMU_INC_STATS(seleqz_s);
 			SPFROMREG(rv.s, MIPSInst_FT(ir));
 			if (rv.w & 0x1)
 				rv.w = 0;
@@ -1766,6 +1776,7 @@ static int fpu_emu(struct pt_regs *xcp, struct mips_fpu_struct *ctx,
 			if (!cpu_has_mips_r6)
 				return SIGILL;
 
+			MIPS_FPU_EMU_INC_STATS(selnez_s);
 			SPFROMREG(rv.s, MIPSInst_FT(ir));
 			if (rv.w & 0x1)
 				SPFROMREG(rv.s, MIPSInst_FS(ir));
@@ -1779,6 +1790,7 @@ static int fpu_emu(struct pt_regs *xcp, struct mips_fpu_struct *ctx,
 			if (!cpu_has_mips_r6)
 				return SIGILL;
 
+			MIPS_FPU_EMU_INC_STATS(maddf_s);
 			SPFROMREG(ft, MIPSInst_FT(ir));
 			SPFROMREG(fs, MIPSInst_FS(ir));
 			SPFROMREG(fd, MIPSInst_FD(ir));
@@ -1792,6 +1804,7 @@ static int fpu_emu(struct pt_regs *xcp, struct mips_fpu_struct *ctx,
 			if (!cpu_has_mips_r6)
 				return SIGILL;
 
+			MIPS_FPU_EMU_INC_STATS(msubf_s);
 			SPFROMREG(ft, MIPSInst_FT(ir));
 			SPFROMREG(fs, MIPSInst_FS(ir));
 			SPFROMREG(fd, MIPSInst_FD(ir));
@@ -1805,6 +1818,7 @@ static int fpu_emu(struct pt_regs *xcp, struct mips_fpu_struct *ctx,
 			if (!cpu_has_mips_r6)
 				return SIGILL;
 
+			MIPS_FPU_EMU_INC_STATS(rint_s);
 			SPFROMREG(fs, MIPSInst_FS(ir));
 			rv.s = ieee754sp_rint(fs);
 			goto copcsr;
@@ -1816,6 +1830,7 @@ static int fpu_emu(struct pt_regs *xcp, struct mips_fpu_struct *ctx,
 			if (!cpu_has_mips_r6)
 				return SIGILL;
 
+			MIPS_FPU_EMU_INC_STATS(class_s);
 			SPFROMREG(fs, MIPSInst_FS(ir));
 			rv.w = ieee754sp_2008class(fs);
 			rfmt = w_fmt;
@@ -1828,6 +1843,7 @@ static int fpu_emu(struct pt_regs *xcp, struct mips_fpu_struct *ctx,
 			if (!cpu_has_mips_r6)
 				return SIGILL;
 
+			MIPS_FPU_EMU_INC_STATS(min_s);
 			SPFROMREG(ft, MIPSInst_FT(ir));
 			SPFROMREG(fs, MIPSInst_FS(ir));
 			rv.s = ieee754sp_fmin(fs, ft);
@@ -1840,6 +1856,7 @@ static int fpu_emu(struct pt_regs *xcp, struct mips_fpu_struct *ctx,
 			if (!cpu_has_mips_r6)
 				return SIGILL;
 
+			MIPS_FPU_EMU_INC_STATS(mina_s);
 			SPFROMREG(ft, MIPSInst_FT(ir));
 			SPFROMREG(fs, MIPSInst_FS(ir));
 			rv.s = ieee754sp_fmina(fs, ft);
@@ -1852,6 +1869,7 @@ static int fpu_emu(struct pt_regs *xcp, struct mips_fpu_struct *ctx,
 			if (!cpu_has_mips_r6)
 				return SIGILL;
 
+			MIPS_FPU_EMU_INC_STATS(max_s);
 			SPFROMREG(ft, MIPSInst_FT(ir));
 			SPFROMREG(fs, MIPSInst_FS(ir));
 			rv.s = ieee754sp_fmax(fs, ft);
@@ -1864,6 +1882,7 @@ static int fpu_emu(struct pt_regs *xcp, struct mips_fpu_struct *ctx,
 			if (!cpu_has_mips_r6)
 				return SIGILL;
 
+			MIPS_FPU_EMU_INC_STATS(maxa_s);
 			SPFROMREG(ft, MIPSInst_FT(ir));
 			SPFROMREG(fs, MIPSInst_FS(ir));
 			rv.s = ieee754sp_fmaxa(fs, ft);
@@ -1871,15 +1890,18 @@ static int fpu_emu(struct pt_regs *xcp, struct mips_fpu_struct *ctx,
 		}
 
 		case fabs_op:
+			MIPS_FPU_EMU_INC_STATS(abs_s);
 			handler.u = ieee754sp_abs;
 			goto scopuop;
 
 		case fneg_op:
+			MIPS_FPU_EMU_INC_STATS(neg_s);
 			handler.u = ieee754sp_neg;
 			goto scopuop;
 
 		case fmov_op:
 			/* an easy one */
+			MIPS_FPU_EMU_INC_STATS(mov_s);
 			SPFROMREG(rv.s, MIPSInst_FS(ir));
 			goto copcsr;
 
@@ -1922,12 +1944,14 @@ static int fpu_emu(struct pt_regs *xcp, struct mips_fpu_struct *ctx,
 			return SIGILL;	/* not defined */
 
 		case fcvtd_op:
+			MIPS_FPU_EMU_INC_STATS(cvt_d_s);
 			SPFROMREG(fs, MIPSInst_FS(ir));
 			rv.d = ieee754dp_fsp(fs);
 			rfmt = d_fmt;
 			goto copcsr;
 
 		case fcvtw_op:
+			MIPS_FPU_EMU_INC_STATS(cvt_w_s);
 			SPFROMREG(fs, MIPSInst_FS(ir));
 			rv.w = ieee754sp_tint(fs);
 			rfmt = w_fmt;
@@ -1940,6 +1964,15 @@ static int fpu_emu(struct pt_regs *xcp, struct mips_fpu_struct *ctx,
 			if (!cpu_has_mips_2_3_4_5_r)
 				return SIGILL;
 
+			if (MIPSInst_FUNC(ir) == fceil_op)
+				MIPS_FPU_EMU_INC_STATS(ceil_w_s);
+			if (MIPSInst_FUNC(ir) == ffloor_op)
+				MIPS_FPU_EMU_INC_STATS(floor_w_s);
+			if (MIPSInst_FUNC(ir) == fround_op)
+				MIPS_FPU_EMU_INC_STATS(round_w_s);
+			if (MIPSInst_FUNC(ir) == ftrunc_op)
+				MIPS_FPU_EMU_INC_STATS(trunc_w_s);
+
 			oldrm = ieee754_csr.rm;
 			SPFROMREG(fs, MIPSInst_FS(ir));
 			ieee754_csr.rm = MIPSInst_FUNC(ir);
@@ -1952,6 +1985,7 @@ static int fpu_emu(struct pt_regs *xcp, struct mips_fpu_struct *ctx,
 			if (!cpu_has_mips_r6)
 				return SIGILL;
 
+			MIPS_FPU_EMU_INC_STATS(sel_s);
 			SPFROMREG(fd, MIPSInst_FD(ir));
 			if (fd.bits & 0x1)
 				SPFROMREG(rv.s, MIPSInst_FT(ir));
@@ -1963,6 +1997,7 @@ static int fpu_emu(struct pt_regs *xcp, struct mips_fpu_struct *ctx,
 			if (!cpu_has_mips_3_4_5_64_r2_r6)
 				return SIGILL;
 
+			MIPS_FPU_EMU_INC_STATS(cvt_l_s);
 			SPFROMREG(fs, MIPSInst_FS(ir));
 			rv.l = ieee754sp_tlong(fs);
 			rfmt = l_fmt;
@@ -1975,6 +2010,15 @@ static int fpu_emu(struct pt_regs *xcp, struct mips_fpu_struct *ctx,
 			if (!cpu_has_mips_3_4_5_64_r2_r6)
 				return SIGILL;
 
+			if (MIPSInst_FUNC(ir) == fceill_op)
+				MIPS_FPU_EMU_INC_STATS(ceil_l_s);
+			if (MIPSInst_FUNC(ir) == ffloorl_op)
+				MIPS_FPU_EMU_INC_STATS(floor_l_s);
+			if (MIPSInst_FUNC(ir) == froundl_op)
+				MIPS_FPU_EMU_INC_STATS(round_l_s);
+			if (MIPSInst_FUNC(ir) == ftruncl_op)
+				MIPS_FPU_EMU_INC_STATS(trunc_l_s);
+
 			oldrm = ieee754_csr.rm;
 			SPFROMREG(fs, MIPSInst_FS(ir));
 			ieee754_csr.rm = MIPSInst_FUNC(ir);
@@ -2016,15 +2060,19 @@ static int fpu_emu(struct pt_regs *xcp, struct mips_fpu_struct *ctx,
 		switch (MIPSInst_FUNC(ir)) {
 			/* binary ops */
 		case fadd_op:
+			MIPS_FPU_EMU_INC_STATS(add_d);
 			handler.b = ieee754dp_add;
 			goto dcopbop;
 		case fsub_op:
+			MIPS_FPU_EMU_INC_STATS(sub_d);
 			handler.b = ieee754dp_sub;
 			goto dcopbop;
 		case fmul_op:
+			MIPS_FPU_EMU_INC_STATS(mul_d);
 			handler.b = ieee754dp_mul;
 			goto dcopbop;
 		case fdiv_op:
+			MIPS_FPU_EMU_INC_STATS(div_d);
 			handler.b = ieee754dp_div;
 			goto dcopbop;
 
@@ -2033,6 +2081,7 @@ static int fpu_emu(struct pt_regs *xcp, struct mips_fpu_struct *ctx,
 			if (!cpu_has_mips_2_3_4_5_r)
 				return SIGILL;
 
+			MIPS_FPU_EMU_INC_STATS(sqrt_d);
 			handler.u = ieee754dp_sqrt;
 			goto dcopuop;
 		/*
@@ -2044,12 +2093,14 @@ static int fpu_emu(struct pt_regs *xcp, struct mips_fpu_struct *ctx,
 			if (!cpu_has_mips_4_5_64_r2_r6)
 				return SIGILL;
 
+			MIPS_FPU_EMU_INC_STATS(rsqrt_d);
 			handler.u = fpemu_dp_rsqrt;
 			goto dcopuop;
 		case frecip_op:
 			if (!cpu_has_mips_4_5_64_r2_r6)
 				return SIGILL;
 
+			MIPS_FPU_EMU_INC_STATS(recip_d);
 			handler.u = fpemu_dp_recip;
 			goto dcopuop;
 		case fmovc_op:
@@ -2083,6 +2134,7 @@ static int fpu_emu(struct pt_regs *xcp, struct mips_fpu_struct *ctx,
 			if (!cpu_has_mips_r6)
 				return SIGILL;
 
+			MIPS_FPU_EMU_INC_STATS(seleqz_d);
 			DPFROMREG(rv.d, MIPSInst_FT(ir));
 			if (rv.l & 0x1)
 				rv.l = 0;
@@ -2094,6 +2146,7 @@ static int fpu_emu(struct pt_regs *xcp, struct mips_fpu_struct *ctx,
 			if (!cpu_has_mips_r6)
 				return SIGILL;
 
+			MIPS_FPU_EMU_INC_STATS(selnez_d);
 			DPFROMREG(rv.d, MIPSInst_FT(ir));
 			if (rv.l & 0x1)
 				DPFROMREG(rv.d, MIPSInst_FS(ir));
@@ -2107,6 +2160,7 @@ static int fpu_emu(struct pt_regs *xcp, struct mips_fpu_struct *ctx,
 			if (!cpu_has_mips_r6)
 				return SIGILL;
 
+			MIPS_FPU_EMU_INC_STATS(maddf_d);
 			DPFROMREG(ft, MIPSInst_FT(ir));
 			DPFROMREG(fs, MIPSInst_FS(ir));
 			DPFROMREG(fd, MIPSInst_FD(ir));
@@ -2120,6 +2174,7 @@ static int fpu_emu(struct pt_regs *xcp, struct mips_fpu_struct *ctx,
 			if (!cpu_has_mips_r6)
 				return SIGILL;
 
+			MIPS_FPU_EMU_INC_STATS(msubf_d);
 			DPFROMREG(ft, MIPSInst_FT(ir));
 			DPFROMREG(fs, MIPSInst_FS(ir));
 			DPFROMREG(fd, MIPSInst_FD(ir));
@@ -2133,6 +2188,7 @@ static int fpu_emu(struct pt_regs *xcp, struct mips_fpu_struct *ctx,
 			if (!cpu_has_mips_r6)
 				return SIGILL;
 
+			MIPS_FPU_EMU_INC_STATS(rint_d);
 			DPFROMREG(fs, MIPSInst_FS(ir));
 			rv.d = ieee754dp_rint(fs);
 			goto copcsr;
@@ -2144,6 +2200,7 @@ static int fpu_emu(struct pt_regs *xcp, struct mips_fpu_struct *ctx,
 			if (!cpu_has_mips_r6)
 				return SIGILL;
 
+			MIPS_FPU_EMU_INC_STATS(class_d);
 			DPFROMREG(fs, MIPSInst_FS(ir));
 			rv.l = ieee754dp_2008class(fs);
 			rfmt = l_fmt;
@@ -2156,6 +2213,7 @@ static int fpu_emu(struct pt_regs *xcp, struct mips_fpu_struct *ctx,
 			if (!cpu_has_mips_r6)
 				return SIGILL;
 
+			MIPS_FPU_EMU_INC_STATS(min_d);
 			DPFROMREG(ft, MIPSInst_FT(ir));
 			DPFROMREG(fs, MIPSInst_FS(ir));
 			rv.d = ieee754dp_fmin(fs, ft);
@@ -2168,6 +2226,7 @@ static int fpu_emu(struct pt_regs *xcp, struct mips_fpu_struct *ctx,
 			if (!cpu_has_mips_r6)
 				return SIGILL;
 
+			MIPS_FPU_EMU_INC_STATS(mina_d);
 			DPFROMREG(ft, MIPSInst_FT(ir));
 			DPFROMREG(fs, MIPSInst_FS(ir));
 			rv.d = ieee754dp_fmina(fs, ft);
@@ -2180,6 +2239,7 @@ static int fpu_emu(struct pt_regs *xcp, struct mips_fpu_struct *ctx,
 			if (!cpu_has_mips_r6)
 				return SIGILL;
 
+			MIPS_FPU_EMU_INC_STATS(max_d);
 			DPFROMREG(ft, MIPSInst_FT(ir));
 			DPFROMREG(fs, MIPSInst_FS(ir));
 			rv.d = ieee754dp_fmax(fs, ft);
@@ -2192,6 +2252,7 @@ static int fpu_emu(struct pt_regs *xcp, struct mips_fpu_struct *ctx,
 			if (!cpu_has_mips_r6)
 				return SIGILL;
 
+			MIPS_FPU_EMU_INC_STATS(maxa_d);
 			DPFROMREG(ft, MIPSInst_FT(ir));
 			DPFROMREG(fs, MIPSInst_FS(ir));
 			rv.d = ieee754dp_fmaxa(fs, ft);
@@ -2199,15 +2260,18 @@ static int fpu_emu(struct pt_regs *xcp, struct mips_fpu_struct *ctx,
 		}
 
 		case fabs_op:
+			MIPS_FPU_EMU_INC_STATS(abs_d);
 			handler.u = ieee754dp_abs;
 			goto dcopuop;
 
 		case fneg_op:
+			MIPS_FPU_EMU_INC_STATS(neg_d);
 			handler.u = ieee754dp_neg;
 			goto dcopuop;
 
 		case fmov_op:
 			/* an easy one */
+			MIPS_FPU_EMU_INC_STATS(mov_d);
 			DPFROMREG(rv.d, MIPSInst_FS(ir));
 			goto copcsr;
 
@@ -2227,6 +2291,7 @@ static int fpu_emu(struct pt_regs *xcp, struct mips_fpu_struct *ctx,
 		 * unary conv ops
 		 */
 		case fcvts_op:
+			MIPS_FPU_EMU_INC_STATS(cvt_s_d);
 			DPFROMREG(fs, MIPSInst_FS(ir));
 			rv.s = ieee754sp_fdp(fs);
 			rfmt = s_fmt;
@@ -2236,6 +2301,7 @@ static int fpu_emu(struct pt_regs *xcp, struct mips_fpu_struct *ctx,
 			return SIGILL;	/* not defined */
 
 		case fcvtw_op:
+			MIPS_FPU_EMU_INC_STATS(cvt_w_d);
 			DPFROMREG(fs, MIPSInst_FS(ir));
 			rv.w = ieee754dp_tint(fs);	/* wrong */
 			rfmt = w_fmt;
@@ -2248,6 +2314,15 @@ static int fpu_emu(struct pt_regs *xcp, struct mips_fpu_struct *ctx,
 			if (!cpu_has_mips_2_3_4_5_r)
 				return SIGILL;
 
+			if (MIPSInst_FUNC(ir) == fceil_op)
+				MIPS_FPU_EMU_INC_STATS(ceil_w_d);
+			if (MIPSInst_FUNC(ir) == ffloor_op)
+				MIPS_FPU_EMU_INC_STATS(floor_w_d);
+			if (MIPSInst_FUNC(ir) == fround_op)
+				MIPS_FPU_EMU_INC_STATS(round_w_d);
+			if (MIPSInst_FUNC(ir) == ftrunc_op)
+				MIPS_FPU_EMU_INC_STATS(trunc_w_d);
+
 			oldrm = ieee754_csr.rm;
 			DPFROMREG(fs, MIPSInst_FS(ir));
 			ieee754_csr.rm = MIPSInst_FUNC(ir);
@@ -2260,6 +2335,7 @@ static int fpu_emu(struct pt_regs *xcp, struct mips_fpu_struct *ctx,
 			if (!cpu_has_mips_r6)
 				return SIGILL;
 
+			MIPS_FPU_EMU_INC_STATS(sel_d);
 			DPFROMREG(fd, MIPSInst_FD(ir));
 			if (fd.bits & 0x1)
 				DPFROMREG(rv.d, MIPSInst_FT(ir));
@@ -2271,6 +2347,7 @@ static int fpu_emu(struct pt_regs *xcp, struct mips_fpu_struct *ctx,
 			if (!cpu_has_mips_3_4_5_64_r2_r6)
 				return SIGILL;
 
+			MIPS_FPU_EMU_INC_STATS(cvt_l_d);
 			DPFROMREG(fs, MIPSInst_FS(ir));
 			rv.l = ieee754dp_tlong(fs);
 			rfmt = l_fmt;
@@ -2283,6 +2360,15 @@ static int fpu_emu(struct pt_regs *xcp, struct mips_fpu_struct *ctx,
 			if (!cpu_has_mips_3_4_5_64_r2_r6)
 				return SIGILL;
 
+			if (MIPSInst_FUNC(ir) == fceill_op)
+				MIPS_FPU_EMU_INC_STATS(ceil_l_d);
+			if (MIPSInst_FUNC(ir) == ffloorl_op)
+				MIPS_FPU_EMU_INC_STATS(floor_l_d);
+			if (MIPSInst_FUNC(ir) == froundl_op)
+				MIPS_FPU_EMU_INC_STATS(round_l_d);
+			if (MIPSInst_FUNC(ir) == ftruncl_op)
+				MIPS_FPU_EMU_INC_STATS(trunc_l_d);
+
 			oldrm = ieee754_csr.rm;
 			DPFROMREG(fs, MIPSInst_FS(ir));
 			ieee754_csr.rm = MIPSInst_FUNC(ir);
@@ -2324,12 +2410,14 @@ static int fpu_emu(struct pt_regs *xcp, struct mips_fpu_struct *ctx,
 		switch (MIPSInst_FUNC(ir)) {
 		case fcvts_op:
 			/* convert word to single precision real */
+			MIPS_FPU_EMU_INC_STATS(cvt_s_w);
 			SPFROMREG(fs, MIPSInst_FS(ir));
 			rv.s = ieee754sp_fint(fs.bits);
 			rfmt = s_fmt;
 			goto copcsr;
 		case fcvtd_op:
 			/* convert word to double precision real */
+			MIPS_FPU_EMU_INC_STATS(cvt_d_w);
 			SPFROMREG(fs, MIPSInst_FS(ir));
 			rv.d = ieee754dp_fint(fs.bits);
 			rfmt = d_fmt;
@@ -2349,6 +2437,90 @@ static int fpu_emu(struct pt_regs *xcp, struct mips_fpu_struct *ctx,
 			    (MIPSInst_FUNC(ir) & 0x20))
 				return SIGILL;
 
+			if (!sig) {
+				if (!(MIPSInst_FUNC(ir) & PREDICATE_BIT)) {
+					switch (cmpop) {
+					case 0:
+					MIPS_FPU_EMU_INC_STATS(cmp_af_s);
+					break;
+					case 1:
+					MIPS_FPU_EMU_INC_STATS(cmp_un_s);
+					break;
+					case 2:
+					MIPS_FPU_EMU_INC_STATS(cmp_eq_s);
+					break;
+					case 3:
+					MIPS_FPU_EMU_INC_STATS(cmp_ueq_s);
+					break;
+					case 4:
+					MIPS_FPU_EMU_INC_STATS(cmp_lt_s);
+					break;
+					case 5:
+					MIPS_FPU_EMU_INC_STATS(cmp_ult_s);
+					break;
+					case 6:
+					MIPS_FPU_EMU_INC_STATS(cmp_le_s);
+					break;
+					case 7:
+					MIPS_FPU_EMU_INC_STATS(cmp_ule_s);
+					break;
+					}
+				} else {
+					switch (cmpop) {
+					case 1:
+					MIPS_FPU_EMU_INC_STATS(cmp_or_s);
+					break;
+					case 2:
+					MIPS_FPU_EMU_INC_STATS(cmp_une_s);
+					break;
+					case 3:
+					MIPS_FPU_EMU_INC_STATS(cmp_ne_s);
+					break;
+					}
+				}
+			} else {
+				if (!(MIPSInst_FUNC(ir) & PREDICATE_BIT)) {
+					switch (cmpop) {
+					case 0:
+					MIPS_FPU_EMU_INC_STATS(cmp_saf_s);
+					break;
+					case 1:
+					MIPS_FPU_EMU_INC_STATS(cmp_sun_s);
+					break;
+					case 2:
+					MIPS_FPU_EMU_INC_STATS(cmp_seq_s);
+					break;
+					case 3:
+					MIPS_FPU_EMU_INC_STATS(cmp_sueq_s);
+					break;
+					case 4:
+					MIPS_FPU_EMU_INC_STATS(cmp_slt_s);
+					break;
+					case 5:
+					MIPS_FPU_EMU_INC_STATS(cmp_sult_s);
+					break;
+					case 6:
+					MIPS_FPU_EMU_INC_STATS(cmp_sle_s);
+					break;
+					case 7:
+					MIPS_FPU_EMU_INC_STATS(cmp_sule_s);
+					break;
+					}
+				} else {
+					switch (cmpop) {
+					case 1:
+					MIPS_FPU_EMU_INC_STATS(cmp_sor_s);
+					break;
+					case 2:
+					MIPS_FPU_EMU_INC_STATS(cmp_sune_s);
+					break;
+					case 3:
+					MIPS_FPU_EMU_INC_STATS(cmp_sne_s);
+					break;
+					}
+				}
+			}
+
 			/* fmt is w_fmt for single precision so fix it */
 			rfmt = s_fmt;
 			/* default to false */
@@ -2406,11 +2578,13 @@ static int fpu_emu(struct pt_regs *xcp, struct mips_fpu_struct *ctx,
 		switch (MIPSInst_FUNC(ir)) {
 		case fcvts_op:
 			/* convert long to single precision real */
+			MIPS_FPU_EMU_INC_STATS(cvt_s_l);
 			rv.s = ieee754sp_flong(bits);
 			rfmt = s_fmt;
 			goto copcsr;
 		case fcvtd_op:
 			/* convert long to double precision real */
+			MIPS_FPU_EMU_INC_STATS(cvt_d_l);
 			rv.d = ieee754dp_flong(bits);
 			rfmt = d_fmt;
 			goto copcsr;
@@ -2424,6 +2598,90 @@ static int fpu_emu(struct pt_regs *xcp, struct mips_fpu_struct *ctx,
 			    (MIPSInst_FUNC(ir) & 0x20))
 				return SIGILL;
 
+			if (!sig) {
+				if (!(MIPSInst_FUNC(ir) & PREDICATE_BIT)) {
+					switch (cmpop) {
+					case 0:
+					MIPS_FPU_EMU_INC_STATS(cmp_af_d);
+					break;
+					case 1:
+					MIPS_FPU_EMU_INC_STATS(cmp_un_d);
+					break;
+					case 2:
+					MIPS_FPU_EMU_INC_STATS(cmp_eq_d);
+					break;
+					case 3:
+					MIPS_FPU_EMU_INC_STATS(cmp_ueq_d);
+					break;
+					case 4:
+					MIPS_FPU_EMU_INC_STATS(cmp_lt_d);
+					break;
+					case 5:
+					MIPS_FPU_EMU_INC_STATS(cmp_ult_d);
+					break;
+					case 6:
+					MIPS_FPU_EMU_INC_STATS(cmp_le_d);
+					break;
+					case 7:
+					MIPS_FPU_EMU_INC_STATS(cmp_ule_d);
+					break;
+					}
+				} else {
+					switch (cmpop) {
+					case 1:
+					MIPS_FPU_EMU_INC_STATS(cmp_or_d);
+					break;
+					case 2:
+					MIPS_FPU_EMU_INC_STATS(cmp_une_d);
+					break;
+					case 3:
+					MIPS_FPU_EMU_INC_STATS(cmp_ne_d);
+					break;
+					}
+				}
+			} else {
+				if (!(MIPSInst_FUNC(ir) & PREDICATE_BIT)) {
+					switch (cmpop) {
+					case 0:
+					MIPS_FPU_EMU_INC_STATS(cmp_saf_d);
+					break;
+					case 1:
+					MIPS_FPU_EMU_INC_STATS(cmp_sun_d);
+					break;
+					case 2:
+					MIPS_FPU_EMU_INC_STATS(cmp_seq_d);
+					break;
+					case 3:
+					MIPS_FPU_EMU_INC_STATS(cmp_sueq_d);
+					break;
+					case 4:
+					MIPS_FPU_EMU_INC_STATS(cmp_slt_d);
+					break;
+					case 5:
+					MIPS_FPU_EMU_INC_STATS(cmp_sult_d);
+					break;
+					case 6:
+					MIPS_FPU_EMU_INC_STATS(cmp_sle_d);
+					break;
+					case 7:
+					MIPS_FPU_EMU_INC_STATS(cmp_sule_d);
+					break;
+					}
+				} else {
+					switch (cmpop) {
+					case 1:
+					MIPS_FPU_EMU_INC_STATS(cmp_sor_d);
+					break;
+					case 2:
+					MIPS_FPU_EMU_INC_STATS(cmp_sune_d);
+					break;
+					case 3:
+					MIPS_FPU_EMU_INC_STATS(cmp_sne_d);
+					break;
+					}
+				}
+			}
+
 			/* fmt is l_fmt for double precision so fix it */
 			rfmt = d_fmt;
 			/* default to false */
diff --git a/arch/mips/math-emu/me-debugfs.c b/arch/mips/math-emu/me-debugfs.c
index f080493..8c0ec15 100644
--- a/arch/mips/math-emu/me-debugfs.c
+++ b/arch/mips/math-emu/me-debugfs.c
@@ -28,6 +28,26 @@ static int fpuemu_stat_get(void *data, u64 *val)
 }
 DEFINE_SIMPLE_ATTRIBUTE(fops_fpuemu_stat, fpuemu_stat_get, NULL, "%llu\n");
 
+/*
+ * Used to obtain names for a debugfs instruction counter, given field name
+ * in fpuemustats structure. For example, for input "cmp_sueq_d", the output
+ * would be "cmp.sueq.d". This is needed since dots are not allowed to be
+ * used in structure field names, and are, on the other hand, desired to be
+ * used in debugfs item names to be clearly associated to corresponding
+ * MIPS FPU instructions.
+ */
+static void adjust_instruction_counter_name(char *out_name, char *in_name)
+{
+	int i = 0;
+
+	strcpy(out_name, in_name);
+	while (in_name[i] != '\0') {
+		if (out_name[i] == '_')
+			out_name[i] = '.';
+		i++;
+	}
+}
+
 static int fpuemustats_clear_show(struct seq_file *s, void *unused)
 {
 	__this_cpu_write((fpuemustats).emulated, 0);
@@ -44,6 +64,121 @@ static int fpuemustats_clear_show(struct seq_file *s, void *unused)
 	__this_cpu_write((fpuemustats).ieee754_invalidop, 0);
 	__this_cpu_write((fpuemustats).ds_emul, 0);
 
+	__this_cpu_write((fpuemustats).abs_s, 0);
+	__this_cpu_write((fpuemustats).abs_d, 0);
+	__this_cpu_write((fpuemustats).add_s, 0);
+	__this_cpu_write((fpuemustats).add_d, 0);
+	__this_cpu_write((fpuemustats).bc1eqz, 0);
+	__this_cpu_write((fpuemustats).bc1nez, 0);
+	__this_cpu_write((fpuemustats).ceil_w_s, 0);
+	__this_cpu_write((fpuemustats).ceil_w_d, 0);
+	__this_cpu_write((fpuemustats).ceil_l_s, 0);
+	__this_cpu_write((fpuemustats).ceil_l_d, 0);
+	__this_cpu_write((fpuemustats).class_s, 0);
+	__this_cpu_write((fpuemustats).class_d, 0);
+	__this_cpu_write((fpuemustats).cmp_af_s, 0);
+	__this_cpu_write((fpuemustats).cmp_af_d, 0);
+	__this_cpu_write((fpuemustats).cmp_eq_s, 0);
+	__this_cpu_write((fpuemustats).cmp_eq_d, 0);
+	__this_cpu_write((fpuemustats).cmp_le_s, 0);
+	__this_cpu_write((fpuemustats).cmp_le_d, 0);
+	__this_cpu_write((fpuemustats).cmp_lt_s, 0);
+	__this_cpu_write((fpuemustats).cmp_lt_d, 0);
+	__this_cpu_write((fpuemustats).cmp_ne_s, 0);
+	__this_cpu_write((fpuemustats).cmp_ne_d, 0);
+	__this_cpu_write((fpuemustats).cmp_or_s, 0);
+	__this_cpu_write((fpuemustats).cmp_or_d, 0);
+	__this_cpu_write((fpuemustats).cmp_ueq_s, 0);
+	__this_cpu_write((fpuemustats).cmp_ueq_d, 0);
+	__this_cpu_write((fpuemustats).cmp_ule_s, 0);
+	__this_cpu_write((fpuemustats).cmp_ule_d, 0);
+	__this_cpu_write((fpuemustats).cmp_ult_s, 0);
+	__this_cpu_write((fpuemustats).cmp_ult_d, 0);
+	__this_cpu_write((fpuemustats).cmp_un_s, 0);
+	__this_cpu_write((fpuemustats).cmp_un_d, 0);
+	__this_cpu_write((fpuemustats).cmp_une_s, 0);
+	__this_cpu_write((fpuemustats).cmp_une_d, 0);
+	__this_cpu_write((fpuemustats).cmp_saf_s, 0);
+	__this_cpu_write((fpuemustats).cmp_saf_d, 0);
+	__this_cpu_write((fpuemustats).cmp_seq_s, 0);
+	__this_cpu_write((fpuemustats).cmp_seq_d, 0);
+	__this_cpu_write((fpuemustats).cmp_sle_s, 0);
+	__this_cpu_write((fpuemustats).cmp_sle_d, 0);
+	__this_cpu_write((fpuemustats).cmp_slt_s, 0);
+	__this_cpu_write((fpuemustats).cmp_slt_d, 0);
+	__this_cpu_write((fpuemustats).cmp_sne_s, 0);
+	__this_cpu_write((fpuemustats).cmp_sne_d, 0);
+	__this_cpu_write((fpuemustats).cmp_sor_s, 0);
+	__this_cpu_write((fpuemustats).cmp_sor_d, 0);
+	__this_cpu_write((fpuemustats).cmp_sueq_s, 0);
+	__this_cpu_write((fpuemustats).cmp_sueq_d, 0);
+	__this_cpu_write((fpuemustats).cmp_sule_s, 0);
+	__this_cpu_write((fpuemustats).cmp_sule_d, 0);
+	__this_cpu_write((fpuemustats).cmp_sult_s, 0);
+	__this_cpu_write((fpuemustats).cmp_sult_d, 0);
+	__this_cpu_write((fpuemustats).cmp_sun_s, 0);
+	__this_cpu_write((fpuemustats).cmp_sun_d, 0);
+	__this_cpu_write((fpuemustats).cmp_sune_s, 0);
+	__this_cpu_write((fpuemustats).cmp_sune_d, 0);
+	__this_cpu_write((fpuemustats).cvt_d_l, 0);
+	__this_cpu_write((fpuemustats).cvt_d_s, 0);
+	__this_cpu_write((fpuemustats).cvt_d_w, 0);
+	__this_cpu_write((fpuemustats).cvt_l_s, 0);
+	__this_cpu_write((fpuemustats).cvt_l_d, 0);
+	__this_cpu_write((fpuemustats).cvt_s_d, 0);
+	__this_cpu_write((fpuemustats).cvt_s_l, 0);
+	__this_cpu_write((fpuemustats).cvt_s_w, 0);
+	__this_cpu_write((fpuemustats).cvt_w_s, 0);
+	__this_cpu_write((fpuemustats).cvt_w_d, 0);
+	__this_cpu_write((fpuemustats).div_s, 0);
+	__this_cpu_write((fpuemustats).div_d, 0);
+	__this_cpu_write((fpuemustats).floor_w_s, 0);
+	__this_cpu_write((fpuemustats).floor_w_d, 0);
+	__this_cpu_write((fpuemustats).floor_l_s, 0);
+	__this_cpu_write((fpuemustats).floor_l_d, 0);
+	__this_cpu_write((fpuemustats).maddf_s, 0);
+	__this_cpu_write((fpuemustats).maddf_d, 0);
+	__this_cpu_write((fpuemustats).max_s, 0);
+	__this_cpu_write((fpuemustats).max_d, 0);
+	__this_cpu_write((fpuemustats).maxa_s, 0);
+	__this_cpu_write((fpuemustats).maxa_d, 0);
+	__this_cpu_write((fpuemustats).min_s, 0);
+	__this_cpu_write((fpuemustats).min_d, 0);
+	__this_cpu_write((fpuemustats).mina_s, 0);
+	__this_cpu_write((fpuemustats).mina_d, 0);
+	__this_cpu_write((fpuemustats).mov_s, 0);
+	__this_cpu_write((fpuemustats).mov_d, 0);
+	__this_cpu_write((fpuemustats).msubf_s, 0);
+	__this_cpu_write((fpuemustats).msubf_d, 0);
+	__this_cpu_write((fpuemustats).mul_s, 0);
+	__this_cpu_write((fpuemustats).mul_d, 0);
+	__this_cpu_write((fpuemustats).neg_s, 0);
+	__this_cpu_write((fpuemustats).neg_d, 0);
+	__this_cpu_write((fpuemustats).recip_s, 0);
+	__this_cpu_write((fpuemustats).recip_d, 0);
+	__this_cpu_write((fpuemustats).rint_s, 0);
+	__this_cpu_write((fpuemustats).rint_d, 0);
+	__this_cpu_write((fpuemustats).round_w_s, 0);
+	__this_cpu_write((fpuemustats).round_w_d, 0);
+	__this_cpu_write((fpuemustats).round_l_s, 0);
+	__this_cpu_write((fpuemustats).round_l_d, 0);
+	__this_cpu_write((fpuemustats).rsqrt_s, 0);
+	__this_cpu_write((fpuemustats).rsqrt_d, 0);
+	__this_cpu_write((fpuemustats).sel_s, 0);
+	__this_cpu_write((fpuemustats).sel_d, 0);
+	__this_cpu_write((fpuemustats).seleqz_s, 0);
+	__this_cpu_write((fpuemustats).seleqz_d, 0);
+	__this_cpu_write((fpuemustats).selnez_s, 0);
+	__this_cpu_write((fpuemustats).selnez_d, 0);
+	__this_cpu_write((fpuemustats).sqrt_s, 0);
+	__this_cpu_write((fpuemustats).sqrt_d, 0);
+	__this_cpu_write((fpuemustats).sub_s, 0);
+	__this_cpu_write((fpuemustats).sub_d, 0);
+	__this_cpu_write((fpuemustats).trunc_w_s, 0);
+	__this_cpu_write((fpuemustats).trunc_w_d, 0);
+	__this_cpu_write((fpuemustats).trunc_l_s, 0);
+	__this_cpu_write((fpuemustats).trunc_l_d, 0);
+
 	return 0;
 }
 
@@ -61,13 +196,18 @@ static const struct file_operations fpuemustats_clear_fops = {
 
 static int __init debugfs_fpuemu(void)
 {
-	struct dentry *d, *dir, *reset_file;
+	struct dentry *fpuemu_debugfs_base_dir;
+	struct dentry *fpuemu_debugfs_inst_dir;
+	struct dentry *d, *reset_file;
 
 	if (!mips_debugfs_dir)
 		return -ENODEV;
-	dir = debugfs_create_dir("fpuemustats", mips_debugfs_dir);
-	if (!dir)
+
+	fpuemu_debugfs_base_dir = debugfs_create_dir("fpuemustats",
+						     mips_debugfs_dir);
+	if (!fpuemu_debugfs_base_dir)
 		return -ENOMEM;
+
 	reset_file = debugfs_create_file("fpuemustats_clear", 0444,
 					 mips_debugfs_dir, NULL,
 					 &fpuemustats_clear_fops);
@@ -79,7 +219,7 @@ static int __init debugfs_fpuemu(void)
 
 #define FPU_STAT_CREATE(m)						\
 do {									\
-	d = debugfs_create_file(#m , S_IRUGO, dir,			\
+	d = debugfs_create_file(#m, 0444, fpuemu_debugfs_base_dir,	\
 				(void *)FPU_EMU_STAT_OFFSET(m),		\
 				&fops_fpuemu_stat);			\
 	if (!d)								\
@@ -100,6 +240,139 @@ do {									\
 	FPU_STAT_CREATE(ieee754_invalidop);
 	FPU_STAT_CREATE(ds_emul);
 
+	fpuemu_debugfs_inst_dir = debugfs_create_dir("instructions",
+						     fpuemu_debugfs_base_dir);
+	if (!fpuemu_debugfs_inst_dir)
+		return -ENOMEM;
+
+#define FPU_STAT_CREATE_EX(m)						\
+do {									\
+	char name[32];							\
+									\
+	adjust_instruction_counter_name(name, #m);			\
+									\
+	d = debugfs_create_file(name, 0444, fpuemu_debugfs_inst_dir,	\
+				(void *)FPU_EMU_STAT_OFFSET(m),		\
+				&fops_fpuemu_stat);			\
+	if (!d)								\
+		return -ENOMEM;						\
+} while (0)
+
+	FPU_STAT_CREATE_EX(abs_s);
+	FPU_STAT_CREATE_EX(abs_d);
+	FPU_STAT_CREATE_EX(add_s);
+	FPU_STAT_CREATE_EX(add_d);
+	FPU_STAT_CREATE_EX(bc1eqz);
+	FPU_STAT_CREATE_EX(bc1nez);
+	FPU_STAT_CREATE_EX(ceil_w_s);
+	FPU_STAT_CREATE_EX(ceil_w_d);
+	FPU_STAT_CREATE_EX(ceil_l_s);
+	FPU_STAT_CREATE_EX(ceil_l_d);
+	FPU_STAT_CREATE_EX(class_s);
+	FPU_STAT_CREATE_EX(class_d);
+	FPU_STAT_CREATE_EX(cmp_af_s);
+	FPU_STAT_CREATE_EX(cmp_af_d);
+	FPU_STAT_CREATE_EX(cmp_eq_s);
+	FPU_STAT_CREATE_EX(cmp_eq_d);
+	FPU_STAT_CREATE_EX(cmp_le_s);
+	FPU_STAT_CREATE_EX(cmp_le_d);
+	FPU_STAT_CREATE_EX(cmp_lt_s);
+	FPU_STAT_CREATE_EX(cmp_lt_d);
+	FPU_STAT_CREATE_EX(cmp_ne_s);
+	FPU_STAT_CREATE_EX(cmp_ne_d);
+	FPU_STAT_CREATE_EX(cmp_or_s);
+	FPU_STAT_CREATE_EX(cmp_or_d);
+	FPU_STAT_CREATE_EX(cmp_ueq_s);
+	FPU_STAT_CREATE_EX(cmp_ueq_d);
+	FPU_STAT_CREATE_EX(cmp_ule_s);
+	FPU_STAT_CREATE_EX(cmp_ule_d);
+	FPU_STAT_CREATE_EX(cmp_ult_s);
+	FPU_STAT_CREATE_EX(cmp_ult_d);
+	FPU_STAT_CREATE_EX(cmp_un_s);
+	FPU_STAT_CREATE_EX(cmp_un_d);
+	FPU_STAT_CREATE_EX(cmp_une_s);
+	FPU_STAT_CREATE_EX(cmp_une_d);
+	FPU_STAT_CREATE_EX(cmp_saf_s);
+	FPU_STAT_CREATE_EX(cmp_saf_d);
+	FPU_STAT_CREATE_EX(cmp_seq_s);
+	FPU_STAT_CREATE_EX(cmp_seq_d);
+	FPU_STAT_CREATE_EX(cmp_sle_s);
+	FPU_STAT_CREATE_EX(cmp_sle_d);
+	FPU_STAT_CREATE_EX(cmp_slt_s);
+	FPU_STAT_CREATE_EX(cmp_slt_d);
+	FPU_STAT_CREATE_EX(cmp_sne_s);
+	FPU_STAT_CREATE_EX(cmp_sne_d);
+	FPU_STAT_CREATE_EX(cmp_sor_s);
+	FPU_STAT_CREATE_EX(cmp_sor_d);
+	FPU_STAT_CREATE_EX(cmp_sueq_s);
+	FPU_STAT_CREATE_EX(cmp_sueq_d);
+	FPU_STAT_CREATE_EX(cmp_sule_s);
+	FPU_STAT_CREATE_EX(cmp_sule_d);
+	FPU_STAT_CREATE_EX(cmp_sult_s);
+	FPU_STAT_CREATE_EX(cmp_sult_d);
+	FPU_STAT_CREATE_EX(cmp_sun_s);
+	FPU_STAT_CREATE_EX(cmp_sun_d);
+	FPU_STAT_CREATE_EX(cmp_sune_s);
+	FPU_STAT_CREATE_EX(cmp_sune_d);
+	FPU_STAT_CREATE_EX(cvt_d_l);
+	FPU_STAT_CREATE_EX(cvt_d_s);
+	FPU_STAT_CREATE_EX(cvt_d_w);
+	FPU_STAT_CREATE_EX(cvt_l_s);
+	FPU_STAT_CREATE_EX(cvt_l_d);
+	FPU_STAT_CREATE_EX(cvt_s_d);
+	FPU_STAT_CREATE_EX(cvt_s_l);
+	FPU_STAT_CREATE_EX(cvt_s_w);
+	FPU_STAT_CREATE_EX(cvt_w_s);
+	FPU_STAT_CREATE_EX(cvt_w_d);
+	FPU_STAT_CREATE_EX(div_s);
+	FPU_STAT_CREATE_EX(div_d);
+	FPU_STAT_CREATE_EX(floor_w_s);
+	FPU_STAT_CREATE_EX(floor_w_d);
+	FPU_STAT_CREATE_EX(floor_l_s);
+	FPU_STAT_CREATE_EX(floor_l_d);
+	FPU_STAT_CREATE_EX(maddf_s);
+	FPU_STAT_CREATE_EX(maddf_d);
+	FPU_STAT_CREATE_EX(max_s);
+	FPU_STAT_CREATE_EX(max_d);
+	FPU_STAT_CREATE_EX(maxa_s);
+	FPU_STAT_CREATE_EX(maxa_d);
+	FPU_STAT_CREATE_EX(min_s);
+	FPU_STAT_CREATE_EX(min_d);
+	FPU_STAT_CREATE_EX(mina_s);
+	FPU_STAT_CREATE_EX(mina_d);
+	FPU_STAT_CREATE_EX(mov_s);
+	FPU_STAT_CREATE_EX(mov_d);
+	FPU_STAT_CREATE_EX(msubf_s);
+	FPU_STAT_CREATE_EX(msubf_d);
+	FPU_STAT_CREATE_EX(mul_s);
+	FPU_STAT_CREATE_EX(mul_d);
+	FPU_STAT_CREATE_EX(neg_s);
+	FPU_STAT_CREATE_EX(neg_d);
+	FPU_STAT_CREATE_EX(recip_s);
+	FPU_STAT_CREATE_EX(recip_d);
+	FPU_STAT_CREATE_EX(rint_s);
+	FPU_STAT_CREATE_EX(rint_d);
+	FPU_STAT_CREATE_EX(round_w_s);
+	FPU_STAT_CREATE_EX(round_w_d);
+	FPU_STAT_CREATE_EX(round_l_s);
+	FPU_STAT_CREATE_EX(round_l_d);
+	FPU_STAT_CREATE_EX(rsqrt_s);
+	FPU_STAT_CREATE_EX(rsqrt_d);
+	FPU_STAT_CREATE_EX(sel_s);
+	FPU_STAT_CREATE_EX(sel_d);
+	FPU_STAT_CREATE_EX(seleqz_s);
+	FPU_STAT_CREATE_EX(seleqz_d);
+	FPU_STAT_CREATE_EX(selnez_s);
+	FPU_STAT_CREATE_EX(selnez_d);
+	FPU_STAT_CREATE_EX(sqrt_s);
+	FPU_STAT_CREATE_EX(sqrt_d);
+	FPU_STAT_CREATE_EX(sub_s);
+	FPU_STAT_CREATE_EX(sub_d);
+	FPU_STAT_CREATE_EX(trunc_w_s);
+	FPU_STAT_CREATE_EX(trunc_w_d);
+	FPU_STAT_CREATE_EX(trunc_l_s);
+	FPU_STAT_CREATE_EX(trunc_l_d);
+
 	return 0;
 }
 arch_initcall(debugfs_fpuemu);
-- 
2.7.4
