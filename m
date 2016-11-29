Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 29 Nov 2016 01:47:18 +0100 (CET)
Received: from mail-pg0-f48.google.com ([74.125.83.48]:34457 "EHLO
        mail-pg0-f48.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993219AbcK2ArK4iVPR (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 29 Nov 2016 01:47:10 +0100
Received: by mail-pg0-f48.google.com with SMTP id x23so62604057pgx.1
        for <linux-mips@linux-mips.org>; Mon, 28 Nov 2016 16:47:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=android.com; s=20120917;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=4VCaVfY+ijXif5smWLjb4L1t0rysFM5gQuMrDXFqQ+k=;
        b=Gz8y4QaSK4aDqAWI15nbkWkQw4JBNJ/t5bqlYW4pTxDq/4IAVOFeTITdzPkRzSR8Cr
         MtaSpNvO2LlLAzD9DtpPOo1gAWxC9+Irg06TGhC/dDWwvg+CLq4SrTdQREzJM66V8bfU
         sDVPNjgHnHVlCVJatFmI9byRqRs94bUAflO+9ZfH2CZ7k5h1l5+JkhU2TuGTTZ4TKvj3
         7lIsPOl74AbkmQDr3Qm3LlhWrMMHhamsVNyABqIFKW3xKB0H1LY2AVa1vGuLyJbZp3b5
         QG/sWu4lAUM2lXJaM2+tbdtD0WbOFhwVkZ2VwVV7VwQZSwH/ASeJ/BkqXjYlAyOjAHec
         zLyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=4VCaVfY+ijXif5smWLjb4L1t0rysFM5gQuMrDXFqQ+k=;
        b=Mq1MF5OLAzuA3+sYvhJA+quNHah4qvJ+XPOmxBzNGaQ9HNsja2j5PAY6TJE6sSzvpp
         zRm/NV1QAjf1M32i7ww0FHgWON/vlxPPU2Xp/yqSgEace+xt79T/EQnJYVAN82wHVfZN
         +wdzpDkUTJynKaBDfi4TKxwQLENdqDe8vU7OveEKLw7XSBN6idZeXNWoQGrpsYkUf97K
         oLQuZFTHBpojvhAyrVwsLiEu4EMaKgB5P5ZxbybKVc3n3mKoWZSFVz2yfpCI5CGrXeKn
         13o68edzWOuzMf9On9jc8QLZ8TlKhu7HTwsSekTVx/DZ0W3syhPGtwBZ0QPjI07aspS+
         B7FA==
X-Gm-Message-State: AKaTC01IT1OBGRWBfHMceD5gvxrVwY3hmK5tvslbNasHzE2qujPGyo4673mEf1fMWpro+g==
X-Received: by 10.84.141.129 with SMTP id 1mr55800855plv.102.1480380424972;
        Mon, 28 Nov 2016 16:47:04 -0800 (PST)
Received: from dcashman-macbookpro.roam.corp.google.com ([172.26.48.249])
        by smtp.gmail.com with ESMTPSA id a22sm89921140pfg.7.2016.11.28.16.47.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 28 Nov 2016 16:47:04 -0800 (PST)
Subject: Re: [PATCH] MIPS: Add support for ARCH_MMAP_RND_{COMPAT_}BITS
To:     Kees Cook <keescook@chromium.org>,
        Matt Redfearn <matt.redfearn@imgtec.com>
References: <1480008765-3876-1-git-send-email-matt.redfearn@imgtec.com>
 <CAGXu5jLT-V3+3_KSAfxbN3yY22xRh3tvs1wpL+mwk1En8MC6Bg@mail.gmail.com>
 <a8dd7013-979a-6352-cc75-68383a111ff0@imgtec.com>
 <CAGXu5j+VNnaVtARQL=Xcdy3jtd+Tt+Akp5gKHOu5hvVRfiSbyg@mail.gmail.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>,
        "kernel-hardening@lists.openwall.com" 
        <kernel-hardening@lists.openwall.com>,
        Paul Gortmaker <paul.gortmaker@windriver.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
From:   Dan Cashman <dcashman@android.com>
Message-ID: <74bc3b7a-d2ed-0865-e07a-e9e5da65710f@android.com>
Date:   Mon, 28 Nov 2016 16:47:03 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.11; rv:45.0)
 Gecko/20100101 Thunderbird/45.5.0
MIME-Version: 1.0
In-Reply-To: <CAGXu5j+VNnaVtARQL=Xcdy3jtd+Tt+Akp5gKHOu5hvVRfiSbyg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <dcashman@android.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 55906
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dcashman@android.com
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

As can be seen from the following comment in arch/arm64/Kconfig:
""
# max bits determined by the following formula:
#  VA_BITS - PAGE_SHIFT - 3
config ARCH_MMAP_RND_BITS_MAX
"""

The max value was determined based on the available address space 
(VA_BITS - PAGE_SHIFT) and an account of how far mmap_base could be 
moved (the "- 3" part).  MIPS uses the same calculation for the MAX_GAP 
in arch/mips/mm/mmap.c, namely 5/6 the TASK_SIZE, so I'd expect a 
similar formula for MIPS from a cursory first-glance.

These values likely will stick, so it'd be best to get them to be as 
large as possible from the get-go.  I imagine something similar to ARM64 
would be set up based on the following in 
arch/mips/include/asm/processor.h, but of course defer to the mips 
maintainer:

"""
#ifdef CONFIG_MIPS_VA_BITS_48
#define TASK_SIZE64     (0x1UL << 
((cpu_data[0].vmbits>48)?48:cpu_data[0].vmbits))
#else
#define TASK_SIZE64     0x10000000000UL
#endif
"""

Thanks,
Dan

On 11/28/16 10:17 AM, Kees Cook wrote:
> On Mon, Nov 28, 2016 at 8:10 AM, Matt Redfearn <matt.redfearn@imgtec.com> wrote:
>> Hi Kees
>>
>>
>>
>> On 25/11/16 20:00, Kees Cook wrote:
>>>
>>> On Thu, Nov 24, 2016 at 9:32 AM, Matt Redfearn <matt.redfearn@imgtec.com>
>>> wrote:
>>>>
>>>> arch_mmap_rnd() uses hard-coded limits of 16MB for the randomisation
>>>> of mmap within 32bit processes and 256MB in 64bit processes. Since v4.4
>>>> other arches support tuning this value in /proc/sys/vm/mmap_rnd_bits.
>>>> Add support for this to MIPS.
>>>>
>>>> Set the minimum(default) number of bits randomisation for 32bit to 8 -
>>>> which with 4k pagesize is unchanged from the current 16MB total
>>>> randomness. The minimum(default) for 64bit is 12bits, again with 4k
>>>> pagesize this is the same as the current 256MB.
>>>>
>>>> This patch is necessary for MIPS32 to pass the Android CTS tests, with
>>>> the number of random bits set to 15.
>>>>
>>>> Signed-off-by: Matt Redfearn <matt.redfearn@imgtec.com>
>>>> ---
>>>>
>>>>   arch/mips/Kconfig   | 16 ++++++++++++++++
>>>>   arch/mips/mm/mmap.c | 10 +++++-----
>>>>   2 files changed, 21 insertions(+), 5 deletions(-)
>>>>
>>>> diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
>>>> index b3c5bde43d34..d72cf6129b2c 100644
>>>> --- a/arch/mips/Kconfig
>>>> +++ b/arch/mips/Kconfig
>>>> @@ -13,6 +13,8 @@ config MIPS
>>>>          select HAVE_PERF_EVENTS
>>>>          select PERF_USE_VMALLOC
>>>>          select HAVE_ARCH_KGDB
>>>> +       select HAVE_ARCH_MMAP_RND_BITS if MMU
>>>> +       select HAVE_ARCH_MMAP_RND_COMPAT_BITS if MMU && COMPAT
>>>>          select HAVE_ARCH_SECCOMP_FILTER
>>>>          select HAVE_ARCH_TRACEHOOK
>>>>          select HAVE_CBPF_JIT if !CPU_MICROMIPS
>>>> @@ -3073,6 +3075,20 @@ config MMU
>>>>          bool
>>>>          default y
>>>>
>>>> +config ARCH_MMAP_RND_BITS_MIN
>>>> +       default 12 if 64BIT
>>>> +       default 8
>>>> +
>>>> +config ARCH_MMAP_RND_BITS_MAX
>>>> +       default 18 if 64BIT
>>>> +       default 15
>>>> +
>>>> +config ARCH_MMAP_RND_COMPAT_BITS_MIN
>>>> +       default 8
>>>> +
>>>> +config ARCH_MMAP_RND_COMPAT_BITS_MAX
>>>> +       default 15
>>>> +
>>>>   config I8253
>>>>          bool
>>>>          select CLKSRC_I8253
>>>> diff --git a/arch/mips/mm/mmap.c b/arch/mips/mm/mmap.c
>>>> index d08ea3ff0f53..d6d92c02308d 100644
>>>> --- a/arch/mips/mm/mmap.c
>>>> +++ b/arch/mips/mm/mmap.c
>>>> @@ -146,14 +146,14 @@ unsigned long arch_mmap_rnd(void)
>>>>   {
>>>>          unsigned long rnd;
>>>>
>>>> -       rnd = get_random_long();
>>>> -       rnd <<= PAGE_SHIFT;
>>>> +#ifdef CONFIG_COMPAT
>>>>          if (TASK_IS_32BIT_ADDR)
>>>> -               rnd &= 0xfffffful;
>>>> +               rnd = get_random_long() & ((1UL << mmap_rnd_compat_bits)
>>>> - 1);
>>>>          else
>>>> -               rnd &= 0xffffffful;
>>>> +#endif /* CONFIG_COMPAT */
>>>> +               rnd = get_random_long() & ((1UL << mmap_rnd_bits) - 1);
>>>>
>>>> -       return rnd;
>>>> +       return rnd << PAGE_SHIFT;
>>>>   }
>>>>
>>>>   void arch_pick_mmap_layout(struct mm_struct *mm)
>>>> --
>>>> 2.7.4
>>>>
>>> Excellent!
>>>
>>> Reviewed-by: Kees Cook <keescook@chromium.org>
>>>
>>> Out of curiosity, how were the maxs of 15 and 18 chosen?
>>
>>
>> The maximum of 15 bits for 32 bit processes was the minimum required to pass
>> the Android CTS tests with Nougat using 4k pages, but with 64k pages would
>> be on the limit of the virtual address space. For 64 bit processes, I just
>> allowed an 3 extra bits of randomness within the larger virtual address
>> space, similar to the ARM64 limit.
>
> arm64's limit depends on the VA size. What does MIPS's 64-bit VA space
> look like? e.g. by default on arm64 with 4k pages, the VA space is 39
> bits, which gives 24 bits of entropy (rather than 18 here, which seems
> low to me for a 64-bit userspace).
>
> -Kees
>
