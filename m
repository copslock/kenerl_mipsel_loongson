Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 29 Jun 2017 03:33:41 +0200 (CEST)
Received: from mail-io0-x230.google.com ([IPv6:2607:f8b0:4001:c06::230]:34707
        "EHLO mail-io0-x230.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992675AbdF2BdenAUvq convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 29 Jun 2017 03:33:34 +0200
Received: by mail-io0-x230.google.com with SMTP id r36so45719053ioi.1;
        Wed, 28 Jun 2017 18:33:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=kJqBM+rQO0OuWhZ8qRhT5IldSnadrfgiGyTg+/MzqFE=;
        b=bggiv3KwQilaDiQsUf8WK2jF6DH+f2GZC6eYkvlbVKefsxofJDbEQ2f2+xAe+Gl480
         tZ1uPCbXSjRBVCdG6nXAqgz1fPZQ5+Vw89I2pMOGjPW6hVY7r2VQYyaWt/HS9xPEyGe8
         9KE/1Xr7hDCHizRKZtbzjDPp+LMsOt7yfEbelOi5nKX/20WWS/hKaDQGapJmK50TY+rn
         pVUjbl+6mL8ZnJygGIXX/s51Ms+vPO89Bi0tJ/xqK5folOSJKipHD0ajP6rv56LZbNd8
         BAOlfqSXEfU6EQA/0ft5IYviJ3pMFX1MBFhKU3BKNsAPgj63KqmtcWjGcuYFBMYBVJ5j
         XAJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc:content-transfer-encoding;
        bh=kJqBM+rQO0OuWhZ8qRhT5IldSnadrfgiGyTg+/MzqFE=;
        b=WZYWz9Ymg/riK0/KL1E22tEf3HphxS0eF05GRL0M+GquMPANcaKB01Yc7Qp6NOdVs7
         yff6pb8txSzc6A/aWW1Oji+UkfhQLUH/Z3VYbCPcW5It4PojRJ8rOGr2sHvNz7XUmgKO
         RVpS/Va1bIHIQiC8LCT2hCXm1Fbtf7qUZVDTh7/MlHpC1Hdomldu7BS05UPQX6bD98Nu
         bEdAluhTHo1tf6Y84v1YRcWzW63wvpCLS1RWgkJbfrtKZS3EGGxtUZfr2+lVdoBVHe6o
         0P9ZSeWvblPLMl6Uj8HyJVXxYAp0xM2cPgP1VuFoxveDKWt9pNLSCS5Tgw+/VpjhnAsn
         cOQw==
X-Gm-Message-State: AKS2vOyhoFxIWKbYx4Q6DCeI2Pb+u34qigV2oQduRNg8Ll9lRi82RtFd
        dfppEGdf7oFcO5jzEKdW9tOGZbB7jA==
X-Received: by 10.107.205.193 with SMTP id d184mr16783024iog.188.1498700008872;
 Wed, 28 Jun 2017 18:33:28 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.144.85 with HTTP; Wed, 28 Jun 2017 18:33:28 -0700 (PDT)
In-Reply-To: <20170628143005.GJ31455@jhogan-linux.le.imgtec.org>
References: <1498144016-9111-1-git-send-email-chenhc@lemote.com>
 <1498144016-9111-3-git-send-email-chenhc@lemote.com> <20170628143005.GJ31455@jhogan-linux.le.imgtec.org>
From:   Huacai Chen <chenhc@lemote.com>
Date:   Thu, 29 Jun 2017 09:33:28 +0800
X-Google-Sender-Auth: M0i88JOwnWUhftuhjD6jeenHU6Q
Message-ID: <CAAhV-H7+0v0TE=V29DVYtEhxN2fUjVhh9MP9gNV96jzkq_1yrg@mail.gmail.com>
Subject: Re: [PATCH V7 2/9] MIPS: c-r4k: Add r4k_blast_scache_node for Loongson-3
To:     James Hogan <james.hogan@imgtec.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        John Crispin <john@phrozen.org>,
        "Steven J . Hill" <Steven.Hill@cavium.com>,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>,
        Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>,
        stable <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Return-Path: <chenhuacai@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 58889
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

Hi, James,

Is it suitable to add this line in arch/mips/include/asm/mmzone.h?
#define pa_to_nid(addr) 0

Huacai

On Wed, Jun 28, 2017 at 10:30 PM, James Hogan <james.hogan@imgtec.com> wrote:
> Hi Huacai,
>
> On Thu, Jun 22, 2017 at 11:06:49PM +0800, Huacai Chen wrote:
>> @@ -839,9 +860,12 @@ static void r4k_dma_cache_wback_inv(unsigned long addr, unsigned long size)
>>
>>       preempt_disable();
>>       if (cpu_has_inclusive_pcaches) {
>> -             if (size >= scache_size)
>> -                     r4k_blast_scache();
>> -             else
>> +             if (size >= scache_size) {
>> +                     if (current_cpu_type() != CPU_LOONGSON3)
>> +                             r4k_blast_scache();
>> +                     else
>> +                             r4k_blast_scache_node(pa_to_nid(addr));
>> +             } else
>>                       blast_scache_range(addr, addr + size);
>>               preempt_enable();
>>               __sync();
>> @@ -872,9 +896,12 @@ static void r4k_dma_cache_inv(unsigned long addr, unsigned long size)
>>
>>       preempt_disable();
>>       if (cpu_has_inclusive_pcaches) {
>> -             if (size >= scache_size)
>> -                     r4k_blast_scache();
>> -             else {
>> +             if (size >= scache_size) {
>> +                     if (current_cpu_type() != CPU_LOONGSON3)
>> +                             r4k_blast_scache();
>> +                     else
>> +                             r4k_blast_scache_node(pa_to_nid(addr));
>
> malta_defconfig now fails to build:
>
> arch/mips/mm/c-r4k.c: In function ‘r4k_dma_cache_wback_inv’:
> arch/mips/mm/c-r4k.c:867:5: error: implicit declaration of function ‘pa_to_nid’ [-Werror=implicit-function-declaration]
>      r4k_blast_scache_node(pa_to_nid(addr));
>      ^
>
> Cheers
> James
