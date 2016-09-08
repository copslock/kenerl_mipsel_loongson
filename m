Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 08 Sep 2016 09:55:42 +0200 (CEST)
Received: from mga05.intel.com ([192.55.52.43]:64504 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23992198AbcIHHzei-kif (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 8 Sep 2016 09:55:34 +0200
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga105.fm.intel.com with ESMTP; 08 Sep 2016 00:55:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.30,298,1470726000"; 
   d="asc'?scan'208";a="758330888"
Received: from pipin.fi.intel.com (HELO localhost) ([10.237.68.160])
  by FMSMGA003.fm.intel.com with ESMTP; 08 Sep 2016 00:55:27 -0700
From:   Felipe Balbi <felipe.balbi@linux.intel.com>
To:     "Steven J. Hill" <steven.hill@cavium.com>,
        linux-usb@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-mips@linux-mips.org,
        David Daney <david.daney@cavium.com>
Subject: Re: [PATCH] usb: dwc3: OCTEON: add support for device tree
In-Reply-To: <eb11c5c9-62c8-ee1b-0030-c8885015e6c3@cavium.com>
References: <eb11c5c9-62c8-ee1b-0030-c8885015e6c3@cavium.com>
User-Agent: Notmuch/0.22.1+63~g994277e (https://notmuchmail.org) Emacs/25.1.3 (x86_64-pc-linux-gnu)
Date:   Thu, 08 Sep 2016 10:54:54 +0300
Message-ID: <8760q6ker5.fsf@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha256; protocol="application/pgp-signature"
Return-Path: <felipe.balbi@linux.intel.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 55065
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


Hi Steven,

"Steven J. Hill" <steven.hill@cavium.com> writes:
> This patch adds support to parse probe data for
> the dwc3-octeon driver using device tree. The
> DWC3 IP core is found on OCTEON III processors.
>
> Signed-off-by: Steven J. Hill <Steven.Hill@cavium.com>
> ---
>  drivers/usb/dwc3/Kconfig       | 10 +++++
>  drivers/usb/dwc3/Makefile      |  1 +
>  drivers/usb/dwc3/dwc3-octeon.c | 96 ++++++++++++++++++++++++++++++++++++=
++++++
>  3 files changed, 107 insertions(+)
>  create mode 100644 drivers/usb/dwc3/dwc3-octeon.c
>
> diff --git a/drivers/usb/dwc3/Kconfig b/drivers/usb/dwc3/Kconfig
> index a64ce1c..99db6008 100644
> --- a/drivers/usb/dwc3/Kconfig
> +++ b/drivers/usb/dwc3/Kconfig
> @@ -105,4 +105,14 @@ config USB_DWC3_ST
>  	  inside (i.e. STiH407).
>  	  Say 'Y' or 'M' if you have one such device.
>=20=20
> +config USB_DWC3_OCTEON
> +	tristate "Cavium OCTEON III Platforms"
> +	depends on CAVIUM_OCTEON_SOC

we really don't want SoC dependencies. At a minimum, you should have:

	depends on CAVIUM_OCTEON_SOC || COMPILE_TEST

> +static int dwc3_octeon_probe(struct platform_device *pdev)
> +{
> +	struct device		*dev =3D &pdev->dev;
> +	struct resource		*res;
> +	struct dwc3_octeon	*octeon;
> +	int			ret;
> +
> +	octeon =3D devm_kzalloc(dev, sizeof(*octeon), GFP_KERNEL);
> +	if (!octeon)
> +		return - ENOMEM;
> +
> +	/*
> +	 * Right now device-tree probed devices don't get dma_mask set.
> +	 * Since shared usb code relies on it, set it here for now.
> +	 */

this doesn't look correct to me. Are you, perhaps, just missing
dma-ranges and dma-coherent properties?

> +static int dwc3_octeon_remove(struct platform_device *pdev)
> +{
> +	struct dwc3_octeon *octeon =3D platform_get_drvdata(pdev);
> +
> +	octeon->usbctl =3D NULL;
> +	octeon->index =3D -1;

octeon is going to be freed when ->remove() gets executed. You really
don't need to do these. In fact, setting usbctl to NULL will break
iounmap(). It seems to be me you don't need a remove at all.

=2D-=20
balbi

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBCAAGBQJX0RlOAAoJEMy+uJnhGpkGE3IQAK6cttOmiK5LYbLLAjVP9daU
b2fhBB6x2mZZI3IvR8dTHN90s9G+oU45MOjz/xXU6Zl3rxQpdo1don05ecXcIRSP
kOsalcQkA+wwywXemUF/Xsqm94D2iAkH3k+KX5Cu4kLYRr4iNXZZ88o4dy8uswAA
h+w5jWGp/KfUgHAbrEuMw0z9giLMRWJKv3c/UuwS3Z8honEpc7u6tLmMne4FtGeB
jiLd1RTiOBe18zDuiW3D+dX8+neKdnaKsxjz04LzLe1ptLEp40bz5Z+K27pyQ2i6
nSaJJtu5c9SMSdZVplaoKDDU1Q5TOpFXYkrMc83ul/2cl0G2UFiDImSzMRytqViW
9EoFr9yFGHtzBJX5Bi42y5uAZ3W+0T81KT7IeA0ZODq4TCYf0Py3iDN5WdC9vLWC
/BfNqTVSXyRXrdeQcflvVtenRQR/Mhj3jZkDQ+5oWn6xgw9xM6VOQsigmnc2VwYh
m03HO3iOpt8FS/Nkl+Em3GHfyhdLDLWy39Aht1MokGr2ZqQpIDefba7+l2FPpMZb
xQndNLmdBcsuY06y+TWet4IA2PzJyfsN2ULo9fu8nYc6BQdLMZ6RuMt4n7+HlD0y
RLhsCkOMChBpgt0UqCbCt74y46DboOTLhDHrW/GX4T3mZvQrrQ0gFlBQYz06+Xaz
00NvGJgj+cELrgETkaQE
=D8j5
-----END PGP SIGNATURE-----
--=-=-=--
