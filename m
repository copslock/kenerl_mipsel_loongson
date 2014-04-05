Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 05 Apr 2014 02:55:11 +0200 (CEST)
Received: from mail.lemote.com ([222.92.8.138]:45604 "EHLO mail.lemote.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6822263AbaDEAyz2a23f (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sat, 5 Apr 2014 02:54:55 +0200
Received: from localhost (localhost [127.0.0.1])
        by mail.lemote.com (Postfix) with ESMTP id 7998B23412;
        Sat,  5 Apr 2014 08:54:46 +0800 (CST)
X-Virus-Scanned: Debian amavisd-new at lemote.com
Received: from mail.lemote.com ([127.0.0.1])
        by localhost (mail.lemote.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id I-hoapo-gqzI; Sat,  5 Apr 2014 08:54:28 +0800 (CST)
Received: from mail.lemote.com (localhost [127.0.0.1])
        (Authenticated sender: chenhc@lemote.com)
        by mail.lemote.com (Postfix) with ESMTPA id 05D6B228C4;
        Sat,  5 Apr 2014 08:54:28 +0800 (CST)
Received: from 222.92.8.142
        (SquirrelMail authenticated user chenhc)
        by mail.lemote.com with HTTP;
        Sat, 5 Apr 2014 08:54:28 +0800
Message-ID: <621ab4a5012d8ae1eebc5dc47393f864.squirrel@mail.lemote.com>
In-Reply-To: <533EE1B9.2040805@gmail.com>
References: <1396599104-24370-1-git-send-email-chenhc@lemote.com>
    <1396599104-24370-6-git-send-email-chenhc@lemote.com>
    <533EE1B9.2040805@gmail.com>
Date:   Sat, 5 Apr 2014 08:54:28 +0800
Subject: Re: [PATCH 5/9] MIPS: Add numa api support
From:   =?gb2312?Q?=22=B3=C2=BB=AA=B2=C5=22?= <chenhc@lemote.com>
To:     "David Daney" <ddaney.cavm@gmail.com>
Cc:     "Ralf Baechle" <ralf@linux-mips.org>,
        "John Crispin" <john@phrozen.org>,
        "Steven J. Hill" <steven.hill@imgtec.com>,
        "Aurelien Jarno" <aurelien@aurel32.net>, linux-mips@linux-mips.org,
        "Fuxin Zhang" <zhangfx@lemote.com>,
        "Zhangjin Wu" <wuzhangjin@gmail.com>
User-Agent: SquirrelMail/1.4.22
MIME-Version: 1.0
Content-Type: text/plain;charset=gb2312
Content-Transfer-Encoding: 8bit
X-Priority: 3 (Normal)
Importance: Normal
Return-Path: <chenhc@lemote.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 39655
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

Excuse me, what's the compat version exactly means? Or how to produce a
problem  without a compat version? It seems everything works fine just
with this patch.

Huacai

> On 04/04/2014 01:11 AM, Huacai Chen wrote:
>> Enable sys_mbind()/sys_get_mempolicy()/sys_set_mempolicy() for O32, N32,
>> and N64 ABIs.
>>
>> Signed-off-by: Huacai Chen <chenhc@lemote.com>
>
> NACK.
>
> You need compat versions of the syscalls...
>
> Also current migrate_pages and move_pages syscalls need to use the
> compat wrappers for 32-bit ABIs.
>
> David Daney
>
>
>> ---
>>   arch/mips/kernel/scall32-o32.S |    4 ++--
>>   arch/mips/kernel/scall64-64.S  |    4 ++--
>>   arch/mips/kernel/scall64-n32.S |    6 +++---
>>   arch/mips/kernel/scall64-o32.S |    6 +++---
>>   4 files changed, 10 insertions(+), 10 deletions(-)
>>
>> diff --git a/arch/mips/kernel/scall32-o32.S
>> b/arch/mips/kernel/scall32-o32.S
>> index fdc70b4..7f7e2fb 100644
>> --- a/arch/mips/kernel/scall32-o32.S
>> +++ b/arch/mips/kernel/scall32-o32.S
>> @@ -495,8 +495,8 @@ EXPORT(sys_call_table)
>>   	PTR	sys_tgkill
>>   	PTR	sys_utimes
>>   	PTR	sys_mbind
>> -	PTR	sys_ni_syscall			/* sys_get_mempolicy */
>> -	PTR	sys_ni_syscall			/* 4270 sys_set_mempolicy */
>> +	PTR	sys_get_mempolicy
>> +	PTR	sys_set_mempolicy		/* 4270 */
>>   	PTR	sys_mq_open
>>   	PTR	sys_mq_unlink
>>   	PTR	sys_mq_timedsend
>> diff --git a/arch/mips/kernel/scall64-64.S
>> b/arch/mips/kernel/scall64-64.S
>> index dd99c328..a4baf06 100644
>> --- a/arch/mips/kernel/scall64-64.S
>> +++ b/arch/mips/kernel/scall64-64.S
>> @@ -347,8 +347,8 @@ EXPORT(sys_call_table)
>>   	PTR	sys_tgkill			/* 5225 */
>>   	PTR	sys_utimes
>>   	PTR	sys_mbind
>> -	PTR	sys_ni_syscall			/* sys_get_mempolicy */
>> -	PTR	sys_ni_syscall			/* sys_set_mempolicy */
>> +	PTR	sys_get_mempolicy
>> +	PTR	sys_set_mempolicy
>>   	PTR	sys_mq_open			/* 5230 */
>>   	PTR	sys_mq_unlink
>>   	PTR	sys_mq_timedsend
>> diff --git a/arch/mips/kernel/scall64-n32.S
>> b/arch/mips/kernel/scall64-n32.S
>> index f68d2f4..92db19e 100644
>> --- a/arch/mips/kernel/scall64-n32.S
>> +++ b/arch/mips/kernel/scall64-n32.S
>> @@ -339,9 +339,9 @@ EXPORT(sysn32_call_table)
>>   	PTR	compat_sys_clock_nanosleep
>>   	PTR	sys_tgkill
>>   	PTR	compat_sys_utimes		/* 6230 */
>> -	PTR	sys_ni_syscall			/* sys_mbind */
>> -	PTR	sys_ni_syscall			/* sys_get_mempolicy */
>> -	PTR	sys_ni_syscall			/* sys_set_mempolicy */
>> +	PTR	sys_mbind
>> +	PTR	sys_get_mempolicy
>> +	PTR	sys_set_mempolicy
>
> Here
>
>
>>   	PTR	compat_sys_mq_open
>>   	PTR	sys_mq_unlink			/* 6235 */
>>   	PTR	compat_sys_mq_timedsend
>> diff --git a/arch/mips/kernel/scall64-o32.S
>> b/arch/mips/kernel/scall64-o32.S
>> index 70f6ace..0230429 100644
>> --- a/arch/mips/kernel/scall64-o32.S
>> +++ b/arch/mips/kernel/scall64-o32.S
>> @@ -473,9 +473,9 @@ EXPORT(sys32_call_table)
>>   	PTR	compat_sys_clock_nanosleep	/* 4265 */
>>   	PTR	sys_tgkill
>>   	PTR	compat_sys_utimes
>> -	PTR	sys_ni_syscall			/* sys_mbind */
>> -	PTR	sys_ni_syscall			/* sys_get_mempolicy */
>> -	PTR	sys_ni_syscall			/* 4270 sys_set_mempolicy */
>> +	PTR	sys_mbind
>> +	PTR	sys_get_mempolicy
>> +	PTR	sys_set_mempolicy		/* 4270 */
>
> And Here.
>
>
>>   	PTR	compat_sys_mq_open
>>   	PTR	sys_mq_unlink
>>   	PTR	compat_sys_mq_timedsend
>>
>
>
