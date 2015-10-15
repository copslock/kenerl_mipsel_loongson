Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 15 Oct 2015 10:34:18 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:2463 "EHLO
        imgpgp01.kl.imgtec.org" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S27007991AbbJOIeOveT0s (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 15 Oct 2015 10:34:14 +0200
Received: from imgpgp01.kl.imgtec.org (imgpgp01.kl.imgtec.org [127.0.0.1])
        by imgpgp01.kl.imgtec.org (PGP Universal) with ESMTP id 7182041F8D8A;
        Thu, 15 Oct 2015 09:34:09 +0100 (BST)
Received: from mailapp01.imgtec.com ([10.100.180.242])
  by imgpgp01.kl.imgtec.org (PGP Universal service);
  Thu, 15 Oct 2015 09:34:09 +0100
X-PGP-Universal: processed;
        by imgpgp01.kl.imgtec.org on Thu, 15 Oct 2015 09:34:09 +0100
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 9EDE5FBEE82C9;
        Thu, 15 Oct 2015 09:34:07 +0100 (IST)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Thu, 15 Oct 2015 09:34:09 +0100
Received: from localhost (192.168.154.110) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.210.2; Thu, 15 Oct
 2015 09:34:08 +0100
Date:   Thu, 15 Oct 2015 09:34:08 +0100
From:   James Hogan <james.hogan@imgtec.com>
To:     Zubair Lutfullah Kakakhel <Zubair.Kakakhel@imgtec.com>
CC:     <ralf@linux-mips.org>, <robh+dt@kernel.org>,
        <linus.walleij@linaro.org>, <linux-mips@linux-mips.org>,
        <linux-gpio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 5/5] MIPS: Add xilfpga defconfig
Message-ID: <20151015083408.GF14475@jhogan-linux.le.imgtec.org>
References: <1444827117-10939-1-git-send-email-Zubair.Kakakhel@imgtec.com>
 <1444827117-10939-6-git-send-email-Zubair.Kakakhel@imgtec.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="V4b9U9vrdWczvw78"
Content-Disposition: inline
In-Reply-To: <1444827117-10939-6-git-send-email-Zubair.Kakakhel@imgtec.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Originating-IP: [192.168.154.110]
X-ESG-ENCRYPT-TAG: e4aa9c8
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 49559
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

--V4b9U9vrdWczvw78
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 14, 2015 at 01:51:57PM +0100, Zubair Lutfullah Kakakhel wrote:
> Signed-off-by: Zubair Lutfullah Kakakhel <Zubair.Kakakhel@imgtec.com>
> ---
>  arch/mips/configs/xilfpga_defconfig | 59 +++++++++++++++++++++++++++++++=
++++++
>  1 file changed, 59 insertions(+)
>  create mode 100644 arch/mips/configs/xilfpga_defconfig
>=20
> diff --git a/arch/mips/configs/xilfpga_defconfig b/arch/mips/configs/xilf=
pga_defconfig
> new file mode 100644
> index 0000000..94bb9b8
> --- /dev/null
> +++ b/arch/mips/configs/xilfpga_defconfig
> @@ -0,0 +1,59 @@
> +CONFIG_MACH_XILFPGA=3Dy
> +# CONFIG_COMPACTION is not set
> +# CONFIG_LOCALVERSION_AUTO is not set
> +# CONFIG_CROSS_MEMORY_ATTACH is not set
> +# CONFIG_USELIB is not set
> +# CONFIG_SHMEM is not set
> +# CONFIG_AIO is not set
> +# CONFIG_ADVISE_SYSCALLS is not set

Did you disable these intentionally? Its a kernel tinification option
that is rarely used in defconfigs.

> +CONFIG_EMBEDDED=3Dy
> +# CONFIG_VM_EVENT_COUNTERS is not set
> +# CONFIG_COMPAT_BRK is not set
> +CONFIG_SLAB=3Dy
> +# CONFIG_BLOCK is not set
> +# CONFIG_SUSPEND is not set
> +# CONFIG_UEVENT_HELPER is not set
> +CONFIG_DEVTMPFS=3Dy
> +CONFIG_DEVTMPFS_MOUNT=3Dy
> +# CONFIG_STANDALONE is not set
> +# CONFIG_PREVENT_FIRMWARE_BUILD is not set
> +# CONFIG_FW_LOADER is not set
> +# CONFIG_ALLOW_DEV_COREDUMP is not set
> +# CONFIG_INPUT_MOUSEDEV is not set
> +# CONFIG_INPUT_KEYBOARD is not set
> +# CONFIG_INPUT_MOUSE is not set
> +# CONFIG_SERIO is not set
> +CONFIG_VT_HW_CONSOLE_BINDING=3Dy
> +# CONFIG_UNIX98_PTYS is not set
> +# CONFIG_LEGACY_PTYS is not set
> +# CONFIG_SERIAL_8250_DEPRECATED_OPTIONS is not set
> +CONFIG_SERIAL_8250_NR_UARTS=3D1
> +CONFIG_SERIAL_8250_RUNTIME_UARTS=3D1
> +CONFIG_SERIAL_OF_PLATFORM=3Dy
> +# CONFIG_HW_RANDOM is not set
> +CONFIG_GPIO_SYSFS=3Dy
> +CONFIG_GPIO_XILINX=3Dy
> +# CONFIG_HWMON is not set
> +# CONFIG_USB_SUPPORT is not set
> +# CONFIG_MIPS_PLATFORM_DEVICES is not set
> +# CONFIG_IOMMU_SUPPORT is not set
> +# CONFIG_FILE_LOCKING is not set

Likewise, intentional? Its another tinification option that isn't all
that commonly used in defconfigs.

> +# CONFIG_DNOTIFY is not set
> +# CONFIG_INOTIFY_USER is not set

Likewise, intentional? I don't think inotify is deprecated in favour of
anything else yet (it appears to superscede dnotify).

> +# CONFIG_PROC_SYSCTL is not set

Likewise.

> +# CONFIG_PROC_PAGE_MONITOR is not set
> +# CONFIG_MISC_FILESYSTEMS is not set
> +# CONFIG_ENABLE_WARN_DEPRECATED is not set
> +# CONFIG_ENABLE_MUST_CHECK is not set

Particular reason to disable these two compile time warnings?

> +CONFIG_PANIC_ON_OOPS=3Dy
> +# CONFIG_SCHED_DEBUG is not set
> +CONFIG_DEBUG_LOCK_ALLOC=3Dy

Did you mean to leave this turned on?

> +# CONFIG_FTRACE is not set
> +CONFIG_CMDLINE_BOOL=3Dy
> +CONFIG_CMDLINE=3D"console=3DttyS0,115200 clk_ignore_unused earlyprintk=
=3Dserial,ttyS0,115200"

I believe you can specify an earlyprintk address on command line. Would
it be preferable to do that rather than hard coding the address in the
platform code?

Cheers
James

> +CONFIG_CRYPTO_MD5=3Dy
> +CONFIG_CRYPTO_SHA1=3Dy
> +CONFIG_CRYPTO_DES=3Dy
> +CONFIG_CRYPTO_DEFLATE=3Dy
> +CONFIG_CRC16=3Dy
> +CONFIG_LIBCRC32C=3Dy
> --=20
> 1.9.1
>=20
>=20

--V4b9U9vrdWczvw78
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJWH2UAAAoJEGwLaZPeOHZ6Mm8QALPdiC3bMvt/ayU2HdP6gFD+
FGPxAgFpsP/4G/qxapJiidSiIIOL/yl4P8M+zUV3Wixnk7RQeldc1WKhOhgzAZ5P
MCttTeZlLjGP1Wk0lJnqG6+I1R39SvGJpNgNuYCRHOSH/uOkY8IsW/UXBj6sE8FJ
07XzpjhxnXD+ZrdL43FN/3Vg68zL2Bh6q60KNb7QbTz9QaLfbfDWtzEz6ZDKX6H4
LiirUZTYRgG29BkmpChxBhTJgRt36SORpHVJo3YFOpNkXsRcde0EEMACnanRGdnE
77OxDniflmlHhxTJwpYd2P+lfWK/BDEzXUoM3dF7oFi8y6EWpHyD67VeZ8C+qbzZ
HR+DdKDt9g12O78B2uF+YOSUEalb7SbLYFlqBabrqS0MWuNpm9gS1OEQid9fYYJT
PF3zlXcmZzlAwnfudoEyDNbgh7tTMdpRTTt/hIL2Wj6+aK6sLfG73cKfBzbclZVG
Wt/HLOoAHpD78XHtPU8yoq58dxAO1T2NhPZSQKIJ5rpWUz9vbrAhdZafvtjZITyc
4N92UFsGHoUgVkCC4xPfbZWq7pM83RUykqwkgu8Fb3O4DMLKAeJr6/VpVdLURFrw
nGl1mApxoAocmjXlIfW2GhhtZexp/1fyr1IvaBo0pew/nagXIM0g3hNuBHfTvbpY
jp5Nv5P3gX7J/+SlUkCx
=nZH4
-----END PGP SIGNATURE-----

--V4b9U9vrdWczvw78--
