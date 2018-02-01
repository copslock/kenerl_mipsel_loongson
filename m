Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 01 Feb 2018 17:08:21 +0100 (CET)
Received: from mail.kernel.org ([198.145.29.99]:37084 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23994841AbeBAQINyTAhz (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 1 Feb 2018 17:08:13 +0100
Received: from saruman (jahogan.plus.com [212.159.75.221])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 79EF52178E;
        Thu,  1 Feb 2018 16:08:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 79EF52178E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=jhogan@kernel.org
Date:   Thu, 1 Feb 2018 16:08:01 +0000
From:   James Hogan <jhogan@kernel.org>
To:     Luis de Bethencourt <luisbg@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Joe Perches <joe@perches.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Al Viro <viro@zeniv.linux.org.uk>, linux-mips@linux-mips.org
Subject: Re: [PATCH] MIPS: Fix trailing semicolon
Message-ID: <20180201160801.GN7637@saruman>
References: <20180123133803.26789-1-luisbg@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="1rguoi8KZGYj2k4L"
Content-Disposition: inline
In-Reply-To: <20180123133803.26789-1-luisbg@kernel.org>
User-Agent: Mutt/1.7.2 (2016-11-26)
Return-Path: <jhogan@kernel.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 62401
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


--1rguoi8KZGYj2k4L
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 23, 2018 at 01:38:03PM +0000, Luis de Bethencourt wrote:
> The trailing semicolon is an empty statement that does no operation.
> Removing it since it doesn't do anything.
>=20
> Signed-off-by: Luis de Bethencourt <luisbg@kernel.org>

Applied to my 4.16 branch,

Thanks
James

> ---
>=20
> Hi,
>=20
> After fixing the same thing in drivers/staging/rtl8723bs/, Joe Perches
> suggested I fix it treewide [0].
>=20
> Best regards=20
> Luis
>=20
>=20
> [0] http://driverdev.linuxdriverproject.org/pipermail/driverdev-devel/201=
8-January/115410.html
> [1] http://driverdev.linuxdriverproject.org/pipermail/driverdev-devel/201=
8-January/115390.html
>=20
>  arch/mips/include/asm/checksum.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/arch/mips/include/asm/checksum.h b/arch/mips/include/asm/che=
cksum.h
> index 77cad232a1c6..e8161e4dfde7 100644
> --- a/arch/mips/include/asm/checksum.h
> +++ b/arch/mips/include/asm/checksum.h
> @@ -110,7 +110,7 @@ __wsum csum_partial_copy_nocheck(const void *src, voi=
d *dst,
>   */
>  static inline __sum16 csum_fold(__wsum csum)
>  {
> -	u32 sum =3D (__force u32)csum;;
> +	u32 sum =3D (__force u32)csum;
> =20
>  	sum +=3D (sum << 16);
>  	csum =3D (sum < csum);
> --=20
> 2.15.1
>=20

--1rguoi8KZGYj2k4L
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEd80NauSabkiESfLYbAtpk944dnoFAlpzO2EACgkQbAtpk944
dnqn1A//T50PTqfoRRo7Q2UpltX3WXdXAedu8uTG+EqkILsX+ssn2+P+76YBSHLU
VdDmME/RLu5/4cLrD7MjE3SkFWJ7iEy5xr4wSdTqjTkV7cKRr59xsIF0uiONUcYG
BbjuxpLYxWfNOnfLtKY1QREBSxrB0AjRZQxK1BNX1UArTNzWt5rTwPWpN6iScbSa
Pw0FzVphhc9i4LzhbPN1StXJ5cPtWNBIeeiHzXvJEYh/gupcm0KVInMfJhymtiii
6u4oahQA4KHN8cyT37clhH4mQyaNsVyKpLjH7jb8odbaJjRFO/Vrzk3Cfh36Fk/+
6LIuW8GP/LynpHKYstx4FxQvPqDyS6ytpMt/WN2DauIZbEOFTu+E4NmCpz8tWb2A
y8YfwmaBGEoymHvy0Vol0YJ+ePDxX4ZbKSd/VfSDKE+2pducZWzZWiEAwPLmwZWq
KEeqSHrdCZPflhWdOB+9+9nvDSm6St7IgS/4pc78/vFf2gWNLAqq7yTMAT0MMt9u
MqOFm0XoRmHXukyuC4hCf1cjNpF3Ox9qZSV6TcvwCjhnen0WN1UtGTmkAWuGXpr6
6+DMIbYpw8J/mb9ZPSeYzwiDnW/dgIh18tH36mrWQEOy9GBo/yD+m4oclPxoYBPs
9nbgwARIDdxfmdDA6ndzDHshDdLUIgYD4ywscQ1QqiF4weiTDf4=
=6d11
-----END PGP SIGNATURE-----

--1rguoi8KZGYj2k4L--
