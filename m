Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 27 Feb 2017 13:54:47 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:23203 "EHLO
        imgpgp01.kl.imgtec.org" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S23992121AbdB0MyjYBZrY (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 27 Feb 2017 13:54:39 +0100
Received: from imgpgp01.kl.imgtec.org (imgpgp01.kl.imgtec.org [127.0.0.1])
        by imgpgp01.kl.imgtec.org (PGP Universal) with ESMTP id 8372141F8EAD;
        Mon, 27 Feb 2017 13:59:06 +0000 (GMT)
Received: from mailapp01.imgtec.com ([10.100.180.241])
  by imgpgp01.kl.imgtec.org (PGP Universal service);
  Mon, 27 Feb 2017 13:59:06 +0000
X-PGP-Universal: processed;
        by imgpgp01.kl.imgtec.org on Mon, 27 Feb 2017 13:59:06 +0000
Received: from hhmail02.hh.imgtec.org (unknown [10.100.10.20])
        by Forcepoint Email with ESMTPS id 06473D5779C74;
        Mon, 27 Feb 2017 12:54:31 +0000 (GMT)
Received: from localhost (192.168.154.110) by hhmail02.hh.imgtec.org
 (10.100.10.21) with Microsoft SMTP Server (TLS) id 14.3.294.0; Mon, 27 Feb
 2017 12:54:33 +0000
Date:   Mon, 27 Feb 2017 12:54:33 +0000
From:   James Hogan <james.hogan@imgtec.com>
To:     John Crispin <john@phrozen.org>
CC:     <linux-mips@linux-mips.org>, Daniel Golle <daniel@makrotopia.org>
Subject: Re: [PATCH V2] arch: mips: ralink: fix typos in rt3883 pinctrl
Message-ID: <20170227125433.GB2878@jhogan-linux.le.imgtec.org>
References: <1488020063-2385-1-git-send-email-john@phrozen.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="IrhDeMKUP4DT/M7F"
Content-Disposition: inline
In-Reply-To: <1488020063-2385-1-git-send-email-john@phrozen.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Originating-IP: [192.168.154.110]
X-ESG-ENCRYPT-TAG: 1b7d744b
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56901
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

--IrhDeMKUP4DT/M7F
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Feb 25, 2017 at 11:54:23AM +0100, John Crispin wrote:
> There are two copy & paste errors in the definition of the 5GHz LNA and
> second ethernet pinmux.
>=20
> Signed-off-by: John Crispin <john@phrozen.org>
> Signed-off-by: Daniel Golle <daniel@makrotopia.org>

Thanks John, Applied

Cheers
James

> ---
>  arch/mips/ralink/rt3883.c |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/arch/mips/ralink/rt3883.c b/arch/mips/ralink/rt3883.c
> index c4ffd43..48ce701 100644
> --- a/arch/mips/ralink/rt3883.c
> +++ b/arch/mips/ralink/rt3883.c
> @@ -35,7 +35,7 @@
>  static struct rt2880_pmx_func jtag_func[] =3D { FUNC("jtag", 0, 17, 5) };
>  static struct rt2880_pmx_func mdio_func[] =3D { FUNC("mdio", 0, 22, 2) };
>  static struct rt2880_pmx_func lna_a_func[] =3D { FUNC("lna a", 0, 32, 3)=
 };
> -static struct rt2880_pmx_func lna_g_func[] =3D { FUNC("lna a", 0, 35, 3)=
 };
> +static struct rt2880_pmx_func lna_g_func[] =3D { FUNC("lna g", 0, 35, 3)=
 };
>  static struct rt2880_pmx_func pci_func[] =3D {
>  	FUNC("pci-dev", 0, 40, 32),
>  	FUNC("pci-host2", 1, 40, 32),
> @@ -43,7 +43,7 @@
>  	FUNC("pci-fnc", 3, 40, 32)
>  };
>  static struct rt2880_pmx_func ge1_func[] =3D { FUNC("ge1", 0, 72, 12) };
> -static struct rt2880_pmx_func ge2_func[] =3D { FUNC("ge1", 0, 84, 12) };
> +static struct rt2880_pmx_func ge2_func[] =3D { FUNC("ge2", 0, 84, 12) };
> =20
>  static struct rt2880_pmx_group rt3883_pinmux_data[] =3D {
>  	GRP("i2c", i2c_func, 1, RT3883_GPIO_MODE_I2C),
> --=20
> 1.7.10.4
>=20

--IrhDeMKUP4DT/M7F
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIcBAEBCAAGBQJYtCGCAAoJEGwLaZPeOHZ6j54QAJDE0wriTE9jS3oT6kfGDtFE
fcAT6b+mhpqaGFGNFBV/XdDqL0OyjvFgN9btbTahCEax2Ae6S6IFTo4awq7XwR66
ekSkpW9icYSVBUZp/SOX/TvP7xbVDw75zJNFXE8ujGTwU3Fd0dyCnzFwEysDe4N5
Eu1xWSQpMW2GTM0uIPIGgQSBLIVZPRvSBDFv9zCBmz1BWpvQTgEznk2cWajdzkjl
DEgwaaMso0M8k+cjeDfGosFL44x5+vFU/U9/FJ9TRITvoo2oTCMb3ndh6sXCEP+E
6ZOM0xe06YRlT6Ka1RAr6uzqa4PW5ozRgcJ9Xc9uqV4kOXSe3x5+Y2Zo5GEEE1wJ
AiTsrfPa4e52rnN9g+6mtf5XCUsY0eSa0I3WMN/LxCfRJzrxKgj4QZTS2wx/vcdl
AHAi848+shJRKw4eqGK34jBWS7yEU8A8RgQZx2I8OOjjj0roYvyeAN3LrFPKu0gb
xfabieMXpSnF55hW8RTD6swxG/05pypla+7x0LzFbXT+jVVgP1hv7JJdCJVtQD4/
GtzodlPSubYge264qCPNn/zb1Tjlw76wrNbqe8eQC5b6ggGFZcccq0kBRUpJ3xiK
z9EUTDBxHejuznvRyV7XsM3jqLxbjFM1hl7Ja1YL5m4jNdU8L2lZz91csf4oScTt
X42xODB13YK+5Qxvd1If
=d+nT
-----END PGP SIGNATURE-----

--IrhDeMKUP4DT/M7F--
