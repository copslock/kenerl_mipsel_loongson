Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 24 May 2005 16:35:55 +0100 (BST)
Received: from wip-ec-wd.wipro.com ([IPv6:::ffff:203.101.113.39]:6865 "EHLO
	wip-ec-wd.wipro.com") by linux-mips.org with ESMTP
	id <S8225291AbVEXPfj>; Tue, 24 May 2005 16:35:39 +0100
Received: from wip-ec-wd.wipro.com (localhost.wipro.com [127.0.0.1])
	by localhost (Postfix) with ESMTP id E774C2051E
	for <linux-mips@linux-mips.org>; Tue, 24 May 2005 20:56:45 +0530 (IST)
Received: from blr-ec-bh02.wipro.com (unknown [10.201.50.92])
	by wip-ec-wd.wipro.com (Postfix) with ESMTP id CE0572051D
	for <linux-mips@linux-mips.org>; Tue, 24 May 2005 20:56:45 +0530 (IST)
Received: from chn-snr-bh1.wipro.com ([10.145.50.91]) by blr-ec-bh02.wipro.com with Microsoft SMTPSVC(6.0.3790.211);
	 Tue, 24 May 2005 21:05:28 +0530
Received: from CHN-SNR-MBX01.wipro.com ([10.145.50.181]) by chn-snr-bh1.wipro.com with Microsoft SMTPSVC(6.0.3790.0);
	 Tue, 24 May 2005 21:05:11 +0530
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C56076.2CBC07F0"
Subject: Unable to handle kernel paging request at virtual address 04000460
Date:	Tue, 24 May 2005 21:02:06 +0530
Message-ID: <438662DA48DCAA41B1DF648BD4BD76C0CF563C@CHN-SNR-MBX01.wipro.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Unable to handle kernel paging request at virtual address 04000460
Thread-Index: AcVgdb3pII4bfpg6Saua9o/sQJUI4w==
From:	<raghunathan.venkatesan@wipro.com>
To:	<linux-mips@linux-mips.org>
X-OriginalArrivalTime: 24 May 2005 15:35:11.0726 (UTC) FILETIME=[2C66A8E0:01C56076]
Return-Path: <raghunathan.venkatesan@wipro.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7969
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: raghunathan.venkatesan@wipro.com
Precedence: bulk
X-list: linux-mips

This is a multi-part message in MIME format.

------_=_NextPart_001_01C56076.2CBC07F0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi,
We are facing the following crash in custom Linux 2.4.26 kernel, when we
run a netperf TCP Stream (sizes varying from 64 to 32586 bytes) test
over an IPSEC tunnel created between a host and a VPN server through our
box. This is a Au1550 MIPS32 based board (DB1550 Cabernet board from
AMD). We observe that crash happens randomly (the PrId keeps changing at
each crash), because of burstiness in the netperf tool generated
traffic. Please look into the following capture below. I'd like some
help in debugging this issue. The same set of IPSEC drivers works fine
on a custom Linux 2.4.25 based kernel. Is there a patch that needs to be
applied for Linux 2.4.26 ?=20
=20
Unable to handle kernel paging request at virtual address 04000460, epc
=3D=3D 802501cc, 8Oops in fault.c::do_page_fault, line 206:

$0 : 00000000 1000fc00 00000000 00000001 00000000 8b5f61b2 04000460
00000000

$8 : 00000000 00000000 1a000a08 0301590f 8b37d9d8 00000000 8b37dbd0
aa85e405

$16: 8b6d4780 00000001 8b6d4780 c01ce2a8 00000040 803251c0 00000001
8b37dc80

$24: 00000002 2afcee20 8b37c000 8b37dbb0 00004031 c01ce108

Hi : 00000000

Lo : 00000002

epc : 802501cc Not tainted

Status: 1000fc03

Cause : 00800008

PrId : 03030200

Process l2tpd (pid: 304, stackpage=3D8b37c000)

Stack: 1000fc03 00000002 00000000 8b5f61b2 80335808 c01ce108 1a000a08

0301590f 8b37d9d8 00000000 80255920 80255884 803d9400 803251cc 0000002c

803251ec 80352c88 8b6d4280 00000008 00000001 80255c94 2afcee20 00000006

80325080 8b37c000 8b37dc38 00004031 80255e48 803d9400 803251cc 0000002d

803251ec 80255e48 80255e60 8011b368 8011b368 8026a9e0 8025f444 803252b0

803251ec ...

Call Trace: [<c01ce108>] [<80255920>] [<80255884>] [<80255c94>]
[<80255e48>]

[<80255e48>] [<80255e60>] [<8011b368>] [<8011b368>] [<8026a9e0>]
[<8025f444>]

[<8025601c>] [<80116d90>] [<8011687c>] [<8010101c>] [<8010133c>]
[<801012ec>]

[<8026a7b8>] [<802ca7c8>] [<80255d08>] [<802c9f54>] [<80255e48>]
[<801aab24>]

[<801a3dc4>] [<801aab24>] [<801334c4>] [<801a1ee4>] [<8014fe9c>]
[<8014fe80>]

[<8024c918>] [<801a01a0>] [<801a22f4>] [<8015076c>] [<80150638>]
[<80105f0c>]

[<801046ac>] [<80107688>]

Code: 8e06009c 10c0000e 24030001 <8cc20000> c0450000 00a32023 e0440000
1080fffc 0

Kernel panic: Aiee, killing interrupt handler!

In interrupt handler - not syncing

=20

Any help in debugging is welcome.

Regards,

Raghu


------_=_NextPart_001_01C56076.2CBC07F0
Content-Type: text/html;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD>
<META http-equiv=3DContent-Type content=3D"text/html; =
charset=3Dus-ascii">
<META content=3D"MSHTML 6.00.2900.2627" name=3DGENERATOR></HEAD>
<BODY>
<DIV><FONT face=3DArial size=3D2><SPAN=20
class=3D484181715-24052005>Hi,</SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN class=3D484181715-24052005>We are =
facing the=20
following crash in custom Linux 2.4.26 kernel, when we run a =
netperf&nbsp;TCP=20
Stream (sizes varying from 64 to 32586 bytes)&nbsp;test over an IPSEC =
tunnel=20
created between a host and a VPN server through our box. This is a =
Au1550 MIPS32=20
based board (DB1550 Cabernet board from AMD). We observe that crash =
happens=20
randomly (the PrId keeps changing at each crash), because of burstiness =
in the=20
netperf tool generated traffic. </SPAN></FONT><FONT face=3DArial =
size=3D2><SPAN=20
class=3D484181715-24052005>Please look into the following capture below. =
I'd like=20
some help in debugging this issue. The same set of IPSEC drivers works =
fine on a=20
custom Linux 2.4.25 based kernel. Is there a patch that needs to be =
applied for=20
Linux 2.4.26 ? </SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN=20
class=3D484181715-24052005></SPAN></FONT>&nbsp;</DIV>
<DIV><FONT><SPAN class=3D484181715-24052005>
<P><FONT face=3DArial size=3D2>Unable to handle kernel paging request at =
virtual=20
address 04000460, epc =3D=3D 802501cc, 8Oops in fault.c::do_page_fault, =
line=20
206:</FONT></P>
<P><FONT face=3DArial size=3D2>$0 : 00000000 1000fc00 00000000 00000001 =
00000000=20
8b5f61b2 04000460 00000000</FONT></P>
<P><FONT face=3DArial size=3D2>$8 : 00000000 00000000 1a000a08 0301590f =
8b37d9d8=20
00000000 8b37dbd0 aa85e405</FONT></P>
<P><FONT face=3DArial size=3D2>$16: 8b6d4780 00000001 8b6d4780 c01ce2a8 =
00000040=20
803251c0 00000001 8b37dc80</FONT></P>
<P><FONT face=3DArial size=3D2>$24: 00000002 2afcee20 8b37c000 8b37dbb0 =
00004031=20
c01ce108</FONT></P>
<P><FONT face=3DArial size=3D2>Hi : 00000000</FONT></P>
<P><FONT face=3DArial size=3D2>Lo : 00000002</FONT></P>
<P><FONT face=3DArial size=3D2>epc : 802501cc Not tainted</FONT></P>
<P><FONT face=3DArial size=3D2>Status: 1000fc03</FONT></P>
<P><FONT face=3DArial size=3D2>Cause : 00800008</FONT></P>
<P><FONT face=3DArial size=3D2>PrId : 03030200</FONT></P>
<P><FONT face=3DArial size=3D2>Process l2tpd (pid: 304,=20
stackpage=3D8b37c000)</FONT></P>
<P><FONT face=3DArial size=3D2>Stack: 1000fc03 00000002 00000000 =
8b5f61b2 80335808=20
c01ce108 1a000a08</FONT></P>
<P><FONT face=3DArial size=3D2>0301590f 8b37d9d8 00000000 80255920 =
80255884 803d9400=20
803251cc 0000002c</FONT></P>
<P><FONT face=3DArial size=3D2>803251ec 80352c88 8b6d4280 00000008 =
00000001 80255c94=20
2afcee20 00000006</FONT></P>
<P><FONT face=3DArial size=3D2>80325080 8b37c000 8b37dc38 00004031 =
80255e48 803d9400=20
803251cc 0000002d</FONT></P>
<P><FONT face=3DArial size=3D2>803251ec 80255e48 80255e60 8011b368 =
8011b368 8026a9e0=20
8025f444 803252b0</FONT></P>
<P><FONT face=3DArial size=3D2>803251ec ...</FONT></P>
<P><FONT face=3DArial size=3D2>Call Trace: [&lt;c01ce108&gt;] =
[&lt;80255920&gt;]=20
[&lt;80255884&gt;] [&lt;80255c94&gt;] [&lt;80255e48&gt;]</FONT></P>
<P><FONT face=3DArial size=3D2>[&lt;80255e48&gt;] [&lt;80255e60&gt;]=20
[&lt;8011b368&gt;] [&lt;8011b368&gt;] [&lt;8026a9e0&gt;]=20
[&lt;8025f444&gt;]</FONT></P>
<P><FONT face=3DArial size=3D2>[&lt;8025601c&gt;] [&lt;80116d90&gt;]=20
[&lt;8011687c&gt;] [&lt;8010101c&gt;] [&lt;8010133c&gt;]=20
[&lt;801012ec&gt;]</FONT></P>
<P><FONT face=3DArial size=3D2>[&lt;8026a7b8&gt;] [&lt;802ca7c8&gt;]=20
[&lt;80255d08&gt;] [&lt;802c9f54&gt;] [&lt;80255e48&gt;]=20
[&lt;801aab24&gt;]</FONT></P>
<P><FONT face=3DArial size=3D2>[&lt;801a3dc4&gt;] [&lt;801aab24&gt;]=20
[&lt;801334c4&gt;] [&lt;801a1ee4&gt;] [&lt;8014fe9c&gt;]=20
[&lt;8014fe80&gt;]</FONT></P>
<P><FONT face=3DArial size=3D2>[&lt;8024c918&gt;] [&lt;801a01a0&gt;]=20
[&lt;801a22f4&gt;] [&lt;8015076c&gt;] [&lt;80150638&gt;]=20
[&lt;80105f0c&gt;]</FONT></P>
<P><FONT face=3DArial size=3D2>[&lt;801046ac&gt;] =
[&lt;80107688&gt;]</FONT></P>
<P><FONT face=3DArial size=3D2></FONT></P>
<P><FONT face=3DArial size=3D2>Code: 8e06009c 10c0000e 24030001 =
&lt;8cc20000&gt;=20
c0450000 00a32023 e0440000 1080fffc 0</FONT></P>
<P><FONT face=3DArial size=3D2>Kernel panic: Aiee, killing interrupt=20
handler!</FONT></P>
<P><FONT face=3DArial size=3D2>In interrupt handler - not =
syncing</FONT></P>
<P><FONT face=3DArial size=3D2></FONT>&nbsp;</P>
<P><SPAN class=3D484181715-24052005><FONT face=3DArial size=3D2>Any help =
in debugging=20
is welcome.</FONT></SPAN></P>
<P><SPAN class=3D484181715-24052005><FONT face=3DArial=20
size=3D2>Regards,</FONT></SPAN></P>
<P><SPAN class=3D484181715-24052005></SPAN><SPAN =
class=3D484181715-24052005><FONT=20
face=3DArial =
size=3D2>Raghu</FONT></SPAN></P></SPAN></FONT></DIV></BODY></HTML>

------_=_NextPart_001_01C56076.2CBC07F0--
