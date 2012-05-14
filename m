Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 14 May 2012 07:46:49 +0200 (CEST)
Received: from mail-ob0-f177.google.com ([209.85.214.177]:39293 "EHLO
        mail-ob0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903605Ab2ENFqn convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 14 May 2012 07:46:43 +0200
Received: by obqv19 with SMTP id v19so9172019obq.36
        for <linux-mips@linux-mips.org>; Sun, 13 May 2012 22:46:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=3G2uT3h48tiBApMtVJKAbO4Zphy5CEC/fgqfEumMLu0=;
        b=zjSWJD7H9reI2eDZUAriLQlMQnMSM9rMinPTRT5pQuUpS0Q8Okmr5E/vRUcs8qlImy
         ch51yThog/N1In0VPf9YGKN1BRC2OTpYXbATZy1S3EhMQQAn/7Au+KeCoapmjZlkgmCS
         UgCzZQcEz42uWnHSXSS8TwA9NcSqeZwWy/mLzQdul3NY19N3BEPiYvaCA1/MOTw6YFvA
         GWdWXysH3yXw52nBzvSpMRiCjYh6BUS5XTwKhEo80JIXq0NjM4aNAAyWDDcAw3SjyZID
         UJUGXsApRZMQ1Dj91GrcL9WV+d1CDnlQ6fBqiQ76CP8JVHz0gFpBC44Osl2wwWMdgHRO
         avlQ==
MIME-Version: 1.0
Received: by 10.50.45.133 with SMTP id n5mr3400542igm.8.1336974397141; Sun, 13
 May 2012 22:46:37 -0700 (PDT)
Received: by 10.231.76.214 with HTTP; Sun, 13 May 2012 22:46:37 -0700 (PDT)
In-Reply-To: <1336772086-17248-3-git-send-email-ddaney.cavm@gmail.com>
References: <1336772086-17248-1-git-send-email-ddaney.cavm@gmail.com>
        <1336772086-17248-3-git-send-email-ddaney.cavm@gmail.com>
Date:   Mon, 14 May 2012 11:16:37 +0530
Message-ID: <CAM=Q2csSQWbCOCQpubDok1=hmPvHU0MTEUg+-FGhp91=O5L6Hw@mail.gmail.com>
Subject: Re: [PATCH 2/2] spi: Add SPI master controller for OCTEON SOCs.
From:   Shubhrajyoti Datta <omaplinuxkernel@gmail.com>
To:     David Daney <ddaney.cavm@gmail.com>
Cc:     devicetree-discuss@lists.ozlabs.org,
        Grant Likely <grant.likely@secretlab.ca>,
        Rob Herring <rob.herring@calxeda.com>,
        spi-devel-general@lists.sourceforge.net, linux-mips@linux-mips.org,
        David Daney <david.daney@cavium.com>,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
X-archive-position: 33288
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: omaplinuxkernel@gmail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

Hi David,
A few comments.

On Sat, May 12, 2012 at 3:04 AM, David Daney <ddaney.cavm@gmail.com> wrote:
> From: David Daney <david.daney@cavium.com>
>
> Add the driver, link it into the kbuild system and provide device tree
> binding documentation.
>
> Signed-off-by: David Daney <david.daney@cavium.com>
> ---
>  .../devicetree/bindings/spi/spi-octeon.txt         |   33 ++
>  drivers/spi/Kconfig                                |    7 +
>  drivers/spi/Makefile                               |    1 +
>  drivers/spi/spi-octeon.c                           |  369 ++++++++++++++++++++
>  4 files changed, 410 insertions(+), 0 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/spi/spi-octeon.txt
>  create mode 100644 drivers/spi/spi-octeon.c
>
> diff --git a/Documentation/devicetree/bindings/spi/spi-octeon.txt b/Documentation/devicetree/bindings/spi/spi-octeon.txt
> new file mode 100644
> index 0000000..431add1
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/spi/spi-octeon.txt
> @@ -0,0 +1,33 @@
> +Cavium, Inc. OCTEON SOC SPI master controller.
> +
> +Required properties:
> +- compatible : "cavium,octeon-3010-spi"
> +- reg : The register base for the controller.
> +- interrupts : One interrupt, used by the controller.
> +- #address-cells : <1>, as required by generic SPI binding.
> +- #size-cells : <0>, also as required by generic SPI binding.
> +
> +Child nodes as per the generic SPI binding.
> +
> +Example:
> +
> +       spi@1070000001000 {
> +               compatible = "cavium,octeon-3010-spi";
> +               reg = <0x10700 0x00001000 0x0 0x100>;
> +               interrupts = <0 58>;
> +               #address-cells = <1>;
> +               #size-cells = <0>;
> +
> +               eeprom@0 {
> +                       compatible = "st,m95256", "atmel,at25";
> +                       reg = <0>;
> +                       spi-max-frequency = <5000000>;
> +                       spi-cpha;
> +                       spi-cpol;
> +
> +                       pagesize = <64>;
> +                       size = <32768>;
> +                       address-width = <16>;
> +               };
> +       };
> +
> diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
> index 00c0240..e1dd0d0 100644
> --- a/drivers/spi/Kconfig
> +++ b/drivers/spi/Kconfig
> @@ -228,6 +228,13 @@ config SPI_OC_TINY
>        help
>          This is the driver for OpenCores tiny SPI master controller.
>
> +config SPI_OCTEON
> +       tristate "Cavium OCTEON SPI controller"
> +       depends on CPU_CAVIUM_OCTEON
> +       help
> +         SPI host driver for the hardware found on some Cavium OCTEON
> +         SOCs.
> +
>  config SPI_OMAP_UWIRE
>        tristate "OMAP1 MicroWire"
>        depends on ARCH_OMAP1
> diff --git a/drivers/spi/Makefile b/drivers/spi/Makefile
> index 9d75d21..c7f8b71 100644
> --- a/drivers/spi/Makefile
> +++ b/drivers/spi/Makefile
> @@ -37,6 +37,7 @@ obj-$(CONFIG_SPI_MPC52xx_PSC)         += spi-mpc52xx-psc.o
>  obj-$(CONFIG_SPI_MPC52xx)              += spi-mpc52xx.o
>  obj-$(CONFIG_SPI_NUC900)               += spi-nuc900.o
>  obj-$(CONFIG_SPI_OC_TINY)              += spi-oc-tiny.o
> +obj-$(CONFIG_SPI_OCTEON)               += spi-octeon.o
>  obj-$(CONFIG_SPI_OMAP_UWIRE)           += spi-omap-uwire.o
>  obj-$(CONFIG_SPI_OMAP_100K)            += spi-omap-100k.o
>  obj-$(CONFIG_SPI_OMAP24XX)             += spi-omap2-mcspi.o
> diff --git a/drivers/spi/spi-octeon.c b/drivers/spi/spi-octeon.c
> new file mode 100644
> index 0000000..7207aaf
> --- /dev/null
> +++ b/drivers/spi/spi-octeon.c
> @@ -0,0 +1,369 @@
> +/*
> + * This file is subject to the terms and conditions of the GNU General Public
> + * License.  See the file "COPYING" in the main directory of this archive
> + * for more details.
> + *
> + * Copyright (C) 2011, 2012 Cavium, Inc.
> + */
> +
> +#include <linux/platform_device.h>
> +#include <linux/interrupt.h>
> +#include <linux/spi/spi.h>
> +#include <linux/module.h>
> +#include <linux/init.h>
> +#include <linux/of_spi.h>
> +#include <linux/io.h>
> +#include <linux/of.h>
> +
> +#include <asm/octeon/octeon.h>
> +#include <asm/octeon/cvmx-mpi-defs.h>
> +
> +#define DRV_VERSION "2.0" /* Version 1 was the out-of-tree driver */
This could be given a miss. As it is less meaningful once accepted.

> +#define DRV_DESCRIPTION "Cavium, Inc. OCTEON SPI bus driver"
> +
> +
> +#define OCTEON_SPI_CFG 0
> +#define OCTEON_SPI_STS 0x08
> +#define OCTEON_SPI_TX 0x10
> +#define OCTEON_SPI_DAT0 0x80
> +
> +#define OCTEON_SPI_MAX_BYTES 9
> +
> +#define OCTEON_SPI_MAX_CLOCK_HZ 16000000
> +
> +struct octeon_spi {
> +       struct spi_master *my_master;
> +       u64 register_base;
> +       u64 last_cfg;
> +       u64 cs_enax;
> +};
> +
> +struct octeon_spi_setup {
> +       u32 max_speed_hz;
> +       u8 chip_select;
> +       u8 mode;
> +       u8 bits_per_word;
> +};
> +
> +static void octeon_spi_wait_ready(struct octeon_spi *p)
> +{
> +       union cvmx_mpi_sts mpi_sts;
> +       unsigned int loops = 0;
> +
> +       do {
> +               if (loops++)
> +                       __delay(500);
Could we allow  have a non-busy loop here?
