Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 12 Dec 2002 07:05:49 +0000 (GMT)
Received: from smtp-send.myrealbox.com ([192.108.102.143]:37758 "EHLO
	smtp-send.myrealbox.com") by linux-mips.org with ESMTP
	id <S8225218AbSLLHFs>; Thu, 12 Dec 2002 07:05:48 +0000
Received: from GILAD yaelgilad@smtp-send.myrealbox.com [194.90.64.161]
	by smtp-send.myrealbox.com with NetMail SMTP Agent $Revision:   3.21  $ on Novell NetWare;
	Thu, 12 Dec 2002 00:05:43 -0700
From: "yaelgilad" <yaelgilad@myrealbox.com>
To: <linux-mips@linux-mips.org>
Subject: R_MIPS_26 etc.
Date: Thu, 12 Dec 2002 09:07:27 +0200
Message-ID: <ECEPLLMMNGHMFBLHCLMAOEDMDGAA.yaelgilad@myrealbox.com>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_NextPart_000_000E_01C2A1BD.E4BD0940"
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2911.0)
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Return-Path: <yaelgilad@myrealbox.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 878
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yaelgilad@myrealbox.com
Precedence: bulk
X-list: linux-mips

This is a multi-part message in MIME format.

------=_NextPart_000_000E_01C2A1BD.E4BD0940
Content-Type: text/plain;
	charset="windows-1255"
Content-Transfer-Encoding: 7bit

Looking in the assembly code of my driver, I see the following
pattern repeating with every function call.
    4ce4: 0c000000  jal 0
      4ce4: R_MIPS_26 rx_wait_packet
(R_MIPS_26 is sometimes replaces by a similar command)
What is R_MIPS_26 ? What are the rest of them ?
I am guessing it has to do with relocatable addresses, but this specific
function is in the same C file. Marking it as "static" does change the code
and get rid of this command.

TIA
Gilad

P.S. I am building assembler files in two different methods:
- gmake <path-to-file>.lst
- mips-linux-odjdump -x -S <path-to-C-file>  > <path-to-file.lst>
The outputs are similar but not identical.
What's the more "correct" way ?
TIA-2





------=_NextPart_000_000E_01C2A1BD.E4BD0940
Content-Type: text/html;
	charset="windows-1255"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD>
<META http-equiv=3DContent-Type content=3D"text/html; =
charset=3Dwindows-1255">
<META content=3D"MSHTML 6.00.2722.900" name=3DGENERATOR></HEAD>
<BODY>
<DIV><FONT face=3DArial size=3D2><SPAN =
class=3D328594915-10122002>Looking in the=20
assembly code of my driver, I see the following </SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN =
class=3D328594915-10122002>pattern repeating=20
with every function call.</SPAN></FONT></DIV>
<DIV><FONT><SPAN class=3D328594915-10122002>
<DIV><FONT face=3DArial size=3D2>&nbsp;&nbsp;&nbsp; 4ce4: 0c000000&nbsp; =
jal=20
0&nbsp;</FONT></DIV>
<DIV><FONT face=3DArial size=3D2>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 4ce4: =
R_MIPS_26=20
rx_wait_packet</FONT></DIV>
<DIV><FONT><SPAN class=3D328594915-10122002></SPAN><FONT face=3DArial =
size=3D2>(<SPAN=20
class=3D328594915-10122002>R_MIPS_26 is sometimes replaces by a similar=20
command)</SPAN><BR>What is R_MIPS_26 ? What are the rest of them=20
?</FONT></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN class=3D328594915-10122002>I am =
guessing it has=20
to do with relocatable addresses, but this specific</SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN =
class=3D328594915-10122002>function is in the=20
same C file. Marking it as "static" does change the code =
</SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN class=3D328594915-10122002>and =
get rid of this=20
command.</SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN=20
class=3D328594915-10122002></SPAN></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2><SPAN=20
class=3D328594915-10122002>TIA</SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN=20
class=3D328594915-10122002>Gilad</SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN=20
class=3D328594915-10122002></SPAN></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2><SPAN class=3D328594915-10122002>P.S. I =
am building=20
assembler files in two different methods:</SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN class=3D328594915-10122002>- =
gmake=20
&lt;path-to-file&gt;.lst</SPAN></FONT></SPAN></FONT></DIV></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN class=3D328594915-10122002>- =
mips-linux-odjdump=20
-x -S &lt;path-to-C-file&gt;&nbsp; &gt;=20
&lt;path-to-file.lst&gt;</SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN =
class=3D328594915-10122002>The&nbsp;outputs are=20
similar but not identical.</SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN class=3D328594915-10122002>What's =
the more=20
"correct" way ?</SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN=20
class=3D328594915-10122002>TIA-2</SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN=20
class=3D328594915-10122002></SPAN></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2><SPAN=20
class=3D328594915-10122002></SPAN></FONT>&nbsp;</DIV>
<DIV>&nbsp;</DIV>
<DIV>&nbsp;</DIV></BODY></HTML>

------=_NextPart_000_000E_01C2A1BD.E4BD0940--
