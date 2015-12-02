Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 02 Dec 2015 14:23:29 +0100 (CET)
Received: from localhost.localdomain ([127.0.0.1]:57574 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S27011789AbbLBNX1IoguQ (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 2 Dec 2015 14:23:27 +0100
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.15.2/8.14.8) with ESMTP id tB2DNOUF025032;
        Wed, 2 Dec 2015 14:23:24 +0100
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.15.2/8.15.2/Submit) id tB2DNKWM025031;
        Wed, 2 Dec 2015 14:23:20 +0100
Date:   Wed, 2 Dec 2015 14:23:20 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Yang Shi <yang.shi@linaro.org>
Cc:     akpm@linux-foundation.org, rostedt@goodmis.org, mingo@redhat.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linaro-kernel@lists.linaro.org, linux-mips@linux-mips.org
Subject: Re: [PATCH 4/7] mips: mm/gup: add gup trace points
Message-ID: <20151202132320.GA24730@linux-mips.org>
References: <1449011177-30686-1-git-send-email-yang.shi@linaro.org>
 <1449011177-30686-5-git-send-email-yang.shi@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1449011177-30686-5-git-send-email-yang.shi@linaro.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 50290
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

On Tue, Dec 01, 2015 at 03:06:14PM -0800, Yang Shi wrote:

>  arch/mips/mm/gup.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/arch/mips/mm/gup.c b/arch/mips/mm/gup.c
> index 349995d..3c5b8c8 100644
> --- a/arch/mips/mm/gup.c
> +++ b/arch/mips/mm/gup.c
> @@ -12,6 +12,9 @@
>  #include <linux/swap.h>
>  #include <linux/hugetlb.h>
>  
> +#define CREATE_TRACE_POINTS
> +#include <trace/events/gup.h>
> +
>  #include <asm/cpu-features.h>
>  #include <asm/pgtable.h>
>  
> @@ -211,6 +214,8 @@ int __get_user_pages_fast(unsigned long start, int nr_pages, int write,
>  					(void __user *)start, len)))
>  		return 0;
>  
> +	trace_gup_get_user_pages_fast(start, nr_pages, write, pages);
> +
>  	/*
>  	 * XXX: batch / limit 'nr', to avoid large irq off latency
>  	 * needs some instrumenting to determine the common sizes used by
> @@ -277,6 +282,8 @@ int get_user_pages_fast(unsigned long start, int nr_pages, int write,
>  	if (end < start || cpu_has_dc_aliases)
>  		goto slow_irqon;
>  
> +	trace_gup_get_user_pages_fast(start, nr_pages, write, pages);
> +
>  	/* XXX: batch / limit 'nr' */
>  	local_irq_disable();
>  	pgdp = pgd_offset(mm, addr);

Acked-by: Ralf Baechle <ralf@linux-mips.org>

Please feel free to merge this upstream with the remainder of the
series once it's been acked.

  Ralf
