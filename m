Received:  by oss.sgi.com id <S553852AbRAIPUg>;
	Tue, 9 Jan 2001 07:20:36 -0800
Received: from brutus.conectiva.com.br ([200.250.58.146]:7417 "EHLO
        lappi.waldorf-gmbh.de") by oss.sgi.com with ESMTP
	id <S553840AbRAIPU1>; Tue, 9 Jan 2001 07:20:27 -0800
Received: (ralf@lappi.waldorf-gmbh.de) by bacchus.dhis.org
	id <S869786AbRAIPJ6>; Tue, 9 Jan 2001 13:09:58 -0200
Date:	Tue, 9 Jan 2001 13:09:58 -0200
From:	Ralf Baechle <ralf@oss.sgi.com>
To:	"Kevin D. Kissell" <kevink@mips.com>
Cc:	"Florian Lohoff" <flo@rfc822.org>, <linux-mips@oss.sgi.com>
Subject: Re: MIPS32 patches breaking DecStation
Message-ID: <20010109130958.B1047@bacchus.dhis.org>
References: <20010109004101.B27674@paradigm.rfc822.org> <000501c079d3$fefe1a60$0deca8c0@Ulysses>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <000501c079d3$fefe1a60$0deca8c0@Ulysses>; from kevink@mips.com on Tue, Jan 09, 2001 at 01:34:47AM +0100
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Tue, Jan 09, 2001 at 01:34:47AM +0100, Kevin D. Kissell wrote:

> uses 3 or 4 nops instead of the branch to the instruction
> after the delay slot?   There was a reason that I eliminated
> the branch construct from the MIPS internal Linux source
> base - it's a hack that works perfectly on R4000's, but
> it's pretty much a coincidence that it does so.  Yes,
> the code fragment in question is R4K-specific, but
> we really need to migrate towards the use of consistent
> mechanisms that work across the full range of MIPS
> CPUs.  Ideally, *all* CP0 hazards should some day be 
> padded out with "ssnops" (sll $0,$0,1, if I recall), which 
> force a 1 cycle delay per instruction even on superscalar 
> MIPS CPUs.

While we could come up with a common TLB fault handler I really don't want
to.  For many applications this TLB fault handler is extremly performance
sensitive; every single cycle directly translates into application
performance.  Seems like we'll need some more TLB fault handler.  And a
complete TLB fault handler rewrite would be a good ide anyway, sigh ...

  Ralf
