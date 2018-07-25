Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 25 Jul 2018 21:57:54 +0200 (CEST)
Received: from mail-lj1-f196.google.com ([209.85.208.196]:40952 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992479AbeGYT5s7YvT6 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 25 Jul 2018 21:57:48 +0200
Received: by mail-lj1-f196.google.com with SMTP id j19-v6so7738813ljc.7
        for <linux-mips@linux-mips.org>; Wed, 25 Jul 2018 12:57:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=ZnyVhMnjQ9csP7PYxV6MEMFN9O1jEC27W6pJFE9lcaw=;
        b=jRxkrsI5KxyVZeN0Qovo2OCDunO1QXpktGradWUivLcmje8YgUmCi1EirdvosiwdFq
         xE4NX6s7ndTp1m2sWV9Jd4xlFHsDnxUhRwzzgQ1J0RTv+QeSidvDUBvpNh1OOH3Sn2+3
         Oc9I+j41eC8XmEUCfVDKoNKq8aY1gsGL6ED0OnW4FMMyGnHNL2urAm2l0WTFwGR+0rKM
         dkgx1XC/IeC/JrODU3jpEI3J2ZVLKPyaVbTUpr7OtlgMBkcdyqs7y+bujC0bqiGIOBTC
         mX3kRRmNP2TMlELYBwW0qZ545pyrDf8I3yyB1Cjw68jdOIv/O3jiQwFU3bhSwREos0JG
         NZRQ==
X-Gm-Message-State: AOUpUlGFmAiZOluO3JCLsuGZI9rk8VUbH+pQyU6vuJ65pJ+AZbHmNad1
        F6J6oCXMo1n98T+0eYlZexFJWS5+zkc4AuOtNDxFeg==
X-Google-Smtp-Source: AAOMgpeI2ciBq+DLU6KbKiAk0vrP+48+kTaHIbx2qPhYWk2ZUTVxwqzhLF0cEGL6N1DIhmt0rhmE5me+G9lK9Yfj6o4=
X-Received: by 2002:a2e:4557:: with SMTP id s84-v6mr15981493lja.47.1532548663318;
 Wed, 25 Jul 2018 12:57:43 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a2e:81a:0:0:0:0:0 with HTTP; Wed, 25 Jul 2018 12:57:42 -0700 (PDT)
In-Reply-To: <9c4d7c8d-3f0b-ff2f-68e8-03638a5fe2a4@arm.com>
References: <1531949864-27447-1-git-send-email-bhsharma@redhat.com>
 <d8959ca1-65a1-f59c-bfc4-b048c75add26@arm.com> <CACi5LpOa-BMRSTShS019DDv7MoxNfpnnsqjwR3z13GZC49NrSA@mail.gmail.com>
 <9c4d7c8d-3f0b-ff2f-68e8-03638a5fe2a4@arm.com>
From:   Bhupesh Sharma <bhsharma@redhat.com>
Date:   Thu, 26 Jul 2018 01:27:42 +0530
Message-ID: <CACi5LpM9sc+c1M_dAEL9z+Sw6t0Wi1CsQ=M4E1nbQ4RRnkysRw@mail.gmail.com>
Subject: Re: [PATCH] arm64, kaslr: export offset in VMCOREINFO ELF notes
To:     James Morse <james.morse@arm.com>
Cc:     linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        kexec mailing list <kexec@lists.infradead.org>,
        Bhupesh SHARMA <bhupesh.linux@gmail.com>,
        AKASHI Takahiro <takahiro.akashi@linaro.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Will Deacon <will.deacon@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        linux-mips@linux-mips.org
Content-Type: text/plain; charset="UTF-8"
Return-Path: <bhsharma@redhat.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 65147
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: bhsharma@redhat.com
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

Hello James,

On Mon, Jul 23, 2018 at 10:35 PM, James Morse <james.morse@arm.com> wrote:
> Hi Bhupesh,
>
> (CC: +mips list, looks like mips is missing vmcore's KERNELOFFSET too.
> Start of this thread: https://lkml.org/lkml/2018/7/18/951 )

Yes, but the current upstream makedumpfile doesn't seem to contain
mips specific support (please see
<git://git.code.sf.net/p/makedumpfile/code> for details), so I am not
sure they need the 'KERNELOFFSET=' supported in kernel as they are
probably not using it in the user-space.

If someone from the mips list can help suggest if my understanding is
correct it would be great. Just as a side note, I don't have access to
mips hardware, so I will be happy to update the v2 to add mips kernel
bits as well, in case someone is willing to give it a try on their
mips hardware.

> On 19/07/18 15:55, Bhupesh Sharma wrote:
>> On Thu, Jul 19, 2018 at 5:01 PM, James Morse <james.morse@arm.com> wrote:
>>> On 18/07/18 22:37, Bhupesh Sharma wrote:
>>>> Include KASLR offset in VMCOREINFO ELF notes to assist in debugging.
>>>>
>>>> makedumpfile user-space utility will need fixup to use this KASLR offset
>>>> to work with cases where we need to find a way to translate symbol
>>>> address from vmlinux to kernel run time address in case of KASLR boot on
>>>> arm64.
>>>
>>> You need the kernel VA for a symbol. Isn't this what kallsyms is for?
>>> | root@frikadeller:~# cat /proc/kallsyms | grep swapper_pg_dir
>>> | ffff5404610d0000 B swapper_pg_dir
>
>> Its already used by other archs like x86_64.
>> Its just that we are enabling this feature for arm64 now that the
>> KASLR boot cases are more widely seen on arm64 boards (as newer EFI
>> firmware implementations are available which support EFI_RNG_PROTOCOL
>> and hence KASLR boot).
>>
>> And we want existing user-space application(s) to work similarly on
>> arm64 distributions as they work historically on other archs like
>> x86_64 (in most cases the user-space user is not even aware, if he is
>> developing for or using an underlying hardware which is arm64 or
>> x86_64)
>
> Aha, so its ABI. This is the information that should be in the commit message as
> it describes why this patch should be merged.

Sure, will add the description in the commit message of v2.

> ... Ideally core code would do this, that way this information won't be missed
> when an architecture adds KASLR support.
>
> But mips has CONFIG_RANDOMIZE_BASE, and doesn't provide kaslr_offset(),
> and x86 always provides this value, not just if CONFIG_RANDOMIZE_BASE is
> selected. I can't see a way to do this without touching all three architectures.
> (we can try and tidy it up once its clear whether mips needs this too)

Yes, I checked internally at Red Hat and no use-cases for mips
surfaced for this feature. So, if someone from the mips list can help
clarify, it will help me re-write the v2 accordingly.

> I think the patch is fine, but could you re-post it with a commit message that
> describes that vmcore parsing in user-space already expects this value in the
> notes. We're providing it for portability of those existing tools with x86.

Sure.

>>> I picked swapper_pg_dir, but you could use any of the vmcore:SYMBOL() addresses
>>> to work out this offset. (you should expect the kernel to rename these symbols
>>> at a whim).
>>>
>>
>> Perhaps you missed what the above makedumpfile command was doing, so
>> let me summarize again:
>
> Yes, I glossed over it, all that seemed relevant is you are trying to find the
> kernel-va of a symbol from the value in the vmlinux.

Yes, that's correct.

>
>> as it breaks the
>> existing user-space use-cases and the .conf file can be user-defined
>> (and hence he can pick any symbol/functions
>
> My suggestion was you can calculate the offset between the link-time and
> run-time address from information you already have. You just need one of each.
> This would be better as its independent of how the kernel does the relocation.
>
> But, this is irrelevant as 'KERNELOFFSET=' is already an ABI string.

Indeed. We would like to have ABI strings similar across archs.

>> which might not even be present in 'kallsyms').
>
> Eh? How can that happen? I thought even modules had their symbols added to kallsyms.

Sorry, when I re-read my reply, I think I did not explain it better in
terms of the distribution use-cases we usually encounter. Let me try
again:

One of the reason is that existing user-space implementations (for
archs like x86_64), historically use 'vmlinux' for filtering of
symbols from 'vmcore'.

Usually when an end-user uses a distribution kernel on their hardware
and face issues with it, they share the 'vmcore' (crash dump) and
'vmlinux' with the distribution provider. 'vmlinux' can be used by
utilities like gdb/crash-utility to debug the reason for kernel crash.

Let's assume, even if the user manages to save the 'kallsyms' on some
external media (e.g. usb stick) when the kernel crashed, since the
symbol addresses in 'kallsyms' change on each boot (as KASLR
randomizes the same), so we cannot use 'KERNELOFFSET=' to calculate
kaslr offset to the symbols reliably.

For example, let me share the following values of a real use-case:

Let's saw we are looking to find and erase the symbol 'jiffies' from
the vmcore, using (1) - vmlinux and (2) - kallsyms:

(1) vmlinux - Address of 'jiffies' -> 0xffff000009291980
(2) kallsyms - Address of 'jiffies' -> 0xffff4ce385291980 (value seen
during the boot when primary kernel crashed)

In this particular boot, makedumpfile reports 'kaslr_offset' as 0x2934e3000000
So, if we use:
(1) vmlinux - We calculate Address of 'jiffies' as ->
0xffff000009291980 + 0x2934e3000000 = 0xFFFF2934EC291980
(2) kallsyms - We calculate Address of 'jiffies' as ->
0xffff4ce385291980 + 0x2934e3000000 = 0xFFFF761868291980

When we check the 'vmcore' we can see that the address of 'jiffies' is
indeed 0xFFFF2934EC291980 and not 0xFFFF761868291980:

crash> sym jiffies
ffff2934ec291980 (D) jiffies

Since, the address of 'jiffies' pointed to by 'kallsyms' will change
on every boot, its probably not a good source for such user-space
use-cases.

Will send out a v2 shortly (after waiting for some inputs from the mips guys).

Thanks,
Bhupesh
