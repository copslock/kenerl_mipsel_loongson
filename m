Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 19 Oct 2010 02:57:46 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:48936 "EHLO
        localhost.localdomain" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1490978Ab0JSA5n (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 19 Oct 2010 02:57:43 +0200
Date:   Tue, 19 Oct 2010 01:57:43 +0100 (BST)
From:   "Maciej W. Rozycki" <macro@linux-mips.org>
To:     Kevin Cernekee <cernekee@gmail.com>
cc:     Shinya Kuribayashi <skuribay@pobox.com>,
        Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH resend 5/9] MIPS: sync after cacheflush
In-Reply-To: <AANLkTinpry=XG-ZDgXJK-VB6QkBL2TO4-vrsV5Tc1eEs@mail.gmail.com>
Message-ID: <alpine.LFD.2.00.1010190146360.15889@eddie.linux-mips.org>
References: <17ebecce124618ddf83ec6fe8e526f93@localhost>        <17d8d27a2356640a4359f1a7dcbb3b42@localhost>        <4CBC4F4E.5010305@pobox.com> <AANLkTinpry=XG-ZDgXJK-VB6QkBL2TO4-vrsV5Tc1eEs@mail.gmail.com>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 28150
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, 18 Oct 2010, Kevin Cernekee wrote:

> Some systems do require additional steps along those lines, e.g.
> 
> # ifdef CONFIG_SGI_IP28
> #  define fast_iob()				\
> 	__asm__ __volatile__(			\
> 		".set	push\n\t"		\
> 		".set	noreorder\n\t"		\
> 		"lw	$0,%0\n\t"		\
> 		"sync\n\t"			\
> 		"lw	$0,%0\n\t"		\
> 		".set	pop"			\
> 		: /* no output */		\
> 		: "m" (*(int *)CKSEG1ADDR(0x1fa00004)) \
> 		: "memory")
> 
> Maybe it would be better to use iob() instead of __sync() directly, so
> that it is easy to add extra steps for the CPUs that need them.  DEC
> and Loongson have custom __wbflush() implementations, and something
> similar could be added for your processor to implement the uncached
> dummy load.

 Ah, the old issue of the write-back barrier.  I can't comment on 
Loongson, but for DEC IIRC the write-back buffer only needs to be taken 
care of for uncached writes and they take a path separate to cached 
writes.  I'd have to dig out the details to be sure.  IIRC the most 
pathological case was the R2020 WB chip, but that was only used on systems 
that didn't do DMA (namely DECstatation 3100 and 2100 boxes).

  Maciej
