Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 18 Apr 2007 23:35:00 +0100 (BST)
Received: from mx.mips.com ([63.167.95.198]:26264 "EHLO dns0.mips.com")
	by ftp.linux-mips.org with ESMTP id S20021834AbXDRWe6 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 18 Apr 2007 23:34:58 +0100
Received: from mercury.mips.com (mercury [192.168.64.101])
	by dns0.mips.com (8.12.11/8.12.11) with ESMTP id l3IMRk9p005510;
	Wed, 18 Apr 2007 15:27:46 -0700 (PDT)
Received: from exchange.MIPS.COM (exchange [192.168.20.29])
	by mercury.mips.com (8.13.5/8.13.5) with ESMTP id l3IMRA02020482;
	Wed, 18 Apr 2007 15:27:11 -0700 (PDT)
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: [PATCH 3/16] Kconfig update for lemote fulong mini-PC
Date:	Wed, 18 Apr 2007 15:27:16 -0700
Message-ID: <692AB3595F5D76428B34B9BEFE20BC1FC1D733@Exchange.mips.com>
In-Reply-To: <20070418163806.GA27199@linux-mips.org>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH 3/16] Kconfig update for lemote fulong mini-PC
Thread-Index: AceB1/8Iw6c8qNA6T7u9BLfk1jzPVgAL//TQ
References: <11766507651736-git-send-email-tiansm@lemote.com> <11766507661317-git-send-email-tiansm@lemote.com> <11766507661726-git-send-email-tiansm@lemote.com> <11766507662638-git-send-email-tiansm@lemote.com> <20070418120620.GE3938@linux-mips.org> <46261DE2.5040908@ict.ac.cn> <692AB3595F5D76428B34B9BEFE20BC1FC1D723@Exchange.mips.com> <20070418163806.GA27199@linux-mips.org>
From:	"Uhler, Mike" <uhler@mips.com>
To:	"Ralf Baechle" <ralf@linux-mips.org>
Cc:	"Fuxin Zhang" <fxzhang@ict.ac.cn>, <tiansm@lemote.com>,
	<linux-mips@linux-mips.org>, "Fuxin Zhang" <zhangfx@lemote.com>
Return-Path: <uhler@mips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14891
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: uhler@mips.com
Precedence: bulk
X-list: linux-mips

Note that both of these apply to pre-MIPS64 processors.  In a MIPS64
implementation, The Status.PX bit should be used to enable 64-bit
operations without enabling 64-bit addressing.  The Status.XX bit is
gone and can't be set.  The addressing boundary condition that Bill
mentioned is explicitly address in the Architecture for Programmer's
manual, Volume III, section 4.10 as a requirement for hardware in
exactly this case.

I realize that Loongson is a MIPS III processor where Bill's suggestion
may apply, but it's not a general problem moving forward to MIPS64.

/gmu
---
Michael Uhler, Chief Technology Officer
MIPS Technologies, Inc.   Email: uhler AT mips.com
1225 Charleston Road      Voice:  (650)567-5025   FAX:   (650)567-5225
Mountain View, CA 94043
   

> -----Original Message-----
> From: Ralf Baechle [mailto:ralf@linux-mips.org] 
> Sent: Wednesday, April 18, 2007 9:38 AM
> To: Uhler, Mike
> Cc: Fuxin Zhang; tiansm@lemote.com; 
> linux-mips@linux-mips.org; Fuxin Zhang
> Subject: Re: [PATCH 3/16] Kconfig update for lemote fulong mini-PC
> 
> On Wed, Apr 18, 2007 at 08:28:16AM -0700, Uhler, Mike wrote:
> 
> > > Yes. Most 64bit MIPS processors cannot access 64bit content of 
> > > registers when it is in 32bit mode.
> > 
> > For clarity, there is no 32/64-bit mode in MIPS processors. 
>  There is 
> > a mode in which 64-bit OPERATIONS are enabled (that is, those 
> > instructions which operate on the full width of the 
> registers) - See 
> > the definition of 64-bit Operations Enable in the MIPS64 
> Architecture 
> > for Programmers, volume III.  Note that such operations are always 
> > enabled while the processor is running in Kernel Mode.
> > 
> > The patch is a little short on context, but if you've got a 64-bit 
> > kernel, I had always assumed that save/restore of context is always 
> > done with LD/SD, not by figuring out whether a process has 64-bit 
> > operations enabled, then doing a conditional LD/SD or LW/SW.
> 
> Here's a funny one where we have something like a mode.  This 
> is a reposting from Bill Earl:
> 
> [...]
>      One other issue is that UX should always be set, to allow use of
> MIPS3 instructions, and that XX (bit 31) should be set on 
> R5000 and R10000 processors, to enable MIPS4 instructions.  
> This in turn means that, to avoid various illegal address 
> exceptions, the VM system should not allow a 32-bit user 
> program to map anything into the top 32 KB of the user address space.
> 
>      The problem has to do with some compilers using integer 
> arithmetic to compute a base for some variables in the 
> current stack frame, and then using negative displacements to 
> address the variables, for cases where the stack frame 
> exceeds 32 KB, but is located near the top of memory.  The 
> 32-bit unsigned integer add to, say, 0x7fffff00 (64-bit 
> address 0x000000007fffff00) produces a signed 32-bit value 
> such as 0x80000f00, which is the 64-bit value 
> 0xffffffff80000f00, since all 32-bit values, signed or 
> unsigned, are stored as 32-bit signed values sign-extended to 
> 64 bits.  When you do a load with a negative offset of, say, 
> -0x1000, you get an address 0xffffffff7fffff00, not 
> 0x000000007fffff00.  With UX=0, this would be fine, but, with 
> UX=1 (to enable MIPS3 instructions), the above address is 
> illegal.  If the $sp is always at least 32 KB below the top 
> of the address space, this problem does not arise, since any 
> such intermediate pointer generated by the compiler will 
> always be below 0x80000000.
> [...]
> 
> The original posting is at 
> http://www.linux-mips.org/cgi-bin/mesg.cgi?a=linux-mips&i=1445
2.59571.970106.514001%40liveoak.engr.sgi.com
> 
>   Ralf
> 
