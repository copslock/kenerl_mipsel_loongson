Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 24 Jan 2011 14:16:11 +0100 (CET)
Received: from localhost.localdomain ([127.0.0.1]:49676 "EHLO
        duck.linux-mips.net" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S1491059Ab1AXNQI (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 24 Jan 2011 14:16:08 +0100
Received: from duck.linux-mips.net (duck [127.0.0.1])
        by duck.linux-mips.net (8.14.4/8.14.4) with ESMTP id p0ODFcCe028890;
        Mon, 24 Jan 2011 14:15:38 +0100
Received: (from ralf@localhost)
        by duck.linux-mips.net (8.14.4/8.14.4/Submit) id p0ODFaTx028888;
        Mon, 24 Jan 2011 14:15:36 +0100
Date:   Mon, 24 Jan 2011 14:15:36 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Yoichi Yuasa <yuasa@linux-mips.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-mips <linux-mips@linux-mips.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fix build error when CONFIG_SWAP is not set
Message-ID: <20110124131536.GA6246@linux-mips.org>
References: <20110124210813.ba743fc5.yuasa@linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20110124210813.ba743fc5.yuasa@linux-mips.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <ralf@localhost.localdomain>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 29036
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, Jan 24, 2011 at 09:08:13PM +0900, Yoichi Yuasa wrote:

> In file included from
> linux-2.6/arch/mips/include/asm/tlb.h:21,
>                  from mm/pgtable-generic.c:9:
> include/asm-generic/tlb.h: In function 'tlb_flush_mmu':
> include/asm-generic/tlb.h:76: error: implicit declaration of function
> 'release_pages'
> include/asm-generic/tlb.h: In function 'tlb_remove_page':
> include/asm-generic/tlb.h:105: error: implicit declaration of function
> 'page_cache_release'
> make[1]: *** [mm/pgtable-generic.o] Error 1
> 
> Signed-off-by: Yoichi Yuasa <yuasa@linux-mips.org>

Works as advertised for me.

Tested-by: Ralf Baechle <ralf@linux-mips.org>

  Ralf
