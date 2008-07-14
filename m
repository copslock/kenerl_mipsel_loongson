Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 14 Jul 2008 17:31:57 +0100 (BST)
Received: from sj-iport-2.cisco.com ([171.71.176.71]:22369 "EHLO
	sj-iport-2.cisco.com") by ftp.linux-mips.org with ESMTP
	id S20038976AbYGNQby (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 14 Jul 2008 17:31:54 +0100
X-IronPort-AV: E=Sophos;i="4.30,360,1212364800"; 
   d="scan'208,217";a="65276019"
Received: from sj-dkim-4.cisco.com ([171.71.179.196])
  by sj-iport-2.cisco.com with ESMTP; 14 Jul 2008 16:30:53 +0000
Received: from sj-core-1.cisco.com (sj-core-1.cisco.com [171.71.177.237])
	by sj-dkim-4.cisco.com (8.12.11/8.12.11) with ESMTP id m6EGUrse006252
	for <linux-mips@linux-mips.org>; Mon, 14 Jul 2008 09:30:53 -0700
Received: from sausatlsmtp2.sciatl.com ([192.133.217.159])
	by sj-core-1.cisco.com (8.13.8/8.13.8) with ESMTP id m6EGUr71000358
	for <linux-mips@linux-mips.org>; Mon, 14 Jul 2008 16:30:53 GMT
Received: from default.com ([192.133.217.159]) by sausatlsmtp2.sciatl.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Mon, 14 Jul 2008 12:30:47 -0400
Received: from sausatlbhs02.corp.sa.net ([192.133.216.42]) by sausatlsmtp2.sciatl.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Mon, 14 Jul 2008 12:30:45 -0400
Received: from SAUSCUPEXCH01.corp.sa.net ([64.101.22.160]) by sausatlbhs02.corp.sa.net with Microsoft SMTPSVC(6.0.3790.3959);
	 Mon, 14 Jul 2008 12:30:45 -0400
x-mimeole: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C8E5CE.F68CA842"
Subject: sparse or discontiguous  memory on 32bit mips platform
Date:	Mon, 14 Jul 2008 09:30:44 -0700
Message-ID: <D331130DD3DA194B96EF57DA3415F50A026331BC@SAUSCUPEXCH01.corp.sa.net>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: sparse or discontiguous  memory on 32bit mips platform
Thread-Index: AcjlzvaDwoNenOH2RumoeoHrBZYXVA==
From:	"Sundius, Michael" <michael.sundius@sciatl.com>
To:	<linux-mips@linux-mips.org>
Cc:	<msundius@sundius.com>
X-OriginalArrivalTime: 14 Jul 2008 16:30:45.0235 (UTC) FILETIME=[F7230430:01C8E5CE]
X-ST-MF-Message-Resent:	7/14/2008 12:30
Authentication-Results:	sj-dkim-4; header.From=michael.sundius@sciatl.com; dkim=neutral
Return-Path: <michael.sundius@sciatl.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 19832
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: michael.sundius@sciatl.com
Precedence: bulk
X-list: linux-mips

This is a multi-part message in MIME format.

------_=_NextPart_001_01C8E5CE.F68CA842
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
------_=_NextPart_001_01C8E5CE.F68CA842
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

------_=_NextPart_001_01C8E5CE.F68CA842--
