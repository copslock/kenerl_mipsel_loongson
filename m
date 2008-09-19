From: Ralf Baechle <ralf@linux-mips.org>
Date: Fri, 19 Sep 2008 14:05:53 +0200
Subject: [PATCH] [MIPS] Fix 64-bit csum_partial, __csum_partial_copy_user and csum_partial_copy
Message-ID: <20080919120553.0pW8A0EArjhjVUThPxvPbQgjHhgSG81c6NRyUV5PBbY@z>

On 64-bit machines it wouldn't handle a possible carry when adding the
32-bit folded checksum and checksum argument.

While at it, add a few trivial optimizations, also for R2 processors.

Signed-off-by: Ralf Baechle <ralf@linux-mips.org>

diff --git a/arch/mips/lib/csum_partial.S b/arch/mips/lib/csum_partial.S
index 8d77841..c77a7a0 100644
--- a/arch/mips/lib/csum_partial.S
+++ b/arch/mips/lib/csum_partial.S
@@ -53,12 +53,14 @@
 #define UNIT(unit)  ((unit)*NBYTES)
 
 #define ADDC(sum,reg)						\
-	.set	push;						\
-	.set	noat;						\
 	ADD	sum, reg;					\
 	sltu	v1, sum, reg;					\
 	ADD	sum, v1;					\
-	.set	pop
+
+#define ADDC32(sum,reg)						\
+	addu	sum, reg;					\
+	sltu	v1, sum, reg;					\
+	addu	sum, v1;					\
 
 #define CSUM_BIGCHUNK1(src, offset, sum, _t0, _t1, _t2, _t3)	\
 	LOAD	_t0, (offset + UNIT(0))(src);			\
@@ -254,8 +256,6 @@ LEAF(csum_partial)
 1:	ADDC(sum, t1)
 
 	/* fold checksum */
-	.set	push
-	.set	noat
 #ifdef USE_DOUBLE
 	dsll32	v1, sum, 0
 	daddu	sum, v1
@@ -263,24 +263,25 @@ LEAF(csum_partial)
 	dsra32	sum, sum, 0
 	addu	sum, v1
 #endif
-	sll	v1, sum, 16
-	addu	sum, v1
-	sltu	v1, sum, v1
-	srl	sum, sum, 16
-	addu	sum, v1
 
 	/* odd buffer alignment? */
-	beqz	t7, 1f
-	 nop
-	sll	v1, sum, 8
+#ifdef CPU_MIPSR2
+	wsbh	v1, sum	
+	movn	sum, v1, t7
+#else
+	beqz	t7, 1f			/* odd buffer alignment? */
+	 lui	v1, 0x00ff
+	addu	v1, 0x00ff
+	and	t0, sum, v1
+	sll	t0, t0, 8
 	srl	sum, sum, 8
-	or	sum, v1
-	andi	sum, 0xffff
-	.set	pop
+	and	sum, sum, v1
+	or	sum, sum, t0
 1:
+#endif
 	.set	reorder
 	/* Add the passed partial csum.  */
-	ADDC(sum, a2)
+	ADDC32(sum, a2)
 	jr	ra
 	.set	noreorder
 	END(csum_partial)
@@ -656,8 +657,6 @@ EXC(	sb	t0, NBYTES-2(dst), .Ls_exc)
 	ADDC(sum, t2)
 .Ldone:
 	/* fold checksum */
-	.set	push
-	.set	noat
 #ifdef USE_DOUBLE
 	dsll32	v1, sum, 0
 	daddu	sum, v1
@@ -665,23 +664,23 @@ EXC(	sb	t0, NBYTES-2(dst), .Ls_exc)
 	dsra32	sum, sum, 0
 	addu	sum, v1
 #endif
-	sll	v1, sum, 16
-	addu	sum, v1
-	sltu	v1, sum, v1
-	srl	sum, sum, 16
-	addu	sum, v1
 
-	/* odd buffer alignment? */
-	beqz	odd, 1f
-	 nop
-	sll	v1, sum, 8
+#ifdef CPU_MIPSR2
+	wsbh	v1, sum
+	movn	sum, v1, odd
+#else
+	beqz	odd, 1f			/* odd buffer alignment? */
+	 lui	v1, 0x00ff
+	addu	v1, 0x00ff
+	and	t0, sum, v1
+	sll	t0, t0, 8
 	srl	sum, sum, 8
-	or	sum, v1
-	andi	sum, 0xffff
-	.set	pop
+	and	sum, sum, v1
+	or	sum, sum, t0
 1:
+#endif
 	.set reorder
-	ADDC(sum, psum)
+	ADDC32(sum, psum)
 	jr	ra
 	.set noreorder
 
