Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 22 Mar 2011 03:02:56 +0100 (CET)
Received: from mail-yw0-f49.google.com ([209.85.213.49]:49786 "EHLO
        mail-yw0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491770Ab1CVCCx (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 22 Mar 2011 03:02:53 +0100
Received: by ywa8 with SMTP id 8so2900168ywa.36
        for <multiple recipients>; Mon, 21 Mar 2011 19:02:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=Dr/NBMqigEbtXGAu9LB2qz5GX8+wRRud3BFcVuBoXM0=;
        b=FvqLANwphCZWSv88w7OMBH+glDCV4zClQl9Q+0AF+2Aqk5J3FRGBmQ+3zeXD/1l+16
         l+L3S9Z+kseIcoZuVfoBiWA9Nn3sOfVT37eVRWFaAdhSSqtUEMTnhjGC0o18u9Rzdqe4
         A77oZk3y5QRVXoRG58fp/vczrglp+gmuQp5qk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=c7gQ+0afyx/i/1NWKPLxzxyzUFC9UbRPPdf6y1I5YLZytI3LpP5taVy7qZNEqcH9sG
         n9nR1+9j7cGDxaRgv80F8hpaItXaTmgi8JKdoAXX+w5Tz5XXLQgtVnwXmku65qnVDh3k
         PveUkT6+B1PR+fxanzCvqn4HtL4iYS1la27PE=
MIME-Version: 1.0
Received: by 10.151.142.3 with SMTP id u3mr4619779ybn.214.1300759365426; Mon,
 21 Mar 2011 19:02:45 -0700 (PDT)
Received: by 10.146.167.5 with HTTP; Mon, 21 Mar 2011 19:02:45 -0700 (PDT)
In-Reply-To: <20110319172254.GA11550@linux-mips.org>
References: <AANLkTinhM4PUmLbWeAyavf-JPM1Xpu9pJVkXDq4c-f0C@mail.gmail.com>
        <AANLkTinsQrZJsXt0SKRfe3S0cNGT+uuW-t3Jo4Ob4=B4@mail.gmail.com>
        <A7DEA48C84FD0B48AAAE33F328C02014033DADEC@BBY1EXM11.pmc_nt.nt.pmc-sierra.bc.ca>
        <AANLkTikWUehOmyD6Nk3Abz=u7FEb8NMtX2-N4r5HHuY9@mail.gmail.com>
        <AANLkTimK1xpHwvfE95rEMCikk8-0EkGjn4b5DwYWyN-E@mail.gmail.com>
        <20110319172254.GA11550@linux-mips.org>
Date:   Tue, 22 Mar 2011 10:02:45 +0800
Message-ID: <AANLkTim3Xqe=aOmAEC7k7MGpLYHzRUFE82EX7J+SkJ76@mail.gmail.com>
Subject: Re: Problem About Vectored interrupt
From:   "Dennis.Yxun" <dennis.yxun@gmail.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org
Content-Type: multipart/alternative; boundary=00151750da36ea20f9049f08a32e
Return-Path: <dennis.yxun@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 29424
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dennis.yxun@gmail.com
Precedence: bulk
X-list: linux-mips

--00151750da36ea20f9049f08a32e
Content-Type: text/plain; charset=UTF-8

HI Ralf:
   It's still a hack here, but that's solve my problem.
The Compare/Count timer interrupt here is connect to irq7 here,
which means interrupt occurs hardware will set CAUSE TI bit to 7.
  The hardware, it's a integrated SOC platform shipped with mips24kc
processor,
Still no public document released yet.
   What's could explain that flush_data_cache_page fix the problem?
Cache misconfiguration?
   Thanks

Dennis

On Sun, Mar 20, 2011 at 1:22 AM, Ralf Baechle <ralf@linux-mips.org> wrote:

> On Sat, Mar 19, 2011 at 08:42:17AM +0800, Dennis.Yxun wrote:
>
> > HI ALL:
> >   Again, found that when come to set vect irq 7, do additional data flush
> > fix my problem, here is the patch
> >
> > diff --git a/arch/mips/kernel/traps.c b/arch/mips/kernel/traps.c
> > index e971043..850ce58 100644
> > --- a/arch/mips/kernel/traps.c
> > +++ b/arch/mips/kernel/traps.c
> > @@ -1451,6 +1451,9 @@ static void *set_vi_srs_handler(int n, vi_handler_t
> > addr, int srs)
> >                 *w = (*w & 0xffff0000) | (((u32)handler >> 16) & 0xffff);
> >                 w = (u32 *)(b + ori_offset);
> >                 *w = (*w & 0xffff0000) | ((u32)handler & 0xffff);
> > +               /* FIXME: need flash data cache, for timer irq */
> > +               if (n == 7)
> > +                       flush_data_cache_page((unsigned int)b);
> >                 local_flush_icache_range((unsigned long)b,
> >                                          (unsigned long)(b+handler_len));
>
> The call local_flush_icache_range should already flushes the cache and
> there should be no reason why a 2nd range makes it any better - or why
> it would only be needed for irq 7 - and the timer isn't necessarily
> always irq 7.
>
> What is your hardware platform and processor?
>
>  Ralf
>
>

--00151750da36ea20f9049f08a32e
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

HI Ralf:<br>=C2=A0=C2=A0 It&#39;s still a hack here, but that&#39;s solve m=
y problem.<br>The Compare/Count timer interrupt here is connect to irq7 her=
e, <br>which means interrupt occurs hardware will set CAUSE TI bit to 7.<br=
>=C2=A0 The hardware, it&#39;s a integrated SOC platform shipped with mips2=
4kc processor, <br>
Still no public document released yet.<br>=C2=A0=C2=A0 What&#39;s could exp=
lain that flush_data_cache_page fix the problem? <br>Cache misconfiguration=
?<br>=C2=A0=C2=A0 Thanks<br><br>Dennis<br><br><div class=3D"gmail_quote">On=
 Sun, Mar 20, 2011 at 1:22 AM, Ralf Baechle <span dir=3D"ltr">&lt;<a href=
=3D"mailto:ralf@linux-mips.org">ralf@linux-mips.org</a>&gt;</span> wrote:<b=
r>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex;"><div class=3D"im">On Sat, Mar 19, 2011 at 0=
8:42:17AM +0800, Dennis.Yxun wrote:<br>
<br>
&gt; HI ALL:<br>
&gt; =C2=A0 Again, found that when come to set vect irq 7, do additional da=
ta flush<br>
&gt; fix my problem, here is the patch<br>
&gt;<br>
&gt; diff --git a/arch/mips/kernel/traps.c b/arch/mips/kernel/traps.c<br>
&gt; index e971043..850ce58 100644<br>
&gt; --- a/arch/mips/kernel/traps.c<br>
&gt; +++ b/arch/mips/kernel/traps.c<br>
&gt; @@ -1451,6 +1451,9 @@ static void *set_vi_srs_handler(int n, vi_handle=
r_t<br>
&gt; addr, int srs)<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 *w =3D (*w &am=
p; 0xffff0000) | (((u32)handler &gt;&gt; 16) &amp; 0xffff);<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 w =3D (u32 *)(=
b + ori_offset);<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 *w =3D (*w &am=
p; 0xffff0000) | ((u32)handler &amp; 0xffff);<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* FIXME: need flas=
h data cache, for timer irq */<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (n =3D=3D 7)<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 flush_data_cache_page((unsigned int)b);<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 local_flush_ic=
ache_range((unsigned long)b,<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0(unsigned long)(b+handler_len));<br>
<br>
</div>The call local_flush_icache_range should already flushes the cache an=
d<br>
there should be no reason why a 2nd range makes it any better - or why<br>
it would only be needed for irq 7 - and the timer isn&#39;t necessarily<br>
always irq 7.<br>
<br>
What is your hardware platform and processor?<br>
<font color=3D"#888888"><br>
 =C2=A0Ralf<br>
<br>
</font></blockquote></div><br>

--00151750da36ea20f9049f08a32e--
