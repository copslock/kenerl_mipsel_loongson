Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 28 Apr 2004 16:05:40 +0100 (BST)
Received: from web11305.mail.yahoo.com ([IPv6:::ffff:216.136.131.208]:23567
	"HELO web11305.mail.yahoo.com") by linux-mips.org with SMTP
	id <S8226121AbUD1PFi>; Wed, 28 Apr 2004 16:05:38 +0100
Message-ID: <20040428150520.17119.qmail@web11305.mail.yahoo.com>
Received: from [66.93.100.212] by web11305.mail.yahoo.com via HTTP; Wed, 28 Apr 2004 08:05:20 PDT
Date: Wed, 28 Apr 2004 08:05:20 -0700 (PDT)
From: Alex Deucher <agd5f@yahoo.com>
Subject: Re: TLB on R10k
To: sskowron@ET.PUT.Poznan.PL
Cc: linux-mips@linux-mips.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-Path: <agd5f@yahoo.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4919
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: agd5f@yahoo.com
Precedence: bulk
X-list: linux-mips

This thread may be ARM specific, but it sounds like a similar problem. 
if it's of no use, please ignore.

http://lists.arm.linux.org.uk/pipermail/linux-arm-kernel/2003-November/018303.html
http://lists.arm.linux.org.uk/pipermail/linux-arm-kernel/2003-November/018409.html

Alex

-----------------------------

> Have you verified that the UX bit is set correctly by your kernel? 
BEV
> also plays a role but since you survive BogoMIPS it should be right.

From what I remember, the UX bit is fixed set. I have made the machine
print a '*' (no, I didn't use printk, but since it's my own console
driver I'm pretty sure it can work in interrupts - all it does is
hardware writes) whenever it gets a TLB refill and flushed the TLB
before
entering usermode. Guess what, I didn't get a single '*' after ERET. To
verify my method, I've made a single read from the usermode PC from the
kernel, and the '*' appeared. I don't know what's up.

Stanislaw


	
		
__________________________________
Do you Yahoo!?
Win a $20,000 Career Makeover at Yahoo! HotJobs  
http://hotjobs.sweepstakes.yahoo.com/careermakeover 
