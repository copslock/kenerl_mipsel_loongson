Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 16 Mar 2007 23:54:37 +0000 (GMT)
Received: from father.pmc-sierra.com ([216.241.224.13]:42233 "HELO
	father.pmc-sierra.bc.ca") by ftp.linux-mips.org with SMTP
	id S20022629AbXCPXyc (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 16 Mar 2007 23:54:32 +0000
Received: (qmail 11325 invoked by uid 101); 16 Mar 2007 23:53:21 -0000
Received: from unknown (HELO pmxedge2.pmc-sierra.bc.ca) (216.241.226.184)
  by father.pmc-sierra.com with SMTP; 16 Mar 2007 23:53:21 -0000
Received: from bby1exi01.pmc_nt.nt.pmc-sierra.bc.ca (bby1exi01.pmc-sierra.bc.ca [216.241.231.251])
	by pmxedge2.pmc-sierra.bc.ca (8.13.4/8.12.7) with ESMTP id l2GNrKxn004815;
	Fri, 16 Mar 2007 15:53:20 -0800
Received: by bby1exi01.pmc-sierra.bc.ca with Internet Mail Service (5.5.2657.72)
	id <FGCPXZM7>; Fri, 16 Mar 2007 16:53:17 -0800
Message-ID: <45FB2DEB.70204@pmc-sierra.com>
From:	Marc St-Jean <Marc_St-Jean@pmc-sierra.com>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	linux-mips@linux-mips.org
Subject: Re: [PATCH 2/5] mips: PMC MSP71xx mips common
Date:	Fri, 16 Mar 2007 15:53:15 -0800
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2657.72)
x-originalarrivaltime: 17 Mar 2007 00:53:08.0859 (UTC) FILETIME=[A16084B0:01C7682E]
user-agent: Thunderbird 1.5.0.10 (X11/20070221)
Content-Type: text/plain;
	charset="iso-8859-1"
Return-Path: <Marc_St-Jean@pmc-sierra.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14512
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Marc_St-Jean@pmc-sierra.com
Precedence: bulk
X-list: linux-mips



Ralf Baechle wrote:
> On Wed, Mar 07, 2007 at 12:01:34PM -0600, Marc St-Jean wrote:
> 
> Looks fine ...  except this one:
> 
>  > diff --git a/include/asm-mips/regops.h b/include/asm-mips/regops.h
>  > new file mode 100644
>  > index 0000000..375c667
>  > --- /dev/null
>  > +++ b/include/asm-mips/regops.h
>  > @@ -0,0 +1,166 @@
>  > +/*
>  > + * VPE/SMP-safe functions to access registers.  They use ll/sc 
> instructions, so
>  > + * it is your responsibility to ensure these are available on your 
> platform
>  > + * before including this file.
>  > + *
>  > + * In addition, there is a bug on the R10000 chips which has a 
> workaround.  If
>  > + * you are affected by this bug, make sure to define the symbol
>  > + * 'R10000_LLSC_WAR' to be non-zero.  If you are using this header 
> from within
>  > + * linux, you may include <asm/war.h> before including this file to 
> have this
>  > + * defined appropriately for you.

[...]

>  > + */
>  > +
>  > +#ifndef __ASM_REGOPS_H__
>  > +#define __ASM_REGOPS_H__
>  > +
>  > +#ifndef R10000_LLSC_WAR
>  > +#define R10000_LLSC_WAR 0
>  > +#endif
> 
> Better include <asm/war.h> or R10000_LLSC_WAR might have an unexpected 
> value.

Thanks, will do.

>  > +#if R10000_LLSC_WAR == 1
>  > +#define __beqz       "beqzl  "
>  > +#else
>  > +#define __beqz       "beqz   "
>  > +#endif
>  > +
>  > +#ifndef _LINUX_TYPES_H
>  > +typedef unsigned int uint32_t;
>  > +#endif
> 
> Again, include <linux/types.h>.  Including this file first then 
> <linux/types.h>
> will result in a duplicate definition ...

OK.

>  > +/*
>  > + * Sets all the masked bits to the corresponding value bits
>  > + */
>  > +static inline void set_value_reg32( volatile uint32_t * const addr,
>  > +                                     uint32_t const mask,
>  > +                                     uint32_t const value )
>  > +{
>  > +     uint32_t temp;
>  > +
>  > +     __asm__ __volatile__(
>  > +     "       .set    mips3                           \n"
>  > +     "1:     ll      %0, %1  # set_value_reg32       \n"
>  > +     "       and     %0, %2                          \n"
>  > +     "       or      %0, %3                          \n"
>  > +     "       sc      %0, %1                          \n"
>  > +     "       "__beqz"%0, 1b                          \n"
>  > +     "       .set    mips0                           \n"
>  > +     : "=&r" (temp), "=m" (*addr)
>  > +     : "ir" (~mask), "ir" (value), "m" (*addr) );
>  > +}
>  > +
>  > +/*
>  > + * Sets all the masked bits to '1'
>  > + */
>  > +static inline void set_reg32( volatile uint32_t * const addr,
>  > +                             uint32_t const mask )
>  > +{
>  > +     uint32_t temp;
>  > +
>  > +     __asm__ __volatile__(
>  > +     "       .set    mips3                           \n"
>  > +     "1:     ll      %0, %1          # set_reg32     \n"
>  > +     "       or      %0, %2                          \n"
>  > +     "       sc      %0, %1                          \n"
>  > +     "       "__beqz"%0, 1b                          \n"
>  > +     "       .set    mips0                           \n"
>  > +     : "=&r" (temp), "=m" (*addr)
>  > +     : "ir" (mask), "m" (*addr) );
>  > +}
>  > +
>  > +/*
>  > + * Sets all the masked bits to '0'
>  > + */
>  > +static inline void clear_reg32( volatile uint32_t * const addr,
>  > +                             uint32_t const mask )
>  > +{
>  > +     uint32_t temp;
>  > +
>  > +     __asm__ __volatile__(
>  > +     "       .set    mips3                           \n"
>  > +     "1:     ll      %0, %1          # clear_reg32   \n"
>  > +     "       and     %0, %2                          \n"
>  > +     "       sc      %0, %1                          \n"
>  > +     "       "__beqz"%0, 1b                          \n"
>  > +     "       .set    mips0                           \n"
>  > +     : "=&r" (temp), "=m" (*addr)
>  > +     : "ir" (~mask), "m" (*addr) );
>  > +}
>  > +
>  > +/*
>  > + * Toggles all masked bits from '0' to '1' and '1' to '0'
>  > + */
>  > +static inline void toggle_reg32( volatile uint32_t * const addr,
>  > +                             uint32_t const mask )
>  > +{
>  > +     uint32_t temp;
>  > +
>  > +     __asm__ __volatile__(
>  > +     "       .set    mips3                           \n"
>  > +     "1:     ll      %0, %1          # toggle_reg32  \n"
>  > +     "       xor     %0, %2                          \n"
>  > +     "       sc      %0, %1                          \n"
>  > +     "       "__beqz"%0, 1b                          \n"
>  > +     "       .set    mips0                           \n"
>  > +     : "=&r" (temp), "=m" (*addr)
>  > +     : "ir" (mask), "m" (*addr) );
>  > +}
> 
> As I understand you're using the preceeding 4 functions with the address
> pointing to device registers, that is uncached memory?  The operation of
> ll/sc on uncached memory is undefined.

I have been searching for information on this in various 34k manuals as
well as Dominic's See MIPS Run 2nd Ed. and have not found this limitation
stated anywhere.

Programming the MIPS32 34K Core Family (MD00427) Section 3.5 states:
"The MIPS MT ASE requires that ll/sc also work between concurrent threads
on an MT CPU. Each TC is equipped with a CP0 register called LLAddr, which
remembers the physical address (at least to the enclosing 32-byte block) of
the target location of any ll/sc sequence. The 34K core detects possible
non-atomicity by checking every write made by any thread against the LLAddr
of all other TCs."

Doesn't the fact that a physical address is being compared imply any logical
address type can be used?


> So to fix this you'd have to use something like this:
> 
>         unsigned long flags;
>         spinlock_t lock;
> 
>         spin_lock_irqsave(&lock, flags);
>         writel(readl(addr) | mask);
>         spin_unlock_restore(&lock, flags);
> 
> Which of course is considerably slower and heavier weight.

I don't believe we can use a linux lock as the code running on the other TCs
is not necessarily a linux driver/thread/process. It does not share linux's
lock implementation.


>  > +/* For special strange cases only:
>  > + *
>  > + * If you need custom processing within a ll/sc loop, use the 
> following macros
>  > + * VERY CAREFULLY:
>  > + *
>  > + *   uint32_t tmp;                      <-- Define a variable to 
> hold the data
>  > + *
>  > + *   custom_reg32_start(address, tmp);       <-- Reads the address 
> and puts the value
>  > + *                                           in the 'tmp' variable 
> given
>  > + *
>  > + *   < From here on out, you are (basicly) atomic, so don't do 
> anything too
>  > + *   < fancy!
>  > + *   < Also, this code may loop if the end of this block fails to write
>  > + *   < everything back safely due do the other CPU, so do NOT do 
> anything
>  > + *   < with side-effects!
>  > + *
>  > + *   custom_reg32_stop(address, tmp);        <-- Writes back 'tmp' 
> safely.
>  > + *
>  > + */
>  > +#define custom_reg32_read(address, tmp)                              \
>  > +     __asm__ __volatile__(                                   \
>  > +     "       .set    mips3                           \n"     \
>  > +     "1:     ll      %0, %1  #custom_reg32_read      \n"     \
>  > +     "       .set    mips0                           \n"     \
>  > +     : "=r" (tmp), "=m" (*address)                           \
>  > +     : "m" (*address) )
>  > +
>  > +#define custom_reg32_write(address, tmp)                     \
>  > +     __asm__ __volatile__(                                   \
>  > +     "       .set    mips3                           \n"     \
>  > +     "       sc      %0, %1  #custom_reg32_write     \n"     \
>  > +     "       "__beqz"%0, 1b                          \n"     \
>  > +     "       .set    mips0                           \n"     \
>  > +     : "=&r" (tmp), "=m" (*address)                          \
>  > +     : "0" (tmp), "m" (*address) )
>  > +
>  > +#endif  /* __ASM_REGOPS_H__ */
> 
> Same comment as above applies for uncached accesses.
> 
> I used to have functions that expand into ll/sc in the kernel ages ago -
> gcc did generate interesting (for some definition of interesting) but not
> terribly useful code from it.  The chance that something like this is
> happening has grown even further thanks to the more agressive optimizer
> of modern gcc.
> 
> A valid ll/sc sequence also requires that there may not be another
> load or store in between these two instructions.  So for example:

MIPS32 34K Processor Core Family Software User's Manual (MD00534)
Store Conditional Word instruction states:
"If either of the following events occurs between the execution of LL and
SC, the SC may succeed or it may fail; the success or failure is not
predictable. Portable programs should not cause one of these events.
  -A memory access instruction (load, store, or prefetch) is executed on
   the processor executing the LL/SC.
  -The instructions executed starting with the LL and ending with the SC
   do not lie in a 2048-byte contiguous region of virtual memory. (The
   region does not have to be aligned, other than the alignment required
   for instruction words.)"

For the first of these points, if a failure occurs because of activity
on another TC, the loop should repeat until success.

For the second point, the code between custom_reg32_read and
custom_reg32_write is meant to be very simple. We can live with a
2k limit.


> +                       custom_reg32_read(MSP_GPIO_DATA_REGISTER[gpio],
> +                                         tmpdata);
> +                       if (tmpdata & EXTENDED_CLR(gpio))
> +                               tmpdata = EXTENDED_CLR(gpio);
> +                       else
> +                               tmpdata = EXTENDED_SET(gpio);
> +                       custom_reg32_write(MSP_GPIO_DATA_REGISTER[gpio],
> +                                          tmpdata);
> 
> What if gcc just because it feels like it puts tmpdata or gpio into the
> stackframe?  In this particular case there is little register pressure
> so it's unlikely but be afraid, be very afraid ...
> 
>   Ralf

We've been using this for a year with different versions of gcc and
have not encountered any problems. We could declare tmpdata as
"register" and increase the odds of it being allocated into a register.

Marc
