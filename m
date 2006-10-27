Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 27 Oct 2006 20:22:41 +0100 (BST)
Received: from smtp-out.sigp.net ([63.237.78.44]:29943 "EHLO smtp-out.sigp.net")
	by ftp.linux-mips.org with ESMTP id S20037750AbWJ0TWh (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 27 Oct 2006 20:22:37 +0100
Received: from gamd-ex-001.ss.drs.master (gamd-ex-001.ss.drs.master [172.22.132.94])
	by smtp-out.sigp.net (8.13.8/8.13.8) with ESMTP id k9RJMVdQ018204;
	Fri, 27 Oct 2006 15:22:35 -0400 (EDT)
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C6F9FD.3FBAB911"
Subject: RE: sanblaze driver -> LSFC929 FiberChannel
Date:	Fri, 27 Oct 2006 15:22:00 -0400
Message-ID: <DEB94D90ABFC8240851346CFD4ACFF149E1CC2@gamd-ex-001.ss.drs.master>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: sanblaze driver -> LSFC929 FiberChannel
Thread-Index: Acb5U0ypC9ZHsldVRgOrB0VVQKcH9wAn21gQAAKc0PQ=
References: <DEB94D90ABFC8240851346CFD4ACFF1429FF05@gamd-ex-001.ss.drs.master>
From:	"Azer, William" <Bill.Azer@drs-ss.com>
To:	"Azer, William" <Bill.Azer@drs-ss.com>, <ralf@linux-mips.org>
Cc:	<linux-mips@linux-mips.org>
Return-Path: <Bill.Azer@drs-ss.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 13111
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Bill.Azer@drs-ss.com
Precedence: bulk
X-list: linux-mips

This is a multi-part message in MIME format.

------_=_NextPart_001_01C6F9FD.3FBAB911
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

this is the order of the laod and the messages :

bash-2.05b# insmod drivers/message/fusion/mptbase.ko

Fusion MPT base driver 3.03.09

Copyright (c) 1999-2005 LSI Logic Corporation

bash-2.05b# insmod drivers/message/fusion/mptctl.ko

Fusion MPT misc device (ioctl) driver 3.03.09

mptctl: Registered with Fusion MPT base driver

mptctl: /dev/mptctl @ (major,minor=3D10,220)

bash-2.05b# insmod drivers/message/fusion/mptscsih.ko

bash-2.05b# insmod drivers/scsi/scsi_transport_fc.ko

bash-2.05b# insmod

/lib/modules/2.6.17.7/kernel/drivers/message/fusion/mptfc.ko

Fusion MPT FC Host driver 3.03.09

mptbase: Initiating ioc0 bringup

ioc0: FC929: Capabilities=3D{Initiator,Target,LAN}

=20

mptbase: mpt_reply: WARNING - ioc0: Invalid cb_idx (0)!

mptbase: mpt_reply: WARNING - ioc0: Invalid cb_idx (0)!

mptbase: Initiating ioc0 recovery

mptbase: mpt_reply: WARNING - ioc0: Invalid cb_idx (130)!

mptbase: mpt_reply: WARNING - ioc0: Invalid cb_idx (65)!

mptbase: Initiating ioc0 recovery

mptbase: mpt_reply: WARNING - ioc0: Invalid cb_idx (0)!

mptbase: mpt_reply: WARNING - ioc0: Invalid cb_idx (65)!

mptbase: Initiating ioc0 recovery

mptbase: mpt_reply: WARNING - ioc0: Invalid cb_idx (0)!

scsi0 : ioc0: LSIFC929, FwRev=3D02000a00h, Ports=3D1, MaxQ=3D1023, =
IRQ=3D10

mptbase: mpt_reply: WARNING - ioc0: Invalid cb_idx (65)!

mptbase: Initiating ioc0 recovery

mptbase: mpt_reply: WARNING - ioc0: Invalid cb_idx (0)!

mptbase: mpt_reply: WARNING - ioc0: Invalid cb_idx (65)!




-----Original Message-----
From: linux-mips-bounce@linux-mips.org on behalf of Azer, William
Sent: Fri 10/27/2006 2:07 PM
To: ralf@linux-mips.org
Cc: linux-mips@linux-mips.org
Subject: Re: sanblaze driver -> LSFC929 FiberChannel
=20
It is a bcm1480, using linux 2.6.17.7 with sanblaze PMC

Bill

-----Original Message-----
From: Ralf Baechle <ralf@linux-mips.org>
To: Azer, William <Bill.Azer@drs-ss.com>
CC: linux-mips@linux-mips.org <linux-mips@linux-mips.org>
Sent: Thu Oct 26 19:06:09 2006
Subject: Re: sanblaze driver -> LSFC929 FiberChannel

On Thu, Oct 26, 2006 at 04:39:42PM -0400, Azer, William wrote:

> i am using the sanblaze card configured in the kernel for the
> fiberchannel.  i enabled the mpt fusion fc and the ioctl driver, i =
also
> enable scsi disk support, ...

This is the first user report for such a device on MIPS ever afaics.
A few more details on your system, messages etc. could be useful to
solve your issue.

  Ralf




------_=_NextPart_001_01C6F9FD.3FBAB911
Content-Type: text/html;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 3.2//EN">
<HTML>
<HEAD>
<META HTTP-EQUIV=3D"Content-Type" CONTENT=3D"text/html; =
charset=3Diso-8859-1">
<META NAME=3D"Generator" CONTENT=3D"MS Exchange Server version =
6.5.7233.28">
<TITLE>RE: sanblaze driver -&gt; LSFC929 FiberChannel</TITLE>
</HEAD>
<BODY>
<!-- Converted from text/plain format -->

<P><FONT SIZE=3D2>this is the order of the laod and the messages :<BR>
<BR>
bash-2.05b# insmod drivers/message/fusion/mptbase.ko<BR>
<BR>
Fusion MPT base driver 3.03.09<BR>
<BR>
Copyright (c) 1999-2005 LSI Logic Corporation<BR>
<BR>
bash-2.05b# insmod drivers/message/fusion/mptctl.ko<BR>
<BR>
Fusion MPT misc device (ioctl) driver 3.03.09<BR>
<BR>
mptctl: Registered with Fusion MPT base driver<BR>
<BR>
mptctl: /dev/mptctl @ (major,minor=3D10,220)<BR>
<BR>
bash-2.05b# insmod drivers/message/fusion/mptscsih.ko<BR>
<BR>
bash-2.05b# insmod drivers/scsi/scsi_transport_fc.ko<BR>
<BR>
bash-2.05b# insmod<BR>
<BR>
/lib/modules/2.6.17.7/kernel/drivers/message/fusion/mptfc.ko<BR>
<BR>
Fusion MPT FC Host driver 3.03.09<BR>
<BR>
mptbase: Initiating ioc0 bringup<BR>
<BR>
ioc0: FC929: Capabilities=3D{Initiator,Target,LAN}<BR>
<BR>
<BR>
<BR>
mptbase: mpt_reply: WARNING - ioc0: Invalid cb_idx (0)!<BR>
<BR>
mptbase: mpt_reply: WARNING - ioc0: Invalid cb_idx (0)!<BR>
<BR>
mptbase: Initiating ioc0 recovery<BR>
<BR>
mptbase: mpt_reply: WARNING - ioc0: Invalid cb_idx (130)!<BR>
<BR>
mptbase: mpt_reply: WARNING - ioc0: Invalid cb_idx (65)!<BR>
<BR>
mptbase: Initiating ioc0 recovery<BR>
<BR>
mptbase: mpt_reply: WARNING - ioc0: Invalid cb_idx (0)!<BR>
<BR>
mptbase: mpt_reply: WARNING - ioc0: Invalid cb_idx (65)!<BR>
<BR>
mptbase: Initiating ioc0 recovery<BR>
<BR>
mptbase: mpt_reply: WARNING - ioc0: Invalid cb_idx (0)!<BR>
<BR>
scsi0 : ioc0: LSIFC929, FwRev=3D02000a00h, Ports=3D1, MaxQ=3D1023, =
IRQ=3D10<BR>
<BR>
mptbase: mpt_reply: WARNING - ioc0: Invalid cb_idx (65)!<BR>
<BR>
mptbase: Initiating ioc0 recovery<BR>
<BR>
mptbase: mpt_reply: WARNING - ioc0: Invalid cb_idx (0)!<BR>
<BR>
mptbase: mpt_reply: WARNING - ioc0: Invalid cb_idx (65)!<BR>
<BR>
<BR>
<BR>
<BR>
-----Original Message-----<BR>
From: linux-mips-bounce@linux-mips.org on behalf of Azer, William<BR>
Sent: Fri 10/27/2006 2:07 PM<BR>
To: ralf@linux-mips.org<BR>
Cc: linux-mips@linux-mips.org<BR>
Subject: Re: sanblaze driver -&gt; LSFC929 FiberChannel<BR>
<BR>
It is a bcm1480, using linux 2.6.17.7 with sanblaze PMC<BR>
<BR>
Bill<BR>
<BR>
-----Original Message-----<BR>
From: Ralf Baechle &lt;ralf@linux-mips.org&gt;<BR>
To: Azer, William &lt;Bill.Azer@drs-ss.com&gt;<BR>
CC: linux-mips@linux-mips.org &lt;linux-mips@linux-mips.org&gt;<BR>
Sent: Thu Oct 26 19:06:09 2006<BR>
Subject: Re: sanblaze driver -&gt; LSFC929 FiberChannel<BR>
<BR>
On Thu, Oct 26, 2006 at 04:39:42PM -0400, Azer, William wrote:<BR>
<BR>
&gt; i am using the sanblaze card configured in the kernel for the<BR>
&gt; fiberchannel.&nbsp; i enabled the mpt fusion fc and the ioctl =
driver, i also<BR>
&gt; enable scsi disk support, ...<BR>
<BR>
This is the first user report for such a device on MIPS ever afaics.<BR>
A few more details on your system, messages etc. could be useful to<BR>
solve your issue.<BR>
<BR>
&nbsp; Ralf<BR>
<BR>
<BR>
<BR>
</FONT>
</P>

</BODY>
</HTML>
------_=_NextPart_001_01C6F9FD.3FBAB911--
