Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 04 Jul 2003 14:44:23 +0100 (BST)
Received: from wiprom2mx1.wipro.com ([IPv6:::ffff:203.197.164.41]:44789 "EHLO
	wiprom2mx1.wipro.com") by linux-mips.org with ESMTP
	id <S8224821AbTGDNnu>; Fri, 4 Jul 2003 14:43:50 +0100
Received: from m2vwall2 (m2vwall2.wipro.com [164.164.29.236])
	by wiprom2mx1.wipro.com (8.12.9/8.12.9) with SMTP id h64DhFRO021981
	for <linux-mips@linux-mips.org>; Fri, 4 Jul 2003 19:13:20 +0530 (IST)
Received: from blr-m3-msg.wipro.com ([10.114.50.99]) by blr-m1-bh1.wipro.com with Microsoft SMTPSVC(5.0.2195.5329);
	 Fri, 4 Jul 2003 19:13:15 +0530
X-MimeOLE: Produced By Microsoft Exchange V6.0.6249.0
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C34232.37DED859"
Subject: gdbserver on mips
Date: Fri, 4 Jul 2003 19:13:14 +0530
Message-ID: <52C85426D39B314381D76DDD480EEE0CDA556C@blr-m3-msg.wipro.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: gdbserver on mips
Thread-Index: AcNCMjdrDP+3TmhMRCyyeWHdvisioQ==
From: "Rahul Pande" <rahul.pande@wipro.com>
To: <linux-mips@linux-mips.org>
X-OriginalArrivalTime: 04 Jul 2003 13:43:15.0256 (UTC) FILETIME=[380B2B80:01C34232]
Return-Path: <rahul.pande@wipro.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2761
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: rahul.pande@wipro.com
Precedence: bulk
X-list: linux-mips

This is a multi-part message in MIME format.

------_=_NextPart_001_01C34232.37DED859
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable


Hi,
=20
 I am working on a AMD Au1500 based board and want some information. I
am using the Linux 2.4.21pre. The problem happens when i run an
application under "gdbserver" on the board, it does not allow me to
single step into functions/code. The following error is displayed :
                "ptrace : Input/Output error".=20
=20
The  "ptrace.c" file under arch/mips/kernel/ does not have support for
PTRACE_SINGLESTEP because of which the above error is occuring. I would
like to know why single stepping support is not there for mips
architecture under linux, whereas it is there for others like i386,
alpha, arm etc ?
=20
Thanks and Regards,
          rahul
=20

**************************Disclaimer************************************

Information contained in this E-MAIL being proprietary to Wipro Limited is=
=20
'privileged' and 'confidential' and intended for use only by the individual
 or entity to which it is addressed. You are notified that any use, copying=
=20
or dissemination of the information contained in the E-MAIL in any manner=20
whatsoever is strictly prohibited.

***************************************************************************

------_=_NextPart_001_01C34232.37DED859
Content-Type: text/html;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD>
<META HTTP-EQUIV=3D"Content-Type" CONTENT=3D"text/html; charset=
=3Dus-ascii">
<TITLE>Message</TITLE>

<META content=3D"MSHTML 5.50.4807.2300" name=3DGENERATOR></HEAD>
<BODY>
<DIV>
<DIV><FONT face=3DArial size=3D2><SPAN=20
class=3D720301808-04072003>Hi,</SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN=20
class=3D720301808-04072003></SPAN></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial><FONT size=3D2><SPAN class=
=3D720301808-04072003>&nbsp;I=20
am&nbsp;<SPAN class=3D646113813-04072003>working on</SPAN>&nbsp;<SPAN=20
class=3D646113813-04072003>a AMD Au1500&nbsp;based board</SPAN>&nbsp;and=
 want some=20
information. I am using the Linux <SPAN=20
class=3D646113813-04072003>2.4.21pre</SPAN>. The problem happens when i run=
 an=20
application&nbsp;under "gdbserver" on the </SPAN><SPAN=20
class=3D720301808-04072003>board, it does not allow me to single step into=
=20
functions/code. The&nbsp;following error is displayed=20
:</SPAN></FONT></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN=20
class=
=3D720301808-04072003>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
"ptrace : Input/Output error". </SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN=20
class=3D720301808-04072003></SPAN></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2><SPAN class=3D720301808-04072003>The=
 &nbsp;"ptrace.c"=20
file under arch/mips/kernel/ does not have support for PTRACE_SINGLESTEP=
 because=20
of which the above error is occuring. I would like to know why&nbsp;single=
=20
stepping support&nbsp;is not there for mips architecture under linux,=
 whereas it=20
is there for others like i386, alpha, arm etc ?</SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN=20
class=3D720301808-04072003></SPAN></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2><SPAN class=3D720301808-04072003>Thanks=
 and=20
Regards,</SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN=20
class=
=3D720301808-04072003>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;=20
rahul</SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN=20
class=3D720301808-04072003></SPAN></FONT>&nbsp;</DIV></DIV></BODY></HTML>
<table><tr><td bgcolor=3D#ffffff><font color=
=3D#000000><pre>**************************Disclaimer***********************=
*************

Information contained in this E-MAIL being proprietary to Wipro Limited is=
=20
'privileged' and 'confidential' and intended for use only by the individual
 or entity to which it is addressed. You are notified that any use, copying=
=20
or dissemination of the information contained in the E-MAIL in any manner=20
whatsoever is strictly prohibited.

***************************************************************************
</pre></font></td></tr></table>
------_=_NextPart_001_01C34232.37DED859--
