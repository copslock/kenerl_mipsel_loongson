Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 02 Mar 2016 11:51:20 +0100 (CET)
Received: from mail-wm0-f65.google.com ([74.125.82.65]:33833 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27007226AbcCBKvRsi1fC (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 2 Mar 2016 11:51:17 +0100
Received: by mail-wm0-f65.google.com with SMTP id p65so8890334wmp.1;
        Wed, 02 Mar 2016 02:51:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc;
        bh=snKIXm8y/dlwLwVEEf3p1PWHlSui5e7ENfySJK4P9tA=;
        b=dyAEx8rMj2bUP9R6lxFAMNdcKAnXmrNixfSGt+ZaG+YC/z0hY7Wt2EBF5XpATTQFyC
         mn5HTUn0ybb5xkwsTC5Vv5N3/ZtR7wF6YaQCRyeo0sX3LYPAHri1egIKexnCOxaZ4gea
         NNrRvMzb4ZP2RtITch/CciBtUH5BSuW0W8yuTRhuJ+rPN9XrMasSmtQPwF7TUUZ/CCta
         1hSlMzKkuNL8uA6Rw4Y+hkwB6ySdcsPZBGKG9ou2dtdlBP+O193eM6zFzC824RQ0Pw2n
         TCFMyOPpQbKW8TmMhIaqZ+/d5Hxa7nJEakXSkaBv3tehrRqqlBNVpvFruNgxmgQ3CpJb
         ZYLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=snKIXm8y/dlwLwVEEf3p1PWHlSui5e7ENfySJK4P9tA=;
        b=QT9mptnowj0IP4ASOV+ggWMsZdiRqQ8jUPduYp8gmH/9YLrf+TF8AY4Zn1Bng/PWcn
         FmR9d3s86KPoxXy9mZyTATOE4wDG2ftHgzi9ZNP/rXrmeZFIKYEeZ3CXNDTlaP3Fjdrc
         sIfRzIwCfT2pI6uoMyje1Zmn81CBiuE6g0S4xz8NvQ+YGeyr2LcFpfEJVgrgtO5sgGLu
         UY7JkEo9qtysZ7O/g4/6QcA+UV2OixBBPQ+mnEh1T9wE2BbIDzuXfHZzLbqkmV1kjhfU
         f/aftmTkBfJKiEwNaGRz1BQ/gYXBzT81Z7wWinPOJmhpP3RygIKeacCl/2RM5TS2Cnif
         lhyw==
X-Gm-Message-State: AD7BkJKq8z0tugn0Qafihpb1HvgHIjTguFKKgV6TmANlxzd4kjtSWMrK3g4O+GWbiX28HiTMOnTZ+jIVTzUhkA==
MIME-Version: 1.0
X-Received: by 10.28.137.148 with SMTP id l142mr3816324wmd.40.1456915872526;
 Wed, 02 Mar 2016 02:51:12 -0800 (PST)
Received: by 10.27.13.13 with HTTP; Wed, 2 Mar 2016 02:51:12 -0800 (PST)
In-Reply-To: <20160302104128.GA18341@linux-mips.org>
References: <1456567658-14694-1-git-send-email-chenhc@lemote.com>
        <1456567658-14694-4-git-send-email-chenhc@lemote.com>
        <20160302104128.GA18341@linux-mips.org>
Date:   Wed, 2 Mar 2016 18:51:12 +0800
X-Google-Sender-Auth: Os52ZErI9tipvQIMxTcT0yKQR7g
Message-ID: <CAAhV-H52k9zhukQgUixN7exPgf0gu_cM7dxgyv7rUnortmsf7g@mail.gmail.com>
Subject: Re: [PATCH V4 3/5] MIPS: Loongson: Invalidate special TLBs when needed
From:   Huacai Chen <chenhc@lemote.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     Aurelien Jarno <aurelien@aurel32.net>,
        "Steven J . Hill" <Steven.Hill@imgtec.com>,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>,
        Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>
Content-Type: text/plain; charset=UTF-8
Return-Path: <chenhuacai@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 52420
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

On Wed, Mar 2, 2016 at 6:41 PM, Ralf Baechle <ralf@linux-mips.org> wrote:
> On Sat, Feb 27, 2016 at 06:07:36PM +0800, Huacai Chen wrote:
>
>> Loongson-2 has a 4 entry itlb which is a subset of jtlb, Loongson-3 has
>> a 4 entry itlb and a 4 entry dtlb which are subsets of jtlb. We should
>> write diag register to invalidate itlb/dtlb when flushing jtlb because
>> itlb/dtlb are not totally transparent to software.
>>
>> For Loongson-3A R2 (and newer), we should invalidate ITLB, DTLB, VTLB
>> and FTLB before we enable/disable FTLB.
>>
>> Signed-off-by: Huacai Chen <chenhc@lemote.com>
>> ---
>>  arch/mips/kernel/cpu-probe.c |  2 ++
>>  arch/mips/mm/tlb-r4k.c       | 27 +++++++++++++++------------
>>  2 files changed, 17 insertions(+), 12 deletions(-)
>>
>> diff --git a/arch/mips/kernel/cpu-probe.c b/arch/mips/kernel/cpu-probe.c
>> index 2a2ae86..ef605e2 100644
>> --- a/arch/mips/kernel/cpu-probe.c
>> +++ b/arch/mips/kernel/cpu-probe.c
>> @@ -562,6 +562,8 @@ static int set_ftlb_enable(struct cpuinfo_mips *c, int enable)
>>                                          << MIPS_CONF7_FTLBP_SHIFT));
>>               break;
>>       case CPU_LOONGSON3:
>> +             /* Flush ITLB, DTLB, VTLB and FTLB */
>> +             write_c0_diag(1<<2 | 1<<3 | 1<<12 | 1<<13);
>
> Too many magic numbers.  Could you use defines for the magic numbers you're
> writing to these registers?
OK, I know, but if I define macros, put them in tlb.h or tlbflush.h or
loongson.h in mach-loongson64?

>
>>               /* Loongson-3 cores use Config6 to enable the FTLB */
>>               config = read_c0_config6();
>>               if (enable)
>> diff --git a/arch/mips/mm/tlb-r4k.c b/arch/mips/mm/tlb-r4k.c
>> index c17d762..7593529 100644
>> --- a/arch/mips/mm/tlb-r4k.c
>> +++ b/arch/mips/mm/tlb-r4k.c
>> @@ -28,25 +28,28 @@
>>  extern void build_tlb_refill_handler(void);
>>
>>  /*
>> - * LOONGSON2/3 has a 4 entry itlb which is a subset of dtlb,
>> - * unfortunately, itlb is not totally transparent to software.
>> + * LOONGSON-2 has a 4 entry itlb which is a subset of jtlb, LOONGSON-3 has
>> + * a 4 entry itlb and a 4 entry dtlb which are subsets of jtlb. Unfortunately,
>> + * itlb/dtlb are not totally transparent to software.
>>   */
>> -static inline void flush_itlb(void)
>> +static inline void flush_spec_tlb(void)
>>  {
>>       switch (current_cpu_type()) {
>>       case CPU_LOONGSON2:
>> +             write_c0_diag(0x4);
>
> Same here.
>
>> +             break;
>>       case CPU_LOONGSON3:
>> -             write_c0_diag(4);
>> +             write_c0_diag(0xc);
>
> And here.
>
> Also, why did the magic number change from 4 to 0xc?
0x4 means flush itlb only, 0xc means flush itlb and dtlb.

>
>>               break;
>>       default:
>>               break;
>>       }
>>  }
>>
>> -static inline void flush_itlb_vm(struct vm_area_struct *vma)
>> +static inline void flush_spec_tlb_vm(struct vm_area_struct *vma)
>>  {
>>       if (vma->vm_flags & VM_EXEC)
>> -             flush_itlb();
>> +             flush_spec_tlb();
>
> Hm..  "spec tlb" is not very descriptive in my opinion.  How about
> renameing this function to flush_micro_tlb().
OK, I will change the name.

>
>   Ralf
>
