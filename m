Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 18 Apr 2006 08:00:50 +0100 (BST)
Received: from mx1.razamicroelectronics.com ([63.111.213.197]:8753 "EHLO
	hq-ex-mb01.razamicroelectronics.com") by ftp.linux-mips.org with ESMTP
	id S8133367AbWDRHAm (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 18 Apr 2006 08:00:42 +0100
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C662B7.88BA32FD"
Subject: Can you please help me out  -- Issue with GDB on mips board ????
Date:	Tue, 18 Apr 2006 00:13:03 -0700
Message-ID: <2E96546B3C2C8B4CA739323C6058204A726D89@hq-ex-mb01.razamicroelectronics.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Can you please help me out  -- Issue with GDB on mips board ????
Thread-Index: AcZit4i11tTncAklSFi4o/i9SrUQGQ==
From:	"V Mehul" <vmehul@razamicroelectronics.com>
To:	<linux-mips@linux-mips.org>
Cc:	<dan@debian.org>
Return-Path: <vmehul@razamicroelectronics.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11152
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: vmehul@razamicroelectronics.com
Precedence: bulk
X-list: linux-mips

This is a multi-part message in MIME format.

------_=_NextPart_001_01C662B7.88BA32FD
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable


hi,
       i am working on i386 based board and want some information. i am =
using mips-linux 2.6.6 kernel on target board and linux 2.6.9 on intel =
board. I am running an application under "gdbserver" on the target mips =
board, but am not able to do a single step inside the function. Foll. =
error is displayed
          "ptrace : Input/Output error",

   the  "ptrace.c" file under arch/mips/kernel/ does not have support =
for PTRACE_SINGLESTEP because of which the above error is occuring. =
Though i386,alpha,arm etc. architecture has this support, but why mips =
doesnt have this ?
=20
   I am not a member of this group, so kindly reply me on my personal =
id.

Regards,
Mehul.

------_=_NextPart_001_01C662B7.88BA32FD
Content-Type: text/html;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 3.2//EN">
<HTML>
<HEAD>
<META HTTP-EQUIV=3D"Content-Type" CONTENT=3D"text/html; =
charset=3Diso-8859-1">
<META NAME=3D"Generator" CONTENT=3D"MS Exchange Server version =
6.5.7226.0">
<TITLE>Can you please help me out  -- Issue with GDB on mips board =
????</TITLE>
</HEAD>
<BODY>
<!-- Converted from text/plain format -->
<BR>

<P><FONT SIZE=3D2>hi,<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; i am working on i386 based board =
and want some information. i am using mips-linux 2.6.6 kernel on target =
board and linux 2.6.9 on intel board. I am running an application under =
&quot;gdbserver&quot; on the target mips board, but am not able to do a =
single step inside the function. Foll. error is displayed<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;ptrace : =
Input/Output error&quot;,<BR>
<BR>
&nbsp;&nbsp; the&nbsp; &quot;ptrace.c&quot; file under arch/mips/kernel/ =
does not have support for PTRACE_SINGLESTEP because of which the above =
error is occuring. Though i386,alpha,arm etc. architecture has this =
support, but why mips doesnt have this ?<BR>
<BR>
&nbsp;&nbsp; I am not a member of this group, so kindly reply me on my =
personal id.<BR>
<BR>
Regards,<BR>
Mehul.</FONT>
</P>

</BODY>
</HTML>
------_=_NextPart_001_01C662B7.88BA32FD--
