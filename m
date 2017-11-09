Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 09 Nov 2017 08:48:50 +0100 (CET)
Received: from 19pmail.ess.barracuda.com ([64.235.154.231]:55999 "EHLO
        19pmail.ess.barracuda.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990451AbdKIHsm7RU65 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 9 Nov 2017 08:48:42 +0100
Received: from MIPSMAIL01.mipstec.com (mailrelay.mips.com [12.201.5.28]) by mx1401.ess.rzc.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NO); Thu, 09 Nov 2017 07:47:22 +0000
Received: from localhost (192.168.154.110) by MIPSMAIL01.mipstec.com
 (10.20.43.31) with Microsoft SMTP Server (TLS) id 14.3.361.1; Wed, 8 Nov 2017
 23:47:21 -0800
Date:   Thu, 9 Nov 2017 07:47:19 +0000
From:   James Hogan <james.hogan@mips.com>
To:     Wim Van Sebroeck <wim@iguana.be>
CC:     Mathieu Malaterre <malat@debian.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Paul Cercueil <paul@crapouillou.net>,
        Linus Walleij <linus.walleij@linaro.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        <devicetree@vger.kernel.org>, <linux-mips@linux-mips.org>,
        <linux-kernel@vger.kernel.org>, <linux-watchdog@vger.kernel.org>
Subject: Re: [PATCH 2/3] watchdog: jz4780: Allow selection of jz4740-wdt
 driver
Message-ID: <20171109074718.GR15260@jhogan-linux>
References: <20170908183558.1537-1-malat@debian.org>
 <20170908183558.1537-2-malat@debian.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="eLe8FOcWSbbyMVJD"
Content-Disposition: inline
In-Reply-To: <20170908183558.1537-2-malat@debian.org>
User-Agent: Mutt/1.7.2 (2016-11-26)
X-Originating-IP: [192.168.154.110]
X-BESS-ID: 1510213641-321457-5728-41757-1
X-BESS-VER: 2017.12-r1710252241
X-BESS-Apparent-Source-IP: 12.201.5.28
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.186747
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------
        0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.00 using account:ESS59374 scores of KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND
X-BESS-BRTS-Status: 1
Return-Path: <James.Hogan@mips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60794
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: james.hogan@mips.com
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

--eLe8FOcWSbbyMVJD
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Wim,

On Fri, Sep 08, 2017 at 08:35:54PM +0200, Mathieu Malaterre wrote:
> This driver works for jz4740 & jz4780
>=20
> Suggested-by: Maarten ter Huurne <maarten@treewalker.org>
> Signed-off-by: Mathieu Malaterre <malat@debian.org>

I just noticed that though Ralf applied the other two patches in this
series (defconfig + dt), he hadn't applied this patch.

Please can we have an ack from a watchdog maintainer so this can get
into 4.15 via the MIPS tree? It could alternatively go via the watchdog
tree if you prefer.

Thanks
James

> ---
>  drivers/watchdog/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
> index c722cbfdc7e6..ca200d1f310a 100644
> --- a/drivers/watchdog/Kconfig
> +++ b/drivers/watchdog/Kconfig
> @@ -1460,7 +1460,7 @@ config INDYDOG
> =20
>  config JZ4740_WDT
>  	tristate "Ingenic jz4740 SoC hardware watchdog"
> -	depends on MACH_JZ4740
> +	depends on MACH_JZ4740 || MACH_JZ4780
>  	select WATCHDOG_CORE
>  	help
>  	  Hardware driver for the built-in watchdog timer on Ingenic jz4740 SoC=
s.
> --=20
> 2.11.0
>=20
>=20

--eLe8FOcWSbbyMVJD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEd80NauSabkiESfLYbAtpk944dnoFAloEB/0ACgkQbAtpk944
dnqjVA/+NBFJj9xGzjZBF7j8SB64O6oIE+ZUb3J6D3PwsWW/jOfxiEPPz7pQmZQ0
BNkL5TGx2K/kb+TW3qpc5H/80q3WlZzU6Z6XV/gC7JR3SEfuguJxZ7tsavWUsyJD
g0nWcyb8x6usMvHLQFwDWPApkak4XvLp7p9EkeBrAPGlMeveJAbxBWCwywG92dg3
BiaVP9JkOV/tz1c4I33vnDKGNedBqPRjrLKcdKqnzddaHXKyaAtoGiLl6UkcaNMb
l0yuOzz2NVLIuML7dzkYbiqsCoBjOMQo8QI8HOaGFkc+qvZLYJ5f5gDQ2CD8gERU
mDG52f9xueoHIQIdQ3exAHVrudRrwNXLDaZ7IChj3tert96QWkqeB+zBKpEBpgth
ojwM7mvSeiX02EPLW5iQCJQejKw/dydN4xWEZHJdGQtCZZXOl3MpVQlrioyJTBzM
PZIS1XYJpAurF4Ve63s/KcgFOHR0zGSnQMa9ZIov1OlcS9vXOuwM49Dyr3EgjcJC
lIE1EKTSnfoPSM0o9ft0U6m+ve9IUPcVCfmIm2433N9VPPL9f/WyTDR01D9tXXv3
EmcV7JU4rHhc2X+y4Jy0tnAsI1iN/sT8VdxoH1D8Ab+4q7MgBNpEHmq84e0rVv5n
uugOr6IvWBb/rQprex7mL2Tq3KLlF8ZT1DSH5oXVugQSDgTQUgU=
=UwIM
-----END PGP SIGNATURE-----

--eLe8FOcWSbbyMVJD--
