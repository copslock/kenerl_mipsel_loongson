Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 26 Dec 2008 15:07:18 +0000 (GMT)
Received: from mba.ocn.ne.jp ([122.1.235.107]:62697 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S24044647AbYLZPHQ (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 26 Dec 2008 15:07:16 +0000
Received: from localhost (p5246-ipad305funabasi.chiba.ocn.ne.jp [123.217.167.246])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id B0FB8A99A; Sat, 27 Dec 2008 00:07:11 +0900 (JST)
Date:	Sat, 27 Dec 2008 00:07:13 +0900 (JST)
Message-Id: <20081227.000713.72709048.anemo@mba.ocn.ne.jp>
To:	jan.nikitenko@gmail.com
Cc:	ralf@linux-mips.org, linux-mips@linux-mips.org
Subject: Re: fix oops in dma_unmap_page on not coherent mips platforms
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <20081128075258.GA10200@nikitenko.systek.local>
References: <20081128075258.GA10200@nikitenko.systek.local>
X-Fingerprint: 6ACA 1623 39BD 9A94 9B1A  B746 CA77 FE94 2874 D52F
X-Pgp-Public-Key: http://wwwkeys.pgp.net/pks/lookup?op=get&search=0x2874D52F
X-Mailer: Mew version 5.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <anemo@mba.ocn.ne.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21672
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

On Fri, 28 Nov 2008 08:52:58 +0100, Jan Nikitenko <jan.nikitenko@gmail.com> wrote:
> dma_cache_wback_inv() expects virtual address, but physical was provided
> due to translation via plat_dma_addr_to_phys().
> If replaced with dma_addr_to_virt(), page fault oops from dma_unmap_page()
> is gone on au1550 platform.
> 
> Signed-off-by: Jan Nikitenko <jan.nikitenko@gmail.com>
> ---
>  arch/mips/mm/dma-default.c |    2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/mips/mm/dma-default.c b/arch/mips/mm/dma-default.c
> index 5b98d0e..5f336c1 100644
> --- a/arch/mips/mm/dma-default.c
> +++ b/arch/mips/mm/dma-default.c
> @@ -222,7 +222,7 @@ void dma_unmap_page(struct device *dev, dma_addr_t dma_address, size_t size,
>  	if (!plat_device_is_coherent(dev) && direction != DMA_TO_DEVICE) {
>  		unsigned long addr;
>  
> -		addr = plat_dma_addr_to_phys(dma_address);
> +		addr = dma_addr_to_virt(dma_address);
>  		dma_cache_wback_inv(addr, size);
>  	}

Acked-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>

I'm also wondering why dma_map_page and dma_unmap_page are using
dma_cache_wback_inv instead of __dma_sync.  They also lack special
r10000 handling.  Hmm...

---
Atsushi Nemoto
