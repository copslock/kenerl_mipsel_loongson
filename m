Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 17 Jan 2018 20:56:37 +0100 (CET)
Received: from 9pmail.ess.barracuda.com ([64.235.154.211]:53859 "EHLO
        9pmail.ess.barracuda.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993497AbeAQT42xuAG- (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 17 Jan 2018 20:56:28 +0100
Received: from MIPSMAIL01.mipstec.com (mailrelay.mips.com [12.201.5.28]) by mx1403.ess.rzc.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NO); Wed, 17 Jan 2018 19:55:49 +0000
Received: from localhost (192.168.154.110) by MIPSMAIL01.mipstec.com
 (10.20.43.31) with Microsoft SMTP Server (TLS) id 14.3.361.1; Wed, 17 Jan
 2018 11:55:29 -0800
Date:   Wed, 17 Jan 2018 19:55:28 +0000
From:   James Hogan <james.hogan@mips.com>
To:     Corentin Labbe <clabbe.montjoie@gmail.com>
CC:     <ralf@linux-mips.org>, <linux-kernel@vger.kernel.org>,
        <linux-mips@linux-mips.org>
Subject: Re: [PATCH] MIPS: fix typo BIG_ENDIAN to CPU_BIG_ENDIAN
Message-ID: <20180117195527.GZ27409@jhogan-linux.mipstec.com>
References: <20180117185638.22426-1-clabbe.montjoie@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="CRrRoVXEpX/Dc4YP"
Content-Disposition: inline
In-Reply-To: <20180117185638.22426-1-clabbe.montjoie@gmail.com>
User-Agent: Mutt/1.7.2 (2016-11-26)
X-Originating-IP: [192.168.154.110]
X-BESS-ID: 1516218946-321459-5293-5951-4
X-BESS-VER: 2017.17-r1801171719
X-BESS-Apparent-Source-IP: 12.201.5.28
X-BESS-Outbound-Spam-Score: 0.50
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.189083
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------
        0.50 BSF_RULE7568M          META: Custom Rule 7568M 
        0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.50 using account:ESS59374 scores of KILL_LEVEL=7.0 tests=BSF_RULE7568M, BSF_BESS_OUTBOUND
X-BESS-BRTS-Status: 1
Return-Path: <James.Hogan@mips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 62206
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

--CRrRoVXEpX/Dc4YP
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 17, 2018 at 07:56:38PM +0100, Corentin Labbe wrote:
> MIPS_GENERIC select some options with condition on BIG_ENDIAN which do
> not exists.
> Replace BIG_ENDIAN by CPU_BIG_ENDIAN which is the correct kconfig name.
> Note that BMIP_GENERIC do the same which confirm that this patch is
> needed.
>=20
> Fixes: eed0eabd12ef0 ("MIPS: generic: Introduce generic DT-based board su=
pport")
> Signed-off-by: Corentin Labbe <clabbe.montjoie@gmail.com>

Good spot:
Reviewed-by: James Hogan <jhogan@kernel.org>

Probably worthy of a backport too:
Cc: <stable@vger.kernel.org> # 4.9+

Cheers
James

> ---
>  arch/mips/Kconfig | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
>=20
> diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
> index 13c6e5cb6055..504e78ff0b00 100644
> --- a/arch/mips/Kconfig
> +++ b/arch/mips/Kconfig
> @@ -119,12 +119,12 @@ config MIPS_GENERIC
>  	select SYS_SUPPORTS_MULTITHREADING
>  	select SYS_SUPPORTS_RELOCATABLE
>  	select SYS_SUPPORTS_SMARTMIPS
> -	select USB_EHCI_BIG_ENDIAN_DESC if BIG_ENDIAN
> -	select USB_EHCI_BIG_ENDIAN_MMIO if BIG_ENDIAN
> -	select USB_OHCI_BIG_ENDIAN_DESC if BIG_ENDIAN
> -	select USB_OHCI_BIG_ENDIAN_MMIO if BIG_ENDIAN
> -	select USB_UHCI_BIG_ENDIAN_DESC if BIG_ENDIAN
> -	select USB_UHCI_BIG_ENDIAN_MMIO if BIG_ENDIAN
> +	select USB_EHCI_BIG_ENDIAN_DESC if CPU_BIG_ENDIAN
> +	select USB_EHCI_BIG_ENDIAN_MMIO if CPU_BIG_ENDIAN
> +	select USB_OHCI_BIG_ENDIAN_DESC if CPU_BIG_ENDIAN
> +	select USB_OHCI_BIG_ENDIAN_MMIO if CPU_BIG_ENDIAN
> +	select USB_UHCI_BIG_ENDIAN_DESC if CPU_BIG_ENDIAN
> +	select USB_UHCI_BIG_ENDIAN_MMIO if CPU_BIG_ENDIAN
>  	select USE_OF
>  	help
>  	  Select this to build a kernel which aims to support multiple boards,
> --=20
> 2.13.6
>=20
>=20

--CRrRoVXEpX/Dc4YP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEd80NauSabkiESfLYbAtpk944dnoFAlpfqiMACgkQbAtpk944
dnoQ4Q//bfwU5ov0Ge3GWNQDJEfZVOZF2QwBMPW7yg+c70OQHC0v9RFRdf6gwcdy
PKaTsbII9ZZv1zwDwJMFc5CS6elJLT8fpL8BdV1oQ/gH4/m1GzM357pNMypk6LQf
4s9Yp7E8k8mViik4TyZ9B2zCmRH1yG99KNVR7bEHCfvTgTp1uE6wFATPgyIzbtD8
p6jb/Fu2CxAluAcyw58qioxoLENu4n2pGHKXa9sJ0CFMCvAAGpfF2eH9q/1kNgZu
mc4zgucCKhv+PdhH0fWUM/NmW1wAPv4jOVQMblK9onFt4QnJe96aFtZp7JhpM2ae
EsEFWPNGqNJEm4ls2Nl63U4rXwmQ7/BSuLiHhPyP254cOXTGNi6kMjMnMPLCPG/+
shBO1GOLjD+kj0vIdJkq8gxKwc6Y7jjzbcH5VXPpbQhEk4198hXsMpo/uZ4nFWgD
H1nFU+UWW48ATBdY9d3p9rdowBMFmfbfNza8XpqN8TCb4dn41G7SMvtw3NAeSflY
Djlojqb/uWzbIoegcksNlpx5MzczkAJnLtIlume6GB2IpLYItpAMgbTMEKfe9BUj
otOBa//Kv+yyiSJ3zv4mlEREZuXjMqMhkcLkIACOgw6so5MiTZ+ytBqKy/Ma/jxx
usWugINdDpBafDsklidCSiYYzfuFkKvdt2u6xu42r13/uoEnJEM=
=kNim
-----END PGP SIGNATURE-----

--CRrRoVXEpX/Dc4YP--
