Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 10 Sep 2008 15:37:06 +0100 (BST)
Received: from mms2.broadcom.com ([216.31.210.18]:26382 "EHLO
	mms2.broadcom.com") by ftp.linux-mips.org with ESMTP
	id S20093941AbYIJObo (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 10 Sep 2008 15:31:44 +0100
Received: from [10.11.16.99] by mms2.broadcom.com with ESMTP (Broadcom
 SMTP Relay (Email Firewall v6.3.2)); Wed, 10 Sep 2008 07:31:28 -0700
X-Server-Uuid: D3C04415-6FA8-4F2C-93C1-920E106A2031
Received: by mail-irva-10.broadcom.com (Postfix, from userid 47) id
 D975A2B1; Wed, 10 Sep 2008 07:31:28 -0700 (PDT)
Received: from mail-irva-8.broadcom.com (mail-irva-8 [10.11.18.52]) by
 mail-irva-10.broadcom.com (Postfix) with ESMTP id C5AC72B0 for
 <linux-mips@linux-mips.org>; Wed, 10 Sep 2008 07:31:28 -0700 (PDT)
Received: from mail-sj1-12.sj.broadcom.com (mail-sj1-12.sj.broadcom.com
 [10.16.128.215]) by mail-irva-8.broadcom.com (MOS 3.7.5a-GA) with ESMTP
 id HDE89574; Wed, 10 Sep 2008 07:31:23 -0700 (PDT)
Received: from NT-SJCA-0751.brcm.ad.broadcom.com (nt-sjca-0751
 [10.16.192.221]) by mail-sj1-12.sj.broadcom.com (Postfix) with ESMTP id
 19FD520502 for <linux-mips@linux-mips.org>; Wed, 10 Sep 2008 07:31:23
 -0700 (PDT)
Received: from SJEXCHHUB01.corp.ad.broadcom.com ([10.16.192.224]) by
 NT-SJCA-0751.brcm.ad.broadcom.com with Microsoft
 SMTPSVC(6.0.3790.1830); Wed, 10 Sep 2008 07:31:22 -0700
Received: from SJEXCHCCR01.corp.ad.broadcom.com ([10.252.49.130]) by
 SJEXCHHUB01.corp.ad.broadcom.com ([10.16.192.224]) with mapi; Wed, 10
 Sep 2008 07:31:22 -0700
From:	"Ramgopal Kota" <rkota@broadcom.com>
To:	"linux-mips@linux-mips.org" <linux-mips@linux-mips.org>
Date:	Wed, 10 Sep 2008 07:31:21 -0700
Subject: Help on MTD Partitions.
Thread-Topic: Help on MTD Partitions.
Thread-Index: AckTUeUm/RIcnrzVRNaYFLuEmtu96g==
Message-ID: <6C370B347C3FE8438C9692873287D2E110068DF9C3@SJEXCHCCR01.corp.ad.broadcom.com>
Accept-Language: en-US
Content-Language: en-US
acceptlanguage:	en-US
MIME-Version: 1.0
X-OriginalArrivalTime: 10 Sep 2008 14:31:22.0982 (UTC)
 FILETIME=[E60F7060:01C91351]
X-WSS-ID: 64D905CA3D0150015831-01-01
Content-Type: multipart/alternative;
 boundary=_000_6C370B347C3FE8438C9692873287D2E110068DF9C3SJEXCHCCR01co_
Return-Path: <rkota@broadcom.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20438
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: rkota@broadcom.com
Precedence: bulk
X-list: linux-mips


--_000_6C370B347C3FE8438C9692873287D2E110068DF9C3SJEXCHCCR01co_
Content-Type: text/plain;
 charset=us-ascii
Content-Transfer-Encoding: quoted-printable

Hi,

I am facing a problem with MTD partitions with linux 2.6.
I have a Spansion Flash of 8MB. where the number of erase regions are 2 ,

1st erase region has 127 64KB sectors
2nd erase region has 8 8KB sectors.   ( This is at the end of the flash)

I want to create 4 partitions.
NAME  --  SIZE
BOOT  --  128KB.
OS      --  2MB
JFFS    --  (8MB - 8KB)
DUMP   --  8KB

Kernel prints a error message that "JFFS Partition is read-only".
Can a partition span across 2 various erase regions ?
(I see that there is a check for the same in the mtdpart.c while adding a p=
artition.)

Is there any work-around using MTDPART_OFS_APPEND & MTDPART_OFS_NXTBLK flag=
s ??
Any help is highly appreciable ??

Ramgopal Kota

--_000_6C370B347C3FE8438C9692873287D2E110068DF9C3SJEXCHCCR01co_
Content-Type: text/html;
 charset=us-ascii
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD>
<META http-equiv=3DContent-Type content=3D"text/html; charset=3Dus-ascii">
<META content=3D"MSHTML 6.00.2900.3314" name=3DGENERATOR></HEAD>
<BODY>
<DIV><SPAN class=3D828112214-10092008><FONT face=3DVerdana=20
size=3D2>Hi,</FONT></SPAN></DIV>
<DIV><SPAN class=3D828112214-10092008><FONT face=3DVerdana=20
size=3D2></FONT></SPAN>&nbsp;</DIV>
<DIV><SPAN class=3D828112214-10092008><FONT face=3DVerdana size=3D2>I am fa=
cing a=20
problem with MTD partitions with linux 2.6.</FONT></SPAN></DIV>
<DIV><SPAN class=3D828112214-10092008><FONT face=3DVerdana size=3D2>I have =
a Spansion=20
Flash of 8MB. where the number of erase regions are 2 ,</FONT></SPAN></DIV>
<DIV><SPAN class=3D828112214-10092008><FONT face=3DVerdana=20
size=3D2></FONT></SPAN>&nbsp;</DIV>
<DIV><SPAN class=3D828112214-10092008><FONT face=3DVerdana size=3D2>1st era=
se region=20
has 127 64KB sectors</FONT></SPAN></DIV>
<DIV><SPAN class=3D828112214-10092008><FONT face=3DVerdana size=3D2>2nd era=
se region=20
has 8 8KB sectors.&nbsp;&nbsp; ( This is at the end of the=20
flash)</FONT></SPAN></DIV>
<DIV><SPAN class=3D828112214-10092008><FONT face=3DVerdana=20
size=3D2></FONT></SPAN>&nbsp;</DIV>
<DIV><SPAN class=3D828112214-10092008><FONT face=3DVerdana size=3D2>I want =
to=20
create&nbsp;4 partitions.</FONT></SPAN></DIV>
<DIV><SPAN class=3D828112214-10092008><FONT face=3DVerdana size=3D2>NAME&nb=
sp;=20
--&nbsp; SIZE</FONT></SPAN></DIV>
<DIV><SPAN class=3D828112214-10092008><FONT face=3DVerdana size=3D2>BOOT&nb=
sp;=20
--&nbsp; 128KB.</FONT></SPAN></DIV>
<DIV><SPAN class=3D828112214-10092008><FONT face=3DVerdana=20
size=3D2>OS&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; --&nbsp; 2MB</FONT></SPAN></DIV>
<DIV><SPAN class=3D828112214-10092008><FONT face=3DVerdana=20
size=3D2>JFFS&nbsp;&nbsp;&nbsp; --&nbsp; (8MB - 8KB)</FONT></SPAN></DIV>
<DIV><SPAN class=3D828112214-10092008></SPAN><SPAN class=3D828112214-100920=
08><FONT=20
face=3DVerdana size=3D2>DUMP&nbsp;&nbsp; --&nbsp; 8KB</FONT></SPAN></DIV>
<DIV><SPAN class=3D828112214-10092008><FONT face=3DVerdana=20
size=3D2></FONT></SPAN>&nbsp;</DIV>
<DIV><SPAN class=3D828112214-10092008><FONT face=3DVerdana size=3D2>Kernel =
prints a=20
error message that "JFFS Partition is read-only".</FONT></SPAN></DIV>
<DIV><SPAN class=3D828112214-10092008><FONT face=3DVerdana size=3D2>Can a p=
artition=20
span across 2 various erase regions ?</FONT></SPAN></DIV>
<DIV><SPAN class=3D828112214-10092008><FONT face=3DVerdana size=3D2>(I see =
that there=20
is a check for the same in the mtdpart.c while adding a=20
partition.)</FONT></SPAN></DIV>
<DIV><SPAN class=3D828112214-10092008><FONT face=3DVerdana=20
size=3D2></FONT></SPAN>&nbsp;</DIV>
<DIV><SPAN class=3D828112214-10092008><FONT face=3DVerdana size=3D2>Is ther=
e any=20
work-around using <FONT face=3DArial size=3D2>MTDPART_OFS_APPEND &amp; <FON=
T=20
face=3DArial size=3D2>MTDPART_OFS_NXTBLK flags ??</FONT></FONT></FONT></SPA=
N></DIV>
<DIV><SPAN class=3D828112214-10092008><FONT face=3DArial size=3D2>Any help =
is highly=20
appreciable ??</FONT></SPAN></DIV>
<DIV><SPAN class=3D828112214-10092008><FONT face=3DArial=20
size=3D2></FONT></SPAN>&nbsp;</DIV>
<DIV><SPAN class=3D828112214-10092008><FONT face=3DArial size=3D2>Ramgopal=
=20
Kota</FONT></SPAN></DIV></BODY></HTML>

--_000_6C370B347C3FE8438C9692873287D2E110068DF9C3SJEXCHCCR01co_--
