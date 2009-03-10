Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 10 Mar 2009 19:18:52 +0000 (GMT)
Received: from sj-iport-1.cisco.com ([171.71.176.70]:24920 "EHLO
	sj-iport-1.cisco.com") by ftp.linux-mips.org with ESMTP
	id S21366122AbZCJTSq (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 10 Mar 2009 19:18:46 +0000
X-IronPort-AV: E=Sophos;i="4.38,337,1233532800"; 
   d="scan'208";a="153684893"
Received: from sj-dkim-4.cisco.com ([171.71.179.196])
  by sj-iport-1.cisco.com with ESMTP; 10 Mar 2009 19:18:38 +0000
Received: from sj-core-2.cisco.com (sj-core-2.cisco.com [171.71.177.254])
	by sj-dkim-4.cisco.com (8.12.11/8.12.11) with ESMTP id n2AJIc0J032013;
	Tue, 10 Mar 2009 12:18:38 -0700
Received: from cliff.cisco.com (cliff.cisco.com [171.69.11.141])
	by sj-core-2.cisco.com (8.13.8/8.13.8) with ESMTP id n2AJIcxY000810;
	Tue, 10 Mar 2009 19:18:38 GMT
Received: from cuplxvomd02.corp.sa.net ([64.101.20.155]) by cliff.cisco.com (8.6.12/8.6.5) with ESMTP id TAA26825; Tue, 10 Mar 2009 19:18:28 GMT
Date:	Tue, 10 Mar 2009 12:18:28 -0700
From:	VomLehn <dvomlehn@cisco.com>
To:	Paul Gortmaker <paul.gortmaker@windriver.com>
Cc:	linux-mips@linux-mips.org, ralf@linux-mips.org
Subject: Re: [PATCH][MIPS] Use CP0 Count register to implement more
	granular ndelay
Message-ID: <20090310191828.GA30449@cuplxvomd02.corp.sa.net>
References: <20090227230950.GA29546@cuplxvomd02.corp.sa.net> <7d1d9c250902281310o7c03da24jcb8760fdfef4d46b@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7d1d9c250902281310o7c03da24jcb8760fdfef4d46b@mail.gmail.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
DKIM-Signature:	v=1; a=rsa-sha256; q=dns/txt; l=10534; t=1236712718; x=1237576718;
	c=relaxed/simple; s=sjdkim4002;
	h=Content-Type:From:Subject:Content-Transfer-Encoding:MIME-Version;
	d=cisco.com; i=dvomlehn@cisco.com;
	z=From:=20VomLehn=20<dvomlehn@cisco.com>
	|Subject:=20Re=3A=20[PATCH][MIPS]=20Use=20CP0=20Count=20reg
	ister=20to=20implement=20more=0A=09granular=20ndelay
	|Sender:=20;
	bh=zbiMAHknSPe0mdYV1VTFU9XelsBmVIHq/vkWyYpD5is=;
	b=Gy/nW1CAGOqHmtW35JIZOrk0ovsGNyYU/27kSCea6kKolq9vIHa7hfjTbl
	q42/WG/DU7fp7W4rCw94bL4mCAMArLeWcBoNW0dLbTe/eJt0WBw4m0jrTsB7
	rxLuWxok7t;
Authentication-Results:	sj-dkim-4; header.From=dvomlehn@cisco.com; dkim=pass (
	sig from cisco.com/sjdkim4002 verified; ); 
Return-Path: <dvomlehn@cisco.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22054
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dvomlehn@cisco.com
Precedence: bulk
X-list: linux-mips

On Sat, Feb 28, 2009 at 04:10:46PM -0500, Paul Gortmaker wrote:
> On Fri, Feb 27, 2009 at 6:09 PM, VomLehn <dvomlehn@cisco.com> wrote:
> > The default implementation of ndelay uses udelay, which will result in the
> > rounding up of any requested interval to the next highest number of
> > microseconds. This may be a much longer delay than was desired.  However,
> > if the tick rate of the CP0 Count register is known, it is possible to
> > implement an accurate ndelay that works on multiple MIPS processors.
> 
> Presumably the only case where this would ever matter is for delays
> that needed to be much less than udelay(1) -- is there a lot of these
> out there?  According to git grep, the only user of ndelay in
> arch/mips is lasat.  And, if what is there is working now, then one
> could argue that the calls for the short delays are not explicitly
> required to be less than udelay(1).

I'm working on patches that have a requirement for a 100 nsec delay, which
was the motivation for this. I'm trying to mainline code that has been
sitting outside the kernel tree for something like 3-1/2 years, but this
requires hitting a moving target with a moving gun, so it's taking a while...

> > To use this, enable CONFIG_CP0_COUNT_NDELAY and modify the platform startup
> > code to call init_ndelay as early as possible. A good place to call it
> > is probably the prom_init function. The argument to init_ndelay should be
> > the CP0 Count register tick rate, in kHz.  The tick rate is typically half
> > the processor clock rate so, if you have a 700 MHz processor, the CP0 Count
> > register would tick at 350 MHz and you would pass 3500000 to init_ndelay.
> >
> > At the risk of being obvious, you will need to ensure that ndelay isn't used
> > until after the call to init_ndelay. There are no checks to enforce this as
> > it would increase the latency in ndelay, but, in order to make it obvious
> > that init_ndelay hasn't been called early enough, the initial ndelay
> > parameters are set to cause a really large delay.
> 
> I didn't see the arch_initcall for the init_ndelay placed anywhere in
> this patch.

Two reasons for this:
1.	I haven't convinced myself that an arch_init call is early enough; you
	might need it earlier. I'm open to feedback about this.
2.	Doing this as an arch_initcall requires that init_ndelay call some
	currently undefined function to get the CP0 Count tick rate, whereas
	it is presently called with that value. Again, I'm open to feedback.

> > +config CP0_COUNT_NDELAY
> > +       bool "Use coprocessor 0 Count register for ndelay functionality"
> > +       default n
> 
> Does there need to be some sort of depends here to cover off any
> limitations where it is known that it won't work?

I don't have the breadth of knowledge required to say what processors have
a CP0 Count register. Any suggestions?

> > +/* Maximum amount of time that will be handled with ndelay, in nanoseconds.
> > + * Values bigger than this will be bounced up to udelay. */
> > +#define        _MAX_DIRECT_NDELAY              65535
> 
> Why the leading underscore here?  Maybe MAX_CP0_NDELAY would be a
> better choice if it has to be changed anyway?

I've spent lots of time doing standards and am following the C convention
of "hiding" things that aren't part of the published interface with an
underscore. The name you suggested has the downside that it implies you
can't call ndelay with a bigger value, which isn't true. This is just the
cut-over to using udelay.

> > +
> > +#define ndelay(n)      _ndelay(n)
> > +
> > +extern struct fast_ratio _ndelay_param;
> 
> 
> ...and here ; not sure why the leading underscore.

The previous comment about hiding things that aren't part of the published
interface applies.

> > +static inline void _ndelay(unsigned long nsecs)
> > +{
> > +       int     start;
> > +
> > +       /* The expected thing would be to do the first read of the Count
> > +        * register later, just before entering the delay loop. Reading here
> > +        * ensures that very short intervals will exit the first time through
> > +        * that loop. */
> > +       start = read_c0_count();
> 
> Is this really going to all work on mips64?  I've spent hours
> debugging silent boot death on mips64 due to bad variable choices used
> for stuff playing with read_c0_count when mips went to generic
> clockevents on r4k, and it wasn't fun.

I don't have a MIPS64 box to play with, but the manuals make it look like
I've got a 32-bit Count register.  It is also recommended that, though you
*can* set Count, you don't. I'm assuming this has been followed. If not,
then your suggestion about a dependency in Kconfig should limit this to
32-bit systems.

> > +#ifndef _ASM_MACH_POWERTV_FAST_RATIO_H_
> > +#define _ASM_MACH_POWERTV_FAST_RATIO_H_
> 
> s/MACH_POWERTV_//  is probably what you wanted to do here.

Yes, this is bleed-through from the out-of-tree implementation and should
be changed.

> > +/* Instances of this structure will normally be declared with the attribute
> > + * __read_mostly since it only makes sense to use the fast-ratio code if
> > + * you fill in the structure once for many calls to evalue the result. */
> > +struct fast_ratio {
> > +       unsigned long   k;
> > +       unsigned int    s;
> > +       unsigned long   r;
> > +};
> 
> Use of "int" again tends to make me nervous.

Not to worry. The variable s is a shift count. Since the C standard assures
us that ints can hold values up to 32767, this should work until we hit the
MIPS32768 architecture. :-)

> > +/* This elements are initialized to a value that will cause huge delays to
> > + * arise from use of ndelay before calling init_ndelay. This should make such
> > + * mistakes obvious enough to easily find and correct. */
> 
> I think it would be better to have something like:
> 
> if (unlikely(not_calibrated))
>      WARN_ON_ONCE(...)

If you have to use ndelay instead of udelay, you may very well care about the
extra few nanoseconds this would take.

> > +struct fast_ratio _ndelay_param __read_mostly = {
> > +       .k = 0,
> > +       .s = 0,
> > +       .r = ULONG_MAX / 2,
> > +};
> > +EXPORT_SYMBOL(_ndelay_param);
> 
> Not sure why the leading underscore here either.

Same reason as above.

> > +#ifndef assert
> > +#define assert(x)      BUG_ON(!(x))
> > +#endif
> > +#endif
> 
> I suspect the thing you will be asked to do here is dump the whole
> __KERNEL__ test and assert usage and simply just use BUG_ON right in
> the code.

Agreed, this is left-over cruft from testing and should be removed.

> > +#ifndef BITS_PER_LLONG
> > +#define        BITS_PER_LLONG  ((BITS_PER_LONG * sizeof(long long)) / sizeof(long))
> > +#endif
> 
> Is BITS_PER_LLONG really defined anywhere for anything?

See below.

> > +/* Type for intermediate calculations, along with the number of bits and
> > + * the maximum size. This should be the biggest unsigned type for which
> > + * division and modulus by unsigned long are defined on this
> > + * architecture. */
> > +#ifdef CONFIG_HAVE_ULLONG_DIV_AND_MOD
> 
> I've not seen any instances of this CONFIG option either.
> 
> > +typedef unsigned long long intermediate_t;
> > +#define        BITS_PER_ACC    BITS_PER_LLONG
> > +#define        ACC_MAX         ULLONG_MAX
> > +#else
> > +typedef unsigned long intermediate_t;
> > +#define        BITS_PER_ACC    BITS_PER_LONG
> > +#define        ACC_MAX         ULLONG_MAX
> > +#endif
> 
> This might fall into the loophole of  Documentation/CodingStyle  --
> chapter 5; i.e:
> 
>     ...but if there is a clear reason for why it under certain circumstances
>      might be an "unsigned int" and under other configurations might be
>      "unsigned long", then by all means go ahead and use a typedef.

This is fuzzy. The code was developed and tested in userspace for both
sizes, but it turns out we don't support division and modulus operations
of unsigned long longs by unsigned longs in kernel space, at least at present.
Support this would allow additional precision. So, I scratched my head a bit
and left it in to see what comments it might provoke. I'm still undecided as
to what I should do with it...

> > +
> > +/*
> 
> Don't these need to start with /** if you want to have them
> automagically parsed?

Good point.
> > +int init_fast_ratio(unsigned int max_x, unsigned long a,
> > +       unsigned long b, struct fast_ratio *fr)
> > +{
> > +#define        SHIFT_ROUND_UP(_v, _n)  (((_n) < 0) ?                   \
> > +               (((unsigned long long) (_v)) << -(_n)) :        \
> > +               (((_v) + ((1ull << (_n)) - 1)) >> (_n)))
> > +#define ROUNDING_CONST(_s)     (((_s) < 0) ? 0 : ((1ull << (_s)) - 1))
> 
> You've created a fast_ratio.h ; any reason why these #defines don't
> live there rather than in the middle of this function?   And if there
> is any implicit trickery being used that might not be obvious to Joe
> Average, then a comment or two wouldn't go amiss.  I know that it is
> over my head to parse on the fly, but that doesn't say much.  :-)

The macros aren't part of the interface, so I don't want to put them in
the header file. They only used in this particular function, so I only have
them defined here.

> > +#undef SHIFT_ROUND_UP
> > +#undef ROUNDING_CONST
> 
> This is a .c file, so I don't see the need to undef anything at the end.

Information hiding, they aren't used outside the function, so they are not
defined outside the function. Nested function definitions or scoping rules for
#defines would accomplish the same thing.

> Generally speaking, I think this could be two separate commits -- one
> that implements the basic ndelay uses read_c0_count() concept (if
> really required), and then an add-on commit that does the uber
> optimization of the whole ratio thing?  Then if it turns out that one
> hunk gets the green light, and the other doesn't, well then at least
> you get to see that one part of your work goes forward.

It could be, but I don't know of a current user of the fast-ratio work outside
of ndelay, and I like the extra dynamic range and precision it gives you for
ndelay. If there is an objection to the fast-ratio stuff, I could recast
ndelay as stand-alone but my preference is to have both.

I'll tweak this patch and resend a new version.

David VomLehn
