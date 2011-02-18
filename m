Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 18 Feb 2011 08:12:12 +0100 (CET)
Received: from mail-iy0-f177.google.com ([209.85.210.177]:33449 "EHLO
        mail-iy0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491147Ab1BRHMJ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 18 Feb 2011 08:12:09 +0100
Received: by iyh42 with SMTP id 42so3149204iyh.36
        for <linux-mips@linux-mips.org>; Thu, 17 Feb 2011 23:12:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:cc:content-type;
        bh=e/hZLGDg9/OYyiAFJTQ93GrMjyob2cfKzlIS1H1YnJA=;
        b=dKIGMYsMyBnXVTOw6HZ6Fi+6doHRlHho03nVEln3eyzf63WK5mZeoa7OK5pMVaY54/
         ld58Uw6hDtMmpUYFnOxguhfoywt1QMZgiSD8vrkX2LhhJQP0QIJ38XqPswNEqlipfmbL
         QUoPSglpepQc+ctt8cV9e8liM7gkDTZ1FuZ5s=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:cc
         :content-type;
        b=Qyjqmn8hjzGpuI70C1+D9DixKxusv8yn6L3oPlUdO7qRdAv4vK8yla4fJ4tNdJY9JE
         GPOmEzN4uSTfl54qyXgx+LSi59vCICtmccB1QGGPYUxwJ8FHSzeDAIU0wlMMgc/ZmwHX
         bAxsoch3zENEsfm0AqaXtf1z+nDj1v0HZfXrw=
MIME-Version: 1.0
Received: by 10.42.178.135 with SMTP id bm7mr495879icb.101.1298013120857; Thu,
 17 Feb 2011 23:12:00 -0800 (PST)
Received: by 10.42.108.74 with HTTP; Thu, 17 Feb 2011 23:12:00 -0800 (PST)
In-Reply-To: <AANLkTinjCAQAn00Jwn-Nbu_thr-E4fcTW-tgqKo19c_j@mail.gmail.com>
References: <AANLkTin_CMzhGmCMKfg+FMkKQue=XzwuEOZkLDMLE_to@mail.gmail.com>
        <220544EE49E5824C9DE242B5ACE58C3041639ACA@EMBX01-BNG.jnpr.net>
        <AANLkTinoCrk0Jfo_vD7qrtenSEHbY_c=foGePLcx-oe-@mail.gmail.com>
        <AANLkTikxjRtJ9igCh75yVcAHnWqFts2FbMbK+7dOBf7B@mail.gmail.com>
        <AANLkTinjCAQAn00Jwn-Nbu_thr-E4fcTW-tgqKo19c_j@mail.gmail.com>
Date:   Fri, 18 Feb 2011 15:12:00 +0800
Message-ID: <AANLkTik9OJjgUThRW2tUvQy=pDNz58twJC7psASgu5CK@mail.gmail.com>
Subject: Re: some questions about kernel source
From:   loody <miloody@gmail.com>
Cc:     Linux MIPS Mailing List <linux-mips@linux-mips.org>
Content-Type: text/plain; charset=ISO-8859-1
To:     unlisted-recipients:; (no To-header on input)
Return-Path: <miloody@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 29228
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: miloody@gmail.com
Precedence: bulk
X-list: linux-mips

Hi all:

2011/2/18 John Mahoney <jmahoney@waav.com>:
> On Thu, Feb 17, 2011 at 9:17 AM, loody <miloody@gmail.com> wrote:
>> hi :-)
>>
>> 2011/2/16 Mulyadi Santosa <mulyadi.santosa@gmail.com>:
>>> Hi :)
>>>
>>> On Wed, Feb 16, 2011 at 12:59, Rajat Jain <rajatjain@juniper.net> wrote:
>>>> Hello loody,
>>>>
>>>>> 1. in kernel/trace, I always see "__read_mostly" at the end of
>>>>> parameter is that a compiler optimization parameter?
>>>>
>>>> Yes, it is a hint to the compiler that the parameter is mostly read, thus if the compiler has to make a decision between optimizing one of the read / write paths, it will optimize the read path even at the expense of write path.
>>>
>>>
>>> To be precise, they will be grouped into same cache line as much as
>>> possible. By doing so, those cache line won't be invalidated so often
>>> (keeping them "hot" :) hehehhe )
>>
>> I cannot find it on the gcc manual.
>> is it a option in kernel for kernel usage?
>> if so, where I can found them.
>> If not, can I use it on normal user level program?
>>
>
> It is a macro defined for x86 as:
>
> #define __read_mostly __attribute__((__section__(".data..read_mostly")))
I try to find "__read_mostly" of mips arch and below are the results I
grep on arch/

......
ia64/xen/hypervisor.c:29:struct shared_info *HYPERVISOR_shared_info
__read_mostly =
mips/kernel/irq_txx9.c:58:static struct txx9_irc_reg __iomem
*txx9_ircptr __read_mostly;
mips/kernel/irq_txx9.c:63:} txx9irq[TXx9_MAX_IR] __read_mostly;
mips/kernel/setup.c:35:struct cpuinfo_mips cpu_data[NR_CPUS] __read_mostly;
mips/kernel/setup.c:55:unsigned long mips_machtype __read_mostly = MACH_UNKNOWN;
mips/kernel/setup.c:72:const unsigned long mips_io_port_base __read_mostly = -1;
mips/kernel/smp.c:58:cpumask_t cpu_sibling_map[NR_CPUS] __read_mostly;
mips/kernel/process.c:329:static struct mips_frame_info schedule_mfi
__read_mostly;
mips/txx9/generic/irq_tx4939.c:50:} tx4939irq[TX4939_NUM_IR] __read_mostly;
mips/mm/c-r4k.c:67:static unsigned long icache_size __read_mostly;
mips/mm/c-r4k.c:68:static unsigned long dcache_size __read_mostly;
mips/mm/c-r4k.c:69:static unsigned long scache_size __read_mostly;
parisc/mm/init.c:543:unsigned long *empty_zero_page __read_mostly;
parisc/include/asm/cache.h:31:#define __read_mostly
__attribute__((__section__(".data.read_mostly")))
.....
x86/vdso/vdso32-setup.c:57:unsigned int __read_mostly vdso_enabled =
VDSO_DEFAULT;
x86/include/asm/cache.h:10:#define __read_mostly
__attribute__((__section__(".data.read_mostly")))


Does Mips arch not use this option?
-- 
Regards,
miloody
