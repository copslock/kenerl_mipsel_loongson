Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 26 Jan 2016 15:19:19 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:35383 "EHLO
        imgpgp01.kl.imgtec.org" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S27011295AbcAZOTP4qe70 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 26 Jan 2016 15:19:15 +0100
Received: from imgpgp01.kl.imgtec.org (imgpgp01.kl.imgtec.org [127.0.0.1])
        by imgpgp01.kl.imgtec.org (PGP Universal) with ESMTP id 8C4E141F8E4F;
        Tue, 26 Jan 2016 14:19:10 +0000 (GMT)
Received: from mailapp01.imgtec.com ([10.100.180.242])
  by imgpgp01.kl.imgtec.org (PGP Universal service);
  Tue, 26 Jan 2016 14:19:10 +0000
X-PGP-Universal: processed;
        by imgpgp01.kl.imgtec.org on Tue, 26 Jan 2016 14:19:10 +0000
Received: from hhmail02.hh.imgtec.org (unknown [10.100.10.20])
        by Websense Email Security Gateway with ESMTPS id 55398F306C26F;
        Tue, 26 Jan 2016 14:19:08 +0000 (GMT)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 hhmail02.hh.imgtec.org (10.100.10.20) with Microsoft SMTP Server (TLS) id
 14.3.235.1; Tue, 26 Jan 2016 14:19:10 +0000
Received: from localhost (192.168.154.110) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.210.2; Tue, 26 Jan
 2016 14:19:09 +0000
Date:   Tue, 26 Jan 2016 14:19:09 +0000
From:   James Hogan <james.hogan@imgtec.com>
To:     Huacai Chen <chenhc@lemote.com>
CC:     Ralf Baechle <ralf@linux-mips.org>,
        Aurelien Jarno <aurelien@aurel32.net>,
        "Steven J. Hill" <Steven.Hill@imgtec.com>,
        <linux-mips@linux-mips.org>, "Fuxin Zhang" <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>
Subject: Re: [PATCH 6/6] MIPS: Loongson-3: Introduce
 CONFIG_LOONGSON3_ENHANCEMENT
Message-ID: <20160126141909.GB12365@jhogan-linux.le.imgtec.org>
References: <1453814784-14230-1-git-send-email-chenhc@lemote.com>
 <1453814784-14230-7-git-send-email-chenhc@lemote.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="OwLcNYc0lM97+oe1"
Content-Disposition: inline
In-Reply-To: <1453814784-14230-7-git-send-email-chenhc@lemote.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Originating-IP: [192.168.154.110]
X-ESG-ENCRYPT-TAG: 30575414
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 51411
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

--OwLcNYc0lM97+oe1
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 26, 2016 at 09:26:24PM +0800, Huacai Chen wrote:
> New Loongson 3 CPU (since Loongson-3A R2, as opposed to Loongson-3A R1,
> Loongson-3B R1 and Loongson-3B R2) has many enhancements, such as FTLB,
> L1-VCache, EI/DI/Wait/Prefetch instruction, DSP/DSPv2 ASE, User Local
> register, Read-Inhibit/Execute-Inhibit, SFB (Store Fill Buffer), Fast
> TLB refill support, etc.
>=20
> This patch introduce a config option, CONFIG_LOONGSON3_ENHANCEMENT, to
> enable those enhancements which cannot be probed at run time. If you
> want a generic kernel to run on all Loongson 3 machines, please say 'N'
> here. If you want a high-performance kernel to run on new Loongson 3
> machines only, please say 'Y' here.
>=20
> Signed-off-by: Huacai Chen <chenhc@lemote.com>
> ---
>  arch/mips/Kconfig                                      | 18 ++++++++++++=
++++++
>  arch/mips/include/asm/hazards.h                        |  7 ++++---
>  arch/mips/include/asm/io.h                             | 10 +++++-----
>  arch/mips/include/asm/irqflags.h                       |  5 +++++
>  .../include/asm/mach-loongson64/kernel-entry-init.h    | 12 ++++++++++++
>  arch/mips/mm/c-r4k.c                                   |  3 +++
>  arch/mips/mm/page.c                                    |  9 +++++++++
>  7 files changed, 56 insertions(+), 8 deletions(-)
>=20
> diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
> index 15faaf0..e6d6f7b 100644
> --- a/arch/mips/Kconfig
> +++ b/arch/mips/Kconfig
> @@ -1349,6 +1349,24 @@ config CPU_LOONGSON3
>  		The Loongson 3 processor implements the MIPS64R2 instruction
>  		set with many extensions.
> =20
> +config LOONGSON3_ENHANCEMENT
> +	bool "New Loongson 3 CPU Enhancements"
> +	default n

no need, n is the default.

> +	select CPU_MIPSR2
> +	select CPU_HAS_PREFETCH
> +	depends on CPU_LOONGSON3
> +	help
> +	  New Loongson 3 CPU (since Loongson-3A R2, as opposed to Loongson-3A
> +	  R1, Loongson-3B R1 and Loongson-3B R2) has many enhancements, such as
> +	  FTLB, L1-VCache, EI/DI/Wait/Prefetch instruction, DSP/DSPv2 ASE, User
> +	  Local register, Read-Inhibit/Execute-Inhibit, SFB (Store Fill Buffer),
> +	  Fast TLB refill support, etc.
> +
> +	  This option enable those enhancements which cannot be probed at run
> +	  time. If you want a generic kernel to run on all Loongson 3 machines,
> +	  please say 'N' here. If you want a high-performance kernel to run on
> +	  new Loongson 3 machines only, please say 'Y' here.
> +
>  config CPU_LOONGSON2E
>  	bool "Loongson 2E"
>  	depends on SYS_HAS_CPU_LOONGSON2E
> diff --git a/arch/mips/include/asm/hazards.h b/arch/mips/include/asm/haza=
rds.h
> index 7b99efd..dbb1eb6 100644
> --- a/arch/mips/include/asm/hazards.h
> +++ b/arch/mips/include/asm/hazards.h
> @@ -22,7 +22,8 @@
>  /*
>   * TLB hazards
>   */
> -#if defined(CONFIG_CPU_MIPSR2) || defined(CONFIG_CPU_MIPSR6) && !defined=
(CONFIG_CPU_CAVIUM_OCTEON)
> +#if (defined(CONFIG_CPU_MIPSR2) || defined(CONFIG_CPU_MIPSR6)) && \
> +	!defined(CONFIG_CPU_CAVIUM_OCTEON) && !defined(CONFIG_LOONGSON3_ENHANCE=
MENT)
> =20
>  /*
>   * MIPSR2 defines ehb for hazard avoidance
> @@ -155,8 +156,8 @@ do {									\
>  } while (0)
> =20
>  #elif defined(CONFIG_MIPS_ALCHEMY) || defined(CONFIG_CPU_CAVIUM_OCTEON) =
|| \
> -	defined(CONFIG_CPU_LOONGSON2) || defined(CONFIG_CPU_R10000) || \
> -	defined(CONFIG_CPU_R5500) || defined(CONFIG_CPU_XLR)
> +	defined(CONFIG_CPU_LOONGSON2) || defined(CONFIG_LOONGSON3_ENHANCEMENT) =
|| \
> +	defined(CONFIG_CPU_R10000) || defined(CONFIG_CPU_R5500) || defined(CONF=
IG_CPU_XLR)
> =20
>  /*
>   * R10000 rocks - all hazards handled in hardware, so this becomes a nob=
rainer.
> diff --git a/arch/mips/include/asm/io.h b/arch/mips/include/asm/io.h
> index 2b4dc7a..ecabc00 100644
> --- a/arch/mips/include/asm/io.h
> +++ b/arch/mips/include/asm/io.h
> @@ -304,10 +304,10 @@ static inline void iounmap(const volatile void __io=
mem *addr)
>  #undef __IS_KSEG1
>  }
> =20
> -#ifdef CONFIG_CPU_CAVIUM_OCTEON
> -#define war_octeon_io_reorder_wmb()		wmb()
> +#if defined(CONFIG_CPU_CAVIUM_OCTEON) || defined(CONFIG_LOONGSON3_ENHANC=
EMENT)
> +#define war_io_reorder_wmb()		wmb()
>  #else
> -#define war_octeon_io_reorder_wmb()		do { } while (0)
> +#define war_io_reorder_wmb()		do { } while (0)
>  #endif

Doesn't this slow things down when enabled, or is it required due to
STFill buffer being enabled or something?

> =20
>  #define __BUILD_MEMORY_SINGLE(pfx, bwlq, type, irq)			\
> @@ -318,7 +318,7 @@ static inline void pfx##write##bwlq(type val,				\
>  	volatile type *__mem;						\
>  	type __val;							\
>  									\
> -	war_octeon_io_reorder_wmb();					\
> +	war_io_reorder_wmb();					\
>  									\
>  	__mem =3D (void *)__swizzle_addr_##bwlq((unsigned long)(mem));	\
>  									\
> @@ -387,7 +387,7 @@ static inline void pfx##out##bwlq##p(type val, unsign=
ed long port)	\
>  	volatile type *__addr;						\
>  	type __val;							\
>  									\
> -	war_octeon_io_reorder_wmb();					\
> +	war_io_reorder_wmb();					\
>  									\
>  	__addr =3D (void *)__swizzle_addr_##bwlq(mips_io_port_base + port); \
>  									\
> diff --git a/arch/mips/include/asm/irqflags.h b/arch/mips/include/asm/irq=
flags.h
> index 65c351e..12f80b5 100644
> --- a/arch/mips/include/asm/irqflags.h
> +++ b/arch/mips/include/asm/irqflags.h
> @@ -41,7 +41,12 @@ static inline unsigned long arch_local_irq_save(void)
>  	"	.set	push						\n"
>  	"	.set	reorder						\n"
>  	"	.set	noat						\n"
> +#if defined(CONFIG_LOONGSON3_ENHANCEMENT)
> +	"	mfc0	%[flags], $12					\n"
> +	"	di							\n"

Does this somehow help performance, or is it necessary when STFill
buffer is enabled?

> +#else
>  	"	di	%[flags]					\n"
> +#endif
>  	"	andi	%[flags], 1					\n"
>  	"	" __stringify(__irq_disable_hazard) "			\n"
>  	"	.set	pop						\n"
> diff --git a/arch/mips/include/asm/mach-loongson64/kernel-entry-init.h b/=
arch/mips/include/asm/mach-loongson64/kernel-entry-init.h
> index da83482..8393bc54 100644
> --- a/arch/mips/include/asm/mach-loongson64/kernel-entry-init.h
> +++ b/arch/mips/include/asm/mach-loongson64/kernel-entry-init.h
> @@ -26,6 +26,12 @@
>  	mfc0	t0, $5, 1
>  	or	t0, (0x1 << 29)
>  	mtc0	t0, $5, 1
> +#ifdef CONFIG_LOONGSON3_ENHANCEMENT
> +	/* Enable STFill Buffer */
> +	mfc0	t0, $16, 6
> +	or	t0, 0x100
> +	mtc0	t0, $16, 6
> +#endif
>  	_ehb
>  	.set	pop
>  #endif
> @@ -46,6 +52,12 @@
>  	mfc0	t0, $5, 1
>  	or	t0, (0x1 << 29)
>  	mtc0	t0, $5, 1
> +#ifdef CONFIG_LOONGSON3_ENHANCEMENT
> +	/* Enable STFill Buffer */
> +	mfc0	t0, $16, 6
> +	or	t0, 0x100
> +	mtc0	t0, $16, 6
> +#endif

What does the STFill buffer do?

Given that you can get a portable kernel without this, can this not be
done from C code depending on the PRid?

>  	_ehb
>  	.set	pop
>  #endif
> diff --git a/arch/mips/mm/c-r4k.c b/arch/mips/mm/c-r4k.c
> index 65fb28c..903d8da 100644
> --- a/arch/mips/mm/c-r4k.c
> +++ b/arch/mips/mm/c-r4k.c
> @@ -1170,6 +1170,9 @@ static void probe_pcache(void)
>  					  c->dcache.ways *
>  					  c->dcache.linesz;
>  		c->dcache.waybit =3D 0;
> +#ifdef CONFIG_CPU_HAS_PREFETCH
> +		c->options |=3D MIPS_CPU_PREFETCH;
> +#endif

Can't do that based on PRid?

Cheers
James

>  		break;
> =20
>  	case CPU_CAVIUM_OCTEON3:
> diff --git a/arch/mips/mm/page.c b/arch/mips/mm/page.c
> index 885d73f..c41953c 100644
> --- a/arch/mips/mm/page.c
> +++ b/arch/mips/mm/page.c
> @@ -188,6 +188,15 @@ static void set_prefetch_parameters(void)
>  			}
>  			break;
> =20
> +		case CPU_LOONGSON3:
> +			/* Loongson-3 only support the Pref_Load/Pref_Store. */
> +			pref_bias_clear_store =3D 128;
> +			pref_bias_copy_load =3D 128;
> +			pref_bias_copy_store =3D 128;
> +			pref_src_mode =3D Pref_Load;
> +			pref_dst_mode =3D Pref_Store;
> +			break;
> +
>  		default:
>  			pref_bias_clear_store =3D 128;
>  			pref_bias_copy_load =3D 256;
> --=20
> 2.4.6
>=20
>=20
>=20
>=20
>=20

--OwLcNYc0lM97+oe1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJWp4BdAAoJEGwLaZPeOHZ64/YP/32tZ2dh2qaCQ23/OmyiDPOb
pHXFdO4Rw/GHcGADkPaUGwzhCemClwFk50hca+4BiO8eoeOpDStc03wwdFi3ROaQ
VPccSUv5mQqlEsIvCRymHkZb+9JFu2jvQTO2q/7vyjneZuctWzaUGfNWKMa/7TR/
g2YGcOmniuESTeCiWqhvRH84nTfheDtASocQkidhX3MkmgElz69rU5BqPdpx34sS
odMUTli9YqtaiPsKL9JWmXukEVXTeFZvGRkpOqNPvakaL5U2phWxygH8gWZip1yt
jZItE/ST7L9SUz+/2TA8TiJgliWdon78wJ0dUNqoEkU3C4JciVdCON8L/kGMD7R1
uFt5LGKnl3N7dMi+HDUhmyp240lD7MiNoPqIBfxSlGjwDewoh7fVGcnjAL/WU7m6
5qRNH2cnkjLUCX2SkW3MAXGd+8o3w3WkVHhMmcAeZECgDBQ9SrwfpnOmNSagSEfu
EC9aldOfZ5/AG4Ct7LqGs+9juqdqMn07wOhNzvFB6qj0EgisFszw0G+lMp08Fam3
C8o6B8f+jglMjpAe4HyKVCu2xRK56apNVLBOkPZCbX2LRwqQ+hI9IzP6NBBnlmWJ
8Nj/aCeeHK1mib/K0v6SYl5rOAa2yfnrJSM6F48LDCdbE/SZ0vdDvJuRaSf8dgEZ
GKUenccANNw/Tth91XD/
=NAyB
-----END PGP SIGNATURE-----

--OwLcNYc0lM97+oe1--
