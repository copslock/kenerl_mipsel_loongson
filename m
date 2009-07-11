Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 11 Jul 2009 12:51:33 +0200 (CEST)
Received: from mail-vw0-f183.google.com ([209.85.212.183]:64494 "EHLO
	mail-vw0-f183.google.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1492105AbZGKKv1 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sat, 11 Jul 2009 12:51:27 +0200
Received: by vwj13 with SMTP id 13so1246564vwj.22
        for <multiple recipients>; Sat, 11 Jul 2009 03:51:16 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type;
        bh=NyLR2adUB/qCEmKm+5KYYEzR3yCNSy5U87+iS4CaLfQ=;
        b=eZP9zHFcgzYACYF07YTQsLdPODeWC4vXS2sU5QF7P4LZELIbhdsaHQZYYWErNTbDzd
         fRjOnDrfyVWkULG41/j3dideIUibLu6VeKdpvw6Tb0ui/Fdr2rKtiAAfIC7qhWoR2ZxG
         0hulP6MCuwKafbh7k7Y0LcIwfBJCENHDeoVZ0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=TGS/NWJnPJt9eiT4VVwKBbLkhx1ndnUHEaa13HENISGm5o8RX1RgkYeK+qYy4QBrKF
         zlkVPxVSEtSRfB8s1NWxqHcQHeaALJiGRXBmRkqJwV7c+wX1BBCL4x7TGeSVqRN8XWAe
         3HreH4WguOPb1r46FXK1e84nRzTnofIhm4/zU=
MIME-Version: 1.0
Received: by 10.220.97.210 with SMTP id m18mr4333969vcn.50.1247309476425; Sat, 
	11 Jul 2009 03:51:16 -0700 (PDT)
In-Reply-To: <200906280701.32649.florian@openwrt.org>
References: <200904271659.48357.florian@openwrt.org>
	 <200904291512.19297.florian@openwrt.org>
	 <b2b2f2320904290718pe9a28efy9a8af432887778cb@mail.gmail.com>
	 <200906280701.32649.florian@openwrt.org>
Date:	Sat, 11 Jul 2009 04:51:16 -0600
Message-ID: <b2b2f2320907110351o1473fc79xa3926b8af4ffc35@mail.gmail.com>
Subject: Re: [PATCH] fix build failures on msp_irq_slp.c
From:	Shane McDonald <mcdonald.shane@gmail.com>
To:	Florian Fainelli <florian@openwrt.org>
Cc:	Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Content-Type: multipart/alternative; boundary=0016e647560e4471a0046e6bdef8
Return-Path: <mcdonald.shane@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23722
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mcdonald.shane@gmail.com
Precedence: bulk
X-list: linux-mips

--0016e647560e4471a0046e6bdef8
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi Florian:

  My apologies for the delay in replying to your latest prompt -- I've been
on vacation with little internet access.

  Your patch looks correct to me, but as Ralf says, the existing code is a
little suspect.  In my poking around, I've come across three different
versions of this file: the in-tree version, the latest out-of-tree patch
from PMC-Sierra, and an unreleased version from a colleague.  None appear t=
o
be quite correct.  I think I've got enough info, though, to come up with a
good version.

  I'll cook something up this weekend and get it posted.

Shane

On Sat, Jun 27, 2009 at 11:01 PM, Florian Fainelli <florian@openwrt.org>wro=
te:

> Hi Shane,
>
> Le Wednesday 29 April 2009 16:18:11 Shane McDonald, vous avez =E9crit :
> > Hello:
> >
> > On Wed, Apr 29, 2009 at 7:12 AM, Florian Fainelli
> <florian@openwrt.org>wrote:
> > > Hi Ralf, Shane,
> > >
> > > Le Wednesday 29 April 2009 13:58:59 Ralf Baechle, vous avez =E9crit :
> > > > The whole irq chip thing in this file is looking suspect as it trea=
ts
> > > > acknowledging and mask an interrupt as the same thing.  Sure that i=
s
> > > > the right thing?
> > >
> > > That is a quick and dirty fix which compiles, I assumed that the
> function
> > > meant to be called is mask_msp_slp_irq, Shane probably knows more abo=
ut
> > > how this should be fixed.
> >
> > It's been quite a while since I messed around with the 4200.  I'll do
> some
> > digging and ask some questions of guys who probably know better.
>
> Any updates on that patch ? Thank you very much.
> --
> Best regards, Florian Fainelli
> Email : florian@openwrt.org
> http://openwrt.org
> -------------------------------
>

--0016e647560e4471a0046e6bdef8
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi Florian:<br><br>=A0 My apologies for the delay in replying to your lates=
t prompt -- I&#39;ve been on vacation with little internet access.<br><br>=
=A0 Your patch looks correct to me, but as Ralf says, the existing code is =
a little suspect.=A0 In my poking around, I&#39;ve come across three differ=
ent versions of this file: the in-tree version, the latest out-of-tree patc=
h from PMC-Sierra, and an unreleased version from a colleague.=A0 None appe=
ar to be quite correct.=A0 I think I&#39;ve got enough info, though, to com=
e up with a good version.<br>
<br>=A0 I&#39;ll cook something up this weekend and get it posted.<br><br>S=
hane<br><br><div class=3D"gmail_quote">On Sat, Jun 27, 2009 at 11:01 PM, Fl=
orian Fainelli <span dir=3D"ltr">&lt;<a href=3D"mailto:florian@openwrt.org"=
>florian@openwrt.org</a>&gt;</span> wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"border-left: 1px solid rgb(204, =
204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">Hi Shane,<br>
<br>
Le Wednesday 29 April 2009 16:18:11 Shane McDonald, vous avez =E9crit=A0:<b=
r>
<div><div></div><div class=3D"h5">&gt; Hello:<br>
&gt;<br>
&gt; On Wed, Apr 29, 2009 at 7:12 AM, Florian Fainelli<br>
&lt;<a href=3D"mailto:florian@openwrt.org">florian@openwrt.org</a>&gt;wrote=
:<br>
&gt; &gt; Hi Ralf, Shane,<br>
&gt; &gt;<br>
&gt; &gt; Le Wednesday 29 April 2009 13:58:59 Ralf Baechle, vous avez =E9cr=
it :<br>
&gt; &gt; &gt; The whole irq chip thing in this file is looking suspect as =
it treats<br>
&gt; &gt; &gt; acknowledging and mask an interrupt as the same thing. =A0Su=
re that is<br>
&gt; &gt; &gt; the right thing?<br>
&gt; &gt;<br>
&gt; &gt; That is a quick and dirty fix which compiles, I assumed that the =
function<br>
&gt; &gt; meant to be called is mask_msp_slp_irq, Shane probably knows more=
 about<br>
&gt; &gt; how this should be fixed.<br>
&gt;<br>
&gt; It&#39;s been quite a while since I messed around with the 4200. =A0I&=
#39;ll do some<br>
&gt; digging and ask some questions of guys who probably know better.<br>
<br>
</div></div>Any updates on that patch ? Thank you very much.<br>
<div><div></div><div class=3D"h5">--<br>
Best regards, Florian Fainelli<br>
Email : <a href=3D"mailto:florian@openwrt.org">florian@openwrt.org</a><br>
<a href=3D"http://openwrt.org" target=3D"_blank">http://openwrt.org</a><br>
-------------------------------<br>
</div></div></blockquote></div><br>

--0016e647560e4471a0046e6bdef8--
