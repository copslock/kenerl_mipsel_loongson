Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 17 Jan 2018 21:55:39 +0100 (CET)
Received: from 9pmail.ess.barracuda.com ([64.235.150.224]:48149 "EHLO
        9pmail.ess.barracuda.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990409AbeAQUzbyTRaE (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 17 Jan 2018 21:55:31 +0100
Received: from MIPSMAIL01.mipstec.com (mailrelay.mips.com [12.201.5.28]) by mx28.ess.sfj.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NO); Wed, 17 Jan 2018 20:55:08 +0000
Received: from localhost (192.168.154.110) by MIPSMAIL01.mipstec.com
 (10.20.43.31) with Microsoft SMTP Server (TLS) id 14.3.361.1; Wed, 17 Jan
 2018 12:54:02 -0800
Date:   Wed, 17 Jan 2018 20:54:00 +0000
From:   James Hogan <james.hogan@mips.com>
To:     Mathieu Malaterre <malat@debian.org>
CC:     Marcin Nowakowski <marcin.nowakowski@mips.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <Zubair.Kakakhel@mips.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        "Mark Rutland" <mark.rutland@arm.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        PrasannaKumar Muralidharan <prasannatsmkumar@gmail.com>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-mips@linux-mips.org>
Subject: Re: [PATCH v2 2/2] dts: Probe efuse for CI20
Message-ID: <20180117205359.GA27409@jhogan-linux.mipstec.com>
References: <20171228212954.2922-1-malat@debian.org>
 <20171228212954.2922-3-malat@debian.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ONmcTkPhtkbQYSLg"
Content-Disposition: inline
In-Reply-To: <20171228212954.2922-3-malat@debian.org>
User-Agent: Mutt/1.7.2 (2016-11-26)
X-Originating-IP: [192.168.154.110]
X-BESS-ID: 1516222505-637138-9131-9876-15
X-BESS-VER: 2017.17-r1801171719
X-BESS-Apparent-Source-IP: 12.201.5.28
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.189084
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
X-archive-position: 62208
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

--ONmcTkPhtkbQYSLg
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 28, 2017 at 10:29:53PM +0100, Mathieu Malaterre wrote:
> MIPS Creator CI20 comes with JZ4780 SoC. Provides access to the efuse blo=
ck
> using jz4780 efuse driver.
>=20
> Signed-off-by: Mathieu Malaterre <malat@debian.org>
> ---
>  arch/mips/configs/ci20_defconfig | 2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/arch/mips/configs/ci20_defconfig b/arch/mips/configs/ci20_de=
fconfig
> index b5f4ad8f2c45..62c63617e97a 100644
> --- a/arch/mips/configs/ci20_defconfig
> +++ b/arch/mips/configs/ci20_defconfig
> @@ -171,3 +171,5 @@ CONFIG_STACKTRACE=3Dy
>  # CONFIG_FTRACE is not set
>  CONFIG_CMDLINE_BOOL=3Dy
>  CONFIG_CMDLINE=3D"earlycon console=3DttyS4,115200 clk_ignore_unused"
> +CONFIG_NVMEM=3Dy
> +CONFIG_JZ4780_EFUSE=3Dy

NVMEM is already implied by RTC_CLASS (which turns on RTC_NVMEM by
default).

I would suggest loading the defconfig:
make ARCH=3Dmips ci20_defconfig

Then enabling the extra configuration options you need, then create a
new minimal defconfig:
make ARCH=3Dmips savedefconfig

Then look at the new file called "defconfig" or copy it over
arch/mips/configs/ci20_defconfig, and see what changes it adds. That way
you'll get the minimum you need and in the right order in the defconfig.

Don't feel like you have to submit other random changes due to config
changes since the defconfig was added, but if you do please do it as a
separate patch to bring the defconfig up to date (i.e. just load
defconfig and save it) before the patch which actually enables the
EFUSE.

Cheers
James

> --=20
> 2.11.0
>=20
>=20

--ONmcTkPhtkbQYSLg
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEd80NauSabkiESfLYbAtpk944dnoFAlpft+cACgkQbAtpk944
dnrk3hAApfLDG//NIiWtvtmyTvMW0EFfxCpWDTA+zdGgPhLlM+qC58BhuBt+opqq
iuGc4fxu8X4HgHyNhNlxj5A9Y+6fEPVfBHzaSVj5Bgxs/pl9SKhdT1+IZOJ3GJZ/
F2zG7OvO0IePC+4ssYQmyOvWsJwQWT50ZtHf3xrPIgnzwj6NCNRtTLZ2cfuOmszY
dwKhfNILgX2Z3pgX2KbAo1/C5nG6vAmRA8lDCw/BhOILsbcvjDGArXMAtC9aGC9T
zRykc1ABefERM7hSNZrbsAK1CZclmb2KaD8wdLjvk5Fgbl7T9X1X1gsyO9PDtL3f
FNMao9SWEpS05ur69tsL+ARjv0XU5s+ma1a2IOqGo8JrQZBjiqzpOnt6tJHoD/eu
UqOns4infil4g7OfawZ+8yYw6rutmDo6xUgYe0gaRhcu8LyZMxtjVXisGQHj74w8
Jt35NVuFzJD4E8friIwKFaU0QB5OJEhXdxkGLy725ZZjq1WdxFMhymBupnO6hU3K
8f358WvR0KyjXkYs5XZFQJPcwglv8hcjpYQVv3glIkTFkDhuRy8Svrq9LcxHZd4w
eV3f52R45yJ5iOfb/1BOCVcy12ZhL8qkh9ud6d932zhqkQ4LOL8+2cE+615MWQb8
R2uJfeb9hebqH69kAHbbvyKRoGxII5IHaZJGOdxrdm+qm/vl3As=
=XoTT
-----END PGP SIGNATURE-----

--ONmcTkPhtkbQYSLg--
