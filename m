Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 02 Jan 2018 09:48:32 +0100 (CET)
Received: from 9pmail.ess.barracuda.com ([64.235.150.224]:59703 "EHLO
        9pmail.ess.barracuda.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990475AbeABIsY4jTOx (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 2 Jan 2018 09:48:24 +0100
Received: from MIPSMAIL01.mipstec.com (mailrelay.mips.com [12.201.5.28]) by mx30.ess.sfj.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NO); Tue, 02 Jan 2018 08:48:02 +0000
Received: from localhost (192.168.154.110) by MIPSMAIL01.mipstec.com
 (10.20.43.31) with Microsoft SMTP Server (TLS) id 14.3.361.1; Tue, 2 Jan 2018
 00:48:01 -0800
Date:   Tue, 2 Jan 2018 08:48:00 +0000
From:   James Hogan <james.hogan@mips.com>
To:     Jiaxun Yang <jiaxun.yang@flygoat.com>
CC:     Ralf Baechle <ralf@linux-mips.org>,
        Huacai CHen <chenhc@lemote.com>, <linux-mips@linux-mips.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] MIPS: Loongson64: Drop 32-bit support for Loongson 2E/2F
 devices
Message-ID: <20180102084759.GL5027@jhogan-linux.mipstec.com>
References: <20171226042138.13227-1-jiaxun.yang@flygoat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="qpqR4wE1CEr+Roqx"
Content-Disposition: inline
In-Reply-To: <20171226042138.13227-1-jiaxun.yang@flygoat.com>
User-Agent: Mutt/1.7.2 (2016-11-26)
X-Originating-IP: [192.168.154.110]
X-BESS-ID: 1514882882-637140-17979-382223-1
X-BESS-VER: 2017.16-r1712230000
X-BESS-Apparent-Source-IP: 12.201.5.28
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.188374
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
X-archive-position: 61813
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

--qpqR4wE1CEr+Roqx
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 26, 2017 at 12:21:38PM +0800, Jiaxun Yang wrote:
> Make loongson64 a pure 64-bit mach.

Please expand to provide some rationale behind the change. Was 32-bit
support broken at runtime, or broken at build time, or are we simply no
longer interested in supporting it?

Cheers
James

>=20
> Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
> ---
>  arch/mips/loongson64/Kconfig | 2 --
>  1 file changed, 2 deletions(-)
>=20
> diff --git a/arch/mips/loongson64/Kconfig b/arch/mips/loongson64/Kconfig
> index 0d249fc3cfe9..a7d9a9241ac4 100644
> --- a/arch/mips/loongson64/Kconfig
> +++ b/arch/mips/loongson64/Kconfig
> @@ -17,7 +17,6 @@ config LEMOTE_FULOONG2E
>  	select I8259
>  	select ISA
>  	select IRQ_MIPS_CPU
> -	select SYS_SUPPORTS_32BIT_KERNEL
>  	select SYS_SUPPORTS_64BIT_KERNEL
>  	select SYS_SUPPORTS_LITTLE_ENDIAN
>  	select SYS_SUPPORTS_HIGHMEM
> @@ -49,7 +48,6 @@ config LEMOTE_MACH2F
>  	select ISA
>  	select SYS_HAS_CPU_LOONGSON2F
>  	select SYS_HAS_EARLY_PRINTK
> -	select SYS_SUPPORTS_32BIT_KERNEL
>  	select SYS_SUPPORTS_64BIT_KERNEL
>  	select SYS_SUPPORTS_HIGHMEM
>  	select SYS_SUPPORTS_LITTLE_ENDIAN
> --=20
> 2.15.1
>=20

--qpqR4wE1CEr+Roqx
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEd80NauSabkiESfLYbAtpk944dnoFAlpLRz8ACgkQbAtpk944
dnqjig/+JxblzZ2hMk1sXm5Hw01j2UIugN2CVoJYPOn5iAg0p+U5eZddjHaSksgi
/dk0mXqeSYxRnaMjwy05CMjNX2mghEZLKVDdZ4YTDhmdQfDBvOuwoVsaUEtByC1c
X4T1y+47Pg42Okp1OYQ92aCO1tqcJUxXF5zHMldaozJpoYG5Cx5i17QMwu2JEM8W
Tb1AVKL9dnOxlL7x7woNrWYRVZaqwTcD2Doq6oxJAajQbEpr2mXfd0DQo+bBg4ya
q1aOo73Tpyuzp25p3l0zv9bcvCYs/MI4YBb7ja4C/7CvabK47kJm8oCZWZbUdkDZ
c+4ueVniOXG6lPiwiXdbMEM6Ne6/MbfNNYRTqGaB7EVZ55Aj9isq6Zr2Mr9YaOWb
kS8ArZBEshD1MMnwBzAzFbXcvek4gGg6gV77MDrqdXnR/pt86U/oEhdv09SJFxBK
h31wP7+XsRJgIM+HQFyO3rl6tfBa70aZs8yI310of4N2MTnx8ST6aqAFTgTyuG3A
QWA1Oet0Jo+JnqO3IOcxfSQwJVlrnpWuGuSjqxW7lr3lVd7VBOMSNCQEWiBRw96c
HfFXaxca9UwV2Tzy43D2qZc5cVn3Se8o4iTAmFDX0iE406KoSo4fsLSbLSXwJ6vG
fZibMswSi/gW9Z8JCOd9jw05P3PYXLTt9A99FYMwyxhHHqSxPAM=
=PIu1
-----END PGP SIGNATURE-----

--qpqR4wE1CEr+Roqx--
