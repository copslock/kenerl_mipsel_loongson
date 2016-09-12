Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 12 Sep 2016 08:59:04 +0200 (CEST)
Received: from mga11.intel.com ([192.55.52.93]:61695 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23991986AbcILG651F7Z7 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 12 Sep 2016 08:58:57 +0200
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga102.fm.intel.com with ESMTP; 11 Sep 2016 23:58:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.30,321,1470726000"; 
   d="asc'?scan'208";a="7722356"
Received: from pipin.fi.intel.com (HELO localhost) ([10.237.68.160])
  by orsmga004.jf.intel.com with ESMTP; 11 Sep 2016 23:58:48 -0700
From:   Felipe Balbi <felipe.balbi@linux.intel.com>
To:     "Steven J. Hill" <Steven.Hill@cavium.com>,
        linux-usb@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-mips@linux-mips.org,
        David Daney <david.daney@cavium.com>
Subject: Re: [PATCH v3] usb: dwc3: OCTEON: add support for device tree
In-Reply-To: <57D47313.7040109@cavium.com>
References: <57D47313.7040109@cavium.com>
User-Agent: Notmuch/0.22.1+63~g994277e (https://notmuchmail.org) Emacs/25.1.3 (x86_64-pc-linux-gnu)
Date:   Mon, 12 Sep 2016 09:58:08 +0300
Message-ID: <87twdleha7.fsf@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha256; protocol="application/pgp-signature"
Return-Path: <felipe.balbi@linux.intel.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 55099
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: felipe.balbi@linux.intel.com
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

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

"Steven J. Hill" <Steven.Hill@cavium.com> writes:

> This patch adds support to parse probe data for
> the dwc3-octeon driver using device tree. The
> DWC3 IP core is found on OCTEON III processors.
>
> Signed-off-by: Steven J. Hill <Steven.Hill@cavium.com>
>
> Changes in v3:
> - Massive simplification of glue logic. Almost all the
>   work is done in the SoC platform code.
> Changes in v2:
> - Changed comment block to acurately describe why the DMA
>   properties are being set.
> - Deleted 'dwc3_octeon_remove()' function as it serves
>   no purpose. Also changed driver from tristate to a
>   boolen as we have no plans to make it modular.
> - Changed driver dependency from CAVIUM_OCTEON_SOC to
>   CPU_CAVIUM_OCTEON || COMPILE_TEST per Balbi's request.

Thanks for updating this changelog, but next time it should come after
the tearline (---) below. We don't want this to reach git's history :-)

> ---
>  drivers/usb/dwc3/Kconfig       | 10 +++++++
>  drivers/usb/dwc3/Makefile      |  1 +
>  drivers/usb/dwc3/dwc3-octeon.c | 61 ++++++++++++++++++++++++++++++++++++=
++++++
>  3 files changed, 72 insertions(+)
>  create mode 100644 drivers/usb/dwc3/dwc3-octeon.c
>
> diff --git a/drivers/usb/dwc3/Kconfig b/drivers/usb/dwc3/Kconfig
> index a64ce1c..f2cb24b 100644
> --- a/drivers/usb/dwc3/Kconfig
> +++ b/drivers/usb/dwc3/Kconfig
> @@ -105,4 +105,14 @@ config USB_DWC3_ST
>  	  inside (i.e. STiH407).
>  	  Say 'Y' or 'M' if you have one such device.
>
> +config USB_DWC3_OCTEON
> +	bool "Cavium OCTEON III Platforms"
> +	depends on CPU_CAVIUM_OCTEON || COMPILE_TEST
> +	depends on OF
> +	default USB_DWC3
> +	help
> +	  Cavium OCTEON III SoCs with one DesignWare Core USB3 IP
> +	  inside (i.e. cn71xx and cn78xx).
> +	  Say 'Y' or 'M' if you have one such device.
> +
>  endif
> diff --git a/drivers/usb/dwc3/Makefile b/drivers/usb/dwc3/Makefile
> index 22420e1..f1a7a3e 100644
> --- a/drivers/usb/dwc3/Makefile
> +++ b/drivers/usb/dwc3/Makefile
> @@ -39,3 +39,4 @@ obj-$(CONFIG_USB_DWC3_PCI)		+=3D dwc3-pci.o
>  obj-$(CONFIG_USB_DWC3_KEYSTONE)		+=3D dwc3-keystone.o
>  obj-$(CONFIG_USB_DWC3_OF_SIMPLE)	+=3D dwc3-of-simple.o
>  obj-$(CONFIG_USB_DWC3_ST)		+=3D dwc3-st.o
> +obj-$(CONFIG_USB_DWC3_OCTEON)		+=3D dwc3-octeon.o
> diff --git a/drivers/usb/dwc3/dwc3-octeon.c b/drivers/usb/dwc3/dwc3-octeo=
n.c
> new file mode 100644
> index 0000000..ae84a01
> --- /dev/null
> +++ b/drivers/usb/dwc3/dwc3-octeon.c
> @@ -0,0 +1,61 @@
> +/**
> + * dwc3-octeon.c - Cavium OCTEON III DWC3 Specific Glue Layer
> + *
> + * Copyright (C) 2016 Cavium Networks
> + *
> + * Author: Steven J. Hill <steven.hill@cavium.com>
> + *
> + * This program is free software: you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2  of
> + * the License as published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + *
> + * Inspired by dwc3-exynos.c and dwc3-st.c files.
> + */
> +
> +#include <linux/module.h>
> +#include <linux/device.h>
> +#include <linux/platform_device.h>
> +#include <linux/of.h>
> +#include <linux/dma-mapping.h>
> +
> +static int dwc3_octeon_probe(struct platform_device *pdev)
> +{
> +	struct device		*dev =3D &pdev->dev;
> +	int			ret;
> +
> +	/*
> +	 * Right now device-tree probed devices do not provide
> +	 * "dma-ranges" or "dma-coherent" properties.
> +	 */
> +	ret =3D dma_coerce_mask_and_coherent(dev, DMA_BIT_MASK(64));
> +	if (ret)
> +		return ret;

don't you need to call of_platform_populate() at least?

=2D-=20
balbi

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBCAAGBQJX1lIAAAoJEMy+uJnhGpkGM1kQAKug3aSm76i3waNz678HIK1W
x8ntEgd0bCT+5rL/ASO1hPp/QJCRHZXPZ84QifuATzUzyXYzP5Mf36lVQ+4PVNcE
ra3XEu9/8yDYFvlAUc80OSBzI08hvXRn/ZmNAULOXO8azw3afw7RXCalNbEUU/Jq
aqHVKgLJ8e2MO1OD9bw06BSpTy/lUPQlkc1mNYF2H2Doo2taUPGtERIUGZcV/GLX
FQmhoJNcsX7qFzjkvWOCpFLTMecgG3auzBC5LcKhx0pVsJFW8jSer33/mzpPTpkt
/DzSCjnAgPCkgqQg44f0LSR4xc/F1mGSu7OKvzNm8uLcyIZj5zjxauq93A+LOE27
l3QKdH/ba+bfQ1f6hJLWt64/WXoVY11mTdAsHauLoAe9RHHCJzApa4CBSjyDPqDQ
oGe7MIN5H6/GrevsdH+azXWl40lCLwjVOzj5s6UuMv3TSmrTnCYpK01yIbxO6svB
782KwUi1TPxbI+NychSX41ZDstQLced/tgBH0Unt8aNuRzQ10ElavTujPagMG7hX
JnGtdPWUP+TosXZ4d/vsa9d2IK+FTID5QuFY4VgDUx7Dv1p9Reb/G2tfdRk+EXOS
zUPx9XbMW1lWgVlo6PSUoXpfv1587qt6Q3bYEnhwmysyb87dkBy7mN+qHJgcqeF1
WbP4xOS9NYPgeWv8ChjU
=qk/8
-----END PGP SIGNATURE-----
--=-=-=--
