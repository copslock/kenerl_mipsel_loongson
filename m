Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 21 Apr 2009 14:46:32 +0100 (BST)
Received: from an-out-0708.google.com ([209.85.132.246]:27655 "EHLO
	an-out-0708.google.com") by ftp.linux-mips.org with ESMTP
	id S20024295AbZDUNqY (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 21 Apr 2009 14:46:24 +0100
Received: by an-out-0708.google.com with SMTP id c37so1229917anc.24
        for <linux-mips@linux-mips.org>; Tue, 21 Apr 2009 06:46:19 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type;
        bh=ikcvw7DMPrfmiZwDLYAHggi8po7ElZSaUQpYLV0IBfM=;
        b=vHBOG7PIS+8g8j1VrBFuJ7IpD1LoKcbZ2kV9qR45ZiMI6Fj5r63+DKgAy6lCWtS0iD
         zSxV9lXIzOvDk61Bu4D7Gx1GkHOpSm008Yn4h4uzRzFu+x41vuRqVZLwA9uPO3/BtXP8
         dY2lqU3fBi2I+zhxmo0ut6Tvs+fEAfb73eKfM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=IqkUOYeIyxw8zs/SUwb8BFpYXh3lPLa1RZdWyuFq9b3AevUazkhn5viRwLuNsvGZXI
         H1RHKoPddyn6rtrVD7H9n6BiBCw/40W722X6tJwlOU7E3Net6VR7+U0/YLdZ7MrIQ2WN
         7ozjrf3gUVcbnBk6MN2ITWDYUBOL/IGu+j6tk=
MIME-Version: 1.0
Received: by 10.100.164.12 with SMTP id m12mr704322ane.88.1240321579501; Tue, 
	21 Apr 2009 06:46:19 -0700 (PDT)
In-Reply-To: <49EDC965.60507@paralogos.com>
References: <d77cedf30904142309na4355e6w63ecea63b0966c92@mail.gmail.com>
	 <200904201100.39164.florian@openwrt.org>
	 <20090420.085929.-1089997132.imp@bsdimp.com>
	 <d77cedf30904202350g602c740dh26641f145677ddd5@mail.gmail.com>
	 <49EDC965.60507@paralogos.com>
Date:	Tue, 21 Apr 2009 19:16:19 +0530
Message-ID: <d77cedf30904210646v2ea71655ye83c8b57fecab761@mail.gmail.com>
Subject: Re: in mips how to change the start address to the new second boot 
	loader ?
From:	nagalakshmi veeramallu <lucky.veeramallu@gmail.com>
To:	"Kevin D. Kissell" <kevink@paralogos.com>
Cc:	"M. Warner Losh" <imp@bsdimp.com>, florian@openwrt.org,
	linux-mips@linux-mips.org
Content-Type: multipart/alternative; boundary=0016e644c37e2748f6046810df8c
Return-Path: <lucky.veeramallu@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22398
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: lucky.veeramallu@gmail.com
Precedence: bulk
X-list: linux-mips

--0016e644c37e2748f6046810df8c
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

hi,
         --          if we set environmental variable =93start=94 as =93go
new_address=94, will it go directly to the new bootloader in the next
power-on.

what about using system environmental "start" ,can you tell me at which
context after power on environmental variables come onto picture.

Regards,
Lucky

On Tue, Apr 21, 2009 at 6:55 PM, Kevin D. Kissell <kevink@paralogos.com>wro=
te:

>  nagalakshmi veeramallu wrote:
>
>  -           Mips atlas board has jumper  which will redirect accesses
> from =93Bootcode=94 range to either =93Monitor flash=94 (0x1e000000) or t=
he upper
> 4MB of =93System flash=94 (0x1dc00000) based on jumper settings. if my km=
c
> board have some jumper like this, can I redirect the start address.
>
> Of course, what is really happening there is that the Atlas boot ROM has =
a
> vector at 0x1fc00000 which reads the jumper and jumps to one address or t=
he
> other depending on the jumper setting. If you control what is in ROM at
> 0x1fc00000 and you have a software-readable jumper on your KMC board, you
> can do the same thing.
>
>           Regards,
>
>           Kevin K.
>
>

--0016e644c37e2748f6046810df8c
Content-Type: text/html; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

hi,<div><br></div><div>=A0=A0 =A0 =A0 =A0 -<span class=3D"Apple-style-span"=
 style=3D"border-collapse: collapse; "><span style=3D"font-size: 10pt; font=
-family: Arial; color: black; "><span>-<span style=3D"font: normal normal n=
ormal 7pt/normal &#39;Times New Roman&#39;; ">=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0</span></span></span><span style=3D"font-size: 10pt; font-family: Arial;=
 color: black; ">if we set environmental variable =93start=94 as =93go new_=
address=94, will it go directly to the new bootloader in the next power-on.=
</span></span></div>
<div><div><span class=3D"Apple-style-span" style=3D"border-collapse: collap=
se;"><br></span></div><div>what about using system environmental &quot;star=
t&quot; ,can you tell me at which context after power on environmental vari=
ables come onto picture.</div>
<div><br></div><div>Regards,</div><div>Lucky<br><br><div class=3D"gmail_quo=
te">On Tue, Apr 21, 2009 at 6:55 PM, Kevin D. Kissell <span dir=3D"ltr">&lt=
;<a href=3D"mailto:kevink@paralogos.com">kevink@paralogos.com</a>&gt;</span=
> wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex;">


 =20
 =20

<div bgcolor=3D"#ffffff" text=3D"#000000"><div class=3D"im">
nagalakshmi veeramallu wrote:
<blockquote type=3D"cite">
  <p><span style=3D"font-size:10pt;font-family:Arial;color:black"><span></s=
pan></span></p>
  <p style=3D"margin-left:0.5in;text-indent:-0.25in"><span style=3D"font-si=
ze:10pt;font-family:Arial;color:black"><span>-<span style=3D"font-family:&q=
uot;Times New Roman&quot;;font-style:normal;font-variant:normal;font-weight=
:normal;font-size:7pt;line-height:normal;font-size-adjust:none;font-stretch=
:normal">=A0=A0=A0=A0=A0=A0=A0=A0=A0
  </span></span></span><span style=3D"font-size:10pt;font-family:Arial;colo=
r:black"><span>=A0</span>Mips atlas board has jumper
  <span>=A0</span>which will redirect accesses from =93Bootcode=94
range to either =93Monitor flash=94 (0x1e000000) or the upper 4MB of
=93System flash=94
(0x1dc00000) based on jumper settings. if<span>=A0</span>my kmc
board have some jumper like this, can I redirect the start address.</span><=
/p>
</blockquote></div>
Of course, what is really happening there is that the Atlas boot ROM
has a vector at 0x1fc00000 which reads the jumper and jumps to one
address or the other depending on the jumper setting. If you control
what is in ROM at 0x1fc00000 and you have a software-readable jumper on
your KMC board, you can do the same thing.<br>
<br>
=A0=A0=A0 =A0=A0 =A0=A0 Regards,<br>
<br>
=A0=A0=A0 =A0=A0 =A0=A0 Kevin K.<br>
<br>
</div>

</blockquote></div><br></div></div>

--0016e644c37e2748f6046810df8c--
