Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 03 Jun 2005 06:20:11 +0100 (BST)
Received: from optima.cs.arizona.edu ([IPv6:::ffff:192.12.69.5]:64264 "EHLO
	optima.cs.arizona.edu") by linux-mips.org with ESMTP
	id <S8225428AbVFCFTw>; Fri, 3 Jun 2005 06:19:52 +0100
Received: from lectura.CS.Arizona.EDU (lectura.cs.arizona.edu [192.12.69.186])
	by optima.cs.arizona.edu (8.13.3/8.13.3) with ESMTP id j535JiUZ064250
	for <linux-mips@linux-mips.org>; Thu, 2 Jun 2005 22:19:45 -0700 (MST)
	(envelope-from bprasad@CS.Arizona.EDU)
Date:	Thu, 2 Jun 2005 22:19:44 -0700 (MST)
From:	Prasad Venkata Boddupalli <bprasad@CS.Arizona.EDU>
To:	linux-mips@linux-mips.org
Subject: Reg checksum computation
Message-ID: <Pine.GSO.4.58.0506022145430.15064@lectura.CS.Arizona.EDU>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <bprasad@CS.Arizona.EDU>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8041
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: bprasad@CS.Arizona.EDU
Precedence: bulk
X-list: linux-mips

Hi, this regards the function 'csum_partial' that is in the file
linux/arch/mips/lib-64/csum_partial.S.

Towards the end, we label

maybe_end_cruft:
    andi     ta2, a1, 0x3

and then

small_memcpy:
     ...


The comments for small_csumcpy says: 'unknown src alignment and < 8 bytes
to go'.

But as I see the checksum computation for buffers containing fewer than 8
bytes is taken care at the beginning of the 'csum_partial' function. So,
what purpose is it serving at the end of 'csum_partial' ? Can someone
please clarify ?

thank you,
Prasad

-----------------------------------------------------------------------------

/*
 * a0: source address
 * a1: length of the area to checksum
 * a2: partial checksum
 */

#define src a0
#define sum v0

	.text
	.set	noreorder

/* unknown src alignment and < 8 bytes to go  */
small_csumcpy:
	move	a1, ta2

	andi	ta0, a1, 4
	beqz	ta0, 1f
	 andi	ta0, a1, 2

	/* Still a full word to go  */
	ulw	ta1, (src)
	daddiu	src, 4
	ADDC(sum, ta1)

1:	move	ta1, zero
	beqz	ta0, 1f
	 andi	ta0, a1, 1

	/* Still a halfword to go  */
	ulhu	ta1, (src)
	daddiu	src, 2

1:	beqz	ta0, 1f
	 sll	ta1, ta1, 16

	lbu	ta2, (src)
	 nop

#ifdef __MIPSEB__
	sll	ta2, ta2, 8
#endif
	or	ta1, ta2

1:	ADDC(sum, ta1)

	/* fold checksum */
	sll	v1, sum, 16
	addu	sum, v1
	sltu	v1, sum, v1
	srl	sum, sum, 16
	addu	sum, v1

	/* odd buffer alignment? */
	beqz	t3, 1f
	 nop
	sll	v1, sum, 8
	srl	sum, sum, 8
	or	sum, v1
	andi	sum, 0xffff
1:
	.set	reorder
	/* Add the passed partial csum.  */
	ADDC(sum, a2)
	jr	ra
	.set	noreorder

/* ------------------------------------------------------------------------- */

	.align	5
LEAF(csum_partial)
	move	sum, zero
	move	t3, zero

	sltiu	t8, a1, 0x8
	bnez	t8, small_csumcpy		/* < 8 bytes to copy */
	 move	ta2, a1

	beqz	a1, out
	 andi	t3, src, 0x1			/* odd buffer? */

hword_align:
	beqz	t3, word_align
	 andi	t8, src, 0x2

	lbu	ta0, (src)
	dsubu	a1, a1, 0x1
#ifdef __MIPSEL__
	sll	ta0, ta0, 8
#endif
	ADDC(sum, ta0)
	daddu	src, src, 0x1
	andi	t8, src, 0x2

word_align:
	beqz	t8, dword_align
	 sltiu	t8, a1, 56

	lhu	ta0, (src)
	dsubu	a1, a1, 0x2
	ADDC(sum, ta0)
	sltiu	t8, a1, 56
	daddu	src, src, 0x2

dword_align:
	bnez	t8, do_end_words
	 move	t8, a1

	andi	t8, src, 0x4
	beqz	t8, qword_align
	 andi	t8, src, 0x8

	lw	ta0, 0x00(src)
	dsubu	a1, a1, 0x4
	ADDC(sum, ta0)
	daddu	src, src, 0x4
	andi	t8, src, 0x8

qword_align:
	beqz	t8, oword_align
	 andi	t8, src, 0x10

	lw	ta0, 0x00(src)
	lw	ta1, 0x04(src)
	dsubu	a1, a1, 0x8
	ADDC(sum, ta0)
	ADDC(sum, ta1)
	daddu	src, src, 0x8
	andi	t8, src, 0x10

oword_align:
	beqz	t8, begin_movement
	 dsrl	t8, a1, 0x7

	lw	ta3, 0x08(src)
	lw	t0, 0x0c(src)
	lw	ta0, 0x00(src)
	lw	ta1, 0x04(src)
	ADDC(sum, ta3)
	ADDC(sum, t0)
	ADDC(sum, ta0)
	ADDC(sum, ta1)
	dsubu	a1, a1, 0x10
	daddu	src, src, 0x10
	dsrl	t8, a1, 0x7

begin_movement:
	beqz	t8, 1f
	 andi	ta2, a1, 0x40

move_128bytes:
	CSUM_BIGCHUNK(src, 0x00, sum, ta0, ta1, ta3, t0)
	CSUM_BIGCHUNK(src, 0x20, sum, ta0, ta1, ta3, t0)
	CSUM_BIGCHUNK(src, 0x40, sum, ta0, ta1, ta3, t0)
	CSUM_BIGCHUNK(src, 0x60, sum, ta0, ta1, ta3, t0)
	dsubu	t8, t8, 0x01
	bnez	t8, move_128bytes
	 daddu	src, src, 0x80

1:
	beqz	ta2, 1f
	 andi	ta2, a1, 0x20

move_64bytes:
	CSUM_BIGCHUNK(src, 0x00, sum, ta0, ta1, ta3, t0)
	CSUM_BIGCHUNK(src, 0x20, sum, ta0, ta1, ta3, t0)
	daddu	src, src, 0x40

1:
	beqz	ta2, do_end_words
	 andi	t8, a1, 0x1c

move_32bytes:
	CSUM_BIGCHUNK(src, 0x00, sum, ta0, ta1, ta3, t0)
	andi	t8, a1, 0x1c
	daddu	src, src, 0x20

do_end_words:
	beqz	t8, maybe_end_cruft
	 dsrl	t8, t8, 0x2

end_words:
	lw	ta0, (src)
	dsubu	t8, t8, 0x1
	ADDC(sum, ta0)
	bnez	t8, end_words
	 daddu	src, src, 0x4

maybe_end_cruft:
	andi	ta2, a1, 0x3

small_memcpy:
 j small_csumcpy; move a1, ta2		/* XXX ??? */
	beqz	t2, out
	 move	a1, ta2

end_bytes:
	lb	ta0, (src)
	dsubu	a1, a1, 0x1
	bnez	a2, end_bytes
	 daddu	src, src, 0x1

out:
	jr	ra
	 move	v0, sum
	END(csum_partial)
