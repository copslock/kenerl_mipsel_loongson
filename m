Received:  by oss.sgi.com id <S42371AbQIZI6W>;
	Tue, 26 Sep 2000 01:58:22 -0700
Received: from smtp.algor.co.uk ([62.254.210.199]:17639 "EHLO
        kenton.algor.co.uk") by oss.sgi.com with ESMTP id <S42281AbQIZI54>;
	Tue, 26 Sep 2000 01:57:56 -0700
Received: from gladsmuir.algor.co.uk (dom@gladsmuir.algor.co.uk [192.168.5.75])
	by kenton.algor.co.uk (8.9.3/8.8.8) with ESMTP id JAA24255;
	Tue, 26 Sep 2000 09:57:19 +0100 (GMT/BST)
Received: (from dom@localhost)
	by gladsmuir.algor.co.uk (8.8.5/8.8.5) id KAA00259;
	Tue, 26 Sep 2000 10:08:15 +0100 (GMT/BST)
Date:   Tue, 26 Sep 2000 10:08:15 +0100 (GMT/BST)
Message-Id: <200009260908.KAA00259@gladsmuir.algor.co.uk>
From:   Dominic Sweetman <dom@algor.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To:     "Kevin D. Kissell" <kevink@mips.com>
Cc:     "Jun Sun" <jsun@mvista.com>, "Dominic Sweetman" <dom@algor.co.uk>,
        <linux-mips@oss.sgi.com>, <linux-mips@fnet.fr>
Subject: Re: load_unaligned() and "uld" instruction
In-Reply-To: <000d01c02782$32d31560$0deca8c0@Ulysses>
References: <39CF9DFC.F30B302B@mvista.com>
	<200009252116.WAA01137@gladsmuir.algor.co.uk>
	<39CFC567.DD66BC56@mvista.com>
	<000d01c02782$32d31560$0deca8c0@Ulysses>
X-Mailer: VM 6.34 under 19.16 "Lille" XEmacs Lucid
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing


Kevin D. Kissell (kevink@mips.com) writes:

> > Another question is that in the same file most CPUs will take another
> > compiler option such as "-mcpu=r8000", in which case the cpu model
> > usually does NOT correspond to the actual CPU.  Why is that?
> 
> The -mcpu tells the compiler and assembler for what kind
> of pipeline it should optimise, which is independent of the
> ISA level.  "-mcpu=r8000", for example, tells the tools that
> the CPU is superscalar. Thus one sees that option selected 
> for the R5000 platforms, even though the R5000 and R8000
> pipelines are otherwise very dissimilar.

Hmm.  I wish it was that simple.  But some MIPS CPUs have 
instruction set additions which are not related to the mips1, mips2,
etc.  For example, a whole collection of parts with a vaguely
"embedded" orientation has integer multiply/accumulate instructions.

Algorithmics' version of GCC (and, I'm sure, others) picks up on the
-mcpu=xxx flag to do that.  In fact, I don't think there's any other
way to allow the compiler to warn you of some bizarre omissions from
one or two rogue CPUs.

But until compiler support for MIPS Linux is more systematic, you'd be
better being conservative.  And you don't want to unnecessarily
multiply kernel versions - so in general, don't say "-mcpu=" anything
for kernel builds.

The Linux convention is "-mips2"; which is quite odd, because the
MIPS-II ISA was incarnate in just one CPU (the R6000).  A few units
were made around 1990 and even fewer worked; the project was overtaken
by the (-mips3, 64-bit) R4000.

Subsequently, and confusingly, "-mips2" has been re-used to mean
"-mips3 but don't assume 64-bit registers".  Except for floating
point.  Maybe.  (it's sometimes not a good idea to re-use a term).

Ralf wrote:

> You cannot use any kind of 64-bit operation for the 32-bit kernel...

Outside SGI circles, I believe, "32-bit kernels" are all that are
likely to work...

> ... except for the $zero register.  This is because all exceptions
> as far as they store / restore the integer registers at all will
> only deal with the lower 32-bit of the registers.  In other word any
> interrupt will corrupt the upper 32-bit bit of gp registers.

Even calling a subroutine compiled 32-bit may corrupt one of the
registers which are supposed to be preserved.

As Kevin indicates, it would probably be worth some effort to converge
on a kernel which would:

1. build for either 32-bit ("MIPS32" and near-miss) and 64-bit
  (MIPS3, MIPS4 and MIPS64) CPUs.

2. Allow 64-bit operations on 64-bit CPUs, without insisting that
   C data types grow.  Need to save the whole of registers and compile
   "long long" and "double" data types...

This is possible, but needs some thought.  AFAIK, the GCC currently
used for Linux changes the whole calling convention when -mips3 is
selected, which makes (2) pretty difficult.

-- 
Dominic Sweetman
Algorithmics Ltd
The Fruit Farm, Ely Road, Chittering, CAMBS CB5 9PH, ENGLAND
phone: +44 1223 706200 / fax: +44 1223 706250 / http://www.algor.co.uk
