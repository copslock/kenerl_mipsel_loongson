Received:  by oss.sgi.com id <S553756AbRAII5x>;
	Tue, 9 Jan 2001 00:57:53 -0800
Received: from noose.gt.owl.de ([62.52.19.4]:51729 "HELO noose.gt.owl.de")
	by oss.sgi.com with SMTP id <S553751AbRAII52>;
	Tue, 9 Jan 2001 00:57:28 -0800
Received: by noose.gt.owl.de (Postfix, from userid 10)
	id 050A07DD; Tue,  9 Jan 2001 09:57:26 +0100 (CET)
Received: by paradigm.rfc822.org (Postfix, from userid 1000)
	id 4F282F44C; Tue,  9 Jan 2001 09:58:04 +0100 (CET)
Date:   Tue, 9 Jan 2001 09:54:38 +0100
From:   Florian Lohoff <flo@rfc822.org>
To:     "Kevin D. Kissell" <kevink@mips.com>
Subject: Re: MIPS32 patches breaking DecStation
Message-ID: <20010109095438.A10683@paradigm.rfc822.org>
References: <20010109004101.B27674@paradigm.rfc822.org> <000501c079d3$fefe1a60$0deca8c0@Ulysses>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <000501c079d3$fefe1a60$0deca8c0@Ulysses>; from kevink@mips.com on Tue, Jan 09, 2001 at 01:34:47AM +0100
Organization: rfc822 - pure communication
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Tue, Jan 09, 2001 at 01:34:47AM +0100, Kevin D. Kissell wrote:
> Florian,
> 
> Could you do me a huge favor and try a build that
> uses 3 or 4 nops instead of the branch to the instruction
> after the delay slot?   There was a reason that I eliminated

No problem - Done - doesnt work

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

It immediatly after starting init goes crazy with "Illegal instruction"
and dies like this:

[ ... a couple hundret Illegal instruction ... ]
[init:1] Illegal instruction 8f9983d4 at 0fb68df8 ra=0fb68a20
[init:1] Illegal instruction 8fbc0018 at 0fb68e08 ra=0fb68a20
[init:1] Illegal instruction 02402021 at 0fb68e10 ra=0fb68a20
[init:1] Illegal instruction 00000000 at 0fb68e18 ra=0fb68a20
Kernel panic: Attempted to kill init!
BUG IN DYNAMIC LINKER ld.so: dl-minimal.c: 67: malloc: Assertion `n <= _dl_page!

It seems we need a R4000 2.0/3.0 special except_vec_r4000 like we already
have for the R4600 and some other kinds of mips CPUs.

Flo
-- 
Florian Lohoff                  flo@rfc822.org             +49-5201-669912
     Why is it called "common sense" when nobody seems to have any?
