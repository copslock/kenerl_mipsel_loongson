Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 03 Mar 2015 18:56:10 +0100 (CET)
Received: from mail-vc0-f175.google.com ([209.85.220.175]:53296 "EHLO
        mail-vc0-f175.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27008012AbbCCR4Jds-f6 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 3 Mar 2015 18:56:09 +0100
Received: by mail-vc0-f175.google.com with SMTP id hq12so13948557vcb.6
        for <linux-mips@linux-mips.org>; Tue, 03 Mar 2015 09:56:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=aXSh+AzNkYi3HHoihQg+UME1/xfxNZs739pQcv9Wzj4=;
        b=glJ2PrNA6OhqSCJS4seyEyBBlHMDsCagJVxVYiMlSsf+s20CJCcB+cToUHurVjBi4u
         lSPJSNzE9QnDwGaFZ0qy7BhVsNhvl9LNVhM/Rk0xq8Sw5ryHQA3mT7tU6iJTJqlQoFyd
         UrVrNx7VGW0GPpKaGEunGrP1SOMj/JbPht7RiU5I6ZskJ6jHOpjdZguDBnkIxya5+0a/
         qlaa1M1irkMI8cjHvavqQ3JI7XfAOntwynmdeA3hjT1ohIoqcO6QBUoWyeF82qrSJTaN
         k010YDFeheAlcherNgIqDlV9ATErd4oJRYeWDp/9HzITrkR+J7NMjkkNVoTq5+6QVSaY
         20pQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=aXSh+AzNkYi3HHoihQg+UME1/xfxNZs739pQcv9Wzj4=;
        b=kJAqw8kn9Y5Lbme2/Cj5isgcpfGBjUOuXMzbGCnBOURwRPJtCUS9iCj+iEqAiYfErl
         QXEoFPCBmp7dJJ7au07efhkkfptMKgf07aPikqfsztNcoBkzCjcSG+7398GkiascAbl5
         SKy7ipWqlaQJ7rT7Fv46/wmCYnIwGL09WD+UI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=aXSh+AzNkYi3HHoihQg+UME1/xfxNZs739pQcv9Wzj4=;
        b=S43uFYX9cyxnvdfXXMqVsHutJiDO+zq3wRxD6oUp+ST8DFKqQCbPKvTegAXfljBbFS
         QS8nswAiCrKMW4s8B03+5+IDCZ+avSCBdE1voNqkqWuMyKeut91NyW4qg4z+Pzcbqes0
         T1Ed/fGJC1d6TniiD+rhg9iotLmZ/NaYzPTAjb0NQo3uxoC/Jr4wnNcZbIYDf12qSsoM
         MshSLpknvU/hXycmncDsQu27iyQYFlBkNmsks/JGuvASIADfTfyY4/aQa26SJpAOsAG5
         sPCG2bws9r9GIISUw/WPd8f5VUxjatrb7ntcI3hnS9H8+UaVImPUudgcYI/mbjJQuo0B
         8ozw==
X-Gm-Message-State: ALoCoQmVQxsEX252bVOrGrrN8k6rzQT9HCtJMZ7ObS0xmrttNKzh7Z8i8uwqyxhKh31AvM40FFfZ
MIME-Version: 1.0
X-Received: by 10.52.135.39 with SMTP id pp7mr10141vdb.47.1425405362840; Tue,
 03 Mar 2015 09:56:02 -0800 (PST)
Received: by 10.52.116.135 with HTTP; Tue, 3 Mar 2015 09:56:02 -0800 (PST)
In-Reply-To: <20150303083002.GA1207@gmail.com>
References: <20150302231254.GA4857@www.outflux.net>
        <20150303083002.GA1207@gmail.com>
Date:   Tue, 3 Mar 2015 09:56:02 -0800
X-Google-Sender-Auth: wJeS4cVkjeBj6XfMOvY-vz4RM0E
Message-ID: <CAGXu5jKs4_c2jcOzTA2tVQThToVfMUO31GF5+6CXtwA+KKj5_Q@mail.gmail.com>
Subject: Re: [PATCH v2] seccomp: switch to using asm-generic for seccomp.h
From:   Kees Cook <keescook@chromium.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        AKASHI Takahiro <takahiro.akashi@linaro.org>,
        Russell King <linux@arm.linux.org.uk>,
        Michal Simek <monstr@monstr.eu>,
        Ralf Baechle <ralf@linux-mips.org>,
        "James E.J. Bottomley" <jejb@parisc-linux.org>,
        Helge Deller <deller@gmx.de>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        linux390@de.ibm.com, "David S. Miller" <davem@davemloft.net>,
        "x86@kernel.org" <x86@kernel.org>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Laura Abbott <lauraa@codeaurora.org>,
        Will Deacon <will.deacon@arm.com>,
        Daniel Borkmann <dborkman@redhat.com>,
        Jesper Nilsson <jesper.nilsson@axis.com>,
        James Hogan <james.hogan@imgtec.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>,
        linux-parisc <linux-parisc@vger.kernel.org>,
        linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
        linux-sh <linux-sh@vger.kernel.org>,
        sparclinux <sparclinux@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Return-Path: <keescook@google.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 46100
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

On Tue, Mar 3, 2015 at 12:30 AM, Ingo Molnar <mingo@kernel.org> wrote:
>
> * Kees Cook <keescook@chromium.org> wrote:
>
>> Most architectures don't need to do anything special for the strict
>> seccomp syscall entries. Remove the redundant headers and reduce the
>> others.
>
>>  19 files changed, 27 insertions(+), 137 deletions(-)
>
> Lovely cleanup factor.
>
> Just to make sure, are you sure the 32-bit details are identical
> across architectures?

I did "gcc -E -dM" style output comparisons on the architectures I had
compilers for, and the buildbot hasn't complained on any of the others
(though see the bottom of this email).

>
> For example some architectures did this:
>
>> --- a/arch/microblaze/include/asm/seccomp.h
>> +++ /dev/null
>> @@ -1,16 +0,0 @@
>> -#ifndef _ASM_MICROBLAZE_SECCOMP_H
>> -#define _ASM_MICROBLAZE_SECCOMP_H
>> -
>> -#include <linux/unistd.h>
>> -
>> -#define __NR_seccomp_read            __NR_read
>> -#define __NR_seccomp_write           __NR_write
>> -#define __NR_seccomp_exit            __NR_exit
>> -#define __NR_seccomp_sigreturn               __NR_sigreturn
>> -
>> -#define __NR_seccomp_read_32         __NR_read
>> -#define __NR_seccomp_write_32                __NR_write
>> -#define __NR_seccomp_exit_32         __NR_exit
>> -#define __NR_seccomp_sigreturn_32    __NR_sigreturn

The asm-generic uses the same syscall numbers from both 64 and 32,
which matches most architectures, and those are the ones that had
their seccomp.h entirely eliminated.

> others did this:
>
>> diff --git a/arch/x86/include/asm/seccomp_64.h b/arch/x86/include/asm/seccomp_64.h
>> deleted file mode 100644
>> index 84ec1bd161a5..000000000000
>> --- a/arch/x86/include/asm/seccomp_64.h
>> +++ /dev/null
>> @@ -1,17 +0,0 @@
>> -#ifndef _ASM_X86_SECCOMP_64_H
>> -#define _ASM_X86_SECCOMP_64_H
>> -
>> -#include <linux/unistd.h>
>> -#include <asm/ia32_unistd.h>
>> -
>> -#define __NR_seccomp_read __NR_read
>> -#define __NR_seccomp_write __NR_write
>> -#define __NR_seccomp_exit __NR_exit
>> -#define __NR_seccomp_sigreturn __NR_rt_sigreturn
>> -
>> -#define __NR_seccomp_read_32 __NR_ia32_read
>> -#define __NR_seccomp_write_32 __NR_ia32_write
>> -#define __NR_seccomp_exit_32 __NR_ia32_exit
>> -#define __NR_seccomp_sigreturn_32 __NR_ia32_sigreturn
>> -
>> -#endif /* _ASM_X86_SECCOMP_64_H */

Well, this was x86's split config that was consolidated into the file below:

>
> While in yet another case you kept the syscall mappings:
>
>> --- a/arch/x86/include/asm/seccomp.h
>> +++ b/arch/x86/include/asm/seccomp.h
>> @@ -1,5 +1,20 @@
>> +#ifndef _ASM_X86_SECCOMP_H
>> +#define _ASM_X86_SECCOMP_H
>> +
>> +#include <asm/unistd.h>
>> +
>> +#ifdef CONFIG_COMPAT
>> +#include <asm/ia32_unistd.h>
>> +#define __NR_seccomp_read_32         __NR_ia32_read
>> +#define __NR_seccomp_write_32                __NR_ia32_write
>> +#define __NR_seccomp_exit_32         __NR_ia32_exit
>> +#define __NR_seccomp_sigreturn_32    __NR_ia32_sigreturn
>> +#endif
>> +
>>  #ifdef CONFIG_X86_32
>> -# include <asm/seccomp_32.h>
>> -#else
>> -# include <asm/seccomp_64.h>
>> +#define __NR_seccomp_sigreturn               __NR_sigreturn
>>  #endif
>> +
>> +#include <asm-generic/seccomp.h>
>> +
>> +#endif /* _ASM_X86_SECCOMP_H */
>
> It might all be correct, but it's not obvious to me.

The x86 change was the most complex as it removed a seccomp_32. and
seccomp_64.h file and merged into a single asm/seccomp.h to provide
overrides for the _32 #defines.

However, in looking at it now... I see some flip/flopping of
__NR_sigreturn and __NR_rt_sigreturn between some of the
architectures. Let me study that and send a v3. I think there are some
accidental changes on microblaze and powerpc.

-Kees

-- 
Kees Cook
Chrome OS Security
