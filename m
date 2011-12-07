Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 07 Dec 2011 03:18:42 +0100 (CET)
Received: from mail-ey0-f177.google.com ([209.85.215.177]:59723 "EHLO
        mail-ey0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903633Ab1LGCSf (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 7 Dec 2011 03:18:35 +0100
Received: by eaac10 with SMTP id c10so50320eaa.36
        for <multiple recipients>; Tue, 06 Dec 2011 18:18:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=nHl4cDf67s7CHam8QkZXjbO3iXjMiGPlwjqX0Yibs9c=;
        b=T7s1HxFgtoyYErfWbi1saRJgVQuLKjaVE/O25VV8wNWAQzYUHE5Zpv4ROwfM+Junrp
         YMehWWRNTvMiWMsCmU+r2tWlZk9xKDTspigTSugfG0KB0pTb55Gvg7DM6i2X5JbjGkKt
         30RuXxpzMNQxjTpeSYAtVg63+yG/UJNHw52u8=
MIME-Version: 1.0
Received: by 10.213.29.138 with SMTP id q10mr3091029ebc.35.1323224309445; Tue,
 06 Dec 2011 18:18:29 -0800 (PST)
Received: by 10.14.37.15 with HTTP; Tue, 6 Dec 2011 18:18:29 -0800 (PST)
In-Reply-To: <20111205155359.GF9192@game.jcrosoft.org>
References: <1322729078-6141-1-git-send-email-zhzhl555@gmail.com>
        <20111205155359.GF9192@game.jcrosoft.org>
Date:   Wed, 7 Dec 2011 10:18:29 +0800
Message-ID: <CANY2ML+ZEr+tHoPJJOSbr2aRvg=8J4j8pGVdiKhKmd13=Tr02w@mail.gmail.com>
Subject: Re: [rtc-linux] [PATCH] MIPS: Add RTC support for loongson1B
From:   zhao zhang <zhzhl555@gmail.com>
To:     Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
Cc:     rtc-linux@googlegroups.com, a.zummo@towertech.it,
        linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
        ralf@linux-mips.org, keguang.zhang@gmail.com, wuzhangjin@gmail.com,
        r0bertz@gentoo.org
Content-Type: multipart/alternative; boundary=0015174be8faec36bb04b3772ad0
X-archive-position: 32051
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: zhzhl555@gmail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 5241

--0015174be8faec36bb04b3772ad0
Content-Type: text/plain; charset=GB2312
Content-Transfer-Encoding: quoted-printable

sorry, i didn't see the rule in that Makefile.

the loongson1B SOC has the alarm,irq. but that's my next plan.
i am adding other IP's support for this SOC right now.



=D4=DA 2011=C4=EA12=D4=C25=C8=D5 =CF=C2=CE=E711:53=A3=ACJean-Christophe PLA=
GNIOL-VILLARD <plagnioj@jcrosoft.com
>=D0=B4=B5=C0=A3=BA

> On 16:44 Thu 01 Dec     , zhzhl555@gmail.com wrote:
> > From: zhao zhang <zhzhl555@gmail.com>
> >
> > V2: use new module_platform_driver macro.
> > thanks for Wolfram's advice.
> >
> > This patch adds RTC support(TOY counter0) for loongson1B.
> > Signed-off-by: zhao zhang <zhzhl555@gmail.com>
> > ---
> >  drivers/rtc/Kconfig    |   10 ++
> >  drivers/rtc/Makefile   |    1 +
> >  drivers/rtc/rtc-ls1x.c |  214
> ++++++++++++++++++++++++++++++++++++++++++++++++
> >  3 files changed, 225 insertions(+), 0 deletions(-)
> >  create mode 100644 drivers/rtc/rtc-ls1x.c
> >
> > diff --git a/drivers/rtc/Kconfig b/drivers/rtc/Kconfig
> > index 5a538fc..6f8c2d7 100644
> > --- a/drivers/rtc/Kconfig
> > +++ b/drivers/rtc/Kconfig
> > @@ -1070,4 +1070,14 @@ config RTC_DRV_PUV3
> >         This drive can also be built as a module. If so, the module
> >         will be called rtc-puv3.
> >
> > +config RTC_DRV_LOONGSON1
> > +     tristate "loongson1 RTC support"
> > +     depends on MACH_LOONGSON1
> > +     help
> > +       This is a driver for the loongson1 on-chip Counter0 (Time-Of-Ye=
ar
> > +       counter) to be used as a RTC.
> > +
> > +       This driver can also be built as a module. If so, the module
> > +       will be called rtc-ls1x.
> > +
> >  endif # RTC_CLASS
> > diff --git a/drivers/rtc/Makefile b/drivers/rtc/Makefile
> > index 6e69823..48153fe 100644
> > --- a/drivers/rtc/Makefile
> > +++ b/drivers/rtc/Makefile
> > @@ -109,3 +109,4 @@ obj-$(CONFIG_RTC_DRV_VT8500)      +=3D rtc-vt8500.o
> >  obj-$(CONFIG_RTC_DRV_WM831X) +=3D rtc-wm831x.o
> >  obj-$(CONFIG_RTC_DRV_WM8350) +=3D rtc-wm8350.o
> >  obj-$(CONFIG_RTC_DRV_X1205)  +=3D rtc-x1205.o
> > +obj-$(CONFIG_RTC_DRV_LOONGSON1)      +=3D rtc-ls1x.o
> keep it ordered
>
>
> you have no alarm, irq on this hardware?
>
> Best Regards,
> J.
>

--0015174be8faec36bb04b3772ad0
Content-Type: text/html; charset=GB2312
Content-Transfer-Encoding: quoted-printable

sorry, i didn&#39;t see the rule in that Makefile. <br><br>the loongson1B S=
OC has the alarm,irq. but that&#39;s my next plan.<br>i am adding other IP&=
#39;s support for this SOC right now.&nbsp; <br><br><br><br><div class=3D"g=
mail_quote">
=D4=DA 2011=C4=EA12=D4=C25=C8=D5 =CF=C2=CE=E711:53=A3=ACJean-Christophe PLA=
GNIOL-VILLARD <span dir=3D"ltr">&lt;<a href=3D"mailto:plagnioj@jcrosoft.com=
">plagnioj@jcrosoft.com</a>&gt;</span>=D0=B4=B5=C0=A3=BA<br><blockquote cla=
ss=3D"gmail_quote" style=3D"margin: 0pt 0pt 0pt 0.8ex; border-left: 1px sol=
id rgb(204, 204, 204); padding-left: 1ex;">
<div><div></div><div class=3D"h5">On 16:44 Thu 01 Dec &nbsp; &nbsp; , <a hr=
ef=3D"mailto:zhzhl555@gmail.com">zhzhl555@gmail.com</a> wrote:<br>
&gt; From: zhao zhang &lt;<a href=3D"mailto:zhzhl555@gmail.com">zhzhl555@gm=
ail.com</a>&gt;<br>
&gt;<br>
&gt; V2: use new module_platform_driver macro.<br>
&gt; thanks for Wolfram&#39;s advice.<br>
&gt;<br>
&gt; This patch adds RTC support(TOY counter0) for loongson1B.<br>
&gt; Signed-off-by: zhao zhang &lt;<a href=3D"mailto:zhzhl555@gmail.com">zh=
zhl555@gmail.com</a>&gt;<br>
&gt; ---<br>
&gt; &nbsp;drivers/rtc/Kconfig &nbsp; &nbsp;| &nbsp; 10 ++<br>
&gt; &nbsp;drivers/rtc/Makefile &nbsp; | &nbsp; &nbsp;1 +<br>
&gt; &nbsp;drivers/rtc/rtc-ls1x.c | &nbsp;214 +++++++++++++++++++++++++++++=
+++++++++++++++++++<br>
&gt; &nbsp;3 files changed, 225 insertions(+), 0 deletions(-)<br>
&gt; &nbsp;create mode 100644 drivers/rtc/rtc-ls1x.c<br>
&gt;<br>
&gt; diff --git a/drivers/rtc/Kconfig b/drivers/rtc/Kconfig<br>
&gt; index 5a538fc..6f8c2d7 100644<br>
&gt; --- a/drivers/rtc/Kconfig<br>
&gt; +++ b/drivers/rtc/Kconfig<br>
&gt; @@ -1070,4 +1070,14 @@ config RTC_DRV_PUV3<br>
&gt; &nbsp; &nbsp; &nbsp; &nbsp; This drive can also be built as a module. =
If so, the module<br>
&gt; &nbsp; &nbsp; &nbsp; &nbsp; will be called rtc-puv3.<br>
&gt;<br>
&gt; +config RTC_DRV_LOONGSON1<br>
&gt; + &nbsp; &nbsp; tristate &quot;loongson1 RTC support&quot;<br>
&gt; + &nbsp; &nbsp; depends on MACH_LOONGSON1<br>
&gt; + &nbsp; &nbsp; help<br>
&gt; + &nbsp; &nbsp; &nbsp; This is a driver for the loongson1 on-chip Coun=
ter0 (Time-Of-Year<br>
&gt; + &nbsp; &nbsp; &nbsp; counter) to be used as a RTC.<br>
&gt; +<br>
&gt; + &nbsp; &nbsp; &nbsp; This driver can also be built as a module. If s=
o, the module<br>
&gt; + &nbsp; &nbsp; &nbsp; will be called rtc-ls1x.<br>
&gt; +<br>
&gt; &nbsp;endif # RTC_CLASS<br>
&gt; diff --git a/drivers/rtc/Makefile b/drivers/rtc/Makefile<br>
&gt; index 6e69823..48153fe 100644<br>
&gt; --- a/drivers/rtc/Makefile<br>
&gt; +++ b/drivers/rtc/Makefile<br>
&gt; @@ -109,3 +109,4 @@ obj-$(CONFIG_RTC_DRV_VT8500) &nbsp; &nbsp; &nbsp;+=
=3D rtc-vt8500.o<br>
&gt; &nbsp;obj-$(CONFIG_RTC_DRV_WM831X) +=3D rtc-wm831x.o<br>
&gt; &nbsp;obj-$(CONFIG_RTC_DRV_WM8350) +=3D rtc-wm8350.o<br>
&gt; &nbsp;obj-$(CONFIG_RTC_DRV_X1205) &nbsp;+=3D rtc-x1205.o<br>
&gt; +obj-$(CONFIG_RTC_DRV_LOONGSON1) &nbsp; &nbsp; &nbsp;+=3D rtc-ls1x.o<b=
r>
</div></div>keep it ordered<br>
<br>
<br>
you have no alarm, irq on this hardware?<br>
<br>
Best Regards,<br>
<font color=3D"#888888">J.<br>
</font></blockquote></div><br>

--0015174be8faec36bb04b3772ad0--
