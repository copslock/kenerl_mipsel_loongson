Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 28 Nov 2016 19:18:11 +0100 (CET)
Received: from mail-io0-f174.google.com ([209.85.223.174]:34013 "EHLO
        mail-io0-f174.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992544AbcK1SSCKiewx (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 28 Nov 2016 19:18:02 +0100
Received: by mail-io0-f174.google.com with SMTP id c21so235764789ioj.1
        for <linux-mips@linux-mips.org>; Mon, 28 Nov 2016 10:18:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=o/WBvB1+gD5NKEs23HPwWhQard1znURY2292zm4QPzA=;
        b=MtykTf1qaiOaqr7fBVbFM1VscVUaIflyzYiwgi1S5WaqbmdfKyMJbpSfG4Ij5LLUYd
         s7MddQxHmC1hXAjjNEhDcrZUwaFcFnV6KCfPRoKmSLFWl+x+Nn6MUxtjVo80o1LChnSe
         wevF0fZBzLzGk29dggCV+C1zvzmdAMx+dRhPl4QL4hI79LeO+9J2MErHQuTmrEbXxwX0
         6QOQsyHdoTRXzx+k0vwG9Y6j7bd51DPPzMLEllzpUYB9JFTFl3r9AJ9MWFNJvCs5ub5T
         yFF2zj1zFX3cOL3+pheI9u4/zW0Etv565z0jUbt2Us6xhnMGweU31LgJW0zlAtRCOJpn
         ao3g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=o/WBvB1+gD5NKEs23HPwWhQard1znURY2292zm4QPzA=;
        b=HT8c7hV0Sx1vOLp+Dx4lIsncflfseKoGJqydR5FGvZ9VakM5VJDZ49oiqS3ogQSPg2
         3m5RmI3hXZbt20XKzn3tGYa0WoCxkCTEqXz6C029yVFlcsX0NDVlMdfWxv+mqkArLDpf
         fUvr0DSn6R9LbPy+ZJnyOf4J5hkTsM/Fg4dEI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=o/WBvB1+gD5NKEs23HPwWhQard1znURY2292zm4QPzA=;
        b=W+5P/VDco8iDDi+O7TVTHHCMyeBpfO3o71y0XakXTwfCt8vKrMpRlQAczgXyeZ646A
         bSTPirsXlHRyVggypYCL3LRurQ8/2FW7JqvTFZz6u+r4FGQjX5JwzI2y9CpJsIYERMK0
         vwzn0bzIEX0NjTYhTCqCmHuLNjV/DtMpLQEwEBTZE0sRbZEegXEnV5PJ08DfozfkQDuE
         AP+N/G4lcw7IBVYfwZnF5KmYTt0mokLORISp7pOgxuA//e7ozdNreLA5lI+oHCK8RWUh
         Vzukr/TsmXRSQPTFXiFUcgESQoKuL2MWRijfyXviLq3wut3AUxghPrHcRG6zyNZ+r/jg
         OaKw==
X-Gm-Message-State: AKaTC01bD3Y2ZUkOkLYs18MrKxC0kWVFcLZPpZgmkk/4sK5/lh3TD/8FxjSWfpCkxDlMUzO8e8W4+WQf2eSebr0J
X-Received: by 10.107.32.141 with SMTP id g135mr12445047iog.96.1480357073173;
 Mon, 28 Nov 2016 10:17:53 -0800 (PST)
MIME-Version: 1.0
Received: by 10.107.161.201 with HTTP; Mon, 28 Nov 2016 10:17:52 -0800 (PST)
In-Reply-To: <a8dd7013-979a-6352-cc75-68383a111ff0@imgtec.com>
References: <1480008765-3876-1-git-send-email-matt.redfearn@imgtec.com>
 <CAGXu5jLT-V3+3_KSAfxbN3yY22xRh3tvs1wpL+mwk1En8MC6Bg@mail.gmail.com> <a8dd7013-979a-6352-cc75-68383a111ff0@imgtec.com>
From:   Kees Cook <keescook@chromium.org>
Date:   Mon, 28 Nov 2016 10:17:52 -0800
X-Google-Sender-Auth: xpLla7KEQhPohyqOBgcowUV4mFA
Message-ID: <CAGXu5j+VNnaVtARQL=Xcdy3jtd+Tt+Akp5gKHOu5hvVRfiSbyg@mail.gmail.com>
Subject: Re: [PATCH] MIPS: Add support for ARCH_MMAP_RND_{COMPAT_}BITS
To:     Matt Redfearn <matt.redfearn@imgtec.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>,
        "kernel-hardening@lists.openwall.com" 
        <kernel-hardening@lists.openwall.com>,
        Paul Gortmaker <paul.gortmaker@windriver.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Daniel Cashman <dcashman@android.com>,
        Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset=UTF-8
Return-Path: <keescook@google.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 55905
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: keescook@chromium.org
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

On Mon, Nov 28, 2016 at 8:10 AM, Matt Redfearn <matt.redfearn@imgtec.com> wrote:
> Hi Kees
>
>
>
> On 25/11/16 20:00, Kees Cook wrote:
>>
>> On Thu, Nov 24, 2016 at 9:32 AM, Matt Redfearn <matt.redfearn@imgtec.com>
>> wrote:
>>>
>>> arch_mmap_rnd() uses hard-coded limits of 16MB for the randomisation
>>> of mmap within 32bit processes and 256MB in 64bit processes. Since v4.4
>>> other arches support tuning this value in /proc/sys/vm/mmap_rnd_bits.
>>> Add support for this to MIPS.
>>>
>>> Set the minimum(default) number of bits randomisation for 32bit to 8 -
>>> which with 4k pagesize is unchanged from the current 16MB total
>>> randomness. The minimum(default) for 64bit is 12bits, again with 4k
>>> pagesize this is the same as the current 256MB.
>>>
>>> This patch is necessary for MIPS32 to pass the Android CTS tests, with
>>> the number of random bits set to 15.
>>>
>>> Signed-off-by: Matt Redfearn <matt.redfearn@imgtec.com>
>>> ---
>>>
>>>   arch/mips/Kconfig   | 16 ++++++++++++++++
>>>   arch/mips/mm/mmap.c | 10 +++++-----
>>>   2 files changed, 21 insertions(+), 5 deletions(-)
>>>
>>> diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
>>> index b3c5bde43d34..d72cf6129b2c 100644
>>> --- a/arch/mips/Kconfig
>>> +++ b/arch/mips/Kconfig
>>> @@ -13,6 +13,8 @@ config MIPS
>>>          select HAVE_PERF_EVENTS
>>>          select PERF_USE_VMALLOC
>>>          select HAVE_ARCH_KGDB
>>> +       select HAVE_ARCH_MMAP_RND_BITS if MMU
>>> +       select HAVE_ARCH_MMAP_RND_COMPAT_BITS if MMU && COMPAT
>>>          select HAVE_ARCH_SECCOMP_FILTER
>>>          select HAVE_ARCH_TRACEHOOK
>>>          select HAVE_CBPF_JIT if !CPU_MICROMIPS
>>> @@ -3073,6 +3075,20 @@ config MMU
>>>          bool
>>>          default y
>>>
>>> +config ARCH_MMAP_RND_BITS_MIN
>>> +       default 12 if 64BIT
>>> +       default 8
>>> +
>>> +config ARCH_MMAP_RND_BITS_MAX
>>> +       default 18 if 64BIT
>>> +       default 15
>>> +
>>> +config ARCH_MMAP_RND_COMPAT_BITS_MIN
>>> +       default 8
>>> +
>>> +config ARCH_MMAP_RND_COMPAT_BITS_MAX
>>> +       default 15
>>> +
>>>   config I8253
>>>          bool
>>>          select CLKSRC_I8253
>>> diff --git a/arch/mips/mm/mmap.c b/arch/mips/mm/mmap.c
>>> index d08ea3ff0f53..d6d92c02308d 100644
>>> --- a/arch/mips/mm/mmap.c
>>> +++ b/arch/mips/mm/mmap.c
>>> @@ -146,14 +146,14 @@ unsigned long arch_mmap_rnd(void)
>>>   {
>>>          unsigned long rnd;
>>>
>>> -       rnd = get_random_long();
>>> -       rnd <<= PAGE_SHIFT;
>>> +#ifdef CONFIG_COMPAT
>>>          if (TASK_IS_32BIT_ADDR)
>>> -               rnd &= 0xfffffful;
>>> +               rnd = get_random_long() & ((1UL << mmap_rnd_compat_bits)
>>> - 1);
>>>          else
>>> -               rnd &= 0xffffffful;
>>> +#endif /* CONFIG_COMPAT */
>>> +               rnd = get_random_long() & ((1UL << mmap_rnd_bits) - 1);
>>>
>>> -       return rnd;
>>> +       return rnd << PAGE_SHIFT;
>>>   }
>>>
>>>   void arch_pick_mmap_layout(struct mm_struct *mm)
>>> --
>>> 2.7.4
>>>
>> Excellent!
>>
>> Reviewed-by: Kees Cook <keescook@chromium.org>
>>
>> Out of curiosity, how were the maxs of 15 and 18 chosen?
>
>
> The maximum of 15 bits for 32 bit processes was the minimum required to pass
> the Android CTS tests with Nougat using 4k pages, but with 64k pages would
> be on the limit of the virtual address space. For 64 bit processes, I just
> allowed an 3 extra bits of randomness within the larger virtual address
> space, similar to the ARM64 limit.

arm64's limit depends on the VA size. What does MIPS's 64-bit VA space
look like? e.g. by default on arm64 with 4k pages, the VA space is 39
bits, which gives 24 bits of entropy (rather than 18 here, which seems
low to me for a 64-bit userspace).

-Kees

-- 
Kees Cook
Nexus Security
