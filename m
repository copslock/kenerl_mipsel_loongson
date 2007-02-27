Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 27 Feb 2007 17:10:49 +0000 (GMT)
Received: from mother.pmc-sierra.com ([216.241.224.12]:52122 "HELO
	mother.pmc-sierra.bc.ca") by ftp.linux-mips.org with SMTP
	id S20038714AbXB0RKo (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 27 Feb 2007 17:10:44 +0000
Received: (qmail 22547 invoked by uid 101); 27 Feb 2007 17:09:33 -0000
Received: from unknown (HELO pmxedge1.pmc-sierra.bc.ca) (216.241.226.183)
  by mother.pmc-sierra.com with SMTP; 27 Feb 2007 17:09:33 -0000
Received: from bby1exi01.pmc_nt.nt.pmc-sierra.bc.ca (bby1exi01.pmc-sierra.bc.ca [216.241.231.251])
	by pmxedge1.pmc-sierra.bc.ca (8.13.4/8.12.7) with ESMTP id l1RH9Rsl024287;
	Tue, 27 Feb 2007 09:09:28 -0800
Received: by bby1exi01.pmc-sierra.bc.ca with Internet Mail Service (5.5.2657.72)
	id <FGCP1R41>; Tue, 27 Feb 2007 09:09:27 -0800
Message-ID: <45E465C1.50408@pmc-sierra.com>
From:	Marc St-Jean <Marc_St-Jean@pmc-sierra.com>
To:	Andrew Sharp <tigerand@gmail.com>
Cc:	linux-mips@linux-mips.org
Subject: Re: [PATCH 2/5] mips: PMC MSP71xx mips common
Date:	Tue, 27 Feb 2007 09:09:21 -0800
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2657.72)
x-originalarrivaltime: 27 Feb 2007 17:09:21.0685 (UTC) FILETIME=[0610FC50:01C75A92]
user-agent: Thunderbird 1.5.0.9 (X11/20061206)
Content-Type: text/plain;
	charset="iso-8859-1"
Return-Path: <Marc_St-Jean@pmc-sierra.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14261
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Marc_St-Jean@pmc-sierra.com
Precedence: bulk
X-list: linux-mips


Andrew Sharp wrote:
> On Mon, 26 Feb 2007 18:12:55 -0600 Marc St-Jean 
> <stjeanma@pmc-sierra.com> wrote:
>  > [PATCH 2/5] mips: PMC MSP71xx mips common
>  >
>  > Patch to add mips common support for the PMC-Sierra
>  > MSP71xx devices.
>  >
>  > These 5 patches along with the previously posted serial patch
>  > will boot the PMC-Sierra MSP7120 Residential Gateway board.
>  >
>  > Thanks,
>  > Marc
>  >
>  > Signed-off-by: Marc St-Jean <Marc_St-Jean@pmc-sierra.com>
>  > ---
>  > Re-posting patch with two recommended changes:
>  > 1. Dropped the PMC_MSP_UNCACHED configuration item as this was
>  > already available in arch/mips/Kconfig.debug.
>  > 3. Dropped 'else' case to simplify patch to do_watch() in
>  > arch/mips/kernel/traps.c
>  >
>  >  arch/mips/Kconfig           |   78 ++++++++++++++++++++
>  >  arch/mips/Makefile          |    8 ++
>  >  arch/mips/kernel/head.S     |    8 ++
>  >  arch/mips/kernel/traps.c    |    6 +
>  >  include/asm-mips/bootinfo.h |   12 +++
>  >  include/asm-mips/mipsregs.h |   30 +++++++
>  >  include/asm-mips/regops.h   |  168
>  > ++++++++++++++++++++++++++++++++++++++++++++
>  > include/asm-mips/war.h      |   11 ++ 8 files changed, 321 insertions(+)
> 
> My mailer kind of made a mess of things, hope I caught them all.
> 
>  > diff --git a/arch/mips/kernel/head.S b/arch/mips/kernel/head.S
>  > index 6f57ca4..d7451b1 100644
>  > --- a/arch/mips/kernel/head.S
>  > +++ b/arch/mips/kernel/head.S
>  > @@ -130,10 +130,18 @@
>  >       .endm
>  > 
>  >       /*
>  > +      * Reserverd space not required for PMC boards, although we 
> need to
>  > +      * jump to kernel start.
>  > +      */
>  > +#ifdef CONFIG_PMC_MSP
>  > +     jal     kernel_entry
>  > +#else
>  > +     /*
>  >        * Reserved space for exception handlers.
>  >        * Necessary for machines which link their kernels at KSEG0.
>  >        */
>  >       .fill   0x400
>  > +#endif /* CONFIG_PMC_MSP */
> 
> This is getting kind of ugly.  There are a whole lot of config choices
> that need to use the 'j kernel_entry'.  Do they all have to have their
> own?  I'm not sure what the best way is to handle them all.

I agree but don't know the best way to handle this. I could introduce a
SYS_NO_EXEPT_FILL or similar flag but this seems excessive.

Any other ideas from arch/mips folks?

I'm not sure why the fill is needed before _stext. The comment states
kernels linked against kseg0 require this. We link our kernels to
0x8010_0000 and expect that to be the start of text. We aren't
changing anything else in the startup code.


>  > diff --git a/include/asm-mips/bootinfo.h b/include/asm-mips/bootinfo.h
>  > index c7c945b..ab29fd4 100644
>  > --- a/include/asm-mips/bootinfo.h
>  > +++ b/include/asm-mips/bootinfo.h
>  > @@ -213,6 +213,18 @@
>  >  #define MACH_GROUP_NEC_EMMA2RH 25    /* NEC EMMA2RH (was 23)         */
>  > #define  MACH_NEC_MARKEINS    0       /* NEC EMMA2RH Mark-eins        */
>  > +/*
>  > + * Valid machtype for group PMC-MSP
>  > + */
>  > +#define MACH_GROUP_MSP         23    /* PMC-Sierra MSP 
> boards/CPUs    */
>  > +#define MACH_MSP4200_EVAL       0    /* PMC-Sierra MSP4200 
> Evaluation board */
>  > +#define MACH_MSP4200_GW         1    /* PMC-Sierra MSP4200 Gateway 
> demo board */
>  > +#define MACH_MSP4200_FPGA       2    /* PMC-Sierra MSP4200 Emulation 
> board */
>  > +#define MACH_MSP7120_EVAL       3    /* PMC-Sierra MSP7120 
> Evaluation board *
> /
>  > +#define MACH_MSP7120_GW         4    /* PMC-Sierra MSP7120 
> Residential Gateway board */
>  > +#define MACH_MSP7120_FPGA       5    /* PMC-Sierra MSP7120 Emulation 
> board */
>  > +#define MACH_MSP_OTHER        255    /* PMC-Sierra unknown board 
> type */
>  > +#define CL_SIZE                      COMMAND_LINE_SIZE
> 
> 
> Really I would add MACH_GROUP_MSP after MACH_GROUP_NEC_EMMA2RH,
> perhaps 27 or 28, rather than an interior number.  Especially if
> you are going to put it after MACH_GROUP_NEC_EMMA2RH in the file. ~:^)

Sure we aren't tied to this number. Looking at the numbering more closely,
it looks like numbers aren't reused when they are dropped so it may be
safer in case existing boards are still using 23.

Why do you recommend 27 or higher when apparently 26 hasn't been used?

Marc
