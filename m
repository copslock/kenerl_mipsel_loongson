Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 16 Mar 2007 02:01:12 +0000 (GMT)
Received: from localhost.localdomain ([127.0.0.1]:12197 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20022561AbXCPCAp (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 16 Mar 2007 02:00:45 +0000
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.13.8/8.13.8) with ESMTP id l2G1wn8b015506;
	Fri, 16 Mar 2007 01:58:49 GMT
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.13.8/8.13.8/Submit) id l2G1wlvJ015505;
	Fri, 16 Mar 2007 01:58:47 GMT
Date:	Fri, 16 Mar 2007 01:58:47 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Marc St-Jean <stjeanma@pmc-sierra.com>
Cc:	linux-mips@linux-mips.org
Subject: Re: [PATCH 2/5] mips: PMC MSP71xx mips common
Message-ID: <20070316015847.GB14865@linux-mips.org>
References: <200703071801.l27I1Yfs012803@pasqua.pmc-sierra.bc.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200703071801.l27I1Yfs012803@pasqua.pmc-sierra.bc.ca>
User-Agent: Mutt/1.4.2.2i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14489
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, Mar 07, 2007 at 12:01:34PM -0600, Marc St-Jean wrote:

Looks fine ...  except this one:

> diff --git a/include/asm-mips/regops.h b/include/asm-mips/regops.h
> new file mode 100644
> index 0000000..375c667
> --- /dev/null
> +++ b/include/asm-mips/regops.h
> @@ -0,0 +1,166 @@
> +/*
> + * VPE/SMP-safe functions to access registers.  They use ll/sc instructions, so
> + * it is your responsibility to ensure these are available on your platform
> + * before including this file.
> + *
> + * In addition, there is a bug on the R10000 chips which has a workaround.  If
> + * you are affected by this bug, make sure to define the symbol
> + * 'R10000_LLSC_WAR' to be non-zero.  If you are using this header from within
> + * linux, you may include <asm/war.h> before including this file to have this
> + * defined appropriately for you.
> + *
> + * Copyright 2005 PMC-Sierra, Inc.
> + *
> + *  This program is free software; you can redistribute  it and/or modify it
> + *  under  the terms of  the GNU General  Public License as published by the
> + *  Free Software Foundation;  either version 2 of the  License, or (at your
> + *  option) any later version.
> + *
> + *  THIS  SOFTWARE  IS PROVIDED   ``AS  IS'' AND   ANY  EXPRESS OR IMPLIED
> + *  WARRANTIES,   INCLUDING, BUT NOT  LIMITED  TO, THE IMPLIED WARRANTIES OF
> + *  MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED.  IN NO
> + *  EVENT  SHALL   THE AUTHOR  BE    LIABLE FOR ANY   DIRECT, INDIRECT,
> + *  INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
> + *  LIMITED   TO, PROCUREMENT OF  SUBSTITUTE GOODS  OR SERVICES; LOSS OF USE,
> + *  DATA,  OR PROFITS; OR  BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
> + *  THEORY OF LIABILITY, WHETHER IN  CONTRACT, STRICT LIABILITY, OR TORT
> + *  (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF
> + *  THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
> + *
> + *  You should have received a copy of the  GNU General Public License along
> + *  with this program; if not, write  to the Free Software Foundation, Inc., 675
> + *  Mass Ave, Cambridge, MA 02139, USA.
> + */
> +
> +#ifndef __ASM_REGOPS_H__
> +#define __ASM_REGOPS_H__
> +
> +#ifndef R10000_LLSC_WAR
> +#define R10000_LLSC_WAR 0
> +#endif

Better include <asm/war.h> or R10000_LLSC_WAR might have an unexpected value.

> +#if R10000_LLSC_WAR == 1
> +#define __beqz	"beqzl	"
> +#else
> +#define __beqz	"beqz	"
> +#endif
> +
> +#ifndef _LINUX_TYPES_H
> +typedef unsigned int uint32_t;
> +#endif

Again, include <linux/types.h>.  Including this file first then <linux/types.h>
will result in a duplicate definition ...

> +/*
> + * Sets all the masked bits to the corresponding value bits
> + */
> +static inline void set_value_reg32( volatile uint32_t * const addr,
> +					uint32_t const mask,
> +					uint32_t const value )
> +{
> +	uint32_t temp;
> +
> +	__asm__ __volatile__(
> +	"	.set	mips3				\n"
> +	"1:	ll	%0, %1	# set_value_reg32	\n"
> +	"	and	%0, %2				\n"
> +	"	or	%0, %3				\n"
> +	"	sc	%0, %1				\n"
> +	"	"__beqz"%0, 1b				\n"
> +	"	.set	mips0				\n"
> +	: "=&r" (temp), "=m" (*addr)
> +	: "ir" (~mask), "ir" (value), "m" (*addr) );
> +}
> +
> +/*
> + * Sets all the masked bits to '1'
> + */
> +static inline void set_reg32( volatile uint32_t * const addr,
> +				uint32_t const mask )
> +{
> +	uint32_t temp;
> +
> +	__asm__ __volatile__(
> +	"	.set	mips3				\n"
> +	"1:	ll	%0, %1		# set_reg32	\n"
> +	"	or	%0, %2				\n"
> +	"	sc	%0, %1				\n"
> +	"	"__beqz"%0, 1b				\n"
> +	"	.set	mips0				\n"
> +	: "=&r" (temp), "=m" (*addr)
> +	: "ir" (mask), "m" (*addr) );
> +}
> +
> +/*
> + * Sets all the masked bits to '0'
> + */
> +static inline void clear_reg32( volatile uint32_t * const addr,
> +				uint32_t const mask )
> +{
> +	uint32_t temp;
> +
> +	__asm__ __volatile__(
> +	"	.set	mips3				\n"
> +	"1:	ll	%0, %1		# clear_reg32	\n"
> +	"	and	%0, %2				\n"
> +	"	sc	%0, %1				\n"
> +	"	"__beqz"%0, 1b				\n"
> +	"	.set	mips0				\n"
> +	: "=&r" (temp), "=m" (*addr)
> +	: "ir" (~mask), "m" (*addr) );
> +}
> +
> +/*
> + * Toggles all masked bits from '0' to '1' and '1' to '0'
> + */
> +static inline void toggle_reg32( volatile uint32_t * const addr,
> +				uint32_t const mask )
> +{
> +	uint32_t temp;
> +
> +	__asm__ __volatile__(
> +	"	.set	mips3				\n"
> +	"1:	ll	%0, %1		# toggle_reg32	\n"
> +	"	xor	%0, %2				\n"
> +	"	sc	%0, %1				\n"
> +	"	"__beqz"%0, 1b				\n"
> +	"	.set	mips0				\n"
> +	: "=&r" (temp), "=m" (*addr)
> +	: "ir" (mask), "m" (*addr) );
> +}

As I understand you're using the preceeding 4 functions with the address
pointing to device registers, that is uncached memory?  The operation of
ll/sc on uncached memory is undefined.

So to fix this you'd have to use something like this:

	unsigned long flags;
	spinlock_t lock;

	spin_lock_irqsave(&lock, flags);
	writel(readl(addr) | mask);
	spin_unlock_restore(&lock, flags);

Which of course is considerably slower and heavier weight.

> +/* For special strange cases only:
> + *
> + * If you need custom processing within a ll/sc loop, use the following macros
> + * VERY CAREFULLY:
> + *
> + *   uint32_t tmp;                      <-- Define a variable to hold the data
> + *
> + *   custom_reg32_start(address, tmp);	<-- Reads the address and puts the value
> + *						in the 'tmp' variable given
> + *
> + *	< From here on out, you are (basicly) atomic, so don't do anything too
> + *	< fancy!
> + *	< Also, this code may loop if the end of this block fails to write
> + *	< everything back safely due do the other CPU, so do NOT do anything
> + *	< with side-effects!
> + *
> + *   custom_reg32_stop(address, tmp);	<-- Writes back 'tmp' safely. 
> + *
> + */
> +#define custom_reg32_read(address, tmp)				\
> +	__asm__ __volatile__(					\
> +	"	.set	mips3				\n"	\
> +	"1:	ll	%0, %1	#custom_reg32_read	\n"	\
> +	"	.set	mips0				\n"	\
> +	: "=r" (tmp), "=m" (*address)				\
> +	: "m" (*address) )
> +
> +#define custom_reg32_write(address, tmp)			\
> +	__asm__ __volatile__(					\
> +	"	.set	mips3				\n"	\
> +	"	sc	%0, %1	#custom_reg32_write	\n"	\
> +	"	"__beqz"%0, 1b				\n"	\
> +	"	.set	mips0				\n"	\
> +	: "=&r" (tmp), "=m" (*address)				\
> +	: "0" (tmp), "m" (*address) )
> +
> +#endif  /* __ASM_REGOPS_H__ */

Same comment as above applies for uncached accesses.

I used to have functions that expand into ll/sc in the kernel ages ago -
gcc did generate interesting (for some definition of interesting) but not
terribly useful code from it.  The chance that something like this is
happening has grown even further thanks to the more agressive optimizer
of modern gcc.

A valid ll/sc sequence also requires that there may not be another
load or store in between these two instructions.  So for example:

+                       custom_reg32_read(MSP_GPIO_DATA_REGISTER[gpio],
+                                         tmpdata);
+                       if (tmpdata & EXTENDED_CLR(gpio))
+                               tmpdata = EXTENDED_CLR(gpio);
+                       else
+                               tmpdata = EXTENDED_SET(gpio);
+                       custom_reg32_write(MSP_GPIO_DATA_REGISTER[gpio],
+                                          tmpdata);

What if gcc just because it feels like it puts tmpdata or gpio into the
stackframe?  In this particular case there is little register pressure
so it's unlikely but be afraid, be very afraid ...

  Ralf
