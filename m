Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 24 Sep 2002 10:41:01 +0200 (CEST)
Received: from alg133.algor.co.uk ([62.254.210.133]:28413 "EHLO
	oval.algor.co.uk") by linux-mips.org with ESMTP id <S1123916AbSIXIlB>;
	Tue, 24 Sep 2002 10:41:01 +0200
Received: from gladsmuir.algor.co.uk (pubfw.algor.co.uk [62.254.210.129])
	by oval.algor.co.uk (8.11.6/8.10.1) with ESMTP id g8O8enr15158;
	Tue, 24 Sep 2002 09:40:54 +0100 (BST)
From: Dominic Sweetman <dom@algor.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15760.9489.29819.536681@gladsmuir.algor.co.uk>
Date: Tue, 24 Sep 2002 09:40:49 +0100
To: Dinesh Nagpure <dinesh_nagpure@ivivity.com>
Cc: linux-mips@linux-mips.org
Subject: Re: RM5231A: problems in timer using COUNT/COMPARE register.
In-Reply-To: <AEC4671C8179D61194DE0002B328BDD2070C3F@ATLOPS>
References: <AEC4671C8179D61194DE0002B328BDD2070C3F@ATLOPS>
X-Mailer: VM 6.92 under 21.1 (patch 14) "Cuyahoga Valley" XEmacs Lucid
Return-Path: <dom@algor.co.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 263
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dom@algor.co.uk
Precedence: bulk
X-list: linux-mips


Dinesh,

> I am in the process of porting Linux to our FPGA platform using RM5231A
> processor. The COUNT/COMPARE register timer is acting funny with me. When I
> set the compare register value to something like 0x0100_0000 or less I get
> timer interrupt as expected but if I set the COMPARE register to a greater
> value timer interrupt never happens. I have verified this using our boot
> loader also and the results are the same. I am waiting for a reply from PMC
> but would also like to know if there is anyone out there who faced similar
> problems with RM5231A. From data sheets and user manual I know the count
> register is 32 bit but apparently there is some hitch somewhere that I need
> to discover. 

I'd be really surprised if there's a hardware bug; the RM5231A is an
old core and it always seemed to work.  Standard practice is to leave
COUNT free-running, and to get timer interrupts by setting COMPARE
ahead of it; this relies totally on being able to use the whole range
of values, and running seamlessly while COUNT overflows back to zero...

Unless you've already done a really low-level, nothing-else-running
software sanity check on this, it seems more likely that some piece of
software is periodically resetting COUNT, or changing COMPARE, behind
your back.

Dominic Sweetman
MIPS Technologies
