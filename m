Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g1MAxHc29698
	for linux-mips-outgoing; Fri, 22 Feb 2002 02:59:17 -0800
Received: from mx.mips.com (mx.mips.com [206.31.31.226])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g1MAx3929693
	for <linux-mips@oss.sgi.com>; Fri, 22 Feb 2002 02:59:03 -0800
Received: from newman.mips.com (ns-dmz [206.31.31.225])
	by mx.mips.com (8.9.3/8.9.0) with ESMTP id BAA15024;
	Fri, 22 Feb 2002 01:58:56 -0800 (PST)
Received: from Ulysses (ulysses [192.168.236.13])
	by newman.mips.com (8.9.3/8.9.0) with SMTP id BAA15479;
	Fri, 22 Feb 2002 01:58:54 -0800 (PST)
Message-ID: <006701c1bb87$b2b6fb80$0deca8c0@Ulysses>
From: "Kevin D. Kissell" <kevink@mips.com>
To: "Jun Sun" <jsun@mvista.com>, <linux-mips@oss.sgi.com>
References: <3C75B181.C5A065A1@mvista.com> <3C75C19C.13BB0FCC@mvista.com>
Subject: Re: ieee754_csr is the problem (Re: lazy fpu switch irrelavant to no-fpu  case?
Date: Fri, 22 Feb 2002 10:59:35 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4807.1700
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4807.1700
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

This is what I get for processing my mail in-order.
I just got done writing a message asking if the
ieee_754_csr issue might be at the root of your
problem.

Anyway, rather than create an array of the damned
things, I would think that the "best" thing to do would
be to merge the "abstract" IEEE CSR with the
simulated MIPS CSR (by adding the "noq" and
"nod" bits in otherwise unused/reserved bit positions),
and using the thread-local CSR copy for all of the
ieee_754_csr manipulations, much as I did for
the FP registers.  That would be a bit more intrusive
than your proposed hack, however, and only slightly
more efficient.

            Kevin K.

----- Original Message -----
From: "Jun Sun" <jsun@mvista.com>
To: <linux-mips@oss.sgi.com>
Sent: Friday, February 22, 2002 4:57 AM
Subject: ieee754_csr is the problem (Re: lazy fpu switch irrelavant to
no-fpu case?


> Jun Sun wrote:
> > Anyhow, the problem I am seeing with FPU/SMP case seems to be caused by
FPU
> > emulation code itself, if we can assume it is not caused by fpu context
> > switch.  Right now the FPU is not turned on on the box.
> >
>
> OK, I found the guilt part in FPU emul.  It is the global variable
> ieee754_csr.  The following patch seems to fix the problem.  I am sure
someone
> who are more familiar with FPU might be able to make it more elegant.
>
> There is another global variable which is potentially dangerous for SMP.
It
> is fpuemuprivate.  Currently it is used in almost used for accounting and
> read-only purpose.  I did not bother to change it.  It should be fixed
too, I
> suppose.
>
> Cheers.
>
> Jun


----------------------------------------------------------------------------
----


> diff -Nru linux/arch/mips/math-emu/ieee754.h.orig
linux/arch/mips/math-emu/ieee754.h
> --- linux/arch/mips/math-emu/ieee754.h.orig Thu Jan 31 17:13:26 2002
> +++ linux/arch/mips/math-emu/ieee754.h Thu Feb 21 19:34:06 2002
> @@ -323,7 +323,7 @@
>
>  /* the control status register
>  */
> -struct ieee754_csr {
> +struct ieee754_csr_struct {
>   unsigned pad:13;
>   unsigned nod:1; /* set 1 for no denormalised numbers */
>   unsigned cx:5; /* exceptions this operation */
> @@ -331,7 +331,13 @@
>   unsigned sx:5; /* exceptions total */
>   unsigned rm:2; /* current rounding mode */
>  };
> -extern struct ieee754_csr ieee754_csr;
> +
> +#include <linux/sched.h>
> +#include <linux/threads.h>
> +#include <linux/smp.h>
> +#include <asm/current.h>
> +extern struct ieee754_csr_struct ieee754_csr_array[NR_CPUS];
> +#define ieee754_csr ieee754_csr_array[smp_processor_id()]
>
>  static __inline unsigned ieee754_getrm(void)
>  {
> diff -Nru linux/arch/mips/math-emu/ieee754.c.orig
linux/arch/mips/math-emu/ieee754.c
> --- linux/arch/mips/math-emu/ieee754.c.orig Mon Jan 28 11:17:14 2002
> +++ linux/arch/mips/math-emu/ieee754.c Thu Feb 21 19:37:32 2002
> @@ -52,7 +52,7 @@
>
>  /* the control status register
>  */
> -struct ieee754_csr ieee754_csr;
> +struct ieee754_csr_struct ieee754_csr_array[NR_CPUS];
>
>  /* special constants
>  */
> diff -Nru linux/arch/mips/math-emu/cp1emu.c.orig
linux/arch/mips/math-emu/cp1emu.c
> --- linux/arch/mips/math-emu/cp1emu.c.orig Mon Jan 28 11:17:14 2002
> +++ linux/arch/mips/math-emu/cp1emu.c Thu Feb 21 19:22:45 2002
> @@ -945,7 +945,7 @@
>  static ieee754##p fpemu_##p##_##name (ieee754##p r, ieee754##p s, \
>      ieee754##p t) \
>  { \
> -    struct ieee754_csr ieee754_csr_save; \
> +    struct ieee754_csr_struct ieee754_csr_save; \
>      s = f1 (s, t); \
>      ieee754_csr_save = ieee754_csr; \
>      s = f2 (s, r); \
> diff -Nru linux/arch/mips/math-emu/dp_sqrt.c.orig
linux/arch/mips/math-emu/dp_sqrt.c
> --- linux/arch/mips/math-emu/dp_sqrt.c.orig Thu Feb 21 19:41:09 2002
> +++ linux/arch/mips/math-emu/dp_sqrt.c Thu Feb 21 19:39:08 2002
> @@ -37,7 +37,7 @@
>
>  ieee754dp ieee754dp_sqrt(ieee754dp x)
>  {
> - struct ieee754_csr oldcsr;
> + struct ieee754_csr_struct oldcsr;
>   ieee754dp y, z, t;
>   unsigned scalx, yh;
>   COMPXDP;
>
