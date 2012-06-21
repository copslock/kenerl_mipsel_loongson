Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 21 Jun 2012 09:35:27 +0200 (CEST)
Received: from mail-yx0-f177.google.com ([209.85.213.177]:44230 "EHLO
        mail-yx0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903465Ab2FUHfV (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 21 Jun 2012 09:35:21 +0200
Received: by yenr9 with SMTP id r9so229651yen.36
        for <multiple recipients>; Thu, 21 Jun 2012 00:35:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=hSr0miyH16wNzmjXevPO7uG8ALJpwK5MC1mIBo1IsHU=;
        b=I0e/umFM+BUlJrfVTDaGDLazsImSH+v8LfuS21L/Z2SzmOD9Kt7foaHIkgDGlX32SS
         CB/KBTa5Glc247Tk39vauN0deUrUMHcXhWtMMvru4NvbG374wDhlJ4LH4YXuduMgpnjR
         nvqB8bSgnOZDvEMLhJShPKRk6yvnrGg243y6AegWpQHhL5Tnb/6Lvvrs0V9VbtR5KaU6
         7q+gbCNJ/2XMFdl4z/A+1+bF2vNT3Zy5tnKp2toUrpu2mQ+LOp337wJzKBuAYaHt/mPt
         MzIZ7Wu5UlAGNpZvizTAlDA2zR+H2yeux9uGVve3k+VjiBw+/3A3i+aSaheSGkEdR/s8
         JGTg==
Received: by 10.50.216.234 with SMTP id ot10mr6625545igc.51.1340264114326;
 Thu, 21 Jun 2012 00:35:14 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.64.42.197 with HTTP; Thu, 21 Jun 2012 00:34:54 -0700 (PDT)
In-Reply-To: <20120620192551.GC29446@linux-mips.org>
References: <1339757617-2187-1-git-send-email-keguang.zhang@gmail.com>
 <1339757617-2187-3-git-send-email-keguang.zhang@gmail.com> <20120620192551.GC29446@linux-mips.org>
From:   Kelvin Cheung <keguang.zhang@gmail.com>
Date:   Thu, 21 Jun 2012 15:34:54 +0800
Message-ID: <CAJhJPsV2D3xVbA93OpaB8mN6Vs64EmWjxhCbpCMBA5r+wx8mnQ@mail.gmail.com>
Subject: Re: [PATCH V7 2/4] MIPS: Add board support for Loongson1B
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
        wuzhangjin@gmail.com, zhzhl555@gmail.com
Content-Type: multipart/alternative; boundary=f46d040167a9708b3104c2f68e59
X-archive-position: 33750
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

--f46d040167a9708b3104c2f68e59
Content-Type: text/plain; charset=ISO-8859-1

2012/6/21 Ralf Baechle <ralf@linux-mips.org>

> On Fri, Jun 15, 2012 at 06:53:35PM +0800, Kelvin Cheung wrote:
>
> > +#include <linux/clk.h>
>
> > +static LIST_HEAD(clocks);
> > +static DEFINE_MUTEX(clocks_mutex);
> > +
> > +struct clk *clk_get(struct device *dev, const char *name)
> > +{
> > +     struct clk *c;
> > +     struct clk *ret = NULL;
> > +
> > +     mutex_lock(&clocks_mutex);
> > +     list_for_each_entry(c, &clocks, node) {
> > +             if (!strcmp(c->name, name)) {
> > +                     ret = c;
> > +                     break;
> > +             }
> > +     }
> > +     mutex_unlock(&clocks_mutex);
> > +
> > +     return ret;
> > +}
> > +EXPORT_SYMBOL(clk_get);
>
> This redefines a function that already is declared in <linux/clk.h> and
> defined in drivers/clk/clkdev.c.  Why?
>

My intention is to provide minimum clock support,
just as other platforms (bcm63xx, jz4740, etc) did.
Is that OK?


>
> > +int clk_register(struct clk *clk)
> > +{
> > +     mutex_lock(&clocks_mutex);
> > +     list_add(&clk->node, &clocks);
> > +     if (clk->ops->init)
> > +             clk->ops->init(clk);
> > +     mutex_unlock(&clocks_mutex);
> > +
> > +     return 0;
> > +}
> > +EXPORT_SYMBOL(clk_register);
>
> Same here.
>
> > diff --git a/arch/mips/loongson1/common/prom.c
> b/arch/mips/loongson1/common/prom.c
> > new file mode 100644
> > index 0000000..1f8e49f
> > --- /dev/null
> > +++ b/arch/mips/loongson1/common/prom.c
> > @@ -0,0 +1,87 @@
> > +/*
> > + * Copyright (c) 2011 Zhang, Keguang <keguang.zhang@gmail.com>
> > + *
> > + * Modified from arch/mips/pnx833x/common/prom.c.
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
> > +#include <linux/serial_reg.h>
> > +#include <asm/bootinfo.h>
> > +
> > +#include <loongson1.h>
> > +#include <prom.h>
> > +
> > +int prom_argc;
> > +char **prom_argv, **prom_envp;
> > +unsigned long memsize, highmemsize;
> > +
> > +char *prom_getenv(char *envname)
> > +{
> > +     char **env = prom_envp;
> > +     int i;
> > +
> > +     i = strlen(envname);
> > +
> > +     while (*env) {
> > +             if (strncmp(envname, *env, i) == 0 && *(*env+i) == '=')
> > +                     return *env + i + 1;
> > +             env++;
> > +     }
> > +
> > +     return 0;
> > +}
> [...]
>
> Please take a look at sjhill's firmware cleanup patchset which is going to
> remove a fair chunk of duplication of firmware related code.
>
> This is just a heads up; you need to do nothing because that patchset is
> not
> applied yet.)
>

Yes, I have noticed those patches.
I will make changes on my code accordingly once those patches are accepted.


>
> > +const char *get_system_type(void)
> > +{
> > +     unsigned int processor_id = (&current_cpu_data)->processor_id;
> > +
> > +     switch (processor_id & PRID_REV_MASK) {
> > +     case PRID_REV_LOONGSON1B:
> > +             return "LOONGSON LS1B";
> > +     default:
> > +             return "LOONGSON (unknown)";
> > +     }
> > +}
>
> You probably should return a string identifying the system, not the SOC
> being used.  So this function should probably go to board.c.
>

Here, I just want to return the SOC type, not system.
Perhaps, another CPU, for example, Loongson1A will be added in the future.
So this function should probably stay in common/setup.c.


>
> > diff --git a/arch/mips/loongson1/ls1b/board.c
> b/arch/mips/loongson1/ls1b/board.c
> > new file mode 100644
> > index 0000000..1ec350d
> > --- /dev/null
> > +++ b/arch/mips/loongson1/ls1b/board.c
> > @@ -0,0 +1,39 @@
> > +/*
> > + * Copyright (c) 2011 Zhang, Keguang <keguang.zhang@gmail.com>
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
> > +#include <platform.h>
> > +
> > +#include <linux/serial_8250.h>
> > +#include <loongson1.h>
> > +
> > +static struct platform_device *ls1b_platform_devices[] __initdata = {
> > +     &ls1x_uart_device,
> > +#if IS_ENABLED(CONFIG_STMMAC_ETH)
> > +     &ls1x_eth0_device,
> > +#endif
> > +#if IS_ENABLED(CONFIG_USB_EHCI_HCD)
> > +     &ls1x_ehci_device,
> > +#endif
> > +#if IS_ENABLED(CONFIG_RTC_DRV_LOONGSON1)
> > +     &ls1x_rtc_device,
> > +#endif
> > +};
>
> Don't ifdef the platform devices.  The platform devices should always
> be registered if a system actually has the underlying hardware.  If the
> driver has been compiled or not does not matter.
>

OK, I will fix this later.


>
> And the final plug - take a look at FDT for a future revision of this
> code :)
>
>
Yes, I am aware that the FDT is the final target.
But PMON which is the bootloader of Loongson CPU does not support FDT at
present.
I will remember this.


>  Ralf
>



-- 
Best Regards!
Kelvin

--f46d040167a9708b3104c2f68e59
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<br><br><div class=3D"gmail_quote">2012/6/21 Ralf Baechle <span dir=3D"ltr"=
>&lt;<a href=3D"mailto:ralf@linux-mips.org" target=3D"_blank">ralf@linux-mi=
ps.org</a>&gt;</span><br><blockquote class=3D"gmail_quote" style=3D"margin:=
0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">

On Fri, Jun 15, 2012 at 06:53:35PM +0800, Kelvin Cheung wrote:<br>
<br>
&gt; +#include &lt;linux/clk.h&gt;<br>
<div class=3D"im"><br>
&gt; +static LIST_HEAD(clocks);<br>
&gt; +static DEFINE_MUTEX(clocks_mutex);<br>
&gt; +<br>
&gt; +struct clk *clk_get(struct device *dev, const char *name)<br>
&gt; +{<br>
&gt; + =A0 =A0 struct clk *c;<br>
&gt; + =A0 =A0 struct clk *ret =3D NULL;<br>
&gt; +<br>
&gt; + =A0 =A0 mutex_lock(&amp;clocks_mutex);<br>
&gt; + =A0 =A0 list_for_each_entry(c, &amp;clocks, node) {<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 if (!strcmp(c-&gt;name, name)) {<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D c;<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 }<br>
&gt; + =A0 =A0 }<br>
&gt; + =A0 =A0 mutex_unlock(&amp;clocks_mutex);<br>
&gt; +<br>
&gt; + =A0 =A0 return ret;<br>
&gt; +}<br>
&gt; +EXPORT_SYMBOL(clk_get);<br>
<br>
</div>This redefines a function that already is declared in &lt;linux/clk.h=
&gt; and<br>
defined in drivers/clk/clkdev.c. =A0Why?<br></blockquote><div><br>My intent=
ion is to provide minimum clock support,<br>just as other platforms (bcm63x=
x, jz4740, etc) did.<br>Is that OK?<br>=A0</div><blockquote class=3D"gmail_=
quote" style=3D"margin:0pt 0pt 0pt 0.8ex;border-left:1px solid rgb(204,204,=
204);padding-left:1ex">


<div class=3D"im"><br>
&gt; +int clk_register(struct clk *clk)<br>
&gt; +{<br>
&gt; + =A0 =A0 mutex_lock(&amp;clocks_mutex);<br>
&gt; + =A0 =A0 list_add(&amp;clk-&gt;node, &amp;clocks);<br>
&gt; + =A0 =A0 if (clk-&gt;ops-&gt;init)<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 clk-&gt;ops-&gt;init(clk);<br>
&gt; + =A0 =A0 mutex_unlock(&amp;clocks_mutex);<br>
&gt; +<br>
&gt; + =A0 =A0 return 0;<br>
&gt; +}<br>
&gt; +EXPORT_SYMBOL(clk_register);<br>
<br>
</div>Same here.<br>
<div><div class=3D"h5"><br>
&gt; diff --git a/arch/mips/loongson1/common/prom.c b/arch/mips/loongson1/c=
ommon/prom.c<br>
&gt; new file mode 100644<br>
&gt; index 0000000..1f8e49f<br>
&gt; --- /dev/null<br>
&gt; +++ b/arch/mips/loongson1/common/prom.c<br>
&gt; @@ -0,0 +1,87 @@<br>
&gt; +/*<br>
&gt; + * Copyright (c) 2011 Zhang, Keguang &lt;<a href=3D"mailto:keguang.zh=
ang@gmail.com">keguang.zhang@gmail.com</a>&gt;<br>
&gt; + *<br>
&gt; + * Modified from arch/mips/pnx833x/common/prom.c.<br>
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
&gt; +#include &lt;linux/serial_reg.h&gt;<br>
&gt; +#include &lt;asm/bootinfo.h&gt;<br>
&gt; +<br>
&gt; +#include &lt;loongson1.h&gt;<br>
&gt; +#include &lt;prom.h&gt;<br>
&gt; +<br>
&gt; +int prom_argc;<br>
&gt; +char **prom_argv, **prom_envp;<br>
&gt; +unsigned long memsize, highmemsize;<br>
&gt; +<br>
&gt; +char *prom_getenv(char *envname)<br>
&gt; +{<br>
&gt; + =A0 =A0 char **env =3D prom_envp;<br>
&gt; + =A0 =A0 int i;<br>
&gt; +<br>
&gt; + =A0 =A0 i =3D strlen(envname);<br>
&gt; +<br>
&gt; + =A0 =A0 while (*env) {<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 if (strncmp(envname, *env, i) =3D=3D 0 &amp;=
&amp; *(*env+i) =3D=3D &#39;=3D&#39;)<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return *env + i + 1;<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 env++;<br>
&gt; + =A0 =A0 }<br>
&gt; +<br>
&gt; + =A0 =A0 return 0;<br>
&gt; +}<br>
</div></div>[...]<br>
<br>
Please take a look at sjhill&#39;s firmware cleanup patchset which is going=
 to<br>
remove a fair chunk of duplication of firmware related code.<br>
<br>
This is just a heads up; you need to do nothing because that patchset is no=
t<br>
applied yet.)<br></blockquote><div><br>Yes, I have noticed those patches.<b=
r>I will make changes on my code accordingly once those patches are accepte=
d.<br>=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0pt 0pt 0p=
t 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">


<div class=3D"im"><br>
&gt; +const char *get_system_type(void)<br>
&gt; +{<br>
&gt; + =A0 =A0 unsigned int processor_id =3D (&amp;current_cpu_data)-&gt;pr=
ocessor_id;<br>
&gt; +<br>
&gt; + =A0 =A0 switch (processor_id &amp; PRID_REV_MASK) {<br>
&gt; + =A0 =A0 case PRID_REV_LOONGSON1B:<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 return &quot;LOONGSON LS1B&quot;;<br>
&gt; + =A0 =A0 default:<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 return &quot;LOONGSON (unknown)&quot;;<br>
&gt; + =A0 =A0 }<br>
&gt; +}<br>
<br>
</div>You probably should return a string identifying the system, not the S=
OC<br>
being used. =A0So this function should probably go to board.c.<br></blockqu=
ote><div><br>Here, I just want to return the SOC type, not system.<br>Perha=
ps, another CPU, for example, Loongson1A will be added in the future.<br>

So this function should probably stay in common/setup.c.<br>=A0</div><block=
quote class=3D"gmail_quote" style=3D"margin:0pt 0pt 0pt 0.8ex;border-left:1=
px solid rgb(204,204,204);padding-left:1ex">
<div><div class=3D"h5"><br>
&gt; diff --git a/arch/mips/loongson1/ls1b/board.c b/arch/mips/loongson1/ls=
1b/board.c<br>
&gt; new file mode 100644<br>
&gt; index 0000000..1ec350d<br>
&gt; --- /dev/null<br>
&gt; +++ b/arch/mips/loongson1/ls1b/board.c<br>
&gt; @@ -0,0 +1,39 @@<br>
&gt; +/*<br>
&gt; + * Copyright (c) 2011 Zhang, Keguang &lt;<a href=3D"mailto:keguang.zh=
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
&gt; +#include &lt;platform.h&gt;<br>
&gt; +<br>
&gt; +#include &lt;linux/serial_8250.h&gt;<br>
&gt; +#include &lt;loongson1.h&gt;<br>
&gt; +<br>
&gt; +static struct platform_device *ls1b_platform_devices[] __initdata =3D=
 {<br>
&gt; + =A0 =A0 &amp;ls1x_uart_device,<br>
&gt; +#if IS_ENABLED(CONFIG_STMMAC_ETH)<br>
&gt; + =A0 =A0 &amp;ls1x_eth0_device,<br>
&gt; +#endif<br>
&gt; +#if IS_ENABLED(CONFIG_USB_EHCI_HCD)<br>
&gt; + =A0 =A0 &amp;ls1x_ehci_device,<br>
&gt; +#endif<br>
&gt; +#if IS_ENABLED(CONFIG_RTC_DRV_LOONGSON1)<br>
&gt; + =A0 =A0 &amp;ls1x_rtc_device,<br>
&gt; +#endif<br>
&gt; +};<br>
<br>
</div></div>Don&#39;t ifdef the platform devices. =A0The platform devices s=
hould always<br>
be registered if a system actually has the underlying hardware. =A0If the<b=
r>
driver has been compiled or not does not matter.<br></blockquote><div><br>O=
K, I will fix this later.<br>=A0</div><blockquote class=3D"gmail_quote" sty=
le=3D"margin:0pt 0pt 0pt 0.8ex;border-left:1px solid rgb(204,204,204);paddi=
ng-left:1ex">


<br>
And the final plug - take a look at FDT for a future revision of this<br>
code :)<br>
<span class=3D"HOEnZb"><font color=3D"#888888"><br></font></span></blockquo=
te><div><br>Yes, I am aware that the FDT is the final target.<br>But PMON w=
hich is the bootloader of Loongson CPU does not support FDT at present.<br>

I will remember this.<br>=A0</div><blockquote class=3D"gmail_quote" style=
=3D"margin:0pt 0pt 0pt 0.8ex;border-left:1px solid rgb(204,204,204);padding=
-left:1ex"><span class=3D"HOEnZb"><font color=3D"#888888">
 =A0Ralf<br>
</font></span></blockquote></div><br><br clear=3D"all"><br>-- <br>Best Rega=
rds!<br>Kelvin<br><br><img src=3D"http://ubuntucounter.geekosophical.net/im=
g/ubuntu-blogger.php?user=3D26540"><br><br>

--f46d040167a9708b3104c2f68e59--
