Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 14 Oct 2002 18:35:09 +0200 (CEST)
Received: from dell-paw-3.cambridge.redhat.com ([195.224.55.237]:4851 "EHLO
	executor.cambridge.redhat.com") by linux-mips.org with ESMTP
	id <S1122169AbSJNQfI>; Mon, 14 Oct 2002 18:35:08 +0200
Received: from talisman.cambridge.redhat.com (talisman.cambridge.redhat.com [172.16.18.81])
	by executor.cambridge.redhat.com (Postfix) with ESMTP
	id ECFA5ABAF8; Mon, 14 Oct 2002 17:35:00 +0100 (BST)
Received: (from rsandifo@localhost)
	by talisman.cambridge.redhat.com (8.11.6/8.11.0) id g9EGZ0h20736;
	Mon, 14 Oct 2002 17:35:00 +0100
X-Authentication-Warning: talisman.cambridge.redhat.com: rsandifo set sender to rsandifo@redhat.com using -f
To: "H. J. Lu" <hjl@lucon.org>
Cc: aoliva@redhat.com, linux-mips@linux-mips.org, gcc@gcc.gnu.org,
	binutils@sources.redhat.com
Subject: Re: MIPS gas relaxation still doesn't work
References: <20021012113423.A27894@lucon.org>
	<20021013145423.A10174@lucon.org> <20021014082810.A28682@lucon.org>
	<wvnit05ovct.fsf@talisman.cambridge.redhat.com>
	<20021014091649.A29353@lucon.org>
From: Richard Sandiford <rsandifo@redhat.com>
Date: 14 Oct 2002 17:35:00 +0100
In-Reply-To: <20021014091649.A29353@lucon.org>
Message-ID: <wvnfzv9ou6j.fsf@talisman.cambridge.redhat.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-Path: <rsandifo@redhat.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 419
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: rsandifo@redhat.com
Precedence: bulk
X-list: linux-mips

"H. J. Lu" <hjl@lucon.org> writes:
> > gcc is usually much better at filling delay slots than gas is.  gas just
> > looks at the previous instruction to see if it's suitable.  gcc can pull
> > pull instructions from the branch target instead.
> 
> I don't think so. Please check out g++.dg/opt/longbranch1.C. gcc 3.2
> generates:
> 
> $L7488:
>         lw      $2,52($fp)
>         .set    noreorder
>         .set    nomacro
> 
>         bne     $2,$0,$L7493
>         nop
>         j       $L2
>         nop
> 
>         .set    macro
>         .set    reorder
> $L7493:
> 
> It is no better than gas and disables the branch relaxation. I don't
> why gcc shouldn't let gas handle it in this case. That is gcc should
> never fill the delay slot with nop.

Huh?  Obviously there are going to be cases when neither gcc nor
gas can fill a slot.  Just because you've found one doesn't mean
that gcc never fills a delay that gas wouldn't.  Compare gcc's
dbr_schedule with gas's append_insn.

The fact gcc fills this slot with a nop is just incidental.
gcc is not written on the assumption that the assembler will
relax branches.  It's easy to see it filling that slot with
a non-nop in other cases.  And, what's more, filling it with
a non-nop that gas wouldn't consider.

When you said:

> Can gcc be be modified not to generate noreorder/nomacro for branchs if
> gas is used?

you seemed to be arguing that gcc should start relying on
branch relaxation, but that really seems the wrong way to go.

Richard
