Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 02 Jul 2008 11:52:10 +0100 (BST)
Received: from relay01.mx.bawue.net ([193.7.176.67]:43964 "EHLO
	relay01.mx.bawue.net") by ftp.linux-mips.org with ESMTP
	id S62068190AbYGBKwB (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 2 Jul 2008 11:52:01 +0100
Received: from lagash (88-106-136-149.dynamic.dsl.as9105.com [88.106.136.149])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by relay01.mx.bawue.net (Postfix) with ESMTP id 5108548918;
	Wed,  2 Jul 2008 12:51:56 +0200 (CEST)
Received: from ths by lagash with local (Exim 4.69)
	(envelope-from <ths@networkno.de>)
	id 1KDzwJ-0002F6-Er; Wed, 02 Jul 2008 11:51:55 +0100
Date:	Wed, 2 Jul 2008 11:51:55 +0100
From:	Thiemo Seufer <ths@networkno.de>
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Cc:	mlarsen@broadcom.com, linux-mips@linux-mips.org
Subject: Re: Bug in atomic_sub_if_positive
Message-ID: <20080702105155.GC7007@networkno.de>
References: <ADD7831BD377A74E9A1621D1EAAED18F0450AC61@NT-SJCA-0750.brcm.ad.broadcom.com> <20080702095955.GA7007@networkno.de> <20080702.193133.211490377.nemoto@toshiba-tops.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20080702.193133.211490377.nemoto@toshiba-tops.co.jp>
User-Agent: Mutt/1.5.18 (2008-05-17)
Return-Path: <ths@networkno.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 19693
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ths@networkno.de
Precedence: bulk
X-list: linux-mips

Atsushi Nemoto wrote:
> On Wed, 2 Jul 2008 10:59:56 +0100, Thiemo Seufer <ths@networkno.de> wrote:
> > > --- a/include/asm-mips/atomic.h	2008-06-25 22:38:43.159739000 -0700
> > > +++ b/include/asm-mips/atomic.h	2008-06-25 22:39:07.552065000 -0700
> > > @@ -292,10 +292,10 @@ static __inline__ int atomic_sub_if_posi
> > >  		"	beqz	%0, 2f					\n"
> > >  		"	 subu	%0, %1, %3				\n"
> > >  		"	.set	reorder					\n"
> > > -		"1:							\n"
> > >  		"	.subsection 2					\n"
> > >  		"2:	b	1b					\n"
> > >  		"	.previous					\n"
> > > +		"1:							\n"
> > 
> > AFAICS this change should make no difference to the generated code. I
> > suspect you assembler handles .subsection incorrectly. Can you provide
> > a disassembled exapmle which gets altered by this patch? Also, please
> > tell us the exact version of the assembler you use.
> 
> Why no defference?  The '1b' in subsection refer backword '1' label on
> the source code (which is a label for LL insn in this case with the
> patch) ?

Oh. Now that you spelled it out I see it, too. :-)

> Anyway I can provide them.  I'm using vanilla 2.17 and 2.18.
> 
> Without the patch:
> 801233bc <try_acquire_console_sem>:
> 801233bc:	lui	v0,0x8038
> 801233c0:	ll	a0,31976(v0)
> 801233c4:	addiu	v1,a0,-1
> 801233c8:	bltz	v1,801233dc <try_acquire_console_sem+0x20>
> 801233cc: 	nop
> 801233d0: 	sc	v1,31976(v0)
> 801233d4: 	beqz	v1,80124dac <sys_syslog+0x8>
> 801233d8: 	addiu	v1,a0,-1
> 801233dc: 	bltz	v1,801233fc <try_acquire_console_sem+0x40>
> 801233e0: 	li	v0,-1
> ...
> 80124dac:	b	801233dc <try_acquire_console_sem+0x20>
> 80124db0:	nop
> 
> With the patch:
> 801233bc <try_acquire_console_sem>:
> 801233bc:	lui	v0,0x8038
> 801233c0:	ll	a0,31976(v0)
> 801233c4:	addiu	v1,a0,-1
> 801233c8:	bltz	v1,801233dc <try_acquire_console_sem+0x20>
> 801233cc:	nop
> 801233d0:	sc	v1,31976(v0)
> 801233d4:	beqz	v1,80124dac <sys_syslog+0x8>
> 801233d8:	addiu	v1,a0,-1
> 801233dc:	bltz	v1,801233fc <try_acquire_console_sem+0x40>
> 801233e0:	li	v0,-1
> ...
> 80124dac:	b	801233c0 <try_acquire_console_sem+0x4>
> 80124db0:	nop
> 
> 
> The patch looks correct.

Agreed.


Thiemo
