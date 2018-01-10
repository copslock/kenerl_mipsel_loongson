Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 10 Jan 2018 23:17:23 +0100 (CET)
Received: from 9pmail.ess.barracuda.com ([64.235.150.225]:36023 "EHLO
        9pmail.ess.barracuda.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990435AbeAJWROhvkY5 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 10 Jan 2018 23:17:14 +0100
Received: from MIPSMAIL01.mipstec.com (mailrelay.mips.com [12.201.5.28]) by mx27.ess.sfj.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NO); Wed, 10 Jan 2018 22:16:49 +0000
Received: from localhost (192.168.154.110) by MIPSMAIL01.mipstec.com
 (10.20.43.31) with Microsoft SMTP Server (TLS) id 14.3.361.1; Wed, 10 Jan
 2018 14:16:35 -0800
Date:   Wed, 10 Jan 2018 22:16:33 +0000
From:   James Hogan <james.hogan@mips.com>
To:     Paul Cercueil <paul@crapouillou.net>
CC:     Ralf Baechle <ralf@linux-mips.org>,
        Maarten ter Huurne <maarten@treewalker.org>,
        Paul Burton <paul.burton@mips.com>,
        <linux-kernel@vger.kernel.org>, <linux-mips@linux-mips.org>
Subject: Re: [PATCH v6 08/15] MIPS: ingenic: Use common cmdline handling code
Message-ID: <20180110221633.GS27409@jhogan-linux.mipstec.com>
References: <20180102150848.11314-1-paul@crapouillou.net>
 <20180105182513.16248-1-paul@crapouillou.net>
 <20180105182513.16248-9-paul@crapouillou.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="cnBsrynPgIOyCJkL"
Content-Disposition: inline
In-Reply-To: <20180105182513.16248-9-paul@crapouillou.net>
User-Agent: Mutt/1.7.2 (2016-11-26)
X-Originating-IP: [192.168.154.110]
X-BESS-ID: 1515622607-637137-12097-847446-10
X-BESS-VER: 2017.16-r1712230000
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
X-archive-position: 62053
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

--cnBsrynPgIOyCJkL
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 05, 2018 at 07:25:06PM +0100, Paul Cercueil wrote:
> From: Paul Burton <paul.burton@mips.com>
>=20
> jz4740_init_cmdline appends all arguments from argv (in fw_arg1) to
> arcs_cmdline, up to argc (in fw_arg0). The common code in
> fw_init_cmdline will do the exact same thing when run on a system where
> fw_arg0 isn't a pointer to kseg0 (it'll also set _fw_envp but we don't
> use it). Remove the custom implementation & use the generic code.
>=20
> Signed-off-by: Paul Burton <paul.burton@mips.com>
> Reviewed-by: PrasannaKumar Muralidharan <prasannatsmkumar@gmail.com>

Reviewed-by: James Hogan <jhogan@kernel.org>

Cheers
James

> ---
>  arch/mips/jz4740/prom.c | 24 ++----------------------
>  1 file changed, 2 insertions(+), 22 deletions(-)
>=20
>  v2: No change
>  v3: No change
>  v4: No change
>  v5: No change
>  v6: Update Paul Burton's email address
>=20
> diff --git a/arch/mips/jz4740/prom.c b/arch/mips/jz4740/prom.c
> index 47e857194ce6..a62dd8e6ecf9 100644
> --- a/arch/mips/jz4740/prom.c
> +++ b/arch/mips/jz4740/prom.c
> @@ -20,33 +20,13 @@
>  #include <linux/serial_reg.h>
> =20
>  #include <asm/bootinfo.h>
> +#include <asm/fw/fw.h>
>  #include <asm/mach-jz4740/base.h>
> =20
> -static __init void jz4740_init_cmdline(int argc, char *argv[])
> -{
> -	unsigned int count =3D COMMAND_LINE_SIZE - 1;
> -	int i;
> -	char *dst =3D &(arcs_cmdline[0]);
> -	char *src;
> -
> -	for (i =3D 1; i < argc && count; ++i) {
> -		src =3D argv[i];
> -		while (*src && count) {
> -			*dst++ =3D *src++;
> -			--count;
> -		}
> -		*dst++ =3D ' ';
> -	}
> -	if (i > 1)
> -		--dst;
> -
> -	*dst =3D 0;
> -}
> -
>  void __init prom_init(void)
>  {
> -	jz4740_init_cmdline((int)fw_arg0, (char **)fw_arg1);
>  	mips_machtype =3D MACH_INGENIC_JZ4740;
> +	fw_init_cmdline();
>  }
> =20
>  void __init prom_free_prom_memory(void)
> --=20
> 2.11.0
>=20
>=20

--cnBsrynPgIOyCJkL
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEd80NauSabkiESfLYbAtpk944dnoFAlpWkMAACgkQbAtpk944
dnovjw//aqQyFuVZEmUvUWQH1U20UtKS1cAWk+s6e/b1BUwxQRBicvdWhvgWVZu4
QhwuT1aS+08qzBcKvmoBXaFkiIEUW6kzL83082qLomFVwV2NR6MDzUavvkq7l4FF
5oeK5smzBH7py3Ac1ahHHy1M0afOG/GaTjgNgeiXiwmdM2GdQdEKgk/SsfgjB0U3
SMF903ZAglz6OKmI8HYKMsQ/Pk5N6hvIo0wtCsMTxV40mn+Cy0gDAyp4bo/zwEgw
vrsyVynCTvxmujU1CUjaUhgbBUXRYmPiuEhLoGzSxMdNxawN3+23LrKWUvQIqKC9
5Y12jL7TSL0LgcvSLl1k7gBCwGEhF10clQpAGvLWHjxrxOtjtZ/Z5EcQL4rLfI2J
uI+QaEhwcMOwfGLZsWhut2PtzzlxMdSU/PAfGtZez+7A0+egEBHRMR44q8APqDjh
RO7aH9iOnJ7gjwtcQg/Jk2wRsun+uOJeOV7I6yh3pDRM3gtxKcvT7hlg3ufOQF2T
n8TF4aJ31WOdq/uD6MIsSz0PGIMRpfYo5d7Siip3cg7iKs1QL/TFbbA88IouKNEC
DIZuyySON5N/E76RRP6solZHe7i8zriuzAQOt7DSY/IitJcRidOswamZJT55lT8Q
6/PGR4PqQfs4cVWTOcE9VzZhiG2tl1NBpLw9xv+tjkiRTQsd6pg=
=atKF
-----END PGP SIGNATURE-----

--cnBsrynPgIOyCJkL--
