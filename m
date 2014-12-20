Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 20 Dec 2014 02:21:49 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:37876 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27009080AbaLTBVryevoW (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 20 Dec 2014 02:21:47 +0100
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 1DEE4BA85700B;
        Sat, 20 Dec 2014 01:21:41 +0000 (GMT)
Received: from BAMAIL02.ba.imgtec.org (10.20.40.28) by KLMAIL01.kl.imgtec.org
 (192.168.5.35) with Microsoft SMTP Server (TLS) id 14.3.195.1; Sat, 20 Dec
 2014 01:21:42 +0000
Received: from [192.168.65.146] (192.168.65.146) by bamail02.ba.imgtec.org
 (10.20.40.28) with Microsoft SMTP Server (TLS) id 14.3.174.1; Fri, 19 Dec
 2014 17:21:40 -0800
Message-ID: <5494CF23.1080606@imgtec.com>
Date:   Fri, 19 Dec 2014 17:21:39 -0800
From:   Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.2.0
MIME-Version: 1.0
To:     David Daney <ddaney.cavm@gmail.com>, <linux-mips@linux-mips.org>,
        <ralf@linux-mips.org>
CC:     David Daney <david.daney@cavium.com>
Subject: Re: [PATCH] MIPS: Fix C0_Pagegrain[IEC] support.
References: <1419038123-30270-1-git-send-email-ddaney.cavm@gmail.com>
In-Reply-To: <1419038123-30270-1-git-send-email-ddaney.cavm@gmail.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.65.146]
Return-Path: <Leonid.Yegoshin@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 44861
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Leonid.Yegoshin@imgtec.com
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

On 12/19/2014 05:15 PM, David Daney wrote:
> From: David Daney <david.daney@cavium.com>
>
> If we are generating TLB exception expecting separate vectors, we must
> enable the feature.
>
> Cc: Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>
> Signed-off-by: David Daney <david.daney@cavium.com>
> ---
>
> Very lightly tested, but it seems to make my XI and RI tests work on
> OCTEON II CPUs, which have the C0_Pagegrain[IEC] bit.
>
>   arch/mips/mm/tlb-r4k.c | 2 ++
>   1 file changed, 2 insertions(+)
>
> diff --git a/arch/mips/mm/tlb-r4k.c b/arch/mips/mm/tlb-r4k.c
> index e90b2e8..30639a6 100644
> --- a/arch/mips/mm/tlb-r4k.c
> +++ b/arch/mips/mm/tlb-r4k.c
> @@ -489,6 +489,8 @@ static void r4k_tlb_configure(void)
>   #ifdef CONFIG_64BIT
>   		pg |= PG_ELPA;
>   #endif
> +		if (cpu_has_rixiex)
> +			pg |= PG_IEC;
>   		write_c0_pagegrain(pg);
>   	}
>   
David, I think it is still better to use set_c0_pagegrain() because 
PageGrain has a lot of RW bits now and clear all of them may be not good.
