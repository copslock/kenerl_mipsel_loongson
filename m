Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 13 Aug 2015 10:00:49 +0200 (CEST)
Received: (from localhost user: 'mchandras' uid#10145 fake: STDIN
        (mchandras@eddie.linux-mips.org)) by eddie.linux-mips.org
        id S27012157AbbHMH7AZYG64 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 13 Aug 2015 09:59:00 +0200
From:   Markos Chandras <markos.chandras@imgtec.com>
To:     <linux-mips@linux-mips.org>
Cc:     Markos Chandras <markos.chandras@imgtec.com>
Subject: [PATCH 08/10] MIPS: math-emu: Add support for the MIPS R6 CLASS FPU instruction
Date:   Thu, 13 Aug 2015 09:56:34 +0200
Message-Id: <1439452596-16759-9-git-send-email-markos.chandras@imgtec.com>
X-Mailer: git-send-email 2.4.3
In-Reply-To: <1439452596-16759-1-git-send-email-markos.chandras@imgtec.com>
References: <1439452596-16759-1-git-send-email-markos.chandras@imgtec.com>
Return-Path: <mchandras@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 48839
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: markos.chandras@imgtec.com
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

MIPS R6 introduced the following instruction:
Stores in fd a bit mask reflecting the floating-point class of the
floating point scalar value fs.

CLASS.fmt: FPR[fd] = class(FPR[fs])

Signed-off-by: Markos Chandras <markos.chandras@imgtec.com>
---
 arch/mips/math-emu/Makefile       |  4 +--
 arch/mips/math-emu/cp1emu.c       | 24 +++++++++++++++++
 arch/mips/math-emu/dp_2008class.c | 55 +++++++++++++++++++++++++++++++++++++++
 arch/mips/math-emu/ieee754.h      |  2 ++
 arch/mips/math-emu/sp_2008class.c | 55 +++++++++++++++++++++++++++++++++++++++
 5 files changed, 138 insertions(+), 2 deletions(-)
 create mode 100644 arch/mips/math-emu/dp_2008class.c
 create mode 100644 arch/mips/math-emu/sp_2008class.c

diff --git a/arch/mips/math-emu/Makefile b/arch/mips/math-emu/Makefile
index 0037690521ee..ea8db2607d07 100644
--- a/arch/mips/math-emu/Makefile
+++ b/arch/mips/math-emu/Makefile
@@ -4,9 +4,9 @@
 
 obj-y	+= cp1emu.o ieee754dp.o ieee754sp.o ieee754.o \
 	   dp_div.o dp_mul.o dp_sub.o dp_add.o dp_fsp.o dp_cmp.o dp_simple.o \
-	   dp_tint.o dp_fint.o dp_maddf.o dp_msubf.o \
+	   dp_tint.o dp_fint.o dp_maddf.o dp_msubf.o dp_2008class.o \
 	   sp_div.o sp_mul.o sp_sub.o sp_add.o sp_fdp.o sp_cmp.o sp_simple.o \
-	   sp_tint.o sp_fint.o sp_maddf.o sp_msubf.o \
+	   sp_tint.o sp_fint.o sp_maddf.o sp_msubf.o sp_2008class.o \
 	   dsemul.o
 
 lib-y	+= ieee754d.o \
diff --git a/arch/mips/math-emu/cp1emu.c b/arch/mips/math-emu/cp1emu.c
index 6b09b37ff50a..cdebeb14a7d0 100644
--- a/arch/mips/math-emu/cp1emu.c
+++ b/arch/mips/math-emu/cp1emu.c
@@ -1785,6 +1785,18 @@ static int fpu_emu(struct pt_regs *xcp, struct mips_fpu_struct *ctx,
 			goto copcsr;
 		}
 
+		case fclass_op: {
+			union ieee754sp fs;
+
+			if (!cpu_has_mips_r6)
+				return SIGILL;
+
+			SPFROMREG(fs, MIPSInst_FS(ir));
+			rv.w = ieee754sp_2008class(fs);
+			rfmt = w_fmt;
+			break;
+		}
+
 		case fabs_op:
 			handler.u = ieee754sp_abs;
 			goto scopuop;
@@ -2043,6 +2055,18 @@ copcsr:
 			goto copcsr;
 		}
 
+		case fclass_op: {
+			union ieee754dp fs;
+
+			if (!cpu_has_mips_r6)
+				return SIGILL;
+
+			DPFROMREG(fs, MIPSInst_FS(ir));
+			rv.w = ieee754dp_2008class(fs);
+			rfmt = w_fmt;
+			break;
+		}
+
 		case fabs_op:
 			handler.u = ieee754dp_abs;
 			goto dcopuop;
diff --git a/arch/mips/math-emu/dp_2008class.c b/arch/mips/math-emu/dp_2008class.c
new file mode 100644
index 000000000000..9dc39fc4835e
--- /dev/null
+++ b/arch/mips/math-emu/dp_2008class.c
@@ -0,0 +1,55 @@
+/*
+ * IEEE754 floating point arithmetic
+ * double precision: CLASS.f
+ * FPR[fd] = class(FPR[fs])
+ *
+ * MIPS floating point support
+ * Copyright (C) 2015 Imagination Technologies, Ltd.
+ * Author: Markos Chandras <markos.chandras@imgtec.com>
+ *
+ *  This program is free software; you can distribute it and/or modify it
+ *  under the terms of the GNU General Public License as published by the
+ *  Free Software Foundation; version 2 of the License.
+ */
+
+#include "ieee754dp.h"
+
+int ieee754dp_2008class(union ieee754dp x)
+{
+	COMPXDP;
+
+	EXPLODEXDP;
+
+	/*
+	 * 10 bit mask as follows:
+	 *
+	 * bit0 = SNAN
+	 * bit1 = QNAN
+	 * bit2 = -INF
+	 * bit3 = -NORM
+	 * bit4 = -DNORM
+	 * bit5 = -ZERO
+	 * bit6 = INF
+	 * bit7 = NORM
+	 * bit8 = DNORM
+	 * bit9 = ZERO
+	 */
+
+	switch(xc) {
+	case IEEE754_CLASS_SNAN:
+		return 0x01;
+	case IEEE754_CLASS_QNAN:
+		return 0x02;
+	case IEEE754_CLASS_INF:
+		return 0x04 << (xs ? 0 : 4);
+	case IEEE754_CLASS_NORM:
+		return 0x08 << (xs ? 0 : 4);
+	case IEEE754_CLASS_DNORM:
+		return 0x10 << (xs ? 0 : 4);
+	case IEEE754_CLASS_ZERO:
+		return 0x20 << (xs ? 0 : 4);
+	default:
+		pr_err("Unknown class: %d\n", xc);
+		return 0;
+	}
+}
diff --git a/arch/mips/math-emu/ieee754.h b/arch/mips/math-emu/ieee754.h
index 8c780190a059..3b833eac48f5 100644
--- a/arch/mips/math-emu/ieee754.h
+++ b/arch/mips/math-emu/ieee754.h
@@ -79,6 +79,7 @@ union ieee754sp ieee754sp_maddf(union ieee754sp z, union ieee754sp x,
 				union ieee754sp y);
 union ieee754sp ieee754sp_msubf(union ieee754sp z, union ieee754sp x,
 				union ieee754sp y);
+int ieee754sp_2008class(union ieee754sp x);
 
 /*
  * double precision (often aka double)
@@ -108,6 +109,7 @@ union ieee754dp ieee754dp_maddf(union ieee754dp z, union ieee754dp x,
 				union ieee754dp y);
 union ieee754dp ieee754dp_msubf(union ieee754dp z, union ieee754dp x,
 				union ieee754dp y);
+int ieee754dp_2008class(union ieee754dp x);
 
 
 /* 5 types of floating point number
diff --git a/arch/mips/math-emu/sp_2008class.c b/arch/mips/math-emu/sp_2008class.c
new file mode 100644
index 000000000000..ff62606a1465
--- /dev/null
+++ b/arch/mips/math-emu/sp_2008class.c
@@ -0,0 +1,55 @@
+/*
+ * IEEE754 floating point arithmetic
+ * single precision: CLASS.f
+ * FPR[fd] = class(FPR[fs])
+ *
+ * MIPS floating point support
+ * Copyright (C) 2015 Imagination Technologies, Ltd.
+ * Author: Markos Chandras <markos.chandras@imgtec.com>
+ *
+ *  This program is free software; you can distribute it and/or modify it
+ *  under the terms of the GNU General Public License as published by the
+ *  Free Software Foundation; version 2 of the License.
+ */
+
+#include "ieee754sp.h"
+
+int ieee754sp_2008class(union ieee754sp x)
+{
+	COMPXSP;
+
+	EXPLODEXSP;
+
+	/*
+	 * 10 bit mask as follows:
+	 *
+	 * bit0 = SNAN
+	 * bit1 = QNAN
+	 * bit2 = -INF
+	 * bit3 = -NORM
+	 * bit4 = -DNORM
+	 * bit5 = -ZERO
+	 * bit6 = INF
+	 * bit7 = NORM
+	 * bit8 = DNORM
+	 * bit9 = ZERO
+	 */
+
+	switch(xc) {
+	case IEEE754_CLASS_SNAN:
+		return 0x01;
+	case IEEE754_CLASS_QNAN:
+		return 0x02;
+	case IEEE754_CLASS_INF:
+		return 0x04 << (xs ? 0 : 4);
+	case IEEE754_CLASS_NORM:
+		return 0x08 << (xs ? 0 : 4);
+	case IEEE754_CLASS_DNORM:
+		return 0x10 << (xs ? 0 : 4);
+	case IEEE754_CLASS_ZERO:
+		return 0x20 << (xs ? 0 : 4);
+	default:
+		pr_err("Unknown class: %d\n", xc);
+		return 0;
+	}
+}
-- 
2.5.0
