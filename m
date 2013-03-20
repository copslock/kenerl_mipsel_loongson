Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 21 Mar 2013 00:16:17 +0100 (CET)
Received: from mail-pb0-f46.google.com ([209.85.160.46]:40576 "EHLO
        mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6834924Ab3CTXQQpM9B0 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 21 Mar 2013 00:16:16 +0100
Received: by mail-pb0-f46.google.com with SMTP id uo15so1731820pbc.33
        for <multiple recipients>; Wed, 20 Mar 2013 16:16:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:message-id:date:from:user-agent:mime-version:to:cc
         :subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=uH5Dh9DzSMsaz/Df9/TX5pKNST6IEVVJ3/t8djdiuYI=;
        b=meQPlFXEU1WcgruSFnPujKtX9/GdKMDbvAI+sK1Fct75syngZ6lvKz8YYfUDf0Xr5M
         FUPYEOC3j3PUxxbvEwWV7gSvbfiUpnbdDX4y+7m+JkuudHUoqCOjRN4nEYlwkbMK62Ux
         3XaPPSLnId1x6IjIfidndz0tBlrLDBL+6S4kEel5EkRjrLVirgMy19HJlKSlg2wkFWv9
         I3fjZ1E3XzgggSbeHoEPFUMo9E6qJEwbdUnp4X36cHLHo89w1aRexfAle837b3py4U0u
         6EFdofEPxsfuSDJRR1icUQly4neu1WaPmg3NA6wZW/cIjT4tOgHFAmFlrL3O1X2gq3Ym
         2csQ==
X-Received: by 10.67.1.8 with SMTP id bc8mr4637292pad.96.1363821370224;
        Wed, 20 Mar 2013 16:16:10 -0700 (PDT)
Received: from dl.caveonetworks.com (64.2.3.195.ptr.us.xo.net. [64.2.3.195])
        by mx.google.com with ESMTPS id is1sm3625205pbc.15.2013.03.20.16.16.08
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Wed, 20 Mar 2013 16:16:09 -0700 (PDT)
Message-ID: <514A4337.6080100@gmail.com>
Date:   Wed, 20 Mar 2013 16:16:07 -0700
From:   David Daney <ddaney.cavm@gmail.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130110 Thunderbird/17.0.2
MIME-Version: 1.0
To:     Huacai Chen <chenhc@lemote.com>
CC:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org, Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>
Subject: Re: [PATCH V2 02/02] MIPS: Init new mmu_context for each possible
 CPU to avoid memory corruption
References: <1363524614-3823-1-git-send-email-chenhc@lemote.com>
In-Reply-To: <1363524614-3823-1-git-send-email-chenhc@lemote.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-archive-position: 35925
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
Return-Path: <linux-mips-bounce@linux-mips.org>

On 03/17/2013 05:50 AM, Huacai Chen wrote:
> Currently, init_new_context() only for each online CPU, this may cause
> memory corruption when CPU hotplug and fork() happens at the same time.
> To avoid this, we make init_new_context() cover each possible CPU.
>
> Scenario:
> 1, CPU#1 is being offline;
> 2, On CPU#0, do_fork() call dup_mm() and copy a mm_struct to the child;
> 3, On CPU#0, dup_mm() call init_new_context(), since CPU#1 is offline
>     and init_new_context() only covers the online CPUs, child has the
>     same asid as its parent on CPU#1 (however, child's asid should be 0);
> 4, CPU#1 is being online;
> 5, Now, if both parent and child run on CPU#1, memory corruption (e.g.
>     segfault, bus error, etc.) will occur.
>
> Signed-off-by: Huacai Chen <chenhc@lemote.com>


We were seeing the same crashes, this patch set seems to fix the problem.

Acked-by: David Daney <david.daney@cavium.com>

> ---
>   arch/mips/include/asm/mmu_context.h |    2 +-
>   1 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/arch/mips/include/asm/mmu_context.h b/arch/mips/include/asm/mmu_context.h
> index e81d719..49d220c 100644
> --- a/arch/mips/include/asm/mmu_context.h
> +++ b/arch/mips/include/asm/mmu_context.h
> @@ -133,7 +133,7 @@ init_new_context(struct task_struct *tsk, struct mm_struct *mm)
>   {
>   	int i;
>
> -	for_each_online_cpu(i)
> +	for_each_possible_cpu(i)
>   		cpu_context(i, mm) = 0;
>
>   	return 0;
>
