Received:  by oss.sgi.com id <S42203AbQHJRkJ>;
	Thu, 10 Aug 2000 10:40:09 -0700
Received: from u-173.karlsruhe.ipdial.viaginterkom.de ([62.180.19.173]:6404
        "EHLO u-173.karlsruhe.ipdial.viaginterkom.de") by oss.sgi.com
	with ESMTP id <S42202AbQHJRji>; Thu, 10 Aug 2000 10:39:38 -0700
Received: (ralf@lappi) by lappi.waldorf-gmbh.de id <S868787AbQHJRi6>;
        Thu, 10 Aug 2000 19:38:58 +0200
Date:   Thu, 10 Aug 2000 19:38:58 +0200
From:   Ralf Baechle <ralf@uni-koblenz.de>
To:     Jun Sun <jsun@mvista.com>
Cc:     linux-mips@oss.sgi.com, linux-mips@fnet.fr,
        linux-mips@vger.rutgers.edu
Subject: Re: bug in the latest cache code?
Message-ID: <20000810193858.A1478@bacchus.dhis.org>
References: <3992007C.49050FC@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <3992007C.49050FC@mvista.com>; from jsun@mvista.com on Wed, Aug 09, 2000 at 06:08:12PM -0700
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Wed, Aug 09, 2000 at 06:08:12PM -0700, Jun Sun wrote:

> I spent the last a few days to track down a problem where /sbin/init
> hangs forever.  It turns out, I believe, to be a bug introduced in the
> recent cache code change.
> 
> A new function, r4k_flush_icache_page_i32(), was added recently.  It
> calls blast_icache32_page(), which uses Hit cache operations to flush
> cache.  Unfortunately, that will generate TLB fault if virtual address
> is not present in TLB.  Under certain conditions,
> r4k_flush_icache_page_i32() will be called in the middle of handling a
> page fault, and it will then generate the same page fault again with
> cache hit operation.  This causes a deadlock (on current->mm->mmap_sem).
> 
> I read the previous version of code.  The fix seems to be using the
> indexed cache operation.  Here is the fix, and apparently it fixes the
> problem on my board.

I can see how this may happen and will take care of fixing this one.

We really want to avoid using index operations.  Unlike what the comment
in the kernel code suggest they do overly flush caches which is pretty
expensive.

  Ralf
