Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 11 Nov 2003 04:47:04 +0000 (GMT)
Received: from [IPv6:::ffff:202.96.215.33] ([IPv6:::ffff:202.96.215.33]:40964
	"EHLO tmtms.trident.com.cn") by linux-mips.org with ESMTP
	id <S8225361AbTKKEqw>; Tue, 11 Nov 2003 04:46:52 +0000
Received: by TMTMS with Internet Mail Service (5.5.2653.19)
	id <WT9PVVJL>; Tue, 11 Nov 2003 12:39:48 +0800
Message-ID: <15F9E1AE3207D6119CEA00D0B7DD5F6801C99492@TMTMS>
From: "Liu Hongming (Alan)" <alanliu@trident.com.cn>
To: Ralf Baechle <ralf@linux-mips.org>,
	"Liu Hongming (Alan)" <alanliu@trident.com.cn>
Cc: Adeel Malik <AdeelM@quartics.com>, linux-mips@linux-mips.org
Subject: RE: How to request an IRQ for NMI on MIPS Processor
Date: Tue, 11 Nov 2003 12:39:04 +0800
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C3A80D.BC891ED0"
Return-Path: <alanliu@trident.com.cn>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3597
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: alanliu@trident.com.cn
Precedence: bulk
X-list: linux-mips

This message is in MIME format. Since your mail reader does not understand
this format, some or all of this message may not be legible.

------_=_NextPart_001_01C3A80D.BC891ED0
Content-Type: text/plain;
	charset="ISO-8859-1"


Hi Ralf,

I have never used these kind of boards.It seems to me 
NMI is implemented by interrupt controller,to cpu,it is a 
normal interrupt source.If 'NMI' in Adeel's board is like 
what you repeated,request_irq could just use cpu's pin number
as the 'irq' parameter. I think NMI has been used in many
boards that only means 'non-maskable' to interrupt controller,
not cpu. If it is this case, NMI interrupt is a normal case.

Regards,
Alan Liu

-----Original Message-----
From: Ralf Baechle [mailto:ralf@linux-mips.org]
Sent: Tuesday, November 11, 2003 11:40 AM
To: Liu Hongming (Alan)
Cc: Adeel Malik; linux-mips@linux-mips.org
Subject: Re: How to request an IRQ for NMI on MIPS Processor


Liu,

On Tue, Nov 11, 2003 at 10:51:50AM +0800, Liu Hongming (Alan) wrote:

> when using request_irq(...),the parameter irq is a value specified by you,
> of course,when porting linux for your board,you should have specified
value
> for every IRQ. 0--5 only means CPU pin for interrupt,unless that only one
> interrupt
> may occur on this pin,you will use other value in request_irq,instead of
> 0-5.
>  
> all in all, when we touch request_irq,it is board specific.When your board
> has
> been made out,all interrupts have specific route to cpu(unless you have
IRQ
> router,since embedded,need this??).If you have more external interrupts
than
> cpu pins,maybe you have cascaded many interrupt using one cpu pin.So,
> the parameter irq in request_irq is determined by your board and your
> porting
> for interrupt handling.Just ask that guy that ported linux.He will tell
> you.If you
> are using linux ported by others,have a look at BSP codes.

your answer is correct for normal interrupts, not the NMI.  The NMI goes
through the firmware and none of the board support code so far bothered
to make it available via request_irq as it has several severe limitations.
To repeat one of my prior postings about the NMI:

NMI on MIPS is pretty much miss-designed for use in application code; it's
use should be limited to debugging and recovery from catastrophical
failure.  The reason for this is the way this exception is handled:
 

  - the BEV, TS, SR, NMI and ERL bits in c0_status are overwritten - that is
    their old state is lost.
  - c0_errorepc is overwritten - again that means the old value is lost so
    in case the NMI interrupts an exception handler that uses this register
    such as the cache error handler you can not resume execution.
  - the program counter is set to 0xbfc00000.  Most likely a slow flash
    memory is mapped at this address but in any case it's an uncached
    segment of the address space so execution will be even slower.
  - execution will pass through the firmware.  That means you can only
    use the NMI at all if firmware provides some kind of hook.
 

It seems pretty clear to me that the MIPS designers never intended the
NMI for anything else than catastrophic events.

  Ralf

------_=_NextPart_001_01C3A80D.BC891ED0
Content-Type: text/html;
	charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 3.2//EN">
<HTML>
<HEAD>
<META HTTP-EQUIV=3D"Content-Type" CONTENT=3D"text/html; =
charset=3DISO-8859-1">
<META NAME=3D"Generator" CONTENT=3D"MS Exchange Server version =
5.5.2653.12">
<TITLE>RE: How to request an IRQ for NMI on MIPS Processor</TITLE>
</HEAD>
<BODY>
<BR>

<P><FONT SIZE=3D2>Hi Ralf,</FONT>
</P>

<P><FONT SIZE=3D2>I have never used these kind of boards.It seems to me =
</FONT>
<BR><FONT SIZE=3D2>NMI is implemented by interrupt controller,to cpu,it =
is a </FONT>
<BR><FONT SIZE=3D2>normal interrupt source.If 'NMI' in Adeel's board is =
like </FONT>
<BR><FONT SIZE=3D2>what you repeated,request_irq could just use cpu's =
pin number</FONT>
<BR><FONT SIZE=3D2>as the 'irq' parameter. I think NMI has been used in =
many</FONT>
<BR><FONT SIZE=3D2>boards that only means 'non-maskable' to interrupt =
controller,</FONT>
<BR><FONT SIZE=3D2>not cpu. If it is this case, NMI interrupt is a =
normal case.</FONT>
</P>

<P><FONT SIZE=3D2>Regards,</FONT>
<BR><FONT SIZE=3D2>Alan Liu</FONT>
</P>

<P><FONT SIZE=3D2>-----Original Message-----</FONT>
<BR><FONT SIZE=3D2>From: Ralf Baechle [<A =
HREF=3D"mailto:ralf@linux-mips.org">mailto:ralf@linux-mips.org</A>]</FON=
T>
<BR><FONT SIZE=3D2>Sent: Tuesday, November 11, 2003 11:40 AM</FONT>
<BR><FONT SIZE=3D2>To: Liu Hongming (Alan)</FONT>
<BR><FONT SIZE=3D2>Cc: Adeel Malik; linux-mips@linux-mips.org</FONT>
<BR><FONT SIZE=3D2>Subject: Re: How to request an IRQ for NMI on MIPS =
Processor</FONT>
</P>
<BR>

<P><FONT SIZE=3D2>Liu,</FONT>
</P>

<P><FONT SIZE=3D2>On Tue, Nov 11, 2003 at 10:51:50AM +0800, Liu =
Hongming (Alan) wrote:</FONT>
</P>

<P><FONT SIZE=3D2>&gt; when using request_irq(...),the parameter irq is =
a value specified by you,</FONT>
<BR><FONT SIZE=3D2>&gt; of course,when porting linux for your board,you =
should have specified value</FONT>
<BR><FONT SIZE=3D2>&gt; for every IRQ. 0--5 only means CPU pin for =
interrupt,unless that only one</FONT>
<BR><FONT SIZE=3D2>&gt; interrupt</FONT>
<BR><FONT SIZE=3D2>&gt; may occur on this pin,you will use other value =
in request_irq,instead of</FONT>
<BR><FONT SIZE=3D2>&gt; 0-5.</FONT>
<BR><FONT SIZE=3D2>&gt;&nbsp; </FONT>
<BR><FONT SIZE=3D2>&gt; all in all, when we touch request_irq,it is =
board specific.When your board</FONT>
<BR><FONT SIZE=3D2>&gt; has</FONT>
<BR><FONT SIZE=3D2>&gt; been made out,all interrupts have specific =
route to cpu(unless you have IRQ</FONT>
<BR><FONT SIZE=3D2>&gt; router,since embedded,need this??).If you have =
more external interrupts than</FONT>
<BR><FONT SIZE=3D2>&gt; cpu pins,maybe you have cascaded many interrupt =
using one cpu pin.So,</FONT>
<BR><FONT SIZE=3D2>&gt; the parameter irq in request_irq is determined =
by your board and your</FONT>
<BR><FONT SIZE=3D2>&gt; porting</FONT>
<BR><FONT SIZE=3D2>&gt; for interrupt handling.Just ask that guy that =
ported linux.He will tell</FONT>
<BR><FONT SIZE=3D2>&gt; you.If you</FONT>
<BR><FONT SIZE=3D2>&gt; are using linux ported by others,have a look at =
BSP codes.</FONT>
</P>

<P><FONT SIZE=3D2>your answer is correct for normal interrupts, not the =
NMI.&nbsp; The NMI goes</FONT>
<BR><FONT SIZE=3D2>through the firmware and none of the board support =
code so far bothered</FONT>
<BR><FONT SIZE=3D2>to make it available via request_irq as it has =
several severe limitations.</FONT>
<BR><FONT SIZE=3D2>To repeat one of my prior postings about the =
NMI:</FONT>
</P>

<P><FONT SIZE=3D2>NMI on MIPS is pretty much miss-designed for use in =
application code; it's</FONT>
<BR><FONT SIZE=3D2>use should be limited to debugging and recovery from =
catastrophical</FONT>
<BR><FONT SIZE=3D2>failure.&nbsp; The reason for this is the way this =
exception is handled:</FONT>
<BR><FONT =
SIZE=3D2>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </FONT>
<BR><FONT SIZE=3D2>&nbsp; - the BEV, TS, SR, NMI and ERL bits in =
c0_status are overwritten - that is</FONT>
<BR><FONT SIZE=3D2>&nbsp;&nbsp;&nbsp; their old state is lost.</FONT>
<BR><FONT SIZE=3D2>&nbsp; - c0_errorepc is overwritten - again that =
means the old value is lost so</FONT>
<BR><FONT SIZE=3D2>&nbsp;&nbsp;&nbsp; in case the NMI interrupts an =
exception handler that uses this register</FONT>
<BR><FONT SIZE=3D2>&nbsp;&nbsp;&nbsp; such as the cache error handler =
you can not resume execution.</FONT>
<BR><FONT SIZE=3D2>&nbsp; - the program counter is set to =
0xbfc00000.&nbsp; Most likely a slow flash</FONT>
<BR><FONT SIZE=3D2>&nbsp;&nbsp;&nbsp; memory is mapped at this address =
but in any case it's an uncached</FONT>
<BR><FONT SIZE=3D2>&nbsp;&nbsp;&nbsp; segment of the address space so =
execution will be even slower.</FONT>
<BR><FONT SIZE=3D2>&nbsp; - execution will pass through the =
firmware.&nbsp; That means you can only</FONT>
<BR><FONT SIZE=3D2>&nbsp;&nbsp;&nbsp; use the NMI at all if firmware =
provides some kind of hook.</FONT>
<BR><FONT =
SIZE=3D2>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </FONT>
<BR><FONT SIZE=3D2>It seems pretty clear to me that the MIPS designers =
never intended the</FONT>
<BR><FONT SIZE=3D2>NMI for anything else than catastrophic =
events.</FONT>
</P>

<P><FONT SIZE=3D2>&nbsp; Ralf</FONT>
</P>

</BODY>
</HTML>
------_=_NextPart_001_01C3A80D.BC891ED0--
