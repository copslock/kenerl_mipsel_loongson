Received:  by oss.sgi.com id <S553788AbRCNS7t>;
	Wed, 14 Mar 2001 10:59:49 -0800
Received: from u-203-18.karlsruhe.ipdial.viaginterkom.de ([62.180.18.203]:35580
        "EHLO dea.waldorf-gmbh.de") by oss.sgi.com with ESMTP
	id <S553776AbRCNS7h>; Wed, 14 Mar 2001 10:59:37 -0800
Received: (from ralf@localhost)
	by dea.waldorf-gmbh.de (8.11.1/8.11.1) id f2EIxJM02180;
	Wed, 14 Mar 2001 19:59:19 +0100
Date:   Wed, 14 Mar 2001 19:59:19 +0100
From:   Ralf Baechle <ralf@oss.sgi.com>
To:     Daniel Jacobowitz <dan@debian.org>
Cc:     linux-mips@oss.sgi.com
Subject: Re: Can't build a CONFIG_CPU_NEVADA kernel
Message-ID: <20010314195919.A1911@bacchus.dhis.org>
References: <20010314084633.A25674@nevyn.them.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010314084633.A25674@nevyn.them.org>; from dan@debian.org on Wed, Mar 14, 2001 at 08:46:33AM -0500
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Wed, Mar 14, 2001 at 08:46:33AM -0500, Daniel Jacobowitz wrote:

> I've been trying for a couple of days now to build a MIPS kernel with
> CONFIG_CPU_NEVADA, and I can't get it to work.  r4k_switch.S produces a
> pile of "opcode not supported by processor" errors.

Known and unsolved problem.

> First, I figured out where the problem is coming from:
> 
> r4k_switch.S is included for all processors but the r3000 and r3912. 
> Is that really correct?  Then, it references FPU_SAVE_DOUBLE, which
> includes:

Yes.  Originally written for the R4000 the Dr. Franksteins at MIPS in the
meantime also have taken r4k-style fpus and put them into 32-bit processors,

>         cfc1    tmp,  fcr31;                    \
>         sdc1    $f0,  (THREAD_FPU + 0x000)(thread); \
>         sdc1    $f2,  (THREAD_FPU + 0x010)(thread); \
> 
> 
> The sdc1 instruction in binutils is flagged like this:
>       if (mips_cpu == CPU_R4650)
>         {
>           as_bad (_("opcode not supported on this processor"));
>           return;
>         }
> 
> And the IVR sets CONFIG_CPU_NEVADA, which produces
> ifdef CONFIG_CPU_NEVADA
> GCCFLAGS        += -mcpu=r8000 -mips2 -Wa,--trap -mmad
> endif
> 
> and -mmad becomes -m4650 to the assembler.

Which is pretty much bs because mmad may have been introduced with the
R4640 / R4650 but isn't only available on this processor.  From an ISA
view it's a processor specific extension and as such it should be
controlled by a separate option.  Gcc has -mmad which is fine but passing
it on to as as -m4650 is borken.

> Something is fishy here.  Anyone know what?  I have a suspicion that we
> need to change the way we invoke binutils.  Making -mmad imply -m4650
> just seems lame, since -m4650 also implies -msingle-float, and I don't
> think that's right for the r8000.

R8000 is serious fp, indeed.

> I worked back in time in gcc, binutils, and kernel sources and I
> couldn't figure out what's changed - I'm sure this worked at some
> point.

You'll have to go back far in time.  I introduced the use of -mmad for
Nevada-class CPUs in late summor '97.

As a second bug which makes this one even more annoying something like

	.set	mips3
	sdc1    $f2, (a0)
	.set	mips0

also doesn't work - the assembler will still throw an "opcode not supported
on this processor" message.  After all MIPS III means double precission fp.
And passing additional assembler options with -Wa,foo doesn't help either
in this case so without the necessary gcc / assembler changes this
optimization is lost for now.

  Ralf
