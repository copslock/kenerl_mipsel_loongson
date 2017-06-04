Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 04 Jun 2017 17:13:16 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:4107 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23993417AbdFDPNJyN0kE (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 4 Jun 2017 17:13:09 +0200
Received: from hhmail02.hh.imgtec.org (unknown [10.100.10.20])
        by Forcepoint Email with ESMTPS id C3A99C84BEAF5;
        Sun,  4 Jun 2017 16:12:59 +0100 (IST)
Received: from [10.20.78.115] (10.20.78.115) by hhmail02.hh.imgtec.org
 (10.100.10.21) with Microsoft SMTP Server id 14.3.294.0; Sun, 4 Jun 2017
 16:13:02 +0100
Date:   Sun, 4 Jun 2017 16:12:53 +0100
From:   "Maciej W. Rozycki" <macro@imgtec.com>
To:     Stuart Longland <stuartl@longlandclan.id.au>
CC:     <linux-mips@linux-mips.org>
Subject: Re: QEMU Malta emulation using I6400: runaway loop modprobe
 binfmt-464c
In-Reply-To: <81bca3a5-88dc-d6af-9c6a-3e17d9a8bda5@longlandclan.id.au>
Message-ID: <alpine.DEB.2.00.1706041556050.10864@tp.orcam.me.uk>
References: <996c275d-d969-508e-6b4e-bef22d8e7385@longlandclan.id.au> <alpine.DEB.2.00.1706031310470.2590@tp.orcam.me.uk> <81bca3a5-88dc-d6af-9c6a-3e17d9a8bda5@longlandclan.id.au>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
X-Originating-IP: [10.20.78.115]
Return-Path: <Maciej.Rozycki@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 58200
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@imgtec.com
Precedence: bulk
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-Id: linux-mips <linux-mips.eddie.linux-mips.org>
X-List-ID: linux-mips <linux-mips.eddie.linux-mips.org>
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
X-list: linux-mips

Hi Stuart,

> >  First is rebuilding your userland for the 2008 NaN encoding.  I'm sure 
> > someone already did it, but I don't have a pointer at hand.  This might be 
> > the best option however.
> 
> This will be a lengthy process, is there a particular compiler flag I
> should be using for that?  `man gcc` seems to mention the following:
> 
> >        -mabs=2008
> >        -mabs=legacy
> >            These options control the treatment of the special not-a-number (NaN) IEEE 754 floating-point data with the "abs.fmt" and "neg.fmt"
> >            machine instructions.
> > 
> >            By default or when -mabs=legacy is used the legacy treatment is selected.  In this case these instructions are considered arithmetic and
> >            avoided where correct operation is required and the input operand might be a NaN.  A longer sequence of instructions that manipulate the
> >            sign bit of floating-point datum manually is used instead unless the -ffinite-math-only option has also been specified.
> > 
> >            The -mabs=2008 option selects the IEEE 754-2008 treatment.  In this case these instructions are considered non-arithmetic and therefore
> >            operating correctly in all cases, including in particular where the input operand is a NaN.  These instructions are therefore always used
> >            for the respective operations.
> > 
> >        -mnan=2008
> >        -mnan=legacy
> >            These options control the encoding of the special not-a-number (NaN) IEEE 754 floating-point data.
> > 
> >            The -mnan=legacy option selects the legacy encoding.  In this case quiet NaNs (qNaNs) are denoted by the first bit of their trailing
> >            significand field being 0, whereas signalling NaNs (sNaNs) are denoted by the first bit of their trailing significand field being 1.
> > 
> >            The -mnan=2008 option selects the IEEE 754-2008 encoding.  In this case qNaNs are denoted by the first bit of their trailing significand
> >            field being 1, whereas sNaNs are denoted by the first bit of their trailing significand field being 0.
> > 
> >            The default is -mnan=legacy unless GCC has been configured with --with-nan=2008.
> 
> If I understand correctly, the right thing to do would be to use
> -mnan=2008 then?

 I suggest keeping the two settings in sync, because this is what in 
reality hardware does even though the architecture allows them to be 
independent (which is also why these are two separate settings).  That is 
`-mnan=2008 -mabs=2008' or `-mnan=legacy -mabs=legacy'.

 You could also configure GCC itself with one of the `--with-nan=2008' and 
`--with-nan=legacy' options, which would set the defaults for both 
`-mnan=' and `-mabs=' settings accordingly.  In the absence of the 
`--with-nan=' option in the configuration process GCC defaults to 
inferring the `-mnan=' and `-mabs=' settings from the architecture 
specified with `-march=', which is `legacy' for `mips32r5'/`mips64r5' and 
older, or `2008' for `mips32r6'/`mips64r6' (and likewise according to the 
architecture level implemented by any specific processor requested with 
`-march=').

 NB the default for `-march=' can also be specified in configuration, with 
the use of the `--with-arch=' option.

>  What's the effect on pre-2008 CPUs?

 The same as with running legacy-NaN software on a 2008-NaN processor -- 
by default the kernel will refuse execution of such a binary, or you can 
use the kernel options I quoted to change that, and likewise with the 
`ieee754=relaxed' option you risk incorrect results, including a possible 
crash.  There is symmetry here.

  Maciej
