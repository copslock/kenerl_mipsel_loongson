Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 14 Jul 2008 17:30:46 +0100 (BST)
Received: from rtp-iport-1.cisco.com ([64.102.122.148]:30793 "EHLO
	rtp-iport-1.cisco.com") by ftp.linux-mips.org with ESMTP
	id S28578063AbYGNQao (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 14 Jul 2008 17:30:44 +0100
X-IronPort-AV: E=Sophos;i="4.30,360,1212364800"; 
   d="scan'208,217";a="14240665"
Received: from rtp-dkim-2.cisco.com ([64.102.121.159])
  by rtp-iport-1.cisco.com with ESMTP; 14 Jul 2008 16:30:34 +0000
Received: from rtp-core-1.cisco.com (rtp-core-1.cisco.com [64.102.124.12])
	by rtp-dkim-2.cisco.com (8.12.11/8.12.11) with ESMTP id m6EGUY4w007658
	for <linux-mips@linux-mips.org>; Mon, 14 Jul 2008 12:30:34 -0400
Received: from sausatlsmtp1.sciatl.com ([192.133.217.33])
	by rtp-core-1.cisco.com (8.13.8/8.13.8) with ESMTP id m6EGUY4T003972
	for <linux-mips@linux-mips.org>; Mon, 14 Jul 2008 16:30:34 GMT
Received: from default.com ([192.133.217.33]) by sausatlsmtp1.sciatl.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Mon, 14 Jul 2008 12:30:33 -0400
Received: from sausatlbhs01.corp.sa.net ([192.133.216.76]) by sausatlsmtp1.sciatl.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Mon, 14 Jul 2008 12:30:32 -0400
Received: from SAUSCUPEXCH01.corp.sa.net ([64.101.22.160]) by sausatlbhs01.corp.sa.net with Microsoft SMTPSVC(6.0.3790.3959);
	 Mon, 14 Jul 2008 12:30:31 -0400
x-mimeole: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C8E5CE.EE641206"
Subject: sparse or discontiguous  memory on 32bit mips platform
Date:	Mon, 14 Jul 2008 09:30:30 -0700
Message-ID: <D331130DD3DA194B96EF57DA3415F50A026331BB@SAUSCUPEXCH01.corp.sa.net>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: sparse or discontiguous  memory on 32bit mips platform
Thread-Index: Acjlzu5Yjal8D5ipT+yVN4T1NoaG1g==
From:	"Sundius, Michael" <michael.sundius@sciatl.com>
To:	<linux-mips@linux-mips.org>
Cc:	<msundius@sundius.com>
X-OriginalArrivalTime: 14 Jul 2008 16:30:31.0540 (UTC) FILETIME=[EEF95340:01C8E5CE]
X-ST-MF-Message-Resent:	7/14/2008 12:30
Authentication-Results:	rtp-dkim-2; header.From=michael.sundius@sciatl.com; dkim=neutral
Return-Path: <michael.sundius@sciatl.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 19831
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: michael.sundius@sciatl.com
Precedence: bulk
X-list: linux-mips

This is a multi-part message in MIME format.

------_=_NextPart_001_01C8E5CE.EE641206
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hi, 

I'm looking into turning on either sparse memory or discontiguous
memory for a 32 Mips platform (single processor) since we have 2 
large memory banks that are nowhere near each other in physical memory.

What has been done in hardware, has been done and so be it.
But since we are an embedded system, we do have memroy constraints and
wish to conserve as much space as possible, we are trying to avoid creati=
ng 
pagetables for the whole space. 

That said, I have a few questions.

1) Are there any 32 Mips platforms where either sparsemem or
discontigmem have been supported?

2) It seems like sparesemem is the wave of the future, am I 
correct in assuming that this is simmplier / more efficient /
"better" way to go? 

3) Is there anywhere (besides the code) where I can find an article
or some documentation on how sparsemem and/or discontig work? or how
to go about adding support for them in a here to for unsupported 
platform?

all info, pointers, hints, advice and comments are much appreciated. 

thanks
Mike




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
------_=_NextPart_001_01C8E5CE.EE641206
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
<TITLE>sparse or discontiguous  memory on 32bit mips platform</TITLE>
</HEAD>
<BODY><P>
<!-- Converted from text/plain format -->

<P><FONT SIZE=3D2>Hi,<BR>
<BR>
I'm looking into turning on either sparse memory or discontiguous<BR>
memory for a 32 Mips platform (single processor) since we have 2<BR>
large memory banks that are nowhere near each other in physical memory.<B=
R>
<BR>
What has been done in hardware, has been done and so be it.<BR>
But since we are an embedded system, we do have memroy constraints and<BR=
>
wish to conserve as much space as possible, we are trying to avoid creati=
ng<BR>
pagetables for the whole space.<BR>
<BR>
That said, I have a few questions.<BR>
<BR>
1) Are there any 32 Mips platforms where either sparsemem or<BR>
discontigmem have been supported?<BR>
<BR>
2) It seems like sparesemem is the wave of the future, am I<BR>
correct in assuming that this is simmplier / more efficient /<BR>
&quot;better&quot; way to go?<BR>
<BR>
3) Is there anywhere (besides the code) where I can find an article<BR>
or some documentation on how sparsemem and/or discontig work? or how<BR>
to go about adding support for them in a here to for unsupported<BR>
platform?<BR>
<BR>
all info, pointers, hints, advice and comments are much appreciated.<BR>
<BR>
thanks<BR>
Mike</FONT>
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

------_=_NextPart_001_01C8E5CE.EE641206--
