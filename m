Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 18 Aug 2017 15:19:52 +0200 (CEST)
Received: from mx2.rt-rk.com ([89.216.37.149]:43115 "EHLO mail.rt-rk.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23993376AbdHRNT0VHoS9 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 18 Aug 2017 15:19:26 +0200
Received: from localhost (localhost [127.0.0.1])
        by mail.rt-rk.com (Postfix) with ESMTP id E6E231A1DE6;
        Fri, 18 Aug 2017 15:19:20 +0200 (CEST)
X-Virus-Scanned: amavisd-new at rt-rk.com
Received: from rtrkw197-lin.domain.local (unknown [10.10.13.95])
        by mail.rt-rk.com (Postfix) with ESMTPSA id B97311A1DCA;
        Fri, 18 Aug 2017 15:19:20 +0200 (CEST)
From:   Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
To:     linux-mips@linux-mips.org
Cc:     Aleksandar Markovic <aleksandar.markovic@imgtec.com>,
        Miodrag Dinic <miodrag.dinic@imgtec.com>,
        Goran Ferenc <goran.ferenc@imgtec.com>,
        Bo Hu <bohu@google.com>,
        "David S. Miller" <davem@davemloft.net>,
        Douglas Leung <douglas.leung@imgtec.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        James Hogan <james.hogan@imgtec.com>,
        Jin Qian <jinqian@google.com>, linux-kernel@vger.kernel.org,
        "Maciej W. Rozycki" <macro@imgtec.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Paul Burton <paul.burton@imgtec.com>,
        Petar Jovanovic <petar.jovanovic@imgtec.com>,
        Raghu Gandham <raghu.gandham@imgtec.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH 2/6] MIPS: math-emu: RINT.<D|S>: Fix several problems by reimplementation
Date:   Fri, 18 Aug 2017 15:17:31 +0200
Message-Id: <1503062286-27030-3-git-send-email-aleksandar.markovic@rt-rk.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1503062286-27030-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1503062286-27030-1-git-send-email-aleksandar.markovic@rt-rk.com>
Return-Path: <aleksandar.markovic@rt-rk.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 59658
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

Reimplement RINT.<D|S> kernel emulation so that all RINT.<D|S>
specifications are met.

For the sake of simplicity, let's analyze RINT.S only. Prior to
this patch, RINT.S emulation was essentially implemented as (in
pseudocode) <output> = ieee754sp_flong(ieee754sp_tlong(<input>)),
where ieee754sp_tlong() and ieee754sp_flong() are functions
providing conversion from double to integer, and from integer
to double, rescpectively. On surface, this implementation looks
correct, but actually fails in many cases. Following problems
were detected:

1. NaN and infinity cases will not be handled properly. The
   function ieee754sp_flong() never returns NaN nor infinity.
2. For RINT.S, for all inputs larger than LONG_MAX, and smaller
   than FLT_MAX, the result will be wrong, and the overflow
   exception will be erroneously set. A similar problem for
   negative inputs exists as well.
3. For some rounding modes, for some negative inputs close to zero,
   the return value will be zero, and should be -zero. This is
   because ieee754sp_flong() never returns -zero.

This patch removes the problems above by implementing dedicated
functions for RINT.<D|S> emulation.

The core of the new function functionality is adapted version of
the core of the function ieee754sp_tlong(). However, there are many
details that are implemented to match RINT.<D|S> specification. It
should be said that the functionality of ieee754sp_tlong() actually
closely corresponds to CVT.L.S instruction, and it is used while
emulating CVT.L.S. However, RINT.S and CVT.L.S instructions differ
in many aspects. This patch fulfills missing support for RINT.<D|S>.

Signed-off-by: Miodrag Dinic <miodrag.dinic@imgtec.com>
Signed-off-by: Goran Ferenc <goran.ferenc@imgtec.com>
Signed-off-by: Aleksandar Markovic <aleksandar.markovic@imgtec.com>
---
 MAINTAINERS                  |  7 ++++
 arch/mips/math-emu/Makefile  |  6 ++-
 arch/mips/math-emu/cp1emu.c  |  6 +--
 arch/mips/math-emu/dp_rint.c | 89 +++++++++++++++++++++++++++++++++++++++++++
 arch/mips/math-emu/ieee754.h |  2 +
 arch/mips/math-emu/sp_rint.c | 90 ++++++++++++++++++++++++++++++++++++++++++++
 6 files changed, 194 insertions(+), 6 deletions(-)
 create mode 100644 arch/mips/math-emu/dp_rint.c
 create mode 100644 arch/mips/math-emu/sp_rint.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 6f7721d..88bea9e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8803,6 +8803,13 @@ F:	arch/mips/include/asm/mach-loongson32/
 F:	drivers/*/*loongson1*
 F:	drivers/*/*/*loongson1*
 
+MIPS RINT INSTRUCTION EMULATION
+M:	Aleksandar Markovic <aleksandar.markovic@imgtec.com>
+L:	linux-mips@linux-mips.org
+S:	Supported
+F:	arch/mips/math-emu/sp_rint.c
+F:	arch/mips/math-emu/dp_rint.c
+
 MIROSOUND PCM20 FM RADIO RECEIVER DRIVER
 M:	Hans Verkuil <hverkuil@xs4all.nl>
 L:	linux-media@vger.kernel.org
diff --git a/arch/mips/math-emu/Makefile b/arch/mips/math-emu/Makefile
index e9bbc2a..e9f10b8 100644
--- a/arch/mips/math-emu/Makefile
+++ b/arch/mips/math-emu/Makefile
@@ -4,9 +4,11 @@
 
 obj-y	+= cp1emu.o ieee754dp.o ieee754sp.o ieee754.o \
 	   dp_div.o dp_mul.o dp_sub.o dp_add.o dp_fsp.o dp_cmp.o dp_simple.o \
-	   dp_tint.o dp_fint.o dp_maddf.o dp_2008class.o dp_fmin.o dp_fmax.o \
+	   dp_tint.o dp_fint.o dp_rint.o dp_maddf.o dp_2008class.o dp_fmin.o \
+	   dp_fmax.o							     \
 	   sp_div.o sp_mul.o sp_sub.o sp_add.o sp_fdp.o sp_cmp.o sp_simple.o \
-	   sp_tint.o sp_fint.o sp_maddf.o sp_2008class.o sp_fmin.o sp_fmax.o \
+	   sp_tint.o sp_fint.o sp_rint.o sp_maddf.o sp_2008class.o sp_fmin.o \
+	   sp_fmax.o							     \
 	   dsemul.o
 
 lib-y	+= ieee754d.o \
diff --git a/arch/mips/math-emu/cp1emu.c b/arch/mips/math-emu/cp1emu.c
index 520a5ac..cabcf2c 100644
--- a/arch/mips/math-emu/cp1emu.c
+++ b/arch/mips/math-emu/cp1emu.c
@@ -1805,8 +1805,7 @@ static int fpu_emu(struct pt_regs *xcp, struct mips_fpu_struct *ctx,
 				return SIGILL;
 
 			SPFROMREG(fs, MIPSInst_FS(ir));
-			rv.l = ieee754sp_tlong(fs);
-			rv.s = ieee754sp_flong(rv.l);
+			rv.s = ieee754sp_rint(fs);
 			goto copcsr;
 		}
 
@@ -2134,8 +2133,7 @@ static int fpu_emu(struct pt_regs *xcp, struct mips_fpu_struct *ctx,
 				return SIGILL;
 
 			DPFROMREG(fs, MIPSInst_FS(ir));
-			rv.l = ieee754dp_tlong(fs);
-			rv.d = ieee754dp_flong(rv.l);
+			rv.d = ieee754dp_rint(fs);
 			goto copcsr;
 		}
 
diff --git a/arch/mips/math-emu/dp_rint.c b/arch/mips/math-emu/dp_rint.c
new file mode 100644
index 0000000..c3b9077
--- /dev/null
+++ b/arch/mips/math-emu/dp_rint.c
@@ -0,0 +1,89 @@
+/* IEEE754 floating point arithmetic
+ * double precision: common utilities
+ */
+/*
+ * MIPS floating point support
+ * Copyright (C) 1994-2000 Algorithmics Ltd.
+ * Copyright (C) 2017 Imagination Technologies, Ltd.
+ * Author: Aleksandar Markovic <aleksandar.markovic@imgtec.com>
+ *
+ *  This program is free software; you can distribute it and/or modify it
+ *  under the terms of the GNU General Public License (Version 2) as
+ *  published by the Free Software Foundation.
+ *
+ *  This program is distributed in the hope it will be useful, but WITHOUT
+ *  ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ *  FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License
+ *  for more details.
+ *
+ *  You should have received a copy of the GNU General Public License along
+ *  with this program.
+ */
+
+#include "ieee754dp.h"
+
+union ieee754dp ieee754dp_rint(union ieee754dp x)
+{
+	union ieee754dp ret;
+	u64 residue;
+	int sticky;
+	int round;
+	int odd;
+
+	COMPXDP;
+
+	ieee754_clearcx();
+
+	EXPLODEXDP;
+	FLUSHXDP;
+
+	if (xc == IEEE754_CLASS_SNAN)
+		return ieee754dp_nanxcpt(x);
+
+	if ((xc == IEEE754_CLASS_QNAN) ||
+	    (xc == IEEE754_CLASS_INF) ||
+	    (xc == IEEE754_CLASS_ZERO))
+		return x;
+
+	if (xe >= DP_FBITS)
+		return x;
+
+	if (xe < -1) {
+		residue = xm;
+		round = 0;
+		sticky = residue != 0;
+		xm = 0;
+	} else {
+		residue = xm << (64 - DP_FBITS + xe);
+		round = (residue >> 63) != 0;
+		sticky = (residue << 1) != 0;
+		xm >>= DP_FBITS - xe;
+	}
+
+	odd = (xm & 0x1) != 0x0;
+
+	switch (ieee754_csr.rm) {
+	case FPU_CSR_RN:	/* toward nearest */
+		if (round && (sticky || odd))
+			xm++;
+		break;
+	case FPU_CSR_RZ:	/* toward zero */
+		break;
+	case FPU_CSR_RU:	/* toward +infinity */
+		if ((round || sticky) && !xs)
+			xm++;
+		break;
+	case FPU_CSR_RD:	/* toward -infinity */
+		if ((round || sticky) && xs)
+			xm++;
+		break;
+	}
+
+	if (round || sticky)
+		ieee754_setcx(IEEE754_INEXACT);
+
+	ret = ieee754dp_flong(xm);
+	DPSIGN(ret) = xs;
+
+	return ret;
+}
diff --git a/arch/mips/math-emu/ieee754.h b/arch/mips/math-emu/ieee754.h
index d3be351..92dc8fa 100644
--- a/arch/mips/math-emu/ieee754.h
+++ b/arch/mips/math-emu/ieee754.h
@@ -67,6 +67,7 @@ union ieee754sp ieee754sp_div(union ieee754sp x, union ieee754sp y);
 union ieee754sp ieee754sp_fint(int x);
 union ieee754sp ieee754sp_flong(s64 x);
 union ieee754sp ieee754sp_fdp(union ieee754dp x);
+union ieee754sp ieee754sp_rint(union ieee754sp x);
 
 int ieee754sp_tint(union ieee754sp x);
 s64 ieee754sp_tlong(union ieee754sp x);
@@ -101,6 +102,7 @@ union ieee754dp ieee754dp_neg(union ieee754dp x);
 union ieee754dp ieee754dp_fint(int x);
 union ieee754dp ieee754dp_flong(s64 x);
 union ieee754dp ieee754dp_fsp(union ieee754sp x);
+union ieee754dp ieee754dp_rint(union ieee754dp x);
 
 int ieee754dp_tint(union ieee754dp x);
 s64 ieee754dp_tlong(union ieee754dp x);
diff --git a/arch/mips/math-emu/sp_rint.c b/arch/mips/math-emu/sp_rint.c
new file mode 100644
index 0000000..70765b1
--- /dev/null
+++ b/arch/mips/math-emu/sp_rint.c
@@ -0,0 +1,90 @@
+/* IEEE754 floating point arithmetic
+ * single precision
+ */
+/*
+ * MIPS floating point support
+ * Copyright (C) 1994-2000 Algorithmics Ltd.
+ * Copyright (C) 2017 Imagination Technologies, Ltd.
+ * Author: Aleksandar Markovic <aleksandar.markovic@imgtec.com>
+ *
+ *  This program is free software; you can distribute it and/or modify it
+ *  under the terms of the GNU General Public License (Version 2) as
+ *  published by the Free Software Foundation.
+ *
+ *  This program is distributed in the hope it will be useful, but WITHOUT
+ *  ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ *  FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License
+ *  for more details.
+ *
+ *  You should have received a copy of the GNU General Public License along
+ *  with this program.
+ */
+
+#include "ieee754sp.h"
+
+union ieee754sp ieee754sp_rint(union ieee754sp x)
+{
+	union ieee754sp ret;
+	u32 residue;
+	int sticky;
+	int round;
+	int odd;
+
+	COMPXDP;		/* <-- DP needed for 64-bit mantissa tmp */
+
+	ieee754_clearcx();
+
+	EXPLODEXSP;
+	FLUSHXSP;
+
+	if (xc == IEEE754_CLASS_SNAN)
+		return ieee754sp_nanxcpt(x);
+
+	if ((xc == IEEE754_CLASS_QNAN) ||
+	    (xc == IEEE754_CLASS_INF) ||
+	    (xc == IEEE754_CLASS_ZERO))
+		return x;
+
+	if (xe >= SP_FBITS)
+		return x;
+
+	if (xe < -1) {
+		residue = xm;
+		round = 0;
+		sticky = residue != 0;
+		xm = 0;
+	} else {
+		residue = xm << (xe + 1);
+		residue <<= 31 - SP_FBITS;
+		round = (residue >> 31) != 0;
+		sticky = (residue << 1) != 0;
+		xm >>= SP_FBITS - xe;
+	}
+
+	odd = (xm & 0x1) != 0x0;
+
+	switch (ieee754_csr.rm) {
+	case FPU_CSR_RN:	/* toward nearest */
+		if (round && (sticky || odd))
+			xm++;
+		break;
+	case FPU_CSR_RZ:	/* toward zero */
+		break;
+	case FPU_CSR_RU:	/* toward +infinity */
+		if ((round || sticky) && !xs)
+			xm++;
+		break;
+	case FPU_CSR_RD:	/* toward -infinity */
+		if ((round || sticky) && xs)
+			xm++;
+		break;
+	}
+
+	if (round || sticky)
+		ieee754_setcx(IEEE754_INEXACT);
+
+	ret = ieee754sp_flong(xm);
+	SPSIGN(ret) = xs;
+
+	return ret;
+}
-- 
2.7.4
