Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 04 Nov 2003 11:56:34 +0000 (GMT)
Received: from [IPv6:::ffff:203.82.55.162] ([IPv6:::ffff:203.82.55.162]:47575
	"EHLO 1aurora.enabtech") by linux-mips.org with ESMTP
	id <S8225316AbTKDL4W>; Tue, 4 Nov 2003 11:56:22 +0000
Received: by 1aurora.enabtech with Internet Mail Service (5.5.2650.21)
	id <WHAQ22B4>; Tue, 4 Nov 2003 16:56:09 +0500
Message-ID: <10C6C1971DA00C4BB87AC0206E3CA38264F542@1aurora.enabtech>
From: Adeel Malik <AdeelM@quartics.com>
To: linux-mips@linux-mips.org
Subject: How to request an IRQ for NMI on MIPS Processor
Date: Tue, 4 Nov 2003 16:56:08 +0500 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2650.21)
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C3A2CA.A25A8C70"
Return-Path: <AdeelM@quartics.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3582
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: AdeelM@quartics.com
Precedence: bulk
X-list: linux-mips

This message is in MIME format. Since your mail reader does not understand
this format, some or all of this message may not be legible.

------_=_NextPart_001_01C3A2CA.A25A8C70
Content-Type: text/plain;
	charset="iso-8859-1"

Hi All,
          In my embedded design, I intend to use NMI of MIPS 4Kc processor
(rather than IRQ0 or IRQ1 .....) for an external Interrupt Source. The
external Interrupt source is a video capture device which interrupts the
MIPS 4Kc CPU via its NMI (Non-Maskable Interrupt) line, whenever it has one
complete frame. I need to write the driver for that device in Linux-2.4.20.
The request_irq function provided by Linux takes a digit value from 0 to 5
to map external interrupt sources to any one of CPUs Interrupt pins. How can
I request and implement my interrupt handler routine for the NMI of MIPS
processor ?.
 
Regards,
ADEEL MALIK,


------_=_NextPart_001_01C3A2CA.A25A8C70
Content-Type: text/html;
	charset="iso-8859-1"

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD>
<META HTTP-EQUIV="Content-Type" CONTENT="text/html; charset=iso-8859-1">


<META content="MSHTML 6.00.2600.0" name=GENERATOR></HEAD>
<BODY style="COLOR: #000000; FONT-FAMILY: Arial" hb_focus_attach="true">
<DIV><SPAN class=276362111-04112003><FONT size=2>Hi All,</FONT></SPAN></DIV>
<DIV><SPAN class=276362111-04112003><FONT 
size=2>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; In my 
embedded&nbsp;design, I&nbsp;intend to use NMI of MIPS 4Kc processor (rather 
than IRQ0 or IRQ1 .....) for an external Interrupt Source. The external 
Interrupt source is a video capture device which interrupts the MIPS 4Kc CPU via 
its NMI (Non-Maskable Interrupt) line,&nbsp;whenever it has one complete frame. 
I need to write the driver for that device in Linux-2.4.20. The 
<STRONG>request_irq</STRONG> function provided by Linux takes&nbsp;a 
digit&nbsp;value from 0 to 5 to map external interrupt sources to any one of 
CPUs Interrupt pins. How can I request and implement my interrupt handler 
routine for the NMI of MIPS processor ?.</FONT></SPAN></DIV>
<DIV><SPAN class=276362111-04112003><FONT size=2></FONT></SPAN>&nbsp;</DIV>
<DIV><SPAN class=276362111-04112003><FONT size=2>Regards,</FONT></SPAN></DIV>
<DIV><FONT face=Georgia color=#0000ff size=2><EM>ADEEL MALIK,</EM></FONT></DIV>
<P></P></BODY></HTML>

------_=_NextPart_001_01C3A2CA.A25A8C70--
