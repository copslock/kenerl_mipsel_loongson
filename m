Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 11 Nov 2003 02:59:48 +0000 (GMT)
Received: from [IPv6:::ffff:202.96.215.33] ([IPv6:::ffff:202.96.215.33]:5903
	"EHLO tmtms.trident.com.cn") by linux-mips.org with ESMTP
	id <S8225379AbTKKC7h>; Tue, 11 Nov 2003 02:59:37 +0000
Received: by TMTMS with Internet Mail Service (5.5.2653.19)
	id <WT9PV48W>; Tue, 11 Nov 2003 10:52:29 +0800
Message-ID: <15F9E1AE3207D6119CEA00D0B7DD5F6801C99461@TMTMS>
From: "Liu Hongming (Alan)" <alanliu@trident.com.cn>
To: Adeel Malik <AdeelM@quartics.com>, linux-mips@linux-mips.org
Subject: RE: How to request an IRQ for NMI on MIPS Processor
Date: Tue, 11 Nov 2003 10:51:50 +0800
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C3A7FE.C148C790"
Return-Path: <alanliu@trident.com.cn>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3595
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: alanliu@trident.com.cn
Precedence: bulk
X-list: linux-mips

This message is in MIME format. Since your mail reader does not understand
this format, some or all of this message may not be legible.

------_=_NextPart_001_01C3A7FE.C148C790
Content-Type: text/plain;
	charset="ISO-8859-1"

hi Malik,

when using request_irq(...),the parameter irq is a value specified by you,
of course,when porting linux for your board,you should have specified value
for every IRQ. 0--5 only means CPU pin for interrupt,unless that only one
interrupt
may occur on this pin,you will use other value in request_irq,instead of
0-5.
 
all in all, when we touch request_irq,it is board specific.When your board
has
been made out,all interrupts have specific route to cpu(unless you have IRQ
router,since embedded,need this??).If you have more external interrupts than
cpu pins,maybe you have cascaded many interrupt using one cpu pin.So,
the parameter irq in request_irq is determined by your board and your
porting
for interrupt handling.Just ask that guy that ported linux.He will tell
you.If you
are using linux ported by others,have a look at BSP codes.
 
Regards,
Alan Liu
 
-----Original Message-----
From: Adeel Malik [mailto:AdeelM@quartics.com]
Sent: Tuesday, November 04, 2003 7:56 PM
To: linux-mips@linux-mips.org
Subject: How to request an IRQ for NMI on MIPS Processor


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


------_=_NextPart_001_01C3A7FE.C148C790
Content-Type: text/html;
	charset="ISO-8859-1"

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD>
<META HTTP-EQUIV="Content-Type" CONTENT="text/html; charset=ISO-8859-1">


<META content="MSHTML 6.00.2600.0" name=GENERATOR></HEAD>
<BODY style="COLOR: #000000; FONT-FAMILY: Arial" hb_focus_attach="true">
<DIV><FONT size=2>hi<SPAN class=592214802-11112003> Malik</SPAN>,</FONT></DIV>
<DIV><FONT size=2><BR>when using request_irq<SPAN 
class=592214802-11112003>(...),the parameter irq is a value specified by 
you,</SPAN></FONT></DIV>
<DIV><FONT size=2><SPAN class=592214802-11112003>of course,when porting linux 
for your board,you should have specified value</SPAN></FONT></DIV>
<DIV><FONT size=2><SPAN class=592214802-11112003>for every IRQ. 0--5 only means 
CPU pin for interrupt,unless that only one interrupt</SPAN></FONT></DIV>
<DIV><FONT size=2><SPAN class=592214802-11112003>may occur on this pin,you 
will&nbsp;use&nbsp;other value&nbsp;in request_irq,instead of 
0-5.</SPAN></FONT></DIV>
<DIV><FONT size=2><SPAN class=592214802-11112003></SPAN></FONT>&nbsp;</DIV>
<DIV><FONT size=2><SPAN class=592214802-11112003>all in all, when we touch 
request_irq,it is board specific.When your board has</SPAN></FONT></DIV>
<DIV><FONT size=2><SPAN class=592214802-11112003>been made out,all interrupts 
have specific route to cpu(unless you have IRQ</SPAN></FONT></DIV>
<DIV><FONT size=2><SPAN class=592214802-11112003>router,since embedded,need 
this??).If you have&nbsp;more external interrupts than</SPAN></FONT></DIV>
<DIV><FONT size=2><SPAN class=592214802-11112003>cpu pins,maybe you have 
cascaded many interrupt using one cpu pin.So,</SPAN></FONT></DIV>
<DIV><FONT size=2><SPAN class=592214802-11112003>the parameter irq in 
request_irq is determined by your board and your porting</SPAN></FONT></DIV>
<DIV><FONT size=2><SPAN class=592214802-11112003>for interrupt handling.Just ask 
that guy that ported linux.He will tell you.If you</SPAN></FONT></DIV>
<DIV><FONT size=2><SPAN class=592214802-11112003>are using linux ported by 
others,have a look at BSP codes.</SPAN></FONT></DIV>
<DIV><FONT size=2><SPAN class=592214802-11112003></SPAN></FONT>&nbsp;</DIV>
<DIV><FONT size=2><SPAN class=592214802-11112003>Regards,</SPAN></FONT></DIV>
<DIV><FONT size=2><SPAN class=592214802-11112003>Alan Liu</SPAN></FONT></DIV>
<DIV><FONT size=2><SPAN class=592214802-11112003></SPAN></FONT><FONT 
size=2><SPAN class=592214802-11112003></SPAN></FONT>&nbsp;</DIV>
<DIV><FONT face="Times New Roman" size=2>-----Original 
Message-----<BR><B>From:</B> Adeel Malik 
[mailto:AdeelM@quartics.com]<BR><B>Sent:</B> Tuesday, November 04, 2003 7:56 
PM<BR><B>To:</B> linux-mips@linux-mips.org<BR><B>Subject:</B> How to request an 
IRQ for NMI on MIPS Processor<BR><BR></FONT></DIV>
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
<P><FONT size=2></FONT></P></BODY></HTML>

------_=_NextPart_001_01C3A7FE.C148C790--
