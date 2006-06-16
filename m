Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 16 Jun 2006 16:57:57 +0100 (BST)
Received: from mba.ocn.ne.jp ([210.190.142.172]:16368 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S8133788AbWFPP5t (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 16 Jun 2006 16:57:49 +0100
Received: from localhost (p7155-ipad213funabasi.chiba.ocn.ne.jp [124.85.72.155])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id C79A6A940; Sat, 17 Jun 2006 00:57:41 +0900 (JST)
Date:	Sat, 17 Jun 2006 00:58:45 +0900 (JST)
Message-Id: <20060617.005845.93020013.anemo@mba.ocn.ne.jp>
To:	dan@debian.org
Cc:	libc-ports@sourceware.org, linux-mips@linux-mips.org
Subject: Re: mips RDHWR instruction in glibc
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <20060615153252.GA21598@nevyn.them.org>
References: <20060614165040.GA19480@nevyn.them.org>
	<20060616.002837.59465125.anemo@mba.ocn.ne.jp>
	<20060615153252.GA21598@nevyn.them.org>
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
X-archive-position: 11747
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

On Thu, 15 Jun 2006 11:32:52 -0400, Daniel Jacobowitz <dan@debian.org> wrote:
> > I also found a "rdhwr" in gcc's mips.md file ("tls_get_tp_<mode>").
> > Is this the origin?  MD is a very foreign language for me...
> 
> Yes.  Compile something like this with -O2 but without -fpic:
> 
> __thread int x;
> int foo() { return x; }
> 
> It should use the IE model, which will generate a rdhwr.

Thanks.  So this must be a gcc issue, not glibc issue.

extern __thread int x;
int foo(int arg)
{
	if (arg)
		return x;
	return 0;
}

If I compiled this program with -O2 I got:

foo:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, gp= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	.set	noreorder
	.cpload	$25
	.set	nomacro
	
	lw	$2,%gottprel(x)($28)
	.set	push
	.set	mips32r2	
	rdhwr	$3,$29
	.set	pop
	addu	$2,$2,$3
	beq	$4,$0,$L4
	move	$3,$0

	lw	$3,0($2)
$L4:
	j	$31
	move	$2,$3

It looks too bad for arg == 0 case.  I should ask on gcc list.

---
Atsushi Nemoto
