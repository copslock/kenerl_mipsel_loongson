Received:  by oss.sgi.com id <S553879AbQKCVGL>;
	Fri, 3 Nov 2000 13:06:11 -0800
Received: from u-120.karlsruhe.ipdial.viaginterkom.de ([62.180.10.120]:53266
        "EHLO u-120.karlsruhe.ipdial.viaginterkom.de") by oss.sgi.com
	with ESMTP id <S553877AbQKCVGC>; Fri, 3 Nov 2000 13:06:02 -0800
Received: (ralf@lappi) by lappi.waldorf-gmbh.de id <S869091AbQKCQSF>;
        Fri, 3 Nov 2000 17:18:05 +0100
Date:   Fri, 3 Nov 2000 17:18:05 +0100
From:   Ralf Baechle <ralf@oss.sgi.com>
To:     Ian Chilton <mailinglist@ichilton.co.uk>
Cc:     linux-mips@oss.sgi.com
Subject: Re: More GCC problems
Message-ID: <20001103171805.F24751@bacchus.dhis.org>
References: <20001103143725.A2123@woody.ichilton.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <20001103143725.A2123@woody.ichilton.co.uk>; from mailinglist@ichilton.co.uk on Fri, Nov 03, 2000 at 02:37:25PM +0000
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Fri, Nov 03, 2000 at 02:37:25PM +0000, Ian Chilton wrote:

> Hello,
> 
> > /tmp/cca08866.s: Assembler messages:
> > /tmp/cca08866.s:27593: Error: Branch out of range
> > /tmp/cca08866.s:27632: Error: Branch out of range
> > /tmp/cca08866.s:27637: Error: Branch out of range

This is a bug in all MIPS versions of gas I've ever examined, including the
vendors of GNU based development systems like Algorithmics.  The problem is
that gcc is producing code that results in loops of over 128kb size, so the
range of a normal branch is exceeded.  Gas should then convert assembler
code such as

loop:
	# > 128kb loop body
	bnez	reg, loop

into:

loop:
	# > 128kb loop body
	beq	reg, endloop
	jump	loop
endloop:

That's a non-trivial gas modification.

This is becoming an increasing problem with today's codesize.  Right now
only few applications are affected but Moore's law is mercyless ...

In this particular case I'll simply optimizing the code with -O1 or higher
will help by getting the loop body's size below 128kb size.  This may also
help with other affected packages.  It's however only a temporary solution;
we'll see code in the not to far future where the optimizer is no longer
able to get the code size below the critical size of 128kb.

  Ralf
