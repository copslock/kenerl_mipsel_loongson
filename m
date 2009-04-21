Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 21 Apr 2009 15:21:07 +0100 (BST)
Received: from yx-out-1718.google.com ([74.125.44.157]:29029 "EHLO
	yx-out-1718.google.com") by ftp.linux-mips.org with ESMTP
	id S20026873AbZDUOUw (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 21 Apr 2009 15:20:52 +0100
Received: by yx-out-1718.google.com with SMTP id 4so960051yxp.24
        for <linux-mips@linux-mips.org>; Tue, 21 Apr 2009 07:20:48 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type;
        bh=+oCurNygi2RpgrobN1wQAYky/3cn4T2ir040RZr6Ht0=;
        b=Bo1G2wFhbQBMLdfUgT+jLnCWuW9O+OMa+xZR41YI7H59049+xNA21FRDRMGix7QYzg
         xfobKRPypPRlRzi6PfPmhkPGLdcfHSeF6buWyhWw0TsfkP3XkEJiRWWFMs1XEAcZv4ZL
         ur7+9kcJcdNfjbmDjNrOb/7EASSL+YRLtauEc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=fuiWAax1aU9lHvb9vGCk6HloE2tFkdI3brgQpt72i3UJ8UTPektWdp7Qe7qzQlwBCg
         EwlwBvKGcNR2iLzgtMukzZVTpyc8+JfQiII2vy83G/KHTZbAyglSTmxk/Tvdzq/BGpHh
         UpK7Fhs5lBPKJDYTOXuF1JjpZyuYbvgcLjmEw=
MIME-Version: 1.0
Received: by 10.100.46.10 with SMTP id t10mr9713621ant.116.1240323648511; Tue, 
	21 Apr 2009 07:20:48 -0700 (PDT)
In-Reply-To: <10f740e80904210710sdc9e5c2ic310e689ca6677b5@mail.gmail.com>
References: <d77cedf30904142309na4355e6w63ecea63b0966c92@mail.gmail.com>
	 <200904201100.39164.florian@openwrt.org>
	 <20090420.085929.-1089997132.imp@bsdimp.com>
	 <d77cedf30904202350g602c740dh26641f145677ddd5@mail.gmail.com>
	 <49EDC965.60507@paralogos.com>
	 <d77cedf30904210646v2ea71655ye83c8b57fecab761@mail.gmail.com>
	 <10f740e80904210710sdc9e5c2ic310e689ca6677b5@mail.gmail.com>
Date:	Tue, 21 Apr 2009 19:50:48 +0530
Message-ID: <d77cedf30904210720m1a5862ccx220fea16f3a0f01a@mail.gmail.com>
Subject: Re: in mips how to change the start address to the new second boot 
	loader ?
From:	nagalakshmi veeramallu <lucky.veeramallu@gmail.com>
To:	Geert Uytterhoeven <geert@linux-m68k.org>
Cc:	"Kevin D. Kissell" <kevink@paralogos.com>,
	"M. Warner Losh" <imp@bsdimp.com>, florian@openwrt.org,
	linux-mips@linux-mips.org
Content-Type: multipart/alternative; boundary=001485f945a679e0870468115a2d
Return-Path: <lucky.veeramallu@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22400
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: lucky.veeramallu@gmail.com
Precedence: bulk
X-list: linux-mips

--001485f945a679e0870468115a2d
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

Hi,
will this approach work? if i used "start" environmental variable will it g=
o
to new boot loader address directly.

Regards,
Lucky


On Tue, Apr 21, 2009 at 7:40 PM, Geert Uytterhoeven <geert@linux-m68k.org>w=
rote:

> On Tue, Apr 21, 2009 at 15:46, nagalakshmi veeramallu
> <lucky.veeramallu@gmail.com> wrote:
> > hi,
> >          --          if we set environmental variable =93start=94 as =
=93go
> > new_address=94, will it go directly to the new bootloader in the next
> > power-on.
> > what about using system environmental "start" ,can you tell me at which
> > context after power on environmental variables come onto picture.
>
> Environment variables are parsed by the boot loader, whose code resides a=
t,
> guess what, 0x1fc00000...
>
> > On Tue, Apr 21, 2009 at 6:55 PM, Kevin D. Kissell <kevink@paralogos.com=
>
> > wrote:
> >>
> >> nagalakshmi veeramallu wrote:
> >>
> >> -           Mips atlas board has jumper  which will redirect accesses
> from
> >> =93Bootcode=94 range to either =93Monitor flash=94 (0x1e000000) or the=
 upper 4MB
> of
> >> =93System flash=94 (0x1dc00000) based on jumper settings. if my kmc bo=
ard
> have
> >> some jumper like this, can I redirect the start address.
> >>
> >> Of course, what is really happening there is that the Atlas boot ROM h=
as
> a
> >> vector at 0x1fc00000 which reads the jumper and jumps to one address o=
r
> the
> >> other depending on the jumper setting. If you control what is in ROM a=
t
> >> 0x1fc00000 and you have a software-readable jumper on your KMC board,
> you
> >> can do the same thing.
> >>
> >>           Regards,
> >>
> >>           Kevin K.
> >>
> >
> >
>
>
>
> --
> Gr{oetje,eeting}s,
>
>                                                Geert
>
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 --
> geert@linux-m68k.org
>
> In personal conversations with technical people, I call myself a hacker.
> But
> when I'm talking to journalists I just say "programmer" or something like
> that.
>                                                            -- Linus
> Torvalds
>

--001485f945a679e0870468115a2d
Content-Type: text/html; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

<div>Hi,</div>will this=A0approach=A0work? if i used &quot;start&quot; envi=
ronmental variable will it go to new boot loader address directly.<div><br>=
<br></div><div>Regards,</div><div>Lucky</div><div><br></div><div><br><div c=
lass=3D"gmail_quote">
On Tue, Apr 21, 2009 at 7:40 PM, Geert Uytterhoeven <span dir=3D"ltr">&lt;<=
a href=3D"mailto:geert@linux-m68k.org">geert@linux-m68k.org</a>&gt;</span> =
wrote:<br><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;bord=
er-left:1px #ccc solid;padding-left:1ex;">
On Tue, Apr 21, 2009 at 15:46, nagalakshmi veeramallu<br>
<div class=3D"im">&lt;<a href=3D"mailto:lucky.veeramallu@gmail.com">lucky.v=
eeramallu@gmail.com</a>&gt; wrote:<br>
</div><div class=3D"im">&gt; hi,<br>
&gt; =A0=A0 =A0 =A0 =A0 --=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0if we set environme=
ntal variable =93start=94 as =93go<br>
&gt; new_address=94, will it go directly to the new bootloader in the next<=
br>
&gt; power-on.<br>
&gt; what about using system environmental &quot;start&quot; ,can you tell =
me at which<br>
&gt; context after power on environmental variables come onto picture.<br>
<br>
</div>Environment variables are parsed by the boot loader, whose code resid=
es at,<br>
guess what, 0x1fc00000...<br>
<div class=3D"im"><br>
&gt; On Tue, Apr 21, 2009 at 6:55 PM, Kevin D. Kissell &lt;<a href=3D"mailt=
o:kevink@paralogos.com">kevink@paralogos.com</a>&gt;<br>
&gt; wrote:<br>
&gt;&gt;<br>
&gt;&gt; nagalakshmi veeramallu wrote:<br>
&gt;&gt;<br>
&gt;&gt; -=A0=A0=A0=A0=A0=A0=A0=A0=A0 =A0Mips atlas board has jumper =A0whi=
ch will redirect accesses from<br>
&gt;&gt; =93Bootcode=94 range to either =93Monitor flash=94 (0x1e000000) or=
 the upper 4MB of<br>
&gt;&gt; =93System flash=94 (0x1dc00000) based on jumper settings. if=A0my =
kmc board have<br>
&gt;&gt; some jumper like this, can I redirect the start address.<br>
&gt;&gt;<br>
&gt;&gt; Of course, what is really happening there is that the Atlas boot R=
OM has a<br>
&gt;&gt; vector at 0x1fc00000 which reads the jumper and jumps to one addre=
ss or the<br>
&gt;&gt; other depending on the jumper setting. If you control what is in R=
OM at<br>
&gt;&gt; 0x1fc00000 and you have a software-readable jumper on your KMC boa=
rd, you<br>
&gt;&gt; can do the same thing.<br>
&gt;&gt;<br>
&gt;&gt; =A0=A0=A0 =A0=A0 =A0=A0 Regards,<br>
&gt;&gt;<br>
&gt;&gt; =A0=A0=A0 =A0=A0 =A0=A0 Kevin K.<br>
&gt;&gt;<br>
&gt;<br>
&gt;<br>
<br>
<br>
<br>
</div>--<br>
Gr{oetje,eeting}s,<br>
<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0Geert<br>
<font color=3D"#888888"><br>
--<br>
Geert Uytterhoeven -- There&#39;s lots of Linux beyond ia32 -- <a href=3D"m=
ailto:geert@linux-m68k.org">geert@linux-m68k.org</a><br>
<br>
In personal conversations with technical people, I call myself a hacker. Bu=
t<br>
when I&#39;m talking to journalists I just say &quot;programmer&quot; or so=
mething like that.<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0-- Linus Torvalds<br>
</font></blockquote></div><br></div>

--001485f945a679e0870468115a2d--
