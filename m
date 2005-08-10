Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 10 Aug 2005 20:33:07 +0100 (BST)
Received: from static-151-204-232-50.bos.east.verizon.net ([IPv6:::ffff:151.204.232.50]:56279
	"EHLO mail2.sicortex.com") by linux-mips.org with ESMTP
	id <S8225252AbVHJTcu>; Wed, 10 Aug 2005 20:32:50 +0100
Received: from gs104.sicortex.com (gs104.sicortex.com [10.0.1.104])
	by mail2.sicortex.com (Postfix) with ESMTP id 601101BF211
	for <linux-mips@linux-mips.org>; Wed, 10 Aug 2005 15:36:44 -0400 (EDT)
From:	Joshua Wise <mips@joshuawise.com>
To:	linux-mips@linux-mips.org
Subject: SMP spinlocks forever while doing a put_user
Date:	Wed, 10 Aug 2005 15:36:43 -0400
User-Agent: KMail/1.8.1
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200508101536.43605.mips@joshuawise.com>
Return-Path: <mips@joshuawise.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8733
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mips@joshuawise.com
Precedence: bulk
X-list: linux-mips

So I've been doing some research into SMP on MIPS as I mentioned a while back, 
and as I think I mentioned, I've run into issues with put_user, well, not 
putting. In particular, I found that it was engaging in the classic SMP 
pastime of sitting in a spinlock forever, doing nothing.

My current configuration is one emulated 5kc with 64mb of emulated RAM. After 
adding some preliminary support to GXemul so that it can act as a GDB server, 
I managed to dig up the following backtrace before my crummy GDB server 
implementation blew up:

(gdb) bt
#0  0xffffffff8027f4b8 in _spin_lock (lock=0x3af0) at spinlock.h:60
#1  0xffffffff80194bac in handle_mm_fault (mm=0x3a80, vma=0x310948, 
address=64321698660352, write_access=0) at mm/memory.c:2029
Cannot access memory at address 0x81b758
(gdb)

In particular, line 2029 is the spinlock within the following snippet of code:
        /*
         * We need the page table lock to synchronize with kswapd
         * and the SMP-safe atomic PTE updates.
         */
        pgd = pgd_offset(mm, address);
        spin_lock(&mm->page_table_lock);

I'm not sure where this is being held that I'm not seeing it. I guess I should 
probably enable spinlock debugging, although I've tried that once in the past 
and gotten a total of zero spinlock-debug related messages. I'll give it 
another shot, in case I selected the wrong option or some such.

Does anyone have any insight as to what's going on here?

Thanks in advance,
joshua
