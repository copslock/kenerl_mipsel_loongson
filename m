Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 11 Nov 2003 05:35:03 +0000 (GMT)
Received: from [IPv6:::ffff:202.96.215.33] ([IPv6:::ffff:202.96.215.33]:60936
	"EHLO tmtms.trident.com.cn") by linux-mips.org with ESMTP
	id <S8225361AbTKKFev>; Tue, 11 Nov 2003 05:34:51 +0000
Received: by TMTMS with Internet Mail Service (5.5.2653.19)
	id <WT9PVVPG>; Tue, 11 Nov 2003 13:27:48 +0800
Message-ID: <15F9E1AE3207D6119CEA00D0B7DD5F6801C9949F@TMTMS>
From: "Liu Hongming (Alan)" <alanliu@trident.com.cn>
To: Adeel Malik <AdeelM@quartics.com>,
	"Liu Hongming (Alan)" <alanliu@trident.com.cn>
Cc: Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Subject: RE: How to request an IRQ for NMI on MIPS Processor
Date: Tue, 11 Nov 2003 13:26:53 +0800
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C3A814.6A4B7C10"
Return-Path: <alanliu@trident.com.cn>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3599
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: alanliu@trident.com.cn
Precedence: bulk
X-list: linux-mips

This message is in MIME format. Since your mail reader does not understand
this format, some or all of this message may not be legible.

------_=_NextPart_001_01C3A814.6A4B7C10
Content-Type: text/plain;
	charset="ISO-8859-1"

 
Hi Adeel,
 
I have understood your situation.
 
Under this situation,I think you need not use request_irq.
Just keep your 'interrupt' handler in BIOS or bootloader,
of course,it is different with Rest Exception,since 
many registers' status are not the same as hardware-reseting.
You could detect the difference.Right?
 
 
Alan Liu
 
-----Original Message-----
From: Adeel Malik [mailto:AdeelM@quartics.com]
Sent: Tuesday, November 11, 2003 1:22 PM
To: Liu Hongming (Alan)
Cc: Ralf Baechle; linux-mips@linux-mips.org
Subject: RE: How to request an IRQ for NMI on MIPS Processor


Liu,
      In my board the interrupt was routed directly to an NMI line of MIPS
CPU rather than regular IRQs 0 - 5.   I went through the MIPS Architecture
Programming Guide Document, describing Interrupt and Exception Handling for
MIPS Processor. It is written there that although a Non-Maskable Interrupt
(NMI) includes "interrupt" in its name, it is more correctly described as an
NMI exception because it does not affect, nor is it controlled by the
processor interrupt system. 
 
Secondly, Linux Kernel especially the Embedded Linux Versions for various
Processors doesn't support the use of NMI as a regular IRQ.
 
The Interrupt Vector Address of all the Hardware Interrupt from IRQ0 - IRQ5
for MIPS Processor have the same vector location that is 0x80000180 or
0x80000380 which is a cached access, but the vector Location of NMI is
0xbfc00000 which is an un-cached access. So one needs to modify the
boot-code which is error-prone if it is possible at all.
 
Thatswhy we don't find much code related to NMIs in Linux.
 
ADEEL MALIK,

-----Original Message-----
From: linux-mips-bounce@linux-mips.org
[mailto:linux-mips-bounce@linux-mips.org]On Behalf Of Liu Hongming (Alan)
Sent: Tuesday, November 11, 2003 9:39 AM
To: Ralf Baechle; Liu Hongming (Alan)
Cc: Adeel Malik; linux-mips@linux-mips.org
Subject: RE: How to request an IRQ for NMI on MIPS Processor




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
From: Ralf Baechle [ mailto:ralf@linux-mips.org <mailto:ralf@linux-mips.org>
] 
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


------_=_NextPart_001_01C3A814.6A4B7C10
Content-Type: text/html;
	charset="ISO-8859-1"

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD>
<META HTTP-EQUIV="Content-Type" CONTENT="text/html; charset=ISO-8859-1">
<TITLE>RE: How to request an IRQ for NMI on MIPS Processor</TITLE>

<META content="MSHTML 6.00.2600.0" name=GENERATOR></HEAD>
<BODY hb_focus_attach="true">
<DIV><SPAN class=495232905-11112003><FONT face=&#23435;&#20307; color=#0000ff 
size=2></FONT></SPAN>&nbsp;</DIV>
<DIV><SPAN class=495232905-11112003><FONT face=&#23435;&#20307; color=#0000ff size=2>Hi 
Adeel,</FONT></SPAN></DIV>
<DIV><SPAN class=495232905-11112003><FONT face=&#23435;&#20307; color=#0000ff 
size=2></FONT></SPAN>&nbsp;</DIV>
<DIV><SPAN class=495232905-11112003><FONT face=&#23435;&#20307; color=#0000ff size=2>I have 
understood your situation.</FONT></SPAN></DIV>
<DIV><SPAN class=495232905-11112003><FONT face=&#23435;&#20307; color=#0000ff 
size=2></FONT></SPAN>&nbsp;</DIV>
<DIV><SPAN class=495232905-11112003><FONT face=&#23435;&#20307; color=#0000ff size=2>Under 
this situation,I think you need not use request_irq.</FONT></SPAN></DIV>
<DIV><SPAN class=495232905-11112003><FONT face=&#23435;&#20307; color=#0000ff size=2>Just 
</FONT></SPAN><SPAN class=495232905-11112003><FONT face=&#23435;&#20307; color=#0000ff 
size=2>keep your 'interrupt' handler in BIOS or bootloader,</FONT></SPAN></DIV>
<DIV><SPAN class=495232905-11112003><FONT face=&#23435;&#20307; color=#0000ff size=2>of 
course,it is different with Rest Exception,since </FONT></SPAN></DIV>
<DIV><SPAN class=495232905-11112003><FONT face=&#23435;&#20307; color=#0000ff size=2>many 
registers' status&nbsp;are not the same as 
hardware-reseting.</FONT></SPAN></DIV>
<DIV><SPAN class=495232905-11112003><FONT face=&#23435;&#20307; color=#0000ff size=2>You could 
detect the difference.</FONT></SPAN><SPAN class=495232905-11112003><FONT face=&#23435;&#20307; 
color=#0000ff size=2>Right?</FONT></SPAN></DIV>
<DIV><SPAN class=495232905-11112003></SPAN>&nbsp;</DIV>
<DIV><SPAN class=495232905-11112003><FONT face=&#23435;&#20307; color=#0000ff 
size=2></FONT></SPAN>&nbsp;</DIV>
<DIV><SPAN class=495232905-11112003><FONT face=&#23435;&#20307; color=#0000ff size=2>Alan 
Liu</FONT></SPAN></DIV>
<DIV><SPAN class=495232905-11112003><FONT face=&#23435;&#20307; color=#0000ff 
size=2></FONT></SPAN>&nbsp;</DIV>
<DIV class=OutlookMessageHeader><FONT face="Times New Roman" 
size=2>-----Original Message-----<BR><B>From:</B> Adeel Malik 
[mailto:AdeelM@quartics.com]<BR><B>Sent:</B> Tuesday, November 11, 2003 1:22 
PM<BR><B>To:</B> Liu Hongming (Alan)<BR><B>Cc:</B> Ralf Baechle; 
linux-mips@linux-mips.org<BR><B>Subject:</B> RE: How to request an IRQ for NMI 
on MIPS Processor<BR><BR></FONT></DIV>
<DIV><FONT face=Arial color=#0000ff size=2><SPAN 
class=118040205-11112003>Liu,</SPAN></FONT></DIV>
<DIV><FONT size=2><FONT face=Arial color=#0000ff><SPAN 
class=118040205-11112003>&nbsp;&nbsp;&nbsp;<FONT face="Times New Roman" 
color=#000000>&nbsp;&nbsp; In my board the interrupt 
was&nbsp;routed&nbsp;directly&nbsp;to an NMI line of MIPS&nbsp;CPU rather than 
regular IRQs 0 - 5.&nbsp;&nbsp;&nbsp;I&nbsp;went through 
the</FONT></SPAN></FONT> MIPS Architecture Programming Guide Document<SPAN 
class=118040205-11112003>,&nbsp;describing Interrupt and Exception Handling for 
MIPS Processor. It is written there</SPAN>&nbsp;that&nbsp;<U><SPAN 
class=118040205-11112003>a</SPAN>lthough a Non-Maskable Interrupt (NMI) 
includes<SPAN class=118040205-11112003> </SPAN>"interrupt" in its name, it is 
more correctly described as an NMI exception because it does not affect, nor is 
it controlled<SPAN class=118040205-11112003> </SPAN>by the processor interrupt 
system.</U> </FONT></DIV>
<DIV><U><FONT size=2></FONT></U>&nbsp;</DIV>
<DIV><SPAN class=118040205-11112003><FONT size=2>Secondly, Linux Kernel 
especially the Embedded Linux Versions for various Processors doesn't support 
the use of NMI as a regular IRQ.</FONT></SPAN></DIV>
<DIV><FONT size=2></FONT>&nbsp;</DIV>
<DIV><FONT size=2><SPAN class=118040205-11112003>The</SPAN>&nbsp;Interrupt 
Vector Address of all the Hardware Interrupt from IRQ0 - IRQ5<SPAN 
class=118040205-11112003> for MIPS Processor</SPAN>&nbsp;have the same vector 
location that is 0x80000180&nbsp;<SPAN class=118040205-11112003>or 0x80000380 
</SPAN>which is a cached access, but the vector Location of NMI is 0xbfc00000 
which is an un-cached access. So&nbsp;<SPAN class=118040205-11112003>one</SPAN> 
need<SPAN class=118040205-11112003>s</SPAN> to modify the boot-code 
which&nbsp;<SPAN class=118040205-11112003>is </SPAN>error-prone if it is 
possible at all.</FONT></DIV>
<DIV><FONT size=2></FONT>&nbsp;</DIV>
<DIV><FONT size=2>Thatswhy we don't find much code related to NMIs in 
Linux.</FONT></DIV>
<DIV><FONT face=&#23435;&#20307; color=#0000ff size=2></FONT>&nbsp;</DIV>
<DIV><FONT face=Georgia color=#0000ff size=2><EM>ADEEL MALIK,</EM></FONT></DIV>
<BLOCKQUOTE dir=ltr style="MARGIN-RIGHT: 0px">
  <DIV class=OutlookMessageHeader dir=ltr align=left><FONT face=Tahoma 
  size=2>-----Original Message-----<BR><B>From:</B> 
  linux-mips-bounce@linux-mips.org 
  [mailto:linux-mips-bounce@linux-mips.org]<B>On Behalf Of </B>Liu Hongming 
  (Alan)<BR><B>Sent:</B> Tuesday, November 11, 2003 9:39 AM<BR><B>To:</B> Ralf 
  Baechle; Liu Hongming (Alan)<BR><B>Cc:</B> Adeel Malik; 
  linux-mips@linux-mips.org<BR><B>Subject:</B> RE: How to request an IRQ for NMI 
  on MIPS Processor<BR><BR></FONT></DIV><BR>
  <P><FONT size=2>Hi Ralf,</FONT> </P>
  <P><FONT size=2>I have never used these kind of boards.It seems to me 
  </FONT><BR><FONT size=2>NMI is implemented by interrupt controller,to cpu,it 
  is a </FONT><BR><FONT size=2>normal interrupt source.If 'NMI' in Adeel's board 
  is like </FONT><BR><FONT size=2>what you repeated,request_irq could just use 
  cpu's pin number</FONT> <BR><FONT size=2>as the 'irq' parameter. I think NMI 
  has been used in many</FONT> <BR><FONT size=2>boards that only means 
  'non-maskable' to interrupt controller,</FONT> <BR><FONT size=2>not cpu. If it 
  is this case, NMI interrupt is a normal case.</FONT> </P>
  <P><FONT size=2>Regards,</FONT> <BR><FONT size=2>Alan Liu</FONT> </P>
  <P><FONT size=2>-----Original Message-----</FONT> <BR><FONT size=2>From: Ralf 
  Baechle [<A 
  href="mailto:ralf@linux-mips.org">mailto:ralf@linux-mips.org</A>]</FONT> 
  <BR><FONT size=2>Sent: Tuesday, November 11, 2003 11:40 AM</FONT> <BR><FONT 
  size=2>To: Liu Hongming (Alan)</FONT> <BR><FONT size=2>Cc: Adeel Malik; 
  linux-mips@linux-mips.org</FONT> <BR><FONT size=2>Subject: Re: How to request 
  an IRQ for NMI on MIPS Processor</FONT> </P><BR>
  <P><FONT size=2>Liu,</FONT> </P>
  <P><FONT size=2>On Tue, Nov 11, 2003 at 10:51:50AM +0800, Liu Hongming (Alan) 
  wrote:</FONT> </P>
  <P><FONT size=2>&gt; when using request_irq(...),the parameter irq is a value 
  specified by you,</FONT> <BR><FONT size=2>&gt; of course,when porting linux 
  for your board,you should have specified value</FONT> <BR><FONT size=2>&gt; 
  for every IRQ. 0--5 only means CPU pin for interrupt,unless that only 
  one</FONT> <BR><FONT size=2>&gt; interrupt</FONT> <BR><FONT size=2>&gt; may 
  occur on this pin,you will use other value in request_irq,instead of</FONT> 
  <BR><FONT size=2>&gt; 0-5.</FONT> <BR><FONT size=2>&gt;&nbsp; </FONT><BR><FONT 
  size=2>&gt; all in all, when we touch request_irq,it is board specific.When 
  your board</FONT> <BR><FONT size=2>&gt; has</FONT> <BR><FONT size=2>&gt; been 
  made out,all interrupts have specific route to cpu(unless you have IRQ</FONT> 
  <BR><FONT size=2>&gt; router,since embedded,need this??).If you have more 
  external interrupts than</FONT> <BR><FONT size=2>&gt; cpu pins,maybe you have 
  cascaded many interrupt using one cpu pin.So,</FONT> <BR><FONT size=2>&gt; the 
  parameter irq in request_irq is determined by your board and your</FONT> 
  <BR><FONT size=2>&gt; porting</FONT> <BR><FONT size=2>&gt; for interrupt 
  handling.Just ask that guy that ported linux.He will tell</FONT> <BR><FONT 
  size=2>&gt; you.If you</FONT> <BR><FONT size=2>&gt; are using linux ported by 
  others,have a look at BSP codes.</FONT> </P>
  <P><FONT size=2>your answer is correct for normal interrupts, not the 
  NMI.&nbsp; The NMI goes</FONT> <BR><FONT size=2>through the firmware and none 
  of the board support code so far bothered</FONT> <BR><FONT size=2>to make it 
  available via request_irq as it has several severe limitations.</FONT> 
  <BR><FONT size=2>To repeat one of my prior postings about the NMI:</FONT> </P>
  <P><FONT size=2>NMI on MIPS is pretty much miss-designed for use in 
  application code; it's</FONT> <BR><FONT size=2>use should be limited to 
  debugging and recovery from catastrophical</FONT> <BR><FONT 
  size=2>failure.&nbsp; The reason for this is the way this exception is 
  handled:</FONT> <BR><FONT 
  size=2>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
  </FONT><BR><FONT size=2>&nbsp; - the BEV, TS, SR, NMI and ERL bits in 
  c0_status are overwritten - that is</FONT> <BR><FONT size=2>&nbsp;&nbsp;&nbsp; 
  their old state is lost.</FONT> <BR><FONT size=2>&nbsp; - c0_errorepc is 
  overwritten - again that means the old value is lost so</FONT> <BR><FONT 
  size=2>&nbsp;&nbsp;&nbsp; in case the NMI interrupts an exception handler that 
  uses this register</FONT> <BR><FONT size=2>&nbsp;&nbsp;&nbsp; such as the 
  cache error handler you can not resume execution.</FONT> <BR><FONT 
  size=2>&nbsp; - the program counter is set to 0xbfc00000.&nbsp; Most likely a 
  slow flash</FONT> <BR><FONT size=2>&nbsp;&nbsp;&nbsp; memory is mapped at this 
  address but in any case it's an uncached</FONT> <BR><FONT 
  size=2>&nbsp;&nbsp;&nbsp; segment of the address space so execution will be 
  even slower.</FONT> <BR><FONT size=2>&nbsp; - execution will pass through the 
  firmware.&nbsp; That means you can only</FONT> <BR><FONT 
  size=2>&nbsp;&nbsp;&nbsp; use the NMI at all if firmware provides some kind of 
  hook.</FONT> <BR><FONT 
  size=2>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
  </FONT><BR><FONT size=2>It seems pretty clear to me that the MIPS designers 
  never intended the</FONT> <BR><FONT size=2>NMI for anything else than 
  catastrophic events.</FONT> </P>
  <P><FONT size=2>&nbsp; Ralf</FONT> </P></BLOCKQUOTE>
<P></P></BODY></HTML>

------_=_NextPart_001_01C3A814.6A4B7C10--
