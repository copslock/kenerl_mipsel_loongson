Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 26 Jan 2018 11:09:42 +0100 (CET)
Received: from mail.kernel.org ([198.145.29.99]:56258 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23990410AbeAZKJfqtRyU (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 26 Jan 2018 11:09:35 +0100
Received: from saruman (jahogan.plus.com [212.159.75.221])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2397A21785;
        Fri, 26 Jan 2018 10:09:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2397A21785
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=jhogan@kernel.org
Date:   Fri, 26 Jan 2018 10:09:03 +0000
From:   James Hogan <jhogan@kernel.org>
To:     Sven Joachim <svenjoac@gmx.de>
Cc:     Michael Buesch <m@bues.ch>, linux-wireless@vger.kernel.org,
        linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        Matt Redfearn <matt.redfearn@imgtec.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Kalle Valo <kvalo@codeaurora.org>
Subject: Re: [PATCH] ssb: Do not disable PCI host on non-Mips
Message-ID: <20180126100902.GN5446@saruman>
References: <87vafpq7t2.fsf@turtle.gmx.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="citGix+cyBYE+lqp"
Content-Disposition: inline
In-Reply-To: <87vafpq7t2.fsf@turtle.gmx.de>
User-Agent: Mutt/1.7.2 (2016-11-26)
Return-Path: <jhogan@kernel.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 62337
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


--citGix+cyBYE+lqp
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 26, 2018 at 10:38:01AM +0100, Sven Joachim wrote:
> After upgrading an old laptop to 4.15-rc9, I found that the eth0 and
> wlan0 interfaces had disappeared.  It turns out that the b43 and b44
> drivers require SSB_PCIHOST_POSSIBLE which depends on
> PCI_DRIVERS_LEGACY, a config option that only exists on Mips.
>=20
> Fixes: 58eae1416b80 ("ssb: Disable PCI host for PCI_DRIVERS_GENERIC")
> Cc: stable@vger.org
> Signed-off-by: Sven Joachim <svenjoac@gmx.de>

Whoops, thats a very good point. I hadn't twigged that
PCI_DRIVERS_LEGACY was MIPS specific (one of the disadvantages of using
"tig grep" I suppose!).

Reviewed-by: James Hogan <jhogan@kernel.org>

I think this is obviously correct, so it'd be great to squeeze it into
4.15 final.

Fortunately the other related change, commit 664eadd6f44b ("bcma: Fix
'allmodconfig' and BCMA builds on MIPS targets"), already depends on
MIPS so doesn't have the same issue.

Sorry for the breakage!
James

> ---
>  drivers/ssb/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/ssb/Kconfig b/drivers/ssb/Kconfig
> index 71c73766ee22..65af12c3bdb2 100644
> --- a/drivers/ssb/Kconfig
> +++ b/drivers/ssb/Kconfig
> @@ -32,7 +32,7 @@ config SSB_BLOCKIO
> =20
>  config SSB_PCIHOST_POSSIBLE
>  	bool
> -	depends on SSB && (PCI =3D y || PCI =3D SSB) && PCI_DRIVERS_LEGACY
> +	depends on SSB && (PCI =3D y || PCI =3D SSB) && (PCI_DRIVERS_LEGACY || =
!MIPS)
>  	default y
> =20
>  config SSB_PCIHOST
> --=20
> 2.15.1
>=20

--citGix+cyBYE+lqp
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEd80NauSabkiESfLYbAtpk944dnoFAlpq/jcACgkQbAtpk944
dnoJ7BAAp8ZL9TaQ6/JF0Sxbj+hyxNM2WfCH6hz3YaxrsYBL4SgmbDzhUd4fTpqw
BM4SM5khbrtr9DriVKNn4rL4P/0mqzzwC/5OhBSE3H6nK7aVEBjnnepFPUHc/doH
QuBFimcAwJa2cZnenmkGVte2fNLjjLk1JhBwnSsCnlrrJa2uGsOEQK/eTJ22Vw/o
QELGehKt1VmvrZC1vQp6tegoXN69uOA9ClqPNUyPmChafxqoNS8VyWH6bQmlXAq3
2oqS5Vzvc+re8Rs1CRCj0n/l0XP/wQLLyqoZD0lMKyFfXThvZZdYtIyz7Kj8YboK
b/ZkTDw32fKsOgDFsDwTXrw0Z7P/3dXWZ5FuJcGo5xTgENNbq6ZaMxIzKqUHJbFA
P6NOVRapeWtBi3OHPr7TACr4GBkz85FISuVh8Raz6j7Ot9ed2eheSuB17xQ0TV5N
Gm+gssmiyiOgtUZog15OJIjFGvP6usQ1R8kGagoLdbgVzhAAie/bK6xzKEfcdDiJ
xBA9UxVS0O+8hTCi/jiFG6VMLwd87I9Pr3cZ2sM/xXZg9Ys0RnZ7fOBYsBYaP96Y
Bwtmxw7QRdwhgbg8HdwYpn2XDd4fyC/Jovt4QIkyYv5jHJhpRW4U6MEHEGv9LkPc
fjJ6Z1X5cnkWh0FI0/bgukk/zHkpjUDbMte/5YWGDyOcjIwlHWU=
=XUPc
-----END PGP SIGNATURE-----

--citGix+cyBYE+lqp--
