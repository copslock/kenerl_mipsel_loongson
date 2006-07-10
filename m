Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 11 Jul 2006 00:00:45 +0100 (BST)
Received: from mms3.broadcom.com ([216.31.210.19]:51470 "EHLO
	MMS3.broadcom.com") by ftp.linux-mips.org with ESMTP
	id S8133816AbWGJXAf (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 11 Jul 2006 00:00:35 +0100
Received: from 10.10.64.154 by MMS3.broadcom.com with ESMTP (Broadcom
 SMTP Relay (Email Firewall v6.2.0)); Mon, 10 Jul 2006 16:00:16 -0700
X-Server-Uuid: B238DE4C-2139-4D32-96A8-DD564EF2313E
Received: by mail-irva-10.broadcom.com (Postfix, from userid 47) id
 9224D2B0; Mon, 10 Jul 2006 16:00:16 -0700 (PDT)
Received: from mail-irva-8.broadcom.com (mail-irva-8 [10.10.64.221]) by
 mail-irva-10.broadcom.com (Postfix) with ESMTP id 6DA1B2AF; Mon, 10 Jul
 2006 16:00:16 -0700 (PDT)
Received: from mail-sj1-12.sj.broadcom.com (mail-sj1-12.sj.broadcom.com
 [10.16.128.215]) by mail-irva-8.broadcom.com (MOS 3.7.5a-GA) with ESMTP
 id DYL90946; Mon, 10 Jul 2006 16:00:15 -0700 (PDT)
Received: from NT-SJCA-0751.brcm.ad.broadcom.com (nt-sjca-0751
 [10.16.192.221]) by mail-sj1-12.sj.broadcom.com (Postfix) with ESMTP id
 6B95420502; Mon, 10 Jul 2006 16:00:15 -0700 (PDT)
Received: from NT-SJCA-0752.brcm.ad.broadcom.com ([10.16.192.222]) by
 NT-SJCA-0751.brcm.ad.broadcom.com with Microsoft
 SMTPSVC(6.0.3790.1830); Mon, 10 Jul 2006 16:00:15 -0700
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Subject: [PATCH] update sb1250-swarm-defconfig
Date:	Mon, 10 Jul 2006 16:00:12 -0700
Message-ID: <710F16C36810444CA2F5821E5EAB7F230675D0@NT-SJCA-0752.brcm.ad.broadcom.com>
Thread-Topic: [PATCH] update sb1250-swarm-defconfig
Thread-Index: AcakdJmLnbao0lI4QU641ETr8/MmgQ==
From:	"Manoj Ekbote" <manoje@broadcom.com>
To:	linux-mips@linux-mips.org
cc:	ralf@linux-mips.org
X-OriginalArrivalTime: 10 Jul 2006 23:00:15.0346 (UTC)
 FILETIME=[9B30B520:01C6A474]
X-TMWD-Spam-Summary: SEV=1.1; DFV=A2006071013; IFV=2.0.6,4.0-7;
 RPD=4.00.0004;
 RPDID=303030312E30413039303230362E34344232443942452E303032442D412D;
 ENG=IBF; TS=20060710230018; CAT=NONE; CON=NONE;
X-MMS-Spam-Filter-ID: A2006071013_4.00.0004_2.0.6,4.0-7
X-WSS-ID: 68AC038A1OO4149131-01-01
Content-Type: multipart/alternative;
 boundary="----_=_NextPart_001_01C6A474.9B081E80"
Return-Path: <manoje@broadcom.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11967
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: manoje@broadcom.com
Precedence: bulk
X-list: linux-mips

This is a multi-part message in MIME format.

------_=_NextPart_001_01C6A474.9B081E80
Content-Type: text/plain;
 charset=us-ascii
Content-Transfer-Encoding: quoted-printable

Hi,

 This patch updates sb1250-swarm-defconfig file to default to Sibyte Bn
silicon as the PASS_1 processors are very old.

=20
--- a/arch/mips/configs/sb1250-swarm_defconfig=20
+++ b/arch/mips/configs/sb1250-swarm_defconfig=20
@@ -66,9 +66,9 @@
 # CONFIG_TOSHIBA_RBTX4938 is not set
 CONFIG_SIBYTE_SB1250=3Dy
 CONFIG_SIBYTE_SB1xxx_SOC=3Dy
-CONFIG_CPU_SB1_PASS_1=3Dy
+# CONFIG_CPU_SB1_PASS_1 is not set
 # CONFIG_CPU_SB1_PASS_2_1250 is not set
-# CONFIG_CPU_SB1_PASS_2_2 is not set
+CONFIG_CPU_SB1_PASS_2_2=3Dy
 # CONFIG_CPU_SB1_PASS_4 is not set
 # CONFIG_CPU_SB1_PASS_2_112x is not set
 # CONFIG_CPU_SB1_PASS_3 is not set
=20
=20
-manoj
=20

------_=_NextPart_001_01C6A474.9B081E80
Content-Type: text/html;
 charset=us-ascii
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD>
<META http-equiv=3DContent-Type content=3D"text/html; =
charset=3Dus-ascii">
<META content=3D"MSHTML 6.00.2900.2873" name=3DGENERATOR></HEAD>
<BODY>
<DIV align=3Dleft><FONT face=3DArial size=3D2>
<P class=3DMsoNormal><FONT face=3DArial size=3D2><SPAN=20
style=3D"FONT-SIZE: 10pt; FONT-FAMILY: Arial">Hi,<?xml:namespace prefix =
=3D o ns =3D=20
"urn:schemas-microsoft-com:office:office" =
/><o:p></o:p></SPAN></FONT></P>
<P class=3DMsoNormal><FONT face=3DArial size=3D2><SPAN=20
style=3D"FONT-SIZE: 10pt; FONT-FAMILY: =
Arial"><o:p>&nbsp;</o:p></SPAN></FONT><SPAN=20
style=3D"FONT-SIZE: 10pt; FONT-FAMILY: Arial">This&nbsp;<SPAN=20
class=3D095542718-10072006>patch&nbsp;u</SPAN>pdate<SPAN=20
class=3D095542718-10072006>s</SPAN> sb1250-swarm-defconfig&nbsp;<SPAN=20
class=3D095542718-10072006>file </SPAN>to default to&nbsp;<SPAN=20
class=3D095542718-10072006>Sibyte </SPAN>Bn silicon<SPAN =
class=3D095542718-10072006>=20
as the PASS_1 processors are very old.</SPAN></SPAN></P></FONT></DIV>
<DIV align=3Dleft><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV align=3Dleft><FONT face=3D"Arial Unicode MS" size=3D2>---=20
a/arch/mips/configs/sb1250-swarm_defconfig&nbsp;<BR>+++=20
b/arch/mips/configs/sb1250-swarm_defconfig&nbsp;</FONT></DIV><FONT=20
face=3D"Arial Unicode MS"></FONT><FONT face=3D"Arial Unicode MS">
<DIV align=3Dleft><FONT size=3D2>@@ -66,9 +66,9 @@<BR>&nbsp;#=20
CONFIG_TOSHIBA_RBTX4938 is not=20
set<BR>&nbsp;CONFIG_SIBYTE_SB1250=3Dy<BR>&nbsp;CONFIG_SIBYTE_SB1xxx_SOC=3D=
y<BR>-CONFIG_CPU_SB1_PASS_1=3Dy<BR>+#=20
CONFIG_CPU_SB1_PASS_1 is not set<BR>&nbsp;# CONFIG_CPU_SB1_PASS_2_1250 =
is not=20
set<BR>-# CONFIG_CPU_SB1_PASS_2_2 is not=20
set<BR>+CONFIG_CPU_SB1_PASS_2_2=3Dy<BR>&nbsp;# CONFIG_CPU_SB1_PASS_4 is =
not=20
set<BR>&nbsp;# CONFIG_CPU_SB1_PASS_2_112x is not set<BR>&nbsp;#=20
CONFIG_CPU_SB1_PASS_3 is not set</FONT></DIV>
<DIV align=3Dleft><FONT size=3D2></FONT>&nbsp;</DIV>
<DIV align=3Dleft><FONT size=3D2></FONT>&nbsp;</DIV>
<DIV align=3Dleft></FONT><FONT face=3DArial size=3D2>-m<SPAN=20
class=3D496534422-10072006>a</SPAN>noj</FONT></DIV>
<DIV>&nbsp;</DIV></BODY></HTML>

------_=_NextPart_001_01C6A474.9B081E80--
