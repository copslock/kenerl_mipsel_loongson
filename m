Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 07 Jul 2006 17:11:43 +0100 (BST)
Received: from mba.ocn.ne.jp ([210.190.142.172]:65221 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S8133498AbWGGQLd (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 7 Jul 2006 17:11:33 +0100
Received: from localhost (p1163-ipad206funabasi.chiba.ocn.ne.jp [222.146.104.163])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id 040B4A14F; Sat,  8 Jul 2006 01:11:29 +0900 (JST)
Date:	Sat, 08 Jul 2006 01:12:45 +0900 (JST)
Message-Id: <20060708.011245.82794581.anemo@mba.ocn.ne.jp>
To:	macro@linux-mips.org
Cc:	linux-mips@linux-mips.org, ralf@linux-mips.org
Subject: Re: [PATCH] fast path for rdhwr emulation for TLS
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <Pine.LNX.4.64N.0607071607520.25285@blysk.ds.pg.gda.pl>
References: <20060708.000032.88471510.anemo@mba.ocn.ne.jp>
	<Pine.LNX.4.64N.0607071607520.25285@blysk.ds.pg.gda.pl>
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
X-archive-position: 11938
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

On Fri, 7 Jul 2006 16:22:46 +0100 (BST), "Maciej W. Rozycki" <macro@linux-mips.org> wrote:
> > +	.align	5
> > +	LEAF(handle_ri)
> > +	.set	push
> > +	.set	noat
> > +	mfc0	k0, CP0_CAUSE
> > +	MFC0	k1, CP0_EPC
> > +	bltz	k0, handle_ri_slow	/* if delay slot */
> > +	lw	k0, (k1)
> 
>  For a VIVT I-cache this can result in a TLB exception.  TLB handlers are 
> not currently prepared for being called at the exception level.

Thanks, now I understand the problem.  Are there any good solutions?
Only I can think now is using handle_ri_slow for such CPUs.

>  Also I am fairly sure gas won't fill the branch delay slot above -- a 
> trivial rearrangement of code would save a cycle here (and this is a fast 
> path, so we do not want wasting time).

Well, here is a code compiled by binutils 2.17.  This version of gas
can put MFC0 on the delay slot.  But it might be better to use
noreorder by myself.

80012a80 <handle_ri>:
80012a80:	401a6800 	mfc0	k0,c0_cause
80012a84:	0740fd2e 	bltz	k0,80011f40 <handle_ri_slow>
80012a88:	401b7000 	mfc0	k1,c0_epc
80012a8c:	8f7a0000 	lw	k0,0(k1)
80012a90:	3c1b7c03 	lui	k1,0x7c03
80012a94:	377be83b 	ori	k1,k1,0xe83b
80012a98:	175bfd29 	bne	k0,k1,80011f40 <handle_ri_slow>
80012a9c:	00000000 	nop
80012aa0:	3c1b801b 	lui	k1,0x801b
80012aa4:	8f7b4008 	lw	k1,16392(k1)
80012aa8:	401a7000 	mfc0	k0,c0_epc
80012aac:	275a0004 	addiu	k0,k0,4
80012ab0:	409a7000 	mtc0	k0,c0_epc
80012ab4:	377b1fff 	ori	k1,k1,0x1fff
80012ab8:	3b7b1fff 	xori	k1,k1,0x1fff
80012abc:	8f63000c 	lw	v1,12(k1)
80012ac0:	42000018 	eret

> > +	li	k1, 0x7c03e83b	/* rdhwr v1,$29 */
> > +	bne	k0, k1, handle_ri_slow	/* if not ours */
> > +	get_saved_sp	/* k1 := current_thread_info */
> > +	MFC0	k0, CP0_EPC
> > +	LONG_ADDIU	k0, 4
> 
>  I suggest moving MFC0 ahead of get_saved_sp to avoid a stall.  I would 
> fit in the branch delay slot nicely.

The MFC0 can not be moved.  SMP version of get_saved_sp uses k0 and
k1.  But of course I can use #ifdef CONFIG_SMP, but these assumption
makes the code a bit fragile.  Another performance vs. maintainance
cost issue...

---
Atsushi Nemoto
