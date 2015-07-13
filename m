Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 13 Jul 2015 11:43:57 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:35915 "EHLO
        imgpgp01.kl.imgtec.org" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S27009231AbbGMJnzLgerr (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 13 Jul 2015 11:43:55 +0200
Received: from imgpgp01.kl.imgtec.org (imgpgp01.kl.imgtec.org [127.0.0.1])
        by imgpgp01.kl.imgtec.org (PGP Universal) with ESMTP id D035D41F8DED;
        Mon, 13 Jul 2015 10:43:49 +0100 (BST)
Received: from mailapp01.imgtec.com ([10.100.180.242])
  by imgpgp01.kl.imgtec.org (PGP Universal service);
  Mon, 13 Jul 2015 10:43:49 +0100
X-PGP-Universal: processed;
        by imgpgp01.kl.imgtec.org on Mon, 13 Jul 2015 10:43:49 +0100
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id B04324DA219A6;
        Mon, 13 Jul 2015 10:43:47 +0100 (IST)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Mon, 13 Jul 2015 10:43:49 +0100
Received: from [192.168.154.110] (192.168.154.110) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.210.2; Mon, 13 Jul
 2015 10:43:48 +0100
Message-ID: <55A3885A.5010002@imgtec.com>
Date:   Mon, 13 Jul 2015 10:43:54 +0100
From:   James Hogan <james.hogan@imgtec.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.7.0
MIME-Version: 1.0
To:     Bjorn Helgaas <bhelgaas@google.com>,
        Ralf Baechle <ralf@linux-mips.org>
CC:     Andrew Bresticker <abrestic@chromium.org>,
        <linux-mips@linux-mips.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 5/9] MIPS: Remove "weak" from get_c0_perfcount_int() declaration
References: <20150712230402.11177.11848.stgit@bhelgaas-glaptop2.roam.corp.google.com> <20150712231129.11177.40742.stgit@bhelgaas-glaptop2.roam.corp.google.com>
In-Reply-To: <20150712231129.11177.40742.stgit@bhelgaas-glaptop2.roam.corp.google.com>
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature";
        boundary="TwXg1FMv6epotM0SXxBvW4lB7Sem8FCt8"
X-Originating-IP: [192.168.154.110]
X-ESG-ENCRYPT-TAG: e4aa9c8
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 48222
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

--TwXg1FMv6epotM0SXxBvW4lB7Sem8FCt8
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 13/07/15 00:11, Bjorn Helgaas wrote:
> Weak header file declarations are error-prone because they make every
> definition weak, and the linker chooses one based on link order (see
> 10629d711ed7 ("PCI: Remove __weak annotation from pcibios_get_phb_of_no=
de
> decl")).
>=20
> get_c0_perfcount_int() is defined in several files.  Every definition i=
s
> weak, so I assume Kconfig prevents two or more from being included.  Th=
e
> callers contain identical default code used when get_c0_perfcount_int()=

> isn't defined at all.
>=20
> Add a weak get_c0_perfcount_int() definition with the default code and
> remove the weak annotation from the declaration.
>=20
> Then the platform implementations will be strong and will override the =
weak
> default.  If multiple platforms are ever configured in, we'll get a lin=
k
> error instead of calling a random platform's implementation.
>=20
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> CC: Andrew Bresticker <abrestic@chromium.org>
> ---
>  arch/mips/include/asm/time.h         |    2 +-
>  arch/mips/kernel/perf_event_mipsxx.c |    7 +------
>  arch/mips/kernel/time.c              |   10 +++++++++-
>  arch/mips/oprofile/op_model_mipsxx.c |    8 +-------
>  4 files changed, 12 insertions(+), 15 deletions(-)
>=20
> diff --git a/arch/mips/include/asm/time.h b/arch/mips/include/asm/time.=
h
> index 8ab2874..ce6a7d5 100644
> --- a/arch/mips/include/asm/time.h
> +++ b/arch/mips/include/asm/time.h
> @@ -46,7 +46,7 @@ extern unsigned int mips_hpt_frequency;
>   * so it lives here.
>   */
>  extern int (*perf_irq)(void);
> -extern int __weak get_c0_perfcount_int(void);
> +extern int get_c0_perfcount_int(void);
> =20
>  /*
>   * Initialize the calling CPU's compare interrupt as clockevent device=

> diff --git a/arch/mips/kernel/perf_event_mipsxx.c b/arch/mips/kernel/pe=
rf_event_mipsxx.c
> index cc1b6fa..c126b1c 100644
> --- a/arch/mips/kernel/perf_event_mipsxx.c
> +++ b/arch/mips/kernel/perf_event_mipsxx.c
> @@ -1682,12 +1682,7 @@ init_hw_perf_events(void)
>  		counters =3D counters_total_to_per_cpu(counters);
>  #endif
> =20
> -	if (get_c0_perfcount_int)
> -		irq =3D get_c0_perfcount_int();
> -	else if (cp0_perfcount_irq >=3D 0)
> -		irq =3D MIPS_CPU_IRQ_BASE + cp0_perfcount_irq;
> -	else
> -		irq =3D -1;
> +	irq =3D get_c0_perfcount_int();
> =20
>  	mipspmu.map_raw_event =3D mipsxx_pmu_map_raw_event;
> =20
> diff --git a/arch/mips/kernel/time.c b/arch/mips/kernel/time.c
> index 8d01709..ec7082d 100644
> --- a/arch/mips/kernel/time.c
> +++ b/arch/mips/kernel/time.c
> @@ -55,9 +55,17 @@ static int null_perf_irq(void)
>  }
> =20
>  int (*perf_irq)(void) =3D null_perf_irq;
> -
>  EXPORT_SYMBOL(perf_irq);
> =20
> +#ifdef MIPS_CPU_IRQ_BASE

why the ifdef? This would be the only such ifdef in the kernel, and
arch/mips/include/asm/mach-generic/irq.h seems to ensure it is always
defined anyway.

Aside from that the patch looks good.

Cheers
James

> +int __weak get_c0_perfcount_int(void)
> +{
> +	if (cp0_perfcount_irq >=3D 0)
> +		return MIPS_CPU_IRQ_BASE + cp0_perfcount_irq;
> +	return -1;
> +}
> +#endif
> +
>  /*
>   * time_init() - it does the following things.
>   *
> diff --git a/arch/mips/oprofile/op_model_mipsxx.c b/arch/mips/oprofile/=
op_model_mipsxx.c
> index 6a6e2cc..c0cffa9 100644
> --- a/arch/mips/oprofile/op_model_mipsxx.c
> +++ b/arch/mips/oprofile/op_model_mipsxx.c
> @@ -438,13 +438,7 @@ static int __init mipsxx_init(void)
>  	save_perf_irq =3D perf_irq;
>  	perf_irq =3D mipsxx_perfcount_handler;
> =20
> -	if (get_c0_perfcount_int)
> -		perfcount_irq =3D get_c0_perfcount_int();
> -	else if (cp0_perfcount_irq >=3D 0)
> -		perfcount_irq =3D MIPS_CPU_IRQ_BASE + cp0_perfcount_irq;
> -	else
> -		perfcount_irq =3D -1;
> -
> +	perfcount_irq =3D get_c0_perfcount_int();
>  	if (perfcount_irq >=3D 0)
>  		return request_irq(perfcount_irq, mipsxx_perfcount_int,
>  				   IRQF_PERCPU | IRQF_NOBALANCING |
>=20


--TwXg1FMv6epotM0SXxBvW4lB7Sem8FCt8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJVo4haAAoJEGwLaZPeOHZ6tDsP/3a5lOaTkFzwGxVZfYGOPPv8
uLWiU2ufu5mU8fyG123ZoEfo+Bbc7vZkfzktAicepPjdV2fih9K/P3iUdikcLdGK
HsiO2mAK+YZe2d3B4FCiL/J2OIl2+0TxC6s3IakHCFsfXTvlg9Ln4aq5fxjPoYxC
CcUSJLvmttkLca1l23fCxI0x7XbcSWR54mdJEGoP5KT6SwIj/2zcoZW3o7dFoXpS
Dh3d6b/n0NOKL+EvXkqk+OkSp+gUwLeE8rMUvdEoAa7CWCPH57Y0Hgh6/nR/0Hjn
WXDyCMfNgo3xJ9TW8mB//V0vYPfWeu4kn0EFWfx7nJZIE7WA8NQc3UYYksCMbdD9
I+H/wrEvzdp/g3IuwegZd0DU52BDOxpVWKxn0/xT8zfF8AvRq7jlMmMveKty6eRl
tw4P0/b+7oZRYHrSsrp4Kdx6cCYl4llZNTRckr4cXeWZHgiBdyE9LGPoHStlhiDe
eSLxCysBAJcuUJsPQdfzGJbuT6W4JYanBRfsQY6/6/E44hPC60yMMIW67jpe1j5c
qBSdCFDOqnX/UR3s3+WGKHkgjhoJw2fOETy8jEXDu+eJhit7FaHTroZ9W/Fag76Z
wTwnlQYwkRYzqEsE2BpAEHOIjD7uEqfI+ttYszCylJxOkH0qliOjfhyYeLEF0KrO
oPsA7MX1uf58Cw4PA5JV
=CzYZ
-----END PGP SIGNATURE-----

--TwXg1FMv6epotM0SXxBvW4lB7Sem8FCt8--
