Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 13 Dec 2004 19:05:12 +0000 (GMT)
Received: from eth13.com-link.com ([IPv6:::ffff:208.242.241.164]:62351 "EHLO
	real.realitydiluted.com") by linux-mips.org with ESMTP
	id <S8225397AbULMTE7>; Mon, 13 Dec 2004 19:04:59 +0000
Received: from sjhill by real.realitydiluted.com with local (Exim 4.34 #1 (Debian))
	id 1CdvUh-0002B1-MR; Mon, 13 Dec 2004 13:04:27 -0600
Subject: Re: Kernel located in KSEG2 or KSEG3.
In-Reply-To: <20041213181252.23074.qmail@web25104.mail.ukl.yahoo.com>
To: moreau francis <francis_moreau2000@yahoo.fr>
Date: Mon, 13 Dec 2004 13:04:27 -0600 (CST)
CC: linux-mips@linux-mips.org
X-Mailer: ELM [version 2.4ME+ PL100 (25)]
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=US-ASCII
Message-Id: <E1CdvUh-0002B1-MR@real.realitydiluted.com>
From: sjhill@realitydiluted.com
Return-Path: <sjhill@realitydiluted.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6658
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sjhill@realitydiluted.com
Precedence: bulk
X-list: linux-mips

> Here is my board's mapping:
> 
> Physical Memory Map:
> 
> start        size       type
> -----------------------------
> 0x20000000 - 8MB    - SDRAM
> 0x30000000 - 16MB   - FLASH
> 0x40000000 - 16MB   - FLASH
> 0x50000000 - 2MB    - SRAM
> 
Your board manufacturer should be shot and then have
their hands and tongue cut off. All kidding aside,
are you sure there is no device mapped in the physical
address range of 0x1fc00000-0x1fffffff? I highly doubt
your board would boot otherwise, since a MIPS processor
coming out of reset jumps to physical address 0x1fc00000.
Can you check the board's manual? Thanks.

-Steve
