Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 17 Oct 2005 04:50:06 +0100 (BST)
Received: from wproxy.gmail.com ([64.233.184.207]:6503 "EHLO wproxy.gmail.com")
	by ftp.linux-mips.org with ESMTP id S8133425AbVJQDts (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 17 Oct 2005 04:49:48 +0100
Received: by wproxy.gmail.com with SMTP id i3so393277wra
        for <linux-mips@linux-mips.org>; Sun, 16 Oct 2005 20:49:46 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:references;
        b=O2SOYR4jueINKMvLWA6rQElpboIkJLprriQH/VjeEh1X0t5SRnXR066aVyzmzcT3c5x+ffzjj0lh8X1n8sXajAj8t+Dcfm9EG17KNn/cOQZ0hOT5yhqjqBpgY4ioSQlxxTLWTtahM6iUt/r/mdASfa93w+8BRS8h9mt02PaMVBo=
Received: by 10.54.79.14 with SMTP id c14mr1681111wrb;
        Sun, 16 Oct 2005 20:49:46 -0700 (PDT)
Received: by 10.54.79.15 with HTTP; Sun, 16 Oct 2005 20:49:46 -0700 (PDT)
Message-ID: <8a58e1120510162049v67eebfc8t853ec3afe3b9d778@mail.gmail.com>
Date:	Mon, 17 Oct 2005 09:19:46 +0530
From:	Ivy green <ivy.mips@gmail.com>
To:	Stuart Longland <redhatter@gentoo.org>
Subject: Re: Linux on BCM7038 ?.
Cc:	linux-mips@linux-mips.org
In-Reply-To: <43508FF5.7030306@gentoo.org>
MIME-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_16932_7889155.1129520986556"
References: <8a58e1120510140631yd33f85dg3e3e9c993555726@mail.gmail.com>
	 <43508FF5.7030306@gentoo.org>
Return-Path: <ivy.mips@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9235
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ivy.mips@gmail.com
Precedence: bulk
X-list: linux-mips

------=_Part_16932_7889155.1129520986556
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi all,

Thanks for you reply and info. Actually i had booted xscale ixp425 processo=
r
based ixdp425 Board ,using 2.4.x kernel. For that i downloaded 2.4.19 kerne=
l
from kernel.org <http://kernel.org> and got the patch from another website
(i forgot the link :( ). . I applied those patches on 2.4.19 kernel and
complied it, it works fine.. For bootloader , i used redboot. So i thought,
there would be some patches available for each MIPS based Platforms also.
I could make a tiny distribution using busybox, thats not all a problem ...
i would like to download source code from Linux/MIPS.org. I want to know, D=
o
i need any other patches to make this kernel running on BCM7038 Platform.
Please feel free to comment ;)

Thanks
Ivy



On 10/15/05, Stuart Longland <redhatter@gentoo.org> wrote:
>
> Ivy green wrote:
> > Hi folks,
> > Is there any Patches already available to apply on
> > kernel (>=3D 2.4.29) ?.
>
> kernel 2.4.29 from kernel.org <http://kernel.org>?? Or kernel 2.4.29 from
> Linux/MIPS.org?
>
> There's a difference... a _big_ difference.
> --
> Stuart Longland (aka Redhatter) .'''.
> Gentoo Linux/MIPS Cobalt and Docs Developer '.'` :
> . . . . . . . . . . . . . . . . . . . . . . .'.'
> http://dev.gentoo.org/~redhatter :.'
>
>
>

------=_Part_16932_7889155.1129520986556
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi all,<br>
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;
Thanks for you reply and info. Actually i had booted xscale ixp425
processor based ixdp425 Board ,using 2.4.x kernel. For that i
downloaded 2.4.19 kernel from <a href=3D"http://kernel.org">kernel.org</a> =
and got the patch from another
website (i forgot the link&nbsp; :(&nbsp; ). .&nbsp; I applied those
patches on 2.4.19 kernel and complied it, it works fine.. For
bootloader , i used redboot.&nbsp; So i thought, there would be
some&nbsp; patches available for each MIPS based Platforms also.<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
I could make a tiny distribution using busybox, thats not all a problem
... i would like to download source code from Linux/MIPS.org.&nbsp; I
want to know, Do i need any other patches&nbsp; to make this kernel
running on BCM7038 Platform.&nbsp; Please feel free to comment ;)<br>
<br>
Thanks <br>
Ivy <br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; <br>
<br><br><div><span class=3D"gmail_quote">On 10/15/05, <b class=3D"gmail_sen=
dername">Stuart Longland</b> &lt;<a href=3D"mailto:redhatter@gentoo.org">re=
dhatter@gentoo.org</a>&gt; wrote:</span><blockquote class=3D"gmail_quote" s=
tyle=3D"border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8e=
x; padding-left: 1ex;">
Ivy green wrote:<br>&gt; Hi folks,<br>&gt;&nbsp;&nbsp; Is there any Patches=
 already available to apply on<br>&gt; kernel (&gt;=3D 2.4.29) ?.<br><br>ke=
rnel 2.4.29 from <a href=3D"http://kernel.org">kernel.org</a>?? Or kernel 2=
.4.29 from Linux/MIPS.org?
<br><br>There's a difference... a _big_ difference.<br>--<br>Stuart Longlan=
d (aka Redhatter)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;.'''.<br>Gentoo Linux/MIPS Cobalt and Docs Develo=
per&nbsp;&nbsp;'.'` :<br>. . . . . . . . . . . . . . . . . . . . . .&nbsp;&=
nbsp; .'.'<br>
<a href=3D"http://dev.gentoo.org/~redhatter">http://dev.gentoo.org/~redhatt=
er</a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; :.'<br><br><br></blockquote></div><br>

------=_Part_16932_7889155.1129520986556--
