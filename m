Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 20 Feb 2018 23:22:18 +0100 (CET)
Received: from mail.kernel.org ([198.145.29.99]:54102 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23994696AbeBTWWGv-UoS (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 20 Feb 2018 23:22:06 +0100
Received: from saruman (jahogan.plus.com [212.159.75.221])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 37CC421104;
        Tue, 20 Feb 2018 22:21:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 37CC421104
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=jhogan@kernel.org
Date:   Tue, 20 Feb 2018 22:21:53 +0000
From:   James Hogan <jhogan@kernel.org>
To:     Huacai Chen <chenhc@lemote.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        "Steven J . Hill" <Steven.Hill@cavium.com>,
        linux-mips@linux-mips.org, Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>
Subject: Re: [PATCH V2 12/12] MIPS: Loongson: Introduce and use WAR_LLSC_MB
Message-ID: <20180220222153.GG6245@saruman>
References: <1517022752-3053-1-git-send-email-chenhc@lemote.com>
 <1517023381-17624-1-git-send-email-chenhc@lemote.com>
 <1517023381-17624-3-git-send-email-chenhc@lemote.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="vJguvTgX93MxBIIe"
Content-Disposition: inline
In-Reply-To: <1517023381-17624-3-git-send-email-chenhc@lemote.com>
User-Agent: Mutt/1.7.2 (2016-11-26)
Return-Path: <jhogan@kernel.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 62660
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jhogan@kernel.org
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


--vJguvTgX93MxBIIe
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Jan 27, 2018 at 11:23:01AM +0800, Huacai Chen wrote:
> On the Loongson-2G/2H/3A/3B there is a hardware flaw that ll/sc and
> lld/scd is very weak ordering. We should add sync instructions before
> each ll/lld and after the last sc/scd to workaround. Otherwise, this
> flaw will cause deadlock occationally (e.g. when doing heavy load test
> with LTP).

How confident are you that this is the minimal change required to fix
the issue? Is the problem well understood?

It'd be helpful to have some more details about the flaw if you have
them.

I.e. does it really have to be done on every loop iteration (such that
using WEAK_REORDERING_BEYOND_LLSC is insufficient)?

> diff --git a/arch/mips/include/asm/atomic.h b/arch/mips/include/asm/atomi=
c.h
> index 0ab176b..99a6d01 100644
> --- a/arch/mips/include/asm/atomic.h
> +++ b/arch/mips/include/asm/atomic.h
> @@ -62,6 +62,7 @@ static __inline__ void atomic_##op(int i, atomic_t * v)=
			      \
>  		do {							      \
>  			__asm__ __volatile__(				      \
>  			"	.set	"MIPS_ISA_LEVEL"		\n"   \
> +			__WAR_LLSC_MB					      \
>  			"	ll	%0, %1		# atomic_" #op "\n"   \
>  			"	" #asm_op " %0, %2			\n"   \
>  			"	sc	%0, %1				\n"   \
> @@ -69,6 +70,7 @@ static __inline__ void atomic_##op(int i, atomic_t * v)=
			      \
>  			: "=3D&r" (temp), "+" GCC_OFF_SMALL_ASM() (v->counter)  \
>  			: "Ir" (i));					      \
>  		} while (unlikely(!temp));				      \
> +		__asm__ __volatile__(__WAR_LLSC_MB : : :"memory");	      \

This still results in an additional compiler barrier on other platforms,
so if it must remain it needs abstracting.

> diff --git a/arch/mips/include/asm/barrier.h b/arch/mips/include/asm/barr=
ier.h
> index 0e8e6af..268d921 100644
> --- a/arch/mips/include/asm/barrier.h
> +++ b/arch/mips/include/asm/barrier.h
> @@ -203,6 +203,12 @@
>  #define __WEAK_LLSC_MB		"		\n"
>  #endif
> =20
> +#if defined(CONFIG_LOONGSON3) && defined(CONFIG_SMP) /* Loongson-3's LLS=
C workaround */
> +#define __WAR_LLSC_MB		"	sync	\n"
> +#else
> +#define __WAR_LLSC_MB		"		\n"
> +#endif

A comment explaining the whole issue would be helpful for others trying
to decipher this.

> diff --git a/arch/mips/loongson64/Platform b/arch/mips/loongson64/Platform
> index 0fce460..3700dcf 100644
> --- a/arch/mips/loongson64/Platform
> +++ b/arch/mips/loongson64/Platform
> @@ -23,6 +23,9 @@ ifdef CONFIG_CPU_LOONGSON2F_WORKAROUNDS
>  endif
> =20
>  cflags-$(CONFIG_CPU_LOONGSON3)	+=3D -Wa,--trap
> +ifneq ($(call as-option,-Wa$(comma)-mfix-loongson3-llsc,),)
> +  cflags-$(CONFIG_CPU_LOONGSON3) +=3D -Wa$(comma)-mno-fix-loongson3-llsc
> +endif

Could this be a separate patch?

This needs more explanation.
- What does this do exactly?
- Why are you turning *OFF* the compiler fix?
- Was some fix we don't want already in use by default?

> diff --git a/arch/mips/mm/tlbex.c b/arch/mips/mm/tlbex.c
> index 3d3dfba..a507ba7 100644
> --- a/arch/mips/mm/tlbex.c
> +++ b/arch/mips/mm/tlbex.c
> @@ -919,6 +919,8 @@ build_get_pgd_vmalloc64(u32 **p, struct uasm_label **=
l, struct uasm_reloc **r,
>  		 * to mimic that here by taking a load/istream page
>  		 * fault.
>  		 */
> +		if (current_cpu_type() =3D=3D CPU_LOONGSON3)
> +			uasm_i_sync(p, 0);

I suggest abstracting this out with a nice comment explaining why it is
necessary.

Cheers
James

--vJguvTgX93MxBIIe
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEd80NauSabkiESfLYbAtpk944dnoFAlqMn4EACgkQbAtpk944
dnr5cQ/8DB5SKdGbNqhZmtoL1rGq0H5XuKHH39yp2F5qog+cm8v0wiw3KTO4FPK3
YZVI4QvzFrzZMLr0wzsCTzOk2N/gUVOB8LDjrU7aUADztllGhwfyQDZbIUvXA7Jf
hQtvTDdfug/RGmtjR5mDvf3WoXkeZENTfmiQ9L33YKi/OQbwW2uccszVK9YXZ2G9
hYrdBsyJWjWNuRGp/Ed8VWNrYgKgCGZxjxaRB4Ldqpvvc/bLtlcoMUS5KWT5MsFI
vqXgTHDHRADguEJvdQNZwEvG17yqb04rTa8oPGkibFSESgBsy5BDRNB8EIm2GD3J
0bzHZQaLaaVhpnZ+kU6ij5J/dkuKmDNXF1OVtdxkE+kRXN2jO1BDUZqS2JEgweSj
71krSJHpXS+r0ZKX8xzp7S2Ewt/CdyPVo7BFqxE1yx1uQxH17lcQm17YVoJdrLkn
uX8TK+qSEja2lV91I2jcjE7znv9/sALKp++aTtqCiDdkrZ8cCyNHB+QMkuzzf8nf
xFgN986A7PoG5IdBrEmKuzme+UqU4BeZAqUwNK2xDL/Sre7BVAuWB9DWV+2l/LtD
k7MR86nFH3eIXQWaFvIk2KqdVPfolBfzqKmif9JTIBQ8pa9YDmH3sgG0YOfDDyMI
sHSkMN4P8H56f7SDDJkPx+cg2Mqvjw9Ot7YbnwlLQDAxmtNbAa8=
=4sK3
-----END PGP SIGNATURE-----

--vJguvTgX93MxBIIe--
