Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 18 Apr 2003 01:15:16 +0100 (BST)
Received: from [IPv6:::ffff:207.16.149.110] ([IPv6:::ffff:207.16.149.110]:26312
	"EHLO mail.teralogic.tv") by linux-mips.org with ESMTP
	id <S8225227AbTDRAPP>; Fri, 18 Apr 2003 01:15:15 +0100
Received: from tlexmail.teralogic.tv (tlexmail [192.168.100.138])
	by mail.teralogic.tv (8.11.6/8.11.6) with ESMTP id h3I0BlO27345;
	Thu, 17 Apr 2003 17:11:47 -0700 (PDT)
Received: by TLEXMAIL with Internet Mail Service (5.5.2653.19)
	id <22ACPC9C>; Thu, 17 Apr 2003 17:08:36 -0700
Message-ID: <56BEF0DBC8B9D611BFDB00508B5E2634102F17@TLEXMAIL>
From: Dennis Castleman <DennisCastleman@oaktech.com>
To: "'Ralf Baechle'" <ralf@linux-mips.org>,
	Dennis Castleman <DennisCastleman@oaktech.com>
Cc: linux-mips@linux-mips.org
Subject: RE: your mail
Date: Thu, 17 Apr 2003 17:08:34 -0700
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C3053E.A7230FF0"
Return-Path: <DennisCastleman@oaktech.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2105
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: DennisCastleman@oaktech.com
Precedence: bulk
X-list: linux-mips

This message is in MIME format. Since your mail reader does not understand
this format, some or all of this message may not be legible.

------_=_NextPart_001_01C3053E.A7230FF0
Content-Type: text/plain

Thanks Ralf

Looks like I made the correct call when I picked MIPS32 Kernel.
Look like some of my preformance issues are in Montavistas 2.95.3 toolchain,
it's generating code that looks like this

0000000000000000 <bitBufferCreate>:
   0: 27bdffe0  addiu $sp,$sp,-32
   4: afbf001c  sw  $ra,28($sp)
   8: afb20018  sw  $s2,24($sp)
   c: afb10014  sw  $s1,20($sp)
  10: afb00010  sw  $s0,16($sp)
  14: 00809021  move  $s2,$a0
  18: 00a08021  move  $s0,$a1
  1c: 00c08821  move  $s1,$a2
  20: 24040001  li  $a0,1
  24: 24050010  li  $a1,16
  28: 3c020000  lui $v0,0x0
  2c: 24420000  addiu $v0,$v0,0

but if I use the 2.95.3 toolchain I build myself it's
generating code that looks like this.

0000000000000000 <bitBufferCreate>:
   0: 27bdffe0  addiu $sp,$sp,-32
   4: afb20018  sw  $s2,24($sp)
   8: 00809021  move  $s2,$a0
   c: afb00010  sw  $s0,16($sp)
  10: 00a08021  move  $s0,$a1
  14: afb10014  sw  $s1,20($sp)
  18: 00c08821  move  $s1,$a2
  1c: 24040001  li  $a0,1
  20: 24050010  li  $a1,16
  24: 3c020000  lui $v0,0x0
  28: 24420000  addiu $v0,$v0,0


Any idea whats up MV tool-chain.


Dennis 


-----Original Message-----
From: Ralf Baechle [mailto:ralf@linux-mips.org]
Sent: Thursday, April 17, 2003 5:04 PM
To: Dennis Castleman
Cc: linux-mips@linux-mips.org
Subject: Re: your mail


On Thu, Apr 17, 2003 at 10:53:57AM -0700, Dennis Castleman wrote:

> Anybody know the performance differences I can expect using a MIPS 5K core
> @250 Mhz in 64bit mode versus 32bit mode?

As a rule of thumb - less performance.  64-bit code is typically larger
resulting in lower cache hit rate.  And since performance optimization
these days is essentially equivalent to maximising the cache hit rate
going 64-bit usually means a performance drop due to the drastically
larger size of code and data.

On the positive side for 64-bit stuff there's the possibility to do
64-bit computations with just one instruction, move data with less
instructions, use twice as many double precission fp registers that are
offered by 64-bit ABIs and more calling sequences.

The first two paragraphs were sort of a generic statement regarding
32-bit vs. 64-bit software on MIPS processors and affect both kernel and
userspace.  There's a few additional issues with the Linux kernel.
The 32-bit kernels requires all memory to be addressable through KSEG0
which limits it to at most 512MB; typically the limit is more like 256MB.
Memory above 512MB physical address can only be used as highmem.  That's
fairly inefficient and requires alot of special care when writing new
kernel software.  For processors that suffer from virtual aliases in
their data cache highmem currently is frighteningly inefficient - and
high memory pressure on lowmem doesn't help either.  So from a certain
point on that's simply making a 64-bit kernel is simply the better
idea - even for running 32-bit software.  That in particular applies
to very I/O intensive stuff.

In short - the right choice is a tradeoff between the hardware platform
and the application's requirements.  Choose wrong and you'll curse
loudly :-)

  Ralf

------_=_NextPart_001_01C3053E.A7230FF0
Content-Type: text/html

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 3.2//EN">
<HTML>
<HEAD>
<META HTTP-EQUIV="Content-Type" CONTENT="text/html; charset=us-ascii">
<META NAME="Generator" CONTENT="MS Exchange Server version 5.5.2653.12">
<TITLE>RE: your mail</TITLE>
</HEAD>
<BODY>

<P><FONT SIZE=2>Thanks Ralf</FONT>
</P>

<P><FONT SIZE=2>Looks like I made the correct call when I picked MIPS32 Kernel.</FONT>
<BR><FONT SIZE=2>Look like some of my preformance issues are in Montavistas 2.95.3 toolchain,</FONT>
<BR><FONT SIZE=2>it's generating code that looks like this</FONT>
</P>

<P><FONT SIZE=2>0000000000000000 &lt;bitBufferCreate&gt;:</FONT>
<BR><FONT SIZE=2>&nbsp;&nbsp; 0: 27bdffe0&nbsp; addiu $sp,$sp,-32</FONT>
<BR><FONT SIZE=2>&nbsp;&nbsp; 4: afbf001c&nbsp; sw&nbsp; $ra,28($sp)</FONT>
<BR><FONT SIZE=2>&nbsp;&nbsp; 8: afb20018&nbsp; sw&nbsp; $s2,24($sp)</FONT>
<BR><FONT SIZE=2>&nbsp;&nbsp; c: afb10014&nbsp; sw&nbsp; $s1,20($sp)</FONT>
<BR><FONT SIZE=2>&nbsp; 10: afb00010&nbsp; sw&nbsp; $s0,16($sp)</FONT>
<BR><FONT SIZE=2>&nbsp; 14: 00809021&nbsp; move&nbsp; $s2,$a0</FONT>
<BR><FONT SIZE=2>&nbsp; 18: 00a08021&nbsp; move&nbsp; $s0,$a1</FONT>
<BR><FONT SIZE=2>&nbsp; 1c: 00c08821&nbsp; move&nbsp; $s1,$a2</FONT>
<BR><FONT SIZE=2>&nbsp; 20: 24040001&nbsp; li&nbsp; $a0,1</FONT>
<BR><FONT SIZE=2>&nbsp; 24: 24050010&nbsp; li&nbsp; $a1,16</FONT>
<BR><FONT SIZE=2>&nbsp; 28: 3c020000&nbsp; lui $v0,0x0</FONT>
<BR><FONT SIZE=2>&nbsp; 2c: 24420000&nbsp; addiu $v0,$v0,0</FONT>
</P>

<P><FONT SIZE=2>but if I use the 2.95.3 toolchain I build myself it's</FONT>
<BR><FONT SIZE=2>generating code that looks like this.</FONT>
</P>

<P><FONT SIZE=2>0000000000000000 &lt;bitBufferCreate&gt;:</FONT>
<BR><FONT SIZE=2>&nbsp;&nbsp; 0: 27bdffe0&nbsp; addiu $sp,$sp,-32</FONT>
<BR><FONT SIZE=2>&nbsp;&nbsp; 4: afb20018&nbsp; sw&nbsp; $s2,24($sp)</FONT>
<BR><FONT SIZE=2>&nbsp;&nbsp; 8: 00809021&nbsp; move&nbsp; $s2,$a0</FONT>
<BR><FONT SIZE=2>&nbsp;&nbsp; c: afb00010&nbsp; sw&nbsp; $s0,16($sp)</FONT>
<BR><FONT SIZE=2>&nbsp; 10: 00a08021&nbsp; move&nbsp; $s0,$a1</FONT>
<BR><FONT SIZE=2>&nbsp; 14: afb10014&nbsp; sw&nbsp; $s1,20($sp)</FONT>
<BR><FONT SIZE=2>&nbsp; 18: 00c08821&nbsp; move&nbsp; $s1,$a2</FONT>
<BR><FONT SIZE=2>&nbsp; 1c: 24040001&nbsp; li&nbsp; $a0,1</FONT>
<BR><FONT SIZE=2>&nbsp; 20: 24050010&nbsp; li&nbsp; $a1,16</FONT>
<BR><FONT SIZE=2>&nbsp; 24: 3c020000&nbsp; lui $v0,0x0</FONT>
<BR><FONT SIZE=2>&nbsp; 28: 24420000&nbsp; addiu $v0,$v0,0</FONT>
</P>
<BR>

<P><FONT SIZE=2>Any idea whats up MV tool-chain.</FONT>
</P>
<BR>

<P><FONT SIZE=2>Dennis </FONT>
</P>
<BR>

<P><FONT SIZE=2>-----Original Message-----</FONT>
<BR><FONT SIZE=2>From: Ralf Baechle [<A HREF="mailto:ralf@linux-mips.org">mailto:ralf@linux-mips.org</A>]</FONT>
<BR><FONT SIZE=2>Sent: Thursday, April 17, 2003 5:04 PM</FONT>
<BR><FONT SIZE=2>To: Dennis Castleman</FONT>
<BR><FONT SIZE=2>Cc: linux-mips@linux-mips.org</FONT>
<BR><FONT SIZE=2>Subject: Re: your mail</FONT>
</P>
<BR>

<P><FONT SIZE=2>On Thu, Apr 17, 2003 at 10:53:57AM -0700, Dennis Castleman wrote:</FONT>
</P>

<P><FONT SIZE=2>&gt; Anybody know the performance differences I can expect using a MIPS 5K core</FONT>
<BR><FONT SIZE=2>&gt; @250 Mhz in 64bit mode versus 32bit mode?</FONT>
</P>

<P><FONT SIZE=2>As a rule of thumb - less performance.&nbsp; 64-bit code is typically larger</FONT>
<BR><FONT SIZE=2>resulting in lower cache hit rate.&nbsp; And since performance optimization</FONT>
<BR><FONT SIZE=2>these days is essentially equivalent to maximising the cache hit rate</FONT>
<BR><FONT SIZE=2>going 64-bit usually means a performance drop due to the drastically</FONT>
<BR><FONT SIZE=2>larger size of code and data.</FONT>
</P>

<P><FONT SIZE=2>On the positive side for 64-bit stuff there's the possibility to do</FONT>
<BR><FONT SIZE=2>64-bit computations with just one instruction, move data with less</FONT>
<BR><FONT SIZE=2>instructions, use twice as many double precission fp registers that are</FONT>
<BR><FONT SIZE=2>offered by 64-bit ABIs and more calling sequences.</FONT>
</P>

<P><FONT SIZE=2>The first two paragraphs were sort of a generic statement regarding</FONT>
<BR><FONT SIZE=2>32-bit vs. 64-bit software on MIPS processors and affect both kernel and</FONT>
<BR><FONT SIZE=2>userspace.&nbsp; There's a few additional issues with the Linux kernel.</FONT>
<BR><FONT SIZE=2>The 32-bit kernels requires all memory to be addressable through KSEG0</FONT>
<BR><FONT SIZE=2>which limits it to at most 512MB; typically the limit is more like 256MB.</FONT>
<BR><FONT SIZE=2>Memory above 512MB physical address can only be used as highmem.&nbsp; That's</FONT>
<BR><FONT SIZE=2>fairly inefficient and requires alot of special care when writing new</FONT>
<BR><FONT SIZE=2>kernel software.&nbsp; For processors that suffer from virtual aliases in</FONT>
<BR><FONT SIZE=2>their data cache highmem currently is frighteningly inefficient - and</FONT>
<BR><FONT SIZE=2>high memory pressure on lowmem doesn't help either.&nbsp; So from a certain</FONT>
<BR><FONT SIZE=2>point on that's simply making a 64-bit kernel is simply the better</FONT>
<BR><FONT SIZE=2>idea - even for running 32-bit software.&nbsp; That in particular applies</FONT>
<BR><FONT SIZE=2>to very I/O intensive stuff.</FONT>
</P>

<P><FONT SIZE=2>In short - the right choice is a tradeoff between the hardware platform</FONT>
<BR><FONT SIZE=2>and the application's requirements.&nbsp; Choose wrong and you'll curse</FONT>
<BR><FONT SIZE=2>loudly :-)</FONT>
</P>

<P><FONT SIZE=2>&nbsp; Ralf</FONT>
</P>

</BODY>
</HTML>
------_=_NextPart_001_01C3053E.A7230FF0--
