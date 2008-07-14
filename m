Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 14 Jul 2008 18:26:42 +0100 (BST)
Received: from sj-iport-3.cisco.com ([171.71.176.72]:31521 "EHLO
	sj-iport-3.cisco.com") by ftp.linux-mips.org with ESMTP
	id S20038991AbYGNR0j (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 14 Jul 2008 18:26:39 +0100
X-IronPort-AV: E=Sophos;i="4.30,360,1212364800"; 
   d="scan'208,217";a="86998279"
Received: from sj-dkim-1.cisco.com ([171.71.179.21])
  by sj-iport-3.cisco.com with ESMTP; 14 Jul 2008 17:25:31 +0000
Received: from sj-core-5.cisco.com (sj-core-5.cisco.com [171.71.177.238])
	by sj-dkim-1.cisco.com (8.12.11/8.12.11) with ESMTP id m6EHPUtK031284
	for <linux-mips@linux-mips.org>; Mon, 14 Jul 2008 10:25:30 -0700
Received: from sausatlsmtp2.sciatl.com ([192.133.217.159])
	by sj-core-5.cisco.com (8.13.8/8.13.8) with ESMTP id m6EHPUK3013594
	for <linux-mips@linux-mips.org>; Mon, 14 Jul 2008 17:25:30 GMT
Received: from default.com ([192.133.217.159]) by sausatlsmtp2.sciatl.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Mon, 14 Jul 2008 13:25:28 -0400
Received: from sausatlbhs01.corp.sa.net ([192.133.216.76]) by sausatlsmtp2.sciatl.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Mon, 14 Jul 2008 13:25:25 -0400
Received: from SAUSCUPEXCH01.corp.sa.net ([64.101.22.160]) by sausatlbhs01.corp.sa.net with Microsoft SMTPSVC(6.0.3790.3959);
	 Mon, 14 Jul 2008 13:25:24 -0400
x-mimeole: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C8E5D6.994654D1"
Subject: RE: sparse or discontiguous  memory on 32bit mips platform
Date:	Mon, 14 Jul 2008 10:20:54 -0700
Message-ID: <D331130DD3DA194B96EF57DA3415F50A026331BE@SAUSCUPEXCH01.corp.sa.net>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: sparse or discontiguous  memory on 32bit mips platform
Thread-Index: Acjl0vODLU3QLKT5RlK8KXJW2TxnzAAAwV7r
References: <D331130DD3DA194B96EF57DA3415F50A026331BB@SAUSCUPEXCH01.corp.sa.net> <1216054738.30304.45.camel@chaos.ne.broadcom.com>
From:	"Sundius, Michael" <michael.sundius@sciatl.com>
To:	<jfraser@broadcom.com>
Cc:	<linux-mips@linux-mips.org>, <msundius@sundius.com>
X-OriginalArrivalTime: 14 Jul 2008 17:25:24.0586 (UTC) FILETIME=[99C844A0:01C8E5D6]
X-ST-MF-Message-Resent:	7/14/2008 13:25
Authentication-Results:	sj-dkim-1; header.From=michael.sundius@sciatl.com; dkim=neutral
Return-Path: <michael.sundius@sciatl.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 19834
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: michael.sundius@sciatl.com
Precedence: bulk
X-list: linux-mips

This is a multi-part message in MIME format.

------_=_NextPart_001_01C8E5D6.994654D1
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable


| I have something similar.  Under 2.6.24, I have the following
| configured:
| 
| CONFIG_HIGHMEM=3Dy
| CONFIG_CPU_SUPPORTS_HIGHMEM=3Dy
| CONFIG_SYS_SUPPORTS_HIGHMEM=3Dy
| CONFIG_ARCH_FLATMEM_ENABLE=3Dy
| CONFIG_ARCH_DISCONTIGMEM_ENABLE=3Dy
| CONFIG_DISCONTIGMEM=3Dy
| CONFIG_FLAT_NODE_MEM_MAP=3Dy
| CONFIG_ARCH_POPULATES_NODE_MAP=3Dy
| CONFIG_NODES_SHIFT=3D6
| CONFIG_FLAT_NODE_MEM_MAP=3Dy
| CONFIG_NEED_MULTIPLE_NODES=3Dy
|
|
| Each bank of memory is in a separate node. I did have to write
| some code in arch/mips/kernel/setup.c to setup the multiple memory
| regions.  I used some of the PPC NUMA code as an example, IIRC.
| 
| Because my second bank of mem starts at 0x20000000,
| I use HIGHMEM to access it.  There been some HIGHMEM info
| posted to this list in the last 6 months.
|
| I didn't think my efforts were general enough to post, but maybe
| more people are doing these discontiguous memory platforms.

Oh, yes, that is very similar to what I want to do. we currently
use HIGHMEM to access our 2nd bank of memory, and so its the 
setup of the additional node that we'd like to use. I'd be
interested in seeing that patch if possible. 

thanks Mike




     - - - - -                              Cisco                        =
    - - - - -         
This e-mail and any attachments may contain information which is confiden=
tial, 
proprietary, privileged or otherwise protected by law. The information is=
 solely 
intended for the named addressee (or a person responsible for delivering =
it to 
the addressee). If you are not the intended recipient of this message, yo=
u are 
not authorized to read, print, retain, copy or disseminate this message o=
r any 
part of it. If you have received this e-mail in error, please notify the =
sender 
immediately by return e-mail and delete it from your computer.
------_=_NextPart_001_01C8E5D6.994654D1
Content-Type: text/html;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 3.2//EN">
<HTML>
<HEAD>
<META HTTP-EQUIV=3D"Content-Type" CONTENT=3D"text/html; charset=3Diso-885=
9-1">
<META NAME=3D"Generator" CONTENT=3D"MS Exchange Server version 6.5.7652.2=
4">
<TITLE>RE: sparse or discontiguous  memory on 32bit mips platform</TITLE>
</HEAD>
<BODY><P>
<!-- Converted from text/plain format -->
<BR>

<P><FONT SIZE=3D2>| I have something similar.&nbsp; Under 2.6.24, I have =
the following<BR>
| configured:<BR>
|<BR>
| CONFIG_HIGHMEM=3Dy<BR>
| CONFIG_CPU_SUPPORTS_HIGHMEM=3Dy<BR>
| CONFIG_SYS_SUPPORTS_HIGHMEM=3Dy<BR>
| CONFIG_ARCH_FLATMEM_ENABLE=3Dy<BR>
| CONFIG_ARCH_DISCONTIGMEM_ENABLE=3Dy<BR>
| CONFIG_DISCONTIGMEM=3Dy<BR>
| CONFIG_FLAT_NODE_MEM_MAP=3Dy<BR>
| CONFIG_ARCH_POPULATES_NODE_MAP=3Dy<BR>
| CONFIG_NODES_SHIFT=3D6<BR>
| CONFIG_FLAT_NODE_MEM_MAP=3Dy<BR>
| CONFIG_NEED_MULTIPLE_NODES=3Dy<BR>
|<BR>
|<BR>
| Each bank of memory is in a separate node. I did have to write<BR>
| some code in arch/mips/kernel/setup.c to setup the multiple memory<BR>
| regions.&nbsp; I used some of the PPC NUMA code as an example, IIRC.<BR=
>
|<BR>
| Because my second bank of mem starts at 0x20000000,<BR>
| I use HIGHMEM to access it.&nbsp; There been some HIGHMEM info<BR>
| posted to this list in the last 6 months.<BR>
|<BR>
| I didn't think my efforts were general enough to post, but maybe<BR>
| more people are doing these discontiguous memory platforms.<BR>
<BR>
Oh, yes, that is very similar to what I want to do. we currently<BR>
use HIGHMEM to access our 2nd bank of memory, and so its the<BR>
setup of the additional node that we'd like to use. I'd be<BR>
interested in seeing that patch if possible.<BR>
<BR>
thanks Mike<BR>
</FONT>
</P>

</P>
<HR style=3D"HEIGHT: 1px">

<DIV></DIV>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; - - - - 
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Cisco&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
&nbsp;&nbsp;&nbsp; - - - - 
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<BR>This e-mail an=
d any 
attachments may contain information which is confidential, <BR>proprietar=
y, 
privileged or otherwise protected by law. The information is solely <BR>i=
ntended 
for the named addressee (or a person responsible for delivering it to <BR=
>the 
addressee). If you are not the intended recipient of this message, you ar=
e 
<BR>not authorized to read, print, retain, copy or disseminate this messa=
ge or 
any <BR>part of it. If you have received this e-mail in error, please not=
ify the 
sender <BR>immediately by return e-mail and delete it from your computer.=
</BODY>
</HTML>

------_=_NextPart_001_01C8E5D6.994654D1--
