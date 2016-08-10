Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 10 Aug 2016 12:17:59 +0200 (CEST)
Received: from comal.ext.ti.com ([198.47.26.152]:38684 "EHLO comal.ext.ti.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23992424AbcHJKRvtS0AH (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 10 Aug 2016 12:17:51 +0200
Received: from dflxv15.itg.ti.com ([128.247.5.124])
        by comal.ext.ti.com (8.13.7/8.13.7) with ESMTP id u7AAHUgh003826;
        Wed, 10 Aug 2016 05:17:30 -0500
Received: from DFLE73.ent.ti.com (dfle73.ent.ti.com [128.247.5.110])
        by dflxv15.itg.ti.com (8.14.3/8.13.8) with ESMTP id u7AAHTmj018941;
        Wed, 10 Aug 2016 05:17:29 -0500
Received: from dlep32.itg.ti.com (157.170.170.100) by DFLE73.ent.ti.com
 (128.247.5.110) with Microsoft SMTP Server id 14.3.294.0; Wed, 10 Aug 2016
 05:17:28 -0500
Received: from [192.168.2.6] (ileax41-snat.itg.ti.com [10.172.224.153]) by
 dlep32.itg.ti.com (8.14.3/8.13.8) with ESMTP id u7AAHODD032624;        Wed, 10 Aug
 2016 05:17:25 -0500
Subject: Re: [PATCH 16/20] fbdev: cobalt_lcdfb: Drop SEAD3 support
To:     Paul Burton <paul.burton@imgtec.com>, <linux-mips@linux-mips.org>,
        Ralf Baechle <ralf@linux-mips.org>
References: <20160809123546.10190-1-paul.burton@imgtec.com>
 <20160809123546.10190-17-paul.burton@imgtec.com>
CC:     Ondrej Zary <linux@rainbow-software.org>,
        <linux-fbdev@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        "Maciej W. Rozycki" <macro@linux-mips.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
        <linux-kernel@vger.kernel.org>,
        Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Simon Horman <horms+renesas@verge.net.au>
From:   Tomi Valkeinen <tomi.valkeinen@ti.com>
Message-ID: <355f078b-b81c-61ef-6c1f-8f5a345cb441@ti.com>
Date:   Wed, 10 Aug 2016 13:17:25 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.2.0
MIME-Version: 1.0
In-Reply-To: <20160809123546.10190-17-paul.burton@imgtec.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature";
        boundary="X4nskscgpLWoSE2VraiT27ojT48PMUJjT"
Return-Path: <tomi.valkeinen@ti.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 54470
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

--X4nskscgpLWoSE2VraiT27ojT48PMUJjT
Content-Type: multipart/mixed; boundary="TBJLpd01qRBGFesQsvgsowEibFS5LOsGa"
From: Tomi Valkeinen <tomi.valkeinen@ti.com>
To: Paul Burton <paul.burton@imgtec.com>, linux-mips@linux-mips.org,
 Ralf Baechle <ralf@linux-mips.org>
Cc: Ondrej Zary <linux@rainbow-software.org>, linux-fbdev@vger.kernel.org,
 Arnd Bergmann <arnd@arndb.de>, Robert Jarzmik <robert.jarzmik@free.fr>,
 "Maciej W. Rozycki" <macro@linux-mips.org>,
 Linus Walleij <linus.walleij@linaro.org>,
 Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
 linux-kernel@vger.kernel.org,
 Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Simon Horman <horms+renesas@verge.net.au>
Message-ID: <355f078b-b81c-61ef-6c1f-8f5a345cb441@ti.com>
Subject: Re: [PATCH 16/20] fbdev: cobalt_lcdfb: Drop SEAD3 support
References: <20160809123546.10190-1-paul.burton@imgtec.com>
 <20160809123546.10190-17-paul.burton@imgtec.com>
In-Reply-To: <20160809123546.10190-17-paul.burton@imgtec.com>

--TBJLpd01qRBGFesQsvgsowEibFS5LOsGa
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 09/08/16 15:35, Paul Burton wrote:
> The SEAD3 board no longer uses the cobalt_lcdfb driver, so remove the
> SEAD3-specific code from it.
>=20
> Signed-off-by: Paul Burton <paul.burton@imgtec.com>
> ---
>=20
>  drivers/video/fbdev/Kconfig        |  2 +-
>  drivers/video/fbdev/cobalt_lcdfb.c | 42 ------------------------------=
--------
>  2 files changed, 1 insertion(+), 43 deletions(-)

Acked-by: Tomi Valkeinen <tomi.valkeinen@ti.com>

 Tomi


--TBJLpd01qRBGFesQsvgsowEibFS5LOsGa--

--X4nskscgpLWoSE2VraiT27ojT48PMUJjT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJXqv81AAoJEPo9qoy8lh71HTIP/1FldFHomssLajEP6Z5Barl7
AL9lRRDMvR2/40LMvJowAqPH+SFO/7jGHwdGtXqPBI4Ts3bOGpetqsy3zA0XicHX
b7RrZ5Khc+tmK9JCFNWuJFYSctHDQnxCHqcwI/FA1vuqhC/yJpRkqFDkZZ7HtsvN
KQ6ElEYC6VZK4q9BwhtfZfn727SC9E468RpAO9KhYw50aooDd9OaBiXHuNRIaHi5
AdOTyMDvPTBp68DkjNRt0YerjtSQGGjHHmrl4F+PbXIgk+F66/dGYtjDX4lBqK0B
eLEf+eiDHsBBjSLBArOkRZWioDVv2X5lsG6MSp79XaNWpJI7uXfj0dhqeiLmwo4w
qqbEnI8MAuJRrcjQkVpszCAum9gBmZ0D0XQZ07gexLLvRbNalpBHcpEpj6F65agV
Kcxfj4rQWVsXUzYOyS3oYpr2RSOwUt3hE//CVpOGztAJqBxKfdnMk9jHNMGuvpjm
wdLPFk8mMIvdLSA6Sl0GLkHzThsWcz+AOVe7eeNgWHkSGz3C1rF9wFAe/XvPcQ/i
nOjJHtaGU4BQnPCE1Wj2x03bKsJdri8w4O0Fttuld/FkQJqBECMmPuMkW/JmDtAA
H2SLuXJ/y2I6mJO6Nn2mbZ90SDZJmte3NBG078usaXE31poeYH+o6bmrlmjNMy6t
CK3y3ew5LNYXNcFvuIQe
=GX+e
-----END PGP SIGNATURE-----

--X4nskscgpLWoSE2VraiT27ojT48PMUJjT--
