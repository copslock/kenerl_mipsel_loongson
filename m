Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 14 Feb 2003 19:23:15 +0000 (GMT)
Received: from f103.law10.hotmail.com ([IPv6:::ffff:64.4.15.103]:30726 "EHLO
	hotmail.com") by linux-mips.org with ESMTP id <S8225205AbTBNTXO>;
	Fri, 14 Feb 2003 19:23:14 +0000
Received: from mail pickup service by hotmail.com with Microsoft SMTPSVC;
	 Fri, 14 Feb 2003 11:23:02 -0800
Received: from 63.121.54.5 by lw10fd.law10.hotmail.msn.com with HTTP;
	Fri, 14 Feb 2003 19:23:02 GMT
X-Originating-IP: [63.121.54.5]
From: "Mark and Janice Juszczec" <juszczec@hotmail.com>
To: linux-mips@linux-mips.org
Subject: R3000 stack docs
Date: Fri, 14 Feb 2003 19:23:02 +0000
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
Message-ID: <F103oqFXfyY0QUUBPcZ00009516@hotmail.com>
X-OriginalArrivalTime: 14 Feb 2003 19:23:02.0827 (UTC) FILETIME=[7E269FB0:01C2D45E]
Return-Path: <juszczec@hotmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1429
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: juszczec@hotmail.com
Precedence: bulk
X-list: linux-mips


Hi folks

I'm trying to compile uClibc fur use on my Helio pda.  There is some kind of 
problem with the stack layout.  The one uClibc expects isn't what my kernel 
is putting together.

I'm trying to find out the stack layout for the
Toshiba TMPR3912AU, 75 MHz., 32-bit RISC processor so I can figure out what 
I'm getting out of the kernel.

There is one in ftp://www.linux-mips.org/pub/linux/mips/doc/ABI/mipsabi.pdf

Does this refer to the stack the kernel loads in binfmt_elf.c and is it the 
correct place to start?

Thanks

Mark

Thanks

Mark



_________________________________________________________________
MSN 8 with e-mail virus protection service: 2 months FREE*  
http://join.msn.com/?page=features/virus
