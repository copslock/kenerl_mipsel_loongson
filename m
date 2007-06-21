Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 21 Jun 2007 20:22:16 +0100 (BST)
Received: from father.pmc-sierra.com ([216.241.224.13]:4065 "HELO
	father.pmc-sierra.bc.ca") by ftp.linux-mips.org with SMTP
	id S20021829AbXFUTWN (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 21 Jun 2007 20:22:13 +0100
Received: (qmail 4905 invoked by uid 101); 21 Jun 2007 19:21:04 -0000
Received: from unknown (HELO pmxedge1.pmc-sierra.bc.ca) (216.241.226.183)
  by father.pmc-sierra.com with SMTP; 21 Jun 2007 19:21:04 -0000
Received: from bby1exi01.pmc_nt.nt.pmc-sierra.bc.ca (bby1exi01.pmc-sierra.bc.ca [216.241.231.251])
	by pmxedge1.pmc-sierra.bc.ca (8.13.4/8.12.7) with ESMTP id l5LJJ2bT015510;
	Thu, 21 Jun 2007 12:19:53 -0700
Received: by bby1exi01.pmc-sierra.bc.ca with Internet Mail Service (5.5.2657.72)
	id <LGNW7RDN>; Thu, 21 Jun 2007 12:19:02 -0700
Message-ID: <467ACF21.1030506@pmc-sierra.com>
From:	Marc St-Jean <Marc_St-Jean@pmc-sierra.com>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	linux-mips@linux-mips.org,
	Brian Oostenbrink <Brian_Oostenbrink@pmc-sierra.com>,
	Dan Doucette <Dan_Doucette@pmc-sierra.com>
Subject: Re: [PATCH 1/12] mips: PMC MSP71xx core platform
Date:	Thu, 21 Jun 2007 12:18:57 -0700
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2657.72)
x-originalarrivaltime: 21 Jun 2007 19:18:57.0976 (UTC) FILETIME=[04305380:01C7B439]
user-agent: Thunderbird 1.5.0.12 (X11/20070509)
Content-Type: text/plain;
	charset="iso-8859-1"
Return-Path: <Marc_St-Jean@pmc-sierra.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15504
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Marc_St-Jean@pmc-sierra.com
Precedence: bulk
X-list: linux-mips

Ralf Baechle wrote:
> On Thu, Jun 14, 2007 at 03:54:47PM -0600, Marc St-Jean wrote:
> 
> General comment all the first ~ 2900 of your patch is that it's rather
> heavy on #ifdef.  #ifdef is a nasty construct that has a tendency to hard
> to read code which in trun results in bugs.  Or a test compile fails to
> find real issues in the code because it's hidden in a dead #if construct.

I don't disagree but I do not have the resources to completely rewrite all
code using #ifdef at this time. The best we can do is to ensure to eliminate
them as we update the core platform support.

>  > diff --git a/include/asm-mips/pmc-sierra/msp71xx/msp_regops.h 
> b/include/asm-mips/pmc-sierra/msp71xx/msp_regops.h
>  > new file mode 100644
>  > index 0000000..60a5a38
>  > --- /dev/null
>  > +++ b/include/asm-mips/pmc-sierra/msp71xx/msp_regops.h
>  > @@ -0,0 +1,236 @@
>  > +/*
>  > + * SMP/VPE-safe functions to access "registers" (see note).
>  > + *
>  > + * NOTES:
>  > +* - These macros use ll/sc instructions, so it is your 
> responsibility to
>  > + * ensure these are available on your platform before including this 
> file.
>  > + * - The MIPS32 spec states that ll/sc results are undefined for 
> uncached
>  > + * accesses. This means they can't be used on HW registers accessed
>  > + * through kseg1. Code which requires these macros for this purpose 
> must
>  > + * front-end the registers with cached memory "registers" and have a 
> single
>  > + * thread update the actual HW registers.
> 
> You basically betting on undefined behaviour of the architecture.  I did
> indeed verify this specific case with a processor design guy and the answer
> was a "should be ok".  That is I heared people speak in a more convincing
> tone already ;-)
> 
> A SC with an uncached address on some other MIPS processors will always 
> fail.
> So this isn't just a theoretical footnote in a manual.
> 
> The way things are implemented LL/SC I am certain that uncached LL/SC will
> fail on any MIPS multiprocessor system.  Fortunately while SMTC pretends
> to be multiprocessor it's really just a single core, which saves your day.

I added this comment after this was discussed previously in the list, I have
updated the first part to be more clear about the limitations:

  * SMTC/VPE-safe functions to access "registers" (IMPORTANT: see NOTES).
  *
  * Copyright 2005-2007 PMC-Sierra, Inc.
  *
  * NOTES:
  * - Some of the macros defined in this file use LL/SC instructions which
  * are architecture specific. There use on MSP71XX is dependant on the
  * behavior of the MIPS 34k core in these devices. They will not work on
  * other multi-processor architectures or possibly on future VPE-based
  * cores.

At that time I also eliminated all use of macros containing LL/SC on uncached
memory outside of the core architecture specific (arch/mips/pmc-sierra/msp71xx)
code. The only driver currently using macros with LL/SC is the TWI LED driver
and it's to access a cached shared memory interface.

>  > + * - A maximum of 2k of code can be inserted between ll and sc. Every
>  > + * memory accesses between the instructions will increase the chance of
>  > + * sc failing and having to loop.
> 
> Any memory access between LL/SC makes the LL/SC sequence invalid that is
> it will have undefined effects.

Also a comment added after last discussion. Could you please expand on what
you mean by "undefined"? Are you saying the SC will not report the access?

I thought the reason these instructions exist was to detect an access near
the memory location referenced by them.

Updated to read:
  * - A maximum of 2k of code can be inserted between ll and sc. Every
  * memory accesses between the instructions will increase the chance of
  * sc failing and having to loop. Only perform the necessary logical
  * operations on register values in between these two instructions.


>  > +  * - There is a bug on the R10000 chips which has a workaround. If you
>  > + * are affected by this bug, make sure to define the symbol 
> 'R10000_LLSC_WAR'
>  > + * to be non-zero.  If you are using this header from within linux, 
> you may
>  > + * include <asm/war.h> before including this file to have this defined
>  > + * appropriately for you.
> 
>  > +#ifndef __ASM_REGOPS_H__
>  > +#define __ASM_REGOPS_H__
>  > +
>  > +#include <linux/types.h>
>  > +
>  > +#include <asm/war.h>
>  > +
>  > +#ifndef R10000_LLSC_WAR
>  > +#define R10000_LLSC_WAR 0
>  > +#endif
> 
> This symbol is supposed to be defined by <asm/war.h> only.  Anyway, this
> #ifndef will never be true because you already include <asm/war.h>, so
> this is dead code.

Thanks, I have removed. This file had originally been written to live in
include/asm-mips.

>  > +#if R10000_LLSC_WAR == 1
>  > +#define __beqz       "beqzl  "
>  > +#else
>  > +#define __beqz       "beqz   "
>  > +#endif
>  > +
>  > +#ifndef _LINUX_TYPES_H
>  > +typedef unsigned int u32;
>  > +#endif
> 
> Redefining a stanard Linux type is a no-no as is relying on include
> wrapper symbols like _LINUX_TYPES_H.  Anyway, this #ifndef will never
> be true because you already include <linux/types.h>, so this is dead code.

Removed, similar situation as above.

>  > +static inline u32 read_reg32(volatile u32 *const addr,
>  > +                             u32 const mask)
>  > +{
>  > +     u32 temp;
>  > +
>  > +     __asm__ __volatile__(
>  > +     "       .set    push                            \n"
>  > +     "       .set    noreorder                       \n"
>  > +     "       lw      %0, %1          # read          \n"
>  > +     "       and     %0, %2          # mask          \n"
>  > +     "       .set    pop                             \n"
>  > +     : "=&r" (temp)
>  > +     : "m" (*addr), "ir" (mask));
>  > +
>  > +     return temp;
>  > +}
> 
> No need for inline assembler here; plain C can achieve the same.  Or just
> use a standard Linux function such as readl() or ioread32() or similar.

OK, used C.

>  > +/*
>  > + * For special strange cases only:
>  > + *
>  > + * If you need custom processing within a ll/sc loop, use the 
> following macros
>  > + * VERY CAREFULLY:
>  > + *
>  > + *   u32 tmp;                                <-- Define a variable 
> to hold the data
>  > + *
>  > + *   custom_read_reg32(address, tmp);        <-- Reads the address 
> and put the value
>  > + *                                           in the 'tmp' variable 
> given
>  > + *
>  > + *   From here on out, you are (basicly) atomic, so don't do 
> anything too
>  > + *   fancy!
>  > + *   Also, this code may loop if the end of this block fails to write
>  > + *   everything back safely due do the other CPU, so do NOT do anything
>  > + *   with side-effects!
>  > + *
>  > + *   custom_write_reg32(address, tmp);       <-- Writes back 'tmp' 
> safely.
>  > + */
>  > +#define custom_read_reg32(address, tmp)                              \
>  > +     __asm__ __volatile__(                                   \
>  > +     "       .set    push                            \n"     \
>  > +     "       .set    mips3                           \n"     \
>  > +     "1:     ll      %0, %1  #custom_read_reg32      \n"     \
>  > +     "       .set    pop                             \n"     \
>  > +     : "=r" (tmp), "=m" (*address)                           \
>  > +     : "m" (*address))
>  > +
>  > +#define custom_write_reg32(address, tmp)                     \
>  > +     __asm__ __volatile__(                                   \
>  > +     "       .set    push                            \n"     \
>  > +     "       .set    mips3                           \n"     \
>  > +     "       sc      %0, %1  #custom_write_reg32     \n"     \
>  > +     "       "__beqz"%0, 1b                          \n"     \
>  > +     "       nop                                     \n"     \
>  > +     "       .set    pop                             \n"     \
>  > +     : "=&r" (tmp), "=m" (*address)                          \
>  > +     : "0" (tmp), "m" (*address))
> 
> These two are *really* fragile stuff.  Modern gcc rearranges code in
> amazing ways, so you might end up with other loads or stores being moved
> into the ll/sc sequence or the 1: label of another inline assembler
> construct being taken as the destination of the branch.  So I would
> suggest to safely store the two function in a nice yellow barrel ;-)

I'm probably missing some European cultural nuance, unless of course
you mean toxic waste :) Dropped.

> General suggestion, you can make about every access atomic if you do
> something like
> 
> #include <linux/modules.h>
> #include <linux/spinlocks.h>
> 
> DEFINE_SPINLOCK(register_lock);
> EXPORT_SYMBOL(register_lock);
> 
> static inline void set_value_reg32(u32 *const addr,
>                                        u32 const mask,
>                                        u32 const value)
> {
>         unsigned long flags;
>         u32 bits;
> 
>         spinlock_irqsave(&register_lock, flags);
>         bits = readl(addr);
>         bits &= mask;
>         bits |= value;
>         writel(bits, addr);
> }
> 
> Maybe slower but definately more portable and not waiting before some
> CPU designer screws your code by accident :-)

Yes but code running on the RTOS can't pull in spinlock source from linux.

Marc
