Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 11 Dec 2002 23:23:57 +0000 (GMT)
Received: from postfix3-2.free.fr ([213.228.0.169]:233 "EHLO
	postfix3-2.free.fr") by linux-mips.org with ESMTP
	id <S8225241AbSLKXX5>; Wed, 11 Dec 2002 23:23:57 +0000
Received: from yak (lns-p19-18-81-56-73-208.adsl.proxad.net [81.56.73.208])
	by postfix3-2.free.fr (Postfix) with SMTP id 48EB317E69
	for <linux-mips@linux-mips.org>; Thu, 12 Dec 2002 00:23:55 +0100 (CET)
Message-ID: <013b01c2a16c$68385f60$0100a8c0@yak>
From: "nsauzede" <nsauzede@online.fr>
To: "linux-mips" <linux-mips@linux-mips.org>
Subject: linux-mips fbdev
Date: Thu, 12 Dec 2002 00:24:07 +0100
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_NextPart_000_0138_01C2A174.C8F78C60"
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Return-Path: <nsauzede@online.fr>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 873
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: nsauzede@online.fr
Precedence: bulk
X-list: linux-mips

This is a multi-part message in MIME format.

------=_NextPart_000_0138_01C2A174.C8F78C60
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hi list !

I've got an Indy running linux-mips and I wonder if fbdev exists/is =
possible on this platform.
If I remember well, direct framebuffer mmaping like on intel platforms =
for example is not possible because Video Ram is hidden behind SGI =
custom video chips, and video accesses are done by some magic =
incantations..

But the fact is that I can run linux on my box, a gfx penguin logo =
appears at boot, and I can enjoy a huge beautifull mc on the console, so =
I guess some "kind" of framebuffer is there, but not the full-blown =
Geert's-et-al stuff.

So my question is : would it be feasible/easy to implement some kind of =
"stubs" to, at least, simulate a straight framebuffer, with full =
/dev/fb0 stuff, so I could port my fbdev userspace stuff to my Indy ???

Sorry if the answer is obvious..

Thanks so much to all of you linux-mips-gurus for what has been done !!

Nicolas Sauzede.

ps : in case the answer is : No; would it be hard for newbies like me to =
enable userspace apps to access video screen (just like with fbdev, but =
without it), ie : be able to do some bitblt() or such ? I've tried to =
copy/paste some kernel fragments that "seems" to do the voodoo-like =
video accesses, just to set some pixels on screen, but all I could =
obtain was : entire screen corrupted or even crash (no BSOD here though =
<whew> ;)


------=_NextPart_000_0138_01C2A174.C8F78C60
Content-Type: text/html;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD>
<META http-equiv=3DContent-Type content=3D"text/html; =
charset=3Diso-8859-1">
<META content=3D"MSHTML 6.00.2600.0" name=3DGENERATOR>
<STYLE></STYLE>
</HEAD>
<BODY bgColor=3D#ffffff>
<DIV><FONT face=3DArial size=3D2>Hi list !</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>I've got an Indy running linux-mips and =
I wonder if=20
fbdev exists/is possible on this platform.</FONT></DIV>
<DIV><FONT face=3DArial size=3D2>If I remember well, direct framebuffer =
mmaping like=20
on intel platforms for example is not possible because Video Ram is =
hidden=20
behind SGI custom video chips, and video accesses are done by some magic =

incantations..</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>But the fact is that I can run linux on =
my box, a=20
gfx penguin logo appears at boot, and I can enjoy a huge beautifull mc =
on the=20
console, so I guess some "kind" of framebuffer is there, but not the =
full-blown=20
Geert's-et-al stuff.</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>So my question is : would it be =
feasible/easy to=20
implement some kind of "stubs" to, at least, simulate a straight =
framebuffer,=20
with full /dev/fb0 stuff, so I could port my fbdev userspace stuff to my =
Indy=20
???</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>Sorry if the answer is =
obvious..</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>Thanks&nbsp;so much to all of you =
linux-mips-gurus=20
for what has been done !!</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>Nicolas Sauzede.</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>ps : in case the answer is : No; would =
it be hard=20
for newbies like me to enable userspace apps to access video screen =
(just like=20
with fbdev, but without it), ie : be able to do some bitblt() or such ? =
I've=20
tried to copy/paste some kernel fragments that "seems" to do the =
voodoo-like=20
video accesses, just to set some pixels on screen, but all I could =
obtain was :=20
entire screen corrupted or even crash (no BSOD here though &lt;whew&gt;=20
;)</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV></BODY></HTML>

------=_NextPart_000_0138_01C2A174.C8F78C60--
