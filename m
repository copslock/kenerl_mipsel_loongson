Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 26 Jan 2016 14:42:42 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:4535 "EHLO
        imgpgp01.kl.imgtec.org" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S27011595AbcAZNmgYEFz0 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 26 Jan 2016 14:42:36 +0100
Received: from imgpgp01.kl.imgtec.org (imgpgp01.kl.imgtec.org [127.0.0.1])
        by imgpgp01.kl.imgtec.org (PGP Universal) with ESMTP id 4CFE341F8E4F;
        Tue, 26 Jan 2016 13:42:30 +0000 (GMT)
Received: from mailapp01.imgtec.com ([10.100.180.242])
  by imgpgp01.kl.imgtec.org (PGP Universal service);
  Tue, 26 Jan 2016 13:42:30 +0000
X-PGP-Universal: processed;
        by imgpgp01.kl.imgtec.org on Tue, 26 Jan 2016 13:42:30 +0000
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Websense Email Security Gateway with ESMTPS id 2A828FB7E5F8;
        Tue, 26 Jan 2016 13:42:28 +0000 (GMT)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 HHMAIL01.hh.imgtec.org (10.100.10.19) with Microsoft SMTP Server (TLS) id
 14.3.235.1; Tue, 26 Jan 2016 13:42:29 +0000
Received: from localhost (192.168.154.110) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.210.2; Tue, 26 Jan
 2016 13:42:29 +0000
Date:   Tue, 26 Jan 2016 13:42:29 +0000
From:   James Hogan <james.hogan@imgtec.com>
To:     Huacai Chen <chenhc@lemote.com>
CC:     Ralf Baechle <ralf@linux-mips.org>,
        Aurelien Jarno <aurelien@aurel32.net>,
        "Steven J. Hill" <Steven.Hill@imgtec.com>,
        <linux-mips@linux-mips.org>, "Fuxin Zhang" <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>
Subject: Re: [PATCH 5/6] MIPS: Loongson: Introduce and use
 cpu_has_coherent_cache feature
Message-ID: <20160126134229.GA12365@jhogan-linux.le.imgtec.org>
References: <1453814784-14230-1-git-send-email-chenhc@lemote.com>
 <1453814784-14230-6-git-send-email-chenhc@lemote.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="5vNYLRcllDrimb99"
Content-Disposition: inline
In-Reply-To: <1453814784-14230-6-git-send-email-chenhc@lemote.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Originating-IP: [192.168.154.110]
X-ESG-ENCRYPT-TAG: 30575414
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 51410
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

--5vNYLRcllDrimb99
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Jan 26, 2016 at 09:26:23PM +0800, Huacai Chen wrote:
> Loongson-3 maintains cache coherency by hardware. So we introduce a cpu
> feature named cpu_has_coherent_cache and use it to modify MIPS's cache
> flushing functions.

This is rather ambiguous (the phrase "cache coherency" can be associated
with dcache coherency between cores). Are you saying that the icache is
coherent with the dcache, such that writes to dcache are immediately
visible to instruction fetches on all CPUs in the system without any
icache flushing?

If so, I think that needs clarifying, e.g. cpu_has_coherent_icache.

Perhaps it should be a flag of icache along with MIPS_CACHE_IC_F_DC too
which is already intended to avoid the dcache flushes, but not necessary
the icache flushes.

Cheers
James

>=20
> Signed-off-by: Huacai Chen <chenhc@lemote.com>
> ---
>  arch/mips/include/asm/cpu-features.h                |  3 +++
>  arch/mips/include/asm/cpu.h                         |  1 +
>  .../asm/mach-loongson64/cpu-feature-overrides.h     |  1 +
>  arch/mips/mm/c-r4k.c                                | 21 +++++++++++++++=
++++++
>  4 files changed, 26 insertions(+)
>=20
> diff --git a/arch/mips/include/asm/cpu-features.h b/arch/mips/include/asm=
/cpu-features.h
> index e0ba50a..1ec3dea 100644
> --- a/arch/mips/include/asm/cpu-features.h
> +++ b/arch/mips/include/asm/cpu-features.h
> @@ -148,6 +148,9 @@
>  #ifndef cpu_has_xpa
>  #define cpu_has_xpa		(cpu_data[0].options & MIPS_CPU_XPA)
>  #endif
> +#ifndef cpu_has_coherent_cache
> +#define cpu_has_coherent_cache	(cpu_data[0].options & MIPS_CPU_CACHE_COH=
ERENT)
> +#endif
>  #ifndef cpu_has_vtag_icache
>  #define cpu_has_vtag_icache	(cpu_data[0].icache.flags & MIPS_CACHE_VTAG)
>  #endif
> diff --git a/arch/mips/include/asm/cpu.h b/arch/mips/include/asm/cpu.h
> index 5f50551..28471f0 100644
> --- a/arch/mips/include/asm/cpu.h
> +++ b/arch/mips/include/asm/cpu.h
> @@ -391,6 +391,7 @@ enum cpu_type_enum {
>  #define MIPS_CPU_NAN_LEGACY	0x40000000000ull /* Legacy NaN implemented */
>  #define MIPS_CPU_NAN_2008	0x80000000000ull /* 2008 NaN implemented */
>  #define MIPS_CPU_LDPTE		0x100000000000ull /* CPU has ldpte/lddir instruc=
tions */
> +#define MIPS_CPU_CACHE_COHERENT	0x200000000000ull /* CPU maintains cache=
 coherency by hardware */
> =20
>  /*
>   * CPU ASE encodings
> diff --git a/arch/mips/include/asm/mach-loongson64/cpu-feature-overrides.=
h b/arch/mips/include/asm/mach-loongson64/cpu-feature-overrides.h
> index c3406db..647d952 100644
> --- a/arch/mips/include/asm/mach-loongson64/cpu-feature-overrides.h
> +++ b/arch/mips/include/asm/mach-loongson64/cpu-feature-overrides.h
> @@ -46,6 +46,7 @@
>  #define cpu_has_local_ebase	0
> =20
>  #define cpu_has_wsbh		IS_ENABLED(CONFIG_CPU_LOONGSON3)
> +#define cpu_has_coherent_cache	IS_ENABLED(CONFIG_CPU_LOONGSON3)
>  #define cpu_hwrena_impl_bits	0xc0000000
> =20
>  #endif /* __ASM_MACH_LOONGSON64_CPU_FEATURE_OVERRIDES_H */
> diff --git a/arch/mips/mm/c-r4k.c b/arch/mips/mm/c-r4k.c
> index 2abc73d..65fb28c 100644
> --- a/arch/mips/mm/c-r4k.c
> +++ b/arch/mips/mm/c-r4k.c
> @@ -429,6 +429,9 @@ static void r4k_blast_scache_setup(void)
> =20
>  static inline void local_r4k___flush_cache_all(void * args)
>  {
> +	if (cpu_has_coherent_cache)
> +		return;
> +
>  	switch (current_cpu_type()) {
>  	case CPU_LOONGSON2:
>  	case CPU_LOONGSON3:
> @@ -457,6 +460,9 @@ static inline void local_r4k___flush_cache_all(void *=
 args)
> =20
>  static void r4k___flush_cache_all(void)
>  {
> +	if (cpu_has_coherent_cache)
> +		return;
> +
>  	r4k_on_each_cpu(local_r4k___flush_cache_all, NULL);
>  }
> =20
> @@ -503,6 +509,9 @@ static void r4k_flush_cache_range(struct vm_area_stru=
ct *vma,
>  {
>  	int exec =3D vma->vm_flags & VM_EXEC;
> =20
> +	if (cpu_has_coherent_cache)
> +		return;
> +
>  	if (cpu_has_dc_aliases || (exec && !cpu_has_ic_fills_f_dc))
>  		r4k_on_each_cpu(local_r4k_flush_cache_range, vma);
>  }
> @@ -627,6 +636,9 @@ static void r4k_flush_cache_page(struct vm_area_struc=
t *vma,
>  {
>  	struct flush_cache_page_args args;
> =20
> +	if (cpu_has_coherent_cache)
> +		return;
> +
>  	args.vma =3D vma;
>  	args.addr =3D addr;
>  	args.pfn =3D pfn;
> @@ -636,11 +648,17 @@ static void r4k_flush_cache_page(struct vm_area_str=
uct *vma,
> =20
>  static inline void local_r4k_flush_data_cache_page(void * addr)
>  {
> +	if (cpu_has_coherent_cache)
> +		return;
> +
>  	r4k_blast_dcache_page((unsigned long) addr);
>  }
> =20
>  static void r4k_flush_data_cache_page(unsigned long addr)
>  {
> +	if (cpu_has_coherent_cache)
> +		return;
> +
>  	if (in_atomic())
>  		local_r4k_flush_data_cache_page((void *)addr);
>  	else
> @@ -825,6 +843,9 @@ static void local_r4k_flush_cache_sigtramp(void * arg)
> =20
>  static void r4k_flush_cache_sigtramp(unsigned long addr)
>  {
> +	if (cpu_has_coherent_cache)
> +		return;
> +
>  	r4k_on_each_cpu(local_r4k_flush_cache_sigtramp, (void *) addr);
>  }
> =20
> --=20
> 2.4.6
>=20
>=20
>=20
>=20
>=20

--5vNYLRcllDrimb99
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJWp3fFAAoJEGwLaZPeOHZ6JCIQAJZ33J/UkYkzeFh0hGwYcUSY
RUQW7P2xRuiq7id7yswMC9M3IdIw43X8wO5b7BSMDyTajxg6uK0XqPMMw6uTrbFk
bR4k2khpDuD/c/PQcd84SJORVaTZhMUjvqS+/Jr86c6UzJJOalyS3b0xoOjtVZho
3enTYHFRy9AVqWXZpGWov0PndZtbyax0YrcNreJfDV7+FWHeoB8mJyb2EjGksZJY
aymtlbYTAGbKO4/jxlltGSGga7X/KzL3TEkR+If6LLdSRPqGSwdopFi0j16EVISo
Qp70D3NZKN7449ZyNXzl0RyVKb5I+kZ6nb4GWkGcwM37LhsoJWFgtdnQhX7C+r1V
dw0MdYurf2edEDaoirx8utaqZ/PjVMvfF8S74kGrG3RDFRxoUMd8gFPRWWvra3uz
W7WJXBtE36EHeg2PClUkw2Ue5ms4oyvLMgcENntR9H0fXwpiVpvEa0qs1wJDhzUc
rD5j2/v4c633+W8T4Lt/iyPeMAXS8jT5Wutfye3GKVhAmR9DSkwnp2B2jz0V+OtV
cfb4abjT+k53BniuBgegWdXCfgzWIyC32cjQBHZ5XNUvChzZR8W5mnHvr5HI09ey
9z1WcY3eyfkzC8VUnJ7Ga8or8m0DuQj7fpvtFIwr26SxBtqcSBd+jkNF4aEC84Oz
3OHyWztbhKbsoWqeXZTB
=uqNw
-----END PGP SIGNATURE-----

--5vNYLRcllDrimb99--
