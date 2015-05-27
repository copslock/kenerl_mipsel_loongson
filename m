Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 27 May 2015 19:37:28 +0200 (CEST)
Received: from mail-pa0-f51.google.com ([209.85.220.51]:36004 "EHLO
        mail-pa0-f51.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27007267AbbE0Rh03NDxH (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 27 May 2015 19:37:26 +0200
Received: by paza2 with SMTP id a2so2867323paz.3;
        Wed, 27 May 2015 10:37:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=MOaMvdLgJZocKGKQPCTqGI/11ueU2hL/ozYxjlmAwNA=;
        b=cIE+y51avzVSBz6FIvawZ3w9u+sTbEmm/H1gRps77mlVZnQhKP9u+8vN5wh8Wxud6F
         3f9NWAhy28T83BkddfI1tOO3ESOhCoSIlL95QpeCVsBB3oKU5OCSzhjlsF+o6iXvVJlv
         mVqQkgxaLMjOrRTVH5ecWBOqL/BfVmsw4Yt9B22LVI9jrMhedhwaZYQcYild609jJJzi
         snXs3AdX++eZO2i3l7Jyl3g0l0c/Y2eT+TMyjf4I7sb5BPAozSI9HDI7jT8gw2PzPd9u
         ruLiQOS9k8SUeTNLWrecXiDpKrSNe8s3yEe2nZewVDouXzIOxtb2RYMjLaubzQtYUUnv
         lGnw==
X-Received: by 10.70.89.199 with SMTP id bq7mr59679153pdb.168.1432748243214;
        Wed, 27 May 2015 10:37:23 -0700 (PDT)
Received: from [10.12.156.244] (5520-maca-inet1-outside.broadcom.com. [216.31.211.11])
        by mx.google.com with ESMTPSA id qz3sm16896238pab.19.2015.05.27.10.37.21
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 27 May 2015 10:37:22 -0700 (PDT)
Message-ID: <556600B5.70402@gmail.com>
Date:   Wed, 27 May 2015 10:36:53 -0700
From:   Florian Fainelli <f.fainelli@gmail.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.7.0
MIME-Version: 1.0
To:     Petri Gynther <pgynther@google.com>, linux-mips@linux-mips.org
CC:     ralf@linux-mips.org, cernekee@gmail.com
Subject: Re: [PATCH] MIPS: BMIPS: fix bmips_wr_vec()
References: <20150527062508.CD24722020B@puck.mtv.corp.google.com>
In-Reply-To: <20150527062508.CD24722020B@puck.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 47694
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

On 26/05/15 23:25, Petri Gynther wrote:
> bmips_wr_vec() copies exception vector code from start to dst.
> 
> The call to dma_cache_wback() needs to flush (end-start) bytes,
> starting at dst, from write-back cache to memory.
> 
> Signed-off-by: Petri Gynther <pgynther@google.com>

Acked-by: Florian Fainelli <f.fainelli@gmail.com>
Fixes: df0ac8a406718 ("MIPS: BMIPS: Add SMP support code for
BMIPS43xx/BMIPS5000")
CC: stable@vger.kernel.org # 3.4+

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
>  	local_flush_icache_range(dst, dst + (end - start));
>  	instruction_hazard();
>  }
> 


-- 
Florian
