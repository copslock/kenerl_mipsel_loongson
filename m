Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 28 Nov 2016 17:10:56 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:2464 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23992847AbcK1QKtFMvA2 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 28 Nov 2016 17:10:49 +0100
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id 47EA78ABA2E9D;
        Mon, 28 Nov 2016 16:10:39 +0000 (GMT)
Received: from [10.150.130.83] (10.150.130.83) by HHMAIL01.hh.imgtec.org
 (10.100.10.21) with Microsoft SMTP Server (TLS) id 14.3.294.0; Mon, 28 Nov
 2016 16:10:41 +0000
Subject: Re: [PATCH] MIPS: Add support for ARCH_MMAP_RND_{COMPAT_}BITS
To:     Kees Cook <keescook@chromium.org>
References: <1480008765-3876-1-git-send-email-matt.redfearn@imgtec.com>
 <CAGXu5jLT-V3+3_KSAfxbN3yY22xRh3tvs1wpL+mwk1En8MC6Bg@mail.gmail.com>
CC:     Ralf Baechle <ralf@linux-mips.org>,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>,
        "kernel-hardening@lists.openwall.com" 
        <kernel-hardening@lists.openwall.com>,
        Paul Gortmaker <paul.gortmaker@windriver.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Daniel Cashman <dcashman@android.com>,
        Andrew Morton <akpm@linux-foundation.org>
From:   Matt Redfearn <matt.redfearn@imgtec.com>
Message-ID: <a8dd7013-979a-6352-cc75-68383a111ff0@imgtec.com>
Date:   Mon, 28 Nov 2016 16:10:39 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
MIME-Version: 1.0
In-Reply-To: <CAGXu5jLT-V3+3_KSAfxbN3yY22xRh3tvs1wpL+mwk1En8MC6Bg@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.150.130.83]
Return-Path: <Matt.Redfearn@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 55904
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: matt.redfearn@imgtec.com
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

Hi Kees


On 25/11/16 20:00, Kees Cook wrote:
> On Thu, Nov 24, 2016 at 9:32 AM, Matt Redfearn <matt.redfearn@imgtec.com> wrote:
>> arch_mmap_rnd() uses hard-coded limits of 16MB for the randomisation
>> of mmap within 32bit processes and 256MB in 64bit processes. Since v4.4
>> other arches support tuning this value in /proc/sys/vm/mmap_rnd_bits.
>> Add support for this to MIPS.
>>
>> Set the minimum(default) number of bits randomisation for 32bit to 8 -
>> which with 4k pagesize is unchanged from the current 16MB total
>> randomness. The minimum(default) for 64bit is 12bits, again with 4k
>> pagesize this is the same as the current 256MB.
>>
>> This patch is necessary for MIPS32 to pass the Android CTS tests, with
>> the number of random bits set to 15.
>>
>> Signed-off-by: Matt Redfearn <matt.redfearn@imgtec.com>
>> ---
>>
>>   arch/mips/Kconfig   | 16 ++++++++++++++++
>>   arch/mips/mm/mmap.c | 10 +++++-----
>>   2 files changed, 21 insertions(+), 5 deletions(-)
>>
>> diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
>> index b3c5bde43d34..d72cf6129b2c 100644
>> --- a/arch/mips/Kconfig
>> +++ b/arch/mips/Kconfig
>> @@ -13,6 +13,8 @@ config MIPS
>>          select HAVE_PERF_EVENTS
>>          select PERF_USE_VMALLOC
>>          select HAVE_ARCH_KGDB
>> +       select HAVE_ARCH_MMAP_RND_BITS if MMU
>> +       select HAVE_ARCH_MMAP_RND_COMPAT_BITS if MMU && COMPAT
>>          select HAVE_ARCH_SECCOMP_FILTER
>>          select HAVE_ARCH_TRACEHOOK
>>          select HAVE_CBPF_JIT if !CPU_MICROMIPS
>> @@ -3073,6 +3075,20 @@ config MMU
>>          bool
>>          default y
>>
>> +config ARCH_MMAP_RND_BITS_MIN
>> +       default 12 if 64BIT
>> +       default 8
>> +
>> +config ARCH_MMAP_RND_BITS_MAX
>> +       default 18 if 64BIT
>> +       default 15
>> +
>> +config ARCH_MMAP_RND_COMPAT_BITS_MIN
>> +       default 8
>> +
>> +config ARCH_MMAP_RND_COMPAT_BITS_MAX
>> +       default 15
>> +
>>   config I8253
>>          bool
>>          select CLKSRC_I8253
>> diff --git a/arch/mips/mm/mmap.c b/arch/mips/mm/mmap.c
>> index d08ea3ff0f53..d6d92c02308d 100644
>> --- a/arch/mips/mm/mmap.c
>> +++ b/arch/mips/mm/mmap.c
>> @@ -146,14 +146,14 @@ unsigned long arch_mmap_rnd(void)
>>   {
>>          unsigned long rnd;
>>
>> -       rnd = get_random_long();
>> -       rnd <<= PAGE_SHIFT;
>> +#ifdef CONFIG_COMPAT
>>          if (TASK_IS_32BIT_ADDR)
>> -               rnd &= 0xfffffful;
>> +               rnd = get_random_long() & ((1UL << mmap_rnd_compat_bits) - 1);
>>          else
>> -               rnd &= 0xffffffful;
>> +#endif /* CONFIG_COMPAT */
>> +               rnd = get_random_long() & ((1UL << mmap_rnd_bits) - 1);
>>
>> -       return rnd;
>> +       return rnd << PAGE_SHIFT;
>>   }
>>
>>   void arch_pick_mmap_layout(struct mm_struct *mm)
>> --
>> 2.7.4
>>
> Excellent!
>
> Reviewed-by: Kees Cook <keescook@chromium.org>
>
> Out of curiosity, how were the maxs of 15 and 18 chosen?

The maximum of 15 bits for 32 bit processes was the minimum required to 
pass the Android CTS tests with Nougat using 4k pages, but with 64k 
pages would be on the limit of the virtual address space. For 64 bit 
processes, I just allowed an 3 extra bits of randomness within the 
larger virtual address space, similar to the ARM64 limit.

Thanks,
Matt


>
> -Kees
>
