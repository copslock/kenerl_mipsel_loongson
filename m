Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 15 Feb 2017 11:39:12 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:63339 "EHLO
        imgpgp01.kl.imgtec.org" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S23993877AbdBOKjE6e9yv (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 15 Feb 2017 11:39:04 +0100
Received: from imgpgp01.kl.imgtec.org (imgpgp01.kl.imgtec.org [127.0.0.1])
        by imgpgp01.kl.imgtec.org (PGP Universal) with ESMTP id 3834941F8DEB;
        Wed, 15 Feb 2017 11:42:59 +0000 (GMT)
Received: from mailapp01.imgtec.com ([10.100.180.241])
  by imgpgp01.kl.imgtec.org (PGP Universal service);
  Wed, 15 Feb 2017 11:42:59 +0000
X-PGP-Universal: processed;
        by imgpgp01.kl.imgtec.org on Wed, 15 Feb 2017 11:42:59 +0000
Received: from hhmail02.hh.imgtec.org (unknown [10.100.10.20])
        by Forcepoint Email with ESMTPS id B641B2B9E408F;
        Wed, 15 Feb 2017 10:38:56 +0000 (GMT)
Received: from localhost (192.168.154.110) by hhmail02.hh.imgtec.org
 (10.100.10.21) with Microsoft SMTP Server (TLS) id 14.3.294.0; Wed, 15 Feb
 2017 10:38:59 +0000
Date:   Wed, 15 Feb 2017 10:38:58 +0000
From:   James Hogan <james.hogan@imgtec.com>
To:     Arnd Bergmann <arnd@arndb.de>
CC:     Ralf Baechle <ralf@linux-mips.org>, <linux-mips@linux-mips.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] MIPS: ip27: disable qlge driver in defconfig
Message-ID: <20170215103858.GX24226@jhogan-linux.le.imgtec.org>
References: <20170203164409.3580513-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="UEYxRAcbr7cS1UOX"
Content-Disposition: inline
In-Reply-To: <20170203164409.3580513-1-arnd@arndb.de>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Originating-IP: [192.168.154.110]
X-ESG-ENCRYPT-TAG: 1b7d744b
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56826
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: james.hogan@imgtec.com
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

--UEYxRAcbr7cS1UOX
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 03, 2017 at 05:43:50PM +0100, Arnd Bergmann wrote:
> One of the last remaining failures in kernelci.org is for a gcc bug:
>=20
> drivers/net/ethernet/qlogic/qlge/qlge_main.c:4819:1: error: insn does not=
 satisfy its constraints:
> drivers/net/ethernet/qlogic/qlge/qlge_main.c:4819:1: internal compiler er=
ror: in extract_constrain_insn, at recog.c:2190
>=20
> This is apparently broken in gcc-6 but fixed in gcc-7, and I cannot repro=
duce the
> problem here. However, it is clear that ip27_defconfig does not actually =
need
> this driver as the platform has only PCI-X but not PCIe, and the qlge ada=
pter
> in turn is PCIe-only.
>=20
> The driver was originally enabled in 2010 along with lots of other driver=
s.
>=20
> Fixes: 59d302b342e5 ("MIPS: IP27: Make defconfig useful again.")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Applied

Thanks
James

> ---
>  arch/mips/configs/ip27_defconfig | 1 -
>  1 file changed, 1 deletion(-)
>=20
> diff --git a/arch/mips/configs/ip27_defconfig b/arch/mips/configs/ip27_de=
fconfig
> index 18f024967dcd..e582069b44fd 100644
> --- a/arch/mips/configs/ip27_defconfig
> +++ b/arch/mips/configs/ip27_defconfig
> @@ -205,7 +205,6 @@ CONFIG_MLX4_EN=3Dm
>  # CONFIG_MLX4_DEBUG is not set
>  CONFIG_TEHUTI=3Dm
>  CONFIG_BNX2X=3Dm
> -CONFIG_QLGE=3Dm
>  CONFIG_SFC=3Dm
>  CONFIG_BE2NET=3Dm
>  CONFIG_LIBERTAS_THINFIRM=3Dm
> --=20
> 2.9.0
>=20
>=20

--UEYxRAcbr7cS1UOX
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIcBAEBCAAGBQJYpC/CAAoJEGwLaZPeOHZ6KukQAI/3R5UeahNJYhNInh0LC5RU
M6IupnOTgabIbJ65p0/SVdz2ALkrJjoLiaA6ZE2bNCRphSSh2hjdZyqQN6CcwxVS
h3DvAPlaSTPvxYdCzR0ZI6EEjan4nq/BMNe0creJeUG/CkocNxYmjDYgKKnC/SjE
g4sBaSTFphiK5vrp4hdFc6fq/2JFJY4+IffCy6u+d3NVYABrEf3gqeqGwtWr9sJC
RRVplNAUtF0/4Ulup5MpdxUdtaaJ87wHuDVyDmTxFA5Ohv3yr5g1EImZ+ObWgQ+g
ck5l9PqKFgIPkBRSSrn8sSHbdh7jkDEQ9g7v5cPrcLhCFLdyedZKgfohizrZj2OD
99rsyNQAXCvyIm+jjlKngvp820XyWOYcf9HnmKKfQaR1aL03dbR0p1nhEh+FVTT0
8C8Jch0b7mGlpvO70LKG5tOlFUixlLc8hepVGmHV2WAItm6fn2qsro+epgww8Oq9
/ZKrW/lajIpgBkrKBvgRQ7NRK6ZK6UNzJ2HA0R7HkflztbqVWkmJMIAha72fbbRA
nnSJGjgC/J7J2cUfN761P7apLS649GqsLEV1TdvnFlaY/acfUbCII396QpVrPKVb
LgYZX1b9JzIT01aeZ/HFhdUbSDfXwrGD1Uspbl9YE9kCZe5C5qPjuARhBkZ4uIIu
B8lJoy8TpdEDcQV05esL
=lWWV
-----END PGP SIGNATURE-----

--UEYxRAcbr7cS1UOX--
