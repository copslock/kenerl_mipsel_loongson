Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 23 Feb 2016 01:03:35 +0100 (CET)
Received: from mail-pf0-f174.google.com ([209.85.192.174]:36842 "EHLO
        mail-pf0-f174.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27013675AbcBWADcbYzOt (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 23 Feb 2016 01:03:32 +0100
Received: by mail-pf0-f174.google.com with SMTP id e127so101192313pfe.3;
        Mon, 22 Feb 2016 16:03:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-type:content-transfer-encoding;
        bh=93UzJYL9D+z2foX1Jz5fOc5d/BJXrNaD5oFk3RlTSw0=;
        b=TU6dXVFu4ErKPuSzuunCajnnDtXXEm+XCjYRbwHrS36gNKJv1WeH6en39bXayzX67O
         OP/DQylniQw1+AQjvouZzdF6NrmdFjqBjjZbVG3YYamwtl00lAcCoo7ZqDOCnuB0UgXb
         sg0erIa3ud22wGPxgrXET9Hf30LSd3CJPlkfNQ8MFdGIl06BAU9yxeLCpUnkSkUqUlTp
         YD7XhXL8btXV2++UJOJfeyIgdusonMpILvw1I/T50EEI4bcVZQe7W39XnkqryRvGhyF+
         qrVUsiKZV0LZSqOqRHMxKsRfQkxmLUUE8z4nAAed/sJCXVSdiE8TFxWZx4voArTzBE5h
         Nf1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-type
         :content-transfer-encoding;
        bh=93UzJYL9D+z2foX1Jz5fOc5d/BJXrNaD5oFk3RlTSw0=;
        b=bS5cvISRmVuCfnpol76PoTt8z42DcRn6yqkNmmGeTumDSOUVRQU+s662P0C5Pagq/P
         2cOTE7vYK0xHFYOIEpqWAGfYFXBkxfUKTRi4KWKsAFtjkPLd8TOTBrC7EhEvX6uVD6br
         z1Ol+k6BIweRs8Yg91rzvIEhD2Z96Ov55/Pvt6xTDuiCwLitYLFO3V6NKd8IjZgeLqFq
         DYAr14tZVShkdmQS/5kH/c1uhkLU/adju7nMwfYX35D8QruIEWV5VDE/J7FfiIgujrbT
         yraD4IxzjXHApFO6eciBFq3WvPP+EI+Tz670O5Q/B/igo/2sTi7ddqq/qqQOvMj6wkmc
         p/qA==
X-Gm-Message-State: AG10YOTk5IL7d83RGzJkpHONh11m17lKNDJAXjqgMLYQinYU5IeQvD9VRAWVSM/B5vO1jA==
X-Received: by 10.98.0.194 with SMTP id 185mr41848642pfa.139.1456185806457;
        Mon, 22 Feb 2016 16:03:26 -0800 (PST)
Received: from [10.12.156.244] (5520-maca-inet1-outside.broadcom.com. [216.31.211.11])
        by smtp.googlemail.com with ESMTPSA id y15sm39397424pfi.16.2016.02.22.16.03.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 22 Feb 2016 16:03:25 -0800 (PST)
Subject: Re: [PATCH 1/2] MIPS: Add barriers between dcache & icache flushes
To:     Paul Burton <paul.burton@imgtec.com>, linux-mips@linux-mips.org,
        Ralf Baechle <ralf@linux-mips.org>
References: <1456164585-26910-1-git-send-email-paul.burton@imgtec.com>
Cc:     James Hogan <james.hogan@imgtec.com>,
        Joshua Kinard <kumba@gentoo.org>,
        Paul Gortmaker <paul.gortmaker@windriver.com>,
        linux-kernel@vger.kernel.org,
        "Maciej W. Rozycki" <macro@codesourcery.com>,
        Markos Chandras <markos.chandras@imgtec.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <56CBA181.8070606@gmail.com>
Date:   Mon, 22 Feb 2016 16:02:09 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.5.1
MIME-Version: 1.0
In-Reply-To: <1456164585-26910-1-git-send-email-paul.burton@imgtec.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 52174
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: f.fainelli@gmail.com
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

On 22/02/16 10:09, Paul Burton wrote:
> Index-based cache operations may be arbitrarily reordered by out of
> order CPUs. Thus code which writes back the dcache & then invalidates
> the icache using indexed cache ops must include a barrier between
> operating on the 2 caches in order to prevent the scenario in which:
> 
>   - icache invalidation occurs.
> 
>   - icache fetch occurs, due to speculation.
> 
>   - dcache writeback occurs.
> 
> If the above were allowed to happen then the icache would contain stale
> data. Forcing the dcache writeback to complete before the icache
> invalidation avoids this.

Is that also true for CPUs with have cpu_has_ic_fills_dc?

> 
> Signed-off-by: Paul Burton <paul.burton@imgtec.com>
> Cc: James Hogan <james.hogan@imgtec.com>
> ---
> 
>  arch/mips/mm/c-r4k.c | 15 +++++++++++++--
>  1 file changed, 13 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/mips/mm/c-r4k.c b/arch/mips/mm/c-r4k.c
> index caac3d7..a49010c 100644
> --- a/arch/mips/mm/c-r4k.c
> +++ b/arch/mips/mm/c-r4k.c
> @@ -449,6 +449,7 @@ static inline void local_r4k___flush_cache_all(void * args)
>  
>  	default:
>  		r4k_blast_dcache();
> +		mb(); /* cache instructions may be reordered */
>  		r4k_blast_icache();
>  		break;
>  	}
> @@ -493,8 +494,10 @@ static inline void local_r4k_flush_cache_range(void * args)
>  		return;
>  
>  	r4k_blast_dcache();
> -	if (exec)
> +	if (exec) {
> +		mb(); /* cache instructions may be reordered */
>  		r4k_blast_icache();
> +	}
>  }
>  
>  static void r4k_flush_cache_range(struct vm_area_struct *vma,
> @@ -599,8 +602,13 @@ static inline void local_r4k_flush_cache_page(void *args)
>  	if (cpu_has_dc_aliases || (exec && !cpu_has_ic_fills_f_dc)) {
>  		vaddr ? r4k_blast_dcache_page(addr) :
>  			r4k_blast_dcache_user_page(addr);
> -		if (exec && !cpu_icache_snoops_remote_store)
> +		if (exec)
> +			mb(); /* cache instructions may be reordered */
> +
> +		if (exec && !cpu_icache_snoops_remote_store) {
>  			r4k_blast_scache_page(addr);
> +			mb(); /* cache instructions may be reordered */
> +		}
>  	}
>  	if (exec) {
>  		if (vaddr && cpu_has_vtag_icache && mm == current->active_mm) {
> @@ -660,6 +668,7 @@ static inline void local_r4k_flush_icache_range(unsigned long start, unsigned lo
>  			R4600_HIT_CACHEOP_WAR_IMPL;
>  			protected_blast_dcache_range(start, end);
>  		}
> +		mb(); /* cache instructions may be reordered */
>  	}
>  
>  	if (end - start > icache_size)
> @@ -798,6 +807,8 @@ static void local_r4k_flush_cache_sigtramp(void * arg)
>  		protected_writeback_dcache_line(addr & ~(dc_lsize - 1));
>  	if (!cpu_icache_snoops_remote_store && scache_size)
>  		protected_writeback_scache_line(addr & ~(sc_lsize - 1));
> +	if ((dc_lsize || scache_size) && ic_lsize)
> +		mb(); /* cache instructions may be reordered */
>  	if (ic_lsize)
>  		protected_flush_icache_line(addr & ~(ic_lsize - 1));
>  	if (MIPS4K_ICACHE_REFILL_WAR) {
> 


-- 
Florian
