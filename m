Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 17 Jan 2007 07:14:51 +0000 (GMT)
Received: from mail152.messagelabs.com ([216.82.253.19]:34180 "EHLO
	mail152.messagelabs.com") by ftp.linux-mips.org with ESMTP
	id S20039164AbXAQHOp (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 17 Jan 2007 07:14:45 +0000
X-VirusChecked:	Checked
X-Env-Sender: sachidananda.naik@ap.sony.com
X-Msg-Ref: server-13.tower-152.messagelabs.com!1169018072!2046510!1
X-StarScan-Version: 5.5.10.7; banners=-,-,-
X-Originating-IP: [121.100.32.134]
Received: (qmail 2661 invoked from network); 17 Jan 2007 07:14:36 -0000
Received: from sggdcex1ns01.sony.com.sg (HELO sggdcex1ns01.sony.com.sg) (121.100.32.134)
  by server-13.tower-152.messagelabs.com with DES-CBC3-SHA encrypted SMTP; 17 Jan 2007 07:14:36 -0000
Received: from sgsesgdcia01.sony.com.sg (sggdcwn1vs01 [43.68.8.23])
	by sggdcex1ns01.sony.com.sg (8.13.7+Sun/8.13.7) with SMTP id l0H7Chit027236;
	Wed, 17 Jan 2007 15:13:09 +0800 (SGT)
Received: from (seagw.sony.com.sg [43.68.8.1]) by sgsesgdcia01.sony.com.sg with smtp
	 id 7a18_203c6a3e_a5fa_11db_9dfa_001372631f16;
	Wed, 17 Jan 2007 15:12:43 +0800
Received: from sgapxbh04.ap.sony.com ([43.68.15.49])
	by sgsesgdcid01.sony.com.sg (8.13.7+Sun/8.13.7) with ESMTP id l0H7Chow009409;
	Wed, 17 Jan 2007 15:12:43 +0800 (SGT)
Received: from insardxms01.ap.sony.com ([43.88.102.10]) by sgapxbh04.ap.sony.com with Microsoft SMTPSVC(6.0.3790.1830); Wed, 17 Jan 2007 15:12:43 +0800
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C73A06.CF1DDAE3"
Subject: OSK ARM board automatic rebooting procedure...
Content-Transfer-Encoding: 7bit
content-class: urn:content-classes:message
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.3790.2826
Date:	Wed, 17 Jan 2007 12:42:12 +0530
Message-ID: <7CC0A4CCB789A841944E316301AD1538399C24@insardxms01.ap.sony.com>
Importance: normal
Priority: normal
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: OSK ARM board automatic rebooting procedure...
Thread-Index: Acc6B6XIRbvTKJVMTQuMquAX+AbQ5w==
From:	"Naik, Sachidananda" <sachidananda.naik@ap.sony.com>
To:	<linux-mips@linux-mips.org>, <linux-parport@lists.infradead.org>,
	<heiko.carstens@de.ibm.com>, <ak@suse.de>,
	<linuxppc-dev@ozlabs.org>, <paulus@samba.org>, <aharkes@cs.cmu.edu>
X-OriginalArrivalTime: 17 Jan 2007 07:12:43.0332 (UTC) FILETIME=[E1A61040:01C73A06]
Return-Path: <sachidananda.naik@ap.sony.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 13686
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sachidananda.naik@ap.sony.com
Precedence: bulk
X-list: linux-mips

This is a multi-part message in MIME format.

------_=_NextPart_001_01C73A06.CF1DDAE3
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi all,
=20
I'm trying to achieve automatic restarting of ARM Board : OMAP 5012 OSK
board. For that I found a link and I went through it.
=20
Here is the link that discusses about Ebony board reboot procedure ::
           =20

http://tree.celinuxforum.org/CelfPubWiki/TargetSwitchControlFromParallel
Port?action=3Dhighlight&value=3Dparallel+port
<http://tree.celinuxforum.org/CelfPubWiki/TargetSwitchControlFromParalle
lPort?action=3Dhighlight&value=3Dparallel+port>=20

In the link :

        1. They have taken DB25 connector ::=20

                            I'm not familiar with this device : Anybody
who knows better about this device please send some information abt it.

        2. They have used the parport device driver :

                            Inside the source file, parport.c in the
link , they are taking some addresses, I wan to kno abt those addresses.

        3. And In the module they have developed, the four pins are
there to connect on the target board, In the OMAP 5012 OSK board where
to connect these=20

            wires.

Please reply with some information.

Thanks and Regards

Sachidananda Naik



-------------------------------------------------------------------
This email is confidential and intended only for the use of the =
individual or entity named above and may contain information that is =
privileged. If you are not the intended recipient, you are notified that =
any dissemination, distribution or copying of this email is strictly =
prohibited. If you have received this email in error, please notify us =
immediately by return email or telephone and destroy the original =
message. - This mail is sent via Sony Asia Pacific Mail Gateway.
-------------------------------------------------------------------

------_=_NextPart_001_01C73A06.CF1DDAE3
Content-Type: text/html;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD>
<META http-equiv=3DContent-Type content=3D"text/html; =
charset=3Dus-ascii">
<META content=3D"MSHTML 6.00.2900.3020" name=3DGENERATOR></HEAD>
<BODY>
<DIV><FONT face=3DArial size=3D2><SPAN class=3D765430807-17012007>Hi=20
all,</SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN=20
class=3D765430807-17012007></SPAN></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2><SPAN class=3D765430807-17012007>I'm =
trying to=20
achieve automatic restarting of ARM&nbsp;Board : OMAP&nbsp;5012 =
OSK&nbsp;board.=20
For that I found a link and I went through it.</SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN=20
class=3D765430807-17012007></SPAN></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2><SPAN class=3D765430807-17012007>Here =
is the link=20
that discusses about Ebony board reboot =
procedure&nbsp;::</SPAN></FONT></DIV>
<DIV><FONT><SPAN class=3D765430807-17012007><FONT face=3DArial=20
size=3D2>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;=20
</FONT>
<P><A=20
href=3D"http://tree.celinuxforum.org/CelfPubWiki/TargetSwitchControlFromP=
arallelPort?action=3Dhighlight&amp;value=3Dparallel+port"><U><FONT=20
color=3D#0000ff><FONT face=3DArial=20
size=3D2>http://tree.celinuxforum.org/CelfPubWiki/TargetSwitchControlFrom=
ParallelPort?action=3Dhighlight&amp;value=3Dparallel+port</FONT></U></FON=
T></A></P>
<P><SPAN class=3D765430807-17012007><FONT face=3DArial size=3D2>In the =
link=20
:</FONT></SPAN></P>
<P><SPAN =
class=3D765430807-17012007>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
<FONT face=3DArial size=3D2>1. They have taken DB25 connector :: =
</FONT></SPAN></P>
<P><SPAN class=3D765430807-17012007><FONT face=3DArial=20
size=3D2>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;=20
I'm not familiar with this device : Anybody who knows better about this =
device=20
please send some information abt it.</FONT></SPAN></P>
<P><SPAN =
class=3D765430807-17012007>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
<FONT face=3DArial size=3D2>2. They have used the parport device driver=20
:</FONT></SPAN></P>
<P><SPAN=20
class=3D765430807-17012007>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
<FONT face=3DArial size=3D2>Inside the source file, parport.c in the =
link , they are=20
taking some addresses, I wan to kno abt those =
addresses.</FONT></SPAN></P>
<P><SPAN=20
class=3D765430807-17012007>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;3.&nbsp;<FONT=20
face=3DArial size=3D2>And In the module they have developed, the four =
pins are there=20
to connect on the target board, In the OMAP&nbsp;5012 OSK&nbsp;board =
where to=20
connect these </FONT></SPAN></P>
<P><SPAN=20
class=3D765430807-17012007>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;=20
<FONT face=3DArial size=3D2>wires.</FONT></SPAN></P>
<P><SPAN class=3D765430807-17012007><FONT face=3DArial size=3D2>Please =
reply with some=20
information.</FONT></SPAN></P>
<P><SPAN class=3D765430807-17012007><FONT face=3DArial size=3D2>Thanks =
and=20
Regards</FONT></SPAN></P>
<P><SPAN class=3D765430807-17012007><FONT face=3DArial =
size=3D2>Sachidananda=20
Naik</FONT></SPAN></P></SPAN></FONT></DIV><p></p><hr><br>This email is =
confidential and intended only for the use of the individual or entity =
named above and may contain information that is privileged. If you are =
not the intended recipient, you are notified that any dissemination, =
distribution or copying of this email is strictly prohibited. If you =
have received this email in error, please notify us immediately by =
return email or telephone and destroy the original message. - This mail =
is sent via Sony Asia Pacific Mail Gateway.<hr></BODY></HTML>

------_=_NextPart_001_01C73A06.CF1DDAE3--
