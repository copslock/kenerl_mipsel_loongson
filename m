Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g0F0N6U27237
	for linux-mips-outgoing; Mon, 14 Jan 2002 16:23:06 -0800
Received: from dea.linux-mips.net (localhost [127.0.0.1])
	by oss.sgi.com (8.11.2/8.11.3) with ESMTP id g0F0Mxg27234
	for <linux-mips@oss.sgi.com>; Mon, 14 Jan 2002 16:22:59 -0800
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.1/8.11.1) id g0ENMu229444;
	Mon, 14 Jan 2002 15:22:56 -0800
Date: Mon, 14 Jan 2002 15:22:56 -0800
From: Ralf Baechle <ralf@oss.sgi.com>
To: Dominic Sweetman <dom@algor.co.uk>
Cc: Matthew Dharm <mdharm@momenco.com>, linux-mips@oss.sgi.com
Subject: Re: MIPS64 status?
Message-ID: <20020114152256.D29242@dea.linux-mips.net>
References: <20020113211323.A7115@momenco.com> <15426.48692.795968.819750@gladsmuir.algor.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <15426.48692.795968.819750@gladsmuir.algor.co.uk>; from dom@algor.co.uk on Mon, Jan 14, 2002 at 11:17:08AM +0000
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Mon, Jan 14, 2002 at 11:17:08AM +0000, Dominic Sweetman wrote:

> o Very large virtual address spaces, using 64-bit pointer types.

Actually I only implemented support for something like 0.5TB.  As for
supercomputing that's peanuts (Like five years ago a customer requested
SGI to increase the per process size of the address space from 1TB, the
limit of the R4000 to 16TB, the limit of R10000 class processors.)

> o C "long" (and perhaps even "int") becomes 64-bit.

We follow the MIPS ABI which uses 32-bit ints and 64-bit longs.

> In such a 64-bit Linux system, though, you might still want to be able
> to run 32-bit applications with 32-bit pointers, int and long - either
> for compatibility or economy (32-bit data types make for a smaller
> program).  SGI do this in Irix: I don't know whether the 64-bit
> Linux/MIPS systems got around to it.

Yes.  The environment provided however is slightly different.  32-bit
software on the mips64 kernel is running with UX=1 thus 64-bit instructions
are allowed.

> There are other potentially useful combinations:
> 
> o A Linux where all machine-supported integer data types are 32-bit,

I don't want to support 32-bit char and short, sorry :-)

>   but capable of addressing physical memory outside of a 4Gbyte map.
>   (In practice, you need to use this kind of system to get outside of
>   a 512Mbyte map - so it's urgent).

I'd be working on this right now if you'd not be bothering me with email ;-)

>   Ralf says he has done this: it could be done without using any
>   64-bit operations, but it might be easier with them.

There are still MIPS32 systems which don't support 64-bit operations just
may have an address space of upto 36 bits.

> o A system using 32-bit pointers and 'long' throughout, but with
>   support for 'long long' 64-bit integer data types in registers.
>   
> o A system using 64-bit addressing within the kernel, but not for
>   applications. 
> 
> However, it's unlikely to make sense to do all of them!

Correct.  We may add support for the one or other code of these models
over time.

> > I suspect that this is very much a toolchain issue, as I don't think
> > gcc will generate 64-bit addressing code.
> 
> I suspect that the generic GNU toolchains are pretty buggy when you
> switch on 64-bit MIPS operation; but it's bug-fixes which are needed,
> not wholesale new features.

Actually in the past somebody was doing paid work to get the combo
g++ + SGI as + GNU ld to work for N32.  Due to the similarity of N32 and
N64 that already brought us quite a bit closer to N64 support.  That
still leaves alot of work including plenty of gas work.

> Politics: MIPS Technologies' advocacy for their "MIPS32" instruction
> set dialect in embedded systems means there are now some quite capable
> MIPS CPUs (eg Alchemy's 500Mhz integrated CPUs) which don't have
> 64-bit datapaths or arithmetic.  So casual dependence on 64-bit
> operations should probably be avoided.

I'm doing the best to avoid that.

  Ralf
