Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 08 May 2012 15:21:47 +0200 (CEST)
Received: from mail-yx0-f177.google.com ([209.85.213.177]:41979 "EHLO
        mail-yx0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903636Ab2EHNVj convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 8 May 2012 15:21:39 +0200
Received: by yenr9 with SMTP id r9so3233628yen.36
        for <linux-mips@linux-mips.org>; Tue, 08 May 2012 06:21:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding:x-gm-message-state;
        bh=DErMd9HjGuxGJnUUQ4UfLaCRGoJ/rEk1o+Fx33hzhyU=;
        b=QR3aTBtLUou4OP+wRNxcaZj/gPZM9NgQpFnGwqCuQPt2XDZxQ848KLggkGewCRsDEa
         zUKEkLtrG25jyBJPHYFN6iJtjaaK0wCs2Z6pSNySv6T56w+X7JvY92M0HreHgAJD2O/2
         lZSGxOp8pcHqdA314r2ZJkYaY+HfFEBWH4kNYypMDkd3cew6yUxs4Od8Qpy4We82nU1u
         i4VhDZ3pV/CazVl9k/0OUV0/QN0ZHg0KA/5CHSNPnyYf9DL+eDXTi+/gxvBEobdkhyFL
         DbsatqGeGFe1z178YjAmga8X4sv30YyphiQIvlWhZ7rKO0ZzrRXE819Qone1yw/0V2Vj
         wPrQ==
MIME-Version: 1.0
Received: by 10.236.192.198 with SMTP id i46mr24441971yhn.22.1336483293235;
 Tue, 08 May 2012 06:21:33 -0700 (PDT)
Received: by 10.236.115.164 with HTTP; Tue, 8 May 2012 06:21:33 -0700 (PDT)
In-Reply-To: <1336133919-26525-4-git-send-email-blogic@openwrt.org>
References: <1336133919-26525-1-git-send-email-blogic@openwrt.org>
        <1336133919-26525-4-git-send-email-blogic@openwrt.org>
Date:   Tue, 8 May 2012 15:21:33 +0200
Message-ID: <CACRpkdYJDd84GbKM7r4Xy+d4iOtdD+rJ3kdq-zwVbf_Attj2Gw@mail.gmail.com>
Subject: Re: [PATCH 04/14] OF: pinctrl: MIPS: lantiq: implement lantiq/xway
 pinctrl support
From:   Linus Walleij <linus.walleij@linaro.org>
To:     John Crispin <blogic@openwrt.org>
Cc:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        devicetree-discuss@lists.ozlabs.org,
        Stephen Warren <swarren@wwwdotorg.org>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
X-Gm-Message-State: ALoCoQlo6rNUZP2XwSC+/BUNOatPoqE5+hoeQWCXWXeHFK/IRsTvaRzUlQ832AnfBul4cVyAHqGh
X-archive-position: 33212
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: linus.walleij@linaro.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

On Fri, May 4, 2012 at 2:18 PM, John Crispin <blogic@openwrt.org> wrote:

> Implement support for pinctrl on lantiq/xway socs. The IO core found on these
> socs has the registers for pinctrl, pinconf and gpio mixed up in the same
> register range. As the gpio_chip handling is only a few lines, the driver also
> implements the gpio functionality. This obseletes the old gpio driver that was
> located in the arch/ folder.
>
> Signed-off-by: John Crispin <blogic@openwrt.org>
> Cc: devicetree-discuss@lists.ozlabs.org
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: Stephen Warren <swarren@wwwdotorg.org>

Overall this is looking very good and a positive development for these SoCs.

Nitpicking below.

> --- a/arch/mips/Kconfig
> +++ b/arch/mips/Kconfig
> @@ -216,6 +216,7 @@ config MACH_JZ4740
>  config LANTIQ
>        bool "Lantiq based platforms"
>        select DMA_NONCOHERENT
> +       select PINCTRL

Shouldn't this be:
select PINCTRL
select PINCTRL_LANTIQ

?

> diff --git a/arch/mips/lantiq/Kconfig b/arch/mips/lantiq/Kconfig
> index 9485fe5..b86d942 100644
> --- a/arch/mips/lantiq/Kconfig
> +++ b/arch/mips/lantiq/Kconfig
> @@ -2,6 +2,7 @@ if LANTIQ
>
>  config SOC_TYPE_XWAY
>        bool
> +       select PINCTRL_XWAY
>        default n

OK...

> -obj-y := prom.o pmu.o ebu.o reset.o gpio.o gpio_stp.o gpio_ebu.o dma.o
> +obj-y := prom.o pmu.o ebu.o reset.o gpio_stp.o gpio_ebu.o dma.o

Yeah good riddance :-)

> diff --git a/drivers/pinctrl/Kconfig b/drivers/pinctrl/Kconfig
> index f73a5ea..a19bac96 100644
> --- a/drivers/pinctrl/Kconfig
> +++ b/drivers/pinctrl/Kconfig
> @@ -30,6 +30,11 @@ config PINCTRL_PXA3xx
>        bool
>        select PINMUX
>
> +config PINCTRL_LANTIQ
> +       bool
> +       select PINMUX
> +       select PINCONF

depends on LANTIQ

?

I don't think anyone else is going to want to compile
this.

> +
>  config PINCTRL_MMP2
>        bool "MMP2 pin controller driver"
>        depends on ARCH_MMP
> @@ -83,6 +88,10 @@ config PINCTRL_COH901
>          COH 901 335 and COH 901 571/3. They contain 3, 5 or 7
>          ports of 8 GPIO pins each.
>
> +config PINCTRL_XWAY
> +       bool
> +       select PINCTRL_LANTIQ

Shouldn't this be:

depends on SOC_TYPE_XWAY
depends on PINCTRL_LANTIQ

?

So LANTIQ selects it's pinctrl driver, the the xway SoC
selects its driver and they both are dependent on their
respective system.

> diff --git a/drivers/pinctrl/pinctrl-lantiq.h b/drivers/pinctrl/pinctrl-lantiq.h

> +#define ARRAY_AND_SIZE(x)      (x), ARRAY_SIZE(x)

Hm if we redefine this I start to wonder if this
should go into <linux/kernel.h>

No big deal, we can alsway refactor later.

> +#define LTQ_PINCONF_PACK(_param_, _arg_)       ((_param_) << 16 | (_arg_))
> +#define LTQ_PINCONF_UNPACK_PARAM(_conf_)       ((_conf_) >> 16)
> +#define LTQ_PINCONF_UNPACK_ARG(_conf_)         ((_conf_) & 0xffff)

No need to add _underscores_ around the macro parameters?
I've not seen any coding convention requiring this.

> +struct ltq_pinmux_info {
> +       struct device *dev;
> +       struct pinctrl_dev *pctrl;
> +
> +       /* we need to manage up to 5 padcontrolers */

controllers

> +       void __iomem *membase[5];
> +
> +       /* the handler for the subsystem */
> +       struct pinctrl_desc *desc;

It's a descriptor not a handler.

> +       /* we expose our pads to the subsystem */
> +       struct pinctrl_pin_desc *pads;
> +
> +       /* the number of pads. this varies between socs */
> +       unsigned int num_gpio;

Why not call it num_pads, atleast use the same name for
the array and the count.

> +       /* these are our multifunction pins */
> +       const struct ltq_mfp_pin *mfp;
> +       unsigned int num_mfp;
> +
> +       /* a number of multifunction pins can be grouped together */
> +       const struct ltq_pin_group *grps;
> +       unsigned int num_grps;
> +
> +       /* a mapping between function string and id */
> +       const struct ltq_pmx_func *funcs;
> +       unsigned int num_funcs;
> +
> +       /* the pinconf options that we are able to read from the DT */
> +       const struct ltq_cfg_param *params;
> +       unsigned int num_params;
> +
> +       /* soc specific callback used to apply muxing */
> +       int (*apply_mux)(struct pinctrl_dev *pctrldev, int pin, int mux);
> +};
>
> +enum ltq_pin_list {
> +       GPIO0 = 0,
> +       GPIO1,

Wait, this enum is called something ending with _list but it's not
a list, it's a pin. The enum is like a type, so should define the basic
unit we're dealing with, not a collection of such units, so rename it
"ltq_pin" simply.

You could also consider using:
#define GPIO0 0
#define GPIO1 1

etc like some other drivers do. (Your pick.)

> diff --git a/drivers/pinctrl/pinctrl-xway.c b/drivers/pinctrl/pinctrl-xway.c

> +/* macros to help us access the registers */
> +#define gpio_getbit(m, r, p)   (!!(ltq_r32(m + r) & (1 << p)))
> +#define gpio_setbit(m, r, p)   ltq_w32_mask(0, (1 << p), m + r)
> +#define gpio_clearbit(m, r, p) ltq_w32_mask((1 << p), 0, m + r)

So what makes this arch so fantastic that it needs its own read/write functions?
(Just curious...)

You could replace (1 << p) with BIT(p) by using <linux/bitops.h>

> +       {"pci",         ARRAY_AND_SIZE(xrx_pci_grps)},
> +       {"ebu",         ARRAY_AND_SIZE(xrx_ebu_grps)},
> +};
> +
> +
> +
> +
> +
> +

You can never get enough whitespace :-)

Please trim it down...

> +/* ---------  pinconf related code --------- */
> +static int xway_pinconf_group_get(struct pinctrl_dev *pctldev,
> +                               unsigned group,
> +                               unsigned long *config)
> +{
> +       return -ENOTSUPP;
> +}
> +
> +static int xway_pinconf_group_set(struct pinctrl_dev *pctldev,
> +                               unsigned group,
> +                               unsigned long config)
> +{
> +       return -ENOTSUPP;
> +}

Just don't define these function pointers and leave callbacks as NULL.
The pinctrl core should handle this and if it doesn't, patch the core
in pinconf.c.

> +static void xway_pinconf_dbg_show(struct pinctrl_dev *pctldev,
> +                                       struct seq_file *s, unsigned offset)
> +{
> +}
> +
> +static void xway_pinconf_group_dbg_show(struct pinctrl_dev *pctldev,
> +                                       struct seq_file *s, unsigned selector)
> +{
> +}

Just don't define them if you don't use them, leave pointers as NULL.

These are however good for verbose pretty-printing the pins/groups
hardware state.

> +static inline int xway_mux_apply(struct pinctrl_dev *pctrldev,
> +                               int pin, int mux)
> +{
> +       struct ltq_pinmux_info *info = pinctrl_dev_get_drvdata(pctrldev);
> +       int port = PORT(pin);
> +
> +       if (mux & 0x1)
> +               gpio_setbit(info->membase[0], GPIO_ALT0(pin), PORT_PIN(pin));
> +       else
> +               gpio_clearbit(info->membase[0], GPIO_ALT0(pin), PORT_PIN(pin));
> +
> +       if ((port == 3) && (mux & 0x2))
> +               gpio_setbit(info->membase[0], GPIO3_ALT1, PORT_PIN(pin));
> +       else if (mux & 0x2)
> +               gpio_setbit(info->membase[0], GPIO_ALT1(pin), PORT_PIN(pin));
> +       else if (port == 3)
> +               gpio_clearbit(info->membase[0], GPIO3_ALT1, PORT_PIN(pin));
> +       else
> +               gpio_clearbit(info->membase[0], GPIO_ALT1(pin), PORT_PIN(pin));
> +
> +       return 0;
> +}

Please introduce some #defines for the magic numbers used above:

0x1, 3, 0x2, 3, etc so we can easily figure out what's going on.

> +static struct ltq_pinmux_info xway_info = {
> +       .mfp            = xway_mfp,
> +       .desc           = &xway_pctrl_desc,
> +       .apply_mux      = xway_mux_apply,
> +       .params         = xway_cfg_params,
> +       .num_params     = ARRAY_SIZE(xway_cfg_params),
> +};
> +
> +
> +
> +

Whitespacey...

> +/* ---------  gpio_chip related code --------- */
> +
> +int gpio_to_irq(unsigned int gpio)
> +{
> +       return -EINVAL;
> +}
> +EXPORT_SYMBOL(gpio_to_irq);
> +
> +int irq_to_gpio(unsigned int gpio)
> +{
> +       return -EINVAL;
> +}
> +EXPORT_SYMBOL(irq_to_gpio);

Can't you just leave them undefined?

> +static struct gpio_chip xway_chip = {
> +       .label = "gpio-xway",
> +       .direction_input = xway_gpio_dir_in,
> +       .direction_output = xway_gpio_dir_out,
> +       .get = xway_gpio_get,
> +       .set = xway_gpio_set,
> +       .request = xway_gpio_req,
> +       .free = xway_gpio_free,
> +       .base = 0,
> +};
> +
> +
> +
> +

Whitespace.

Yours,
Linus Walleij
