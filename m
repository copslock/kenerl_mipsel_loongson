Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 27 Feb 2007 18:49:22 +0000 (GMT)
Received: from [66.201.51.66] ([66.201.51.66]:47301 "EHLO ripper.onstor.net")
	by ftp.linux-mips.org with ESMTP id S20039200AbXB0StS (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 27 Feb 2007 18:49:18 +0000
Received: from andys by ripper.onstor.net with local (Exim 4.63)
	(envelope-from <andy.sharp@onstor.com>)
	id 1HM7Kr-0008Rg-S9
	for linux-mips@linux-mips.org; Tue, 27 Feb 2007 10:46:01 -0800
Date:	Tue, 27 Feb 2007 10:46:01 -0800
From:	Andrew Sharp <tigerand@gmail.com>
To:	linux-mips@linux-mips.org
Subject: Re: [PATCH 2/5] mips: PMC MSP71xx mips common
Message-ID: <20070227184555.GA32425@onstor.com>
References: <45E465C1.50408@pmc-sierra.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <45E465C1.50408@pmc-sierra.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Return-Path: <andy.sharp@onstor.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14266
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tigerand@gmail.com
Precedence: bulk
X-list: linux-mips

On Tue, Feb 27, 2007 at 09:09:21AM -0800, Marc St-Jean wrote:
> 
> Andrew Sharp wrote:
> > On Mon, 26 Feb 2007 18:12:55 -0600 Marc St-Jean <stjeanma@pmc-sierra.com> wrote:
> >  > diff --git a/include/asm-mips/bootinfo.h b/include/asm-mips/bootinfo.h
> >  > index c7c945b..ab29fd4 100644
> >  > --- a/include/asm-mips/bootinfo.h
> >  > +++ b/include/asm-mips/bootinfo.h
> >  > @@ -213,6 +213,18 @@
> >  >  #define MACH_GROUP_NEC_EMMA2RH 25    /* NEC EMMA2RH (was 23)         */
> >  > #define  MACH_NEC_MARKEINS    0       /* NEC EMMA2RH Mark-eins        */
> >  > +/*
> >  > + * Valid machtype for group PMC-MSP
> >  > + */
> >  > +#define MACH_GROUP_MSP         23    /* PMC-Sierra MSP 
> > boards/CPUs    */
> >  > +#define MACH_MSP4200_EVAL       0    /* PMC-Sierra MSP4200 
> > Evaluation board */
> >  > +#define MACH_MSP4200_GW         1    /* PMC-Sierra MSP4200 Gateway 
> > demo board */
> >  > +#define MACH_MSP4200_FPGA       2    /* PMC-Sierra MSP4200 Emulation 
> > board */
> >  > +#define MACH_MSP7120_EVAL       3    /* PMC-Sierra MSP7120 
> > Evaluation board *
> > /
> >  > +#define MACH_MSP7120_GW         4    /* PMC-Sierra MSP7120 
> > Residential Gateway board */
> >  > +#define MACH_MSP7120_FPGA       5    /* PMC-Sierra MSP7120 Emulation 
> > board */
> >  > +#define MACH_MSP_OTHER        255    /* PMC-Sierra unknown board 
> > type */
> >  > +#define CL_SIZE                      COMMAND_LINE_SIZE
> > 
> > 
> > Really I would add MACH_GROUP_MSP after MACH_GROUP_NEC_EMMA2RH,
> > perhaps 27 or 28, rather than an interior number.  Especially if
> > you are going to put it after MACH_GROUP_NEC_EMMA2RH in the file. ~:^)
> 
> Sure we aren't tied to this number. Looking at the numbering more closely,
> it looks like numbers aren't reused when they are dropped so it may be
> safer in case existing boards are still using 23.
> 
> Why do you recommend 27 or higher when apparently 26 hasn't been used?

Experience. ~:^)  You never know when a little extra room for expansion
might come in handy.  For example, let's say next year you release a
quad-core SOC (hint-hint), and a line of eval boards.  You would have
room to put them in the file next to your other boards.  But just a
suggestion.

Cheers,

a
