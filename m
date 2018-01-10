Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 10 Jan 2018 23:54:07 +0100 (CET)
Received: from 9pmail.ess.barracuda.com ([64.235.154.210]:39027 "EHLO
        9pmail.ess.barracuda.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990435AbeAJWx7dGJSI (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 10 Jan 2018 23:53:59 +0100
Received: from MIPSMAIL01.mipstec.com (mailrelay.mips.com [12.201.5.28]) by mx1412.ess.rzc.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NO); Wed, 10 Jan 2018 22:53:33 +0000
Received: from localhost (192.168.154.110) by MIPSMAIL01.mipstec.com
 (10.20.43.31) with Microsoft SMTP Server (TLS) id 14.3.361.1; Wed, 10 Jan
 2018 14:52:18 -0800
Date:   Wed, 10 Jan 2018 22:52:16 +0000
From:   James Hogan <james.hogan@mips.com>
To:     Paul Cercueil <paul@crapouillou.net>
CC:     Ralf Baechle <ralf@linux-mips.org>,
        Maarten ter Huurne <maarten@treewalker.org>,
        Paul Burton <paul.burton@mips.com>,
        <linux-kernel@vger.kernel.org>, <linux-mips@linux-mips.org>
Subject: Re: [PATCH v6 12/15] MIPS: JZ4770: Work around config2 misreporting
 associativity
Message-ID: <20180110225216.GW27409@jhogan-linux.mipstec.com>
References: <20180102150848.11314-1-paul@crapouillou.net>
 <20180105182513.16248-1-paul@crapouillou.net>
 <20180105182513.16248-13-paul@crapouillou.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="L2YZAWjVjAQ1Un1Q"
Content-Disposition: inline
In-Reply-To: <20180105182513.16248-13-paul@crapouillou.net>
User-Agent: Mutt/1.7.2 (2016-11-26)
X-Originating-IP: [192.168.154.110]
X-BESS-ID: 1515624813-452060-11653-2933-2
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
X-archive-position: 62057
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

--L2YZAWjVjAQ1Un1Q
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 05, 2018 at 07:25:10PM +0100, Paul Cercueil wrote:
> From: Maarten ter Huurne <maarten@treewalker.org>
>=20
> According to config2, the associativity would be 5-ways, but the
> documentation states 4-ways, which also matches the documented
> L2 cache size of 256 kB.
>=20
> Signed-off-by: Maarten ter Huurne <maarten@treewalker.org>

Hehe, nice

Reviewed-by: James Hogan <jhogan@kernel.org>

Cheers
James

> ---
>  arch/mips/mm/sc-mips.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
>=20
>  v2: No change
>  v3: No change
>  v4: Rebased on top of Linux 4.15-rc5
>  v5: No change
>  v6: No change
>=20
> diff --git a/arch/mips/mm/sc-mips.c b/arch/mips/mm/sc-mips.c
> index 548acb7f8557..394673991bab 100644
> --- a/arch/mips/mm/sc-mips.c
> +++ b/arch/mips/mm/sc-mips.c
> @@ -16,6 +16,7 @@
>  #include <asm/mmu_context.h>
>  #include <asm/r4kcache.h>
>  #include <asm/mips-cps.h>
> +#include <asm/bootinfo.h>
> =20
>  /*
>   * MIPS32/MIPS64 L2 cache handling
> @@ -220,6 +221,14 @@ static inline int __init mips_sc_probe(void)
>  	else
>  		return 0;
> =20
> +	/*
> +	 * According to config2 it would be 5-ways, but that is contradicted
> +	 * by all documentation.
> +	 */
> +	if (current_cpu_type() =3D=3D CPU_JZRISC &&
> +				mips_machtype =3D=3D MACH_INGENIC_JZ4770)
> +		c->scache.ways =3D 4;
> +
>  	c->scache.waysize =3D c->scache.sets * c->scache.linesz;
>  	c->scache.waybit =3D __ffs(c->scache.waysize);
> =20
> --=20
> 2.11.0
>=20
>=20

--L2YZAWjVjAQ1Un1Q
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEd80NauSabkiESfLYbAtpk944dnoFAlpWmR8ACgkQbAtpk944
dnrQvBAAkiKXnbeOftpLJH50gKZ5TlPHF62MecUHzmckJaMKkDnjI2tU3ZaggLFF
dFu+JXvxauIcYULDBRFmB+jyOiNF9uYY7p/H8hironJcZvWLeFKDiUcqdZe0KQxq
8U14dRsLeJZqAkBwR8shLHEtEImPkqiiA4TSA4k2kTdn/zsxShHTUhzlTKLg7ikJ
xDVKZyZZQNORAao7Hhl2UJmpFDEQuavVyVo6q/N5bwolK58/QQQMLqtEm7YAHfmU
OxIzmLCT4VsW48KzoDR4iANw9I0OMd5xWC3zh+9ltMhF2afVfEFAPe+AW0Ji3X2+
r8CWfZCGIw7unWFd2xpbSj4BeVQ1fy35ufAKr1NreEBUCqU2/VpF/aPUnMdhakMx
vm29eVHXMwuUjl2uUos6+0Z5H3ihYoADIaJKIab4MhXN3pmHoWhrM7VlVXF1AZtE
SxSsha6Jrjpgd0uu4wV638ESdUc5ri18KoZxvQ+A7pp/Dl+rfWQQwtyKGs7LCUjc
+VzhBB5smbg8kFqTpNmKLYvRdKvKeG1rEapJC/NRKmCFsoPRXvJLOsE5xvVouQXa
8ysiRcxmON+deLU+9b7/anqCTatvfmClU2Uca8VywUUcAVctqYoyrg13wp9+Gea0
vCFVgVEH8dFYcCGx/Hl/H+vCEqcj9bOUqhsEaperTq1PUqEyWSU=
=zhzb
-----END PGP SIGNATURE-----

--L2YZAWjVjAQ1Un1Q--
