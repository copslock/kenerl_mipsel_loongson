Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 27 Mar 2006 13:56:49 +0100 (BST)
Received: from 209-232-97-206.ded.pacbell.net ([209.232.97.206]:59844 "EHLO
	dns0.mips.com") by ftp.linux-mips.org with ESMTP id S8133487AbWC0M4V
	(ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 27 Mar 2006 13:56:21 +0100
Received: from mercury.mips.com (sbcns-dmz [209.232.97.193])
	by dns0.mips.com (8.12.11/8.12.11) with ESMTP id k2RD6VZH006704;
	Mon, 27 Mar 2006 05:06:32 -0800 (PST)
Received: from grendel (grendel [192.168.236.16])
	by mercury.mips.com (8.13.5/8.13.5) with SMTP id k2RD6TGv008742;
	Mon, 27 Mar 2006 05:06:30 -0800 (PST)
Message-ID: <005901c6519f$b226e060$10eca8c0@grendel>
From:	"Kevin D. Kissell" <kevink@mips.com>
To:	"Kishore K" <hellokishore@gmail.com>
Cc:	"Ralf Baechle" <ralf@linux-mips.org>, <linux-mips@linux-mips.org>
References: <f07e6e0603240636x5e496cd2g29316d73490aa300@mail.gmail.com> <20060324165518.GA16567@linux-mips.org> <f07e6e0603250122t6328c09coe37141d14396dc12@mail.gmail.com> <000d01c65022$90d758a0$10eca8c0@grendel> <f07e6e0603270326s7acb75e4x3000bb08de93ffc5@mail.gmail.com>
Subject: Re: 2.6.14 - problem with malta
Date:	Mon, 27 Mar 2006 15:09:33 +0200
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_NextPart_000_0056_01C651B0.74775770"
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1506
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1506
X-Scanned-By: MIMEDefang 2.39
Return-Path: <kevink@mips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10950
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kevink@mips.com
Precedence: bulk
X-list: linux-mips

This is a multi-part message in MIME format.

------=_NextPart_000_0056_01C651B0.74775770
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable


  ----- Original Message -----=20
  Thanks for the suggestion. In my config only CONFIG_CPU_MIPS32_R1 and =
CONFIG_SYS_HAS_CPU_MIPS32_R1 are set. Even then, I observe the same =
problem. I am enclosing the configuration file along with this mail.=20

My own Malta kernels are built from rather old 2.6 sources, so it's not
clear that all the same options are required/possible.  The questions =
that
come to mind for me are:

1) You're booting a big-endian kernel.  The Malta board can be set up
    for either endianness with a DIP switch, but I believe that it ships
    from the factory in little-endian mode.  Have you verified that the
    endianness setup?

2)  You're configuring for hot-pluggable CPUs.  That isn't fully =
supported
     in the old source base I've got.  It may be fixed in 2.6.14, but do =
you
     actually need it on a Malta?

3) You've got support for MIPS MT (the multithreading extension) =
enabled,
    with the slave-virtual-processor boot loader, etc.  This stuff only =
works
    on a 34K core, and could cause severe problems if invoked on a 4Kc.
    At least you don't have SMP/SMTC multi-virtual-processor support
    enabled, which would *definitely* cause a prompt crash on a 4Kc,
    but please turn MIPS_MT off.  If MIPS MT + VPE loader are really
    selected options in the default malta config file, it needs to be =
fixed!

            Regards,

            Kevin K.


------=_NextPart_000_0056_01C651B0.74775770
Content-Type: text/html;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD>
<META http-equiv=3DContent-Type content=3D"text/html; =
charset=3Diso-8859-1">
<META content=3D"MSHTML 6.00.2800.1528" name=3DGENERATOR>
<STYLE></STYLE>
</HEAD>
<BODY bgColor=3D#ffffff>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<BLOCKQUOTE=20
style=3D"PADDING-RIGHT: 0px; PADDING-LEFT: 5px; MARGIN-LEFT: 5px; =
BORDER-LEFT: #000000 2px solid; MARGIN-RIGHT: 0px">
  <DIV style=3D"FONT: 10pt arial">----- Original Message ----- </DIV>
  <DIV style=3D"BACKGROUND: #e4e4e4; FONT: 10pt arial; font-color: =
black">
  <BLOCKQUOTE class=3Dgmail_quote=20
  style=3D"PADDING-LEFT: 1ex; MARGIN: 0pt 0pt 0pt 0.8ex; BORDER-LEFT: =
rgb(204,204,204) 1px solid">
    <DIV style=3D"DIRECTION: ltr">
    <DIV><FONT face=3DArial =
size=3D2></FONT></DIV></DIV></BLOCKQUOTE></DIV>
  <DIV style=3D"BACKGROUND: #e4e4e4; FONT: 10pt arial; font-color: =
black">Thanks=20
  for the suggestion. In my config only <FONT face=3DArial=20
  size=3D2>CONFIG_CPU_MIPS32_R1 and </FONT><FONT face=3DArial=20
  size=3D2>CONFIG_SYS_HAS_CPU_MIPS32_R1 are set. Even then, I observe =
the same=20
  problem. I am enclosing the configuration file along with this mail.=20
  </FONT></DIV>
  <DIV=20
  style=3D"BACKGROUND: #e4e4e4; FONT: 10pt arial; font-color: =
black">&nbsp;</DIV></BLOCKQUOTE>
<DIV style=3D"BACKGROUND: #e4e4e4; FONT: 10pt arial; font-color: =
black">My own=20
Malta kernels are built from rather old 2.6 sources, so it's not</DIV>
<DIV style=3D"BACKGROUND: #e4e4e4; FONT: 10pt arial; font-color: =
black">clear that=20
all the same options are required/possible.&nbsp; The questions =
that</DIV>
<DIV style=3D"BACKGROUND: #e4e4e4; FONT: 10pt arial; font-color: =
black">come to=20
mind for me are:</DIV>
<DIV=20
style=3D"BACKGROUND: #e4e4e4; FONT: 10pt arial; font-color: =
black">&nbsp;</DIV>
<DIV style=3D"BACKGROUND: #e4e4e4; FONT: 10pt arial; font-color: =
black">1) You're=20
booting a big-endian kernel.&nbsp; The Malta board can be set up</DIV>
<DIV=20
style=3D"BACKGROUND: #e4e4e4; FONT: 10pt arial; font-color: =
black">&nbsp;&nbsp;&nbsp;=20
for either endianness with a DIP switch, but I believe that it =
ships</DIV>
<DIV=20
style=3D"BACKGROUND: #e4e4e4; FONT: 10pt arial; font-color: =
black">&nbsp;&nbsp;&nbsp;=20
from the factory in little-endian mode.&nbsp; Have you verified that =
the</DIV>
<DIV=20
style=3D"BACKGROUND: #e4e4e4; FONT: 10pt arial; font-color: =
black">&nbsp;&nbsp;&nbsp;=20
endianness setup?</DIV>
<DIV=20
style=3D"BACKGROUND: #e4e4e4; FONT: 10pt arial; font-color: =
black">&nbsp;</DIV>
<DIV style=3D"BACKGROUND: #e4e4e4; FONT: 10pt arial; font-color: =
black">2)&nbsp;=20
You're configuring for hot-pluggable CPUs.&nbsp; That isn't fully=20
supported</DIV>
<DIV=20
style=3D"BACKGROUND: #e4e4e4; FONT: 10pt arial; font-color: =
black">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;in=20
the old source base I've got.&nbsp; It may be fixed in 2.6.14, but do =
you</DIV>
<DIV=20
style=3D"BACKGROUND: #e4e4e4; FONT: 10pt arial; font-color: =
black">&nbsp;&nbsp;&nbsp;&nbsp;=20
actually need it on a Malta?</DIV>
<DIV=20
style=3D"BACKGROUND: #e4e4e4; FONT: 10pt arial; font-color: =
black">&nbsp;</DIV>
<DIV style=3D"BACKGROUND: #e4e4e4; FONT: 10pt arial; font-color: =
black">3) You've=20
got support for MIPS MT (the multithreading extension) enabled,</DIV>
<DIV=20
style=3D"BACKGROUND: #e4e4e4; FONT: 10pt arial; font-color: =
black">&nbsp;&nbsp;&nbsp;&nbsp;with=20
the slave-virtual-processor boot loader, etc.&nbsp; This stuff only =
works</DIV>
<DIV=20
style=3D"BACKGROUND: #e4e4e4; FONT: 10pt arial; font-color: =
black">&nbsp;&nbsp;&nbsp;=20
on a 34K core, and could cause severe problems if invoked on a =
4Kc.</DIV>
<DIV=20
style=3D"BACKGROUND: #e4e4e4; FONT: 10pt arial; font-color: =
black">&nbsp;&nbsp;&nbsp;&nbsp;At=20
least you don't have SMP/SMTC multi-virtual-processor support</DIV>
<DIV=20
style=3D"BACKGROUND: #e4e4e4; FONT: 10pt arial; font-color: =
black">&nbsp;&nbsp;&nbsp;=20
enabled, which would *definitely* cause a prompt crash on a 4Kc,</DIV>
<DIV=20
style=3D"BACKGROUND: #e4e4e4; FONT: 10pt arial; font-color: =
black">&nbsp;&nbsp;&nbsp;&nbsp;but=20
please turn MIPS_MT off.&nbsp; If&nbsp;MIPS&nbsp;MT&nbsp;+ =
VPE&nbsp;loader are=20
really</DIV>
<DIV=20
style=3D"BACKGROUND: #e4e4e4; FONT: 10pt arial; font-color: =
black">&nbsp;&nbsp;&nbsp;=20
selected options&nbsp;in the&nbsp;default malta config file, it needs to =
be=20
fixed!</DIV>
<DIV=20
style=3D"BACKGROUND: #e4e4e4; FONT: 10pt arial; font-color: =
black">&nbsp;</DIV>
<DIV=20
style=3D"BACKGROUND: #e4e4e4; FONT: 10pt arial; font-color: =
black">&nbsp;&nbsp;&nbsp;=20
&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; Regards,</DIV>
<DIV=20
style=3D"BACKGROUND: #e4e4e4; FONT: 10pt arial; font-color: =
black">&nbsp;</DIV>
<DIV=20
style=3D"BACKGROUND: #e4e4e4; FONT: 10pt arial; font-color: =
black">&nbsp;&nbsp;&nbsp;=20
&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; Kevin K.</DIV><FONT face=3DArial =
size=3D2>
<DIV><BR></DIV></FONT></BODY></HTML>

------=_NextPart_000_0056_01C651B0.74775770--
