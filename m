Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 17 Jan 2018 22:30:01 +0100 (CET)
Received: from 9pmail.ess.barracuda.com ([64.235.154.210]:47619 "EHLO
        9pmail.ess.barracuda.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990409AbeAQV3skabVq (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 17 Jan 2018 22:29:48 +0100
Received: from MIPSMAIL01.mipstec.com (mailrelay.mips.com [12.201.5.28]) by mx1412.ess.rzc.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NO); Wed, 17 Jan 2018 21:29:13 +0000
Received: from localhost (192.168.154.110) by MIPSMAIL01.mipstec.com
 (10.20.43.31) with Microsoft SMTP Server (TLS) id 14.3.361.1; Wed, 17 Jan
 2018 13:28:56 -0800
Date:   Wed, 17 Jan 2018 21:28:54 +0000
From:   James Hogan <james.hogan@mips.com>
To:     Paul Cercueil <paul@crapouillou.net>
CC:     Ralf Baechle <ralf@linux-mips.org>,
        Maarten ter Huurne <maarten@treewalker.org>,
        <linux-kernel@vger.kernel.org>, <linux-mips@linux-mips.org>
Subject: Re: [PATCH v7 11/14] MIPS: ingenic: Initial JZ4770 support
Message-ID: <20180117212853.GC27409@jhogan-linux.mipstec.com>
References: <20180105182513.16248-2-paul@crapouillou.net>
 <20180116154804.21150-1-paul@crapouillou.net>
 <20180116154804.21150-12-paul@crapouillou.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="Re7H+V5lQR2Zv/pu"
Content-Disposition: inline
In-Reply-To: <20180116154804.21150-12-paul@crapouillou.net>
User-Agent: Mutt/1.7.2 (2016-11-26)
X-Originating-IP: [192.168.154.110]
X-BESS-ID: 1516224551-452060-3081-13852-9
X-BESS-VER: 2017.17.1-r1801152154
X-BESS-Apparent-Source-IP: 12.201.5.28
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.189085
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
X-archive-position: 62210
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

--Re7H+V5lQR2Zv/pu
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 16, 2018 at 04:48:01PM +0100, Paul Cercueil wrote:
> Provide just enough bits (clocks, clocksource, uart) to allow a kernel
> to boot on the JZ4770 SoC to a initramfs userspace.
>=20
> Signed-off-by: Paul Cercueil <paul@crapouillou.net>
> Reviewed-by: PrasannaKumar Muralidharan <prasannatsmkumar@gmail.com>


> diff --git a/arch/mips/jz4740/time.c b/arch/mips/jz4740/time.c
> index bb1ad5119da4..2ca9160f642a 100644
> --- a/arch/mips/jz4740/time.c
> +++ b/arch/mips/jz4740/time.c
> @@ -113,7 +113,7 @@ static struct clock_event_device jz4740_clockevent =
=3D {
>  #ifdef CONFIG_MACH_JZ4740
>  	.irq =3D JZ4740_IRQ_TCU0,
>  #endif
> -#ifdef CONFIG_MACH_JZ4780
> +#if defined(CONFIG_MACH_JZ4770) || defined(CONFIG_MACH_JZ4780)
>  	.irq =3D JZ4780_IRQ_TCU2,
>  #endif
>  };
> --=20
> 2.11.0
>=20

MACH_INGENIC selects SYS_SUPPORTS_ZBOOT_UART16550, so I wonder whether
arch/mips/boot/compressed/uart-16550.c needs updating for JZ4770 like
commit ba9e72c2290f ("MIPS: Fix build with DEBUG_ZBOOT and MACH_JZ4780")
does for JZ4780.

Otherwise the non-DT bits look reasonable (I've not really looked
properly at the DT):
Reviewed-by: James Hogan <jhogan@kernel.org>

Cheers
James

--Re7H+V5lQR2Zv/pu
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEd80NauSabkiESfLYbAtpk944dnoFAlpfwBUACgkQbAtpk944
dnrtoBAAg2K7uXd4aklg9Vo7PmWMQjAyhi92pU1aAQv3a8ld7l2HCKorKi0+YoxA
Ads5snHaNf4jl07yVhyWzM1AzLu2crOS1nat3FNSypX8wUtL2Y/4FNsYJq3rE3lX
0FW8boVkzKWUcyq3i/VMEkxyzs4azMhqzUgfAc4Fk1tQoa4uUsGL+QCwXE+sMQ87
E3Mv7Xf7u+L/sg5AGs/Eu/ITDboBlBlik70qUWMF/HsFYK0ZIDZyCCfwotn8i2K1
8dS1wGp05fpjlsti3zGPqfacrLkA6Bx0yekH/JiOCpuwz5VBoQSFiUZV6kWdwM74
q1RJ0AjyXg39krrYhSf5OOWT07hBGdfpaJOEjc1Uwi13jnjNHDP2o5EsLto7tHJu
zTecpIUg/LCF7xGHxJEck0nliP0GA7STYZep0IPrt0D9o1V3691G0gL2RZ8rxYEn
lzv/824u89iidziOK5CV5lOP5LtzRB9GjJmKx85qa/r4M4Gx9w5srOEFGtQ1dSF+
ZtBaawJ0tOKC1Ngl+eAdXjGcegjYieyO8LXpgi1NT+lvvpqRLf+vY1XK9b9LBXhG
/JoBIYCb9mnSLACRtFoGi37qIu8+I0rkCRdmXeavZ2bW1Zu3tvFgz9Cc45talnj5
EqKE7beELzz0yiVrQbzz2ttobKUJDvmZ2PT3h74rjtd7Puu4W18=
=A6KW
-----END PGP SIGNATURE-----

--Re7H+V5lQR2Zv/pu--
