Received:  by oss.sgi.com id <S553915AbRCHQn7>;
	Thu, 8 Mar 2001 08:43:59 -0800
Received: from enst.enst.fr ([137.194.2.16]:25324 "HELO enst.enst.fr")
	by oss.sgi.com with SMTP id <S553903AbRCHQnj>;
	Thu, 8 Mar 2001 08:43:39 -0800
Received: from email.enst.fr (muse.enst.fr [137.194.2.33])
	by enst.enst.fr (Postfix) with ESMTP id E89431C956
	for <linux-mips@oss.sgi.com>; Thu,  8 Mar 2001 17:43:32 +0100 (MET)
Received: from donjuan.enst.fr (donjuan.enst.fr [137.194.168.21])
	by email.enst.fr (8.9.3/8.9.3) with ESMTP id RAA12807
	for <linux-mips@oss.sgi.com>; Thu, 8 Mar 2001 17:43:32 +0100 (MET)
Received: from localhost (bellard@localhost)
	by donjuan.enst.fr (8.9.3+Sun/8.9.3) with SMTP id RAA09721
	for <linux-mips@oss.sgi.com>; Thu, 8 Mar 2001 17:43:31 +0100 (MET)
Date:   Thu, 8 Mar 2001 17:43:31 +0100 (MET)
From:   Fabrice Bellard <bellard@email.enst.fr>
To:     linux-mips@oss.sgi.com
Subject: mips gcc 2.95.2 and 2.91.66 bug
In-Reply-To: <3AA7B13F.F918E1F8@ti.com>
Message-ID: <Pine.GSO.4.02.10103081721360.9471-100000@donjuan.enst.fr>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

Hi!

Maybe this bug can interest you: when using byte swaping in le16_to_cpu
for example, mips gcc 2.95.2 and 2.91.66 sometime do not generate correct
code : the u16 to u32 convertion is missing. I found this bug while
compiling drivers/mtd/ftl.c in build_maps(). Here is a sample source to
reproduce the bug:

typedef unsigned short __u16;

extern __inline__ __const__ __u16 le16_to_cpu(__u16 x)
{
    return ((__u16)( \
		(((__u16)(x) & (__u16)0x00ffU) << 8) | \
		(((__u16)(x) & (__u16)0xff00U) >> 8) ));
}

int test(int xtrans, int xvalid, __u16 *ptr)
{
    if ((xvalid+xtrans != le16_to_cpu(*ptr))) {
	return -1;
    }
    return 0;
}

The generated asm is :

test:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0,
extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	.set	noreorder
	.cpload	$25
	.set	reorder
	lhu	$3,0($7)
	addu	$5,$6,$5
	sll	$4,$3,8
	srl	$3,$3,8
	or	$4,$4,$3
	.set	noreorder
	.set	nomacro
	bne	$5,$4,$L7
	li	$2,-1			# 0xffffffff
	.set	macro
	.set	reorder

	move	$2,$0
$L7:
	j	$31
	.end	test

The andi op is missing.

egcs-1.0.3 seems to be OK.

I have no experience in submitting gcc bugs, so if someone could forward
this mail to the relevant gcc mailing list...

Fabrice.
