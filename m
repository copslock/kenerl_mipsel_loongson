Received:  by oss.sgi.com id <S553930AbRAIUEh>;
	Tue, 9 Jan 2001 12:04:37 -0800
Received: from brutus.conectiva.com.br ([200.250.58.146]:23287 "EHLO
        lappi.waldorf-gmbh.de") by oss.sgi.com with ESMTP
	id <S553926AbRAIUEc>; Tue, 9 Jan 2001 12:04:32 -0800
Received: (ralf@lappi.waldorf-gmbh.de) by bacchus.dhis.org
	id <S870734AbRAITyQ>; Tue, 9 Jan 2001 17:54:16 -0200
Date:	Tue, 9 Jan 2001 17:54:16 -0200
From:	Ralf Baechle <ralf@oss.sgi.com>
To:	"Kevin D. Kissell" <kevink@mips.com>
Cc:	"Harald Koerfgen" <Harald.Koerfgen@home.ivm.de>,
        <linux-mips@oss.sgi.com>
Subject: Re: MIPS32 patches breaking DecStation
Message-ID: <20010109175416.A5383@bacchus.dhis.org>
References: <20010109095438.A10683@paradigm.rfc822.org> <XFMail.010109181100.Harald.Koerfgen@home.ivm.de> <20010109162835.B4232@bacchus.dhis.org> <019901c07a72$94d19f00$0deca8c0@Ulysses>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <019901c07a72$94d19f00$0deca8c0@Ulysses>; from kevink@mips.com on Tue, Jan 09, 2001 at 08:30:05PM +0100
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Tue, Jan 09, 2001 at 08:30:05PM +0100, Kevin D. Kissell wrote:

> My point is that an SSNOP should cause a 1 cycle stall on *any* MIPS
> implementation to date, superscalar or not.  It's not documented that
> way for the R10000, but if I recall correctly, it works there too.  If one
> wants to standardize on a single mechanism, that's the one to use.
> That's all I'm saying.

I agree on that - except that I haven't seen the various various flavours
of nops documented anywhere except in IRIX's <sys/asm.h> ...

> > Also note that the branch is equivalent to three nops.  One for the
> > branch instruction itself, the two more for instructions in the pipeline
> > that get killed.  On the R4600 / R500 where the hazard is only a single
> > instruction the branch is equivalent to only a single nop.  So while
> > unobvious the branch is a rather neat idea.
> 
> Yes, it's cute, but it relies on accidents of implementation to work,
> and could easily fail on other CPUs otherwise compatible with
> the R4000.  In principle, such a branch might incur no delay at
> all on an advanced 64-bit processor.  By all means, use it for
> the specific cases of the CPUs on which it is known to work,
> but it should not be used in "default" MIPS CP0 handlers.

This behaviour of the R4000 branch is documented in the R4000 manual's
description of the pipeline.

  Ralf
