Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 29 Dec 2010 21:43:03 +0100 (CET)
Received: from mail-ew0-f49.google.com ([209.85.215.49]:52893 "EHLO
        mail-ew0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491043Ab0L2UnA (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 29 Dec 2010 21:43:00 +0100
Received: by ewy20 with SMTP id 20so4620171ewy.36
        for <multiple recipients>; Wed, 29 Dec 2010 12:42:59 -0800 (PST)
Received: by 10.213.22.209 with SMTP id o17mr11991024ebb.41.1293655379439;
        Wed, 29 Dec 2010 12:42:59 -0800 (PST)
Received: from [192.168.11.174] (mail.dev.rtsoft.ru [213.79.90.226])
        by mx.google.com with ESMTPS id t50sm10848562eeh.12.2010.12.29.12.42.57
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 29 Dec 2010 12:42:58 -0800 (PST)
Message-ID: <4D1B9D03.1090109@mvista.com>
Date:   Wed, 29 Dec 2010 23:41:39 +0300
From:   Sergei Shtylyov <sshtylyov@mvista.com>
User-Agent: Thunderbird 2.0.0.21 (X11/20090320)
MIME-Version: 1.0
To:     Maksim Rayskiy <maksim.rayskiy@gmail.com>
CC:     linux-mips <linux-mips@linux-mips.org>,
        "Kevin D. Kissell" <kevink@paralogos.com>,
        Ralf Baechle <ralf@linux-mips.org>
Subject: Re: [PATCH RESEND] MIPS: Add local_flush_tlb_all_mm to clear all
 mm contexts on calling cpu
References: <AANLkTi=_2aqFiB4Qgez8f-tiiqv19+VHDzX2TJ7jZ2Ha@mail.gmail.com>
In-Reply-To: <AANLkTi=_2aqFiB4Qgez8f-tiiqv19+VHDzX2TJ7jZ2Ha@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sshtylyov@mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 28773
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sshtylyov@mvista.com
Precedence: bulk
X-list: linux-mips

Hello.

Maksim Rayskiy wrote:

> I hope this one does not get mangled.

    It seems OK.

> The thing is I do not know how
> to control it in gmail web client.

    Such remarks should follow the --- tear line.

> From 9a03661a40407e14ee75295f5541f371f0a7cdda Mon Sep 17 00:00:00 2001
> From: Maksim Rayskiy <maksim.rayskiy@gmail.com>
> Date: Tue, 30 Nov 2010 11:34:31 -0800
> Subject: [PATCH] MIPS: Add local_flush_tlb_all_mm to clear all mm
> contexts on calling cpu

    Don't include this header in the patch, as it will have to be hand edited 
out of it by the maintainer.

> When hotplug removing a cpu, all mm context TLB entries must be cleared
> to avoid ASID conflict when cpu is restarted.
> New functions local_flush_tlb_all_mm() and all-cpu version
> flush_tlb_all_mm() are added.
> To function properly, local_flush_tlb_all_mm() must be called when
> mm_cpumask for all
> mm context on given cpu is cleared.

> Signed-off-by: Maksim Rayskiy <maksim.rayskiy@gmail.com>
[...]

> diff --git a/arch/mips/mm/tlb-r4k.c b/arch/mips/mm/tlb-r4k.c
> index c618eed..5c03218 100644
> --- a/arch/mips/mm/tlb-r4k.c
> +++ b/arch/mips/mm/tlb-r4k.c
> @@ -66,6 +66,18 @@ extern void build_tlb_refill_handler(void);
> 
>  #endif
> 
> +/* This function will clear all mm contexts on calling cpu
> + * To produce desired effect it must be called
> + * when mm_cpumask for all mm contexts is cleared
> + */
> +void local_flush_tlb_all_mm(void)
> +{
> +	struct task_struct *p;

    An empty line wouldn't hurt here.

> +	for_each_process(p)
> +		if (p->mm)
> +			local_flush_tlb_mm(p->mm);
> +}
> +
>  void local_flush_tlb_all(void)
>  {
>  	unsigned long flags;

WBR, Sergei
