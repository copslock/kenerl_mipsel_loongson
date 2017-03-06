Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 07 Mar 2017 00:04:28 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:48998 "EHLO
        imgpgp01.kl.imgtec.org" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S23993886AbdCFXETi0NOr (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 7 Mar 2017 00:04:19 +0100
Received: from imgpgp01.kl.imgtec.org (imgpgp01.kl.imgtec.org [127.0.0.1])
        by imgpgp01.kl.imgtec.org (PGP Universal) with ESMTP id B62A241F8D5F;
        Tue,  7 Mar 2017 00:09:06 +0000 (GMT)
Received: from mailapp01.imgtec.com ([10.100.180.241])
  by imgpgp01.kl.imgtec.org (PGP Universal service);
  Tue, 07 Mar 2017 00:09:06 +0000
X-PGP-Universal: processed;
        by imgpgp01.kl.imgtec.org on Tue, 07 Mar 2017 00:09:06 +0000
Received: from hhmail02.hh.imgtec.org (unknown [10.100.10.20])
        by Forcepoint Email with ESMTPS id CFE8CB9A566B4;
        Mon,  6 Mar 2017 23:04:08 +0000 (GMT)
Received: from localhost (192.168.154.110) by hhmail02.hh.imgtec.org
 (10.100.10.21) with Microsoft SMTP Server (TLS) id 14.3.294.0; Mon, 6 Mar
 2017 23:04:13 +0000
Date:   Mon, 6 Mar 2017 23:04:13 +0000
From:   James Hogan <james.hogan@imgtec.com>
To:     Nathan Sullivan <nathan.sullivan@ni.com>
CC:     <linus.walleij@linaro.org>, <gnurou@gmail.com>,
        <mark.rutland@arm.com>, <devicetree@vger.kernel.org>,
        <robh+dt@kernel.org>, <ralf@linux-mips.org>,
        <linux-kernel@vger.kernel.org>, <linux-gpio@vger.kernel.org>,
        <linux-mips@linux-mips.org>
Subject: Re: [PATCH 2/2] MIPS: NI 169445 board support
Message-ID: <20170306230413.GF2878@jhogan-linux.le.imgtec.org>
References: <1488830761-681-1-git-send-email-nathan.sullivan@ni.com>
 <1488830761-681-3-git-send-email-nathan.sullivan@ni.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="SxgehGEc6vB0cZwN"
Content-Disposition: inline
In-Reply-To: <1488830761-681-3-git-send-email-nathan.sullivan@ni.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Originating-IP: [192.168.154.110]
X-ESG-ENCRYPT-TAG: 1b7d744b
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 57059
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

--SxgehGEc6vB0cZwN
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Nathan,

On Mon, Mar 06, 2017 at 02:06:01PM -0600, Nathan Sullivan wrote:
> Support the National Instruments 169445 board.
>=20
> Signed-off-by: Nathan Sullivan <nathan.sullivan@ni.com>
> ---
>  Documentation/devicetree/bindings/mips/ni.txt   |   7 ++
>  arch/mips/boot/dts/Makefile                     |   1 +
>  arch/mips/boot/dts/ni/169445.dts                | 101 ++++++++++++++++++=
++
>  arch/mips/boot/dts/ni/Makefile                  |   7 ++
>  arch/mips/configs/generic/board-ni169445.config | 117 ++++++++++++++++++=
++++++
>  arch/mips/generic/Kconfig                       |   6 ++
>  arch/mips/generic/vmlinux.its.S                 |  25 +++++
>  7 files changed, 264 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mips/ni.txt
>  create mode 100644 arch/mips/boot/dts/ni/169445.dts
>  create mode 100644 arch/mips/boot/dts/ni/Makefile
>  create mode 100644 arch/mips/configs/generic/board-ni169445.config
>=20

nice :)

I reckon an entry in MAINTAINERS listing the board specific
files/directories would probably be worthwhile too.

> diff --git a/arch/mips/configs/generic/board-ni169445.config b/arch/mips/=
configs/generic/board-ni169445.config
> new file mode 100644
> index 0000000..2c950a8
> --- /dev/null
> +++ b/arch/mips/configs/generic/board-ni169445.config
> @@ -0,0 +1,117 @@
> +CONFIG_MIPS_GENERIC=3Dy
> +CONFIG_FIT_IMAGE_FDT_NI169445=3Dy
> +CONFIG_CPU_LITTLE_ENDIAN=3Dy
> +CONFIG_CPU_MIPS32_R2=3Dy
> +CONFIG_HZ_100=3Dy
> +CONFIG_MIPS_CMDLINE_FROM_BOOTLOADER=3Dy
> +# CONFIG_SWAP is not set
> +CONFIG_SYSVIPC=3Dy
> +CONFIG_HZ_PERIODIC=3Dy
> +CONFIG_NO_HZ=3Dy
> +CONFIG_HIGH_RES_TIMERS=3Dy
> +CONFIG_IKCONFIG=3Dy
> +CONFIG_IKCONFIG_PROC=3Dy
> +CONFIG_LOG_BUF_SHIFT=3D15
> +CONFIG_BPF_SYSCALL=3Dy
> +# CONFIG_SHMEM is not set
> +CONFIG_USERFAULTFD=3Dy
> +CONFIG_EMBEDDED=3Dy
> +# CONFIG_COMPAT_BRK is not set
> +CONFIG_SLAB=3Dy
> +CONFIG_PROFILING=3Dy
> +CONFIG_CC_STACKPROTECTOR_REGULAR=3Dy
> +# CONFIG_LBDAF is not set
> +# CONFIG_BLK_DEV_BSG is not set
> +# CONFIG_CORE_DUMP_DEFAULT_ELF_HEADERS is not set
> +# CONFIG_SUSPEND is not set
> +CONFIG_NET=3Dy
> +CONFIG_PACKET=3Dy
> +CONFIG_UNIX=3Dy
> +CONFIG_INET=3Dy
> +# CONFIG_INET_XFRM_MODE_TRANSPORT is not set
> +# CONFIG_INET_XFRM_MODE_TUNNEL is not set
> +# CONFIG_INET_XFRM_MODE_BEET is not set
> +# CONFIG_INET_DIAG is not set
> +# CONFIG_INET6_XFRM_MODE_TRANSPORT is not set
> +# CONFIG_INET6_XFRM_MODE_TUNNEL is not set
> +CONFIG_NETFILTER=3Dy
> +CONFIG_NETFILTER_XT_MATCH_MULTIPORT=3Dy
> +CONFIG_IP_NF_IPTABLES=3Dy
> +CONFIG_IP_NF_FILTER=3Dy
> +CONFIG_IP6_NF_IPTABLES=3Dy
> +CONFIG_IP6_NF_FILTER=3Dy
> +# CONFIG_WIRELESS is not set
> +CONFIG_UEVENT_HELPER_PATH=3D"/sbin/hotplug"
> +CONFIG_DEVTMPFS=3Dy
> +CONFIG_DEVTMPFS_MOUNT=3Dy
> +CONFIG_MTD=3Dy
> +CONFIG_MTD_CMDLINE_PARTS=3Dy
> +CONFIG_MTD_BLOCK_RO=3Dy
> +CONFIG_MTD_NAND=3Dy
> +CONFIG_MTD_NAND_ECC_BCH=3Dy
> +CONFIG_MTD_NAND_GPIO=3Dy
> +CONFIG_MTD_UBI=3Dy
> +CONFIG_MTD_UBI_BLOCK=3Dy
> +# CONFIG_BLK_DEV is not set
> +CONFIG_NETDEVICES=3Dy
> +# CONFIG_NET_VENDOR_ALACRITECH is not set
> +# CONFIG_NET_VENDOR_AMAZON is not set
> +# CONFIG_NET_VENDOR_AQUANTIA is not set
> +# CONFIG_NET_VENDOR_ARC is not set
> +# CONFIG_NET_CADENCE is not set
> +# CONFIG_NET_VENDOR_BROADCOM is not set
> +# CONFIG_NET_VENDOR_EZCHIP is not set
> +# CONFIG_NET_VENDOR_INTEL is not set
> +# CONFIG_NET_VENDOR_MARVELL is not set
> +# CONFIG_NET_VENDOR_MICREL is not set
> +# CONFIG_NET_VENDOR_NATSEMI is not set
> +# CONFIG_NET_VENDOR_NETRONOME is not set
> +# CONFIG_NET_VENDOR_QUALCOMM is not set
> +# CONFIG_NET_VENDOR_RENESAS is not set
> +# CONFIG_NET_VENDOR_ROCKER is not set
> +# CONFIG_NET_VENDOR_SAMSUNG is not set
> +# CONFIG_NET_VENDOR_SEEQ is not set
> +# CONFIG_NET_VENDOR_SOLARFLARE is not set
> +# CONFIG_NET_VENDOR_SMSC is not set
> +CONFIG_STMMAC_ETH=3Dy
> +CONFIG_DWMAC_DWC_QOS_ETH=3Dy
> +# CONFIG_NET_VENDOR_VIA is not set
> +# CONFIG_NET_VENDOR_WIZNET is not set
> +# CONFIG_NET_VENDOR_XILINX is not set
> +# CONFIG_WLAN is not set
> +# CONFIG_INPUT_KEYBOARD is not set
> +# CONFIG_INPUT_MOUSE is not set
> +# CONFIG_SERIO is not set
> +# CONFIG_VT is not set
> +CONFIG_LEGACY_PTY_COUNT=3D32
> +CONFIG_SERIAL_8250=3Dy
> +# CONFIG_SERIAL_8250_DEPRECATED_OPTIONS is not set
> +CONFIG_SERIAL_8250_CONSOLE=3Dy
> +CONFIG_SERIAL_8250_NR_UARTS=3D2
> +CONFIG_SERIAL_8250_RUNTIME_UARTS=3D2
> +CONFIG_SERIAL_OF_PLATFORM=3Dy
> +# CONFIG_PTP_1588_CLOCK is not set
> +CONFIG_GPIOLIB=3Dy
> +CONFIG_GPIO_SYSFS=3Dy
> +CONFIG_GPIO_GENERIC_PLATFORM=3Dy
> +# CONFIG_HWMON is not set
> +# CONFIG_HID is not set
> +# CONFIG_USB_SUPPORT is not set
> +# CONFIG_MIPS_PLATFORM_DEVICES is not set
> +# CONFIG_IOMMU_SUPPORT is not set
> +CONFIG_FANOTIFY=3Dy
> +CONFIG_UBIFS_FS=3Dy
> +CONFIG_SQUASHFS=3Dy
> +CONFIG_SQUASHFS_XATTR=3Dy
> +# CONFIG_SQUASHFS_ZLIB is not set
> +CONFIG_SQUASHFS_LZO=3Dy
> +# CONFIG_NETWORK_FILESYSTEMS is not set
> +CONFIG_PRINTK_TIME=3Dy
> +CONFIG_DEBUG_INFO=3Dy
> +CONFIG_DEBUG_INFO_REDUCED=3Dy
> +CONFIG_DEBUG_FS=3Dy
> +# CONFIG_SCHED_DEBUG is not set
> +CONFIG_RCU_TRACE=3Dy
> +# CONFIG_FTRACE is not set
> +# CONFIG_CRYPTO_ECHAINIV is not set
> +# CONFIG_CRYPTO_HW is not set

I think this file is intended to be more minimal than a normal
defconfig, only enabling hardware device drivers (and related options)
and FIT IMAGE on top of the generic_defconfig and other snippets in this
directory, e.g. have you seen the other board config examples here?

https://git.linux-mips.org/cgit/linux-mti.git/tree/arch/mips/configs/generi=
c?h=3Deng

If specific generic kernel features are desired we should probably
consider whether it makes sense to add them to the generic_defconfig so
other generic boards can benefit.

Cheers
James

--SxgehGEc6vB0cZwN
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIcBAEBCAAGBQJYvertAAoJEGwLaZPeOHZ6q6kQAK1J3jlhxSFgWg+ZTagsHc6V
RkXig+3u/0ed4c/DBGPwejNSt5GcredDMBkOJhONLDYbiliVGpjZldeJzd1RU5kw
nJhziq0Jr7KLJg+qGnMN5c57o/afcp4AkgTxAmqqS78HRRw4VrNQlWg12KwNyvdP
RbqsLfrDGhMzO6290KXHkVmNIjiSubVsn1W3ZqciwFOODpRlYdNUAt+3EwYk1YV2
SGenzN1/NcoBuEJ3zNbynVu+ABNFt1ClF1nwHE1jFF3o+0WheZ7qk+fzA2Hw9pRC
gGsas8o7rrWN03Xtwb/UlWtRvLwsXa2cgK+H1o0wPn3RVga7V2luG1maW2TiGEut
zgBOOiB3AI7TND3H3Rn9EuA2cdMdA0pd0hLDRJdirhrOP1QRAypQtSTtyeP247xx
Ezszjt2wYZ9Kk9NbIPKmytuYWBbLLyYcmRhyTVovFK+itd11hsaKYOTuAit9k6yj
pVgSjhq2driiouD4LgU1Q9bOYm1lLiKclBaVgnVlLbE+g35irA4mCGCW1YY2p2qU
cT+c8EsEWCAd85fs58sY3iy9bRmMsoHCg++KRj2v6NM4PZo9ErKc4o+lS9SzZJbq
NeEK1neVzITRomqxrpU5SWNaesrLFf8M2a0oSxveJ+Ek84KbqAFdNWKvYkekNIQz
Xz2eYIuVpdnYqvR7pBwq
=UILz
-----END PGP SIGNATURE-----

--SxgehGEc6vB0cZwN--
