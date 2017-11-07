Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 07 Nov 2017 22:40:22 +0100 (CET)
Received: from 19pmail.ess.barracuda.com ([64.235.154.230]:41254 "EHLO
        19pmail.ess.barracuda.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992329AbdKGVkOcVrh5 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 7 Nov 2017 22:40:14 +0100
Received: from MIPSMAIL01.mipstec.com (mailrelay.mips.com [12.201.5.28]) by mx1412.ess.rzc.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NO); Tue, 07 Nov 2017 21:39:54 +0000
Received: from localhost (192.168.154.110) by MIPSMAIL01.mipstec.com
 (10.20.43.31) with Microsoft SMTP Server (TLS) id 14.3.361.1; Tue, 7 Nov 2017
 13:37:54 -0800
Date:   Tue, 7 Nov 2017 21:39:15 +0000
From:   James Hogan <james.hogan@mips.com>
To:     Jaedon Shin <jaedon.shin@gmail.com>
CC:     Ralf Baechle <ralf@linux-mips.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Kevin Cernekee <cernekee@gmail.com>,
        <linux-mips@linux-mips.org>
Subject: Re: [PATCH] MIPS: BMIPS: Fix missing cbr address
Message-ID: <20171107213915.GK15260@jhogan-linux>
References: <20170616110301.38103-1-jaedon.shin@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="Z8yxTSU1mh2gsre7"
Content-Disposition: inline
In-Reply-To: <20170616110301.38103-1-jaedon.shin@gmail.com>
User-Agent: Mutt/1.7.2 (2016-11-26)
X-Originating-IP: [192.168.154.110]
X-BESS-ID: 1510090790-452060-31097-1076682-12
X-BESS-VER: 2017.12.1-r1710261623
X-BESS-Apparent-Source-IP: 12.201.5.28
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.186687
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
X-archive-position: 60754
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

--Z8yxTSU1mh2gsre7
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 16, 2017 at 08:03:01PM +0900, Jaedon Shin wrote:
> Fixes NULL pointer access in BMIPS3300 RAC flush.
>=20
> Fixes: 738a3f79027b ("MIPS: BMIPS: Add early CPU initialization code")
> Signed-off-by: Jaedon Shin <jaedon.shin@gmail.com>

Thanks. Applied for 4.14.

Cheers
James

> ---
>  arch/mips/kernel/smp-bmips.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/arch/mips/kernel/smp-bmips.c b/arch/mips/kernel/smp-bmips.c
> index 1b070a76fcdd..5e0d87f4958f 100644
> --- a/arch/mips/kernel/smp-bmips.c
> +++ b/arch/mips/kernel/smp-bmips.c
> @@ -589,11 +589,11 @@ void __init bmips_cpu_setup(void)
> =20
>  		/* Flush and enable RAC */
>  		cfg =3D __raw_readl(cbr + BMIPS_RAC_CONFIG);
> -		__raw_writel(cfg | 0x100, BMIPS_RAC_CONFIG);
> +		__raw_writel(cfg | 0x100, cbr + BMIPS_RAC_CONFIG);
>  		__raw_readl(cbr + BMIPS_RAC_CONFIG);
> =20
>  		cfg =3D __raw_readl(cbr + BMIPS_RAC_CONFIG);
> -		__raw_writel(cfg | 0xf, BMIPS_RAC_CONFIG);
> +		__raw_writel(cfg | 0xf, cbr + BMIPS_RAC_CONFIG);
>  		__raw_readl(cbr + BMIPS_RAC_CONFIG);
> =20
>  		cfg =3D __raw_readl(cbr + BMIPS_RAC_ADDRESS_RANGE);
> --=20
> 2.13.1
>=20
>=20

--Z8yxTSU1mh2gsre7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEd80NauSabkiESfLYbAtpk944dnoFAloCJ/wACgkQbAtpk944
dnoMjQ/9EIHPM+IMm/zpYvkKQ7oXmtuzgyBOLM8g8SiHBrJuvZ7zMeDKCeFWBkDY
Uqu+MQK2AGnBsTfjiqSBgiaO7p78oTYKjRYFJ5GbqNBwZYLTMBoWyz4/DUUZ0CXo
2S4AXmmqQf0FnbTtGd5lt6FCZNg0qvyeYvOCUwtuU9RK6QKEVy3nzL/OTAbzdgZp
ArS277LXCzb3aDFQ0TUcg58GPkh03GOzreh+FXs95uy3lZ1m6BbaKPQfzXvEKxhN
+kOvB7lxvqwIS3Z5vuuFHwY2P20G9/OQtz2Mch6dc0GFjxBzWU2ZwdkbkKTxPYWu
s/lM4ktBlU93d6vFD9pgb3afTQoIzxRrA1Jyqxyl02CFC9IX90DPKo2GXVjjEET9
HrG+VvpMA1G+6knwUvWB7Z1fExJ+2hyseXjsPfD3gEtKQeYSpSlbtND58wqalJn9
FZcmE4hml66oTtNcjY92WrFEEhJWrKwgTJTHfk7h07X6NvQRDnrzspFEbi0ud6NI
wwYOJdt/vYMpxHKYl2+yNsRjNjwquM5hyz6KzXxLekXwGrfdF3hi9bTx70fr288d
vi/uzbpv2blDxpOl6/JwQ16go2ZaSwK8L1oumiRp5+uMVHySM1FX/2C7lLvpbDJf
JGonuASwTWxkLczexDagvtC2hSYARThlecHBD4JFsnlM7vw/g/o=
=mMww
-----END PGP SIGNATURE-----

--Z8yxTSU1mh2gsre7--
