Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 02 Jul 2008 11:31:44 +0100 (BST)
Received: from topsns2.toshiba-tops.co.jp ([202.230.225.126]:47559 "EHLO
	topsns2.toshiba-tops.co.jp") by ftp.linux-mips.org with ESMTP
	id S62065862AbYGBKbl (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 2 Jul 2008 11:31:41 +0100
Received: from no.name.available by topsns2.toshiba-tops.co.jp
          via smtpd (for ftp.linux-mips.org [213.58.128.207]) with ESMTP; Wed, 2 Jul 2008 19:31:39 +0900
Received: from topsms.toshiba-tops.co.jp (localhost.localdomain [127.0.0.1])
	by localhost.toshiba-tops.co.jp (Postfix) with ESMTP id 5C8C644FDF;
	Wed,  2 Jul 2008 19:31:34 +0900 (JST)
Received: from srd2sd.toshiba-tops.co.jp (srd2sd.toshiba-tops.co.jp [172.17.28.2])
	by topsms.toshiba-tops.co.jp (Postfix) with ESMTP id 51B9C18602;
	Wed,  2 Jul 2008 19:31:34 +0900 (JST)
Received: from localhost (fragile [172.17.28.65])
	by srd2sd.toshiba-tops.co.jp (8.12.10/8.12.10) with ESMTP id m62AVXfl091762;
	Wed, 2 Jul 2008 19:31:33 +0900 (JST)
	(envelope-from anemo@mba.ocn.ne.jp)
Date:	Wed, 02 Jul 2008 19:31:33 +0900 (JST)
Message-Id: <20080702.193133.211490377.nemoto@toshiba-tops.co.jp>
To:	ths@networkno.de
Cc:	mlarsen@broadcom.com, linux-mips@linux-mips.org
Subject: Re: Bug in atomic_sub_if_positive
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <20080702095955.GA7007@networkno.de>
References: <ADD7831BD377A74E9A1621D1EAAED18F0450AC61@NT-SJCA-0750.brcm.ad.broadcom.com>
	<20080702095955.GA7007@networkno.de>
X-Fingerprint: 6ACA 1623 39BD 9A94 9B1A  B746 CA77 FE94 2874 D52F
X-Pgp-Public-Key: http://wwwkeys.pgp.net/pks/lookup?op=get&search=0x2874D52F
X-Mailer: Mew version 6.1 on Emacs 22.2 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <anemo@mba.ocn.ne.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 19692
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

On Wed, 2 Jul 2008 10:59:56 +0100, Thiemo Seufer <ths@networkno.de> wrote:
> > --- a/include/asm-mips/atomic.h	2008-06-25 22:38:43.159739000 -0700
> > +++ b/include/asm-mips/atomic.h	2008-06-25 22:39:07.552065000 -0700
> > @@ -292,10 +292,10 @@ static __inline__ int atomic_sub_if_posi
> >  		"	beqz	%0, 2f					\n"
> >  		"	 subu	%0, %1, %3				\n"
> >  		"	.set	reorder					\n"
> > -		"1:							\n"
> >  		"	.subsection 2					\n"
> >  		"2:	b	1b					\n"
> >  		"	.previous					\n"
> > +		"1:							\n"
> 
> AFAICS this change should make no difference to the generated code. I
> suspect you assembler handles .subsection incorrectly. Can you provide
> a disassembled exapmle which gets altered by this patch? Also, please
> tell us the exact version of the assembler you use.

Why no defference?  The '1b' in subsection refer backword '1' label on
the source code (which is a label for LL insn in this case with the
patch) ?

Anyway I can provide them.  I'm using vanilla 2.17 and 2.18.

Without the patch:
801233bc <try_acquire_console_sem>:
801233bc:	lui	v0,0x8038
801233c0:	ll	a0,31976(v0)
801233c4:	addiu	v1,a0,-1
801233c8:	bltz	v1,801233dc <try_acquire_console_sem+0x20>
801233cc: 	nop
801233d0: 	sc	v1,31976(v0)
801233d4: 	beqz	v1,80124dac <sys_syslog+0x8>
801233d8: 	addiu	v1,a0,-1
801233dc: 	bltz	v1,801233fc <try_acquire_console_sem+0x40>
801233e0: 	li	v0,-1
...
80124dac:	b	801233dc <try_acquire_console_sem+0x20>
80124db0:	nop

With the patch:
801233bc <try_acquire_console_sem>:
801233bc:	lui	v0,0x8038
801233c0:	ll	a0,31976(v0)
801233c4:	addiu	v1,a0,-1
801233c8:	bltz	v1,801233dc <try_acquire_console_sem+0x20>
801233cc:	nop
801233d0:	sc	v1,31976(v0)
801233d4:	beqz	v1,80124dac <sys_syslog+0x8>
801233d8:	addiu	v1,a0,-1
801233dc:	bltz	v1,801233fc <try_acquire_console_sem+0x40>
801233e0:	li	v0,-1
...
80124dac:	b	801233c0 <try_acquire_console_sem+0x4>
80124db0:	nop


The patch looks correct.

---
Atsushi Nemoto
