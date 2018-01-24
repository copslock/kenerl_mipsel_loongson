Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 24 Jan 2018 21:55:00 +0100 (CET)
Received: from mail.kernel.org ([198.145.29.99]:48920 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23991359AbeAXUyv5s6pU (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 24 Jan 2018 21:54:51 +0100
Received: from saruman (jahogan.plus.com [212.159.75.221])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BC9FD21785;
        Wed, 24 Jan 2018 20:54:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC9FD21785
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=jhogan@kernel.org
Date:   Wed, 24 Jan 2018 20:54:16 +0000
From:   James Hogan <jhogan@kernel.org>
To:     Huacai Chen <chenhc@lemote.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        John Crispin <john@phrozen.org>,
        "Steven J . Hill" <Steven.Hill@cavium.com>,
        linux-mips@linux-mips.org, Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>
Subject: Re: [PATCH 1/8] MIPS: Loongson-3: Enable Store Fill Buffer at runtime
Message-ID: <20180124205415.GH5446@saruman>
References: <1502330433-16670-1-git-send-email-chenhc@lemote.com>
 <1502330433-16670-2-git-send-email-chenhc@lemote.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="0OWHXb1mYLuhj1Ox"
Content-Disposition: inline
In-Reply-To: <1502330433-16670-2-git-send-email-chenhc@lemote.com>
User-Agent: Mutt/1.7.2 (2016-11-26)
Return-Path: <jhogan@kernel.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 62319
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


--0OWHXb1mYLuhj1Ox
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 10, 2017 at 10:00:26AM +0800, Huacai Chen wrote:
> New Loongson-3 (Loongson-3A R2, Loongson-3A R3, and newer) has SFB
> (Store Fill Buffer) which can improve the performance of memory access.
> Now, SFB enablement is controlled by CONFIG_LOONGSON3_ENHANCEMENT, and
> the generic kernel has no benefit from SFB (even it is running on a new
> Loongson-3 machine). With this patch, we can enable SFB at runtime by
> detecting the CPU type (the expense is war_io_reorder_wmb() will always
> be a 'sync', which will hurt the performance of old Loongson-3).
>=20
> Signed-off-by: Huacai Chen <chenhc@lemote.com>
> ---
>  arch/mips/include/asm/io.h                         |  2 +-
>  .../asm/mach-loongson64/kernel-entry-init.h        | 38 +++++++++++++---=
------
>  arch/mips/include/asm/mipsregs.h                   |  2 ++
>  3 files changed, 25 insertions(+), 17 deletions(-)
>=20
> diff --git a/arch/mips/include/asm/io.h b/arch/mips/include/asm/io.h
> index ecabc00..d3e38af 100644
> --- a/arch/mips/include/asm/io.h
> +++ b/arch/mips/include/asm/io.h
> @@ -304,7 +304,7 @@ static inline void iounmap(const volatile void __iome=
m *addr)
>  #undef __IS_KSEG1
>  }
> =20
> -#if defined(CONFIG_CPU_CAVIUM_OCTEON) || defined(CONFIG_LOONGSON3_ENHANC=
EMENT)
> +#if defined(CONFIG_CPU_CAVIUM_OCTEON) || defined(CONFIG_CPU_LOONGSON3)
>  #define war_io_reorder_wmb()		wmb()
>  #else
>  #define war_io_reorder_wmb()		do { } while (0)
> diff --git a/arch/mips/include/asm/mach-loongson64/kernel-entry-init.h b/=
arch/mips/include/asm/mach-loongson64/kernel-entry-init.h
> index 8393bc54..4b7f58a 100644
> --- a/arch/mips/include/asm/mach-loongson64/kernel-entry-init.h
> +++ b/arch/mips/include/asm/mach-loongson64/kernel-entry-init.h
> @@ -19,19 +19,22 @@
>  	.set	push
>  	.set	mips64
>  	/* Set LPA on LOONGSON3 config3 */
> -	mfc0	t0, $16, 3
> +	mfc0	t0, CP0_CONFIG3
>  	or	t0, (0x1 << 7)
> -	mtc0	t0, $16, 3
> +	mtc0	t0, CP0_CONFIG3
>  	/* Set ELPA on LOONGSON3 pagegrain */
> -	mfc0	t0, $5, 1
> +	mfc0	t0, CP0_PAGEGRAIN

Please don't mix cleanups with functional changes.

Separately, both the cleanup and the main change look good to me.

Cheers
James

>  	or	t0, (0x1 << 29)
> -	mtc0	t0, $5, 1
> -#ifdef CONFIG_LOONGSON3_ENHANCEMENT
> +	mtc0	t0, CP0_PAGEGRAIN
>  	/* Enable STFill Buffer */
> -	mfc0	t0, $16, 6
> +	mfc0	t0, CP0_PRID
> +	andi	t0, 0xffff
> +	slti	t0, 0x6308
> +	bnez	t0, 1f
> +	mfc0	t0, CP0_CONFIG6
>  	or	t0, 0x100
> -	mtc0	t0, $16, 6
> -#endif
> +	mtc0	t0, CP0_CONFIG6
> +1:
>  	_ehb
>  	.set	pop
>  #endif
> @@ -45,19 +48,22 @@
>  	.set	push
>  	.set	mips64
>  	/* Set LPA on LOONGSON3 config3 */
> -	mfc0	t0, $16, 3
> +	mfc0	t0, CP0_CONFIG3
>  	or	t0, (0x1 << 7)
> -	mtc0	t0, $16, 3
> +	mtc0	t0, CP0_CONFIG3
>  	/* Set ELPA on LOONGSON3 pagegrain */
> -	mfc0	t0, $5, 1
> +	mfc0	t0, CP0_PAGEGRAIN
>  	or	t0, (0x1 << 29)
> -	mtc0	t0, $5, 1
> -#ifdef CONFIG_LOONGSON3_ENHANCEMENT
> +	mtc0	t0, CP0_PAGEGRAIN
>  	/* Enable STFill Buffer */
> -	mfc0	t0, $16, 6
> +	mfc0	t0, CP0_PRID
> +	andi	t0, 0xffff
> +	slti	t0, 0x6308
> +	bnez	t0, 1f
> +	mfc0	t0, CP0_CONFIG6
>  	or	t0, 0x100
> -	mtc0	t0, $16, 6
> -#endif
> +	mtc0	t0, CP0_CONFIG6
> +1:
>  	_ehb
>  	.set	pop
>  #endif
> diff --git a/arch/mips/include/asm/mipsregs.h b/arch/mips/include/asm/mip=
sregs.h
> index dbb0ece..cb1ebc6 100644
> --- a/arch/mips/include/asm/mipsregs.h
> +++ b/arch/mips/include/asm/mipsregs.h
> @@ -50,6 +50,7 @@
>  #define CP0_CONF $3
>  #define CP0_CONTEXT $4
>  #define CP0_PAGEMASK $5
> +#define CP0_PAGEGRAIN $5, 1
>  #define CP0_SEGCTL0 $5, 2
>  #define CP0_SEGCTL1 $5, 3
>  #define CP0_SEGCTL2 $5, 4
> @@ -76,6 +77,7 @@
>  #define CP0_CONFIG $16
>  #define CP0_CONFIG3 $16, 3
>  #define CP0_CONFIG5 $16, 5
> +#define CP0_CONFIG6 $16, 6
>  #define CP0_LLADDR $17
>  #define CP0_WATCHLO $18
>  #define CP0_WATCHHI $19
> --=20
> 2.7.0
>=20
>=20
>=20
>=20

--0OWHXb1mYLuhj1Ox
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEd80NauSabkiESfLYbAtpk944dnoFAlpo8nEACgkQbAtpk944
dnrb+w//dLh6/h21qSAXZ+fIj1IjH4Lq+1ZQSWpUY3lrOonW9w6ptXg2dt+ajTqA
10HOD3P1k2+bjlLElnXuCgif5Ai3p2via/XN45xdsk8lzrYmrpQfxXiyTPC3AREt
Av2F5FfNQegnBWQPfTgYQdeL12lJcF8kujeelHokdTVy77CCYRbKnnve0txaupVS
TJdFyHafroB9hAbNU4RuUeXF2L4zQfaMI0kdxfEnDrcbiQqNPwufRtQOW3fb4hO9
liAsvjZJmBxcv70+VRO0tFBdqmqX7/uwuYOeNduKOBZVBTJfETuk4zOUgDEyJG7A
357DTJYlkiKmR43kLOElTFuNA9PgVgBnxhVHGgpxG/6GxYxafjp/JPHFUunUAUk5
bbJBDCzRUiqTzKIG81U9zvzAEEx3T5HlwkMHJVofO0GuH17f6sIlVyI+pakW/FuR
EyfnjJ1a+GBvgipkiPRA+jwfyh3bYbOr2NaGerNVyiLQhCX1KBmhMWKw0x2vRCZz
K0USohK3NopVjGAodjUanMXhKChyHbwKKhLz5AMHWezlRqjsIJInOYZed6uDcowy
hDpFBMpkANVE5cxTe0Fd/9+YUcXBWO9vEa0oL7h0uvtaLPOR46GEdd6V9+Ou/dKQ
fmYkwHO9UYNqW78jZ03m9h4JXOfgw1M3kXclwdJSARfkPpI+XU8=
=eXzc
-----END PGP SIGNATURE-----

--0OWHXb1mYLuhj1Ox--
