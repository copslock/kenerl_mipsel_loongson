Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 10 Jan 2014 12:56:24 +0100 (CET)
Received: from bear.ext.ti.com ([192.94.94.41]:59179 "EHLO bear.ext.ti.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6825633AbaAJL4VcXSJn (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 10 Jan 2014 12:56:21 +0100
Received: from dflxv15.itg.ti.com ([128.247.5.124])
        by bear.ext.ti.com (8.13.7/8.13.7) with ESMTP id s0ABu8Pa017379;
        Fri, 10 Jan 2014 05:56:08 -0600
Received: from DLEE71.ent.ti.com (dlee71.ent.ti.com [157.170.170.114])
        by dflxv15.itg.ti.com (8.14.3/8.13.8) with ESMTP id s0ABu8lc027117;
        Fri, 10 Jan 2014 05:56:08 -0600
Received: from dflp33.itg.ti.com (10.64.6.16) by DLEE71.ent.ti.com
 (157.170.170.114) with Microsoft SMTP Server id 14.2.342.3; Fri, 10 Jan 2014
 05:56:08 -0600
Received: from [192.168.2.6] (ileax41-snat.itg.ti.com [10.172.224.153]) by
 dflp33.itg.ti.com (8.14.3/8.13.8) with ESMTP id s0ABu6na032250;        Fri, 10 Jan
 2014 05:56:07 -0600
Message-ID: <52CFDFD6.8090006@ti.com>
Date:   Fri, 10 Jan 2014 13:56:06 +0200
From:   Tomi Valkeinen <tomi.valkeinen@ti.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.2.0
MIME-Version: 1.0
To:     Geert Uytterhoeven <geert@linux-m68k.org>
CC:     Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        <linux-fbdev@vger.kernel.org>, <linux-mips@linux-mips.org>
Subject: Re: [PATCH] video/logo: Remove MIPS-specific include section
References: <1383554550-20901-1-git-send-email-geert@linux-m68k.org>
In-Reply-To: <1383554550-20901-1-git-send-email-geert@linux-m68k.org>
X-Enigmail-Version: 1.6
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature";
        boundary="8KjpcTeU1MJM80E72GwlgrCSqwr4a0pIO"
Return-Path: <tomi.valkeinen@ti.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 38927
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tomi.valkeinen@ti.com
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

--8KjpcTeU1MJM80E72GwlgrCSqwr4a0pIO
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 2013-11-04 10:42, Geert Uytterhoeven wrote:
> Since commit 41702d9a4fffa9e25b2ad9d4af09b3013fa155e1 ("logo.c: get rid=
 of
> mips_machgroup") there's no longer a need to include <asm/bootinfo.h> o=
n
> MIPS.
>=20
> Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
> ---
>  drivers/video/logo/logo.c |    4 ----
>  1 file changed, 4 deletions(-)
>=20
> diff --git a/drivers/video/logo/logo.c b/drivers/video/logo/logo.c
> index 080c35b34bbb..b670cbda38e3 100644
> --- a/drivers/video/logo/logo.c
> +++ b/drivers/video/logo/logo.c
> @@ -17,10 +17,6 @@
>  #include <asm/setup.h>
>  #endif
> =20
> -#ifdef CONFIG_MIPS
> -#include <asm/bootinfo.h>
> -#endif
> -
>  static bool nologo;
>  module_param(nologo, bool, 0);
>  MODULE_PARM_DESC(nologo, "Disables startup logo");
>=20

Queued for 3.14.

 Tomi



--8KjpcTeU1MJM80E72GwlgrCSqwr4a0pIO
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.14 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQIcBAEBAgAGBQJSz9/WAAoJEPo9qoy8lh71c/0P/j0iSGTh1uodjhJ1MQG4oL0L
pOeKJgfeyLqZRcPiKXzYuau//hqNbrDGlGkKws1yI2S5Q7JoFdJheAnGG8q/NApx
WTi6eYly+CyyVEqLMXCSZE+rJ1basIIn/bh2aeLwSJ1xodErVT4IrsUOfSvyd9Im
xP1RXr3hEH398bY2U8VmtKaV0dKbZgGkTiKgSozyQtS8xaArv603qpyB50s08wCz
yLU4ZXtdMLlkTfm7f5VusbNRpqR9hvHhD13YJ5wdFshtfTkLWJteCW7TJayra1UG
XLsrWNfQ20+VpeVcxOUdAOQPOgg7G1D+FIA1s+JD7q/1EsGB6Hnm4ZpwdCuPnYEi
l9VYPROTjgIXfC+XTSXKaqEaGCk5KmTqTb+B32BJ3YZbYjbEkipIl3gCyak/frf7
qz34hBCtqcMUa4C/rDpIMFXR/SDgyL7tLg3mJXu8PsZqhkRE3pfv4CxctLCv36+x
/7hHAgbUkFl/YdeIm5viLHBe5gDLzRNSvXdsbiBlQQqzF9QrvVtjOKZQSWM7iYoc
Dr9gdmFwggXO/ARIsKe0dIewPhNuVBdJdsXYlzBPnxD45jMKpGcJ21dScDLNHfA4
O70LfWW51wya3PZ1ey5sVN+dRBV3HdEqHGx2UR6qripPrTku/jL5GVpErLPqSE2m
jqERWGabD/x68GUOlN+C
=zDEo
-----END PGP SIGNATURE-----

--8KjpcTeU1MJM80E72GwlgrCSqwr4a0pIO--
