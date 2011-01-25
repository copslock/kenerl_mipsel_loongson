Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 25 Jan 2011 08:42:03 +0100 (CET)
Received: from pfepb.post.tele.dk ([195.41.46.236]:50382 "EHLO
        pfepb.post.tele.dk" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S1491149Ab1AYHmA (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 25 Jan 2011 08:42:00 +0100
Received: from merkur.ravnborg.org (x1-6-00-1e-2a-84-ae-3e.k225.webspeed.dk [80.163.61.94])
        by pfepb.post.tele.dk (Postfix) with ESMTP id EE671F84027;
        Tue, 25 Jan 2011 08:41:56 +0100 (CET)
Date:   Tue, 25 Jan 2011 08:41:56 +0100
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Sergei Shtylyov <sshtylyov@mvista.com>,
        Yoichi Yuasa <yuasa@linux-mips.org>,
        linux-mips <linux-mips@linux-mips.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fix build error when CONFIG_SWAP is not set
Message-ID: <20110125074156.GA29709@merkur.ravnborg.org>
References: <20110124210813.ba743fc5.yuasa@linux-mips.org> <4D3DD366.8000704@mvista.com> <20110124124412.69a7c814.akpm@linux-foundation.org> <20110124210752.GA10819@merkur.ravnborg.org> <AANLkTimdgYVpwbCAL96=1F+EtXyNxz5Swv32GN616mqP@mail.gmail.com> <20110124223347.ad6072f1.akpm@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20110124223347.ad6072f1.akpm@linux-foundation.org>
User-Agent: Mutt/1.5.18 (2008-05-17)
Return-Path: <sam@ravnborg.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 29068
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sam@ravnborg.org
Precedence: bulk
X-list: linux-mips

> From: Andrew Morton <akpm@linux-foundation.org>
> 
> mips:
> 
> In file included from arch/mips/include/asm/tlb.h:21,
>                  from mm/pgtable-generic.c:9:
> include/asm-generic/tlb.h: In function `tlb_flush_mmu':
> include/asm-generic/tlb.h:76: error: implicit declaration of function `release_pages'
> include/asm-generic/tlb.h: In function `tlb_remove_page':
> include/asm-generic/tlb.h:105: error: implicit declaration of function `page_cache_release'
> 
> free_pages_and_swap_cache() and free_page_and_swap_cache() are macros
> which call release_pages() and page_cache_release().  The obvious fix is
> to include pagemap.h in swap.h, where those macros are defined.  But that
> breaks sparc for weird reasons.
> 
> So fix it within mm/pgtable-generic.c instead.
> 
> Reported-by: Yoichi Yuasa <yuasa@linux-mips.org>
> Cc: Geert Uytterhoeven <geert@linux-m68k.org>
> Cc: Sam Ravnborg <sam@ravnborg.org>
> Cc: Sergei Shtylyov <sshtylyov@mvista.com>
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>

I have succesfully build sparc32 allnoconfig + defconfig with this patch.
Can you expand the changelog to specify that this fixes sparc32 allnoconfig
as well?

Consider it:
Acked-by: Sam Ravnborg <sam@ravnborg.org>

	Sam
