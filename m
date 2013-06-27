Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 28 Jun 2013 00:23:46 +0200 (CEST)
Received: from mail.linuxfoundation.org ([140.211.169.12]:40708 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6835045Ab3F0WXo0vhke (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 28 Jun 2013 00:23:44 +0200
Received: from akpm3.mtv.corp.google.com (unknown [216.239.45.95])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 61064990;
        Thu, 27 Jun 2013 22:23:36 +0000 (UTC)
Date:   Thu, 27 Jun 2013 15:23:35 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     Veli-Pekka Peltola <veli-pekka.peltola@bluegiga.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mips@linux-mips.org, Russell King <linux@arm.linux.org.uk>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH v2] mm: module_alloc: check if size is 0
Message-Id: <20130627152335.c3a4c9f4c647cf4a2b263479@linux-foundation.org>
In-Reply-To: <20130627093917.GQ7171@linux-mips.org>
References: <1330631119-10059-1-git-send-email-veli-pekka.peltola@bluegiga.com>
        <1331125768-25454-1-git-send-email-veli-pekka.peltola@bluegiga.com>
        <20130627093917.GQ7171@linux-mips.org>
X-Mailer: Sylpheed 3.2.0beta5 (GTK+ 2.24.10; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <akpm@linux-foundation.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37186
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: akpm@linux-foundation.org
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

On Thu, 27 Jun 2013 11:39:17 +0200 Ralf Baechle <ralf@linux-mips.org> wrote:

> Imho de7d2b567d040e3b67fe7121945982f14343213d [mm/vmalloc.c: report more
> vmalloc failures] is overly strict in that it also reports zero-sized
> allocations.  I consider such allocations stupid but legitimiate and often
> better preferrable over having to scatter checks for zero size all over
> place.  So maybe something like below patch?
> 
> ...
>
> --- a/mm/vmalloc.c
> +++ b/mm/vmalloc.c
> @@ -1679,7 +1679,10 @@ void *__vmalloc_node_range(unsigned long size, unsigned long align,
>  	unsigned long real_size = size;
>  
>  	size = PAGE_ALIGN(size);
> -	if (!size || (size >> PAGE_SHIFT) > totalram_pages)
> +	if (unlikely(!size))
> +		return NULL;
> +
> +	if ((size >> PAGE_SHIFT) > totalram_pages)
>  		goto fail;
>  
>  	area = __get_vm_area_node(size, align, VM_ALLOC | VM_UNLIST,
> @@ -1711,6 +1714,7 @@ fail:
>  	warn_alloc_failed(gfp_mask, 0,
>  			  "vmalloc: allocation failure: %lu bytes\n",
>  			  real_size);
> +
>  	return NULL;
>  }

If the caller actually dereferences the returned pointer the kernel
will go oops, which should provide adequate notification of a
programming error ;) But all callers should be checking the return
value.  So I worry about the by-far-most-common case where code does

	size = some_screwed_up_calculation();
	p = vmalloc(size);
	if (!p)
		return -ENOMEM;

So the mistake gets propagated back to who-knows-where as memory
exhaustion and thereby becomes a lot harder to diagnose.


How many callsites really truly need to be edited to avoid the warning?


Veli-Pekka's original patch would be neater if we were to add a new

void *__vmalloc_node_range_zero_size_ok(<args>)
{
	if (size == 0)
		return NULL;
	return __vmalloc_node_range(<args>);
}

(with a better name than __vmalloc_node_range_zero_size_ok!)
