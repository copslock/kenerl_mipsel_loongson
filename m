Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 16 Jan 2009 10:11:13 +0000 (GMT)
Received: from mail-bw0-f13.google.com ([209.85.218.13]:30629 "EHLO
	mail-bw0-f13.google.com") by ftp.linux-mips.org with ESMTP
	id S21365849AbZAPKKd (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 16 Jan 2009 10:10:33 +0000
Received: by bwz6 with SMTP id 6so4443133bwz.0
        for <multiple recipients>; Fri, 16 Jan 2009 02:10:25 -0800 (PST)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:sender:received:in-reply-to
         :references:date:x-google-sender-auth:message-id:subject:from:to:cc
         :content-type;
        bh=dsgDLXtW9cKPTv1SIMBiK5iWWrY7WGkFWapSiH95juM=;
        b=EdUMvDQbNlR8cRxAIeCjUGRyuSjHte/5YdrxQ4/Z6j7N9hsigCkCbG2BiRT5M+lBLv
         I0fCvBPkm/gdFYg1UWTAIYmE/JfAowFrR0f4DFT4ZwVo/GS/sgp6k1Jb7Pa6szty5ESi
         hrov/7Di0oX6OVFLEWi6XjG5FcyQ+Elo5pfa8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type;
        b=ob0WkB6fdd2Hxmk0/p2G2K3pKwVIy0fQiOkRRlHGbC0YQ5SH5aDcou4eAz8tJ1FSTy
         LJGOgHDvonL+S9IuoKa9b38kKddfJ0Bwdv3eCAKLCuRUnZtdp+KVYYoV8vZZX+cDi2Go
         yyb2vVkfq4blVyTz8W+GD/awYzzXgzVp7ZbzM=
MIME-Version: 1.0
Received: by 10.181.155.9 with SMTP id h9mr784604bko.176.1232100625616; Fri, 
	16 Jan 2009 02:10:25 -0800 (PST)
In-Reply-To: <20090115205851.GD8656@roarinelk.homelinux.net>
References: <200901151646.49591.florian@openwrt.org>
	 <20090115205851.GD8656@roarinelk.homelinux.net>
Date:	Fri, 16 Jan 2009 11:10:25 +0100
X-Google-Sender-Auth: f9b3a3c4d4d36dc8
Message-ID: <86ee6fd0901160210pdb7f52nf761f8706a56f8fe@mail.gmail.com>
Subject: Re: [PATCH] au1000: convert to using gpiolib
From:	Florian Fainelli <florian@openwrt.org>
To:	Manuel Lauss <mano@roarinelk.homelinux.net>
Cc:	ralf@linux-mips.org, Linux-MIPS <linux-mips@linux-mips.org>
Content-Type: multipart/alternative; boundary=0016368e2b181e1090046096c88c
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21769
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: florian@openwrt.org
Precedence: bulk
X-list: linux-mips

--0016368e2b181e1090046096c88c
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Manuel,

2009/1/15 Manuel Lauss <mano@roarinelk.homelinux.net>

> Hi Florian,
>
> On Thu, Jan 15, 2009 at 04:46:48PM +0100, Florian Fainelli wrote:
> > This patch converts the GPIO board code to use gpiolib
>
> Because of the 'enable | value' scheme I believe you don't require any
> locking here.


Right, thanks.


>
>
>
> > +struct au1000_gpio_chip au1000_gpio_chip[] = {
> > +     [0] = {
> > +             .regbase                        = (void __iomem *)SYS_BASE,
> > +             .chip = {
> > +                     .label                  = "au1000-gpio1",
> > +                     .direction_input        =
> au1000_gpio1_direction_input,
> > +                     .direction_output       =
> au1000_gpio1_direction_output,
> > +                     .get                    = au1000_gpio1_get,
> > +                     .set                    = au1000_gpio1_set,
> > +                     .base                   = 0,
> > +                     .ngpio                  = 32,
> > +             },
> > +     },
> > +#if !defined(CONFIG_SOC_AU1000)
> > +     [1] = {
> > +             .regbase                        = (void __iomem
> *)GPIO2_BASE,
> > +             .chip = {
> > +                     .label                  = "au1000-gpio2",
> > +                     .direction_input        =
> au1000_gpio2_direction_input,
> > +                     .direction_output       =
> au1000_gpio2_direction_output,
> > +                     .get                    = au1000_gpio2_get,
> > +                     .set                    = au1000_gpio2_set,
> > +                     .base                   = AU1XXX_GPIO_BASE,
> > +                     .ngpio                  = 32,
> > +             },
> > +     },
> >  #endif
> > -     else
> > -             return au1xxx_gpio1_read(gpio);
> > -}
> > -EXPORT_SYMBOL(au1xxx_gpio_get_value);
> > +};
> [...]
> > +static int __init au1000_gpio_init(void)
> >  {
> > -     if (gpio >= AU1XXX_GPIO_BASE)
> > -#if defined(CONFIG_SOC_AU1000)
> > -             ;
> > -#else
> > -             au1xxx_gpio2_write(gpio, value);
> > -#endif
> > -     else
> > -             au1xxx_gpio1_write(gpio, value);
> > -}
> > -EXPORT_SYMBOL(au1xxx_gpio_set_value);
> > +     gpiochip_add(&au1000_gpio_chip[0].chip);
> > +#if !defined(CONFIG_SOC_AU1000)
> > +     gpiochip_add(&au1000_gpio_chip[1].chip);
> >
> [...]
> > +arch_initcall(au1000_gpio_init);
>
> Can you please make the gpiolib registration dependent on a
> CONFIG symbol?  I.e. make the au1000_gpio{,2}_direction() and
> friends calls globally visible but let the individual boards
> decide whether they want to use the gpio numbering imposed by
> this patch.


Would something like #ifdef CONFIG_AU1000_NON_STD_GPIOS be ok with you ?
Or maybe we could get the base information from board-specific code ?


>
>
> Long explanation:  I maintain a number of modules with a common connector
> interface, based on different architectures (sh, mips and arm so far).
> I also maintain a few baseboards which can carry theese modules.  Modules
> provide 16 gpios numbered 0-15, which are used by the baseboards.  Since
> I need to keep the baseboard code free of arch-specific hacks, every module
> provides its own gpio-chip which distributes the gpio-lib calls to various
> on- and off-chip peripherals.  On my alchemy board in particular, those 16
> gpios are provided by a mixture of gpio1, gpio2 and FPGA based pins (yes
> I repeatedly moanoed to the hw guys about this but pin multiplexing and
> required features make a sane implementation difficult; but at least I was
> allowed to write the VHDL for the fpga-based gpios).


Your explanation makes perfect sense to me.


>
>
> If this explanation doesn't make sense I'll gladly whip up an addon patch.
>
>
> > diff --git a/arch/mips/include/asm/mach-au1x00/gpio.h
> b/arch/mips/include/asm/mach-au1x00/gpio.h
> > index 2dc61e0..34d9b72 100644
> > --- a/arch/mips/include/asm/mach-au1x00/gpio.h
> > +++ b/arch/mips/include/asm/mach-au1x00/gpio.h
> > @@ -5,65 +5,29 @@
> >
> >  #define AU1XXX_GPIO_BASE     200
>
> please change this to AU1XXX_GPIO2_BASE (it's the base number
> of the GPIO2 block pins after all)


Ok.

Thanks for your comments, I will respin with your comments.

--0016368e2b181e1090046096c88c
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Manuel,<br><br><div class=3D"gmail_quote">2009/1/15 Manuel Lauss <span d=
ir=3D"ltr">&lt;<a href=3D"mailto:mano@roarinelk.homelinux.net" target=3D"_b=
lank">mano@roarinelk.homelinux.net</a>&gt;</span><br><blockquote class=3D"g=
mail_quote" style=3D"border-left: 1px solid rgb(204, 204, 204); margin: 0pt=
 0pt 0pt 0.8ex; padding-left: 1ex;">

Hi Florian,<br>
<div><br>
On Thu, Jan 15, 2009 at 04:46:48PM +0100, Florian Fainelli wrote:<br>
&gt; This patch converts the GPIO board code to use gpiolib<br></div><div><=
br>
</div>Because of the &#39;enable | value&#39; scheme I believe you don&#39;=
t require any<br>
locking here.</blockquote><div><br>Right, thanks.<br>&nbsp;<br></div><block=
quote class=3D"gmail_quote" style=3D"border-left: 1px solid rgb(204, 204, 2=
04); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;"><br>
<div><div></div><div><br>
<br>
&gt; +struct au1000_gpio_chip au1000_gpio_chip[] =3D {<br>
&gt; + &nbsp; &nbsp; [0] =3D {<br>
&gt; + &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; .regbase &nbsp; &nbsp; &nb=
sp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;=3D (void=
 __iomem *)SYS_BASE,<br>
&gt; + &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; .chip =3D {<br>
&gt; + &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp=
; .label &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;=3D =
&quot;au1000-gpio1&quot;,<br>
&gt; + &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp=
; .direction_input &nbsp; &nbsp; &nbsp; &nbsp;=3D au1000_gpio1_direction_in=
put,<br>
&gt; + &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp=
; .direction_output &nbsp; &nbsp; &nbsp; =3D au1000_gpio1_direction_output,=
<br>
&gt; + &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp=
; .get &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp=
;=3D au1000_gpio1_get,<br>
&gt; + &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp=
; .set &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp=
;=3D au1000_gpio1_set,<br>
&gt; + &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp=
; .base &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; =3D =
0,<br>
&gt; + &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp=
; .ngpio &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;=3D =
32,<br>
&gt; + &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; },<br>
&gt; + &nbsp; &nbsp; },<br>
&gt; +#if !defined(CONFIG_SOC_AU1000)<br>
&gt; + &nbsp; &nbsp; [1] =3D {<br>
&gt; + &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; .regbase &nbsp; &nbsp; &nb=
sp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;=3D (void=
 __iomem *)GPIO2_BASE,<br>
&gt; + &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; .chip =3D {<br>
&gt; + &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp=
; .label &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;=3D =
&quot;au1000-gpio2&quot;,<br>
&gt; + &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp=
; .direction_input &nbsp; &nbsp; &nbsp; &nbsp;=3D au1000_gpio2_direction_in=
put,<br>
&gt; + &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp=
; .direction_output &nbsp; &nbsp; &nbsp; =3D au1000_gpio2_direction_output,=
<br>
&gt; + &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp=
; .get &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp=
;=3D au1000_gpio2_get,<br>
&gt; + &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp=
; .set &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp=
;=3D au1000_gpio2_set,<br>
&gt; + &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp=
; .base &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; =3D =
AU1XXX_GPIO_BASE,<br>
&gt; + &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp=
; .ngpio &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;=3D =
32,<br>
&gt; + &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; },<br>
&gt; + &nbsp; &nbsp; },<br>
&gt; &nbsp;#endif<br>
&gt; - &nbsp; &nbsp; else<br>
&gt; - &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; return au1xxx_gpio1_read(g=
pio);<br>
&gt; -}<br>
&gt; -EXPORT_SYMBOL(au1xxx_gpio_get_value);<br>
&gt; +};<br>
</div></div>[...]<br>
<div>&gt; +static int __init au1000_gpio_init(void)<br>
&gt; &nbsp;{<br>
&gt; - &nbsp; &nbsp; if (gpio &gt;=3D AU1XXX_GPIO_BASE)<br>
&gt; -#if defined(CONFIG_SOC_AU1000)<br>
&gt; - &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; ;<br>
&gt; -#else<br>
&gt; - &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; au1xxx_gpio2_write(gpio, v=
alue);<br>
&gt; -#endif<br>
&gt; - &nbsp; &nbsp; else<br>
&gt; - &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; au1xxx_gpio1_write(gpio, v=
alue);<br>
&gt; -}<br>
&gt; -EXPORT_SYMBOL(au1xxx_gpio_set_value);<br>
&gt; + &nbsp; &nbsp; gpiochip_add(&amp;au1000_gpio_chip[0].chip);<br>
&gt; +#if !defined(CONFIG_SOC_AU1000)<br>
&gt; + &nbsp; &nbsp; gpiochip_add(&amp;au1000_gpio_chip[1].chip);<br>
&gt;<br>
</div>[...]<br>
<div>&gt; +arch_initcall(au1000_gpio_init);<br>
<br>
</div>Can you please make the gpiolib registration dependent on a<br>
CONFIG symbol? &nbsp;I.e. make the au1000_gpio{,2}_direction() and<br>
friends calls globally visible but let the individual boards<br>
decide whether they want to use the gpio numbering imposed by<br>
this patch.</blockquote><div><br>Would something like #ifdef CONFIG_AU1000_=
NON_STD_GPIOS be ok with you ?<br>Or maybe we could get the base informatio=
n from board-specific code ?<br>&nbsp;</div><blockquote class=3D"gmail_quot=
e" style=3D"border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt =
0.8ex; padding-left: 1ex;">
<br>
<br>
Long explanation: &nbsp;I maintain a number of modules with a common connec=
tor<br>
interface, based on different architectures (sh, mips and arm so far).<br>
I also maintain a few baseboards which can carry theese modules. &nbsp;Modu=
les<br>
provide 16 gpios numbered 0-15, which are used by the baseboards. &nbsp;Sin=
ce<br>
I need to keep the baseboard code free of arch-specific hacks, every module=
<br>
provides its own gpio-chip which distributes the gpio-lib calls to various<=
br>
on- and off-chip peripherals. &nbsp;On my alchemy board in particular, thos=
e 16<br>
gpios are provided by a mixture of gpio1, gpio2 and FPGA based pins (yes<br=
>
I repeatedly moanoed to the hw guys about this but pin multiplexing and<br>
required features make a sane implementation difficult; but at least I was<=
br>
allowed to write the VHDL for the fpga-based gpios).</blockquote><div><br>Y=
our explanation makes perfect sense to me.<br>&nbsp;</div><blockquote class=
=3D"gmail_quote" style=3D"border-left: 1px solid rgb(204, 204, 204); margin=
: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">

<br>
<br>
If this explanation doesn&#39;t make sense I&#39;ll gladly whip up an addon=
 patch.<br>
<div><br>
<br>
&gt; diff --git a/arch/mips/include/asm/mach-au1x00/gpio.h b/arch/mips/incl=
ude/asm/mach-au1x00/gpio.h<br>
&gt; index 2dc61e0..34d9b72 100644<br>
&gt; --- a/arch/mips/include/asm/mach-au1x00/gpio.h<br>
&gt; +++ b/arch/mips/include/asm/mach-au1x00/gpio.h<br>
&gt; @@ -5,65 +5,29 @@<br>
&gt;<br>
&gt; &nbsp;#define AU1XXX_GPIO_BASE &nbsp; &nbsp; 200<br>
<br>
</div>please change this to AU1XXX_GPIO2_BASE (it&#39;s the base number<br>
of the GPIO2 block pins after all)</blockquote><div><br>Ok.<br>&nbsp;<br>Th=
anks for your comments, I will respin with your comments.<br></div></div><b=
r>

--0016368e2b181e1090046096c88c--
