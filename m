Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 22 Dec 2004 01:27:52 +0000 (GMT)
Received: from rwcrmhc13.comcast.net ([IPv6:::ffff:204.127.198.39]:37320 "EHLO
	rwcrmhc13.comcast.net") by linux-mips.org with ESMTP
	id <S8224947AbULVB1q>; Wed, 22 Dec 2004 01:27:46 +0000
Received: from gw.junsun.net (c-24-6-106-170.client.comcast.net[24.6.106.170])
          by comcast.net (rwcrmhc13) with ESMTP
          id <2004122201272901500rf7jle>; Wed, 22 Dec 2004 01:27:29 +0000
Received: from gw.junsun.net (gw.junsun.net [127.0.0.1])
	by gw.junsun.net (8.13.1/8.13.1) with ESMTP id iBM1RF72013861;
	Tue, 21 Dec 2004 17:27:27 -0800
Received: (from jsun@localhost)
	by gw.junsun.net (8.13.1/8.13.1/Submit) id iBM1RFj2013860;
	Tue, 21 Dec 2004 17:27:15 -0800
Date: Tue, 21 Dec 2004 17:27:15 -0800
From: Jun Sun <jsun@junsun.net>
To: moreau francis <francis_moreau2000@yahoo.fr>
Cc: linux-mips@linux-mips.org
Subject: Re: port on exotic board.
Message-ID: <20041222012715.GA13782@gw.junsun.net>
References: <20041221085307.3009.qmail@web25107.mail.ukl.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041221085307.3009.qmail@web25107.mail.ukl.yahoo.com>
User-Agent: Mutt/1.4.1i
Return-Path: <jsun@junsun.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6733
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jsun@junsun.net
Precedence: bulk
X-list: linux-mips


Since nobody else is replying I am giving it a shot.  Hope it helps.

On Tue, Dec 21, 2004 at 09:53:07AM +0100, moreau francis wrote:
> Hi,
> 
> Well, I'm still trying to port Linux on my "exotic"
> board...
> I hope you don't mind if I ask a couple of questions,
> which may be stupid for you but usefull at my level. 
> If you think that linux-mips mailing list is not 
> intended for these kind of questions, tell me !
> 
> So here I am:
> 
> I've mapped kernel code and kernel data in different
> memories in order to save precious SDRAM memory.
> 
> Code    0xC0000000    0x30000000     16Mo    FLASH
> Data    0xC1000000    0x20000000      8Mo    SDRAM
> 
> When running the kernel at the very begining, I
> encounter different issues:
> 
> In "tlb_init" function, cp0 WIRED register is set to
> zero, therefore the call to "local_flush_tlb_all" 
> flush all TLB entries which were mapping my kernel
> in the 3 first entries. Why is this necessary ?  

Setting WIRED to zero is just part of kernel start-up initialization.

In 2.4 it is done before board setup routine, which allows board
to setup certain wired mapping.

In 2.6 it is done after board setup routine.  You are screwed. :) I think
this needs to be fixed.  A couple of boards should be broken because of this.

> In different part of the kernel it is assumed that the
> kernel start at physical addr 0. For instance in
> "init_bootmem" fonction, argument start is set to 0.
> Or the way to calculate a page frame index in mem_map
> array. Why this assumption ?
> 

Because all other boards have phys memory starting from 0?  It
simplies code for sure.

> Why does "mem_map" need to store page frames for
> kernel
> code ? 

mem_map holds kernel page table.  Kernel code is mapped there because
we start from 0 and we need to use the free memory _after_ kernel code
segment.  (I don't think it is very useful for MIPS though, since MIPS uses
a flat 512MB block mapping for kernel virtual address.)

> Are these pages going be used when the Linux is
> running ?

Not much in MIPS case I suppose.

> I noticed CPHYSADDR macro. This macro only works if
> PAGE_OFFSET is equal to 0x80000000. Why does this 
> macro exist ? Why not using __pa macro ?

Don't know much about this one.

BTW, once there was a board whose memory starts from 0x90000000.  It had
similar problems as yours, but I think it ran in the end.  Try to search
the mailing list.

Jun
