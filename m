Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 19 Aug 2016 11:48:07 +0200 (CEST)
Received: from mail-it0-f66.google.com ([209.85.214.66]:36366 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990825AbcHSJr5CoNpL (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 19 Aug 2016 11:47:57 +0200
Received: by mail-it0-f66.google.com with SMTP id j124so1172098ith.3
        for <linux-mips@linux-mips.org>; Fri, 19 Aug 2016 02:47:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=cCF9YrN1W65v+4DNl/rIYgyMChsm41UbfwTunvZky70=;
        b=VQGygiykIraIjjCVc34FtSc/cM146zhWKlJmurGxet4wT9DZz5SufgzK+yTsqTKExn
         gSddO103hwXd8jEPTRT8Cf+hA3srPNE78YRT0NLU7LLPrPpCZjPG9wRoElpcKx/6gp9B
         wUWtsQcELzGI92flLodFUxczjUhu8Jb+qYmrV6ujWLy7gdqWwxafe66QaZzhB8Kq61Ud
         JJfZCG/EsFQJuk7wQ2B2sIIkMxi2pLJkf+hha6uz0QKFru9d8j7GBhMkQpOxiihoTvLY
         J/q6BIamf8MJtHyRv9ONx5Z0uRrOUGVKbreeDHtJqN0ZHR3mNG4f5i3KHorgzgbyjyNl
         a+rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:reply-to:in-reply-to:references
         :from:date:message-id:subject:to:cc;
        bh=cCF9YrN1W65v+4DNl/rIYgyMChsm41UbfwTunvZky70=;
        b=GRXXbUGgGBQNEnPGxHxqlCdiGZYMKpnkyHVPYB80nelex5FxlV+dFsT2tqaIa4DJOh
         CPUveoDH/dk9s1sTKgzTz5ABJosSjUia8Me1AE0DOuC2RkTmNw43ENKVN4rB6OPt+BVp
         7wCPBoHacutneT6kjPusTXgGGIxbaWHfFh0zuSLLOXkUzsabHtxSCmW3ky02fSGyJTi6
         8W3WwrVm3KwOb9BoACbVePp0SCzHB+xUr2PuZyAS5YS1iElK4kWWnLNtZSGqKH+f+bk9
         U11MQMX0e01XQTxaGB5Sq/IJm0oCEuYACE3C8pphJo9nOW4nQsncsM1kMrXDGQgyhwgt
         +4bQ==
X-Gm-Message-State: AEkoousYQMtpzjdm46NC3CSMpKTiMCkqjs+KhEXB/fwcVyANHecytOOCL54Fw1Q+8EvSwbwy03t/GenyOqngMQ==
X-Received: by 10.36.102.194 with SMTP id k185mr4898814itc.45.1471600059124;
 Fri, 19 Aug 2016 02:47:39 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.36.54.75 with HTTP; Fri, 19 Aug 2016 02:47:38 -0700 (PDT)
Reply-To: noloader@gmail.com
In-Reply-To: <1471448151-20850-1-git-send-email-prasannatsmkumar@gmail.com>
References: <1471448151-20850-1-git-send-email-prasannatsmkumar@gmail.com>
From:   Jeffrey Walton <noloader@gmail.com>
Date:   Fri, 19 Aug 2016 05:47:38 -0400
Message-ID: <CAH8yC8kt-+6tnzAc2bsu6GX4uX1bqVoE8sZXvCS34DDhGhP2XQ@mail.gmail.com>
Subject: Re: [PATCH] Add Ingenic JZ4780 hardware RNG driver
To:     PrasannaKumar Muralidharan <prasannatsmkumar@gmail.com>
Cc:     linux-crypto@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mips@linux-mips.org
Content-Type: text/plain; charset=UTF-8
Return-Path: <noloader@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 54680
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: noloader@gmail.com
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

On Wed, Aug 17, 2016 at 11:35 AM, PrasannaKumar Muralidharan
<prasannatsmkumar@gmail.com> wrote:
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
> +       compatible = "ingenic,jz4780-rng";
> +       reg = <0x100000D8 0x8>;
> +};
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 08e9efe..c0c66eb 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -6002,6 +6002,11 @@ M:       Zubair Lutfullah Kakakhel <Zubair.Kakakhel@imgtec.com>
>  S:     Maintained
>  F:     drivers/dma/dma-jz4780.c
>
> +INGENIC JZ4780 HW RNG Driver
> +M:     PrasannaKumar Muralidharan <prasannatsmkumar@gmail.com>
> +S:     Maintained
> +F:     drivers/char/hw_random/jz4780-rng.c
> +
>  INTEGRITY MEASUREMENT ARCHITECTURE (IMA)
>  M:     Mimi Zohar <zohar@linux.vnet.ibm.com>
>  M:     Dmitry Kasatkin <dmitry.kasatkin@gmail.com>
> diff --git a/arch/mips/boot/dts/ingenic/jz4780.dtsi b/arch/mips/boot/dts/ingenic/jz4780.dtsi
> index b868b42..f11d139 100644
> --- a/arch/mips/boot/dts/ingenic/jz4780.dtsi
> +++ b/arch/mips/boot/dts/ingenic/jz4780.dtsi
> @@ -36,7 +36,7 @@
>
>         cgu: jz4780-cgu@10000000 {
>                 compatible = "ingenic,jz4780-cgu";
> -               reg = <0x10000000 0x100>;
> +               reg = <0x10000000 0xD8>;
>
>                 clocks = <&ext>, <&rtc>;
>                 clock-names = "ext", "rtc";
> @@ -44,6 +44,11 @@
>                 #clock-cells = <1>;
>         };
>
> +       rng: jz4780-rng@100000D8 {
> +               compatible = "ingenic,jz4780-rng";
> +               reg = <0x100000D8 0x8>;
> +       };
> +
>         uart0: serial@10030000 {
>                 compatible = "ingenic,jz4780-uart";
>                 reg = <0x10030000 0x100>;
> diff --git a/drivers/char/hw_random/Kconfig b/drivers/char/hw_random/Kconfig
> index 56ad5a59..c336fe8 100644
> --- a/drivers/char/hw_random/Kconfig
> +++ b/drivers/char/hw_random/Kconfig
> @@ -294,6 +294,20 @@ config HW_RANDOM_POWERNV
>
>           If unsure, say Y.
>
> +config HW_RANDOM_JZ4780
> +       tristate "JZ4780 HW random number generator support"
> +       depends on MACH_INGENIC
> +       depends on HAS_IOMEM
> +       default HW_RANDOM
> +       ---help---
> +         This driver provides kernel-side support for the Random Number
> +         Generator hardware found on JZ4780 SOCs.
> +
> +         To compile this driver as a module, choose M here: the
> +         module will be called jz4780-rng.
> +
> +         If unsure, say Y.
> +
>  config HW_RANDOM_EXYNOS
>         tristate "EXYNOS HW random number generator support"
>         depends on ARCH_EXYNOS || COMPILE_TEST
> diff --git a/drivers/char/hw_random/Makefile b/drivers/char/hw_random/Makefile
> index 04bb0b0..a155066 100644
> --- a/drivers/char/hw_random/Makefile
> +++ b/drivers/char/hw_random/Makefile
> @@ -26,6 +26,7 @@ obj-$(CONFIG_HW_RANDOM_PSERIES) += pseries-rng.o
>  obj-$(CONFIG_HW_RANDOM_POWERNV) += powernv-rng.o
>  obj-$(CONFIG_HW_RANDOM_EXYNOS) += exynos-rng.o
>  obj-$(CONFIG_HW_RANDOM_HISI)   += hisi-rng.o
> +obj-$(CONFIG_HW_RANDOM_JZ4780) += jz4780-rng.o
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
> +#define REG_RNG_CTRL   0x0
> +#define REG_RNG_DATA   0x4
> +
> +struct jz4780_rng {
> +       struct device *dev;
> +       struct hwrng rng;
> +       void __iomem *mem;
> +};
> +
> +static u32 jz4780_rng_readl(struct jz4780_rng *rng, u32 offset)
> +{
> +       return readl(rng->mem + offset);
> +}
> +
> +static void jz4780_rng_writel(struct jz4780_rng *rng, u32 val, u32 offset)
> +{
> +       writel(val, rng->mem + offset);
> +}
> +
> +static int jz4780_rng_read(struct hwrng *rng, void *buf, size_t max, bool wait)
> +{
> +       struct jz4780_rng *jz4780_rng = container_of(rng, struct jz4780_rng,
> +                                                       rng);
> +       u32 *data = buf;
> +       *data = jz4780_rng_readl(jz4780_rng, REG_RNG_DATA);
> +       return 4;
> +}
> +
> +static int jz4780_rng_probe(struct platform_device *pdev)
> +{
> +       struct jz4780_rng *jz4780_rng;
> +       struct resource *res;
> +       resource_size_t size;
> +       int ret;
> +
> +       jz4780_rng = devm_kzalloc(&pdev->dev, sizeof(struct jz4780_rng),
> +                                       GFP_KERNEL);
> +       if (!jz4780_rng)
> +               return -ENOMEM;
> +
> +       jz4780_rng->dev = &pdev->dev;
> +       jz4780_rng->rng.name = "jz4780";
> +       jz4780_rng->rng.read = jz4780_rng_read;
> +
> +       res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +       size = resource_size(res);
> +
> +       jz4780_rng->mem = devm_ioremap(&pdev->dev, res->start, size);
> +       if (IS_ERR(jz4780_rng->mem))
> +               return PTR_ERR(jz4780_rng->mem);
> +
> +       platform_set_drvdata(pdev, jz4780_rng);
> +       jz4780_rng_writel(jz4780_rng, 1, REG_RNG_CTRL);
> +       ret = hwrng_register(&jz4780_rng->rng);
> +
> +       return ret;
> +}
> +
> +static int jz4780_rng_remove(struct platform_device *pdev)
> +{
> +       struct jz4780_rng *jz4780_rng = platform_get_drvdata(pdev);
> +
> +       jz4780_rng_writel(jz4780_rng, 0, REG_RNG_CTRL);
> +       hwrng_unregister(&jz4780_rng->rng);
> +
> +       return 0;
> +}
> +
> +static const struct of_device_id jz4780_rng_dt_match[] = {
> +       { .compatible = "ingenic,jz4780-rng", },
> +       { },
> +};
> +MODULE_DEVICE_TABLE(of, jz4780_rng_dt_match);
> +
> +static struct platform_driver jz4780_rng_driver = {
> +       .driver         = {
> +               .name   = "jz4780-rng",
> +               .of_match_table = jz4780_rng_dt_match,
> +       },
> +       .probe          = jz4780_rng_probe,
> +       .remove         = jz4780_rng_remove,
> +};
> +module_platform_driver(jz4780_rng_driver);
> +
> +MODULE_DESCRIPTION("Ingenic JZ4780 H/W Random Number Generator driver");
> +MODULE_AUTHOR("PrasannaKumar Muralidharan <prasannatsmkumar@gmail.com>");
> +MODULE_LICENSE("GPL");
> --

Please forgive my ignorance Prasanna...

For the JZ4780 I have, there are two registers in play. The first is
the control register which enables/disables the RNG. The control
register is named ERNG. The second register is the data register, and
it produces the random stream. The data register is named RNG. ERNG is
located at 0x100000D8 and RNG is located at 0x100000DC. This kind of
confuses me because I don't see where 0x100000D8 is ever added to
those values (maybe its in the descriptor?):

+#define REG_RNG_CTRL   0x0
+#define REG_RNG_DATA   0x4


Also, testing with a userland PoC for the device, you have to throttle
reads from RNG register. If reads occur with a 0 delay, then the
random value appears fixed. If the delay is too small, then you can
watch random values being shifted-in in a barrel like fashion.
Unfortunately, the manual did not discuss how long to wait for a value
to be ready. I found spinning in a loop for 5000 was too small and
witnessed the shifting; while spinning in a loop for 10000 avoided the
shift observation. I don't what number of JIFFIES that translates to.


Finally, from looking at the native Ingenic driver (which was not very
impressive), they enabled/disabled the RNG register on demand. There
was also a [possible related] note in the manual about not applying
VCC for over a second. I can only say "possibly related" because I was
not sure if the register was part of the controller they were
discussing. The userland PoC worked fine when enabling/disabling the
RNG register. So I'm not sure about this (from jz4780_rng_probe):

+       platform_set_drvdata(pdev, jz4780_rng);
+       jz4780_rng_writel(jz4780_rng, 1, REG_RNG_CTRL);
+       ret = hwrng_register(&jz4780_rng->rng);

And this (from jz4780_rng_remove):

+       jz4780_rng_writel(jz4780_rng, 0, REG_RNG_CTRL);
+       hwrng_unregister(&jz4780_rng->rng);

Anyway, I hope that helps you avoid some land mines (if they are present).

Jeff
