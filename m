Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 29 Jun 2017 12:07:53 +0200 (CEST)
Received: from mail-it0-x22e.google.com ([IPv6:2607:f8b0:4001:c0b::22e]:37713
        "EHLO mail-it0-x22e.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990552AbdF2KHnPMIoB convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 29 Jun 2017 12:07:43 +0200
Received: by mail-it0-x22e.google.com with SMTP id m84so4253372ita.0;
        Thu, 29 Jun 2017 03:07:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=y3N8jOP7DFk9JFlc6LEyF0r4n3JK88s1lwjdD5EdmGY=;
        b=DAdFAc5mE0m4V/2INcO4EbLQ+ue0zE8czEMn6ru/PlY20ONo8pp19A5Awt8XrJw6Vs
         lAl2uedPCJSt/lyPm8ju+0+VMBzv8qdj88hiUcj6YOxXu3tffrce7osVr9vnNC38PV+w
         KrLmno7xjEJo3KAzjZz9Ty5q0kK3UbiAKssxIXQZvB+KCGJEPVz/44MWsol+20Dot9kX
         pULbPwwz0EP6s6GaEVHfcbNSRLDIuZnM5zRbuvJmWHi2qU7okZ9Cae7k6QCsCtWg0jj/
         mzpU3kdSZj9USmzUiqUaRAEkdXL7h9xi+kY9+fJM/dXGLxVyd0wV1aUCMnF/UETmhpnp
         zN4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc:content-transfer-encoding;
        bh=y3N8jOP7DFk9JFlc6LEyF0r4n3JK88s1lwjdD5EdmGY=;
        b=mq/OZWcTD1vNl4fNlec34RS1BUmxre85dDP9WGtCSXlPs63QaA2ANCiw82YL4HpO1Y
         dDRbnAtSHusUF4gbCoVPHcuRn+5qWRrGdSMLoE4rwmqq17vq1tzpxuMlw2/0GIQilvH+
         2bY3i8/qRRSXFHDZy0KK3IEDNxniv55Qma1B+6EL1BtkJ35hPQVUfVIrGrs9XBNeETyr
         lnBdLnN2GgEqXl+/4MzMCAtX4fjH4AnWlAvFaCPJj9/cK+efdewlNuH0Z7Zo7lVH4SIX
         g7RHNr9QmGA1eBKuQXN3+5SO5EMTEA6pWtgGz+AluJrl9AembzmjxB7det3UtRQJO9ZR
         hAIA==
X-Gm-Message-State: AIVw1104x9nXwrjLo1OWyZ/ZFucWKpTxVVIzd0XjBDfoK492ciDndEoY
        zIKGxH3Gua5/gLnNKUEBSpkLLY8JwnRw
X-Received: by 10.36.89.17 with SMTP id p17mr1146756itb.72.1498730856396; Thu,
 29 Jun 2017 03:07:36 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.144.85 with HTTP; Thu, 29 Jun 2017 03:07:35 -0700 (PDT)
In-Reply-To: <64E99F82-4E2B-4D53-8750-FCE90F84A29B@imgtec.com>
References: <1498144016-9111-1-git-send-email-chenhc@lemote.com>
 <1498144016-9111-3-git-send-email-chenhc@lemote.com> <20170628143005.GJ31455@jhogan-linux.le.imgtec.org>
 <CAAhV-H7+0v0TE=V29DVYtEhxN2fUjVhh9MP9gNV96jzkq_1yrg@mail.gmail.com> <64E99F82-4E2B-4D53-8750-FCE90F84A29B@imgtec.com>
From:   Huacai Chen <chenhc@lemote.com>
Date:   Thu, 29 Jun 2017 18:07:35 +0800
X-Google-Sender-Auth: sq41kXjvgRJzkZMVfGcNqY8eTRM
Message-ID: <CAAhV-H7f7iQtp2aqAXZKXVM7gHu3hWwbOgWL-8zTxhO1Z0Gd3A@mail.gmail.com>
Subject: Re: [PATCH V7 2/9] MIPS: c-r4k: Add r4k_blast_scache_node for Loongson-3
To:     James Hogan <james.hogan@imgtec.com>
Cc:     Linux MIPS Mailing List <linux-mips@linux-mips.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        John Crispin <john@phrozen.org>,
        "Steven J . Hill" <Steven.Hill@cavium.com>,
        Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>,
        stable <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Return-Path: <chenhuacai@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 58897
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: chenhc@lemote.com
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

Create arch/mips/include/asm/mach-malta/mmzone.h and put this line in it?
#define pa_to_nid(addr) 0

Huacai

On Thu, Jun 29, 2017 at 1:46 PM, James Hogan <james.hogan@imgtec.com> wrote:
> On 29 June 2017 02:33:28 BST, Huacai Chen <chenhc@lemote.com> wrote:
>>Hi, James,
>>
>>Is it suitable to add this line in arch/mips/include/asm/mmzone.h?
>>#define pa_to_nid(addr) 0
>
> It was basically malta_defconfig.
>
> OTOH when i tried including asm/mmzone.h, that tries including <mmzone.h> which it can't find.
>
> Cheers
> Jamee
>
>>
>>Huacai
>>
>>On Wed, Jun 28, 2017 at 10:30 PM, James Hogan <james.hogan@imgtec.com>
>>wrote:
>>> Hi Huacai,
>>>
>>> On Thu, Jun 22, 2017 at 11:06:49PM +0800, Huacai Chen wrote:
>>>> @@ -839,9 +860,12 @@ static void r4k_dma_cache_wback_inv(unsigned
>>long addr, unsigned long size)
>>>>
>>>>       preempt_disable();
>>>>       if (cpu_has_inclusive_pcaches) {
>>>> -             if (size >= scache_size)
>>>> -                     r4k_blast_scache();
>>>> -             else
>>>> +             if (size >= scache_size) {
>>>> +                     if (current_cpu_type() != CPU_LOONGSON3)
>>>> +                             r4k_blast_scache();
>>>> +                     else
>>>> +
>>r4k_blast_scache_node(pa_to_nid(addr));
>>>> +             } else
>>>>                       blast_scache_range(addr, addr + size);
>>>>               preempt_enable();
>>>>               __sync();
>>>> @@ -872,9 +896,12 @@ static void r4k_dma_cache_inv(unsigned long
>>addr, unsigned long size)
>>>>
>>>>       preempt_disable();
>>>>       if (cpu_has_inclusive_pcaches) {
>>>> -             if (size >= scache_size)
>>>> -                     r4k_blast_scache();
>>>> -             else {
>>>> +             if (size >= scache_size) {
>>>> +                     if (current_cpu_type() != CPU_LOONGSON3)
>>>> +                             r4k_blast_scache();
>>>> +                     else
>>>> +
>>r4k_blast_scache_node(pa_to_nid(addr));
>>>
>>> malta_defconfig now fails to build:
>>>
>>> arch/mips/mm/c-r4k.c: In function ‘r4k_dma_cache_wback_inv’:
>>> arch/mips/mm/c-r4k.c:867:5: error: implicit declaration of function
>>‘pa_to_nid’ [-Werror=implicit-function-declaration]
>>>      r4k_blast_scache_node(pa_to_nid(addr));
>>>      ^
>>>
>>> Cheers
>>> James
>
>
> --
> James Hogan
>
