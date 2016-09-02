Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 02 Sep 2016 18:26:36 +0200 (CEST)
Received: from mail.kernel.org ([198.145.29.136]:48812 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23991984AbcIBQ0ZFq5Kj (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 2 Sep 2016 18:26:25 +0200
Received: from mail.kernel.org (localhost [127.0.0.1])
        by mail.kernel.org (Postfix) with ESMTP id 8F40920225;
        Fri,  2 Sep 2016 16:26:22 +0000 (UTC)
Received: from mail.kernel.org (host-091-097-077-058.ewe-ip-backbone.de [91.97.77.58])
        (using TLSv1.2 with cipher AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CBC2E20263;
        Fri,  2 Sep 2016 16:26:16 +0000 (UTC)
Date:   Fri, 2 Sep 2016 18:26:13 +0200
From:   Sebastian Reichel <sre@kernel.org>
To:     Paul Burton <paul.burton@imgtec.com>
Cc:     linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>,
        Chris Brand <chris.brand@broadcom.com>,
        Alexandre Belloni <alexandre.belloni@free-electrons.com>,
        Moritz Fischer <moritz.fischer@ettus.com>,
        linux-pm@vger.kernel.org, Richard Weinberger <richard@nod.at>,
        Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>,
        linux-kernel@vger.kernel.org, Andy Yan <andy.yan@rock-chips.com>,
        Krzysztof Kozlowski <k.kozlowski@samsung.com>,
        David Woodhouse <dwmw2@infradead.org>,
        John Stultz <john.stultz@linaro.org>,
        Nicolas Ferre <nicolas.ferre@atmel.com>
Subject: Re: [PATCH 11/12] power: reset: Add Intel PIIX4 poweroff driver
Message-ID: <20160902162612.i6qjjgob7gfqnmkz@earth>
References: <20160902154859.24269-1-paul.burton@imgtec.com>
 <20160902154859.24269-12-paul.burton@imgtec.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="szjeg5vq2ruvr7vz"
Content-Disposition: inline
In-Reply-To: <20160902154859.24269-12-paul.burton@imgtec.com>
User-Agent: Mutt/1.6.2-neo (2016-07-23)
X-Virus-Scanned: ClamAV using ClamSMTP
Return-Path: <sre@kernel.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 55017
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sre@kernel.org
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


--szjeg5vq2ruvr7vz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Paul,

The driver looks fine to me, just two notes:

On Fri, Sep 02, 2016 at 04:48:57PM +0100, Paul Burton wrote:
> Add a driver which allows powering off the system via an Intel PIIX4
> southbridge, by entering the PIIX4 SOff state. This is useful on the
> MIPS Malta development board, where it will power down the FPGA based
> board until its ON/NMI button is pressed, or the QEMU implementation of
> the MIPS Malta board where it will cause QEMU to exit.
>=20
> Signed-off-by: Paul Burton <paul.burton@imgtec.com>
> ---
>=20
>  drivers/power/reset/Kconfig          |   9 +++
>  drivers/power/reset/Makefile         |   1 +
>  drivers/power/reset/piix4-poweroff.c | 103 +++++++++++++++++++++++++++++=
++++++
>  3 files changed, 113 insertions(+)
>  create mode 100644 drivers/power/reset/piix4-poweroff.c
>=20
> diff --git a/drivers/power/reset/Kconfig b/drivers/power/reset/Kconfig
> index c74c3f6..b27ca50 100644
> --- a/drivers/power/reset/Kconfig
> +++ b/drivers/power/reset/Kconfig
> @@ -104,6 +104,15 @@ config POWER_RESET_MSM
>  	help
>  	  Power off and restart support for Qualcomm boards.
> =20
> +config POWER_RESET_PIIX4_POWEROFF
> +	tristate "Intel PIIX4 power-off driver"
> +	depends on MIPS && PCI

depends on PCI
depends on MIPS || COMPILE_TEST

> +	help
> +	  This driver supports powering off a system using the Intel PIIX4
> +	  southbridge, for example the MIPS Malta development board. The
> +	  southbridge SOff state is entered in response to a request to
> +	  power off the system.
> +
>  config POWER_RESET_LTC2952
>  	bool "LTC2952 PowerPath power-off driver"
>  	depends on OF_GPIO
> diff --git a/drivers/power/reset/Makefile b/drivers/power/reset/Makefile
> index 1be307c..11dae3b 100644
> --- a/drivers/power/reset/Makefile
> +++ b/drivers/power/reset/Makefile
> @@ -10,6 +10,7 @@ obj-$(CONFIG_POWER_RESET_GPIO_RESTART) +=3D gpio-restar=
t.o
>  obj-$(CONFIG_POWER_RESET_HISI) +=3D hisi-reboot.o
>  obj-$(CONFIG_POWER_RESET_IMX) +=3D imx-snvs-poweroff.o
>  obj-$(CONFIG_POWER_RESET_MSM) +=3D msm-poweroff.o
> +obj-$(CONFIG_POWER_RESET_PIIX4_POWEROFF) +=3D piix4-poweroff.o
>  obj-$(CONFIG_POWER_RESET_LTC2952) +=3D ltc2952-poweroff.o
>  obj-$(CONFIG_POWER_RESET_QNAP) +=3D qnap-poweroff.o
>  obj-$(CONFIG_POWER_RESET_RESTART) +=3D restart-poweroff.o
> diff --git a/drivers/power/reset/piix4-poweroff.c b/drivers/power/reset/p=
iix4-poweroff.c
> new file mode 100644
> index 0000000..bfa8bea
> --- /dev/null
> +++ b/drivers/power/reset/piix4-poweroff.c

[...]

> +
> +module_pci_driver(piix4_poweroff_driver);
> +MODULE_AUTHOR("Paul Burton <paul.burton@imgtec.com>");

missing MODULE_LICENSE()

-- Sebastian

--szjeg5vq2ruvr7vz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJXyagiAAoJENju1/PIO/qaHFEP/RNtVJ+4OJE+MYDY8qrWDQuR
SYgFJx2EiA0q+FdQuU85wbnPXYsKt5I3HaE55qm/k8kk+2dDhQWgaNPubJTsWq17
5SFW7YYRChM8QE7my0TcXaCr59DUNgS6qsCzdgEhvxD5/U8PFvb9KF4UA7g25hTe
1G0rxWBCSO7qjFlKJqaNUTcdKUh2jcMGgOnquPyM7eGpKNCeReAuz1AX88J8/Qjz
x5JSS6ch0HbROU69pvwi4tjEKaOTtttO7A8DodsoHkF8Ewx6gl0dCL7pDznEZSmG
559ODGDxMhfxawpUltxnD4cERYRaITq8No1x2+wu0gl635DyHWjgFhcgKVkZDgGl
g4KyfjVTcYOCHv4Pk4yMHAownFm+20ANBOgE+YVVBKN8Kz3TlwiRkwlQGA7xwuOk
pUSZ7uD6w3F3j5jIKVU/0qQVvVIwtXeyH22EhDB0Gqf/nEh9CAGChAyPlLGQgrEV
pFOYTNyJ/fSvY+UBmasTEonufCqZGqIycXAVezfXZIE+hKEvKR3ej2Dtj93d7FX4
8OAQxpeUtu2drr8bLFjZ7UWSiMRIcSZGwQlwCpUUUrno/bjy5Oh1yJbewh4tB269
XWRf5/WYD6nZbiI+OgmCD1ZaCCSW4oFDk8wwIsa6FTPBNjXECtHv+jBgSPdQeyzR
pncUxmiouf+ZAc7/849r
=C7oQ
-----END PGP SIGNATURE-----

--szjeg5vq2ruvr7vz--
