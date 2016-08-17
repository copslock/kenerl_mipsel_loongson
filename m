Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 17 Aug 2016 18:01:30 +0200 (CEST)
Received: from mail-wm0-f52.google.com ([74.125.82.52]:37647 "EHLO
        mail-wm0-f52.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992777AbcHQQBXGdAKi (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 17 Aug 2016 18:01:23 +0200
Received: by mail-wm0-f52.google.com with SMTP id i5so241579728wmg.0
        for <linux-mips@linux-mips.org>; Wed, 17 Aug 2016 09:01:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-transfer-encoding;
        bh=BN8tav72eg2eoGd2X1UMLpHGOo3cbdKD7hBaMarqOc0=;
        b=dD2UaT0Y00b8LxEyOWSwfUww7bfq53K35woBVGQhwmgKsXLrEPhpzWXKR16sUVMUGp
         LS4SNxRojEvcGj94rWT+48le+7fHEsrVRf4MEpi8RTBU/gEbUb+d6Euhn8RqjXnlqMal
         XI8rrFt1fj76BQ/iz588UkKrMqLvWeyafM1vo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=BN8tav72eg2eoGd2X1UMLpHGOo3cbdKD7hBaMarqOc0=;
        b=KT6Mt6iF9gxs3hZfph7mT1sBh6MhG6qLI2Y4VVL6b292kC2RHfhNr4Vk5jUz8Ggs8O
         7T8aKVdMdAE/jyhHSmKUfH9b+rs3M9SXR2CCVDY/NdAO61/GUr3xP7wVAl2+kx0/BuZ+
         Q+QlvIRbUh8oK8l6220LH8Y2jTqJuHkRm4gneDnIm3jHbylbqAuZCgmnNLiSNmQMUeVI
         +hlS25k9SBWTdbQgqhS84iMbkKpJIY8ZaHIESz8CXUqm3bttcVNuMB7H20UFUmb+xw1N
         De0YMR9VFxE2Enb4PYZM75drh2goxgm1pH3+zVsRS9Z2RWwoi0o//q3V9A+2jg1biZ+Q
         NIzw==
X-Gm-Message-State: AEkoouvpFKFCZKFPU1JZewn4LvhwgKleA/Wddcr+Dc8PmZMrRc+oeUjKChcwQmSxAZ09KZnj
X-Received: by 10.194.38.166 with SMTP id h6mr43204156wjk.101.1471449677576;
        Wed, 17 Aug 2016 09:01:17 -0700 (PDT)
Received: from [192.168.1.125] (cpc4-aztw19-0-0-cust71.18-1.cable.virginm.net. [82.33.25.72])
        by smtp.googlemail.com with ESMTPSA id jv9sm25404493wjb.45.2016.08.17.09.01.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 17 Aug 2016 09:01:16 -0700 (PDT)
Subject: Re: [PATCH] Add Ingenic JZ4780 hardware RNG driver
To:     PrasannaKumar Muralidharan <prasannatsmkumar@gmail.com>,
        mpm@selenic.com, herbert@gondor.apana.org.au, robh+dt@kernel.org,
        mark.rutland@arm.com, ralf@linux-mips.org, davem@davemloft.net,
        geert@linux-m68k.org, akpm@linux-foundation.org,
        gregkh@linuxfoundation.org, mchehab@kernel.org, linux@roeck-us.net,
        boris.brezillon@free-electrons.com, harvey.hunt@imgtec.com,
        alex.smith@imgtec.com, lee.jones@linaro.org, f.fainelli@gmail.com,
        kieran@bingham.xyz, krzk@kernel.org,
        joshua.henderson@microchip.com, yendapally.reddy@broadcom.com,
        narmstrong@baylibre.com, wangkefeng.wang@huawei.com,
        chunkeey@googlemail.com, noltari@gmail.com,
        linus.walleij@linaro.org, pankaj.dev@st.com,
        mathieu.poirier@linaro.org, linux-crypto@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mips@linux-mips.org
References: <1471448151-20850-1-git-send-email-prasannatsmkumar@gmail.com>
From:   Daniel Thompson <daniel.thompson@linaro.org>
Message-ID: <0c7ae690-31f5-5d10-3168-2a54d4974399@linaro.org>
Date:   Wed, 17 Aug 2016 17:01:15 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.2.0
MIME-Version: 1.0
In-Reply-To: <1471448151-20850-1-git-send-email-prasannatsmkumar@gmail.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <daniel.thompson@linaro.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 54576
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: daniel.thompson@linaro.org
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

On 17/08/16 16:35, PrasannaKumar Muralidharan wrote:
> This patch adds support for hardware random number generator present in
> JZ4780 SoC.
>
> Signed-off-by: PrasannaKumar Muralidharan <prasannatsmkumar@gmail.com>
> ---
>  .../devicetree/bindings/rng/ingenic,jz4780-rng.txt |  12 +++
>  MAINTAINERS                                        |   5 +
>  arch/mips/boot/dts/ingenic/jz4780.dtsi             |   7 +-
>  drivers/char/hw_random/Kconfig                     |  14 +++
>  drivers/char/hw_random/Makefile                    |   1 +
>  drivers/char/hw_random/jz4780-rng.c                | 105 +++++++++++++++++++++
>  6 files changed, 143 insertions(+), 1 deletion(-)
>  create mode 100644 Documentation/devicetree/bindings/rng/ingenic,jz4780-rng.txt
>  create mode 100644 drivers/char/hw_random/jz4780-rng.c
>
> diff --git a/Documentation/devicetree/bindings/rng/ingenic,jz4780-rng.txt b/Documentation/devicetree/bindings/rng/ingenic,jz4780-rng.txt
> new file mode 100644
> index 0000000..03abf56
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/rng/ingenic,jz4780-rng.txt
> @@ -0,0 +1,12 @@
> +Ingenic jz4780 RNG driver
> +
> +Required properties:
> +- compatible : Should be "ingenic,jz4780-rng"
> +- reg : Specifies base physical address and size of the registers.
> +
> +Example:
> +
> +rng: rng@100000D8 {
> +	compatible = "ingenic,jz4780-rng";
> +	reg = <0x100000D8 0x8>;
> +};

Device tree bindings should be a separate patch. See 
Documentation/devicetree/bindings/submitting-patches.txt .


> diff --git a/MAINTAINERS b/MAINTAINERS
> index 08e9efe..c0c66eb 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -6002,6 +6002,11 @@ M:	Zubair Lutfullah Kakakhel <Zubair.Kakakhel@imgtec.com>
>  S:	Maintained
>  F:	drivers/dma/dma-jz4780.c
>
> +INGENIC JZ4780 HW RNG Driver
> +M:	PrasannaKumar Muralidharan <prasannatsmkumar@gmail.com>
> +S:	Maintained
> +F:	drivers/char/hw_random/jz4780-rng.c
> +
>  INTEGRITY MEASUREMENT ARCHITECTURE (IMA)
>  M:	Mimi Zohar <zohar@linux.vnet.ibm.com>
>  M:	Dmitry Kasatkin <dmitry.kasatkin@gmail.com>
> diff --git a/arch/mips/boot/dts/ingenic/jz4780.dtsi b/arch/mips/boot/dts/ingenic/jz4780.dtsi
> index b868b42..f11d139 100644
> --- a/arch/mips/boot/dts/ingenic/jz4780.dtsi
> +++ b/arch/mips/boot/dts/ingenic/jz4780.dtsi
> @@ -36,7 +36,7 @@
>
>  	cgu: jz4780-cgu@10000000 {
>  		compatible = "ingenic,jz4780-cgu";
> -		reg = <0x10000000 0x100>;
> +		reg = <0x10000000 0xD8>;
>  		clocks = <&ext>, <&rtc>;
>  		clock-names = "ext", "rtc";
> @@ -44,6 +44,11 @@
>  		#clock-cells = <1>;
>  	};
>
> +	rng: jz4780-rng@100000D8 {
> +		compatible = "ingenic,jz4780-rng";
> +		reg = <0x100000D8 0x8>;
> +	};
> +
>  	uart0: serial@10030000 {
>  		compatible = "ingenic,jz4780-uart";
>  		reg = <0x10030000 0x100>;

Updates to device tree files are also normally sent as a separate patch 
later in the series than the driver itself (at least they are in arm land).


> diff --git a/drivers/char/hw_random/Kconfig b/drivers/char/hw_random/Kconfig
> index 56ad5a59..c336fe8 100644
> --- a/drivers/char/hw_random/Kconfig
> +++ b/drivers/char/hw_random/Kconfig
> @@ -294,6 +294,20 @@ config HW_RANDOM_POWERNV
>
>  	  If unsure, say Y.
>
> +config HW_RANDOM_JZ4780
> +	tristate "JZ4780 HW random number generator support"
> +	depends on MACH_INGENIC
> +	depends on HAS_IOMEM
> +	default HW_RANDOM
> +	---help---
> +	  This driver provides kernel-side support for the Random Number
> +	  Generator hardware found on JZ4780 SOCs.
> +
> +	  To compile this driver as a module, choose M here: the
> +	  module will be called jz4780-rng.
> +
> +	  If unsure, say Y.
> +

Shouldn't this be inserted either in alphabetic order (which not 
applicable for this file) or at the end of the file?


>  config HW_RANDOM_EXYNOS
>  	tristate "EXYNOS HW random number generator support"
>  	depends on ARCH_EXYNOS || COMPILE_TEST
> diff --git a/drivers/char/hw_random/Makefile b/drivers/char/hw_random/Makefile
> index 04bb0b0..a155066 100644
> --- a/drivers/char/hw_random/Makefile
> +++ b/drivers/char/hw_random/Makefile
> @@ -26,6 +26,7 @@ obj-$(CONFIG_HW_RANDOM_PSERIES) += pseries-rng.o
>  obj-$(CONFIG_HW_RANDOM_POWERNV) += powernv-rng.o
>  obj-$(CONFIG_HW_RANDOM_EXYNOS)	+= exynos-rng.o
>  obj-$(CONFIG_HW_RANDOM_HISI)	+= hisi-rng.o
> +obj-$(CONFIG_HW_RANDOM_JZ4780)	+= jz4780-rng.o

This looks like it inserts into the makefile in a gratuitously different 
order than the one in the KConfig file.


>  obj-$(CONFIG_HW_RANDOM_TPM) += tpm-rng.o
>  obj-$(CONFIG_HW_RANDOM_BCM2835) += bcm2835-rng.o
>  obj-$(CONFIG_HW_RANDOM_IPROC_RNG200) += iproc-rng200.o
> diff --git a/drivers/char/hw_random/jz4780-rng.c b/drivers/char/hw_random/jz4780-rng.c
> new file mode 100644
> index 0000000..c9d2cde
> --- /dev/null
> +++ b/drivers/char/hw_random/jz4780-rng.c
> @@ -0,0 +1,105 @@
> +/*
> + * jz4780-rng.c - Random Number Generator driver for J4780
> + *
> + * Copyright 2016 (C) PrasannaKumar Muralidharan <prasannatsmkumar@gmail.com>
> + *
> + * This file is licensed under  the terms of the GNU General Public
> + * License version 2. This program is licensed "as is" without any
> + * warranty of any kind, whether express or implied.
> + */
> +
> +#include <linux/hw_random.h>
> +#include <linux/device.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/io.h>
> +#include <linux/platform_device.h>
> +#include <linux/err.h>
> +
> +#define REG_RNG_CTRL	0x0
> +#define REG_RNG_DATA	0x4
> +
> +struct jz4780_rng {
> +	struct device *dev;
> +	struct hwrng rng;
> +	void __iomem *mem;
> +};
> +
> +static u32 jz4780_rng_readl(struct jz4780_rng *rng, u32 offset)
> +{
> +	return readl(rng->mem + offset);
> +}
> +
> +static void jz4780_rng_writel(struct jz4780_rng *rng, u32 val, u32 offset)
> +{
> +	writel(val, rng->mem + offset);
> +}
> +
> +static int jz4780_rng_read(struct hwrng *rng, void *buf, size_t max, bool wait)
> +{
> +	struct jz4780_rng *jz4780_rng = container_of(rng, struct jz4780_rng,
> +							rng);
> +	u32 *data = buf;
> +	*data = jz4780_rng_readl(jz4780_rng, REG_RNG_DATA);
> +	return 4;
> +}
> +
> +static int jz4780_rng_probe(struct platform_device *pdev)
> +{
> +	struct jz4780_rng *jz4780_rng;
> +	struct resource *res;
> +	resource_size_t size;
> +	int ret;
> +
> +	jz4780_rng = devm_kzalloc(&pdev->dev, sizeof(struct jz4780_rng),
> +					GFP_KERNEL);
> +	if (!jz4780_rng)
> +		return -ENOMEM;
> +
> +	jz4780_rng->dev = &pdev->dev;
> +	jz4780_rng->rng.name = "jz4780";
> +	jz4780_rng->rng.read = jz4780_rng_read;
> +
> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);

If platform_get_resource() returns NULL I think this code will crash.


> +	size = resource_size(res);
> +
> +	jz4780_rng->mem = devm_ioremap(&pdev->dev, res->start, size);
> +	if (IS_ERR(jz4780_rng->mem))
> +		return PTR_ERR(jz4780_rng->mem);
> +
> +	platform_set_drvdata(pdev, jz4780_rng);
> +	jz4780_rng_writel(jz4780_rng, 1, REG_RNG_CTRL);
> +	ret = hwrng_register(&jz4780_rng->rng);
> +	return ret;
> +}
> +
> +static int jz4780_rng_remove(struct platform_device *pdev)
> +{
> +	struct jz4780_rng *jz4780_rng = platform_get_drvdata(pdev);
> +
> +	jz4780_rng_writel(jz4780_rng, 0, REG_RNG_CTRL);
> +	hwrng_unregister(&jz4780_rng->rng);

These two are in same order as probe() function. I would expect them to 
be reversed (so hardware cannot be shutdown until we have unregistered it).


> +
> +	return 0;
> +}
> +
> +static const struct of_device_id jz4780_rng_dt_match[] = {
> +	{ .compatible = "ingenic,jz4780-rng", },
> +	{ },
> +};
> +MODULE_DEVICE_TABLE(of, jz4780_rng_dt_match);
> +
> +static struct platform_driver jz4780_rng_driver = {
> +	.driver		= {
> +		.name	= "jz4780-rng",
> +		.of_match_table = jz4780_rng_dt_match,
> +	},
> +	.probe		= jz4780_rng_probe,
> +	.remove		= jz4780_rng_remove,
> +};
> +module_platform_driver(jz4780_rng_driver);
> +
> +MODULE_DESCRIPTION("Ingenic JZ4780 H/W Random Number Generator driver");
> +MODULE_AUTHOR("PrasannaKumar Muralidharan <prasannatsmkumar@gmail.com>");
> +MODULE_LICENSE("GPL");
>
