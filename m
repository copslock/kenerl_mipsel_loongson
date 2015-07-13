Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 13 Jul 2015 11:20:26 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:47832 "EHLO
        imgpgp01.kl.imgtec.org" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S27009001AbbGMJUYQgh8X (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 13 Jul 2015 11:20:24 +0200
Received: from imgpgp01.kl.imgtec.org (imgpgp01.kl.imgtec.org [127.0.0.1])
        by imgpgp01.kl.imgtec.org (PGP Universal) with ESMTP id C08B941F8DED;
        Mon, 13 Jul 2015 10:20:18 +0100 (BST)
Received: from mailapp01.imgtec.com ([10.100.180.241])
  by imgpgp01.kl.imgtec.org (PGP Universal service);
  Mon, 13 Jul 2015 10:20:18 +0100
X-PGP-Universal: processed;
        by imgpgp01.kl.imgtec.org on Mon, 13 Jul 2015 10:20:18 +0100
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 2BC118454DE58;
        Mon, 13 Jul 2015 10:20:16 +0100 (IST)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Mon, 13 Jul 2015 10:20:18 +0100
Received: from [192.168.154.110] (192.168.154.110) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.210.2; Mon, 13 Jul
 2015 10:20:18 +0100
Message-ID: <55A382D0.9080208@imgtec.com>
Date:   Mon, 13 Jul 2015 10:20:16 +0100
From:   James Hogan <james.hogan@imgtec.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.7.0
MIME-Version: 1.0
To:     Bjorn Helgaas <bhelgaas@google.com>,
        Ralf Baechle <ralf@linux-mips.org>
CC:     Andrew Bresticker <abrestic@chromium.org>,
        <linux-mips@linux-mips.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 8/9] MIPS: Remove "weak" from mips_cdmm_phys_base() declaration
References: <20150712230402.11177.11848.stgit@bhelgaas-glaptop2.roam.corp.google.com> <20150712231154.11177.57126.stgit@bhelgaas-glaptop2.roam.corp.google.com>
In-Reply-To: <20150712231154.11177.57126.stgit@bhelgaas-glaptop2.roam.corp.google.com>
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature";
        boundary="7P4SmeHGbjJO64MPtX6hlOVWndmFMFwE5"
X-Originating-IP: [192.168.154.110]
X-ESG-ENCRYPT-TAG: f107b6f
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 48218
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

--7P4SmeHGbjJO64MPtX6hlOVWndmFMFwE5
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Bjorn,

On 13/07/15 00:11, Bjorn Helgaas wrote:
> Weak header file declarations are error-prone because they make every
> definition weak, and the linker chooses one based on link order (see
> 10629d711ed7 ("PCI: Remove __weak annotation from pcibios_get_phb_of_no=
de
> decl")).
>=20
> mips_cdmm_phys_base() is defined only in arch/mips/mti-malta/malta-memo=
ry.c
> so there's no problem with multiple definitions.  But it works better t=
o
> have a weak default implementation and allow a strong function to overr=
ide
> it.  Then we don't have to test whether a definition is present, and if=

> there are ever multiple strong definitions, we get a link error instead=
 of
> calling a random definition.
>=20
> Add a weak mips_cdmm_phys_base() definition and remove the weak annotat=
ion
> from the declaration in arch/mips/include/asm/cdmm.h.
>=20
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> CC: James Hogan <james.hogan@imgtec.com>

Reviewed-by: James Hogan <james.hogan@imgtec.com>

Thanks for pointing out these problems. Hopefully eventually some of
these uses of weak symbols can be moved to device tree (its almost like
we need a DT binding for "this physical address isn't used for anything,
and would be suitable for an overlay").

Cheers
James

> ---
>  arch/mips/include/asm/cdmm.h |    4 ++--
>  drivers/bus/mips_cdmm.c      |   14 +++++++++++++-
>  2 files changed, 15 insertions(+), 3 deletions(-)
>=20
> diff --git a/arch/mips/include/asm/cdmm.h b/arch/mips/include/asm/cdmm.=
h
> index 16e22ce..bece206 100644
> --- a/arch/mips/include/asm/cdmm.h
> +++ b/arch/mips/include/asm/cdmm.h
> @@ -53,7 +53,7 @@ struct mips_cdmm_driver {
>   * mips_cdmm_phys_base() - Choose a physical base address for CDMM reg=
ion.
>   *
>   * Picking a suitable physical address at which to map the CDMM region=
 is
> - * platform specific, so this weak function can be defined by platform=
 code to
> + * platform specific, so this function can be defined by platform code=
 to
>   * pick a suitable value if none is configured by the bootloader.
>   *
>   * This address must be 32kB aligned, and the region occupies a maximu=
m of 32kB
> @@ -61,7 +61,7 @@ struct mips_cdmm_driver {
>   *
>   * Returns:	Physical base address for CDMM region, or 0 on failure.
>   */
> -phys_addr_t __weak mips_cdmm_phys_base(void);
> +phys_addr_t mips_cdmm_phys_base(void);
> =20
>  extern struct bus_type mips_cdmm_bustype;
>  void __iomem *mips_cdmm_early_probe(unsigned int dev_type);
> diff --git a/drivers/bus/mips_cdmm.c b/drivers/bus/mips_cdmm.c
> index ab3bde1..1c543ef 100644
> --- a/drivers/bus/mips_cdmm.c
> +++ b/drivers/bus/mips_cdmm.c
> @@ -332,6 +332,18 @@ static phys_addr_t mips_cdmm_cur_base(void)
>  }
> =20
>  /**
> + * mips_cdmm_phys_base() - Choose a physical base address for CDMM reg=
ion.
> + *
> + * Picking a suitable physical address at which to map the CDMM region=
 is
> + * platform specific, so this weak function can be overridden by platf=
orm
> + * code to pick a suitable value if none is configured by the bootload=
er.
> + */
> +phys_addr_t __weak mips_cdmm_phys_base(void)
> +{
> +	return 0;
> +}
> +
> +/**
>   * mips_cdmm_setup() - Ensure the CDMM bus is initialised and usable.
>   * @bus:	Pointer to bus information for current CPU.
>   *		IS_ERR(bus) is checked, so no need for caller to check.
> @@ -368,7 +380,7 @@ static int mips_cdmm_setup(struct mips_cdmm_bus *bu=
s)
>  	if (!bus->phys)
>  		bus->phys =3D mips_cdmm_cur_base();
>  	/* Otherwise, ask platform code for suggestions */
> -	if (!bus->phys && mips_cdmm_phys_base)
> +	if (!bus->phys)
>  		bus->phys =3D mips_cdmm_phys_base();
>  	/* Otherwise, copy what other CPUs have done */
>  	if (!bus->phys)
>=20


--7P4SmeHGbjJO64MPtX6hlOVWndmFMFwE5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJVo4LXAAoJEGwLaZPeOHZ6So4P+gKMyPe2fyPavBvjCP+hpdQe
8DH0nLjx3eD1/19YO+fnad2UVLsMhupoRkQg2U3Xao7Q+BgcxhMN1AM+9HP4UGVE
/Qoq7P/v+lqk6p2H+gYF/goJVoA6Px80E5nyYgEXrnMUnbu29OQYjaNgu4ziyhCJ
L/BHvRnc49qpFY5yLmZEkkIb2cCH55uAFtLbUhVJ/jdOSDeLHu/dtOd4jQH7gvHB
uswvum3Z3Y+2Pv4p4EnonVi5jUgvaUCL+zzrwPeSy2zeNCCPxJlCLIH3FggIzpcT
2mjStRwjUk8oWTed3mxjBxt0JGEiPfCbqFTCxYZY1g8Dw5zdbafCVN+awpdS6huC
gn7N6rpb6R///FqkUwMdnNno2h0s4qR6q0P6iitmQsXjsvH97lUFGPuxrSq+txLV
2nEJjB9G3MVrKT7ifKbRqUcVBaORqM1GgFIUipxpchaTdxvM3qESq49U7Xg8SCr1
LpYfmbmwKBtAikaUihrL93n3un4LwL9cUyM3QpX9L3rJxJt1fncX7OhFqU9HIMCa
IhdG28JO14EsgmvB2qxxJEr1KMMvKYVxdZ08sAWK7lzNVGqac01HohGfV57vK62l
2jFaOvDBw3yENJXJXZuUago/RhGQGlDHJdCqAKC7/PlNtj7CxiqXERbuw5ty0B28
PVA/YT4k3BqIjoE8LLmg
=mRmE
-----END PGP SIGNATURE-----

--7P4SmeHGbjJO64MPtX6hlOVWndmFMFwE5--
