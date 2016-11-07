Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 07 Nov 2016 12:19:45 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:12325 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23992155AbcKGLSy13GXd (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 7 Nov 2016 12:18:54 +0100
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id 323AA5B86A18C;
        Mon,  7 Nov 2016 11:18:44 +0000 (GMT)
Received: from localhost (10.100.200.221) by HHMAIL01.hh.imgtec.org
 (10.100.10.21) with Microsoft SMTP Server (TLS) id 14.3.294.0; Mon, 7 Nov
 2016 11:18:46 +0000
From:   Paul Burton <paul.burton@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@imgtec.com>
Subject: [PATCH 2/7] MIPS: lib: Implement memmove in C
Date:   Mon, 7 Nov 2016 11:17:57 +0000
Message-ID: <20161107111802.12071-3-paul.burton@imgtec.com>
X-Mailer: git-send-email 2.10.2
In-Reply-To: <20161107111802.12071-1-paul.burton@imgtec.com>
References: <20161107111802.12071-1-paul.burton@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.100.200.221]
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 55696
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: paul.burton@imgtec.com
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

Implement memmove in C, dropping the asm implementation which does no
particular optimisation & was duplicated needlessly for octeon.

Signed-off-by: Paul Burton <paul.burton@imgtec.com>
---

 arch/mips/cavium-octeon/octeon-memcpy.S | 50 +----------------------------
 arch/mips/lib/Makefile                  |  1 +
 arch/mips/lib/memcpy.S                  | 56 +--------------------------------
 arch/mips/lib/memmove.c                 | 39 +++++++++++++++++++++++
 4 files changed, 42 insertions(+), 104 deletions(-)
 create mode 100644 arch/mips/lib/memmove.c

diff --git a/arch/mips/cavium-octeon/octeon-memcpy.S b/arch/mips/cavium-octeon/octeon-memcpy.S
index 7d96d9c..4336316 100644
--- a/arch/mips/cavium-octeon/octeon-memcpy.S
+++ b/arch/mips/cavium-octeon/octeon-memcpy.S
@@ -3,7 +3,7 @@
  * License.  See the file "COPYING" in the main directory of this archive
  * for more details.
  *
- * Unified implementation of memcpy, memmove and the __copy_user backend.
+ * Unified implementation of memcpy and the __copy_user backend.
  *
  * Copyright (C) 1998, 99, 2000, 01, 2002 Ralf Baechle (ralf@gnu.org)
  * Copyright (C) 1999, 2000, 01, 2002 Silicon Graphics, Inc.
@@ -66,9 +66,6 @@
  *
  * The exception handlers for stores adjust len (if necessary) and return.
  * These handlers do not need to overwrite any data.
- *
- * For __rmemcpy and memmove an exception is always a kernel bug, therefore
- * they're not protected.
  */
 
 #define EXC(inst_reg,addr,handler)		\
@@ -460,48 +457,3 @@ s_exc_p1:
 s_exc:
 	jr	ra
 	 nop
-
-	.align	5
-LEAF(memmove)
-EXPORT_SYMBOL(memmove)
-	ADD	t0, a0, a2
-	ADD	t1, a1, a2
-	sltu	t0, a1, t0			# dst + len <= src -> memcpy
-	sltu	t1, a0, t1			# dst >= src + len -> memcpy
-	and	t0, t1
-	beqz	t0, __memcpy
-	 move	v0, a0				/* return value */
-	beqz	a2, r_out
-	END(memmove)
-
-	/* fall through to __rmemcpy */
-LEAF(__rmemcpy)					/* a0=dst a1=src a2=len */
-	 sltu	t0, a1, a0
-	beqz	t0, r_end_bytes_up		# src >= dst
-	 nop
-	ADD	a0, a2				# dst = dst + len
-	ADD	a1, a2				# src = src + len
-
-r_end_bytes:
-	lb	t0, -1(a1)
-	SUB	a2, a2, 0x1
-	sb	t0, -1(a0)
-	SUB	a1, a1, 0x1
-	bnez	a2, r_end_bytes
-	 SUB	a0, a0, 0x1
-
-r_out:
-	jr	ra
-	 move	a2, zero
-
-r_end_bytes_up:
-	lb	t0, (a1)
-	SUB	a2, a2, 0x1
-	sb	t0, (a0)
-	ADD	a1, a1, 0x1
-	bnez	a2, r_end_bytes_up
-	 ADD	a0, a0, 0x1
-
-	jr	ra
-	 move	a2, zero
-	END(__rmemcpy)
diff --git a/arch/mips/lib/Makefile b/arch/mips/lib/Makefile
index c0f0d1d..0040bad 100644
--- a/arch/mips/lib/Makefile
+++ b/arch/mips/lib/Makefile
@@ -6,6 +6,7 @@ lib-y += bitops.o
 lib-y += csum_partial.o
 lib-y += delay.o
 lib-y += memcpy.o
+lib-y += memmove.o
 lib-y += memset.o
 lib-y += mips-atomic.o
 lib-y += strlen_user.o
diff --git a/arch/mips/lib/memcpy.S b/arch/mips/lib/memcpy.S
index c3031f1..b8d34d9 100644
--- a/arch/mips/lib/memcpy.S
+++ b/arch/mips/lib/memcpy.S
@@ -3,7 +3,7 @@
  * License.  See the file "COPYING" in the main directory of this archive
  * for more details.
  *
- * Unified implementation of memcpy, memmove and the __copy_user backend.
+ * Unified implementation of memcpy and the __copy_user backend.
  *
  * Copyright (C) 1998, 99, 2000, 01, 2002 Ralf Baechle (ralf@gnu.org)
  * Copyright (C) 1999, 2000, 01, 2002 Silicon Graphics, Inc.
@@ -82,9 +82,6 @@
  *
  * The exception handlers for stores adjust len (if necessary) and return.
  * These handlers do not need to overwrite any data.
- *
- * For __rmemcpy and memmove an exception is always a kernel bug, therefore
- * they're not protected.
  */
 
 /* Instruction type */
@@ -621,57 +618,6 @@ SEXC(1)
 	 nop
 	.endm
 
-	.align	5
-LEAF(memmove)
-EXPORT_SYMBOL(memmove)
-	ADD	t0, a0, a2
-	ADD	t1, a1, a2
-	sltu	t0, a1, t0			# dst + len <= src -> memcpy
-	sltu	t1, a0, t1			# dst >= src + len -> memcpy
-	and	t0, t1
-	beqz	t0, .L__memcpy
-	 move	v0, a0				/* return value */
-	beqz	a2, .Lr_out
-	END(memmove)
-
-	/* fall through to __rmemcpy */
-LEAF(__rmemcpy)					/* a0=dst a1=src a2=len */
-	 sltu	t0, a1, a0
-	beqz	t0, .Lr_end_bytes_up		# src >= dst
-	 nop
-	ADD	a0, a2				# dst = dst + len
-	ADD	a1, a2				# src = src + len
-
-.Lr_end_bytes:
-	R10KCBARRIER(0(ra))
-	lb	t0, -1(a1)
-	SUB	a2, a2, 0x1
-	sb	t0, -1(a0)
-	SUB	a1, a1, 0x1
-	.set	reorder				/* DADDI_WAR */
-	SUB	a0, a0, 0x1
-	bnez	a2, .Lr_end_bytes
-	.set	noreorder
-
-.Lr_out:
-	jr	ra
-	 move	a2, zero
-
-.Lr_end_bytes_up:
-	R10KCBARRIER(0(ra))
-	lb	t0, (a1)
-	SUB	a2, a2, 0x1
-	sb	t0, (a0)
-	ADD	a1, a1, 0x1
-	.set	reorder				/* DADDI_WAR */
-	ADD	a0, a0, 0x1
-	bnez	a2, .Lr_end_bytes_up
-	.set	noreorder
-
-	jr	ra
-	 move	a2, zero
-	END(__rmemcpy)
-
 /*
  * t6 is used as a flag to note inatomic mode.
  */
diff --git a/arch/mips/lib/memmove.c b/arch/mips/lib/memmove.c
new file mode 100644
index 0000000..4e902c6
--- /dev/null
+++ b/arch/mips/lib/memmove.c
@@ -0,0 +1,39 @@
+/*
+ * Copyright (C) 2016 Imagination Technologies
+ * Author: Paul Burton <paul.burton@imgtec.com>
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License as published by the
+ * Free Software Foundation;  either version 2 of the  License, or (at your
+ * option) any later version.
+ */
+
+#include <linux/export.h>
+#include <linux/string.h>
+
+extern void *memmove(void *dest, const void *src, size_t count)
+{
+	const char *s = src;
+	const char *s_end = s + count;
+	char *d = dest;
+	char *d_end = dest + count;
+
+	/* Use optimised memcpy when there's no overlap */
+	if ((d_end <= s) || (s_end <= d))
+		return memcpy(dest, src, count);
+
+	if (d <= s) {
+		/* Incrementing copy loop */
+		while (count--)
+			*d++ = *s++;
+	} else {
+		/* Decrementing copy loop */
+		d = d_end;
+		s = s_end;
+		while (count--)
+			*--d = *--s;
+	}
+
+	return dest;
+}
+EXPORT_SYMBOL(memmove);
-- 
2.10.2
