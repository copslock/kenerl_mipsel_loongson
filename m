Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 27 May 2003 10:53:38 +0100 (BST)
Received: from p508B77C3.dip.t-dialin.net ([IPv6:::ffff:80.139.119.195]:49359
	"EHLO dea.linux-mips.net") by linux-mips.org with ESMTP
	id <S8225232AbTE0Jxg>; Tue, 27 May 2003 10:53:36 +0100
Received: from dea.linux-mips.net (localhost [127.0.0.1])
	by dea.linux-mips.net (8.12.8/8.12.8) with ESMTP id h4R9rRbY023831;
	Tue, 27 May 2003 02:53:27 -0700
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.12.8/8.12.8/Submit) id h4R9rOxv023830;
	Tue, 27 May 2003 11:53:24 +0200
Date: Tue, 27 May 2003 11:53:24 +0200
From: Ralf Baechle <ralf@linux-mips.org>
To: Fuxin Zhang <fxzhang@ict.ac.cn>
Cc: MAKE FUN PRANK CALLS <linux-mips@linux-mips.org>
Subject: Re: about gas load_address
Message-ID: <20030527095324.GC23296@linux-mips.org>
References: <3ED33148.2040008@ict.ac.cn>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3ED33148.2040008@ict.ac.cn>
User-Agent: Mutt/1.4.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2457
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, May 27, 2003 at 05:35:04PM +0800, Fuxin Zhang wrote:
> Date:	Tue, 27 May 2003 17:35:04 +0800
> From:	Fuxin Zhang <fxzhang@ict.ac.cn>
> To:	MAKE FUN PRANK CALLS <linux-mips@linux-mips.org>
        ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Funny alias for this list :-)

> (sorry if it is somewhat out of topic,but i think most mips experts
> are here:)

Certainly more on topic than making prank calls ;-)

> else if (mips_pic == SVR4_PIC && ! mips_big_got)
> {
> expressionS ex;
> 
> /* If this is a reference to an external symbol, we want
> lw $reg,<sym>($gp) (BFD_RELOC_MIPS_GOT16)
> Otherwise we want
> lw $reg,<sym>($gp) (BFD_RELOC_MIPS_GOT16)
> nop
> QUESTION:
> Could somebody tell me why we generate a unconditional 'nop' here?
> addiu $reg,$reg,<sym> (BFD_RELOC_LO16)
> If there is a constant, it must be added in after.

The nop would only be needed for the R2000/R3000 family where a load
instruction may not immediately be followed by it's consumer instruction.
NewABI implies MIPS III or higher so the nop wouldn't be required for
such processors.  Gcc and gas have sort of a tradition of throwing many
more nops in than needed ...

> If we have NewABI, we want
> lw $reg,<sym+cst>($gp) (BFD_RELOC_MIPS_GOT_DISP)
> unless we're referencing a global symbol with a non-zero
> offset, in which case cst must be added separately. */

  Ralf
