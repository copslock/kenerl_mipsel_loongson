Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 01 Jul 2005 06:21:19 +0100 (BST)
Received: from adsl-67-116-42-147.dsl.sntc01.pacbell.net ([IPv6:::ffff:67.116.42.147]:52229
	"EHLO avtrex.com") by linux-mips.org with ESMTP id <S8226122AbVGAFVC>;
	Fri, 1 Jul 2005 06:21:02 +0100
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C57DFC.D8A9ACDA"
Subject: RFH:  What are the semantics of writeb() and friends?
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Date:	Thu, 30 Jun 2005 22:22:17 -0700
Message-ID: <01049E563C8ECC43AD6B53A5AF419B38098BD2@avtrex-server2.hq2.avtrex.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: What are the semantics of writeb() and friends?
thread-index: AcV9/NiK6F9uD0lyR+2aPP/vqUOfgw==
From:	"David Daney" <ddaney@avtrex.com>
To:	<linux-mips@linux-mips.org>
Return-Path: <ddaney@avtrex.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8287
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@avtrex.com
Precedence: bulk
X-list: linux-mips

This is a multi-part message in MIME format.

------_=_NextPart_001_01C57DFC.D8A9ACDA
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

In this thread:
=20
http://www.linux-mips.org/cgi-bin/mesg.cgi?a=3Dlinux-mips&i=3D42C1C6EA.50=
80709%40avtrex.com
=20
I relate the problems I was having with the Intel e100 driver on a new =
2.6.12 port to a 4ke based system.
=20
My new question is:  What are the semantics of writeb(), writel() et =
al.?  I would assume that the effects of these must be in the same order =
that they were issued, and that any hardware write back queue cannot =
combine or merge them in any way.  Is that correct?
=20
=20
A second question I have is:  What is the difference in the semantics of =
wbflush() and wmb()?  For my CPU they both evaluate to the same thing =
(the 'sync' instruction).  So for my own sake I could use either, but =
depending on the situation I assume that one would be used over the =
other.
=20
Thanks,
David Daney.

------_=_NextPart_001_01C57DFC.D8A9ACDA
Content-Type: text/html;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN"><HTML =
DIR=3Dltr><HEAD><META HTTP-EQUIV=3D"Content-Type" CONTENT=3D"text/html; =
charset=3Diso-8859-1"></HEAD><BODY><DIV><FONT face=3D'Arial' =
color=3D#000000 size=3D2>In this thread:</FONT></DIV>=0A=
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>=0A=
<DIV><FONT face=3DArial color=3D#000000 size=3D2><A =0A=
href=3D"http://www.linux-mips.org/cgi-bin/mesg.cgi?a=3Dlinux-mips&amp;i=3D=
42C1C6EA.5080709%40avtrex.com">http://www.linux-mips.org/cgi-bin/mesg.cgi=
?a=3Dlinux-mips&amp;i=3D42C1C6EA.5080709%40avtrex.com</A></FONT></DIV>=0A=
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>=0A=
<DIV><FONT face=3DArial size=3D2>I relate the problems I was having with =
the Intel =0A=
e100 driver on a new 2.6.12 port to a 4ke based system.</FONT></DIV>=0A=
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>=0A=
<DIV><FONT face=3DArial size=3D2>My new question is:&nbsp; What are the =
semantics of =0A=
writeb(), writel() et al.?&nbsp; I would assume that the effects of =
these must =0A=
be in the same order that they were issued, and that any hardware write =
back =0A=
queue cannot combine or merge them in any way.&nbsp; Is that =0A=
correct?</FONT></DIV>=0A=
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>=0A=
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>=0A=
<DIV><FONT face=3DArial size=3D2>A second question I have is:&nbsp; What =
is the =0A=
difference in the semantics of wbflush() and wmb()?&nbsp; For my CPU =
they both =0A=
evaluate to the same thing (the 'sync' instruction).&nbsp; So for my own =
sake I =0A=
could use either, but depending on the situation I assume that one would =
be used =0A=
over the other.</FONT></DIV>=0A=
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>=0A=
<DIV><FONT face=3DArial size=3D2>Thanks,</FONT></DIV>=0A=
<DIV><FONT face=3DArial size=3D2>David Daney.</FONT></DIV></BODY></HTML>
------_=_NextPart_001_01C57DFC.D8A9ACDA--
