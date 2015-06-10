Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 10 Jun 2015 12:28:20 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:42536 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S27006853AbbFJK2RyapkN (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 10 Jun 2015 12:28:17 +0200
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.15.1/8.14.8) with ESMTP id t5AASCOP000580;
        Wed, 10 Jun 2015 12:28:13 +0200
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.15.1/8.15.1/Submit) id t5AAS5lb000579;
        Wed, 10 Jun 2015 12:28:05 +0200
Date:   Wed, 10 Jun 2015 12:28:05 +0200
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>
Cc:     linux-mips@linux-mips.org, david.daney@cavium.com,
        cernekee@gmail.com, linux-kernel@vger.kernel.org,
        macro@codesourcery.com, markos.chandras@imgtec.com,
        kumba@gentoo.org
Subject: Re: [PATCH] MIPS: bugfix of local_r4k_flush_icache_range - added L2
 flush
Message-ID: <20150610102805.GF2753@linux-mips.org>
References: <20150528203724.28800.63700.stgit@ubuntu-yegoshin>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20150528203724.28800.63700.stgit@ubuntu-yegoshin>
User-Agent: Mutt/1.5.23 (2014-03-12)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 47911
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-Id: linux-mips <linux-mips.eddie.linux-mips.org>
X-List-ID: linux-mips <linux-mips.eddie.linux-mips.org>
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
X-list: linux-mips

On Thu, May 28, 2015 at 01:37:24PM -0700, Leonid Yegoshin wrote:

> This function is used to flush code used in NMI and EJTAG debug exceptions.
> However, during that exceptions the Status.ERL bit is set, which means
> that code runs as UNCACHABLE. So, flush code down to memory is needed.
> 
> Signed-off-by: Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>
> ---
>  arch/mips/mm/c-r4k.c |   10 +---------
>  1 file changed, 1 insertion(+), 9 deletions(-)
> 
> diff --git a/arch/mips/mm/c-r4k.c b/arch/mips/mm/c-r4k.c
> index 0dbb65a51ce5..9f0299bb9a2a 100644
> --- a/arch/mips/mm/c-r4k.c
> +++ b/arch/mips/mm/c-r4k.c
> @@ -666,17 +666,9 @@ static inline void local_r4k_flush_icache_range(unsigned long start, unsigned lo
>  			break;
>  		}
>  	}
> -#ifdef CONFIG_EVA
> -	/*
> -	 * Due to all possible segment mappings, there might cache aliases
> -	 * caused by the bootloader being in non-EVA mode, and the CPU switching
> -	 * to EVA during early kernel init. It's best to flush the scache
> -	 * to avoid having secondary cores fetching stale data and lead to
> -	 * kernel crashes.
> -	 */
> +
>  	bc_wback_inv(start, (end - start));
>  	__sync();
> -#endif
>  }

I was wondering why there was a cache flush at all so I dove into git
history and found:

commit 4676f9359fa5190ee6f42bbf2c27d28beb14d26a
Author: Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>
Date:   Tue Jan 21 09:48:48 2014 +0000

    MIPS: mm: c-r4k: Flush scache to avoid cache aliases
    
    There is a chance for the secondary cache to have memory
    aliases. This can happen if the bootloader is in a non-EVA mode
    (or even in EVA mode but with different mapping from the kernel)
    and the kernel switching to EVA afterwards. It's best to flush
    the icache to avoid having the secondary CPUs fetching stale
    data from it.
    
    Signed-off-by: Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>
    Signed-off-by: Markos Chandras <markos.chandras@imgtec.com>

flush_icache_range() really only is meant to deal with I-cache coherency
issues as they appear during normal kernel operation, that is code is
modified and will be executed from RAM.  I doesn't know about aliases
and it's not meant to know.

As I understand you only need this on startup.  Making this function work
for your special use results in a performance penalty for every other user
of this function.

How about reverting this commit and calling __flush_cache_all() to
make sure your kernel code gets flushed out to the other end of the
universe - or memory, what ever comes first?

  Ralf
