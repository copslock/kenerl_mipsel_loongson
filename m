Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 28 May 2015 18:40:37 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:59794 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S27013045AbbE1QkgHVkRu (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 28 May 2015 18:40:36 +0200
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.14.9/8.14.8) with ESMTP id t4SGebTT009933;
        Thu, 28 May 2015 18:40:37 +0200
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.14.9/8.14.9/Submit) id t4SGebG2009932;
        Thu, 28 May 2015 18:40:37 +0200
Date:   Thu, 28 May 2015 18:40:37 +0200
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Petri Gynther <pgynther@google.com>
Cc:     linux-mips@linux-mips.org, cernekee@gmail.com, f.fainelli@gmail.com
Subject: Re: [PATCH] MIPS: BMIPS: fix bmips_wr_vec()
Message-ID: <20150528164037.GB7012@linux-mips.org>
References: <20150527062508.CD24722020B@puck.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20150527062508.CD24722020B@puck.mtv.corp.google.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 47708
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

On Tue, May 26, 2015 at 11:25:08PM -0700, Petri Gynther wrote:

> bmips_wr_vec() copies exception vector code from start to dst.
> 
> The call to dma_cache_wback() needs to flush (end-start) bytes,
> starting at dst, from write-back cache to memory.
> 
> Signed-off-by: Petri Gynther <pgynther@google.com>
> ---
>  arch/mips/kernel/smp-bmips.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/mips/kernel/smp-bmips.c b/arch/mips/kernel/smp-bmips.c
> index fd528d7..336708a 100644
> --- a/arch/mips/kernel/smp-bmips.c
> +++ b/arch/mips/kernel/smp-bmips.c
> @@ -444,7 +444,7 @@ struct plat_smp_ops bmips5000_smp_ops = {
>  static void bmips_wr_vec(unsigned long dst, char *start, char *end)
>  {
>  	memcpy((void *)dst, start, end - start);
> -	dma_cache_wback((unsigned long)start, end - start);
> +	dma_cache_wback(dst, end - start);

dma_cache_wback is a guess what - DMA function.  It doesn't handle
I-caches at all and on some platforms might actually do nothing at all.
or use other optimizations that only work for DMA buffers and it's not
SMP aware - nor will it.  So if it ever worked for your case then just
because you're lucky.  This really should use flush_icache_range which
also conveniently for your code takes an end pointer as argument.

  Ralf
