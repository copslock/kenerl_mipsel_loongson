Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 07 Dec 2006 16:05:10 +0000 (GMT)
Received: from mba.ocn.ne.jp ([210.190.142.172]:25570 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S20037652AbWLGQEt (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 7 Dec 2006 16:04:49 +0000
Received: from localhost (p8245-ipad29funabasi.chiba.ocn.ne.jp [221.184.75.245])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id E40FFB64F; Fri,  8 Dec 2006 01:04:45 +0900 (JST)
Date:	Fri, 08 Dec 2006 01:04:45 +0900 (JST)
Message-Id: <20061208.010445.07456436.anemo@mba.ocn.ne.jp>
To:	linux-mips@linux-mips.org
Cc:	ralf@linux-mips.org
Subject: [PATCH 2/3] Optimize flow of csum_partial
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
X-archive-position: 13405
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

Delete dead codes at end of the function and move small_csumcopy
there.  This makes some labels (maybe_end_cruft, small_memcpy,
end_bytes, out) needless and eliminates some branches.

Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
---
diff --git a/arch/mips/lib/csum_partial.S b/arch/mips/lib/csum_partial.S
index 3bffdbb..b04475d 100644
--- a/arch/mips/lib/csum_partial.S
+++ b/arch/mips/lib/csum_partial.S
@@ -65,64 +65,6 @@ #define sum v0
 
 	.text
 	.set	noreorder
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
-	PTR_ADDIU	src, 4
-	ADDC(sum, t1)
-
-1:	move	t1, zero
-	beqz	t0, 1f
-	 andi	t0, a1, 1
-
-	/* Still a halfword to go  */
-	ulhu	t1, (src)
-	PTR_ADDIU	src, 2
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
 	.align	5
 LEAF(csum_partial)
 	move	sum, zero
@@ -132,8 +74,7 @@ LEAF(csum_partial)
 	bnez	t8, small_csumcpy		/* < 8 bytes to copy */
 	 move	t2, a1
 
-	beqz	a1, out
-	 andi	t7, src, 0x1			/* odd buffer? */
+	andi	t7, src, 0x1			/* odd buffer? */
 
 hword_align:
 	beqz	t7, word_align
@@ -232,8 +173,9 @@ move_32bytes:
 	PTR_ADDU	src, src, 0x20
 
 do_end_words:
-	beqz	t8, maybe_end_cruft
-	 LONG_SRL	t8, t8, 0x2
+	beqz	t8, small_csumcpy
+	 andi	t2, a1, 0x3
+	LONG_SRL	t8, t8, 0x2
 
 end_words:
 	lw	t0, (src)
@@ -242,21 +184,58 @@ end_words:
 	bnez	t8, end_words
 	 PTR_ADDU	src, src, 0x4
 
-maybe_end_cruft:
-	andi	t2, a1, 0x3
+/* unknown src alignment and < 8 bytes to go  */
+small_csumcpy:
+	move	a1, t2
 
-small_memcpy:
- j small_csumcpy; move a1, t2		/* XXX ??? */
-	beqz	t2, out
-	 move	a1, t2
+	andi	t0, a1, 4
+	beqz	t0, 1f
+	 andi	t0, a1, 2
 
-end_bytes:
-	lb	t0, (src)
-	LONG_SUBU	a1, a1, 0x1
-	bnez	a2, end_bytes
-	 PTR_ADDU	src, src, 0x1
+	/* Still a full word to go  */
+	ulw	t1, (src)
+	PTR_ADDIU	src, 4
+	ADDC(sum, t1)
+
+1:	move	t1, zero
+	beqz	t0, 1f
+	 andi	t0, a1, 1
+
+	/* Still a halfword to go  */
+	ulhu	t1, (src)
+	PTR_ADDIU	src, 2
+
+1:	beqz	t0, 1f
+	 sll	t1, t1, 16
+
+	lbu	t2, (src)
+	 nop
+
+#ifdef __MIPSEB__
+	sll	t2, t2, 8
+#endif
+	or	t1, t2
+
+1:	ADDC(sum, t1)
 
-out:
+	/* fold checksum */
+	sll	v1, sum, 16
+	addu	sum, v1
+	sltu	v1, sum, v1
+	srl	sum, sum, 16
+	addu	sum, v1
+
+	/* odd buffer alignment? */
+	beqz	t7, 1f
+	 nop
+	sll	v1, sum, 8
+	srl	sum, sum, 8
+	or	sum, v1
+	andi	sum, 0xffff
+1:
+	.set	reorder
+	/* Add the passed partial csum.  */
+	ADDC(sum, a2)
 	jr	ra
-	 move	v0, sum
+	.set	noreorder
 	END(csum_partial)
