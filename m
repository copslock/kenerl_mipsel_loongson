Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 20 Apr 2003 04:38:11 +0100 (BST)
Received: from kauket.visi.com ([IPv6:::ffff:209.98.98.22]:60834 "HELO
	mail-out.visi.com") by linux-mips.org with SMTP id <S8225195AbTDTDiI>;
	Sun, 20 Apr 2003 04:38:08 +0100
Received: from mehen.visi.com (mehen.visi.com [209.98.98.97])
	by mail-out.visi.com (Postfix) with ESMTP id 93C8436CC
	for <linux-mips@linux-mips.org>; Sat, 19 Apr 2003 22:38:06 -0500 (CDT)
Received: from mehen.visi.com (localhost [127.0.0.1])
	by mehen.visi.com (8.12.9/8.12.5) with ESMTP id h3K3c66D080069
	for <linux-mips@linux-mips.org>; Sat, 19 Apr 2003 22:38:06 -0500 (CDT)
	(envelope-from erik@greendragon.org)
Received: (from www@localhost)
	by mehen.visi.com (8.12.9/8.12.5/Submit) id h3K3c5gt080068
	for linux-mips@linux-mips.org; Sun, 20 Apr 2003 03:38:05 GMT
X-Authentication-Warning: mehen.visi.com: www set sender to erik@greendragon.org using -f
Received: from 64-212-122-73.bras01.mnd.mn.frontiernet.net (64-212-122-73.bras01.mnd.mn.frontiernet.net [64.212.122.73]) 
	by my.visi.com (IMP) with HTTP 
	for <longshot@imap.visi.com>; Sun, 20 Apr 2003 03:38:05 +0000
Message-ID: <1050809885.3ea2161d7bfc7@my.visi.com>
Date: Sun, 20 Apr 2003 03:38:05 +0000
From: "Erik J. Green" <erik@greendragon.org>
To: "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>
Subject: Re: TLB mapping questions (followup q)
References: <1050730370.3ea0df8263a21@my.visi.com> <20030419164854.A15699@linux-mips.org> <1050805826.3ea2064281289@my.visi.com>
In-Reply-To: <1050805826.3ea2064281289@my.visi.com>
MIME-Version: 1.0
Content-Type: text/plain
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
User-Agent: Internet Messaging Program (IMP) 4.0-cvs
X-Originating-IP: 64.212.122.73
Return-Path: <erik@greendragon.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2112
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: erik@greendragon.org
Precedence: bulk
X-list: linux-mips

Quoting "Erik J. Green" <erik@greendragon.org>:
> 
> That's ok for the first page, it's code only.  The second page mapped by the
> entry is data, so I'll set the D bit on that.

A followup question:  my stack is working now that I've set the D flag in the
TLB entry, allowing writes to that page.  From what I can tell, the
MAPPED_KERNEL_SETUP_TLB macro in head.S actually creates two nearly identical
halves for the new TLB entry it creates, except the half in ENTRYLO1 has the D
bit set.  My problem with the stack code was that the address the stack pointer
was being saved to (ok, really more of an addressing problem than a stack
problem) was within that first (16MB) page of memory, which couldn't be written
until I set the D bit.  

How can this work in the existing head.S for a mapped kernel?  Wouldn't other
machines have the same problem, where the location for kernelsp is within the
non-writeable segment? 

Erik



PS: Code from the current (few days old CVS) head.S:

       .macro MAPPED_KERNEL_SETUP_TLB
#ifdef CONFIG_MAPPED_KERNEL
        /*
         * This needs to read the nasid - assume 0 for now.
         * Drop in 0xffffffffc0000000 in tlbhi, 0+VG in tlblo_0,
         * 0+DVG in tlblo_1.
         */
        dli     t0, 0xffffffffc0000000
        dmtc0   t0, CP0_ENTRYHI
        li      t0, 0x1c000             # Offset of text into node memory
        dsll    t1, NASID_SHFT          # Shift text nasid into place
        dsll    t2, NASID_SHFT          # Same for data nasid
        or      t1, t1, t0              # Physical load address of kernel text
        or      t2, t2, t0              # Physical load address of kernel data
        dsrl    t1, 12                  # 4K pfn
        dsrl    t2, 12                  # 4K pfn
        dsll    t1, 6                   # Get pfn into place
        dsll    t2, 6                   # Get pfn into place
        li      t0, ((_PAGE_GLOBAL|_PAGE_VALID| _CACHE_CACHABLE_COW) >> 6)
        or      t0, t0, t1
        mtc0    t0, CP0_ENTRYLO0        # physaddr, VG, cach exlwr
        li      t0, ((_PAGE_GLOBAL|_PAGE_VALID| _PAGE_DIRTY|_CACHE_CACHABLE_COW)
>> 6)
        or      t0, t0, t2
        mtc0    t0, CP0_ENTRYLO1        # physaddr, DVG, cach exlwr
        li      t0, 0x1ffe000           # MAPPED_KERN_TLBMASK, TLBPGMASK_16M
        mtc0    t0, CP0_PAGEMASK
        li      t0, 0                   # KMAP_INX
        mtc0    t0, CP0_INDEX
        li      t0, 1
        mtc0    t0, CP0_WIRED
        tlbwi
#else
        mtc0    zero, CP0_WIRED
#endif
        .endm



-- 
Erik J. Green
erik@greendragon.org
