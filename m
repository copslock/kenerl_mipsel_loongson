Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 14 Mar 2016 08:28:45 +0100 (CET)
Received: from localhost.localdomain ([127.0.0.1]:48616 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S27007763AbcCNH2lU1G3h (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 14 Mar 2016 08:28:41 +0100
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.15.2/8.14.8) with ESMTP id u2E7Se2r003831;
        Mon, 14 Mar 2016 08:28:40 +0100
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.15.2/8.15.2/Submit) id u2E7SavV003830;
        Mon, 14 Mar 2016 08:28:36 +0100
Date:   Mon, 14 Mar 2016 08:28:36 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     miles.chen@mediatek.com
Cc:     James Hogan <james.hogan@imgtec.com>,
        Paul Burton <paul.burton@imgtec.com>, linux-mips@linux-mips.org
Subject: Re: [PATCH] MIPS: smp.c: Fix uninitialised temp_foreign_map
Message-ID: <20160314072836.GC29020@linux-mips.org>
References: <1457935978-16062-1-git-send-email-miles.chen@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1457935978-16062-1-git-send-email-miles.chen@mediatek.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 52579
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

Please fix your scripts to not repost patches.

  Ralf

On Mon, Mar 14, 2016 at 02:12:58PM +0800, miles.chen@mediatek.com wrote:

> From: miles.chen@mediatek.com
> To: Miles <miles.chen@mediatek.com>
> CC: James Hogan <james.hogan@imgtec.com>, Paul Burton
>  <paul.burton@imgtec.com>, linux-mips@linux-mips.org, Ralf Baechle
>  <ralf@linux-mips.org>
> Subject: [PATCH] MIPS: smp.c: Fix uninitialised temp_foreign_map
> Content-Type: text/plain
> 
> From: James Hogan <james.hogan@imgtec.com>
> 
> When calculate_cpu_foreign_map() recalculates the cpu_foreign_map
> cpumask it uses the local variable temp_foreign_map without initialising
> it to zero. Since the calculation only ever sets bits in this cpumask
> any existing bits at that memory location will remain set and find their
> way into cpu_foreign_map too. This could potentially lead to cache
> operations suboptimally doing smp calls to multiple VPEs in the same
> core, even though the VPEs share primary caches.
> 
> Therefore initialise temp_foreign_map using cpumask_clear() before use.
> 
> Fixes: cccf34e9411c ("MIPS: c-r4k: Fix cache flushing for MT cores")
> Signed-off-by: James Hogan <james.hogan@imgtec.com>
> Cc: Paul Burton <paul.burton@imgtec.com>
> Cc: linux-mips@linux-mips.org
> Patchwork: https://patchwork.linux-mips.org/patch/12759/
> Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
> ---
>  arch/mips/kernel/smp.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/mips/kernel/smp.c b/arch/mips/kernel/smp.c
> index bd4385a..2b521e0 100644
> --- a/arch/mips/kernel/smp.c
> +++ b/arch/mips/kernel/smp.c
> @@ -121,6 +121,7 @@ static inline void calculate_cpu_foreign_map(void)
>  	cpumask_t temp_foreign_map;
>  
>  	/* Re-calculate the mask */
> +	cpumask_clear(&temp_foreign_map);
>  	for_each_online_cpu(i) {
>  		core_present = 0;
>  		for_each_cpu(k, &temp_foreign_map)
> -- 
> 1.9.1

  Ralf
