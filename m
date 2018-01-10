Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 10 Jan 2018 23:20:21 +0100 (CET)
Received: from 9pmail.ess.barracuda.com ([64.235.154.210]:52771 "EHLO
        9pmail.ess.barracuda.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990435AbeAJWUOOndw5 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 10 Jan 2018 23:20:14 +0100
Received: from MIPSMAIL01.mipstec.com (mailrelay.mips.com [12.201.5.28]) by mx1412.ess.rzc.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NO); Wed, 10 Jan 2018 22:19:29 +0000
Received: from localhost (192.168.154.110) by MIPSMAIL01.mipstec.com
 (10.20.43.31) with Microsoft SMTP Server (TLS) id 14.3.361.1; Wed, 10 Jan
 2018 14:19:19 -0800
Date:   Wed, 10 Jan 2018 22:19:17 +0000
From:   James Hogan <james.hogan@mips.com>
To:     Paul Cercueil <paul@crapouillou.net>
CC:     Ralf Baechle <ralf@linux-mips.org>,
        Maarten ter Huurne <maarten@treewalker.org>,
        Paul Burton <paul.burton@mips.com>,
        <linux-kernel@vger.kernel.org>, <linux-mips@linux-mips.org>
Subject: Re: [PATCH v6 09/15] MIPS: platform: add machtype IDs for more
 Ingenic SoCs
Message-ID: <20180110221916.GT27409@jhogan-linux.mipstec.com>
References: <20180102150848.11314-1-paul@crapouillou.net>
 <20180105182513.16248-1-paul@crapouillou.net>
 <20180105182513.16248-10-paul@crapouillou.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="7UIJfHqpdi+oBJdT"
Content-Disposition: inline
In-Reply-To: <20180105182513.16248-10-paul@crapouillou.net>
User-Agent: Mutt/1.7.2 (2016-11-26)
X-Originating-IP: [192.168.154.110]
X-BESS-ID: 1515622768-452060-11657-230-1
X-BESS-VER: 2017.17.1-r1801090054
X-BESS-Apparent-Source-IP: 12.201.5.28
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.188855
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
X-archive-position: 62054
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

--7UIJfHqpdi+oBJdT
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 05, 2018 at 07:25:07PM +0100, Paul Cercueil wrote:
> Add a machtype ID for the JZ4780 SoC, which was missing, and one for the
> newly supported JZ4770 SoC.
>=20
> Signed-off-by: Paul Cercueil <paul@crapouillou.net>
> Reviewed-by: PrasannaKumar Muralidharan <prasannatsmkumar@gmail.com>

Reviewed-by: James Hogan <jhogan@kernel.org>

Though perhaps its time for an enum.

Cheers
James

> ---
>  arch/mips/include/asm/bootinfo.h | 2 ++
>  1 file changed, 2 insertions(+)
>=20
>  v2: No change
>  v3: No change
>  v4: No change
>  v5: No change
>  v6: No change
>=20
> diff --git a/arch/mips/include/asm/bootinfo.h b/arch/mips/include/asm/boo=
tinfo.h
> index e26a093bb17a..a301a8f4bc66 100644
> --- a/arch/mips/include/asm/bootinfo.h
> +++ b/arch/mips/include/asm/bootinfo.h
> @@ -79,6 +79,8 @@ enum loongson_machine_type {
>   */
>  #define  MACH_INGENIC_JZ4730	0	/* JZ4730 SOC		*/
>  #define  MACH_INGENIC_JZ4740	1	/* JZ4740 SOC		*/
> +#define  MACH_INGENIC_JZ4770	2	/* JZ4770 SOC		*/
> +#define  MACH_INGENIC_JZ4780	3	/* JZ4780 SOC		*/
> =20
>  extern char *system_type;
>  const char *get_system_type(void);
> --=20
> 2.11.0
>=20
>=20

--7UIJfHqpdi+oBJdT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEd80NauSabkiESfLYbAtpk944dnoFAlpWkWQACgkQbAtpk944
dnp3xA/+PZn+7YzMkxZFonP5RKr80qfh6iHIwJlr3hXM9UVN26nihxTMM3uDj07a
CN6dLh8myCEzXqSFC106RWXwfsH3zwQHyrplm/1twiNH4bfGIikJmA2MYAp6dNLr
fjttmVuKuu6EkEbqqs9jE1D6uBE8btG/KDpBWXwPz1ZFhBQG7nCkmdVWjK8rxX/m
GnNDhpcBfdJkN4AOqWZNVagjH0wSJUE+ZDaVpuVeJKsTofXSpXWXmbJkC9Nt+thm
FQrBeGqHNIDt0RoOeLhkkgpSGjk3XlguFRRL3DkWbpW4BP7IPDxjcS6uCbzRbylC
23BlU3pCl4bQZic1JtrTza2gQWHgglK5pAZ+e1fT6sK/khVYJil1S4comTVL0VmJ
EF9P1NT8StqTmnf5CJHBx1qXsGPjFfX8XAoLRxSDEm5krira8ETMEgTH0jT1MbaQ
njPS/xWSb6O1VYgCPggSgH2AVBiMeOWBCzUpyPWYsJA4PlczvERKO/3pa0sjp/se
dF2/VvUlgiKb5EyzGWuGI+3Q//JuMwF80g7Vt9Tg2a/Emi/yzt+9GLvCwdhlLJyT
wCnkHeqXgL3i1f+vmKkJwo+dwkAN0u61Ngcoups2c37xaLs/khjavlheKqA0a05H
8FwkNf9xcqCbNATpZ3Id+UbHkSuq/aUVDWSzsJ1Pmw19tEQe5TM=
=nPuA
-----END PGP SIGNATURE-----

--7UIJfHqpdi+oBJdT--
