Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 28 Oct 2008 07:57:53 +0000 (GMT)
Received: from h4.dl5rb.org.uk ([81.2.74.4]:10677 "EHLO
	ditditdahdahdah-dahdahdahditdit.dl5rb.org.uk") by ftp.linux-mips.org
	with ESMTP id S22554626AbYJ1H5j (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 28 Oct 2008 07:57:39 +0000
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by ditditdahdahdah-dahdahdahditdit.dl5rb.org.uk (8.14.2/8.14.1) with ESMTP id m9S7vYW6021826;
	Tue, 28 Oct 2008 07:57:34 GMT
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.2/8.14.2/Submit) id m9S7vX7k021824;
	Tue, 28 Oct 2008 07:57:33 GMT
Date:	Tue, 28 Oct 2008 07:57:33 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	David Daney <ddaney@caviumnetworks.com>
Cc:	linux-mips@linux-mips.org,
	Tomaso Paoletti <tpaoletti@caviumnetworks.com>,
	Paul Gortmaker <Paul.Gortmaker@windriver.com>
Subject: Re: [PATCH 02/36] Add Cavium OCTEON files to
	arch/mips/include/asm/mach-cavium-octeon
Message-ID: <20081028075733.GB20858@linux-mips.org>
References: <490655B6.4030406@caviumnetworks.com> <1225152181-3221-1-git-send-email-ddaney@caviumnetworks.com> <1225152181-3221-2-git-send-email-ddaney@caviumnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1225152181-3221-2-git-send-email-ddaney@caviumnetworks.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21049
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, Oct 27, 2008 at 05:02:34PM -0700, David Daney wrote:

> +#ifdef CONFIG_SMP
> +#define cpu_has_llsc		1
> +#else
> +/* Disable LL/SC on non SMP systems. It is faster to disable interrupts for
> +   atomic access than a LL/SC */
> +#define cpu_has_llsc		0
> +#endif

It also means the resulting kernel won't have support for futex which
essentially means you're cut off from modern libcs.

It is possible to get this to work - but nobody bothered so far; ll/sc-less
R2000 class processors are very rare these days.  My recommendation is
to keep cpu_has_llsc as 1 until you've fixed up the futex implementation,
if you deciede so.

> +static inline int read_current_timer(unsigned long *result)
> +{
> +	asm volatile ("rdhwr %0,$31\n"
> +#ifndef CONFIG_64BIT
> +		      "sll %0, 0\n"
> +#endif
> +		      : "=r" (*result));
> +	return 0;
> +}

This function is unused.  And anyway, this header file wasn't meant as
the place for random code but only a way to describe the procesors a
system may feature as tightly as possible.

> +#ifndef __OCTEON_IRQ_H__
> +#define __OCTEON_IRQ_H__
> +
> +#define NR_IRQS OCTEON_IRQ_LAST
> +#define MIPS_CPU_IRQ_BASE 0
> +
> +/* 0 - 7 represent the 8 MIPS standard interrupt sources */

[...]

> +/* 144 - 151 represent the i8259 master */
> +#define OCTEON_IRQ_I8259M0      144
> +#define OCTEON_IRQ_I8259M1      145
> +#define OCTEON_IRQ_I8259M2      146
> +#define OCTEON_IRQ_I8259M3      147
> +#define OCTEON_IRQ_I8259M4      148
> +#define OCTEON_IRQ_I8259M5      149
> +#define OCTEON_IRQ_I8259M6      150
> +#define OCTEON_IRQ_I8259M7      151
> +/* 152 - 159 represent the i8259 slave */
> +#define OCTEON_IRQ_I8259S0      152
> +#define OCTEON_IRQ_I8259S1      153
> +#define OCTEON_IRQ_I8259S2      154
> +#define OCTEON_IRQ_I8259S3      155
> +#define OCTEON_IRQ_I8259S4      156
> +#define OCTEON_IRQ_I8259S5      157
> +#define OCTEON_IRQ_I8259S6      158
> +#define OCTEON_IRQ_I8259S7      159

You have some code for an i8259.  Since ISA interrupts are well known
numbers which are even hardcoded in drivers, manuals, printed on PCBs
etc. I recommend to renumber interrupts such that i8259 interrupts are
interrupts 0..15 and everything else follows after.  Oh the pleassures
of ISA cruft.

> +/**
> + * Write a 32bit value to the Octeon NPI register space
> + *
> + * @param address Address to write to
> + * @param val     Value to write
> + */

Linux coding style - comments are:

/*
 * blah frobnicate zumbitso
 */

sed is your friend to fix this.

  Ralf
