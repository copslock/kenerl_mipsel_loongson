Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 07 Nov 2017 23:52:00 +0100 (CET)
Received: from 19pmail.ess.barracuda.com ([64.235.154.230]:33145 "EHLO
        19pmail.ess.barracuda.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992910AbdKGWvwz-iYC (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 7 Nov 2017 23:51:52 +0100
Received: from MIPSMAIL01.mipstec.com (mailrelay.mips.com [12.201.5.28]) by mx1402.ess.rzc.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NO); Tue, 07 Nov 2017 22:51:18 +0000
Received: from localhost (192.168.154.110) by MIPSMAIL01.mipstec.com
 (10.20.43.31) with Microsoft SMTP Server (TLS) id 14.3.361.1; Tue, 7 Nov 2017
 14:49:29 -0800
Date:   Tue, 7 Nov 2017 22:50:51 +0000
From:   James Hogan <james.hogan@mips.com>
To:     Martin Schiller <ms@dev.tdt.de>
CC:     <linux-mips@linux-mips.org>, <linux-kernel@vger.kernel.org>,
        <john@phrozen.org>, <ralf@linux-mips.org>, <hauke@hauke-m.de>,
        <arnd@arndb.de>, <nbd@nbd.name>
Subject: Re: [PATCH] MIPS: Lantiq: Fix ASC0/ASC1 clocks
Message-ID: <20171107225050.GM15260@jhogan-linux>
References: <1496118874-4251-1-git-send-email-ms@dev.tdt.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="V3eawNQxI9TAjvgi"
Content-Disposition: inline
In-Reply-To: <1496118874-4251-1-git-send-email-ms@dev.tdt.de>
User-Agent: Mutt/1.7.2 (2016-11-26)
X-Originating-IP: [192.168.154.110]
X-BESS-ID: 1510095006-321458-6107-16953-6
X-BESS-VER: 2017.12-r1709122024
X-BESS-Apparent-Source-IP: 12.201.5.28
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.186690
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
X-archive-position: 60756
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

--V3eawNQxI9TAjvgi
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 30, 2017 at 06:34:34AM +0200, Martin Schiller wrote:
> ASC1 is available on every Lantiq SoC (also AmazonSE) and should be
> enabled like the other generic xway clocks instead of ASC0, which is
> only available for AR9 and Danube.
>=20
> Signed-off-by: Martin Schiller <ms@dev.tdt.de>
> ---
>  arch/mips/lantiq/xway/sysctrl.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>=20
> diff --git a/arch/mips/lantiq/xway/sysctrl.c b/arch/mips/lantiq/xway/sysc=
trl.c
> index 95bec46..cd6dbea 100644
> --- a/arch/mips/lantiq/xway/sysctrl.c
> +++ b/arch/mips/lantiq/xway/sysctrl.c
> @@ -484,9 +484,9 @@ void __init ltq_soc_init(void)
> =20
>  	/* add our generic xway clocks */
>  	clkdev_add_pmu("10000000.fpi", NULL, 0, 0, PMU_FPI);
> -	clkdev_add_pmu("1e100400.serial", NULL, 0, 0, PMU_ASC0);
>  	clkdev_add_pmu("1e100a00.gptu", NULL, 1, 0, PMU_GPT);
>  	clkdev_add_pmu("1e100bb0.stp", NULL, 1, 0, PMU_STP);
> +	clkdev_add_pmu("1e100c00.serial", NULL, 0, 0, PMU_ASC1);
>  	clkdev_add_pmu("1e104100.dma", NULL, 1, 0, PMU_DMA);
>  	clkdev_add_pmu("1e100800.spi", NULL, 1, 0, PMU_SPI);
>  	clkdev_add_pmu("1e105300.ebu", NULL, 0, 0, PMU_EBU);
> @@ -501,7 +501,6 @@ void __init ltq_soc_init(void)
>  	}
> =20
>  	if (!of_machine_is_compatible("lantiq,ase")) {
> -		clkdev_add_pmu("1e100c00.serial", NULL, 0, 0, PMU_ASC1);
>  		clkdev_add_pci();
>  	}

Thanks, applied for 4.15 (and I dropped the braces here too).

Cheers
James

--V3eawNQxI9TAjvgi
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEd80NauSabkiESfLYbAtpk944dnoFAloCOMoACgkQbAtpk944
dnp73RAAjh14QRU27UUJ0ejlxrfIFfFG/QZMSGNfSwkP7PBV3VB8lh5bdldWVirt
g7BxHsFxT/ZicrBnUFoe8I0h2KzjjILXqG8Doz5A0HsPlFK/fxMiYNEItuwyqHH9
rlaBhTDPVx3wOFl1S6j0uKSyGMXQyI6WalKSBBROwABbZTJSQTrXQne9SLcW5E1+
K5dGv1j+1eyxTCtzay8jfhlr7EC7pHG/DGq9eXwAEZhhW36LjtCGtEfUKYrHGPaN
JWiKp7zoFk1CtbcBW+Ch5v3n36csjqDcTXRK7DDGvVfqqJuxTBlLtLWJCb+xqyW2
gvvPArEQVcLNEOqhTKiGfvQWf5A+EtR34dymwAHUYz8izktxbFuqo4Xh6kutxRWo
jB9GoPO1inZ/wAF1bUCSKj88GOPMRgO0No9kJqO4Sl4kBflF9SndC9UWgDabkIuy
HBpaGg1f7iCpLj0Z4BZ24sQA2kwV7lNJchoYm2XUXbucTMzc+StjBei0WvWY1Ce1
kppRlxZK39dGDXMDtHkXGJwar1T2Ji3r3QC/MVNS8CKS/aFT5ZpGwNcsEWJBSdPu
61CdIxIT++cUhcQGTGjghyi4TKWspsGFfyPT/kNmNVq4YdtjTMe0UCu583lihfQe
lvCKg9wob3KqQ6ZygSH518q9gxgPfIPs4nK3fcvcNisuwv8gDwg=
=V9Td
-----END PGP SIGNATURE-----

--V3eawNQxI9TAjvgi--
