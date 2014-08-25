Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 25 Aug 2014 16:27:55 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:52852 "EHLO
        localhost.localdomain" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27006709AbaHYO1wyYgcd (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 25 Aug 2014 16:27:52 +0200
Date:   Mon, 25 Aug 2014 15:27:52 +0100 (BST)
From:   "Maciej W. Rozycki" <macro@linux-mips.org>
To:     Ralf Baechle <ralf@linux-mips.org>
cc:     Matthew Fortune <Matthew.Fortune@imgtec.com>,
        Manuel Lauss <manuel.lauss@gmail.com>,
        Linux-MIPS <linux-mips@linux-mips.org>
Subject: Re: [RFC PATCH V2] MIPS: fix build with binutils 2.24.51+
In-Reply-To: <20140825125107.GA25892@linux-mips.org>
Message-ID: <alpine.LFD.2.11.1408251502140.18483@eddie.linux-mips.org>
References: <1408465632-34262-1-git-send-email-manuel.lauss@gmail.com> <20140825125107.GA25892@linux-mips.org>
User-Agent: Alpine 2.11 (LFD 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 42223
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-Id: linux-mips <linux-mips.eddie.linux-mips.org>
X-List-ID: linux-mips <linux-mips.eddie.linux-mips.org>
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
X-list: linux-mips

On Mon, 25 Aug 2014, Ralf Baechle wrote:

> > With binutils snapshots since 29.07.2014 I get the following build failure:
> > {standard input}: Warning: .gnu_attribute 4,3 requires `softfloat'
> >   LD      arch/mips/alchemy/common/built-in.o
> > mipsel-softfloat-linux-gnu-ld: Warning: arch/mips/alchemy/common/built-in.o
> >  uses -msoft-float (set by arch/mips/alchemy/common/prom.o),
> >  arch/mips/alchemy/common/sleeper.o uses -mhard-float
> > 
> > Extend cflags with a soft-float directive for the assembler, and add
> > hardfloat directives to assembler files dealing with FPU
> > registers to compensate.
> 
> I had a discussion about this with Maciej.  He suggested that this
> behavious of binutils should be taken a look at but also that we rather
> should remove the -msoft-float option from the kernel and I support his
> view.
> 
> I did add -msoft-float in 6218cf4410cfce7bc7e89834e73525b124625d4c
> [[MIPS] Always pass -msoft-float.] in 2006 because back then there was a
> wave of bug reports from people attempting to use hard fp in the kernel
> which of course did result in FPR corruption.  Adding -msoft-float made
> sure that floating point operations would result in a link error because
> the kernel does not supply a soft-fp library.
> 
> But maybe there are other methods to achieve the same - such as
> 
> #define float diediedie
> #define double goboom

 I had a short discussion with Matthew (cc-ed) meanwhile who has been 
doing binutils and GCC work in this area recently and made GCC pass 
`-msoft-float' down to GAS as a part of floating-point ABI updates being 
made right now.  As a result at this point I think we want to keep 
`-msoft-float', and furthermore the use of `-Wa,-msoft-float' and `.set 
hardfloat' appears mostly right to me however with the following 
exceptions:

1. Determine whether `-Wa,-msoft-float' and `.set hardfloat' are available 
   (a single check will do, they were added to GAS both at the same time) 
   and only enable them if supported by binutils being used to build the 
   kernel, e.g. (for the `.set' part):

#ifdef GAS_HAS_SET_HARDFLOAT
#define SET_HARDFLOAT .set	hardfloat
#else
#define SET_HARDFLOAT
#endif

   Otherwise we'd have to bump the binutils requirement up to 2.19; this 
   feature was only added with:

commit 037b32b9ffec4d7e68c596a0835dee8b0d26818f
Author: Adam Nemet <anemet@caviumnetworks.com>
Date:   Mon Apr 28 17:06:28 2008 +0000

   I'm not convinced that would be very wise, but maybe it's OK after six 
   years after all.

2. Use `.set hardfloat' only around the places that really require it, 
   i.e.:

	.set	push
	SET_HARDFLOAT
# Do the FP stuff.
	.set	pop

   (so the arch/mips/kernel/r4k_fpu.S piece is good except for maybe using 
   a macro, depending on the outcome of #1 above, but the other ones are 
   not).

 So the patch looks to me like a good starting point, but it is not quite 
there yet.

 The use of `-Wa,-msoft-float' will also improve our safety checks with 
GCC versions up to 4.9 as it'll catch any unintended use of FP operations 
in assembly code as long as the version of GAS used is at least 2.19.

  Maciej
