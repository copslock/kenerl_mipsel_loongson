Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 11 Feb 2017 02:25:25 +0100 (CET)
Received: from bh-25.webhostbox.net ([208.91.199.152]:42281 "EHLO
        bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23992136AbdBKBZRhTH4M (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 11 Feb 2017 02:25:17 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=roeck-us.net; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:Cc:References:To:Subject;
        bh=xJgjh4y3V/cBClvsInUl06QuGXCgLRcsP3kjAnsLHvU=; b=BcGrLc/6URpDxQNhyB4M5yU6AT
        +Z9xZ9pJQuJWXVDYl+stgWL1DABtpouLCEXDnNbmcMKQ9VVAjjDWBHYlnrCd0JjFqOmaQMvdX+p9A
        A/k4D4IuFiJbNZECpJUa7NdRwacwYw7pVRlpC+u3sfGya0KzH9Ufk6NGUC/EPLJrOn1/c2HsrweBH
        jy5OEL1fD6C7KgiZMTr4+wJZYJEsGF1Sj3pDSMiF0aN5zJ4Aum3z3IbKebf9dh8qqoJwdxi/IGYzL
        H0u3J16jnJ2z9Eo14lZHVXtt/3sBGob9iA+2d+syhyWncNYxdfhyBj1oudk5p5IE+022kF9ll6YVa
        kozxgWfw==;
Received: from 108-223-40-66.lightspeed.sntcca.sbcglobal.net ([108.223.40.66]:45200 helo=server.roeck-us.net)
        by bh-25.webhostbox.net with esmtpsa (TLSv1:DHE-RSA-AES128-SHA:128)
        (Exim 4.86_1)
        (envelope-from <linux@roeck-us.net>)
        id 1ccMR2-00379s-T8; Sat, 11 Feb 2017 01:25:09 +0000
Subject: Re: [PATCH] MIPS: Fix cacheinfo overflow
To:     James Hogan <james.hogan@imgtec.com>, linux-mips@linux-mips.org
References: <20170208234523.GA13263@roeck-us.net>
 <20170210230120.21588-1-james.hogan@imgtec.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Justin Chen <justin.chen@broadcom.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        bcm-kernel-feedback-list@broadcom.com
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <83acf9d3-ea54-13a0-d4d5-26e44c788fc0@roeck-us.net>
Date:   Fri, 10 Feb 2017 17:25:07 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.5.1
MIME-Version: 1.0
In-Reply-To: <20170210230120.21588-1-james.hogan@imgtec.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
X-Authenticated_sender: linux@roeck-us.net
X-OutGoing-Spam-Status: No, score=-1.0
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - bh-25.webhostbox.net
X-AntiAbuse: Original Domain - linux-mips.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - roeck-us.net
X-Get-Message-Sender-Via: bh-25.webhostbox.net: authenticated_id: linux@roeck-us.net
X-Authenticated-Sender: bh-25.webhostbox.net: linux@roeck-us.net
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Return-Path: <linux@roeck-us.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56771
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: linux@roeck-us.net
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

On 02/10/2017 03:01 PM, James Hogan wrote:
> The recently added MIPS cacheinfo support used a macro populate_cache()
> to populate the cacheinfo structures depending on which caches are
> present. However the macro contains multiple statements without
> enclosing them in a do {} while (0) loop, so the L2 and L3 cache
> conditionals in populate_cache_leaves() only conditionalised the first
> statement in the macro.
>
> This overflows the buffer allocated by detect_cache_attributes(),
> resulting in boot failures under QEMU where neither the L2 or L2 caches
> are present.
>
> Enclose the macro statements in a do {} while (0) block to keep the
> whole macro inside the conditionals.
>
> Fixes: ef462f3b64e9 ("MIPS: Add cacheinfo support")
> Reported-by: Guenter Roeck <linux@roeck-us.net>
> Signed-off-by: James Hogan <james.hogan@imgtec.com>

Tested-by: Guenter Roeck <linux@roeck-us.net>

> Cc: Ralf Baechle <ralf@linux-mips.org>
> Cc: Justin Chen <justin.chen@broadcom.com>
> Cc: Florian Fainelli <f.fainelli@gmail.com>
> Cc: linux-mips@linux-mips.org
> Cc: bcm-kernel-feedback-list@broadcom.com
> ---
>  arch/mips/kernel/cacheinfo.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/arch/mips/kernel/cacheinfo.c b/arch/mips/kernel/cacheinfo.c
> index a92bbbae969b..97d5239ca47b 100644
> --- a/arch/mips/kernel/cacheinfo.c
> +++ b/arch/mips/kernel/cacheinfo.c
> @@ -17,6 +17,7 @@
>
>  /* Populates leaf and increments to next leaf */
>  #define populate_cache(cache, leaf, c_level, c_type)		\
> +do {								\
>  	leaf->type = c_type;					\
>  	leaf->level = c_level;					\
>  	leaf->coherency_line_size = c->cache.linesz;		\
> @@ -24,7 +25,8 @@
>  	leaf->ways_of_associativity = c->cache.ways;		\
>  	leaf->size = c->cache.linesz * c->cache.sets *		\
>  		c->cache.ways;					\
> -	leaf++;
> +	leaf++;							\
> +} while (0)
>
>  static int __init_cache_level(unsigned int cpu)
>  {
>
