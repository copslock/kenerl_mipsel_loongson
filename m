Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 12 Jun 2017 21:02:22 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:45022 "EHLO
        imgpgp01.kl.imgtec.org" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S23991960AbdFLTCPTObAn (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 12 Jun 2017 21:02:15 +0200
Received: from imgpgp01.kl.imgtec.org (imgpgp01.kl.imgtec.org [127.0.0.1])
        by imgpgp01.kl.imgtec.org (PGP Universal) with ESMTP id 6F4E041F8E74;
        Mon, 12 Jun 2017 21:11:29 +0100 (BST)
Received: from mailapp01.imgtec.com ([10.100.180.241])
  by imgpgp01.kl.imgtec.org (PGP Universal service);
  Mon, 12 Jun 2017 21:11:29 +0100
X-PGP-Universal: processed;
        by imgpgp01.kl.imgtec.org on Mon, 12 Jun 2017 21:11:29 +0100
Received: from hhmail02.hh.imgtec.org (unknown [10.100.10.20])
        by Forcepoint Email with ESMTPS id 93DB7EBCC4C23;
        Mon, 12 Jun 2017 20:02:05 +0100 (IST)
Received: from BAMAIL02.ba.imgtec.org (10.20.40.28) by hhmail02.hh.imgtec.org
 (10.100.10.20) with Microsoft SMTP Server (TLS) id 14.3.294.0; Mon, 12 Jun
 2017 20:02:09 +0100
Received: from np-p-burton.localnet (10.20.1.33) by bamail02.ba.imgtec.org
 (10.20.40.28) with Microsoft SMTP Server (TLS) id 14.3.266.1; Mon, 12 Jun
 2017 12:02:07 -0700
From:   Paul Burton <paul.burton@imgtec.com>
To:     Joshua Kinard <kumba@gentoo.org>
CC:     <linux-mips@linux-mips.org>, Ralf Baechle <ralf@linux-mips.org>
Subject: Re: [PATCH 01/11] MIPS: cmpxchg: Unify R10000_LLSC_WAR & non-R10000_LLSC_WAR cases
Date:   Mon, 12 Jun 2017 12:02:01 -0700
Message-ID: <6427792.nLi7RegdSm@np-p-burton>
Organization: Imagination Technologies
In-Reply-To: <66c7456a-0ae6-5442-2b12-a442055f36d1@gentoo.org>
References: <20170610002644.8434-1-paul.burton@imgtec.com> <20170610002644.8434-2-paul.burton@imgtec.com> <66c7456a-0ae6-5442-2b12-a442055f36d1@gentoo.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart3366342.sDpYB3xtNi";
        micalg=pgp-sha256; protocol="application/pgp-signature"
X-Originating-IP: [10.20.1.33]
X-ESG-ENCRYPT-TAG: 1b7d744b
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 58414
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: paul.burton@imgtec.com
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

--nextPart3366342.sDpYB3xtNi
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Hi Joshua,

On Saturday, 10 June 2017 16:25:30 PDT Joshua Kinard wrote:
> On 06/09/2017 20:26, Paul Burton wrote:
> > Prior to this patch the xchg & cmpxchg functions have duplicated code
> > which is for all intents & purposes identical apart from use of a
> > branch-likely instruction in the R10000_LLSC_WAR case & a regular branch
> > instruction in the non-R10000_LLSC_WAR case.
> > 
> > This patch removes the duplication, declaring a __scbeqz macro to select
> > the branch instruction suitable for use when checking the result of an
> > sc instruction & making use of it to unify the 2 cases.
> > 
> > In __xchg_u{32,64}() this means writing the branch in asm, where it was
> > previously being done in C as a do...while loop for the
> > non-R10000_LLSC_WAR case. As this is a single instruction, and adds
> > consistency with the R10000_LLSC_WAR cases & the cmpxchg() code, this
> > seems worthwhile.
> 
> IMHO, a good cleanup.  I'll test shortly on my Octane once I get some things
> moved around and a new kernel tree set up.

Thanks :)

> That said, there are a number
> of locations where R10000_LLSC_WAR is used in this manner, and I think this
> change should be broken out into its own patch series, with the macro that
> selects normal branch over branch-likely, placed into a main MIPS header
> file somewhere, and the same change made to all locations at once.  That'll
> give some consistency to everything.

I agree that it might be good to generalise this approach & use it elsewhere 
too, but I'd prefer that happen in further patches so that it doesn't hold up 
the rest of these cmpxchg() & locking changes.

> I don't think any of my SGI systems have the specific R10K revision that's
> affected.  I've been building kernels for a while now with a patch that
> splits the R10K CPU selection up into vanilla R10K, and then
> R12K/R14K/R16K, and using the non-R10000_LLSC_WAR path for R12K and up, as
> many of my SGI systems have at least R12K processors.  My IP28 might have
> the older, affected R10K, but I haven't tested that out since 4.4 (it
> didn't survive for very long, either).
> 
> I also wonder if "__scbeqz" is a descriptive-enough name.  It works in this
> case because the macro definition is at the top, but if moved to a different
> header file, perhaps something more like "__r10k_b_insn" or such may clue
> casual readers in some more?

Hmm, the issue then is that the name is shared for the r10k & non-r10k cases 
so putting r10k in the name seems a bit misleading. __scbeqz at least hints 
that it's the variant of beqz to be used to compare the result of an sc.

Thanks,
    Paul

> 
> --J
> 
> > Signed-off-by: Paul Burton <paul.burton@imgtec.com>
> > Cc: Ralf Baechle <ralf@linux-mips.org>
> > Cc: linux-mips@linux-mips.org
> > ---
> > 
> >  arch/mips/include/asm/cmpxchg.h | 80
> >  ++++++++++++----------------------------- 1 file changed, 22
> >  insertions(+), 58 deletions(-)
> > 
> > diff --git a/arch/mips/include/asm/cmpxchg.h
> > b/arch/mips/include/asm/cmpxchg.h index b71ab4a5fd50..0582c01d229d 100644
> > --- a/arch/mips/include/asm/cmpxchg.h
> > +++ b/arch/mips/include/asm/cmpxchg.h
> > @@ -13,44 +13,38 @@
> > 
> >  #include <asm/compiler.h>
> >  #include <asm/war.h>
> > 
> > +/*
> > + * Using a branch-likely instruction to check the result of an sc
> > instruction + * works around a bug present in R10000 CPUs prior to
> > revision 3.0 that could + * cause ll-sc sequences to execute
> > non-atomically.
> > + */
> > +#if R10000_LLSC_WAR
> > +# define __scbeqz "beqzl"
> > +#else
> > +# define __scbeqz "beqz"
> > +#endif
> > +
> > 
> >  static inline unsigned long __xchg_u32(volatile int * m, unsigned int
> >  val)
> >  {
> >  
> >  	__u32 retval;
> >  	
> >  	smp_mb__before_llsc();
> > 
> > -	if (kernel_uses_llsc && R10000_LLSC_WAR) {
> > +	if (kernel_uses_llsc) {
> > 
> >  		unsigned long dummy;
> >  		
> >  		__asm__ __volatile__(
> > 
> > -		"	.set	arch=r4000				\n"
> > +		"	.set	" MIPS_ISA_ARCH_LEVEL "			\n"
> > 
> >  		"1:	ll	%0, %3			# xchg_u32	\n"
> >  		"	.set	mips0					\n"
> >  		"	move	%2, %z4					\n"
> > 
> > -		"	.set	arch=r4000				\n"
> > +		"	.set	" MIPS_ISA_ARCH_LEVEL "			\n"
> > 
> >  		"	sc	%2, %1					\n"
> > 
> > -		"	beqzl	%2, 1b					\n"
> > +		"\t" __scbeqz "	%2, 1b					\n"
> > 
> >  		"	.set	mips0					\n"
> >  		
> >  		: "=&r" (retval), "=" GCC_OFF_SMALL_ASM() (*m), "=&r" (dummy)
> >  		: GCC_OFF_SMALL_ASM() (*m), "Jr" (val)
> >  		: "memory");
> > 
> > -	} else if (kernel_uses_llsc) {
> > -		unsigned long dummy;
> > -
> > -		do {
> > -			__asm__ __volatile__(
> > -			"	.set	"MIPS_ISA_ARCH_LEVEL"		\n"
> > -			"	ll	%0, %3		# xchg_u32	\n"
> > -			"	.set	mips0				\n"
> > -			"	move	%2, %z4				\n"
> > -			"	.set	"MIPS_ISA_ARCH_LEVEL"		\n"
> > -			"	sc	%2, %1				\n"
> > -			"	.set	mips0				\n"
> > -			: "=&r" (retval), "=" GCC_OFF_SMALL_ASM() (*m),
> > -			  "=&r" (dummy)
> > -			: GCC_OFF_SMALL_ASM() (*m), "Jr" (val)
> > -			: "memory");
> > -		} while (unlikely(!dummy));
> > 
> >  	} else {
> >  	
> >  		unsigned long flags;
> > 
> > @@ -72,34 +66,19 @@ static inline __u64 __xchg_u64(volatile __u64 * m,
> > __u64 val)> 
> >  	smp_mb__before_llsc();
> > 
> > -	if (kernel_uses_llsc && R10000_LLSC_WAR) {
> > +	if (kernel_uses_llsc) {
> > 
> >  		unsigned long dummy;
> >  		
> >  		__asm__ __volatile__(
> > 
> > -		"	.set	arch=r4000				\n"
> > +		"	.set	" MIPS_ISA_ARCH_LEVEL "			\n"
> > 
> >  		"1:	lld	%0, %3			# xchg_u64	\n"
> >  		"	move	%2, %z4					\n"
> >  		"	scd	%2, %1					\n"
> > 
> > -		"	beqzl	%2, 1b					\n"
> > +		"\t" __scbeqz "	%2, 1b					\n"
> > 
> >  		"	.set	mips0					\n"
> >  		
> >  		: "=&r" (retval), "=" GCC_OFF_SMALL_ASM() (*m), "=&r" (dummy)
> >  		: GCC_OFF_SMALL_ASM() (*m), "Jr" (val)
> >  		: "memory");
> > 
> > -	} else if (kernel_uses_llsc) {
> > -		unsigned long dummy;
> > -
> > -		do {
> > -			__asm__ __volatile__(
> > -			"	.set	"MIPS_ISA_ARCH_LEVEL"		\n"
> > -			"	lld	%0, %3		# xchg_u64	\n"
> > -			"	move	%2, %z4				\n"
> > -			"	scd	%2, %1				\n"
> > -			"	.set	mips0				\n"
> > -			: "=&r" (retval), "=" GCC_OFF_SMALL_ASM() (*m),
> > -			  "=&r" (dummy)
> > -			: GCC_OFF_SMALL_ASM() (*m), "Jr" (val)
> > -			: "memory");
> > -		} while (unlikely(!dummy));
> > 
> >  	} else {
> >  	
> >  		unsigned long flags;
> > 
> > @@ -142,24 +121,7 @@ static inline unsigned long __xchg(unsigned long x,
> > volatile void * ptr, int siz> 
> >  ({									\
> >  
> >  	__typeof(*(m)) __ret;						\
> >  	
> >  									\
> > 
> > -	if (kernel_uses_llsc && R10000_LLSC_WAR) {			\
> > -		__asm__ __volatile__(					\
> > -		"	.set	push				\n"	\
> > -		"	.set	noat				\n"	\
> > -		"	.set	arch=r4000			\n"	\
> > -		"1:	" ld "	%0, %2		# __cmpxchg_asm \n"	\
> > -		"	bne	%0, %z3, 2f			\n"	\
> > -		"	.set	mips0				\n"	\
> > -		"	move	$1, %z4				\n"	\
> > -		"	.set	arch=r4000			\n"	\
> > -		"	" st "	$1, %1				\n"	\
> > -		"	beqzl	$1, 1b				\n"	\
> > -		"2:						\n"	\
> > -		"	.set	pop				\n"	\
> > -		: "=&r" (__ret), "=" GCC_OFF_SMALL_ASM() (*m)		\
> > -		: GCC_OFF_SMALL_ASM() (*m), "Jr" (old), "Jr" (new)		\
> > -		: "memory");						\
> > -	} else if (kernel_uses_llsc) {					\
> > +	if (kernel_uses_llsc) {						\
> > 
> >  		__asm__ __volatile__(					\
> >  		"	.set	push				\n"	\
> >  		"	.set	noat				\n"	\
> > 
> > @@ -170,7 +132,7 @@ static inline unsigned long __xchg(unsigned long x,
> > volatile void * ptr, int siz> 
> >  		"	move	$1, %z4				\n"	\
> >  		"	.set	"MIPS_ISA_ARCH_LEVEL"		\n"	\
> >  		"	" st "	$1, %1				\n"	\
> > 
> > -		"	beqz	$1, 1b				\n"	\
> > +		"\t" __scbeqz "	$1, 1b				\n"	\
> > 
> >  		"	.set	pop				\n"	\
> >  		"2:						\n"	\
> >  		
> >  		: "=&r" (__ret), "=" GCC_OFF_SMALL_ASM() (*m)		\
> > 
> > @@ -245,4 +207,6 @@ extern void __cmpxchg_called_with_bad_pointer(void);
> > 
> >  #define cmpxchg64(ptr, o, n) cmpxchg64_local((ptr), (o), (n))
> >  #endif
> > 
> > +#undef __scbeqz
> > +
> > 
> >  #endif /* __ASM_CMPXCHG_H */


--nextPart3366342.sDpYB3xtNi
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEELIGR03D5+Fg+69wPgiDZ+mk8HGUFAlk+5SkACgkQgiDZ+mk8
HGU5dw//V4hNWMOktOUZdNZiRr2D/z94B4bRo2FLB7eeuT9Sge0RDj4b4ChjVnOO
AH3bUkB/uQumkSWu4gcqYtJC2wTsXVhapljN77/BWXasd5zYtOoLvJG7S6x4lA0E
oB93rZEwB83olMNZIlttu2dIfz1D0d3j49j+CTWFFGZCtSdcA2C6XzLVuEYTZKyP
c+mGHMEkJI4uPirSgI3nEpWG7L0YoSgDQp0PKHrG8RbscZa+0lC2Yc54cNzNxUt6
5axmeRTUFPaL8oZsCnkeuKwappn3jFHc4XOFPFJ/QU9Q0N5NQ7ojcaJBOK7iAGYk
XZRShkXxC635Ef7bCgNul5RoDsprUx0+ka9+5tTEwp22kVQvuy4S13KVKM/lDBZZ
v8wLxsQA7gH3/tm7JSepJCsyEmcuWOYjF259YJGEEHlmIxWvhQNBEgc89ohka2oS
NxDKJVVc4cvLoTAqDFTt82JYOg4mjlE67sLzNqxsv9xuL2TSjBG8Ys3p8E+Rquh0
C75Xfhel4GOqGaOJj6GvO6f6xnmQhHih/8pVTQP8BJKUl8XNdAvOQ3EVsTcVCDCP
VrKQDs638WeuBjNtqGD5jfXPyHREIzNV+jnAgQJPxPXVnQVTfyPkNOs+giInMXLB
uurSmzhGpjOffq3lnUYlmxnCWSVdrkcD160/RxTVBQZeUQA7gV0=
=l++e
-----END PGP SIGNATURE-----

--nextPart3366342.sDpYB3xtNi--
