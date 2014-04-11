Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 11 Apr 2014 10:21:16 +0200 (CEST)
Received: from mail-ig0-f177.google.com ([209.85.213.177]:52606 "EHLO
        mail-ig0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6822265AbaDKIVMlN89x convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 11 Apr 2014 10:21:12 +0200
Received: by mail-ig0-f177.google.com with SMTP id ur14so526151igb.4
        for <multiple recipients>; Fri, 11 Apr 2014 01:21:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type:content-transfer-encoding;
        bh=daor7oC/9pHu+9tfzQdHw/vanXZUvv9399pjT+yeLHA=;
        b=S43gvvvFgpy/rr88nPV0qpRJFZhP5lcJdVn/o1bmaN0JF1QyQSAX4ZOzwc/MKcVqoz
         /cfRxeR3XE9GuIPqCUpwTYzMkEerpJ/X3lMYvdSl1Toy8rVjGVE11T0/+xOPW3OOJIXh
         O0ku+31IKiAjVeZqFs3L6Mwcke/qaZfbG18Q7WI5rvKPu1ZHv4L2Vf/52PP6Zd4Jq+RR
         roAQ4k6E2WnScAkJX33ALY3Wl2nX+2k3AzgAegtbsEHqQQ7GwUemIJ7hB/OdwtCSkuX9
         y36yKTtXoFlEBKzZjQ7xXziYLVX80RB9zUwBrQYPjdPFuGn1dRf3W/PKWqB/MYZvyVFK
         5cxA==
MIME-Version: 1.0
X-Received: by 10.42.29.73 with SMTP id q9mr1847572icc.46.1397204466593; Fri,
 11 Apr 2014 01:21:06 -0700 (PDT)
Received: by 10.64.27.161 with HTTP; Fri, 11 Apr 2014 01:21:06 -0700 (PDT)
In-Reply-To: <CAAhV-H4inc8sCfWo3J3p7=BGYOZFEbntzO81fP+JvO115j6bvQ@mail.gmail.com>
References: <1396599104-24370-1-git-send-email-chenhc@lemote.com>
        <1396599104-24370-6-git-send-email-chenhc@lemote.com>
        <533EE1B9.2040805@gmail.com>
        <621ab4a5012d8ae1eebc5dc47393f864.squirrel@mail.lemote.com>
        <CAAhV-H4inc8sCfWo3J3p7=BGYOZFEbntzO81fP+JvO115j6bvQ@mail.gmail.com>
Date:   Fri, 11 Apr 2014 16:21:06 +0800
X-Google-Sender-Auth: l0oolxEw3_KYveG2V5uU-ySTvVM
Message-ID: <CAAhV-H4gjj+PsEOi0UWDZSjG8v2yAD1-kGkz9ZP+Nrg3EqjmXw@mail.gmail.com>
Subject: Re: [PATCH 5/9] MIPS: Add numa api support
From:   Huacai Chen <chenhc@lemote.com>
To:     David Daney <ddaney.cavm@gmail.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        John Crispin <john@phrozen.org>,
        "Steven J. Hill" <steven.hill@imgtec.com>,
        Aurelien Jarno <aurelien@aurel32.net>,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>,
        Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-Path: <chenhuacai@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 39773
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

Hi, MIPS hackers,

Could anyone help me?

Huacai

On Thu, Apr 10, 2014 at 6:47 PM, Huacai Chen <chenhc@lemote.com> wrote:
> Hi, David,
>
> After some code reading, I have some understanding about compat
> syscall, please tell me whether I'm correct.
> 1, compat syscall is only needed by n32/o32 userspace on 64-bit kernel.
> 2, compat syscall is only needed when there are arguments in pointer type.
> 3, compat syscall is only needed when pointer arguments are
> array/struct/union for reading (reading means get_user or
> copy_from_user), or pointer arguments are array/struct/union/long
> integer for writing (writing means put_user or copy_to_user).
>
> If my understanding is correct, then in this patch, get_mempolicy()
> need to use the compat version for n32/o32 on 64-bit kernel, mbind()
> and set_mempolicy() can use the normal version in all cases. But when
> I reading the X86 code, it seems like only o32 on 64-bit kernel need a
> compat version (I assume i386/X32/X64 on X86 is the same as
> o32/n32/n64 on MIPS).
>
> Please give some information, thanks.
>
> Huacai
>
> On Sat, Apr 5, 2014 at 8:54 AM, "陈华才" <chenhc@lemote.com> wrote:
>> Excuse me, what's the compat version exactly means? Or how to produce a
>> problem  without a compat version? It seems everything works fine just
>> with this patch.
>>
>> Huacai
>>
>>> On 04/04/2014 01:11 AM, Huacai Chen wrote:
>>>> Enable sys_mbind()/sys_get_mempolicy()/sys_set_mempolicy() for O32, N32,
>>>> and N64 ABIs.
>>>>
>>>> Signed-off-by: Huacai Chen <chenhc@lemote.com>
>>>
>>> NACK.
>>>
>>> You need compat versions of the syscalls...
>>>
>>> Also current migrate_pages and move_pages syscalls need to use the
>>> compat wrappers for 32-bit ABIs.
>>>
>>> David Daney
>>>
>>>
>>>> ---
>>>>   arch/mips/kernel/scall32-o32.S |    4 ++--
>>>>   arch/mips/kernel/scall64-64.S  |    4 ++--
>>>>   arch/mips/kernel/scall64-n32.S |    6 +++---
>>>>   arch/mips/kernel/scall64-o32.S |    6 +++---
>>>>   4 files changed, 10 insertions(+), 10 deletions(-)
>>>>
>>>> diff --git a/arch/mips/kernel/scall32-o32.S
>>>> b/arch/mips/kernel/scall32-o32.S
>>>> index fdc70b4..7f7e2fb 100644
>>>> --- a/arch/mips/kernel/scall32-o32.S
>>>> +++ b/arch/mips/kernel/scall32-o32.S
>>>> @@ -495,8 +495,8 @@ EXPORT(sys_call_table)
>>>>      PTR     sys_tgkill
>>>>      PTR     sys_utimes
>>>>      PTR     sys_mbind
>>>> -    PTR     sys_ni_syscall                  /* sys_get_mempolicy */
>>>> -    PTR     sys_ni_syscall                  /* 4270 sys_set_mempolicy */
>>>> +    PTR     sys_get_mempolicy
>>>> +    PTR     sys_set_mempolicy               /* 4270 */
>>>>      PTR     sys_mq_open
>>>>      PTR     sys_mq_unlink
>>>>      PTR     sys_mq_timedsend
>>>> diff --git a/arch/mips/kernel/scall64-64.S
>>>> b/arch/mips/kernel/scall64-64.S
>>>> index dd99c328..a4baf06 100644
>>>> --- a/arch/mips/kernel/scall64-64.S
>>>> +++ b/arch/mips/kernel/scall64-64.S
>>>> @@ -347,8 +347,8 @@ EXPORT(sys_call_table)
>>>>      PTR     sys_tgkill                      /* 5225 */
>>>>      PTR     sys_utimes
>>>>      PTR     sys_mbind
>>>> -    PTR     sys_ni_syscall                  /* sys_get_mempolicy */
>>>> -    PTR     sys_ni_syscall                  /* sys_set_mempolicy */
>>>> +    PTR     sys_get_mempolicy
>>>> +    PTR     sys_set_mempolicy
>>>>      PTR     sys_mq_open                     /* 5230 */
>>>>      PTR     sys_mq_unlink
>>>>      PTR     sys_mq_timedsend
>>>> diff --git a/arch/mips/kernel/scall64-n32.S
>>>> b/arch/mips/kernel/scall64-n32.S
>>>> index f68d2f4..92db19e 100644
>>>> --- a/arch/mips/kernel/scall64-n32.S
>>>> +++ b/arch/mips/kernel/scall64-n32.S
>>>> @@ -339,9 +339,9 @@ EXPORT(sysn32_call_table)
>>>>      PTR     compat_sys_clock_nanosleep
>>>>      PTR     sys_tgkill
>>>>      PTR     compat_sys_utimes               /* 6230 */
>>>> -    PTR     sys_ni_syscall                  /* sys_mbind */
>>>> -    PTR     sys_ni_syscall                  /* sys_get_mempolicy */
>>>> -    PTR     sys_ni_syscall                  /* sys_set_mempolicy */
>>>> +    PTR     sys_mbind
>>>> +    PTR     sys_get_mempolicy
>>>> +    PTR     sys_set_mempolicy
>>>
>>> Here
>>>
>>>
>>>>      PTR     compat_sys_mq_open
>>>>      PTR     sys_mq_unlink                   /* 6235 */
>>>>      PTR     compat_sys_mq_timedsend
>>>> diff --git a/arch/mips/kernel/scall64-o32.S
>>>> b/arch/mips/kernel/scall64-o32.S
>>>> index 70f6ace..0230429 100644
>>>> --- a/arch/mips/kernel/scall64-o32.S
>>>> +++ b/arch/mips/kernel/scall64-o32.S
>>>> @@ -473,9 +473,9 @@ EXPORT(sys32_call_table)
>>>>      PTR     compat_sys_clock_nanosleep      /* 4265 */
>>>>      PTR     sys_tgkill
>>>>      PTR     compat_sys_utimes
>>>> -    PTR     sys_ni_syscall                  /* sys_mbind */
>>>> -    PTR     sys_ni_syscall                  /* sys_get_mempolicy */
>>>> -    PTR     sys_ni_syscall                  /* 4270 sys_set_mempolicy */
>>>> +    PTR     sys_mbind
>>>> +    PTR     sys_get_mempolicy
>>>> +    PTR     sys_set_mempolicy               /* 4270 */
>>>
>>> And Here.
>>>
>>>
>>>>      PTR     compat_sys_mq_open
>>>>      PTR     sys_mq_unlink
>>>>      PTR     compat_sys_mq_timedsend
>>>>
>>>
>>>
>>
>>
>>
