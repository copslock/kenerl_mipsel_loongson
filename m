Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 18 Aug 2012 13:54:35 +0200 (CEST)
Received: from mail-vb0-f49.google.com ([209.85.212.49]:60399 "EHLO
        mail-vb0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1902232Ab2HRLyb (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 18 Aug 2012 13:54:31 +0200
Received: by vbbfo1 with SMTP id fo1so4388642vbb.36
        for <linux-mips@linux-mips.org>; Sat, 18 Aug 2012 04:54:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=pmU5TvP9sVltismhV4eN1kdesb4dKaNTVrHqFBQ9KfE=;
        b=FBNPkE3NuPhgz6JW6A5h6wzSHjHdurZ6/zmU3zA6LgDdsiLE4Q9czcBelqVD4uE+vC
         JehP973WqA6aLFn3OHU+8hI6CY9plQrKZA3Hke+oLaZlZX0ZNZiMdy2JAPUMt5Sc2QVZ
         gitXP8kGuW1Qi1mg/CgNdUARnWGq/v9+mE97I3VOsqN0cALrG1MQxBXtpPgZNedLOvju
         5Mlq+Kh0vk1p/BltryKDA2zLQj9M5ccgWTua7ehz2oqbTUtPSuoT9TSOrbL4+J5WigK3
         kORxld9AThm4eEKkeGPfuGoI9HAfGsrs0rkQ9HauFIPmG9SEzsMycR6/uSYP/YcPa3XV
         6lpw==
Received: by 10.221.11.197 with SMTP id pf5mr5218745vcb.29.1345290864211; Sat,
 18 Aug 2012 04:54:24 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.220.77.130 with HTTP; Sat, 18 Aug 2012 04:54:03 -0700 (PDT)
In-Reply-To: <CAAfyv36-wwvSFJGXN9bmDy8pdDOT_h0b7sy78+7f4kCW57AxuA@mail.gmail.com>
References: <1345287301-18165-1-git-send-email-keguang.zhang@gmail.com> <CAAfyv36-wwvSFJGXN9bmDy8pdDOT_h0b7sy78+7f4kCW57AxuA@mail.gmail.com>
From:   Kelvin Cheung <keguang.zhang@gmail.com>
Date:   Sat, 18 Aug 2012 19:54:03 +0800
Message-ID: <CAJhJPsVd_XM2QJnU7teQc4JCEPzp3e-YU5vTvW4Twzs9d--0FA@mail.gmail.com>
Subject: Re: [PATCH] clk: add Loongson1B clock support
To:     Belisko Marek <marek.belisko@gmail.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mips@linux-mips.org, Mike Turquette <mturquette@linaro.org>,
        Russell King <linux@arm.linux.org.uk>
Content-Type: multipart/alternative; boundary=bcaec54ee84a14b5c604c788f0e5
X-archive-position: 34275
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: keguang.zhang@gmail.com
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
Return-Path: <linux-mips-bounce@linux-mips.org>

--bcaec54ee84a14b5c604c788f0e5
Content-Type: text/plain; charset=ISO-8859-1

2012/8/18 Belisko Marek <marek.belisko@gmail.com>

> On Sat, Aug 18, 2012 at 12:55 PM, Kelvin Cheung <keguang.zhang@gmail.com>
> wrote:
> > This adds clock support to Loongson1B SoC using the common clock
> > infrastructure.
> >
> > Signed-off-by: Kelvin Cheung <keguang.zhang@gmail.com>
> > ---
> >  drivers/clk/Makefile   |    1 +
> >  drivers/clk/clk-ls1x.c |  108
> ++++++++++++++++++++++++++++++++++++++++++++++++
> >  2 files changed, 109 insertions(+), 0 deletions(-)
> >  create mode 100644 drivers/clk/clk-ls1x.c
> >
> > diff --git a/drivers/clk/Makefile b/drivers/clk/Makefile
> > index 5869ea3..018ec57 100644
> > --- a/drivers/clk/Makefile
> > +++ b/drivers/clk/Makefile
> > @@ -10,6 +10,7 @@ obj-$(CONFIG_ARCH_SOCFPGA)    += socfpga/
> >  obj-$(CONFIG_PLAT_SPEAR)       += spear/
> >  obj-$(CONFIG_ARCH_U300)                += clk-u300.o
> >  obj-$(CONFIG_ARCH_INTEGRATOR)  += versatile/
> > +obj-$(CONFIG_MACH_LOONGSON1)   += clk-ls1x.o
> >
> >  # Chip specific
> >  obj-$(CONFIG_COMMON_CLK_WM831X) += clk-wm831x.o
> > diff --git a/drivers/clk/clk-ls1x.c b/drivers/clk/clk-ls1x.c
> > new file mode 100644
> > index 0000000..0aadf9d
> > --- /dev/null
> > +++ b/drivers/clk/clk-ls1x.c
> > @@ -0,0 +1,108 @@
> > +/*
> > + * Copyright (c) 2012 Zhang, Keguang <keguang.zhang@gmail.com>
> > + *
> > + * This program is free software; you can redistribute  it and/or
> modify it
> > + * under  the terms of  the GNU General  Public License as published by
> the
> > + * Free Software Foundation;  either version 2 of the  License, or (at
> your
> > + * option) any later version.
> > + */
> > +
> > +#include <linux/clkdev.h>
> > +#include <linux/clk-provider.h>
> > +#include <linux/io.h>
> > +#include <linux/slab.h>
> > +#include <linux/err.h>
> > +#include <asm/mach-loongson1/loongson1.h>
> > +
> > +#include <loongson1.h>
> > +
> > +#define OSC    33
> > +
> > +static DEFINE_SPINLOCK(_lock);
> > +
> > +int ls1x_pll_clk_enable(struct clk_hw *hw)
> ^^^^static
>

OK, will do.
Thanks!


> > +{
> > +       return 0;
> > +}
> > +
> > +void ls1x_pll_clk_disable(struct clk_hw *hw)
> ^^^^ also static
> > +{
> > +}
> > +
> > +static unsigned long ls1x_pll_recalc_rate(struct clk_hw *hw,
> > +                                            unsigned long parent_rate)
> > +{
> > +       u32 pll, rate;
> > +
> > +       pll = __raw_readl(LS1X_CLK_PLL_FREQ);
> > +       rate = ((12 + (pll & 0x3f)) * 1000000) +
> > +               ((((pll >> 8) & 0x3ff) * 1000000) >> 10);
> > +       rate *= OSC;
> > +       rate >>= 1;
> > +
> > +       return rate;
> > +}
> > +
> > +static const struct clk_ops ls1x_pll_clk_ops = {
> > +       .enable = ls1x_pll_clk_enable,
> > +       .disable = ls1x_pll_clk_disable,
> > +       .recalc_rate = ls1x_pll_recalc_rate,
> > +};
> > +
> > +static struct clk * __init clk_register_pll(struct device *dev,
> > +        const char *name, const char *parent_name, unsigned long flags)
> > +{
> > +       struct clk_hw *hw;
> > +       struct clk *clk;
> > +       struct clk_init_data init;
> > +
> > +       /* allocate the divider */
> > +       hw = kzalloc(sizeof(struct clk_hw), GFP_KERNEL);
> > +       if (!hw) {
> > +               pr_err("%s: could not allocate clk_hw\n", __func__);
> > +               return ERR_PTR(-ENOMEM);
> > +       }
> > +
> > +       init.name = name;
> > +       init.ops = &ls1x_pll_clk_ops;
> > +       init.flags = flags | CLK_IS_BASIC;
> > +       init.parent_names = (parent_name ? &parent_name : NULL);
> > +       init.num_parents = (parent_name ? 1 : 0);
> > +       hw->init = &init;
> > +
> > +       /* register the clock */
> > +       clk = clk_register(dev, hw);
> > +
> > +       if (IS_ERR(clk))
> > +               kfree(hw);
> > +
> > +       return clk;
> > +}
> > +
> > +void __init ls1x_clk_init(void)
> > +{
> > +       struct clk *clk;
> > +
> > +       clk = clk_register_pll(NULL, "pll_clk", NULL, CLK_IS_ROOT);
> > +       clk_prepare_enable(clk);
> > +
> > +       clk = clk_register_divider(NULL, "cpu_clk", "pll_clk",
> > +                       CLK_SET_RATE_PARENT, LS1X_CLK_PLL_DIV,
> DIV_CPU_SHIFT,
> > +                       DIV_CPU_WIDTH, CLK_DIVIDER_ONE_BASED, &_lock);
> > +       clk_prepare_enable(clk);
> > +       clk_register_clkdev(clk, "cpu", NULL);
> > +
> > +       clk = clk_register_divider(NULL, "ddr_clk", "pll_clk",
> > +                       CLK_SET_RATE_PARENT, LS1X_CLK_PLL_DIV,
> DIV_DDR_SHIFT,
> > +                       DIV_DDR_WIDTH, CLK_DIVIDER_ONE_BASED, &_lock);
> > +       clk_prepare_enable(clk);
> > +       clk_register_clkdev(clk, "ddr", NULL);
> > +       clk_register_clkdev(clk, "stmmaceth", NULL);
> > +
> > +       clk = clk_register_divider(NULL, "dc_clk", "pll_clk",
> > +                       CLK_SET_RATE_PARENT, LS1X_CLK_PLL_DIV,
> DIV_DC_SHIFT,
> > +                       DIV_DC_WIDTH, CLK_DIVIDER_ONE_BASED, &_lock);
> > +       clk_prepare_enable(clk);
> > +       clk_register_clkdev(clk, "dc", NULL);
> > +       clk_register_clkdev(clk, "serial8250", NULL);
> > +}
> > --
> > 1.7.1
> >
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-kernel"
> in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > Please read the FAQ at  http://www.tux.org/lkml/
>
> cheers,
>
> marek
>
> --
> as simple and primitive as possible
> -------------------------------------------------
> Marek Belisko - OPEN-NANDRA
> Freelance Developer
>
> Ruska Nova Ves 219 | Presov, 08005 Slovak Republic
> Tel: +421 915 052 184
> skype: marekwhite
> twitter: #opennandra
> web: http://open-nandra.com
>



-- 
Best Regards!
Kelvin

--bcaec54ee84a14b5c604c788f0e5
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div class=3D"gmail_quote">2012/8/18 Belisko Marek <span dir=3D"ltr">&lt;<a=
 href=3D"mailto:marek.belisko@gmail.com" target=3D"_blank">marek.belisko@gm=
ail.com</a>&gt;</span><br><blockquote class=3D"gmail_quote" style=3D"margin=
:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">

<div class=3D"HOEnZb"><div class=3D"h5">On Sat, Aug 18, 2012 at 12:55 PM, K=
elvin Cheung &lt;<a href=3D"mailto:keguang.zhang@gmail.com">keguang.zhang@g=
mail.com</a>&gt; wrote:<br>
&gt; This adds clock support to Loongson1B SoC using the common clock<br>
&gt; infrastructure.<br>
&gt;<br>
&gt; Signed-off-by: Kelvin Cheung &lt;<a href=3D"mailto:keguang.zhang@gmail=
.com">keguang.zhang@gmail.com</a>&gt;<br>
&gt; ---<br>
&gt; =A0drivers/clk/Makefile =A0 | =A0 =A01 +<br>
&gt; =A0drivers/clk/clk-ls1x.c | =A0108 +++++++++++++++++++++++++++++++++++=
+++++++++++++<br>
&gt; =A02 files changed, 109 insertions(+), 0 deletions(-)<br>
&gt; =A0create mode 100644 drivers/clk/clk-ls1x.c<br>
&gt;<br>
&gt; diff --git a/drivers/clk/Makefile b/drivers/clk/Makefile<br>
&gt; index 5869ea3..018ec57 100644<br>
&gt; --- a/drivers/clk/Makefile<br>
&gt; +++ b/drivers/clk/Makefile<br>
&gt; @@ -10,6 +10,7 @@ obj-$(CONFIG_ARCH_SOCFPGA) =A0 =A0+=3D socfpga/<br>
&gt; =A0obj-$(CONFIG_PLAT_SPEAR) =A0 =A0 =A0 +=3D spear/<br>
&gt; =A0obj-$(CONFIG_ARCH_U300) =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0+=3D clk-u30=
0.o<br>
&gt; =A0obj-$(CONFIG_ARCH_INTEGRATOR) =A0+=3D versatile/<br>
&gt; +obj-$(CONFIG_MACH_LOONGSON1) =A0 +=3D clk-ls1x.o<br>
&gt;<br>
&gt; =A0# Chip specific<br>
&gt; =A0obj-$(CONFIG_COMMON_CLK_WM831X) +=3D clk-wm831x.o<br>
&gt; diff --git a/drivers/clk/clk-ls1x.c b/drivers/clk/clk-ls1x.c<br>
&gt; new file mode 100644<br>
&gt; index 0000000..0aadf9d<br>
&gt; --- /dev/null<br>
&gt; +++ b/drivers/clk/clk-ls1x.c<br>
&gt; @@ -0,0 +1,108 @@<br>
&gt; +/*<br>
&gt; + * Copyright (c) 2012 Zhang, Keguang &lt;<a href=3D"mailto:keguang.zh=
ang@gmail.com">keguang.zhang@gmail.com</a>&gt;<br>
&gt; + *<br>
&gt; + * This program is free software; you can redistribute =A0it and/or m=
odify it<br>
&gt; + * under =A0the terms of =A0the GNU General =A0Public License as publ=
ished by the<br>
&gt; + * Free Software Foundation; =A0either version 2 of the =A0License, o=
r (at your<br>
&gt; + * option) any later version.<br>
&gt; + */<br>
&gt; +<br>
&gt; +#include &lt;linux/clkdev.h&gt;<br>
&gt; +#include &lt;linux/clk-provider.h&gt;<br>
&gt; +#include &lt;linux/io.h&gt;<br>
&gt; +#include &lt;linux/slab.h&gt;<br>
&gt; +#include &lt;linux/err.h&gt;<br>
&gt; +#include &lt;asm/mach-loongson1/loongson1.h&gt;<br>
&gt; +<br>
&gt; +#include &lt;loongson1.h&gt;<br>
&gt; +<br>
&gt; +#define OSC =A0 =A033<br>
&gt; +<br>
&gt; +static DEFINE_SPINLOCK(_lock);<br>
&gt; +<br>
&gt; +int ls1x_pll_clk_enable(struct clk_hw *hw)<br>
</div></div>^^^^static<br></blockquote><div><br>OK, will do.<br>Thanks!<br>=
=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0pt 0pt 0pt 0.8e=
x;border-left:1px solid rgb(204,204,204);padding-left:1ex">
<div class=3D"im">&gt; +{<br>
&gt; + =A0 =A0 =A0 return 0;<br>
&gt; +}<br>
&gt; +<br>
&gt; +void ls1x_pll_clk_disable(struct clk_hw *hw)<br>
</div>^^^^ also static<br>
<div><div class=3D"h5">&gt; +{<br>
&gt; +}<br>
&gt; +<br>
&gt; +static unsigned long ls1x_pll_recalc_rate(struct clk_hw *hw,<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0unsigned long parent_rate)<br>
&gt; +{<br>
&gt; + =A0 =A0 =A0 u32 pll, rate;<br>
&gt; +<br>
&gt; + =A0 =A0 =A0 pll =3D __raw_readl(LS1X_CLK_PLL_FREQ);<br>
&gt; + =A0 =A0 =A0 rate =3D ((12 + (pll &amp; 0x3f)) * 1000000) +<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ((((pll &gt;&gt; 8) &amp; 0x3ff) * 10000=
00) &gt;&gt; 10);<br>
&gt; + =A0 =A0 =A0 rate *=3D OSC;<br>
&gt; + =A0 =A0 =A0 rate &gt;&gt;=3D 1;<br>
&gt; +<br>
&gt; + =A0 =A0 =A0 return rate;<br>
&gt; +}<br>
&gt; +<br>
&gt; +static const struct clk_ops ls1x_pll_clk_ops =3D {<br>
&gt; + =A0 =A0 =A0 .enable =3D ls1x_pll_clk_enable,<br>
&gt; + =A0 =A0 =A0 .disable =3D ls1x_pll_clk_disable,<br>
&gt; + =A0 =A0 =A0 .recalc_rate =3D ls1x_pll_recalc_rate,<br>
&gt; +};<br>
&gt; +<br>
&gt; +static struct clk * __init clk_register_pll(struct device *dev,<br>
&gt; + =A0 =A0 =A0 =A0const char *name, const char *parent_name, unsigned l=
ong flags)<br>
&gt; +{<br>
&gt; + =A0 =A0 =A0 struct clk_hw *hw;<br>
&gt; + =A0 =A0 =A0 struct clk *clk;<br>
&gt; + =A0 =A0 =A0 struct clk_init_data init;<br>
&gt; +<br>
&gt; + =A0 =A0 =A0 /* allocate the divider */<br>
&gt; + =A0 =A0 =A0 hw =3D kzalloc(sizeof(struct clk_hw), GFP_KERNEL);<br>
&gt; + =A0 =A0 =A0 if (!hw) {<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_err(&quot;%s: could not allocate clk_=
hw\n&quot;, __func__);<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return ERR_PTR(-ENOMEM);<br>
&gt; + =A0 =A0 =A0 }<br>
&gt; +<br>
&gt; + =A0 =A0 =A0 <a href=3D"http://init.name" target=3D"_blank">init.name=
</a> =3D name;<br>
&gt; + =A0 =A0 =A0 init.ops =3D &amp;ls1x_pll_clk_ops;<br>
&gt; + =A0 =A0 =A0 init.flags =3D flags | CLK_IS_BASIC;<br>
&gt; + =A0 =A0 =A0 init.parent_names =3D (parent_name ? &amp;parent_name : =
NULL);<br>
&gt; + =A0 =A0 =A0 init.num_parents =3D (parent_name ? 1 : 0);<br>
&gt; + =A0 =A0 =A0 hw-&gt;init =3D &amp;init;<br>
&gt; +<br>
&gt; + =A0 =A0 =A0 /* register the clock */<br>
&gt; + =A0 =A0 =A0 clk =3D clk_register(dev, hw);<br>
&gt; +<br>
&gt; + =A0 =A0 =A0 if (IS_ERR(clk))<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 kfree(hw);<br>
&gt; +<br>
&gt; + =A0 =A0 =A0 return clk;<br>
&gt; +}<br>
&gt; +<br>
&gt; +void __init ls1x_clk_init(void)<br>
&gt; +{<br>
&gt; + =A0 =A0 =A0 struct clk *clk;<br>
&gt; +<br>
&gt; + =A0 =A0 =A0 clk =3D clk_register_pll(NULL, &quot;pll_clk&quot;, NULL=
, CLK_IS_ROOT);<br>
&gt; + =A0 =A0 =A0 clk_prepare_enable(clk);<br>
&gt; +<br>
&gt; + =A0 =A0 =A0 clk =3D clk_register_divider(NULL, &quot;cpu_clk&quot;, =
&quot;pll_clk&quot;,<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 CLK_SET_RATE_PARENT, LS1=
X_CLK_PLL_DIV, DIV_CPU_SHIFT,<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 DIV_CPU_WIDTH, CLK_DIVID=
ER_ONE_BASED, &amp;_lock);<br>
&gt; + =A0 =A0 =A0 clk_prepare_enable(clk);<br>
&gt; + =A0 =A0 =A0 clk_register_clkdev(clk, &quot;cpu&quot;, NULL);<br>
&gt; +<br>
&gt; + =A0 =A0 =A0 clk =3D clk_register_divider(NULL, &quot;ddr_clk&quot;, =
&quot;pll_clk&quot;,<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 CLK_SET_RATE_PARENT, LS1=
X_CLK_PLL_DIV, DIV_DDR_SHIFT,<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 DIV_DDR_WIDTH, CLK_DIVID=
ER_ONE_BASED, &amp;_lock);<br>
&gt; + =A0 =A0 =A0 clk_prepare_enable(clk);<br>
&gt; + =A0 =A0 =A0 clk_register_clkdev(clk, &quot;ddr&quot;, NULL);<br>
&gt; + =A0 =A0 =A0 clk_register_clkdev(clk, &quot;stmmaceth&quot;, NULL);<b=
r>
&gt; +<br>
&gt; + =A0 =A0 =A0 clk =3D clk_register_divider(NULL, &quot;dc_clk&quot;, &=
quot;pll_clk&quot;,<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 CLK_SET_RATE_PARENT, LS1=
X_CLK_PLL_DIV, DIV_DC_SHIFT,<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 DIV_DC_WIDTH, CLK_DIVIDE=
R_ONE_BASED, &amp;_lock);<br>
&gt; + =A0 =A0 =A0 clk_prepare_enable(clk);<br>
&gt; + =A0 =A0 =A0 clk_register_clkdev(clk, &quot;dc&quot;, NULL);<br>
&gt; + =A0 =A0 =A0 clk_register_clkdev(clk, &quot;serial8250&quot;, NULL);<=
br>
&gt; +}<br>
&gt; --<br>
&gt; 1.7.1<br>
&gt;<br>
</div></div>&gt; --<br>
&gt; To unsubscribe from this list: send the line &quot;unsubscribe linux-k=
ernel&quot; in<br>
&gt; the body of a message to <a href=3D"mailto:majordomo@vger.kernel.org">=
majordomo@vger.kernel.org</a><br>
&gt; More majordomo info at =A0<a href=3D"http://vger.kernel.org/majordomo-=
info.html" target=3D"_blank">http://vger.kernel.org/majordomo-info.html</a>=
<br>
&gt; Please read the FAQ at =A0<a href=3D"http://www.tux.org/lkml/" target=
=3D"_blank">http://www.tux.org/lkml/</a><br>
<br>
cheers,<br>
<br>
marek<br>
<span class=3D"HOEnZb"><font color=3D"#888888"><br>
--<br>
as simple and primitive as possible<br>
-------------------------------------------------<br>
Marek Belisko - OPEN-NANDRA<br>
Freelance Developer<br>
<br>
Ruska Nova Ves 219 | Presov, 08005 Slovak Republic<br>
Tel: +421 915 052 184<br>
skype: marekwhite<br>
twitter: #opennandra<br>
web: <a href=3D"http://open-nandra.com" target=3D"_blank">http://open-nandr=
a.com</a><br>
</font></span></blockquote></div><br><br clear=3D"all"><br>-- <br>Best Rega=
rds!<br>Kelvin<br><br><img src=3D"http://ubuntucounter.geekosophical.net/im=
g/ubuntu-blogger.php?user=3D26540"><br><br>

--bcaec54ee84a14b5c604c788f0e5--
