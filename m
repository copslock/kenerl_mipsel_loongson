Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 18 Jan 2012 07:40:05 +0100 (CET)
Received: from mail-vw0-f49.google.com ([209.85.212.49]:64221 "EHLO
        mail-vw0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903642Ab2ARGj5 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 18 Jan 2012 07:39:57 +0100
Received: by vbbff1 with SMTP id ff1so3214999vbb.36
        for <multiple recipients>; Tue, 17 Jan 2012 22:39:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=h2eI1eMOvIGEfdqrptJLqB/4G96ggOIvmoR9KM0uc4A=;
        b=BcHkPGwSnbeYX2O2hTM5+kH0sYeskeYvHgjlT9lNCOtqtxelLK7tC1w+JTVNORkGjl
         vKd6CtzpLkYgL2qDI4XIZZvy+T83vDa/uUoDixfwiRBHVnTZEFNwbxIvXz1i/JeBzrKY
         44gcBuTNdaf1RG9vLJfi28Y9GApC0ygCCv9mo=
Received: by 10.52.93.77 with SMTP id cs13mr2850214vdb.71.1326868791543; Tue,
 17 Jan 2012 22:39:51 -0800 (PST)
MIME-Version: 1.0
Received: by 10.220.184.1 with HTTP; Tue, 17 Jan 2012 22:39:30 -0800 (PST)
In-Reply-To: <Pine.LNX.4.44L0.1201171021320.1818-100000@iolanthe.rowland.org>
References: <1326777160-9930-5-git-send-email-keguang.zhang@gmail.com> <Pine.LNX.4.44L0.1201171021320.1818-100000@iolanthe.rowland.org>
From:   Kelvin Cheung <keguang.zhang@gmail.com>
Date:   Wed, 18 Jan 2012 14:39:30 +0800
Message-ID: <CAJhJPsVd1iTQuo4wWOoJVANsmNAPC8siM9z-dz1V0QX3s3X7cg@mail.gmail.com>
Subject: Re: [PATCH V6 4/5] USB: Add EHCI bus glue for Loongson1x SoCs
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     ralf@linux-mips.org, linux-mips@linux-mips.org,
        linux-usb@vger.kernel.org, gregkh@suse.de, zhzhl555@gmail.com,
        peppe.cavallaro@st.com, wuzhangjin@gmail.com,
        linux-kernel@vger.kernel.org
Content-Type: multipart/alternative; boundary=bcaec501652ffbc7eb04b6c7b686
X-archive-position: 32284
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: keguang.zhang@gmail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

--bcaec501652ffbc7eb04b6c7b686
Content-Type: text/plain; charset=ISO-8859-1

Done.

Thanks for review.

2012/1/17 Alan Stern <stern@rowland.harvard.edu>

> On Tue, 17 Jan 2012, Kelvin Cheung wrote:
>
> > The Loongson1x SoCs have a built-in EHCI controller.
> > This patch adds the necessary glue code to make the generic EHCI
> > driver usable for them.
>
> > --- /dev/null
> > +++ b/drivers/usb/host/ehci-ls1x.c
> > @@ -0,0 +1,170 @@
> > +/*
> > + *  Bus Glue for Loongson LS1X built-in EHCI controller.
> > + *
> > + *  Copyright (c) 2012 Zhang, Keguang <keguang.zhang@gmail.com>
> > + *
> > + *  This program is free software; you can redistribute it and/or
> modify it
> > + *  under the terms of the GNU General Public License version 2 as
> published
> > + *  by the Free Software Foundation.
> > + */
> > +
> > +
> > +#include <linux/platform_device.h>
> > +
> > +static int ehci_ls1x_setup(struct usb_hcd *hcd)
> > +{
> > +     struct ehci_hcd *ehci = hcd_to_ehci(hcd);
> > +     int ret;
> > +
> > +     ehci->caps = hcd->regs;
> > +     ehci->regs = hcd->regs +
> > +             HC_LENGTH(ehci, ehci_readl(ehci, &ehci->caps->hc_capbase));
> > +     dbg_hcs_params(ehci, "reset");
> > +     dbg_hcc_params(ehci, "reset");
> > +
> > +     /* cache this readonly data; minimize chip reads */
> > +     ehci->hcs_params = ehci_readl(ehci, &ehci->caps->hcs_params);
> > +     ehci->sbrn = 0x20;
> > +
> > +     ehci_reset(ehci);
> > +
> > +     /* data structure init */
> > +     ret = ehci_init(hcd);
> > +     if (ret)
> > +             return ret;
> > +
> > +     ehci_port_power(ehci, 0);
> > +
> > +     return 0;
> > +}
>
> Most of this routine should be replaced with a call to ehci_setup().
>
> Alan Stern
>
>


-- 
Best Regards!
Kelvin

--bcaec501652ffbc7eb04b6c7b686
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Done.<br>
<br>
Thanks for review.<br><br><div class=3D"gmail_quote">2012/1/17 Alan Stern <=
span dir=3D"ltr">&lt;<a href=3D"mailto:stern@rowland.harvard.edu">stern@row=
land.harvard.edu</a>&gt;</span><br><blockquote class=3D"gmail_quote" style=
=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">

<div class=3D"im">On Tue, 17 Jan 2012, Kelvin Cheung wrote:<br>
<br>
&gt; The Loongson1x SoCs have a built-in EHCI controller.<br>
&gt; This patch adds the necessary glue code to make the generic EHCI<br>
&gt; driver usable for them.<br>
<br>
</div><div><div class=3D"h5">&gt; --- /dev/null<br>
&gt; +++ b/drivers/usb/host/ehci-ls1x.c<br>
&gt; @@ -0,0 +1,170 @@<br>
&gt; +/*<br>
&gt; + * =A0Bus Glue for Loongson LS1X built-in EHCI controller.<br>
&gt; + *<br>
&gt; + * =A0Copyright (c) 2012 Zhang, Keguang &lt;<a href=3D"mailto:keguang=
.zhang@gmail.com">keguang.zhang@gmail.com</a>&gt;<br>
&gt; + *<br>
&gt; + * =A0This program is free software; you can redistribute it and/or m=
odify it<br>
&gt; + * =A0under the terms of the GNU General Public License version 2 as =
published<br>
&gt; + * =A0by the Free Software Foundation.<br>
&gt; + */<br>
&gt; +<br>
&gt; +<br>
&gt; +#include &lt;linux/platform_device.h&gt;<br>
&gt; +<br>
&gt; +static int ehci_ls1x_setup(struct usb_hcd *hcd)<br>
&gt; +{<br>
&gt; + =A0 =A0 struct ehci_hcd *ehci =3D hcd_to_ehci(hcd);<br>
&gt; + =A0 =A0 int ret;<br>
&gt; +<br>
&gt; + =A0 =A0 ehci-&gt;caps =3D hcd-&gt;regs;<br>
&gt; + =A0 =A0 ehci-&gt;regs =3D hcd-&gt;regs +<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 HC_LENGTH(ehci, ehci_readl(ehci, &amp;ehci-&=
gt;caps-&gt;hc_capbase));<br>
&gt; + =A0 =A0 dbg_hcs_params(ehci, &quot;reset&quot;);<br>
&gt; + =A0 =A0 dbg_hcc_params(ehci, &quot;reset&quot;);<br>
&gt; +<br>
&gt; + =A0 =A0 /* cache this readonly data; minimize chip reads */<br>
&gt; + =A0 =A0 ehci-&gt;hcs_params =3D ehci_readl(ehci, &amp;ehci-&gt;caps-=
&gt;hcs_params);<br>
&gt; + =A0 =A0 ehci-&gt;sbrn =3D 0x20;<br>
&gt; +<br>
&gt; + =A0 =A0 ehci_reset(ehci);<br>
&gt; +<br>
&gt; + =A0 =A0 /* data structure init */<br>
&gt; + =A0 =A0 ret =3D ehci_init(hcd);<br>
&gt; + =A0 =A0 if (ret)<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 return ret;<br>
&gt; +<br>
&gt; + =A0 =A0 ehci_port_power(ehci, 0);<br>
&gt; +<br>
&gt; + =A0 =A0 return 0;<br>
&gt; +}<br>
<br>
</div></div>Most of this routine should be replaced with a call to ehci_set=
up().<br>
<span class=3D"HOEnZb"><font color=3D"#888888"><br>
Alan Stern<br>
<br>
</font></span></blockquote></div><br><br clear=3D"all"><br>-- <br>Best Rega=
rds!<br>Kelvin<br><br><img src=3D"http://ubuntucounter.geekosophical.net/im=
g/ubuntu-blogger.php?user=3D26540"><br><br>

--bcaec501652ffbc7eb04b6c7b686--
