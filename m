Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 10 Jan 2018 23:28:52 +0100 (CET)
Received: from 9pmail.ess.barracuda.com ([64.235.150.225]:56498 "EHLO
        9pmail.ess.barracuda.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990435AbeAJW2k7cDhI (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 10 Jan 2018 23:28:40 +0100
Received: from MIPSMAIL01.mipstec.com (mailrelay.mips.com [12.201.5.28]) by mx29.ess.sfj.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NO); Wed, 10 Jan 2018 22:28:18 +0000
Received: from localhost (192.168.154.110) by MIPSMAIL01.mipstec.com
 (10.20.43.31) with Microsoft SMTP Server (TLS) id 14.3.361.1; Wed, 10 Jan
 2018 14:27:15 -0800
Date:   Wed, 10 Jan 2018 22:27:13 +0000
From:   James Hogan <james.hogan@mips.com>
To:     Paul Cercueil <paul@crapouillou.net>
CC:     Ralf Baechle <ralf@linux-mips.org>,
        Maarten ter Huurne <maarten@treewalker.org>,
        Paul Burton <paul.burton@mips.com>,
        <linux-kernel@vger.kernel.org>, <linux-mips@linux-mips.org>
Subject: Re: [PATCH v6 10/15] MIPS: ingenic: Detect machtype from SoC
 compatible string
Message-ID: <20180110222712.GU27409@jhogan-linux.mipstec.com>
References: <20180102150848.11314-1-paul@crapouillou.net>
 <20180105182513.16248-1-paul@crapouillou.net>
 <20180105182513.16248-11-paul@crapouillou.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="jo46wx5DSA4a/gWG"
Content-Disposition: inline
In-Reply-To: <20180105182513.16248-11-paul@crapouillou.net>
User-Agent: Mutt/1.7.2 (2016-11-26)
X-Originating-IP: [192.168.154.110]
X-BESS-ID: 1515623296-637139-22019-845566-7
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
X-archive-position: 62055
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

--jo46wx5DSA4a/gWG
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 05, 2018 at 07:25:08PM +0100, Paul Cercueil wrote:
> Previously, the mips_machtype variable was always initialized
> to MACH_INGENIC_JZ4740 even if running on different SoCs.
>=20
> Signed-off-by: Paul Cercueil <paul@crapouillou.net>
> ---
>  arch/mips/jz4740/prom.c  |  1 -
>  arch/mips/jz4740/setup.c | 26 ++++++++++++++++++++++----
>  2 files changed, 22 insertions(+), 5 deletions(-)
>=20
>  v2: No change
>  v3: No change
>  v4: No change
>  v5: Use SPDX license identifier
>  v6: Init mips_machtype from DT compatible string instead of using
>      MIPS_MACHINE
>=20
> diff --git a/arch/mips/jz4740/prom.c b/arch/mips/jz4740/prom.c
> index a62dd8e6ecf9..eb9f2f97bedb 100644
> --- a/arch/mips/jz4740/prom.c
> +++ b/arch/mips/jz4740/prom.c
> @@ -25,7 +25,6 @@
> =20
>  void __init prom_init(void)
>  {
> -	mips_machtype =3D MACH_INGENIC_JZ4740;
>  	fw_init_cmdline();
>  }
> =20
> diff --git a/arch/mips/jz4740/setup.c b/arch/mips/jz4740/setup.c
> index 6d0152321819..cd89536fbba1 100644
> --- a/arch/mips/jz4740/setup.c
> +++ b/arch/mips/jz4740/setup.c
> @@ -53,16 +53,30 @@ static void __init jz4740_detect_mem(void)
>  	add_memory_region(0, size, BOOT_MEM_RAM);
>  }
> =20
> +static unsigned long __init get_board_mach_type(const void *fdt)
> +{
> +	if (!fdt_node_check_compatible(fdt, 0, "ingenic,jz4780"))
> +		return MACH_INGENIC_JZ4780;
> +	if (!fdt_node_check_compatible(fdt, 0, "ingenic,jz4770"))
> +		return MACH_INGENIC_JZ4770;
> +
> +	return MACH_INGENIC_JZ4740;
> +}
> +
>  void __init plat_mem_setup(void)
>  {
>  	int offset;
> =20
> +	if (!early_init_dt_scan(__dtb_start))
> +		return;
> +
>  	jz4740_reset_init();
> -	__dt_setup_arch(__dtb_start);

Is it intentional that by removing this we no longer set the machine
name, so it'll default to "unknown"? The commit message doesn't mention
that change.

Cheers
James


> =20
>  	offset =3D fdt_path_offset(__dtb_start, "/memory");
>  	if (offset < 0)
>  		jz4740_detect_mem();
> +
> +	mips_machtype =3D get_board_mach_type(__dtb_start);
>  }
> =20
>  void __init device_tree_init(void)
> @@ -75,10 +89,14 @@ void __init device_tree_init(void)
> =20
>  const char *get_system_type(void)
>  {
> -	if (IS_ENABLED(CONFIG_MACH_JZ4780))
> +	switch (mips_machtype) {
> +	case MACH_INGENIC_JZ4780:
>  		return "JZ4780";
> -
> -	return "JZ4740";
> +	case MACH_INGENIC_JZ4770:
> +		return "JZ4770";
> +	default:
> +		return "JZ4740";
> +	}
>  }
> =20
>  void __init arch_init_irq(void)
> --=20
> 2.11.0
>=20
>=20

--jo46wx5DSA4a/gWG
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEd80NauSabkiESfLYbAtpk944dnoFAlpWk0AACgkQbAtpk944
dnqERw//VO0Qa35HT8h0YLuQCWC+0Up65KdiIl+nfUlZvU38j73+qE/MCHSwwMnA
p+5FxKIzGYVSMOKxmOMHoH0XPSQMY1akoH/Ixr1BvvC6x3wJ03OOd16Stz+3df0v
b3f5xtQxpCUT6mcRZbr0QtvCkmHBOGGMK1AsZ46zEMgPKzHjrvHk+SHLEQXtpj80
Ia3xUHKz2azhdDzdL/kYP/dT33sMPsyl23ZRqjsTdVhE1jxS9tvoe3oL37Czfy2y
LDPVhqUjLyUsaCsnrQRlp+ABv4ACPSOa6Z+0a6FgDCGeKR1O8QIDtbORhIi3Ss88
zSZlIK9lt0+pJH0csk0Z/sx2iGX12wJLGCxfCoNkNmtcYxxVRAADi19Lutpzv5Ze
YPkfLK7XQMbrCeoncZsvxJlFyxGsdO5SIC4RNXYJc/fytLBfiHBQDLhmS3Wryi5O
J4XyZlnF3waUO7sGMYFWKzDVT7x+EWb00B6Am6TmKFsYSqu8r6YHHgVtXUNx/nPR
gBcTYE1aWvltI+vVBKhX5iNgjtzJfWZlyfe5a3eYhdRXIwW4o0E2iWxzqdlhiFZK
rbRdaMeA5yKwqF5gS+2dyON1t8Q1EYx9xokFzOwNZQ1FgpbtkM5PS72XvsdFPAbF
Ls7PqXsSavbvOwhQ7UuYH9LvO1SoZReOLrr1focJL8nqi8xRXMI=
=69oj
-----END PGP SIGNATURE-----

--jo46wx5DSA4a/gWG--
