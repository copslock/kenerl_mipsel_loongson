Received:  by oss.sgi.com id <S42239AbQI2WEE>;
	Fri, 29 Sep 2000 15:04:04 -0700
Received: from u-53.karlsruhe.ipdial.viaginterkom.de ([62.180.19.53]:54022
        "EHLO u-53.karlsruhe.ipdial.viaginterkom.de") by oss.sgi.com
	with ESMTP id <S42406AbQI2WDn>; Fri, 29 Sep 2000 15:03:43 -0700
Received: (ralf@lappi) by lappi.waldorf-gmbh.de id <S869804AbQI2RWy>;
        Fri, 29 Sep 2000 19:22:54 +0200
Date:   Fri, 29 Sep 2000 19:22:54 +0200
From:   Ralf Baechle <ralf@oss.sgi.com>
To:     Dominic Sweetman <dom@algor.co.uk>
Cc:     "Kevin D. Kissell" <kevink@mips.com>, linux-mips@oss.sgi.com,
        linux-mips@fnet.fr
Subject: Re: load_unaligned() and "uld" instruction
Message-ID: <20000929192254.G16050@bacchus.dhis.org>
References: <39CF9DFC.F30B302B@mvista.com> <200009252116.WAA01137@gladsmuir.algor.co.uk> <39CFC567.DD66BC56@mvista.com> <000d01c02782$32d31560$0deca8c0@Ulysses> <200009260908.KAA00259@gladsmuir.algor.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <200009260908.KAA00259@gladsmuir.algor.co.uk>; from dom@algor.co.uk on Tue, Sep 26, 2000 at 10:08:15AM +0100
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Tue, Sep 26, 2000 at 10:08:15AM +0100, Dominic Sweetman wrote:

> Hmm.  I wish it was that simple.  But some MIPS CPUs have 
> instruction set additions which are not related to the mips1, mips2,
> etc.  For example, a whole collection of parts with a vaguely
> "embedded" orientation has integer multiply/accumulate instructions.
> 
> Algorithmics' version of GCC (and, I'm sure, others) picks up on the
> -mcpu=xxx flag to do that.  In fact, I don't think there's any other
> way to allow the compiler to warn you of some bizarre omissions from
> one or two rogue CPUs.

Ouch.  The gcc documentation says this:

`-mcpu=CPU TYPE'
     Assume the defaults for the machine type CPU TYPE when scheduling
     instructions.  The choices for CPU TYPE are `r2000', `r3000',
     `r4000', `r4400', `r4600', and `r6000'.  While picking a specific
     CPU TYPE will schedule things appropriately for that particular
     chip, the compiler will not generate any code that does not meet
     level 1 of the MIPS ISA (instruction set architecture) without the
     `-mips2' or `-mips3' switches being used.

So in other words I wouldn't expect anything like mmad to be used unless
-mmad is also being choosen.  -mcpu not influencing the set of instructions
being used to build a program is a general gcc convention, not only for
MIPS.  So if the Algorithmics compiler does things different I'd consider
it to be off the track.

> But until compiler support for MIPS Linux is more systematic, you'd be
> better being conservative.  And you don't want to unnecessarily
> multiply kernel versions - so in general, don't say "-mcpu=" anything
> for kernel builds.

> The Linux convention is "-mips2"; which is quite odd, because the
> MIPS-II ISA was incarnate in just one CPU (the R6000).  A few units
> were made around 1990 and even fewer worked; the project was overtaken
> by the (-mips3, 64-bit) R4000.
> 
> Subsequently, and confusingly, "-mips2" has been re-used to mean
> "-mips3 but don't assume 64-bit registers".  Except for floating
> point.  Maybe.  (it's sometimes not a good idea to re-use a term).

In the kernel we actually don't care very much about floating point.

> Outside SGI circles, I believe, "32-bit kernels" are all that are
> likely to work...

Currently.  Some embedded people are actually asking for more than the
512mb memory supported by the 32-bit kernel.  So expect the 64-bit
kernel to become the predominant race in the not to distant future.
Also expect embedded SMP kernels in the not to far future.

No, I don't feel at all like adding highmem support to the 32-bit kernel.

> > ... except for the $zero register.  This is because all exceptions
> > as far as they store / restore the integer registers at all will
> > only deal with the lower 32-bit of the registers.  In other word any
> > interrupt will corrupt the upper 32-bit bit of gp registers.
> 
> Even calling a subroutine compiled 32-bit may corrupt one of the
> registers which are supposed to be preserved.

Sure, but that's kind of expected and obvious when following the
instruction sequence as it gets executed while the corruption by an
exception was pretty unobvious when I first ran into it ...

> As Kevin indicates, it would probably be worth some effort to converge
> on a kernel which would:
> 
> 1. build for either 32-bit ("MIPS32" and near-miss) and 64-bit
>   (MIPS3, MIPS4 and MIPS64) CPUs.
> 
> 2. Allow 64-bit operations on 64-bit CPUs, without insisting that
>    C data types grow.  Need to save the whole of registers and compile
>    "long long" and "double" data types...

I was thinking about moving all the 64-bit CPUs over to the mips64 kernel
and leave the `mips' kernel to the true 32-bit stuff.  If you go and
download a 2.0.14 tarball you'll see that I already once tried to support
full 64-bit operation but only 32-bit address space altogether with
real 32-bit CPUs in the `mips' architecture.  The result was fairly ugly,
so having learned form that I would prefer to keep 32-bit and 64-bit
stuff separate.

Most users will currently still not want to use a 64-bit address space
for apps.  That's ok, we can add support for 2-level page tables to
`mips64'.  That's already been done for example for x86 and looks
fairly sane and maintainable.

> This is possible, but needs some thought.  AFAIK, the GCC currently
> used for Linux changes the whole calling convention when -mips3 is
> selected, which makes (2) pretty difficult.

The calling conventions used by -mips3 are slight confusing, if not even
dangerous.  Older gccs use a non-standard calling convention which essentially
is a blind extension of the 32-bit ABI to 64-bit.  Newer gccs support
the N32 and 64 ABIs.  Unfortunately currently gcc does not support building
a single compiler that supports all three 32, N32 and 64 ABIs.

  Ralf
