Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 27 Oct 2006 21:22:13 +0100 (BST)
Received: from mail.gazungle.com ([207.210.240.68]:64957 "HELO
	mail.gazungle.com") by ftp.linux-mips.org with SMTP
	id S20037758AbWJ0UWJ (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 27 Oct 2006 21:22:09 +0100
Received: (qmail 11303 invoked by uid 399); 27 Oct 2006 20:22:00 -0000
Received: from unknown (HELO thelab) (69.26.107.202)
  by mail.gazungle.com with SMTP; 27 Oct 2006 20:22:00 -0000
Reply-To: <vasbridge@sanblaze.com>
From:	"Vince Asbridge" <vasbridge@sanblaze.com>
To:	<ralf@linux-mips.org>, <Bill.Azer@drs-ss.com>
Cc:	<linux-mips@linux-mips.org>
Subject: Drivers for SANBlaze FC card
Date:	Fri, 27 Oct 2006 16:24:46 -0400
Organization: SANBlaze
Message-ID: <017901c6fa05$f211a160$4b01a8c0@sanblaze.com>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_NextPart_000_017A_01C6F9E4.6B000160"
X-Mailer: Microsoft Office Outlook 11
Thread-Index: Acb6BfGMq9+mDN7OS3il5QoeYv4i2w==
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2962
Return-Path: <vasbridge@sanblaze.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 13112
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: vasbridge@sanblaze.com
Precedence: bulk
X-list: linux-mips

This is a multi-part message in MIME format.

------=_NextPart_000_017A_01C6F9E4.6B000160
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit

Ralf,

Bill Azer from DRS forwarded a mail regarding the SANBlaze FibreChannel card
on a MIPS processor, and some issues he was having with loading the driver
set.

Our card uses the FusionMPT driver from LSI logic, and we were able to
provide a new kit to Bill which resolved his issue.

If you would like a copy of this latest driver set, please just send me an
email and I'll send it along.

I expect that LSI Logic will (or maybe even has) update the drivers on
kernel.org, but if you want a copy of what we sent Bill, just send me an
email.

Vince Asbridge
SANBlaze Technology, Inc.


-----Original Message-----
From: Ralf Baechle <ralf@linux-mips.org>
To: Azer, William <Bill.Azer@drs-ss.com>
CC: linux-mips@linux-mips.org <linux-mips@linux-mips.org>
Sent: Thu Oct 26 19:06:09 2006
Subject: Re: sanblaze driver -> LSFC929 FiberChannel

On Thu, Oct 26, 2006 at 04:39:42PM -0400, Azer, William wrote:

> i am using the sanblaze card configured in the kernel for the
> fiberchannel. i enabled the mpt fusion fc and the ioctl driver, i also
> enable scsi disk support, ...

This is the first user report for such a device on MIPS ever afaics.
A few more details on your system, messages etc. could be useful to
solve your issue.

Ralf



	

------=_NextPart_000_017A_01C6F9E4.6B000160
Content-Type: text/html;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 3.2//EN">
<HTML>
<HEAD>
<META HTTP-EQUIV=3D"Content-Type" CONTENT=3D"text/html; =
charset=3Dus-ascii">
<META NAME=3D"Generator" CONTENT=3D"MS Exchange Server version =
6.5.7036.0">
<TITLE>Drivers for SANBlaze FC card</TITLE>
</HEAD>
<BODY>
<!-- Converted from text/rtf format -->

<P><FONT SIZE=3D2 FACE=3D"Arial">Ralf,</FONT>
</P>

<P><FONT SIZE=3D2 FACE=3D"Arial">Bill Azer from DRS forwarded a mail =
regarding the SANBlaze FibreChannel card on a MIPS processor, and some =
issues he was having with loading the driver set.</FONT></P>

<P><FONT SIZE=3D2 FACE=3D"Arial">Our card uses the FusionMPT driver from =
LSI logic, and we were able to provide a new kit to Bill which resolved =
his issue.</FONT></P>

<P><FONT SIZE=3D2 FACE=3D"Arial">If you would like a copy of this latest =
driver set, please just send me an email and I'll send it along.</FONT>
</P>

<P><FONT SIZE=3D2 FACE=3D"Arial">I expect that LSI Logic will (or maybe =
even has) update the drivers on kernel.org, but if you want a copy of =
what we sent Bill, just send me an email.</FONT></P>

<P><FONT SIZE=3D2 FACE=3D"Arial">Vince Asbridge</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">SANBlaze Technology, Inc.</FONT>
</P>
<BR>

<P><FONT FACE=3D"Times New Roman">-----Original Message-----<BR>
From: Ralf Baechle &lt;ralf@linux-mips.org&gt;<BR>
To: Azer, William &lt;Bill.Azer@drs-ss.com&gt;<BR>
CC: linux-mips@linux-mips.org &lt;linux-mips@linux-mips.org&gt;<BR>
Sent: Thu Oct 26 19:06:09 2006<BR>
Subject: Re: sanblaze driver -&gt; LSFC929 FiberChannel<BR>
<BR>
On Thu, Oct 26, 2006 at 04:39:42PM -0400, Azer, William wrote:<BR>
<BR>
&gt; i am using the sanblaze card configured in the kernel for the<BR>
&gt; fiberchannel. i enabled the mpt fusion fc and the ioctl driver, i =
also<BR>
&gt; enable scsi disk support, ...<BR>
<BR>
This is the first user report for such a device on MIPS ever afaics.<BR>
A few more details on your system, messages etc. could be useful to<BR>
solve your issue.<BR>
<BR>
Ralf<BR>
<BR>
</FONT>
</P>

<P>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
</P>

</BODY>
</HTML>
------=_NextPart_000_017A_01C6F9E4.6B000160--
