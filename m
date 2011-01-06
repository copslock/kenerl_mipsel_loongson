Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 06 Jan 2011 17:18:21 +0100 (CET)
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:58278 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S1490989Ab1AFQSR (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 6 Jan 2011 17:18:17 +0100
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0D6EE8F94;
        Thu,  6 Jan 2011 11:18:13 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=message-id
        :date:from:mime-version:to:cc:subject:references:in-reply-to
        :content-type:content-transfer-encoding; s=sasl; bh=XdjpO4FWLZQ/
        2pXR64yaFxnUxeY=; b=NJF5yWdqevE/wXfVCvL/U8zbaUiuOxuz+U3ghaobEsx6
        j6AeWzQ/vBhRo64/NwLzrDegE2cTt0kFu7bZwCZ7r6VZBDHU+aRmABIy99YZe4f9
        ozxkEDieO80tRzU+Ixgs9g/uD0J80QtS87YonWTF7s69cibPGDtNzSKTMIJcZ50=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=message-id:date
        :from:mime-version:to:cc:subject:references:in-reply-to
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=amUoe6
        ONVDaIDesiCRjA6vyg5TCGX/tF9hg62+1c0PmVEaHurXXTdGyGFoSS7WhfJMIdN3
        tOUJizFpOy9ixFQAepMseer/79dW3k2omorarq0KiGjFg9u810wusefOdOkacfwB
        esKWWGXVZW+czZ7dcX+fY0uiHX5wP58ENwomM=
Received: from b-pb-sasl-quonix. (unknown [127.0.0.1])
        by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9E55B8F93;
        Thu,  6 Jan 2011 11:18:06 -0500 (EST)
Received: from [192.168.11.5] (unknown [180.12.104.147]) (using TLSv1 with
 cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested)
 by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 041DB8F81; Thu,  6 Jan
 2011 11:17:57 -0500 (EST)
Message-ID: <4D25EB30.4020905@pobox.com>
Date:   Fri, 07 Jan 2011 01:17:52 +0900
From:   Shinya Kuribayashi <skuribay@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.2.13)
 Gecko/20101208 Thunderbird/3.1.7
MIME-Version: 1.0
To:     Kevin Cernekee <cernekee@gmail.com>
CC:     Ralf Baechle <ralf@linux-mips.org>, macro@linux-mips.org,
        raiko@niisi.msk.ru, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org, skuribay@pobox.com
Subject: Re: [PATCH RESEND 1/6] MIPS: sync after cacheflush
References: <8eec0c63f92528c501c0e6a0c8396359@localhost>
In-Reply-To: <8eec0c63f92528c501c0e6a0c8396359@localhost>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-Pobox-Relay-ID: 8B7BBEFC-19B0-11E0-81CE-DD55F7BC62F2-47602734!b-pb-sasl-quonix.pobox.com
Return-Path: <skuribay@pobox.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 28868
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: skuribay@pobox.com
Precedence: bulk
X-list: linux-mips

Hi,

sorry for my silence for several resending posts.  I talked with Ralf
on this briefly, when the patch was posted for the first time last
year.  He seems busy these days, so I'm trying to move things forward.

On 01/06/2011 04:31 PM, Kevin Cernekee wrote:
> On processors with deep write buffers, it is likely that many cycles
> will pass between a CACHE instruction and the time the data actually
> gets written out to DRAM.  Add a SYNC instruction to ensure that the
> buffers get emptied before the flush functions return.

Having a talk with appropriate people (probably including MIPS guys),
such CACHE behavior would be eventually considered to be _legitimate_,
Ralf said.  Thus we agree with this change required not only for BMIPS
cores, but also for the rest of processors, as one of cache features.

The problem is how to implement it.

Most of SYNC-equipped processors work fine without this treatment,
so unless it's required, we don't want to have __sync() after every
cacheflush operations.  Having SYNC there is somewhat waste of time.

> diff --git a/arch/mips/mm/c-r4k.c b/arch/mips/mm/c-r4k.c
> index b4923a7..dc5d9c4 100644
> --- a/arch/mips/mm/c-r4k.c
> +++ b/arch/mips/mm/c-r4k.c
> @@ -604,6 +604,7 @@ static void r4k_dma_cache_wback_inv(unsigned long addr, unsigned long size)
>  			r4k_blast_scache();
>  		else
>  			blast_scache_range(addr, addr + size);
> +		__sync();
>  		return;
>  	}
>  

Just random thought, how it's going to be when implementing this as,
- sort of barrier
- sort of hazard
- one of cache features (e.g., cpu_has_xxx or similar way)
- and so on...

Another concern is that, except for four __sync() insertions, are we
missing other places?

Ralf also thinks that run-time probe & detection would be better than
build-time configuration.  Optimization is easy and won't be problem
here, so we'd like to keep things synthesized as much as possible.

I couldn't imagine the final shape how this patch should be as of now,
sorry!

  Shinya
