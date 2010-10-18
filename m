Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 18 Oct 2010 15:45:07 +0200 (CEST)
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:51820 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S1491753Ab0JRNpE (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 18 Oct 2010 15:45:04 +0200
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 47004D1705;
        Mon, 18 Oct 2010 09:45:00 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=message-id
        :date:from:mime-version:to:cc:subject:references:in-reply-to
        :content-type:content-transfer-encoding; s=sasl; bh=4UzlDqb+GIRh
        x+CFr1+FX0wrW+c=; b=VGRx9HdK8ygRQV35VC/w3p/8k0EXspNluoTvr3HAziAV
        gdHWiG+XPPEFGIP88XqFhX0UkqsUyax6yGMWGObncjFCT3guHpp3U2KbXAO7sIzZ
        jL1DGJbbvAoAj6vuMOrfHjQj1yruZotVjFGBIhvE84Ff18l56FrcCtpxvUvq0Z0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=message-id:date
        :from:mime-version:to:cc:subject:references:in-reply-to
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=CGbMU6
        gj9fSDC4P+F0OV8gLZQJ95VHBo1Iv70PI3UE3ZW09IuBdyHpC/2xqCFHvziMeJ83
        /ThNb+yzhZVasualigwhFl1xr3wFBkYkPOKo83rmcevlWXavVbEw/sFOPsOuHp3I
        NIfk7Ay2/tY+1DlTpL9+MQe7qU0FinNdhtJGM=
Received: from b-pb-sasl-quonix. (unknown [127.0.0.1])
        by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 12AE3D1701;
        Mon, 18 Oct 2010 09:44:57 -0400 (EDT)
Received: from Shinya-Kuribayashis-MacBook.local (unknown [180.12.66.33])
 (using TLSv1 with cipher AES256-SHA (256/256 bits)) (No client certificate
 requested) by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 24179D1700;
 Mon, 18 Oct 2010 09:44:51 -0400 (EDT)
Message-ID: <4CBC4F4E.5010305@pobox.com>
Date:   Mon, 18 Oct 2010 22:44:46 +0900
From:   Shinya Kuribayashi <skuribay@pobox.com>
User-Agent: Mozilla/5.0 (Macintosh; U; Intel Mac OS X 10.6; en-US;
 rv:1.9.1.14) Gecko/20101005 Thunderbird/3.0.9
MIME-Version: 1.0
To:     Kevin Cernekee <cernekee@gmail.com>
CC:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH resend 5/9] MIPS: sync after cacheflush
References: <17ebecce124618ddf83ec6fe8e526f93@localhost>
 <17d8d27a2356640a4359f1a7dcbb3b42@localhost>
In-Reply-To: <17d8d27a2356640a4359f1a7dcbb3b42@localhost>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Pobox-Relay-ID: E506C1CE-DABD-11DF-94DD-89B3016DD5F0-47602734!b-pb-sasl-quonix.pobox.com
Return-Path: <skuribay@pobox.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 28138
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: skuribay@pobox.com
Precedence: bulk
X-list: linux-mips

On 10/17/10 6:22 AM, Kevin Cernekee wrote:
> On processors with deep write buffers, it is likely that many cycles
> will pass between a CACHE instruction and the time the data actually
> gets written out to DRAM.  Add a SYNC instruction to ensure that the
> buffers get emptied before the flush functions return.
>
> Actual problem seen in the wild:
>
> 1) dma_alloc_coherent() allocates cached memory
>
> 2) memset() is called to clear the new pages
>
> 3) dma_cache_wback_inv() is called to flush the zero data out to memory
>
> 4) dma_alloc_coherent() returns an uncached (kseg1) pointer to the
> freshly allocated pages
>
> 5) Caller writes data through the kseg1 pointer
>
> 6) Buffered writeback data finally gets flushed out to DRAM
>
> 7) Part of caller's data is inexplicably zeroed out
>
> This patch adds SYNC between steps 3 and 4, which fixed the problem.
>
> Signed-off-by: Kevin Cernekee<cernekee@gmail.com>
> ---
>   arch/mips/mm/c-r4k.c |    4 ++++
>   1 files changed, 4 insertions(+), 0 deletions(-)
>
> diff --git a/arch/mips/mm/c-r4k.c b/arch/mips/mm/c-r4k.c
> index 6721ee2..05c3de3 100644
> --- a/arch/mips/mm/c-r4k.c
> +++ b/arch/mips/mm/c-r4k.c
> @@ -605,6 +605,7 @@ static void r4k_dma_cache_wback_inv(unsigned long addr, unsigned long size)
>   			r4k_blast_scache();
>   		else
>   			blast_scache_range(addr, addr + size);
> +		__sync();
>   		return;
>   	}
>

Basically, agreed.  I have similar workarounds when initiating DMA,
where we need to flush out data to DRAM before starting DMA trans-
actions.  Looks like similar situations.

But I have a concern.

I suspect that SYNC insn alone is still not enough, insn't it?  In
such systems with that 'deep' write buffer and data incoherency is
visibly observed, there sill may be data write transactions floating
in the internal bus system.

To make sure that all data (data inside processor's write buffer and
data floating in the internal bus system), we need the following
three steps:

1. Flush data cache
2. Uncached, dummy load operation from _DRAM_ (not somewhere else)
3. then SYNC instruction

With these steps, data in write buffer will be pushed out of the
processor's write buffer, wait for uncached load operation to be
completed, and then finally the pipeline gets cleared.  Thoughts?

   Shinya
