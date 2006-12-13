Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 13 Dec 2006 12:02:12 +0000 (GMT)
Received: from phoenix.bawue.net ([193.7.176.60]:36541 "EHLO mail.bawue.net")
	by ftp.linux-mips.org with ESMTP id S20037491AbWLMMCH (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 13 Dec 2006 12:02:07 +0000
Received: from lagash (intrt.mips-uk.com [194.74.144.130])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.bawue.net (Postfix) with ESMTP id 5B004BAA6D;
	Wed, 13 Dec 2006 12:56:53 +0100 (CET)
Received: from ths by lagash with local (Exim 4.63)
	(envelope-from <ths@networkno.de>)
	id 1GuSh4-0006pO-U2; Wed, 13 Dec 2006 11:54:38 +0000
Date:	Wed, 13 Dec 2006 11:54:38 +0000
To:	Dmitry Adamushko <dmitry.adamushko@gmail.com>
Cc:	linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>
Subject: Re: unwind_stack() and an exception at the last instruction (after the epilogue)
Message-ID: <20061213115438.GA25904@networkno.de>
References: <b647ffbd0612121342y5b188be0o5ccce1b2c57a9725@mail.gmail.com> <b647ffbd0612130307q4ea221d0l3daf34ef0048abcb@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b647ffbd0612130307q4ea221d0l3daf34ef0048abcb@mail.gmail.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
From:	Thiemo Seufer <ths@networkno.de>
Return-Path: <ths@networkno.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 13443
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ths@networkno.de
Precedence: bulk
X-list: linux-mips

Dmitry Adamushko wrote:
> [ resend: probably, my previouse one had been rejected as it was not
> in plain-text :]
> 
> 
> Hello,
> 
> unwind_stack() explicitly handles a case when an exception takes
> place at the first instruction, i.e. before the prologue.
> 
> But what's about another corner case - when an exception is caused by
> an instruction placed after the epilogue.
> 
> example:
> 
> 00400e8c <cause_oops>:
>   400e8c:       3c1c0fc0        lui     gp,0xfc0
>   400e90:       279c71c4        addiu   gp,gp,29124
>   400e94:       0399e021        addu    gp,gp,t9
>   400e98:       27bdffe0        addiu   sp,sp,-32
>   400e9c:       afbf0018        sw      ra,24(sp)
>   400ea0:       afbc0010        sw      gp,16(sp)
>   400ea4:       8f84801c        lw      a0,-32740(gp)
>   400ea8:       8f9980ac        lw      t9,-32596(gp)
>   400eac:       00000000        nop
>   400eb0:       0320f809        jalr    t9
>   400eb4:       24841984        addiu   a0,a0,6532
>   400eb8:       8fbc0010        lw      gp,16(sp)
>   400ebc:       8fbf0018        lw      ra,24(sp)
>   400ec0:       27bd0020        addiu   sp,sp,32
>   400ec4:       03e00008        jr      ra
>   400ec8:       ac000000        sw      zero,0(zero)
> <----------- <epc> will be here when an exception happens

Was this example generated by a real world compiler? (Which one?)

> In this case, <sp> already points to the caller's stack frame so
> unwind_stack() will take a wrong assumption (as it looks at the
> epilogue of the callee).
> 
> btw, the first and last instructions are just corner cases of an
> instruction being placed before the prologue and after the epilogue,
> right?
> 
> so something like
> 
> - if (unlikely(ofs == 0)) {
> + if (unlikely(offs == 0 || offs == size - sizeof_mips_instruction))
>         pc = *ra;
>         *ra = 0;
>         return pc;
> }
> 
> won't be a generic solution.
> 
> Did I miss something? Hm... <epc> is always guaranted to be right
> when the instruction is in the branch delay slot?
> 
> p.s. yep, the example is a part of user-space code (optimization:
> -Os) or is there anything (compiler options etc.) preventing similar
> code from being generated for kernel-space code?

I'm inclined to claim the example is broken WRT ABI rules since it
doesn't enclose the whole user code in the prologue/epilogue bracket.


Thiemo
