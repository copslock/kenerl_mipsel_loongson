Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 11 May 2007 12:36:20 +0100 (BST)
Received: from localhost.localdomain ([127.0.0.1]:9650 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20022558AbXEKLgS (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 11 May 2007 12:36:18 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.13.8/8.13.8) with ESMTP id l4BBaDhP004294;
	Fri, 11 May 2007 12:36:14 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.13.8/8.13.8/Submit) id l4BBaD91004293;
	Fri, 11 May 2007 12:36:13 +0100
Date:	Fri, 11 May 2007 12:36:13 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Franck Bui-Huu <vagabon.xyz@gmail.com>
Cc:	linux-mips <linux-mips@linux-mips.org>
Subject: Re: [PATCH] Simplify pte_offset_{map,map_nested}() on 32 bits [try #2]
Message-ID: <20070511113613.GG2732@linux-mips.org>
References: <463B117F.1070009@innova-card.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <463B117F.1070009@innova-card.com>
User-Agent: Mutt/1.4.2.2i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15032
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Fri, May 04, 2007 at 12:57:03PM +0200, Franck Bui-Huu wrote:

> From: Franck Bui-Huu <fbuihuu@gmail.com>
> 
> Since both kernel and process page tables are never allocated in
> highmem these 2 macros were doing unnecessary extra works for getting
> a pte from a pmd.
> 
> This patch also clean up pte allocation functions by passing
> __GFP_ZERO to alloc_pages() and by removing a useless local variable.
> 
> With this patch the size of the kernel is slighly reduced.

These hook allows general mapping of pagetables, not just highmem.  On MIPS
that's useful because fancy mapping stuff allows a faster implementation of
TLB exception handlers.  That was more or less the official strategy for
the R2000.  Then the R4000 came and broke this scheme with virtual aliases
which was hard to fix back then so I had to switch to the current
pagetable and TLB reload mechanism.  If you care about the details,
take a look at Linux/MIPS 2.1.1.

The fact that getting this to work again would also allow putting pagetables
into highmem at virtually no extra effort is a nice side effect, of course.

  Ralf
