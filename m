Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 01 Dec 2010 12:53:00 +0100 (CET)
Received: from mail-ew0-f49.google.com ([209.85.215.49]:57743 "EHLO
        mail-ew0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492959Ab0LALw4 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 1 Dec 2010 12:52:56 +0100
Received: by ewy20 with SMTP id 20so3367231ewy.36
        for <multiple recipients>; Wed, 01 Dec 2010 03:52:56 -0800 (PST)
Received: by 10.213.9.83 with SMTP id k19mr3526855ebk.47.1291204376092;
        Wed, 01 Dec 2010 03:52:56 -0800 (PST)
Received: from [192.168.2.2] ([91.79.91.95])
        by mx.google.com with ESMTPS id q58sm7438848eeh.9.2010.12.01.03.52.53
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 01 Dec 2010 03:52:54 -0800 (PST)
Message-ID: <4CF636A7.1030809@mvista.com>
Date:   Wed, 01 Dec 2010 14:51:03 +0300
From:   Sergei Shtylyov <sshtylyov@mvista.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-GB; rv:1.9.2.12) Gecko/20101027 Thunderbird/3.1.6
MIME-Version: 1.0
To:     Maksim Rayskiy <maksim.rayskiy@gmail.com>
CC:     "Kevin D. Kissell" <kevink@paralogos.com>,
        Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Subject: Re: [PATCH] MIPS: ASID conflict after CPU hotplug
References: <AANLkTi=yHm72=sM=QwLpm=aDRnxVf7ZM5=W6eNzgVoTN@mail.gmail.com>        <20101122034141.GA13138@linux-mips.org>        <4CEAE1EE.9020406@paralogos.com>        <AANLkTimuJLxG2KoibRxzcHkX3LoKsTWqJSF_e=ouFi+b@mail.gmail.com>        <4CEE877C.7020309@paralogos.com>        <AANLkTinUSjvjwHVJoRW-Fr75WDfheq3hSM_hEBMsEUXK@mail.gmail.com>        <4CF46741.9060902@paralogos.com>        <AANLkTikb32T_c7iu6aa0mXDDqC4ncsV9iQAqyVKHy1_y@mail.gmail.com>        <4CF4CC6B.9090603@paralogos.com> <AANLkTinQKfeYockOBYQOasJ0-C3T106Qe95hV23pfqKg@mail.gmail.com>
In-Reply-To: <AANLkTinQKfeYockOBYQOasJ0-C3T106Qe95hV23pfqKg@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sshtylyov@mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 28579
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sshtylyov@mvista.com
Precedence: bulk
X-list: linux-mips

Hello.

On 30-11-2010 22:49, Maksim Rayskiy wrote:

> From 9a03661a40407e14ee75295f5541f371f0a7cdda Mon Sep 17 00:00:00 2001
> From: Maksim Rayskiy<maksim.rayskiy@gmail.com>
> Date: Tue, 30 Nov 2010 11:34:31 -0800
> Subject: [PATCH] MIPS: Added local_flush_tlb_all_mm to clear all mm
> contexts on calling cpu

> When hotplug removing a cpu, all mm context TLB entries must be cleared
> to avoid ASID conflict when cpu is restarted.
> New functions local_flush_tlb_all_mm() and all-cpu version
> flush_tlb_all_mm() are added.
> To function properly, local_flush_tlb_all_mm() must be called when
> mm_cpumask for all
> mm context on given cpu is cleared.

> Signed-off-by: Maksim Rayskiy<maksim.rayskiy@gmail.com>
[...]

> diff --git a/arch/mips/mm/tlb-r4k.c b/arch/mips/mm/tlb-r4k.c
> index c618eed..5c03218 100644
> --- a/arch/mips/mm/tlb-r4k.c
> +++ b/arch/mips/mm/tlb-r4k.c
> @@ -66,6 +66,18 @@ extern void build_tlb_refill_handler(void);
>
>   #endif
>
> +/* This function will clear all mm contexts on calling cpu
> + * To produce desired effect it must be called
> + * when mm_cpumask for all mm contexts is cleared
> + */
> +void local_flush_tlb_all_mm(void)
> +{
> +	struct task_struct *p;

    An empty line wouldn't hurt here...

> +	for_each_process(p)
> +		if (p->mm)
> +			local_flush_tlb_mm(p->mm);
> +}
> +

WBR, Sergei
