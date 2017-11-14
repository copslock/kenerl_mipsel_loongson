Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 14 Nov 2017 16:41:08 +0100 (CET)
Received: from localhost.localdomain ([127.0.0.1]:55792 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23992780AbdKNPlAzSgL0 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 14 Nov 2017 16:41:00 +0100
Received: from h7.dl5rb.org.uk (localhost [127.0.0.1])
        by h7.dl5rb.org.uk (8.15.2/8.14.8) with ESMTP id vAEFf0dR018096;
        Tue, 14 Nov 2017 16:41:00 +0100
Received: (from ralf@localhost)
        by h7.dl5rb.org.uk (8.15.2/8.15.2/Submit) id vAEFexhY018095;
        Tue, 14 Nov 2017 16:40:59 +0100
Date:   Tue, 14 Nov 2017 16:40:59 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     "Steven J. Hill" <steven.hill@cavium.com>
Cc:     linux-mips@linux-mips.org
Subject: Re: [PATCH v3 02/11] MIPS: Remove unused variable 'lastpfn'
Message-ID: <20171114154059.GB16044@linux-mips.org>
References: <1510633827-23548-1-git-send-email-steven.hill@cavium.com>
 <1510633827-23548-3-git-send-email-steven.hill@cavium.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1510633827-23548-3-git-send-email-steven.hill@cavium.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60923
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

On Mon, Nov 13, 2017 at 10:30:18PM -0600, Steven J. Hill wrote:
> Date:   Mon, 13 Nov 2017 22:30:18 -0600
> From: "Steven J. Hill" <steven.hill@cavium.com>
> To: linux-mips@linux-mips.org
> Cc: "Steven J. Hill" <Steven.Hill@cavium.com>, ralf@linux-mips.org
> Subject: [PATCH v3 02/11] MIPS: Remove unused variable 'lastpfn'
> Content-Type: text/plain
> 
> From: "Steven J. Hill" <Steven.Hill@cavium.com>
> 
> 'lastpfn' is never used for anything. Remove it.
> 
> Signed-off-by: Steven J. Hill <steven.hill@cavium.com>
> Acked-by: David Daney <david.daney@cavium.com
> ---
>  arch/mips/mm/init.c | 4 ----
>  1 file changed, 4 deletions(-)
> 
> diff --git a/arch/mips/mm/init.c b/arch/mips/mm/init.c
> index 5f6ea7d..84b7b59 100644
> --- a/arch/mips/mm/init.c
> +++ b/arch/mips/mm/init.c
> @@ -402,7 +402,6 @@ int page_is_ram(unsigned long pagenr)
>  void __init paging_init(void)
>  {
>  	unsigned long max_zone_pfns[MAX_NR_ZONES];
> -	unsigned long lastpfn __maybe_unused;
>  
>  	pagetable_init();
>  
> @@ -416,17 +415,14 @@ void __init paging_init(void)
>  	max_zone_pfns[ZONE_DMA32] = MAX_DMA32_PFN;
>  #endif
>  	max_zone_pfns[ZONE_NORMAL] = max_low_pfn;
> -	lastpfn = max_low_pfn;
>  #ifdef CONFIG_HIGHMEM
>  	max_zone_pfns[ZONE_HIGHMEM] = highend_pfn;
> -	lastpfn = highend_pfn;
>  
>  	if (cpu_has_dc_aliases && max_low_pfn != highend_pfn) {
>  		printk(KERN_WARNING "This processor doesn't support highmem."
>  		       " %ldk highmem ignored\n",
>  		       (highend_pfn - max_low_pfn) << (PAGE_SHIFT - 10));
>  		max_zone_pfns[ZONE_HIGHMEM] = max_low_pfn;
> -		lastpfn = max_low_pfn;
>  	}
>  #endif

This cleanup is an excellent demonstration for why __maybe_unused is a
less than great idea.

  Ralf
