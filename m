Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 27 Mar 2006 17:10:29 +0100 (BST)
Received: from 209-232-97-206.ded.pacbell.net ([209.232.97.206]:38085 "EHLO
	dns0.mips.com") by ftp.linux-mips.org with ESMTP id S8133487AbWC0QKV
	(ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 27 Mar 2006 17:10:21 +0100
Received: from mercury.mips.com (sbcns-dmz [209.232.97.193])
	by dns0.mips.com (8.12.11/8.12.11) with ESMTP id k2RGKWQf007504;
	Mon, 27 Mar 2006 08:20:32 -0800 (PST)
Received: from grendel (grendel [192.168.236.16])
	by mercury.mips.com (8.13.5/8.13.5) with SMTP id k2RGKURp011968;
	Mon, 27 Mar 2006 08:20:30 -0800 (PST)
Message-ID: <00d501c651ba$ccae9c00$10eca8c0@grendel>
From:	"Kevin D. Kissell" <kevink@mips.com>
To:	"Kishore K" <hellokishore@gmail.com>
Cc:	"Ralf Baechle" <ralf@linux-mips.org>, <linux-mips@linux-mips.org>
References: <f07e6e0603240636x5e496cd2g29316d73490aa300@mail.gmail.com> <20060324165518.GA16567@linux-mips.org> <f07e6e0603250122t6328c09coe37141d14396dc12@mail.gmail.com> <000d01c65022$90d758a0$10eca8c0@grendel> <f07e6e0603270326s7acb75e4x3000bb08de93ffc5@mail.gmail.com> <005901c6519f$b226e060$10eca8c0@grendel> <f07e6e0603270612k39c91d01wa0e08c35fee1922c@mail.gmail.com>
Subject: Re: 2.6.14 - problem with malta
Date:	Mon, 27 Mar 2006 18:23:34 +0200
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_NextPart_000_00D2_01C651CB.8F1496E0"
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1506
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1506
X-Scanned-By: MIMEDefang 2.39
Return-Path: <kevink@mips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10953
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kevink@mips.com
Precedence: bulk
X-list: linux-mips

This is a multi-part message in MIME format.

------=_NextPart_000_00D2_01C651CB.8F1496E0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable


  ----- Original Message -----=20
  From: Kishore K=20
  ...


  I reset the above options, but the same problem persists. If I =
compiled 2.6.10 with default configuration (endian is changed to big =
endian), the board comes up without any problem.



Then the first thing to do is look at the diff between the 2.6.10 =
.config file
and the 2.6.14 .config file and elminate all possible differences.  The =
diff
with my 2.6.9+ .config for Malta could be deceptive, because I've got a
totally hacked up SMTC configuration for the 34K.

        Regards,

        Kevin K.
------=_NextPart_000_00D2_01C651CB.8F1496E0
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
<DIV><FONT face=3DArial size=3D2>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<BLOCKQUOTE=20
style=3D"PADDING-RIGHT: 0px; PADDING-LEFT: 5px; MARGIN-LEFT: 5px; =
BORDER-LEFT: #000000 2px solid; MARGIN-RIGHT: 0px">
  <DIV style=3D"FONT: 10pt arial">----- Original Message ----- </DIV>
  <DIV=20
  style=3D"BACKGROUND: #e4e4e4; FONT: 10pt arial; font-color: =
black"><B>From:</B>=20
  <A title=3Dhellokishore@gmail.com =
href=3D"mailto:hellokishore@gmail.com">Kishore=20
  K</A> </DIV>
  <DIV style=3D"FONT: 10pt arial"><FONT=20
  style=3D"BACKGROUND-COLOR: #e4e4e4">...</FONT></DIV><FONT face=3DArial =
size=3D2>
  <DIV><BR></DIV>
  <DIV></FONT><FONT face=3D"Times New Roman" size=3D3>I reset the above =
options, but=20
  the same problem persists. If I compiled 2.6.10 with default =
configuration=20
  (endian is changed to big endian), the board comes up without any=20
  problem.<BR></FONT></DIV></BLOCKQUOTE>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>Then the first thing to do is look at =
the diff=20
between the 2.6.10 .config file</FONT></DIV>
<DIV><FONT face=3DArial size=3D2>and the 2.6.14 .config file and =
elminate all=20
possible differences.&nbsp; The diff</FONT></DIV>
<DIV><FONT face=3DArial size=3D2>with my 2.6.9+ .config for Malta could =
be=20
deceptive, because I've got a</FONT></DIV>
<DIV><FONT face=3DArial size=3D2>totally hacked up SMTC configuration =
for the=20
34K.</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;=20
Regards,</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial=20
size=3D2>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Kevin=20
K.</FONT></DIV></FONT></DIV></BODY></HTML>

------=_NextPart_000_00D2_01C651CB.8F1496E0--
