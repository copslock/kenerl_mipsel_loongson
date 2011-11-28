Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 28 Nov 2011 06:06:48 +0100 (CET)
Received: from mail-ey0-f177.google.com ([209.85.215.177]:44859 "EHLO
        mail-ey0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1904680Ab1K1FGj (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 28 Nov 2011 06:06:39 +0100
Received: by eaac10 with SMTP id c10so1783565eaa.36
        for <multiple recipients>; Sun, 27 Nov 2011 21:06:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=7YKhc0UVSsOfdOiTL8lX03c+St5kuCsz8sxFiZNYKoE=;
        b=nzMf/Z30ETJC/Xs7sQkMkjPdG0nKUD3VO7kA9YwaOe9mfeoYm04JylFwqVZFsRGM30
         ffdvtoQ+wf21L7sGSgp8FexTkQR7/Rs+7x1syXh6b/RV83W6ejcLuRfBpUswcAt8k8u2
         gmsPGur1qa/Bh9EyYkmu64ftoO0+KD+/LzCUY=
MIME-Version: 1.0
Received: by 10.14.9.134 with SMTP id 6mr351360eet.107.1322456793650; Sun, 27
 Nov 2011 21:06:33 -0800 (PST)
Received: by 10.14.127.199 with HTTP; Sun, 27 Nov 2011 21:06:33 -0800 (PST)
In-Reply-To: <20111127091803.GD5263@pengutronix.de>
References: <1322189527-4761-1-git-send-email-zhzhl555@gmail.com>
        <20111127091803.GD5263@pengutronix.de>
Date:   Mon, 28 Nov 2011 13:06:33 +0800
Message-ID: <CANY2ML+sjKshHF5u+ZxvEp-YSyB8NrJfVDaOggifbsOBuAxCrg@mail.gmail.com>
Subject: Re: [rtc-linux] [PATCH V1] MIPS: Add RTC support for loongson1B
From:   zhao zhang <zhzhl555@gmail.com>
To:     Wolfram Sang <w.sang@pengutronix.de>
Cc:     rtc-linux@googlegroups.com, a.zummo@towertech.it,
        linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
        ralf@linux-mips.org, keguang.zhang@gmail.com, wuzhangjin@gmail.com,
        r0bertz@gentoo.org, zhzhl555@gmail.com
Content-Type: multipart/alternative; boundary=0016364c7ac76a975c04b2c47766
X-archive-position: 32007
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: zhzhl555@gmail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 22568

--0016364c7ac76a975c04b2c47766
Content-Type: text/plain; charset=GB2312
Content-Transfer-Encoding: quoted-printable

1:  Here is a  polling checking for TOY write status bit. if hardware done,
the bit will be cleared. so if hardware has problem, the while loop will be
infinite, it can never break out.  Does i really need to add timeout
checking
code although have checked in probe code.

2:  Just set the default value, the real return value will be set in the
following
code. Line 154, err information will be put into dev_err-block.

3: The minor, accept.

4: Because in probe, we can not assume the hardware is OK,
so add a counter( v =3D 0x100000) to avoid infinite loop.

5: a): Since i have checked the RTC timing was OK, and  toytrim write
status was
OK again, so i can sure, the next writing will be OK.
    b): Just following the  Documentation/timers/timers-howto.txt.
    c): i can make sure.

6: agree.


=D4=DA 2011=C4=EA11=D4=C227=C8=D5 =CF=C2=CE=E75:18=A3=ACWolfram Sang <w.san=
g@pengutronix.de>=D0=B4=B5=C0=A3=BA

> On Fri, Nov 25, 2011 at 10:52:07AM +0800, zhzhl555@gmail.com wrote:
>
> > +     writel(t, SYS_TOYWRITE1);
> > +     while (readl(SYS_COUNTER_CNTRL) & SYS_CNTRL_TS)
> > +             usleep_range(1000, 3000);
> > +     __asm__ volatile ("sync");
>
> Timeout?
>
> > +
> > +static int __devinit ls1x_rtc_probe(struct platform_device *pdev)
> > +{
> > +     struct rtc_device *rtcdev;
> > +     unsigned long v;
> > +     int ret;
> > +
> > +     v =3D readl(SYS_COUNTER_CNTRL);
> > +     if (!(v & RTC_CNTR_OK)) {
> > +             dev_err(&pdev->dev, "rtc counters not working\n");
> > +             ret =3D -ENODEV;
> > +             goto err;
> > +     }
> > +     ret =3D -ETIMEDOUT;
>
> Why not putting this line to the corresponding dev_err-block?
>
> > +     /*set to 1 HZ if needed*/
>
> Minor: Spaces around comment-markers, here and in other places
>
> /* Comment */
>
> > +     if (readl(SYS_TOYTRIM) !=3D 32767) {
> > +             v =3D 0x100000;
> > +             while ((readl(SYS_COUNTER_CNTRL) & SYS_CNTRL_TTS) && --v)
> > +                     usleep_range(1000, 3000);
>
> Timeout?
>
> > +
> > +             if (!v) {
> > +                     dev_err(&pdev->dev, "time out\n");
> > +                     goto err;
> > +             }
> > +             writel(32767, SYS_TOYTRIM);
> > +             __asm__ volatile("sync");
> > +     }
> > +     /*this loop coundn't be endless*/
> > +     while (readl(SYS_COUNTER_CNTRL) & SYS_CNTRL_TTS)
> > +             usleep_range(1000, 3000);
>
> Timeout again. First, the comment does not help. Why are you sure the loo=
p
> could not be endless? And: Does it really need to be a usleep_range()
> instead
> of a simple msleep()? And to make sure: There is no interrupt signalling
> the
> status changed?
>
> > +
> > +     rtcdev =3D rtc_device_register("ls1x-rtc", &pdev->dev,
> > +                                     &ls1x_rtc_ops , THIS_MODULE);
> > +     if (IS_ERR(rtcdev)) {
> > +             ret =3D PTR_ERR(rtcdev);
> > +             goto err;
> > +     }
> > +
> > +     platform_set_drvdata(pdev, rtcdev);
> > +     return 0;
> > +err:
> > +     return ret;
> > +}
> > +
>
> ...
>
> > +static int __init ls1x_rtc_init(void)
> > +{
> > +     return platform_driver_probe(&ls1x_rtc_driver, ls1x_rtc_probe);
> > +}
> > +
> > +static void __exit ls1x_rtc_exit(void)
> > +{
> > +     platform_driver_unregister(&ls1x_rtc_driver);
> > +}
> > +
> > +
> > +module_init(ls1x_rtc_init);
> > +module_exit(ls1x_rtc_exit);
>
> Please use the new module_platform_driver()-macro.
>
> Thanks,
>
>   Wolfram
>
> --
> Pengutronix e.K.                           | Wolfram Sang                =
|
> Industrial Linux Solutions                 | http://www.pengutronix.de/  =
|
>

--0016364c7ac76a975c04b2c47766
Content-Type: text/html; charset=GB2312
Content-Transfer-Encoding: quoted-printable

1:&nbsp; Here is a&nbsp; polling checking for TOY write status bit. if hard=
ware done,<br>the bit will be cleared. so if hardware has problem, the whil=
e loop will be <br>infinite, it can never break out.&nbsp; Does i really ne=
ed to add timeout checking <br>
code although have checked in probe code.<br><br>2:&nbsp; Just set the defa=
ult value, the real return value will be set in the following<br>code. Line=
 154, err information will be put into dev_err-block. <br><br>3: The minor,=
 accept.<br>
<br>4: Because in probe, we can not assume the hardware is OK,<br>so add a =
counter( v =3D 0x100000) to avoid infinite loop.<br><br>5: a): Since i have=
 checked the RTC timing was OK, and&nbsp; toytrim write status was<br>OK ag=
ain, so i can sure, the next writing will be OK.<br>
&nbsp;&nbsp;&nbsp; b): Just following the&nbsp; Documentation/timers/timers=
-howto.txt. <br>&nbsp;&nbsp;&nbsp; c): i can make sure. <br><br>6: agree.<b=
r><br><br><div class=3D"gmail_quote">=D4=DA 2011=C4=EA11=D4=C227=C8=D5 =CF=
=C2=CE=E75:18=A3=ACWolfram Sang <span dir=3D"ltr">&lt;<a href=3D"mailto:w.s=
ang@pengutronix.de">w.sang@pengutronix.de</a>&gt;</span>=D0=B4=B5=C0=A3=BA<=
br>
<blockquote class=3D"gmail_quote" style=3D"margin: 0pt 0pt 0pt 0.8ex; borde=
r-left: 1px solid rgb(204, 204, 204); padding-left: 1ex;"><div class=3D"im"=
>On Fri, Nov 25, 2011 at 10:52:07AM +0800, <a href=3D"mailto:zhzhl555@gmail=
.com">zhzhl555@gmail.com</a> wrote:<br>

<br>
</div><div class=3D"im">&gt; + &nbsp; &nbsp; writel(t, SYS_TOYWRITE1);<br>
&gt; + &nbsp; &nbsp; while (readl(SYS_COUNTER_CNTRL) &amp; SYS_CNTRL_TS)<br=
>
&gt; + &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; usleep_range(1000, 3000);<=
br>
&gt; + &nbsp; &nbsp; __asm__ volatile (&quot;sync&quot;);<br>
<br>
</div>Timeout?<br>
<div class=3D"im"><br>
&gt; +<br>
&gt; +static int __devinit ls1x_rtc_probe(struct platform_device *pdev)<br>
&gt; +{<br>
&gt; + &nbsp; &nbsp; struct rtc_device *rtcdev;<br>
&gt; + &nbsp; &nbsp; unsigned long v;<br>
&gt; + &nbsp; &nbsp; int ret;<br>
&gt; +<br>
&gt; + &nbsp; &nbsp; v =3D readl(SYS_COUNTER_CNTRL);<br>
&gt; + &nbsp; &nbsp; if (!(v &amp; RTC_CNTR_OK)) {<br>
&gt; + &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; dev_err(&amp;pdev-&gt;dev,=
 &quot;rtc counters not working\n&quot;);<br>
&gt; + &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; ret =3D -ENODEV;<br>
&gt; + &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; goto err;<br>
&gt; + &nbsp; &nbsp; }<br>
&gt; + &nbsp; &nbsp; ret =3D -ETIMEDOUT;<br>
<br>
</div>Why not putting this line to the corresponding dev_err-block?<br>
<div class=3D"im"><br>
&gt; + &nbsp; &nbsp; /*set to 1 HZ if needed*/<br>
<br>
</div>Minor: Spaces around comment-markers, here and in other places<br>
<br>
/* Comment */<br>
<div class=3D"im"><br>
&gt; + &nbsp; &nbsp; if (readl(SYS_TOYTRIM) !=3D 32767) {<br>
&gt; + &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; v =3D 0x100000;<br>
&gt; + &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; while ((readl(SYS_COUNTER_=
CNTRL) &amp; SYS_CNTRL_TTS) &amp;&amp; --v)<br>
&gt; + &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp=
; usleep_range(1000, 3000);<br>
<br>
</div>Timeout?<br>
<div class=3D"im"><br>
&gt; +<br>
&gt; + &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; if (!v) {<br>
&gt; + &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp=
; dev_err(&amp;pdev-&gt;dev, &quot;time out\n&quot;);<br>
&gt; + &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp=
; goto err;<br>
&gt; + &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; }<br>
&gt; + &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; writel(32767, SYS_TOYTRIM)=
;<br>
&gt; + &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; __asm__ volatile(&quot;syn=
c&quot;);<br>
&gt; + &nbsp; &nbsp; }<br>
&gt; + &nbsp; &nbsp; /*this loop coundn&#39;t be endless*/<br>
&gt; + &nbsp; &nbsp; while (readl(SYS_COUNTER_CNTRL) &amp; SYS_CNTRL_TTS)<b=
r>
&gt; + &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; usleep_range(1000, 3000);<=
br>
<br>
</div>Timeout again. First, the comment does not help. Why are you sure the=
 loop<br>
could not be endless? And: Does it really need to be a usleep_range() inste=
ad<br>
of a simple msleep()? And to make sure: There is no interrupt signalling th=
e<br>
status changed?<br>
<div class=3D"im"><br>
&gt; +<br>
&gt; + &nbsp; &nbsp; rtcdev =3D rtc_device_register(&quot;ls1x-rtc&quot;, &=
amp;pdev-&gt;dev,<br>
&gt; + &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp=
; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &amp;ls1x_rtc_ops=
 , THIS_MODULE);<br>
&gt; + &nbsp; &nbsp; if (IS_ERR(rtcdev)) {<br>
&gt; + &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; ret =3D PTR_ERR(rtcdev);<b=
r>
&gt; + &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; goto err;<br>
&gt; + &nbsp; &nbsp; }<br>
&gt; +<br>
&gt; + &nbsp; &nbsp; platform_set_drvdata(pdev, rtcdev);<br>
&gt; + &nbsp; &nbsp; return 0;<br>
&gt; +err:<br>
&gt; + &nbsp; &nbsp; return ret;<br>
&gt; +}<br>
&gt; +<br>
<br>
</div>...<br>
<div class=3D"im"><br>
&gt; +static int __init ls1x_rtc_init(void)<br>
&gt; +{<br>
&gt; + &nbsp; &nbsp; return platform_driver_probe(&amp;ls1x_rtc_driver, ls1=
x_rtc_probe);<br>
&gt; +}<br>
&gt; +<br>
&gt; +static void __exit ls1x_rtc_exit(void)<br>
&gt; +{<br>
&gt; + &nbsp; &nbsp; platform_driver_unregister(&amp;ls1x_rtc_driver);<br>
&gt; +}<br>
&gt; +<br>
&gt; +<br>
&gt; +module_init(ls1x_rtc_init);<br>
&gt; +module_exit(ls1x_rtc_exit);<br>
<br>
</div>Please use the new module_platform_driver()-macro.<br>
<br>
Thanks,<br>
<font color=3D"#888888"><br>
 &nbsp; Wolfram<br>
</font><div><div></div><div class=3D"h5"><br>
--<br>
Pengutronix e.K. &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &n=
bsp; &nbsp; &nbsp; &nbsp; &nbsp; | Wolfram Sang &nbsp; &nbsp; &nbsp; &nbsp;=
 &nbsp; &nbsp; &nbsp; &nbsp;|<br>
Industrial Linux Solutions &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;=
 &nbsp; | <a href=3D"http://www.pengutronix.de/" target=3D"_blank">http://w=
ww.pengutronix.de/</a> &nbsp;|<br>
</div></div></blockquote></div><br>

--0016364c7ac76a975c04b2c47766--
