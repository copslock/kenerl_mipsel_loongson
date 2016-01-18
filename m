Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 18 Jan 2016 16:05:29 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:46718 "EHLO
        imgpgp01.kl.imgtec.org" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S27010530AbcARPF0OcQzv (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 18 Jan 2016 16:05:26 +0100
Received: from imgpgp01.kl.imgtec.org (imgpgp01.kl.imgtec.org [127.0.0.1])
        by imgpgp01.kl.imgtec.org (PGP Universal) with ESMTP id CF93D41F8D70;
        Mon, 18 Jan 2016 15:05:20 +0000 (GMT)
Received: from mailapp01.imgtec.com ([10.100.180.242])
  by imgpgp01.kl.imgtec.org (PGP Universal service);
  Mon, 18 Jan 2016 15:05:20 +0000
X-PGP-Universal: processed;
        by imgpgp01.kl.imgtec.org on Mon, 18 Jan 2016 15:05:20 +0000
Received: from hhmail02.hh.imgtec.org (unknown [10.100.10.20])
        by Websense Email Security Gateway with ESMTPS id CA9484D182B69;
        Mon, 18 Jan 2016 15:05:17 +0000 (GMT)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 hhmail02.hh.imgtec.org (10.100.10.20) with Microsoft SMTP Server (TLS) id
 14.3.235.1; Mon, 18 Jan 2016 15:05:20 +0000
Received: from localhost (192.168.154.110) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.210.2; Mon, 18 Jan
 2016 15:05:19 +0000
Date:   Mon, 18 Jan 2016 15:05:19 +0000
From:   James Hogan <james.hogan@imgtec.com>
To:     Govindraj Raja <Govindraj.Raja@imgtec.com>
CC:     <linux-mips@linux-mips.org>, Ralf Baechle <ralf@linux-mips.org>,
        "Markos Chandras" <markos.chandras@imgtec.com>,
        Paul Burton <paul.burton@imgtec.com>,
        Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>,
        James Hartley <James.Hartley@imgtec.com>
Subject: Re: [PATCH] mips: scache: fix scache init with invalid line size.
Message-ID: <20160118150519.GC25510@jhogan-linux.le.imgtec.org>
References: <1453126706-24299-1-git-send-email-Govindraj.Raja@imgtec.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="0vzXIDBeUiKkjNJl"
Content-Disposition: inline
In-Reply-To: <1453126706-24299-1-git-send-email-Govindraj.Raja@imgtec.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Originating-IP: [192.168.154.110]
X-ESG-ENCRYPT-TAG: 30575414
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 51197
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

--0vzXIDBeUiKkjNJl
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Govindraj,

On Mon, Jan 18, 2016 at 02:18:26PM +0000, Govindraj Raja wrote:
> In current scache init cache line_size is determined from
> cpu config register, however if there there no scache
> then mips_sc_probe_cm3 function populates a invalid line_size of 2.
>=20
> The invalid line_size can cause a NULL pointer deference
> during r4k_dma_cache_inv as r4k_blast_scache is populated based on
> line_size. Scache line_size of 2 is invalid option in r4k_blast_scache_se=
tup.
>=20
> This issue was faced during a MIPS I6400 based virtual platform bring up
> where scache was not available in virtual platform model.
>=20
> Signed-off-by: Govindraj Raja <Govindraj.Raja@imgtec.com>
> ---
>  arch/mips/mm/sc-mips.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/arch/mips/mm/sc-mips.c b/arch/mips/mm/sc-mips.c
> index 3bd0597..6e422bc 100644
> --- a/arch/mips/mm/sc-mips.c
> +++ b/arch/mips/mm/sc-mips.c
> @@ -168,7 +168,8 @@ static int __init mips_sc_probe_cm3(void)
> =20
>  	line_sz =3D cfg & CM_GCR_L2_CONFIG_LINE_SIZE_MSK;
>  	line_sz >>=3D CM_GCR_L2_CONFIG_LINE_SIZE_SHF;
> -	c->scache.linesz =3D 2 << line_sz;
> +	if (line_sz)
> +		c->scache.linesz =3D 2 << line_sz;

It seems wrong to clear MIPS_CACHE_NOT_PRESENT if we know there isn't a
cache actually present.

Cheers
James

> =20
>  	assoc =3D cfg & CM_GCR_L2_CONFIG_ASSOC_MSK;
>  	assoc >>=3D CM_GCR_L2_CONFIG_ASSOC_SHF;
> --=20
> 2.5.0
>=20

--0vzXIDBeUiKkjNJl
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJWnP8vAAoJEGwLaZPeOHZ6Wr4QAIonqDisKFnRCwHDeu0ER/GY
9+GOKVI58FxG5tvSC18lIKZZXo3fymCSpEI1oLOfWHH3JpUgPiX3rVTEKL2GprPo
OlvtWHynOz47hTr1ZbJ2w2osvVpDHmUzSnHXD0Y6gMF+XIO51uT8LXQTqJJWmt00
HMr3oFiYWWqRsWOGUZqX2PdY6SNe/wk+ueaCfS9RpBkyW1DtZ7BN6Njr/b6dyD2a
Wti0ERt6DjZjCA5ysPPTszbtQ3zH4tDvwSO1wsoQtYBQJzGQp4YDQUkpDSwu7ZUV
gg8/OaU4Dq70yLhuOLZpEOfCIBpQlQBugFudMsZ/M0ilvaq7QA0692rsUtwLrjRY
yOKgm7m6RX0huhNHrKeg+ZtIJWHP/LuAjdrAwHoRrmfD9ZyiYpaiRWCitb1KOs6k
xC3HT01jbAigjdZvWo18KB3/NsUHDnW6cV0ik2ETemC7XIWPdlhkdGa0LqT14BmJ
1XnfcMufIAH9A1JAX9GbFPH7czfKCWwOHP2EeugI0VgdNF8PwufLDReigSOe8hrJ
2MbdhYBFpn3yXaEgyhisfh2OR7Bk/dbQgiYfyyF6xdffASwbLPk7zy/uYoxz/Qn6
teIHyDtVlKFrfu/3N06ZfsGCKboGIBmHnVclIkXhX1vyqCn1mfYv0DBIaHMTRuXR
pTEsXR0I/pG1mKpSBTqk
=CvjW
-----END PGP SIGNATURE-----

--0vzXIDBeUiKkjNJl--
