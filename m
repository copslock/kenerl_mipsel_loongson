Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.5/8.12.5) with ESMTP id g7289tRw027619
	for <linux-mips-outgoing@oss.sgi.com>; Fri, 2 Aug 2002 01:09:55 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.5/8.12.3/Submit) id g7289t8t027618
	for linux-mips-outgoing; Fri, 2 Aug 2002 01:09:55 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from mx2.mips.com (ftp.mips.com [206.31.31.227])
	by oss.sgi.com (8.12.5/8.12.5) with SMTP id g7289dRw027606;
	Fri, 2 Aug 2002 01:09:39 -0700
Received: from newman.mips.com (ns-dmz [206.31.31.225])
	by mx2.mips.com (8.12.5/8.12.5) with ESMTP id g728ASXb029216;
	Fri, 2 Aug 2002 01:10:28 -0700 (PDT)
Received: from copfs01.mips.com (copfs01 [192.168.205.101])
	by newman.mips.com (8.9.3/8.9.0) with ESMTP id BAA06717;
	Fri, 2 Aug 2002 01:10:24 -0700 (PDT)
Received: from mips.com (copsun17 [192.168.205.27])
	by copfs01.mips.com (8.11.4/8.9.0) with ESMTP id g728AOb06191;
	Fri, 2 Aug 2002 10:10:25 +0200 (MEST)
Message-ID: <3D4A3E68.E330BA7A@mips.com>
Date: Fri, 02 Aug 2002 10:10:24 +0200
From: Carsten Langgaard <carstenl@mips.com>
X-Mailer: Mozilla 4.77 [en] (X11; U; SunOS 5.8 sun4u)
X-Accept-Language: en
MIME-Version: 1.0
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
CC: Ralf Baechle <ralf@oss.sgi.com>, linux-mips@fnet.fr,
   linux-mips@oss.sgi.com
Subject: Re: [update] [patch] linux: Cache coherency fixes
References: <Pine.GSO.3.96.1020801173504.8256H-100000@delta.ds2.pg.gda.pl>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, hits=0.0 required=5.0 tests= version=2.20
X-Spam-Level: 
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

"Maciej W. Rozycki" wrote:

> On Thu, 1 Aug 2002, Ralf Baechle wrote:
>
> > Looks mostly right except that the code in config-shared.in which deciedes
> > if a system is coherent is wrong.  Basically it assumes every R10000 or
> > every uniprocessor system is non-coherent and that's wrong.  As coherency
> > between CPUs and for DMA I/O is basically the same thing I've changed your
> > code from the use of CONFIG_CPU_CACHE_COHERENCY to CONFIG_NONCOHERENT_IO
> > which did already exist; I don't think we need another config symbol to
> > handle this.  Will apply once I did a few test builds and patches the
> > whole thing into 2.5 ...
>
>  Huh?  Coherent caching mode can be used for a few processors only, namely
> R4[04]00MC and presumably SB1 (inferred from the sources), i.e. the ones
> that support the interprocessor coherency protocol.  If you know of any
> other processor that supports the protocol, I'd be pleased to see a
> reference to a spec -- I hoped someone, possibly you, would fill the
> missing bits when I proposed the patch a month ago.  Nobody bothered,
> though, sigh...

The 20Kc has support for cache coherency, but it doesn't support Coherent
Update on Write (CUW), it only support Coherent exclusive (CE).

The way I implemented the coherency support locally, was I used a boot option
(coherency), where I could tell whether I wanted to run coherent or not.
The dma cache routines would then either be the normal (non-coherent version)
or a empty function.
As my system (a Malta board) can have different daughter cards attached, I can
have different CPUs and system controllers and I really like the idea, that I
can run the same kernel on all the different system setups.
So if the kernel was started with the "coherency" option, I checked whether or
not the CPU and system controller has support for coherency or not, if one or
both didn't support coherency, I die telling the user that the system didn't
support coherency.
In both the coherency and non-coherency case, I used the write-back
non-coherent cache attribute, as the 20Kc still responses to Intervention and
Invalidate request from the system controller.
The coherent exclusive cache attribute is really only needed in multi CPU
systems. I don't know if other CPU works the same way as the 20Kc.



>
>  I see your changes are broken conceptually, as the caching mode for the
> TLB should be inferred from the CPU configuration in the first place and
> not the system selection (actually it should be best selected ath the run
> time).  Hence I'd invert the flag, since most systems are non-coherent,
> and only permit it for certain processors.  Using a non-coherent
> configuration for an UP system that supports coherency (do SGI IP27 and
> SiByte SB1250 have another agent in the chipset that may issue coherent
> requests regardless of the number of processors started?) results in a
> performance hit only due to superfluous invalidations, but using a
> coherent configuration for a processor/system that doesn't support it may
> lead to a hard to debug hang with no apparent reason (as I wrote
> previously, even NMI/Reset stopped working on my system -- I had to hit
> the power switch).
>
>  I'll cook another patch to fix what got broken.
>
>   Maciej
>
> --
> +  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
> +--------------------------------------------------------------+
> +        e-mail: macro@ds2.pg.gda.pl, PGP key available        +

--
_    _ ____  ___   Carsten Langgaard   Mailto:carstenl@mips.com
|\  /|||___)(___   MIPS Denmark        Direct: +45 4486 5527
| \/ |||    ____)  Lautrupvang 4B      Switch: +45 4486 5555
  TECHNOLOGIES     2750 Ballerup       Fax...: +45 4486 5556
                   Denmark             http://www.mips.com
