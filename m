Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 28 Sep 2011 15:32:06 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:45923 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S1492105Ab1I1NcB (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 28 Sep 2011 15:32:01 +0200
Received: from duck.linux-mips.net (duck.linux-mips.net [127.0.0.1])
        by duck.linux-mips.net (8.14.4/8.14.4) with ESMTP id p8SDWgI1004838;
        Wed, 28 Sep 2011 15:32:42 +0200
Received: (from ralf@localhost)
        by duck.linux-mips.net (8.14.4/8.14.4/Submit) id p8SDWfCp004837;
        Wed, 28 Sep 2011 15:32:41 +0200
Date:   Wed, 28 Sep 2011 15:32:41 +0200
From:   Ralf Baechle <ralf@linux-mips.org>
To:     David Kuehling <dvdkhlng@gmx.de>
Cc:     linux-mips@linux-mips.org
Subject: Re: [PATCH] add MIPS assembler version of twofish crypto algorithm
Message-ID: <20110928133241.GA30192@linux-mips.org>
References: <87ty9c743i.fsf@snail.Pool>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87ty9c743i.fsf@snail.Pool>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-archive-position: 31182
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

On Sat, Aug 20, 2011 at 12:46:25PM +0200, David Kuehling wrote:

> this patch adds a MIPS assembler version of the twofish cipher
> algorithm.  x86(_64) had an assembler version of twofish for some time
> now, giving it an "unfair" advantage against the not so common
> architectures.
> 
> The code wast put through various tests and benchmarks in a user-space
> testbench, testing its correctness (also via qemu) for 32bit vs. 64bit
> and big vs. little endian MIPS.
> 
> http://mosquito.dyndns.tv/freesvn/trunk/linux/twofish-mips/
> 
> Also the same code backported to a 2.6.39 kernel (64bit) has been
> working flawlessly on my loongson-2f machine (with a twofish dm-crypt
> root) for a few weeks now.
> 
> Performance gain for the pure crypto code in 32-bit mode is about 15% on
> both Ingenic Xburst and Loongson-2f.  With 64-bit it is 24-29%, as the C
> code suffers from 32->64 bit type conversions inserted by gcc.  The code
> uses less unrolling than the C version, and should be smaller by at
> least a factor of 8.  Full results in file Benchres.txt at the SVN URL
> given above.  
> 
> Signed-off-by: David Kühling <dvdkhlng@gmx.de>

Lots of trailing whitespace in that patch.  scripts/checkpatch.pl would
have warned about those …

+#if __mips64
+#  define HAVE_64BIT
+#endif

s/HAVE_64BIT/CONFIG_64BIT/

+#if _MIPS_SZPTR == 32
+#  define PTRADD addu
+#  warning "detected pointer-size as 32-bit"
+#else
+#  ifndef HAVE_64BIT
+#  error "something is broken: detected pointer size > GPR size"
+#  endif
+#  define PTRADD daddu
+#  warning "detected pointer-size as 64-bit"
+#endif

PTR_ADDU from <asm/asm.h> does the same thing as PTRADDU so the entire
ifdefery above can go away.

Finally the use of register names starting with $ is a bit obscure.  Kernel
code needs to build for N64 and O32 but of those only N64 has registers
called $ta0 .. $ta3 which are the equivalent to registers $8 .. $11.

And in O32 registers $t0 ... $t3 also aliases for $8 .. $11.  I haven't
fully analyzed the code to ensure that there is no register conflict
arising from that.

I was surprised that gas assembles the code at all.  $ta0 .. $ta3 are
N32 / N64 register names and consider gas permitting the use of these
registers in O32 a bug - but see my other posting to the binutils list
for that.

Improvment suggestion for le32_fromto_cpu - MIPS 32/64 R2 CPUs can use
the wsbh instruction to faster endianess swapping:

static inline __attribute_const__ __u32 __arch_swab32(__u32 x)
{
        __asm__(
        "       wsbh    %0, %1                  \n"
        "       rotr    %0, %0, 16              \n"
        : "=r" (x)
        : "r" (x));

        return x;
}
#define __arch_swab32 __arch_swab32

This code fragment is from <asm/swab.h>.

+       /* if we turned this into 64-bit ops, we get endianess issues on
+          big-endian mips, plus alignment problems */

Some CPUs (Cavium Octeon) handle unaligned loads in hardware, on others
a combination of LDL / LDR and SDL / SDR could be used to handle the
unaligned loads and DSBH / DSHD (see __arch_swab64 in swab.h) could be
used on MIPS64 R2 CPUs to handle the alignment issues.  Or a rotate -
have to think about it.

  Ralf
