Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 10 Dec 2004 14:47:18 +0000 (GMT)
Received: from xes-inc.com ([IPv6:::ffff:24.196.136.110]:3985 "EHLO
	xes-inc.com") by linux-mips.org with ESMTP id <S8225355AbULJOrN>;
	Fri, 10 Dec 2004 14:47:13 +0000
Received: from matts ([10.52.0.13])
	by xes-inc.com (8.11.6/8.11.6) with SMTP id iBAEktN20541;
	Fri, 10 Dec 2004 08:46:59 -0600
Message-ID: <073a01c4dec7$184527a0$0d00340a@matts>
From: "Matthew Starzewski" <mstarzewski@xes-inc.com>
To: "Thomas Petazzoni" <thomas.petazzoni@enix.org>
Cc: <linux-mips@linux-mips.org>
References: <062301c4de41$5bf43cb0$0d00340a@matts> <41B96281.2050806@enix.org>
Subject: Re: Using more than 256 MB of memory on SB1250 in 32-bit mode, revisited
Date: Fri, 10 Dec 2004 08:46:52 -0600
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2720.3000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Return-Path: <mstarzewski@xes-inc.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6634
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mstarzewski@xes-inc.com
Precedence: bulk
X-list: linux-mips


> I'm really unsure of what I'll say, but I've seen people on this list
> talking about CONFIG_DISCONTIGMEM, an option for the kernel, which is :
>
> "Say Y to upport efficient handling of discontiguous physical memory,
>  for architectures which are either NUMA (Non-Uniform Memory Access)
>   or have huge holes in the physical address space for other reasons.
>  See <file:Documentation/vm/numa> for more."

I've tried using DISCONTIGMEM on the MIPS32 build, but it yields the
following build error.  Maybe someone familiar w/ the SGI IP27 (Origin 200
and
2000) code could tell us whether simply turning on DISCONTIGMEM is
a good idea.

include/linux/mmzone.h:364:2: #error NODES_SHIFT > MAX_NODES_SHIFT

Also, even if it compiled with DISCONTIGMEM, a look at
sgi-ip27/ip27-memory.c
shows no sign of HIGHMEM support, what I was depending on to use the upper
256MB of memory as per my original email.  Now this may be OK; depending on
how
flexible the DISCONTIGMEM option is, perhaps I could map a wired TLB or
KSEG3
to the 2nd 256MB.

Thoughts?

Matt


----- Original Message -----
From: "Thomas Petazzoni" <thomas.petazzoni@enix.org>
To: "Matthew Starzewski" <mstarzewski@xes-inc.com>
Cc: <linux-mips@linux-mips.org>; <Steve.Finney@SpirentCom.COM>
Sent: Friday, December 10, 2004 2:46 AM
Subject: Re: Using more than 256 MB of memory on SB1250 in 32-bit mode,
revisited
