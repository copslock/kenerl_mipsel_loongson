Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 03 Dec 2006 15:43:10 +0000 (GMT)
Received: from mba.ocn.ne.jp ([210.190.142.172]:36295 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S20038819AbWLCPnE (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sun, 3 Dec 2006 15:43:04 +0000
Received: from localhost (p6165-ipad201funabasi.chiba.ocn.ne.jp [222.146.69.165])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id 33FE7BC95; Mon,  4 Dec 2006 00:42:59 +0900 (JST)
Date:	Mon, 04 Dec 2006 00:42:59 +0900 (JST)
Message-Id: <20061204.004259.63130921.anemo@mba.ocn.ne.jp>
To:	linux-mips@linux-mips.org
Cc:	ralf@linux-mips.org
Subject: [PATCH] Unify csum_partial.S
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
X-Fingerprint: 6ACA 1623 39BD 9A94 9B1A  B746 CA77 FE94 2874 D52F
X-Pgp-Public-Key: http://wwwkeys.pgp.net/pks/lookup?op=get&search=0x2874D52F
X-Mailer: Mew version 3.3 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <anemo@mba.ocn.ne.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 13329
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

The 32-bit version and 64-bit version are almost equal.  Unify them.
This makes further improvements (for example, copying with parallel,
supporting PREFETCH, etc.) easier.

Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
---
 arch/mips/lib-32/Makefile       |    2 
 arch/mips/lib-32/csum_partial.S |  240 ---------------------------
 arch/mips/lib-64/Makefile       |    2 
 arch/mips/lib-64/csum_partial.S |  242 ----------------------------
 arch/mips/lib/Makefile          |    4 
 arch/mips/lib/csum_partial.S    |  258 ++++++++++++++++++++++++++++++
 6 files changed, 262 insertions(+), 486 deletions(-)

diff --git a/arch/mips/lib-32/Makefile b/arch/mips/lib-32/Makefile
index ad28578..dcd4d2e 100644
--- a/arch/mips/lib-32/Makefile
+++ b/arch/mips/lib-32/Makefile
@@ -2,7 +2,7 @@ #
 # Makefile for MIPS-specific library files..
 #
 
-lib-y	+= csum_partial.o memset.o watch.o
+lib-y	+= memset.o watch.o
 
 obj-$(CONFIG_CPU_MIPS32)	+= dump_tlb.o
 obj-$(CONFIG_CPU_MIPS64)	+= dump_tlb.o
diff --git a/arch/mips/lib-32/csum_partial.S b/arch/mips/lib-32/csum_partial.S
deleted file mode 100644
index ea257db..0000000
--- a/arch/mips/lib-32/csum_partial.S
+++ /dev/null
@@ -1,240 +0,0 @@
-/*
- * This file is subject to the terms and conditions of the GNU General Public
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
- *
- * Copyright (C) 1998 Ralf Baechle
- */
-#include <asm/asm.h>
-#include <asm/regdef.h>
-
-#define ADDC(sum,reg)			\
-	addu	sum, reg;		\
-	sltu	v1, sum, reg;		\
-	addu	sum, v1
-
-#define CSUM_BIGCHUNK(src, offset, sum, t0, t1, t2, t3) \
-	lw	t0, (offset + 0x00)(src); \
-	lw	t1, (offset + 0x04)(src); \
-	lw	t2, (offset + 0x08)(src); \
-	lw	t3, (offset + 0x0c)(src); \
-	ADDC(sum, t0);                    \
-	ADDC(sum, t1);                    \
-	ADDC(sum, t2);                    \
-	ADDC(sum, t3);                    \
-	lw	t0, (offset + 0x10)(src); \
-	lw	t1, (offset + 0x14)(src); \
-	lw	t2, (offset + 0x18)(src); \
-	lw	t3, (offset + 0x1c)(src); \
-	ADDC(sum, t0);                    \
-	ADDC(sum, t1);                    \
-	ADDC(sum, t2);                    \
-	ADDC(sum, t3);                    \
-
-/*
- * a0: source address
- * a1: length of the area to checksum
- * a2: partial checksum
- */
-
-#define src a0
-#define dest a1
-#define sum v0
-
-	.text
-	.set	noreorder
-
-/* unknown src alignment and < 8 bytes to go  */
-small_csumcpy:
-	move	a1, t2
-
-	andi	t0, a1, 4
-	beqz	t0, 1f
-	 andi	t0, a1, 2
-
-	/* Still a full word to go  */
-	ulw	t1, (src)
-	addiu	src, 4
-	ADDC(sum, t1)
-
-1:	move	t1, zero
-	beqz	t0, 1f
-	 andi	t0, a1, 1
-
-	/* Still a halfword to go  */
-	ulhu	t1, (src)
-	addiu	src, 2
-
-1:	beqz	t0, 1f
-	 sll	t1, t1, 16
-
-	lbu	t2, (src)
-	 nop
-
-#ifdef __MIPSEB__
-	sll	t2, t2, 8
-#endif
-	or	t1, t2
-
-1:	ADDC(sum, t1)
-
-	/* fold checksum */
-	sll	v1, sum, 16
-	addu	sum, v1
-	sltu	v1, sum, v1
-	srl	sum, sum, 16
-	addu	sum, v1
-
-	/* odd buffer alignment? */
-	beqz	t7, 1f
-	 nop
-	sll	v1, sum, 8
-	srl	sum, sum, 8
-	or	sum, v1
-	andi	sum, 0xffff
-1:
-	.set	reorder
-	/* Add the passed partial csum.  */
-	ADDC(sum, a2)
-	jr	ra
-	.set	noreorder
-
-/* ------------------------------------------------------------------------- */
-
-	.align	5
-LEAF(csum_partial)
-	move	sum, zero
-	move	t7, zero
-
-	sltiu	t8, a1, 0x8
-	bnez	t8, small_csumcpy		/* < 8 bytes to copy */
-	 move	t2, a1
-
-	beqz	a1, out
-	 andi	t7, src, 0x1			/* odd buffer? */
-
-hword_align:
-	beqz	t7, word_align
-	 andi	t8, src, 0x2
-
-	lbu	t0, (src)
-	subu	a1, a1, 0x1
-#ifdef __MIPSEL__
-	sll	t0, t0, 8
-#endif
-	ADDC(sum, t0)
-	addu	src, src, 0x1
-	andi	t8, src, 0x2
-
-word_align:
-	beqz	t8, dword_align
-	 sltiu	t8, a1, 56
-
-	lhu	t0, (src)
-	subu	a1, a1, 0x2
-	ADDC(sum, t0)
-	sltiu	t8, a1, 56
-	addu	src, src, 0x2
-
-dword_align:
-	bnez	t8, do_end_words
-	 move	t8, a1
-
-	andi	t8, src, 0x4
-	beqz	t8, qword_align
-	 andi	t8, src, 0x8
-
-	lw	t0, 0x00(src)
-	subu	a1, a1, 0x4
-	ADDC(sum, t0)
-	addu	src, src, 0x4
-	andi	t8, src, 0x8
-
-qword_align:
-	beqz	t8, oword_align
-	 andi	t8, src, 0x10
-
-	lw	t0, 0x00(src)
-	lw	t1, 0x04(src)
-	subu	a1, a1, 0x8
-	ADDC(sum, t0)
-	ADDC(sum, t1)
-	addu	src, src, 0x8
-	andi	t8, src, 0x10
-
-oword_align:
-	beqz	t8, begin_movement
-	 srl	t8, a1, 0x7
-
-	lw	t3, 0x08(src)
-	lw	t4, 0x0c(src)
-	lw	t0, 0x00(src)
-	lw	t1, 0x04(src)
-	ADDC(sum, t3)
-	ADDC(sum, t4)
-	ADDC(sum, t0)
-	ADDC(sum, t1)
-	subu	a1, a1, 0x10
-	addu	src, src, 0x10
-	srl	t8, a1, 0x7
-
-begin_movement:
-	beqz	t8, 1f
-	 andi	t2, a1, 0x40
-
-move_128bytes:
-	CSUM_BIGCHUNK(src, 0x00, sum, t0, t1, t3, t4)
-	CSUM_BIGCHUNK(src, 0x20, sum, t0, t1, t3, t4)
-	CSUM_BIGCHUNK(src, 0x40, sum, t0, t1, t3, t4)
-	CSUM_BIGCHUNK(src, 0x60, sum, t0, t1, t3, t4)
-	subu	t8, t8, 0x01
-	bnez	t8, move_128bytes
-	 addu	src, src, 0x80
-
-1:
-	beqz	t2, 1f
-	 andi	t2, a1, 0x20
-
-move_64bytes:
-	CSUM_BIGCHUNK(src, 0x00, sum, t0, t1, t3, t4)
-	CSUM_BIGCHUNK(src, 0x20, sum, t0, t1, t3, t4)
-	addu	src, src, 0x40
-
-1:
-	beqz	t2, do_end_words
-	 andi	t8, a1, 0x1c
-
-move_32bytes:
-	CSUM_BIGCHUNK(src, 0x00, sum, t0, t1, t3, t4)
-	andi	t8, a1, 0x1c
-	addu	src, src, 0x20
-
-do_end_words:
-	beqz	t8, maybe_end_cruft
-	 srl	t8, t8, 0x2
-
-end_words:
-	lw	t0, (src)
-	subu	t8, t8, 0x1
-	ADDC(sum, t0)
-	bnez	t8, end_words
-	 addu	src, src, 0x4
-
-maybe_end_cruft:
-	andi	t2, a1, 0x3
-
-small_memcpy:
- j small_csumcpy; move a1, t2
-	beqz	t2, out
-	 move	a1, t2
-
-end_bytes:
-	lb	t0, (src)
-	subu	a1, a1, 0x1
-	bnez	a2, end_bytes
-	 addu	src, src, 0x1
-
-out:
-	jr	ra
-	 move	v0, sum
-	END(csum_partial)
diff --git a/arch/mips/lib-64/Makefile b/arch/mips/lib-64/Makefile
index ad28578..dcd4d2e 100644
--- a/arch/mips/lib-64/Makefile
+++ b/arch/mips/lib-64/Makefile
@@ -2,7 +2,7 @@ #
 # Makefile for MIPS-specific library files..
 #
 
-lib-y	+= csum_partial.o memset.o watch.o
+lib-y	+= memset.o watch.o
 
 obj-$(CONFIG_CPU_MIPS32)	+= dump_tlb.o
 obj-$(CONFIG_CPU_MIPS64)	+= dump_tlb.o
diff --git a/arch/mips/lib-64/csum_partial.S b/arch/mips/lib-64/csum_partial.S
deleted file mode 100644
index 25aba66..0000000
--- a/arch/mips/lib-64/csum_partial.S
+++ /dev/null
@@ -1,242 +0,0 @@
-/*
- * This file is subject to the terms and conditions of the GNU General Public
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
- *
- * Quick'n'dirty IP checksum ...
- *
- * Copyright (C) 1998, 1999 Ralf Baechle
- * Copyright (C) 1999 Silicon Graphics, Inc.
- */
-#include <asm/asm.h>
-#include <asm/regdef.h>
-
-#define ADDC(sum,reg)						\
-	addu	sum, reg;					\
-	sltu	v1, sum, reg;					\
-	addu	sum, v1
-
-#define CSUM_BIGCHUNK(src, offset, sum, t0, t1, t2, t3)		\
-	lw	t0, (offset + 0x00)(src);			\
-	lw	t1, (offset + 0x04)(src);			\
-	lw	t2, (offset + 0x08)(src); 			\
-	lw	t3, (offset + 0x0c)(src); 			\
-	ADDC(sum, t0);						\
-	ADDC(sum, t1);						\
-	ADDC(sum, t2);						\
-	ADDC(sum, t3);						\
-	lw	t0, (offset + 0x10)(src);			\
-	lw	t1, (offset + 0x14)(src);			\
-	lw	t2, (offset + 0x18)(src);			\
-	lw	t3, (offset + 0x1c)(src);			\
-	ADDC(sum, t0);						\
-	ADDC(sum, t1);						\
-	ADDC(sum, t2);						\
-	ADDC(sum, t3);						\
-
-/*
- * a0: source address
- * a1: length of the area to checksum
- * a2: partial checksum
- */
-
-#define src a0
-#define sum v0
-
-	.text
-	.set	noreorder
-
-/* unknown src alignment and < 8 bytes to go  */
-small_csumcpy:
-	move	a1, ta2
-
-	andi	ta0, a1, 4
-	beqz	ta0, 1f
-	 andi	ta0, a1, 2
-
-	/* Still a full word to go  */
-	ulw	ta1, (src)
-	daddiu	src, 4
-	ADDC(sum, ta1)
-
-1:	move	ta1, zero
-	beqz	ta0, 1f
-	 andi	ta0, a1, 1
-
-	/* Still a halfword to go  */
-	ulhu	ta1, (src)
-	daddiu	src, 2
-
-1:	beqz	ta0, 1f
-	 sll	ta1, ta1, 16
-
-	lbu	ta2, (src)
-	 nop
-
-#ifdef __MIPSEB__
-	sll	ta2, ta2, 8
-#endif
-	or	ta1, ta2
-
-1:	ADDC(sum, ta1)
-
-	/* fold checksum */
-	sll	v1, sum, 16
-	addu	sum, v1
-	sltu	v1, sum, v1
-	srl	sum, sum, 16
-	addu	sum, v1
-
-	/* odd buffer alignment? */
-	beqz	t3, 1f
-	 nop
-	sll	v1, sum, 8
-	srl	sum, sum, 8
-	or	sum, v1
-	andi	sum, 0xffff
-1:
-	.set	reorder
-	/* Add the passed partial csum.  */
-	ADDC(sum, a2)
-	jr	ra
-	.set	noreorder
-
-/* ------------------------------------------------------------------------- */
-
-	.align	5
-LEAF(csum_partial)
-	move	sum, zero
-	move	t3, zero
-
-	sltiu	t8, a1, 0x8
-	bnez	t8, small_csumcpy		/* < 8 bytes to copy */
-	 move	ta2, a1
-
-	beqz	a1, out
-	 andi	t3, src, 0x1			/* odd buffer? */
-
-hword_align:
-	beqz	t3, word_align
-	 andi	t8, src, 0x2
-
-	lbu	ta0, (src)
-	dsubu	a1, a1, 0x1
-#ifdef __MIPSEL__
-	sll	ta0, ta0, 8
-#endif
-	ADDC(sum, ta0)
-	daddu	src, src, 0x1
-	andi	t8, src, 0x2
-
-word_align:
-	beqz	t8, dword_align
-	 sltiu	t8, a1, 56
-
-	lhu	ta0, (src)
-	dsubu	a1, a1, 0x2
-	ADDC(sum, ta0)
-	sltiu	t8, a1, 56
-	daddu	src, src, 0x2
-
-dword_align:
-	bnez	t8, do_end_words
-	 move	t8, a1
-
-	andi	t8, src, 0x4
-	beqz	t8, qword_align
-	 andi	t8, src, 0x8
-
-	lw	ta0, 0x00(src)
-	dsubu	a1, a1, 0x4
-	ADDC(sum, ta0)
-	daddu	src, src, 0x4
-	andi	t8, src, 0x8
-
-qword_align:
-	beqz	t8, oword_align
-	 andi	t8, src, 0x10
-
-	lw	ta0, 0x00(src)
-	lw	ta1, 0x04(src)
-	dsubu	a1, a1, 0x8
-	ADDC(sum, ta0)
-	ADDC(sum, ta1)
-	daddu	src, src, 0x8
-	andi	t8, src, 0x10
-
-oword_align:
-	beqz	t8, begin_movement
-	 dsrl	t8, a1, 0x7
-
-	lw	ta3, 0x08(src)
-	lw	t0, 0x0c(src)
-	lw	ta0, 0x00(src)
-	lw	ta1, 0x04(src)
-	ADDC(sum, ta3)
-	ADDC(sum, t0)
-	ADDC(sum, ta0)
-	ADDC(sum, ta1)
-	dsubu	a1, a1, 0x10
-	daddu	src, src, 0x10
-	dsrl	t8, a1, 0x7
-
-begin_movement:
-	beqz	t8, 1f
-	 andi	ta2, a1, 0x40
-
-move_128bytes:
-	CSUM_BIGCHUNK(src, 0x00, sum, ta0, ta1, ta3, t0)
-	CSUM_BIGCHUNK(src, 0x20, sum, ta0, ta1, ta3, t0)
-	CSUM_BIGCHUNK(src, 0x40, sum, ta0, ta1, ta3, t0)
-	CSUM_BIGCHUNK(src, 0x60, sum, ta0, ta1, ta3, t0)
-	dsubu	t8, t8, 0x01
-	bnez	t8, move_128bytes
-	 daddu	src, src, 0x80
-
-1:
-	beqz	ta2, 1f
-	 andi	ta2, a1, 0x20
-
-move_64bytes:
-	CSUM_BIGCHUNK(src, 0x00, sum, ta0, ta1, ta3, t0)
-	CSUM_BIGCHUNK(src, 0x20, sum, ta0, ta1, ta3, t0)
-	daddu	src, src, 0x40
-
-1:
-	beqz	ta2, do_end_words
-	 andi	t8, a1, 0x1c
-
-move_32bytes:
-	CSUM_BIGCHUNK(src, 0x00, sum, ta0, ta1, ta3, t0)
-	andi	t8, a1, 0x1c
-	daddu	src, src, 0x20
-
-do_end_words:
-	beqz	t8, maybe_end_cruft
-	 dsrl	t8, t8, 0x2
-
-end_words:
-	lw	ta0, (src)
-	dsubu	t8, t8, 0x1
-	ADDC(sum, ta0)
-	bnez	t8, end_words
-	 daddu	src, src, 0x4
-
-maybe_end_cruft:
-	andi	ta2, a1, 0x3
-
-small_memcpy:
- j small_csumcpy; move a1, ta2		/* XXX ??? */
-	beqz	t2, out
-	 move	a1, ta2
-
-end_bytes:
-	lb	ta0, (src)
-	dsubu	a1, a1, 0x1
-	bnez	a2, end_bytes
-	 daddu	src, src, 0x1
-
-out:
-	jr	ra
-	 move	v0, sum
-	END(csum_partial)
diff --git a/arch/mips/lib/Makefile b/arch/mips/lib/Makefile
index 7e86f0c..42a2b24 100644
--- a/arch/mips/lib/Makefile
+++ b/arch/mips/lib/Makefile
@@ -2,8 +2,8 @@ #
 # Makefile for MIPS-specific library files..
 #
 
-lib-y	+= csum_partial_copy.o memcpy.o promlib.o strlen_user.o strncpy_user.o \
-	   strnlen_user.o uncached.o
+lib-y	+= csum_partial.o csum_partial_copy.o memcpy.o promlib.o \
+	   strlen_user.o strncpy_user.o strnlen_user.o uncached.o 
 
 # libgcc-style stuff needed in the kernel
 lib-y += ashldi3.o ashrdi3.o lshrdi3.o
diff --git a/arch/mips/lib/csum_partial.S b/arch/mips/lib/csum_partial.S
new file mode 100644
index 0000000..15611d9
--- /dev/null
+++ b/arch/mips/lib/csum_partial.S
@@ -0,0 +1,258 @@
+/*
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ *
+ * Quick'n'dirty IP checksum ...
+ *
+ * Copyright (C) 1998, 1999 Ralf Baechle
+ * Copyright (C) 1999 Silicon Graphics, Inc.
+ */
+#include <asm/asm.h>
+#include <asm/regdef.h>
+
+#ifdef CONFIG_64BIT
+#define T0	ta0
+#define T1	ta1
+#define T2	ta2
+#define T3	ta3
+#define T4	t0
+#define T7	t3
+#else
+#define T0	t0
+#define T1	t1
+#define T2	t2
+#define T3	t3
+#define T4	t4
+#define T7	t7
+#endif
+
+#define ADDC(sum,reg)						\
+	addu	sum, reg;					\
+	sltu	v1, sum, reg;					\
+	addu	sum, v1
+
+#define CSUM_BIGCHUNK(src, offset, sum, _t0, _t1, _t2, _t3)	\
+	lw	_t0, (offset + 0x00)(src);			\
+	lw	_t1, (offset + 0x04)(src);			\
+	lw	_t2, (offset + 0x08)(src); 			\
+	lw	_t3, (offset + 0x0c)(src); 			\
+	ADDC(sum, _t0);						\
+	ADDC(sum, _t1);						\
+	ADDC(sum, _t2);						\
+	ADDC(sum, _t3);						\
+	lw	_t0, (offset + 0x10)(src);			\
+	lw	_t1, (offset + 0x14)(src);			\
+	lw	_t2, (offset + 0x18)(src);			\
+	lw	_t3, (offset + 0x1c)(src);			\
+	ADDC(sum, _t0);						\
+	ADDC(sum, _t1);						\
+	ADDC(sum, _t2);						\
+	ADDC(sum, _t3);						\
+
+/*
+ * a0: source address
+ * a1: length of the area to checksum
+ * a2: partial checksum
+ */
+
+#define src a0
+#define sum v0
+
+	.text
+	.set	noreorder
+
+/* unknown src alignment and < 8 bytes to go  */
+small_csumcpy:
+	move	a1, T2
+
+	andi	T0, a1, 4
+	beqz	T0, 1f
+	 andi	T0, a1, 2
+
+	/* Still a full word to go  */
+	ulw	T1, (src)
+	PTR_ADDIU	src, 4
+	ADDC(sum, T1)
+
+1:	move	T1, zero
+	beqz	T0, 1f
+	 andi	T0, a1, 1
+
+	/* Still a halfword to go  */
+	ulhu	T1, (src)
+	PTR_ADDIU	src, 2
+
+1:	beqz	T0, 1f
+	 sll	T1, T1, 16
+
+	lbu	T2, (src)
+	 nop
+
+#ifdef __MIPSEB__
+	sll	T2, T2, 8
+#endif
+	or	T1, T2
+
+1:	ADDC(sum, T1)
+
+	/* fold checksum */
+	sll	v1, sum, 16
+	addu	sum, v1
+	sltu	v1, sum, v1
+	srl	sum, sum, 16
+	addu	sum, v1
+
+	/* odd buffer alignment? */
+	beqz	T7, 1f
+	 nop
+	sll	v1, sum, 8
+	srl	sum, sum, 8
+	or	sum, v1
+	andi	sum, 0xffff
+1:
+	.set	reorder
+	/* Add the passed partial csum.  */
+	ADDC(sum, a2)
+	jr	ra
+	.set	noreorder
+
+/* ------------------------------------------------------------------------- */
+
+	.align	5
+LEAF(csum_partial)
+	move	sum, zero
+	move	T7, zero
+
+	sltiu	t8, a1, 0x8
+	bnez	t8, small_csumcpy		/* < 8 bytes to copy */
+	 move	T2, a1
+
+	beqz	a1, out
+	 andi	T7, src, 0x1			/* odd buffer? */
+
+hword_align:
+	beqz	T7, word_align
+	 andi	t8, src, 0x2
+
+	lbu	T0, (src)
+	LONG_SUBU	a1, a1, 0x1
+#ifdef __MIPSEL__
+	sll	T0, T0, 8
+#endif
+	ADDC(sum, T0)
+	PTR_ADDU	src, src, 0x1
+	andi	t8, src, 0x2
+
+word_align:
+	beqz	t8, dword_align
+	 sltiu	t8, a1, 56
+
+	lhu	T0, (src)
+	LONG_SUBU	a1, a1, 0x2
+	ADDC(sum, T0)
+	sltiu	t8, a1, 56
+	PTR_ADDU	src, src, 0x2
+
+dword_align:
+	bnez	t8, do_end_words
+	 move	t8, a1
+
+	andi	t8, src, 0x4
+	beqz	t8, qword_align
+	 andi	t8, src, 0x8
+
+	lw	T0, 0x00(src)
+	LONG_SUBU	a1, a1, 0x4
+	ADDC(sum, T0)
+	PTR_ADDU	src, src, 0x4
+	andi	t8, src, 0x8
+
+qword_align:
+	beqz	t8, oword_align
+	 andi	t8, src, 0x10
+
+	lw	T0, 0x00(src)
+	lw	T1, 0x04(src)
+	LONG_SUBU	a1, a1, 0x8
+	ADDC(sum, T0)
+	ADDC(sum, T1)
+	PTR_ADDU	src, src, 0x8
+	andi	t8, src, 0x10
+
+oword_align:
+	beqz	t8, begin_movement
+	 LONG_SRL	t8, a1, 0x7
+
+	lw	T3, 0x08(src)
+	lw	T4, 0x0c(src)
+	lw	T0, 0x00(src)
+	lw	T1, 0x04(src)
+	ADDC(sum, T3)
+	ADDC(sum, T4)
+	ADDC(sum, T0)
+	ADDC(sum, T1)
+	LONG_SUBU	a1, a1, 0x10
+	PTR_ADDU	src, src, 0x10
+	LONG_SRL	t8, a1, 0x7
+
+begin_movement:
+	beqz	t8, 1f
+	 andi	T2, a1, 0x40
+
+move_128bytes:
+	CSUM_BIGCHUNK(src, 0x00, sum, T0, T1, T3, T4)
+	CSUM_BIGCHUNK(src, 0x20, sum, T0, T1, T3, T4)
+	CSUM_BIGCHUNK(src, 0x40, sum, T0, T1, T3, T4)
+	CSUM_BIGCHUNK(src, 0x60, sum, T0, T1, T3, T4)
+	LONG_SUBU	t8, t8, 0x01
+	bnez	t8, move_128bytes
+	 PTR_ADDU	src, src, 0x80
+
+1:
+	beqz	T2, 1f
+	 andi	T2, a1, 0x20
+
+move_64bytes:
+	CSUM_BIGCHUNK(src, 0x00, sum, T0, T1, T3, T4)
+	CSUM_BIGCHUNK(src, 0x20, sum, T0, T1, T3, T4)
+	PTR_ADDU	src, src, 0x40
+
+1:
+	beqz	T2, do_end_words
+	 andi	t8, a1, 0x1c
+
+move_32bytes:
+	CSUM_BIGCHUNK(src, 0x00, sum, T0, T1, T3, T4)
+	andi	t8, a1, 0x1c
+	PTR_ADDU	src, src, 0x20
+
+do_end_words:
+	beqz	t8, maybe_end_cruft
+	 LONG_SRL	t8, t8, 0x2
+
+end_words:
+	lw	T0, (src)
+	LONG_SUBU	t8, t8, 0x1
+	ADDC(sum, T0)
+	bnez	t8, end_words
+	 PTR_ADDU	src, src, 0x4
+
+maybe_end_cruft:
+	andi	T2, a1, 0x3
+
+small_memcpy:
+ j small_csumcpy; move a1, T2		/* XXX ??? */
+	beqz	t2, out
+	 move	a1, T2
+
+end_bytes:
+	lb	T0, (src)
+	LONG_SUBU	a1, a1, 0x1
+	bnez	a2, end_bytes
+	 PTR_ADDU	src, src, 0x1
+
+out:
+	jr	ra
+	 move	v0, sum
+	END(csum_partial)
