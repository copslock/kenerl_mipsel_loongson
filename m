Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g2Q8A4v10025
	for linux-mips-outgoing; Tue, 26 Mar 2002 00:10:04 -0800
Received: from mx2.mips.com (ftp.mips.com [206.31.31.227])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g2Q89uq10017
	for <linux-mips@oss.sgi.com>; Tue, 26 Mar 2002 00:09:56 -0800
Received: from newman.mips.com (ns-dmz [206.31.31.225])
	by mx2.mips.com (8.9.3/8.9.0) with ESMTP id AAA22183;
	Tue, 26 Mar 2002 00:11:38 -0800 (PST)
Received: from copfs01.mips.com (copfs01 [192.168.205.101])
	by newman.mips.com (8.9.3/8.9.0) with ESMTP id AAA07969;
	Tue, 26 Mar 2002 00:11:38 -0800 (PST)
Received: from mips.com (copsun17 [192.168.205.27])
	by copfs01.mips.com (8.11.4/8.9.0) with ESMTP id g2Q8AwA06389;
	Tue, 26 Mar 2002 09:10:58 +0100 (MET)
Message-ID: <3CA02D11.B011962@mips.com>
Date: Tue, 26 Mar 2002 09:10:57 +0100
From: Carsten Langgaard <carstenl@mips.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; SunOS 5.7 sun4u)
X-Accept-Language: en
MIME-Version: 1.0
To: "Kevin D. Kissell" <kevink@mips.com>
CC: Johannes Stezenbach <js@convergence.de>, linux-mips@oss.sgi.com
Subject: Re: Mips16 toolchain?
References: <20020325135834.GA1736@convergence.de> <00e901c1d40d$a257a200$0deca8c0@Ulysses>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

"Kevin D. Kissell" wrote:

> > I saw that the algorithmics toolchain (which Dominic Sweetman
> > offered to the Linux/MIPS community here a month ago) claims
> > to have full support for the mips16 instruction set.
> >
> > My questions:
> > Does anyone here have experiences with mips16 and/or with the
> > algorithmics toolchain?
>
> Yes.  Both Algorithmics and Green Hills embedded
> tool chains support it reasonably well.  GHS has no
> Linux target, though.  Algorithmics has been working
> on one, but I'm not sure what it's current status is.
>
> > Is there working support for mips16 in any other gcc-version?
>
> Cygnus (now part of Red Hat) did the very first MIPS16
> support for gcc, most of which found its way into the
> main development/maintence stream.  But apparently
> not enough of it, based on your experience.
>
> > How about gcc-3.x from CVS?
>
> No data there.
>
> > Any other comments or recommendations regarding mips16?
>
> MIPS16 requires more than just gcc support.
> One needs a binutils that can distinguish a MIPS16
> binary module (or function if you want to be fancy and
> mix/match within modules)  from a MIPS32/64 module
> and perform fixups so that the right selections are made
> between JAL and JALX on function invocations.
> If you've got that, you should not need a seperate
> MIPS16 libc.
>
> To correctly support MIPS16, the Linux kernel does
> need to be tweaked in those cases where user-mode
> instructions are decoded and interpreted, as in
> arch/mips/kernel/branch.c and unaligned.c.
> I believe that code has been prototyped somewhere,
> but it's not yet in any commonly used repository to
> the best of my knowledge.  If you avoid throwing
> executing non-instructions, performing unaligned
> accesses, etc, you should be able to tiptoe around
> that deficiency.

I don't think you need to tiptoe to get it working :-;
It should be easy to avoid non-instructions, unaligned accesses and co.
We have a few MIPS16 applications running using Algorithmics compiler
and a static non-PIC libc.

>
>             Regards,
>
>             Kevin K.

--
_    _ ____  ___   Carsten Langgaard   Mailto:carstenl@mips.com
|\  /|||___)(___   MIPS Denmark        Direct: +45 4486 5527
| \/ |||    ____)  Lautrupvang 4B      Switch: +45 4486 5555
  TECHNOLOGIES     2750 Ballerup       Fax...: +45 4486 5556
                   Denmark             http://www.mips.com
