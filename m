Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 11 Feb 2017 00:11:03 +0100 (CET)
Received: from mail-pf0-x231.google.com ([IPv6:2607:f8b0:400e:c00::231]:34980
        "EHLO mail-pf0-x231.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992236AbdBJXKzqZsJt (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 11 Feb 2017 00:10:55 +0100
Received: by mail-pf0-x231.google.com with SMTP id 202so9357665pfx.2
        for <linux-mips@linux-mips.org>; Fri, 10 Feb 2017 15:10:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=Tihn8EgCaEZWq/qqZLXQo2ksqGwfVZbJvgtogyxCM+M=;
        b=fceXba3wMhMAXgU8hQLyGTHwGyyDmRQkN3EFad5GxVK6Nb7m0E7pfRjSYBUoeIe43o
         6CKocPxqytyHvbfRBab8F6Jj7s76fu5eWuhZU47OCefj6/f4YJ9ErTlY+makDmMsAgm5
         G+LAaDknmC7qEaTYebQxncue01jUssg0iEojo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=Tihn8EgCaEZWq/qqZLXQo2ksqGwfVZbJvgtogyxCM+M=;
        b=oHBu4/tNkWNnCNA6MJYjmkpQLecG2MqLRXak6I/AQlO3kRgkgtYUYYuhfg0YZUzTnR
         826e4nmQDHYDyylsseDFgRYOfg/ybaOz/tYhc8mAg+fhPYTR40BWSJlGc2NrXjf6dSXI
         +/XssQVw05h8L7fCOOevZ+c/+VjJ74MWCxhFFI5Q5qyoYHJ5gZJZAuIiuDebAhsAjaKq
         yfkOT4jyGjzo3n786snl1R6Qp+Bw18EBGOl4Hnap+BIjDbZWiLteH9Gyxfcs/9tvbjVS
         K7CoEKjtPU0UKrEk0Em5psLmeyVAt05vIPVnil4nbsBJIRV4EbKMYW51K9/EKM7ZOKp4
         sIpw==
X-Gm-Message-State: AMke39n/EuGn2U1Rplt5JxWO3j6Yl5lRddbE3tJns3+T6JlGU2tBDc59c+t2iQ7J4XlY+r/I
X-Received: by 10.99.5.15 with SMTP id 15mr13582366pgf.109.1486768249626;
        Fri, 10 Feb 2017 15:10:49 -0800 (PST)
Received: from [10.13.138.212] ([192.19.255.250])
        by smtp.gmail.com with ESMTPSA id z70sm7540287pff.26.2017.02.10.15.10.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 10 Feb 2017 15:10:49 -0800 (PST)
Subject: Re: [PATCH] MIPS: Fix cacheinfo overflow
To:     James Hogan <james.hogan@imgtec.com>, linux-mips@linux-mips.org
References: <20170208234523.GA13263@roeck-us.net>
 <20170210230120.21588-1-james.hogan@imgtec.com>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Ralf Baechle <ralf@linux-mips.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        bcm-kernel-feedback-list@broadcom.com
From:   Justin Chen <justin.chen@broadcom.com>
Message-ID: <d63e0019-5861-ccca-7959-631916e6c882@broadcom.com>
Date:   Fri, 10 Feb 2017 15:10:47 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.0
MIME-Version: 1.0
In-Reply-To: <20170210230120.21588-1-james.hogan@imgtec.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <justin.chen@broadcom.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56768
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: justin.chen@broadcom.com
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

Hello,

Thanks for the catch!

I actually submitted a v2 of the patch sometime back located here:
https://patchwork.linux-mips.org/patch/15107/

The v2 had some code review changes from Matt Redfearn. These changes 
indirectly got rid of the error, which was why I wasn't running into the 
crash.

Either way, whatever makes more sense, we can drop the other v1 patch 
and add v2 or just add this patch on top.

Thanks,
Justin

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
