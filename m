Received:  by oss.sgi.com id <S42208AbQJIOha>;
	Mon, 9 Oct 2000 07:37:30 -0700
Received: from smtp.algor.co.uk ([62.254.210.199]:48858 "EHLO
        kenton.algor.co.uk") by oss.sgi.com with ESMTP id <S42196AbQJIOhT>;
	Mon, 9 Oct 2000 07:37:19 -0700
Received: from gladsmuir.algor.co.uk (dom@gladsmuir.algor.co.uk [192.168.5.75])
	by kenton.algor.co.uk (8.9.3/8.8.8) with ESMTP id PAA05646;
	Mon, 9 Oct 2000 15:37:08 +0100 (GMT/BST)
Received: (from dom@localhost)
	by gladsmuir.algor.co.uk (8.8.5/8.8.5) id PAA00765;
	Mon, 9 Oct 2000 15:49:10 +0100 (GMT/BST)
Date:   Mon, 9 Oct 2000 15:49:10 +0100 (GMT/BST)
Message-Id: <200010091449.PAA00765@gladsmuir.algor.co.uk>
From:   Dominic Sweetman <dom@algor.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To:     Ralf Baechle <ralf@oss.sgi.com>
Cc:     Dominic Sweetman <dom@algor.co.uk>, sde@algor.co.uk,
        "Kevin D. Kissell" <kevink@mips.com>, linux-mips@oss.sgi.com,
        linux-mips@fnet.fr
Subject: Re: load_unaligned() and "uld" instruction
In-Reply-To: <20000929192254.G16050@bacchus.dhis.org>
References: <39CF9DFC.F30B302B@mvista.com>
	<200009252116.WAA01137@gladsmuir.algor.co.uk>
	<39CFC567.DD66BC56@mvista.com>
	<000d01c02782$32d31560$0deca8c0@Ulysses>
	<200009260908.KAA00259@gladsmuir.algor.co.uk>
	<20000929192254.G16050@bacchus.dhis.org>
X-Mailer: VM 6.34 under 19.16 "Lille" XEmacs Lucid
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing


It started when I wrote:

> > Hmm.  I wish it was that simple.  But some MIPS CPUs have 
> > instruction set additions which are not related to the mips1, mips2,
> > etc.  For example, a whole collection of parts with a vaguely
> > "embedded" orientation has integer multiply/accumulate instructions.
> > 
> > Algorithmics' version of GCC (and, I'm sure, others) picks up on the
> > -mcpu=xxx flag to do that.  In fact, I don't think there's any other
> > way to allow the compiler to warn you of some bizarre omissions from
> > one or two rogue CPUs.

Ralf Baechle (ralf@oss.sgi.com) replied:

> Ouch.  The gcc documentation says this:
> 
> `-mcpu=CPU TYPE'
>      Assume the defaults for the machine type CPU TYPE when
>      scheduling instructions.  The choices for CPU TYPE are `r2000',
>      `r3000', `r4000', `r4400', `r4600', and `r6000'.  While picking
>      a specific CPU TYPE will schedule things appropriately for that
>      particular chip, the compiler will not generate any code that
>      does not meet level 1 of the MIPS ISA (instruction set
>      architecture) without the `-mips2' or `-mips3' switches being
>      used.
> 
> So in other words I wouldn't expect anything like mmad to be used
> unless -mmad is also being choosen.  -mcpu not influencing the set
> of instructions being used to build a program is a general gcc
> convention, not only for MIPS.  So if the Algorithmics compiler does
> things different I'd consider it to be off the track.

I think we comply with a somewhat weaker reading of the same
paragraph, in that no "MIPS III" instruction will be used unless you
say -mips3 (or greater).

I could also be pedantic and point out that the effect of
"-mcpu=r3900" (for instance) is not defined by that quotation...

-mmad: as you know (but all readers might not) the integer
multiply-accumulate instructions are not in *any* numbered MIPS
instruction set - at least not until MIPS32, which is a different
series.  If they existed as a single, coherent add-on a single "-mmad"
flag would be the best solution - but they don't: no two
manufacturer's implementations are quite the same.

And the Vr41xx is MIPS III, except that it leaves out the "semaphore"
instructions LL and SC.  We want our toolchain to know these
instructions aren't there, and it seems natural to overload the
-mcpu=r4100 flag for this purpose.  Perhaps we'll propose a change to
the manual!

> > Outside SGI circles, I believe, "32-bit kernels" are all that are
> > likely to work...
> 
> Currently.  Some embedded people are actually asking for more than
> the 512mb memory supported by the 32-bit kernel.  So expect the
> 64-bit kernel to become the predominant race in the not to distant
> future.

I can see why that might be sensible.  Most MIPS CPUs except the
lowest-end are now 64-bit, so why try to fix the memory limitation
twice?

I can sketch some reasons, though, why this might not be automatically
and obviously correct outside SGI:

1. Linux on other architectures doesn't depend on being able to
   address the whole of physical memory through an "unmapped" window
   like MIPS' kseg0.  (So this dependency can't extend into
   machine-independent code).

2. One effect of making the kernel 64-bit will be the memory
   swallowed by all those double-size pointers.

3. You're missing the advantage of a neat trick in the MIPS
   architecture, where 32-bit code running on a mips3+ CPU
   automatically "sign-extends" 32-bit pointers to generate valid
   64-bit addresses.
   
   So it's not obvious why you shouldn't go the other way, and use
   32-bit pointers inside a kernel which supports 64-bit-pointer
   applications.  

> Also expect embedded SMP kernels in the not to far future.

That's orthogonal to the pointer size.

> > Even calling a subroutine compiled 32-bit may corrupt one of the
> > registers which are supposed to be preserved.
> 
> Sure, but that's kind of expected and obvious when following the
> instruction sequence as it gets executed while the corruption by an
> exception was pretty unobvious when I first ran into it ...

(With me it was the other way around... the interrupt problem was
obvious, but I found it harder to see how the C compiler puns data
between compiler-world types and "register" data types.)

I guess anyone interested needs to be very careful to make the
distinction (familiar to old hands) between:

1. Using a "64-bit capable" CPU (MIPS III or higher), which has 64-bit
   registers, data path and so on...

2. Compiling in an environment where some C variables are implemented
   with 64-bit mips3+ instructions or rely on 64-bit registers.

3. Compiling in an environment where C pointers become 64-bit objects.

It's easy to slip into saying "64-bit" to mean "whichever of
these I'm currently thinking of."

You mentioned Kevin's suggested virtues for a kernel:

> > 1. build for either 32-bit ("MIPS32" and near-miss) and 64-bit
> >   (MIPS3, MIPS4 and MIPS64) CPUs.

Kevin works for MIPS, who have invented MIPS32 to try to stem
incompatible proliferation of the instructino set of MIPS CPUs with
only 32-bit registers and data paths.  This is still new - few, if
any, MIPS32 CPUs have shipped in systems yet.
   
Linux kernels to run on 32-bit CPUs should perhaps rely on just the
MIPS I instruction set plus a usable TLB (MIPS MMU hardware).  It's
true there are two major branches of the CPU-control instructions, but
it's not that hard to cover up, and surely not a good use of scarce
resources to assume compliance to MIPS32 just now.

> > 2. Allow 64-bit operations on 64-bit CPUs, without insisting that
> >    [standard integer/pointer] C data types grow.  Need to save the
> >    whole of registers and compile "long long" and "double" data
> >    types...

Algorithmics thought that was a good idea, and it's a door we've kept
open to our "embedded" customers, where 64-bit pointers are not
much wanted.  It does create a lot of unexpected side-effects in
return for rather intangible benefits, so I sympathise with Ralf on
that one.

> I was thinking about moving all the 64-bit CPUs over to the mips64
> kernel and leave the `mips' kernel to the true 32-bit stuff.

I think by "64-bit CPUs" you mean all of my (1-3) above, and by "true
32-bit stuff" you mean... I'm really not sure what.

Somewhere buried under this is the problem of maintaining a Linux/MIPS
kernel and providing any kind of confidence that it will (at any
particular version) build and run correctly on "any reasonable MIPS
CPU".

To provide stability on variant platforms means identifying the
interfaces between variant-dependent and -independent code, freezing
those interfaces and treating them with great respect.  I think that's
still foreign to most of the Linux community, because they've grown up
with PCs.

It may simply be the best decision to allow the MIPS kernel landscape
to fragment into islands, with the "compatibility" layer at the
kernel/application interface (and some informal conventions to ease
device driver porting).

> Most users will currently still not want to use a 64-bit address
> space for apps.  That's ok, we can add support for 2-level page
> tables to `mips64'.

I can't see, offhand, why a kernel which can map a large user space
for applications with 64-bit pointers should require different page
tables for applications which use 32-bit pointers.  32-bit pointers
generate perfectly good 64-bit addresses.  The userspace layout of
32-bit-pointer applications needs to feature stack space (for example)
within reach of the 32-bit pointers - but does it really need such
large changes to the VM code?

> The calling conventions used by -mips3 are slight confusing, if not
> even dangerous.  Older gccs use a non-standard calling convention
> which essentially is a blind extension of the 32-bit ABI to
> 64-bit...
>
> Newer gccs support the N32 and 64 ABIs.  Unfortunately currently gcc
> does not support building a single compiler that supports all three
> 32, N32 and 64 ABIs.

While it would be nice to fix it, a single compiler which does all
three is perhaps not so critical... Using o32 puts you in such a
different universe that having a separate compiler is not such a big
deal. 

-- 
Dominic Sweetman
Algorithmics Ltd
The Fruit Farm, Ely Road, Chittering, CAMBS CB5 9PH, ENGLAND
phone: +44 1223 706200 / fax: +44 1223 706250 / http://www.algor.co.uk
