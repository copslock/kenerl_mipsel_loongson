Received:  by oss.sgi.com id <S553692AbRBGQ7z>;
	Wed, 7 Feb 2001 08:59:55 -0800
Received: from noose.gt.owl.de ([62.52.19.4]:44817 "HELO noose.gt.owl.de")
	by oss.sgi.com with SMTP id <S553671AbRBGQ7h>;
	Wed, 7 Feb 2001 08:59:37 -0800
Received: by noose.gt.owl.de (Postfix, from userid 10)
	id 46E6D7F3; Wed,  7 Feb 2001 17:59:25 +0100 (CET)
Received: by paradigm.rfc822.org (Postfix, from userid 1000)
	id DCE6DEEAC; Wed,  7 Feb 2001 17:59:35 +0100 (CET)
Date:   Wed, 7 Feb 2001 17:59:35 +0100
From:   Florian Lohoff <flo@rfc822.org>
To:     "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Cc:     linux-mips@oss.sgi.com
Subject: Re: NON FPU cpus - way to go
Message-ID: <20010207175935.J26479@paradigm.rfc822.org>
References: <20010207144857.B24485@paradigm.rfc822.org> <Pine.GSO.3.96.1010207171821.1418B-100000@delta.ds2.pg.gda.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.GSO.3.96.1010207171821.1418B-100000@delta.ds2.pg.gda.pl>; from macro@ds2.pg.gda.pl on Wed, Feb 07, 2001 at 05:36:33PM +0100
Organization: rfc822 - pure communication
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Wed, Feb 07, 2001 at 05:36:33PM +0100, Maciej W. Rozycki wrote:
> On Wed, 7 Feb 2001, Florian Lohoff wrote:
> 
> > i would like to know the way to go for NON-FPU cpus - Currently its
> > partly an Compile Time thing and partly run time config. 
> 
>  The i386 way seems reasonable, IMHO.  Have a configure option to enable
> an FPU emulator.  Panic upon boot if no FP hardware is available and no
> emulator is compiled in. 

The problem with not compiling in the FPU Emulator at all means some
of your FPU instructions (even on FPU hardware) will fail as on some
specific operators the hardware decides to handle it in software. So
usually you would need an FPU Emulator even on FPU enabled CPUs.

This isnt true if you decide to compile your complete userland with
fpu emulation.

> > this also valid for R3k CPU cores ? From my reading it is not as it doesnt
> > get initialized for R3000 ? As a lot architectures have the R3010
> > so this should get detected. The R3081 definitly has an FPU from
> > what i found on the web so this should be correct.

>   This register is co-processor 1 control register 0 (mnemonic FCR0),
> and is accessed by ctc1 and cfc1 instructions.
>   Unlike the CPUcs field, the "Imp" field is useful.  In the R30xx
> family it will contain one of two values:

I dont know if this is a generic way to go - I saw complete "full-stops"
on an R3912 using the ctc/cfc instructions - I'll try the autodection
when i come home.

>  Is there any problem in a particular configuration which makes the FCR0
> non-zero Imp field dependency unreliable? 
> 
>  The book covers R3081 and it states it contains the 3010A FPA device,
> indeed. 

Flo
-- 
Florian Lohoff                  flo@rfc822.org             +49-5201-669912
     Why is it called "common sense" when nobody seems to have any?
