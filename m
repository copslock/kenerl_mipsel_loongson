Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 12 Dec 2014 22:49:15 +0100 (CET)
Received: from mail-ie0-f173.google.com ([209.85.223.173]:38268 "EHLO
        mail-ie0-f173.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27008034AbaLLVtNFpuEy (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 12 Dec 2014 22:49:13 +0100
Received: by mail-ie0-f173.google.com with SMTP id y20so7746825ier.18
        for <multiple recipients>; Fri, 12 Dec 2014 13:49:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=kGIdpNJaBQVkrG/6CiGt8ITZylz+OegxjlbDXAHK1Ck=;
        b=rns9w1bRiSQupFsaYodPxxQwCbh8MaRTekLBfKpcJtKlwKl+uhpk2hTjELjMK2nWZD
         pqLVUN7XvNR73sY6luKixlDyT655p/8hiZmICGhIOYOAPg25zOfmaFmVyleNVy8deTzS
         rS0VPZBmhbnV7gtKHkHiYE6TafwzBa6Vrr/3tDGt5X+ieRUckmiK9bCz4iYpFLEr7AfC
         zr5z8rM3lldUqNsV8lbF9JlMQiaWm1xfdm7kHBPmSiULFqV1J1jjsZ+111UWB7zhLIqj
         Jl+Jfbt5SZTsHhVpmfBmLhUHcciuLlY6KeWRsnNfTMkAasIi00ALHndcS0oTQ3mXXdVn
         +lVg==
X-Received: by 10.50.22.72 with SMTP id b8mr6915315igf.1.1418420947233;
        Fri, 12 Dec 2014 13:49:07 -0800 (PST)
Received: from dl.caveonetworks.com (64.2.3.194.ptr.us.xo.net. [64.2.3.194])
        by mx.google.com with ESMTPSA id i19sm1138666igh.6.2014.12.12.13.49.06
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Fri, 12 Dec 2014 13:49:06 -0800 (PST)
Message-ID: <548B62D1.4000809@gmail.com>
Date:   Fri, 12 Dec 2014 13:49:05 -0800
From:   David Daney <ddaney.cavm@gmail.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130625 Thunderbird/17.0.7
MIME-Version: 1.0
To:     Joshua Kinard <kumba@gentoo.org>
CC:     Ralf Baechle <ralf@linux-mips.org>,
        Linux MIPS List <linux-mips@linux-mips.org>
Subject: Re: [PATCH] MIPS: CEVT: Make R4K's clockevent_device name more meaningful
References: <548B5EAC.9030403@gentoo.org>
In-Reply-To: <548B5EAC.9030403@gentoo.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <ddaney.cavm@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 44637
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney.cavm@gmail.com
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

On 12/12/2014 01:31 PM, Joshua Kinard wrote:
> Change the R4K clockevent device's name from "MIPS" to something a bit more
> meaningful, "CEVT-R4K".
>

This is visible to userspace, so how does changing this effect the 
kernel <--> userspace ABI?  Or in other words, what uses this, and could 
changing it possibly break things?

David Daney


> Signed-off-by: Joshua Kinard <kumba@gentoo.org>
> ---
>   arch/mips/kernel/cevt-r4k.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/mips/kernel/cevt-r4k.c b/arch/mips/kernel/cevt-r4k.c
> index bc127e2..f531cac 100644
> --- a/arch/mips/kernel/cevt-r4k.c
> +++ b/arch/mips/kernel/cevt-r4k.c
> @@ -178,7 +178,7 @@ int r4k_clockevent_init(void)
>
>   	cd = &per_cpu(mips_clockevent_device, cpu);
>
> -	cd->name		= "MIPS";
> +	cd->name		= "CEVT-R4K";
>   	cd->features		= CLOCK_EVT_FEAT_ONESHOT |
>   				  CLOCK_EVT_FEAT_C3STOP |
>   				  CLOCK_EVT_FEAT_PERCPU;
>
>
>
>
