Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 20 Apr 2003 05:20:04 +0100 (BST)
Received: from kauket.visi.com ([IPv6:::ffff:209.98.98.22]:18083 "HELO
	mail-out.visi.com") by linux-mips.org with SMTP id <S8225195AbTDTEUC>;
	Sun, 20 Apr 2003 05:20:02 +0100
Received: from mehen.visi.com (mehen.visi.com [209.98.98.97])
	by mail-out.visi.com (Postfix) with ESMTP id 114AB36CC
	for <linux-mips@linux-mips.org>; Sat, 19 Apr 2003 23:20:01 -0500 (CDT)
Received: from mehen.visi.com (localhost [127.0.0.1])
	by mehen.visi.com (8.12.9/8.12.5) with ESMTP id h3K4K06D080210
	for <linux-mips@linux-mips.org>; Sat, 19 Apr 2003 23:20:00 -0500 (CDT)
	(envelope-from erik@greendragon.org)
Received: (from www@localhost)
	by mehen.visi.com (8.12.9/8.12.5/Submit) id h3K4K0NV080209
	for linux-mips@linux-mips.org; Sun, 20 Apr 2003 04:20:00 GMT
X-Authentication-Warning: mehen.visi.com: www set sender to erik@greendragon.org using -f
Received: from 170-215-17-187.bras01.mnd.mn.frontiernet.net (170-215-17-187.bras01.mnd.mn.frontiernet.net [170.215.17.187]) 
	by my.visi.com (IMP) with HTTP 
	for <longshot@imap.visi.com>; Sun, 20 Apr 2003 04:20:00 +0000
Message-ID: <1050812400.3ea21ff0ca9f5@my.visi.com>
Date: Sun, 20 Apr 2003 04:20:00 +0000
From: "Erik J. Green" <erik@greendragon.org>
To: linux-mips@linux-mips.org
Subject: Re: TLB mapping questions (followup q)
References: <1050730370.3ea0df8263a21@my.visi.com> <20030419164854.A15699@linux-mips.org> <1050805826.3ea2064281289@my.visi.com> <1050809885.3ea2161d7bfc7@my.visi.com>
In-Reply-To: <1050809885.3ea2161d7bfc7@my.visi.com>
MIME-Version: 1.0
Content-Type: text/plain
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
User-Agent: Internet Messaging Program (IMP) 4.0-cvs
X-Originating-IP: 170.215.17.187
Return-Path: <erik@greendragon.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2113
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: erik@greendragon.org
Precedence: bulk
X-list: linux-mips

Quoting "Erik J. Green" <erik@greendragon.org>:

> How can this work in the existing head.S for a mapped kernel?  Wouldn't other
> machines have the same problem, where the location for kernelsp is within the
> non-writeable segment?
> 


And a followup to my followup: =)

Later in the boot, in tlb-andes.c, the andes_tlb_init function re-sets CP0_wired
to 0 (and pagemask to 4k), then the local_flush_tlb_all function overwrites the
TLB entry for the kernel, causing an immediate halt to things.

Am I correct in thinking the 16M page size initally set up in head.S (with
CONFIG_MAPPED_KERNEL=1) was so the mapped kernel could get to the point of
setting up the TLB "for real" later on?  If so, how is the switch to 4k pages
supposed to work?  I can see the existing code working if local_tlb_flush_all is
running out of unmapped memory, but in my case I would think the "starter" TLB
entry would need to be preserved until a replacement is created.

Thanks again,
Erik



-- 
Erik J. Green
erik@greendragon.org
