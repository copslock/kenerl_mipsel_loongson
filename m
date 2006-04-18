Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 18 Apr 2006 18:38:24 +0100 (BST)
Received: from father.pmc-sierra.com ([216.241.224.13]:28613 "HELO
	father.pmc-sierra.bc.ca") by ftp.linux-mips.org with SMTP
	id S8133489AbWDRRiO (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 18 Apr 2006 18:38:14 +0100
Received: (qmail 4660 invoked by uid 101); 18 Apr 2006 17:50:33 -0000
Received: from unknown (HELO ogyruan.pmc-sierra.bc.ca) (216.241.226.236)
  by father.pmc-sierra.com with SMTP; 18 Apr 2006 17:50:33 -0000
Received: from bby1exi01.pmc_nt.nt.pmc-sierra.bc.ca (bby1exi01.pmc-sierra.bc.ca [216.241.231.251])
	by ogyruan.pmc-sierra.bc.ca (8.13.3/8.12.7) with ESMTP id k3IHoWgF026358
	for <linux-mips@linux-mips.org>; Tue, 18 Apr 2006 10:50:33 -0700
Received: by bby1exi01.pmc-sierra.bc.ca with Internet Mail Service (5.5.2656.59)
	id <132HTRND>; Tue, 18 Apr 2006 10:50:32 -0700
Message-ID: <12E9F4D6141E504DA2F115E577252AC7C09451@sjc1exm04.pmc-sierra.bc.ca>
From:	Raj Palani <Rajesh_Palani@pmc-sierra.com>
To:	linux-mips@linux-mips.org
Subject: Question on SMP warning in irq_cpu.c
Date:	Tue, 18 Apr 2006 10:50:28 -0700
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2656.59)
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C66310.947F7908"
Return-Path: <Rajesh_Palani@pmc-sierra.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11154
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Rajesh_Palani@pmc-sierra.com
Precedence: bulk
X-list: linux-mips

This message is in MIME format. Since your mail reader does not understand
this format, some or all of this message may not be legible.

------_=_NextPart_001_01C66310.947F7908
Content-Type: text/plain

Hi,
   I have a question regarding the following warning in the arch/mips/kernel/irq_cpu.c.
   What is the reason for this comment and in case it is not SMP safe, what are the changes needed to make it SMP safe?
/*
 * Almost all MIPS CPUs define 8 interrupt sources.  They are typically
 * level triggered (i.e., cannot be cleared from CPU; must be cleared from
 * device).  The first two are software interrupts which we don't really
 * use or support.  The last one is usually the CPU timer interrupt if
 * counter register is present or, for CPUs with an external FPU, by
 * convention it's the FPU exception interrupt.
 *
 * Don't even think about using this on SMP.  You have been warned.
 *
 * This file exports one global function:
 *	void mips_cpu_irq_init(int irq_base);
 */
   Thanks.
   Raj

------_=_NextPart_001_01C66310.947F7908
Content-Type: text/html
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 3.2//EN">
<HTML>
<HEAD>
<META HTTP-EQUIV=3D"Content-Type" CONTENT=3D"text/html; =
charset=3DUS-ASCII">
<META NAME=3D"Generator" CONTENT=3D"MS Exchange Server version =
5.5.2658.24">
<TITLE>Question on SMP warning in irq_cpu.c</TITLE>
</HEAD>
<BODY>

<P><FONT SIZE=3D2 FACE=3D"Courier New">Hi,</FONT>
<BR><FONT SIZE=3D2 FACE=3D"Courier New">&nbsp;&nbsp; I have a question =
regarding the following warning in the =
arch/mips/kernel/irq_cpu.c.</FONT>
<BR><FONT SIZE=3D2 FACE=3D"Courier New">&nbsp;&nbsp; What is the reason =
for this comment and in case it is not SMP safe, what are the changes =
needed to make it SMP safe?</FONT>
<BR><FONT SIZE=3D2 FACE=3D"Courier New">/*</FONT>
<BR><FONT SIZE=3D2 FACE=3D"Courier New">&nbsp;* Almost all MIPS CPUs =
define 8 interrupt sources.&nbsp; They are typically</FONT>
<BR><FONT SIZE=3D2 FACE=3D"Courier New">&nbsp;* level triggered (i.e., =
cannot be cleared from CPU; must be cleared from</FONT>
<BR><FONT SIZE=3D2 FACE=3D"Courier New">&nbsp;* device).&nbsp; The =
first two are software interrupts which we don't really</FONT>
<BR><FONT SIZE=3D2 FACE=3D"Courier New">&nbsp;* use or support.&nbsp; =
The last one is usually the CPU timer interrupt if</FONT>
<BR><FONT SIZE=3D2 FACE=3D"Courier New">&nbsp;* counter register is =
present or, for CPUs with an external FPU, by</FONT>
<BR><FONT SIZE=3D2 FACE=3D"Courier New">&nbsp;* convention it's the FPU =
exception interrupt.</FONT>
<BR><FONT SIZE=3D2 FACE=3D"Courier New">&nbsp;*</FONT>
<BR><FONT SIZE=3D2 FACE=3D"Courier New">&nbsp;* Don't even think about =
using this on SMP.&nbsp; You have been warned.</FONT>
<BR><FONT SIZE=3D2 FACE=3D"Courier New">&nbsp;*</FONT>
<BR><FONT SIZE=3D2 FACE=3D"Courier New">&nbsp;* This file exports one =
global function:</FONT>
<BR><FONT SIZE=3D2 FACE=3D"Courier =
New">&nbsp;*&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; void mips_cpu_irq_init(int =
irq_base);</FONT>
<BR><FONT SIZE=3D2 FACE=3D"Courier New">&nbsp;*/</FONT>
<BR><FONT SIZE=3D2 FACE=3D"Courier New">&nbsp;&nbsp; Thanks.</FONT>
<BR><FONT SIZE=3D2 FACE=3D"Courier New">&nbsp;&nbsp; Raj</FONT>
</P>

</BODY>
</HTML>
------_=_NextPart_001_01C66310.947F7908--
