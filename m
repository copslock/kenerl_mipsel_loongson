Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 02 Jun 2015 13:39:20 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:16586 "EHLO
        imgpgp01.kl.imgtec.org" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S27006985AbbFBLjRxbp64 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 2 Jun 2015 13:39:17 +0200
Received: from imgpgp01.kl.imgtec.org (imgpgp01.kl.imgtec.org [127.0.0.1])
        by imgpgp01.kl.imgtec.org (PGP Universal) with ESMTP id AC50541F8D69;
        Tue,  2 Jun 2015 12:39:07 +0100 (BST)
Received: from mailapp01.imgtec.com ([10.100.180.241])
  by imgpgp01.kl.imgtec.org (PGP Universal service);
  Tue, 02 Jun 2015 12:39:07 +0100
X-PGP-Universal: processed;
        by imgpgp01.kl.imgtec.org on Tue, 02 Jun 2015 12:39:07 +0100
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id AF41D3CE6791C;
        Tue,  2 Jun 2015 12:39:04 +0100 (IST)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Tue, 2 Jun 2015 12:39:07 +0100
Received: from [192.168.154.110] (192.168.154.110) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.210.2; Tue, 2 Jun
 2015 12:39:07 +0100
Message-ID: <556D95DA.5090305@imgtec.com>
Date:   Tue, 2 Jun 2015 12:39:06 +0100
From:   James Hogan <james.hogan@imgtec.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.6.0
MIME-Version: 1.0
To:     Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>,
        <linux-mips@linux-mips.org>, <benh@kernel.crashing.org>,
        <will.deacon@arm.com>, <linux-kernel@vger.kernel.org>,
        <ralf@linux-mips.org>, <markos.chandras@imgtec.com>,
        <macro@linux-mips.org>, <Steven.Hill@imgtec.com>,
        <alexander.h.duyck@redhat.com>, <davem@davemloft.net>
Subject: Re: [PATCH 2/3] MIPS: enforce LL-SC loop enclosing with SYNC (ACQUIRE
 and RELEASE)
References: <20150602000818.6668.76632.stgit@ubuntu-yegoshin> <20150602000943.6668.28434.stgit@ubuntu-yegoshin>
In-Reply-To: <20150602000943.6668.28434.stgit@ubuntu-yegoshin>
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature";
        boundary="nTANb0nRFCC0PbO4ocQNBCNNiUDeSRbU2"
X-Originating-IP: [192.168.154.110]
X-ESG-ENCRYPT-TAG: f107b6f
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 47785
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: james.hogan@imgtec.com
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

--nTANb0nRFCC0PbO4ocQNBCNNiUDeSRbU2
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Leonid,

On 02/06/15 01:09, Leonid Yegoshin wrote:
> Many MIPS32 R2 and all MIPS R6 CPUs are out of order execution, so it
> needs memory barriers in SMP environment. However, past cores may have
> a pipeline short enough to ignore that requirements and problem may
> never occurs until recently.
>=20
> This patch gives an option to enclose LL-SC loops by SYNC barriers in s=
pinlocks,
> atomics, futexes, cmpxchg and bitops.

Please reflow text.

>=20
> So, this option is defined for MIPS32 R2 only, because that recent

s/that/those/

> CPUs may occasionally have problems in accordance with HW team.

"have problems in accordance with HW team" is a bit confusing. What do
you mean?

> And most of MIPS64 R2 vendor processors already have some kind of memor=
y
> barrier and the only one generic 5KEs has a pretty short pipeline.
>=20
> Using memory barriers in MIPS R6 is mandatory, all that

s/that/those/

> processors have a speculative memory read which can inflict a trouble

s/a //

> without a correct use of barriers in LL-SC loop cycles.
> The same is actually for MIPS32 R5 I5600 processor.

Actually *true*?
P5600 you mean?

Same in Kconfig help text.


>=20
> Signed-off-by: Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>
> ---
>  arch/mips/Kconfig               |   25 +++++++++++++++++++++++++
>  arch/mips/include/asm/barrier.h |   26 ++++++++++++++++++++++----
>  2 files changed, 47 insertions(+), 4 deletions(-)
>=20
> diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
> index c7d0cacece3d..676eb64f5545 100644
> --- a/arch/mips/Kconfig
> +++ b/arch/mips/Kconfig
> @@ -1896,6 +1896,30 @@ config MIPS_LIGHTWEIGHT_SYNC
>  	  converted to generic "SYNC 0".
> =20
>  	  If you unsure, say N here, it may slightly decrease your performanc=
e
> +
> +config MIPS_ENFORCE_WEAK_REORDERING_BEYOND_LLSC
> +	bool "Enforce memory barriers at LLSC loops - atomics, spinlocks etc"=

> +	depends on CPU_MIPS32_R2
> +	default y if CPU_MIPSR6
> +	select WEAK_REORDERING_BEYOND_LLSC
> +	help
> +	  Many MIPS32 R2 and all MIPS R6 CPUs are out of order execution, so =
it
> +	  needs memory barriers in SMP environment. However, past cores may h=
ave
> +	  a pipeline short enough to ignore that requirements and problem may=

> +	  never occurs until recently.
> +
> +	  So, this option is defined for MIPS32 R2 only, because that recent
> +	  CPUs may occasionally have problems in accordance with HW team.
> +	  And MIPS64 R2 vendor processors already have some kind of memory
> +	  barrier and the only one generic 5KEs has a pretty short pipeline.
> +
> +	  Using memory barriers in MIPS R6 is mandatory, all that
> +	  processors have a speculative memory read which can inflict a troub=
le
> +	  without a correct use of barriers in LL-SC loop cycles.
> +	  The same is actually for MIPS32 R5 I5600 processor.
> +
> +	  If you unsure, say Y here, it may slightly decrease your performanc=
e

If you *are* unsure (same in patch 1). Same comment as patch 1 too about
ambiguity of "it".

> +	  but increase a reliability.

well only if the hardware has weak ordering, and only because it would
be technically wrong in that case to say N here.

It feels wrong to be giving the user this option. Can't we just select
WEAK_REORDERING_BEYOND_LLSC automatically based on the hardware that
needs to be supported by the kernel configuration (e.g. CPU_MIPSR6 or
CPU_MIPS32_R2)? Those who care about mips r2 performance on hardware
which doesn't strictly need it can always speak up / add an exception.

Out of interest, are futex operations safe with weak llsc ordering, on
the premise that they're mainly used by userland so ordering with normal
kernel accesses just doesn't matter in practice?

>  endmenu
> =20
>  #
> @@ -1924,6 +1948,7 @@ config CPU_MIPSR2
>  config CPU_MIPSR6
>  	bool
>  	default y if CPU_MIPS32_R6 || CPU_MIPS64_R6
> +	select MIPS_ENFORCE_WEAK_REORDERING_BEYOND_LLSC
>  	select MIPS_SPRAM
> =20
>  config EVA
> diff --git a/arch/mips/include/asm/barrier.h b/arch/mips/include/asm/ba=
rrier.h
> index d2a63abfc7c6..f3cc7a91ac0d 100644
> --- a/arch/mips/include/asm/barrier.h
> +++ b/arch/mips/include/asm/barrier.h
> @@ -95,33 +95,51 @@
>  #  define smp_mb()	__sync()
>  #  define smp_rmb()	barrier()
>  #  define smp_wmb()	__syncw()
> +#  define smp_acquire() __sync()
> +#  define smp_release() __sync()
>  # else
>  #  ifdef CONFIG_MIPS_LIGHTWEIGHT_SYNC
>  #  define smp_mb()      __asm__ __volatile__("sync 0x10" : : :"memory"=
)
>  #  define smp_rmb()     __asm__ __volatile__("sync 0x13" : : :"memory"=
)
>  #  define smp_wmb()     __asm__ __volatile__("sync 0x4" : : :"memory")=

> +#  define smp_acquire() __asm__ __volatile__("sync 0x11" : : :"memory"=
)
> +#  define smp_release() __asm__ __volatile__("sync 0x12" : : :"memory"=
)

same question about use of sync_acquire/sync_release instructions which
binutils understands since 2.21.

>  #  else
>  #  define smp_mb()	__asm__ __volatile__("sync" : : :"memory")
>  #  define smp_rmb()	__asm__ __volatile__("sync" : : :"memory")
>  #  define smp_wmb()	__asm__ __volatile__("sync" : : :"memory")
> +#  define smp_acquire() __asm__ __volatile__("sync" : : :"memory")
> +#  define smp_release() __asm__ __volatile__("sync" : : :"memory")
>  #  endif
>  # endif
>  #else
>  #define smp_mb()	barrier()
>  #define smp_rmb()	barrier()
>  #define smp_wmb()	barrier()
> +#define smp_acquire()   barrier()
> +#define smp_release()   barrier()
>  #endif
> =20
>  #if defined(CONFIG_WEAK_REORDERING_BEYOND_LLSC) && defined(CONFIG_SMP)=

> +#ifdef CONFIG_MIPS_LIGHTWEIGHT_SYNC
> +#define __WEAK_LLSC_MB          "       sync    0x10    \n"
> +#define __WEAK_ACQUIRE          "       sync    0x11    \n"
> +#define __WEAK_RELEASE          "       sync    0x12    \n"

tabs

__WEAK_ACQUIRE and __WEAK_RELEASE are specific to llsc, maybe call them
__WEAK_LLSC_ACQUIRE and __WEAK_LLSC_RELEASE instead to avoid confusion.


> +#else
>  #define __WEAK_LLSC_MB		"	sync	\n"
> +#define __WEAK_ACQUIRE          __WEAK_LLSC_MB
> +#define __WEAK_RELEASE          __WEAK_LLSC_MB

tabs

> +#endif
>  #else
>  #define __WEAK_LLSC_MB		"		\n"
> +#define __WEAK_ACQUIRE          __WEAK_LLSC_MB
> +#define __WEAK_RELEASE          __WEAK_LLSC_MB

tabs

>  #endif
> =20
>  #define set_mb(var, value) \
>  	do { var =3D value; smp_mb(); } while (0)
> =20
> -#define smp_llsc_mb()	__asm__ __volatile__(__WEAK_LLSC_MB : : :"memory=
")
> +#define smp_llsc_mb()           __asm__ __volatile__(__WEAK_ACQUIRE : =
: :"memory")

tabs

> =20
>  #ifdef CONFIG_CPU_CAVIUM_OCTEON
>  #define smp_mb__before_llsc() smp_wmb()
> @@ -131,14 +149,14 @@
>  					    "syncw\n\t"			\
>  					    ".set pop" : : : "memory")
>  #else
> -#define smp_mb__before_llsc() smp_llsc_mb()
> +#define smp_mb__before_llsc()   __asm__ __volatile__(__WEAK_RELEASE : =
: :"memory")
>  #define nudge_writes() mb()
>  #endif
> =20
>  #define smp_store_release(p, v)						\
>  do {									\
>  	compiletime_assert_atomic_type(*p);				\
> -	smp_mb();							\
> +	smp_release();                                                       =
\
>  	ACCESS_ONCE(*p) =3D (v);						\
>  } while (0)
> =20
> @@ -146,7 +164,7 @@ do {									\
>  ({									\
>  	typeof(*p) ___p1 =3D ACCESS_ONCE(*p);				\
>  	compiletime_assert_atomic_type(*p);				\
> -	smp_mb();							\
> +	smp_acquire();                                                       =
\
>  	___p1;								\
>  })
> =20
>=20
>=20

This patch does 3 logically separable things:
1) add smp_release/smp_acquire based on MIPS_LIGHTWEIGHT_SYNC and weaken
smp_store_release()/smp_load_acquire() to use them.
2) weaken llsc barriers when MIPS_LIGHTWEIGHT_SYNC.
3) the MIPS_ENFORCE_WEAK_REORDERING_BEYOND_LLSC Kconfig stuff (or
whatever method to select WEAK_REORDERING_BEYOND_LLSC more often).

Any reason not to split them, and give a clear description of each?

Cheers
James


--nTANb0nRFCC0PbO4ocQNBCNNiUDeSRbU2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJVbZXaAAoJEGwLaZPeOHZ6QYAQALr2zLfdn3wPdY/8eJCiAcUL
kX3jUHO0hl6fzxXztrn5Mvo0ptmHWyNc30zAtAu4QMOR4gVHrVj3m4p8iiTFTYiy
jVbXw6bnIH1MIzEKfw1FMjTrGL1awOxRZkmOAbG3aPOrEkN91IFU7u43fn7Tde45
/JUFXrcO0EClY2Kmv6myh7+SPACehTc1KHt1ToVzSpIBN1alzLuuOrEEhz5J0S8s
I6mYOReZpi3p+PJib1jO1Uwf+JHzRft1o8cX58UjcUHxQnL1qd/4BsDdRjMhXquy
TQ8uns/5mT+Ptiaix42yAnnE120Czc83XDESDlgdpkbV1LcT/MkjVWtzMXIyCoOF
TBu08agktx9N+aOv+vaPZwj8NLVW8fyxcrMB3r7JO4HTwxD7R5fKmYmejd/kUCLs
JYoE8lslqnwQHne40gwgbUkCLyrcyRYKQUqdCM/6JOdwpAeRjahuqU9cWOoI9Mmt
lFbu7bkFTq6C94Vko6xyadB+J4OGQjEDTmo6WcbrIkc5nznF2A2d3n9yMSd+79O5
/Ea4kzLIJN3fF06T6YuGDYsZpkTDLVGZPVfW1GtC9VsLGkbjNKYTbZKD3aZeVnSe
qtWkT1OkUSfO3jr7MmdlPgZ/z/U7tAbR2B7RiCGzUEtKWytBXMPoyeBvTYekpOEM
7uovnMRDHGTeVAhaajJC
=kYhh
-----END PGP SIGNATURE-----

--nTANb0nRFCC0PbO4ocQNBCNNiUDeSRbU2--
