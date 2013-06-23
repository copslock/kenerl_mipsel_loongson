Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 23 Jun 2013 04:03:09 +0200 (CEST)
Received: from mail.lemote.com ([222.92.8.138]:44399 "EHLO mail.lemote.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6816022Ab3FWCDHwX3JM (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sun, 23 Jun 2013 04:03:07 +0200
Received: from localhost (localhost [127.0.0.1])
        by mail.lemote.com (Postfix) with ESMTP id C6575228CE;
        Sun, 23 Jun 2013 10:02:58 +0800 (CST)
X-Virus-Scanned: Debian amavisd-new at lemote.com
Received: from mail.lemote.com ([127.0.0.1])
        by localhost (mail.lemote.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id mXVnBC789nkU; Sun, 23 Jun 2013 10:02:47 +0800 (CST)
Received: from mail.lemote.com (localhost [127.0.0.1])
        (Authenticated sender: chenhc@lemote.com)
        by mail.lemote.com (Postfix) with ESMTPA id D8DF122744;
        Sun, 23 Jun 2013 10:02:46 +0800 (CST)
Received: from 172.16.2.208
        (SquirrelMail authenticated user chenhc)
        by mail.lemote.com with HTTP;
        Sun, 23 Jun 2013 10:02:47 +0800
Message-ID: <5292c3e3e092b848dcafbbaf9a80fbee.squirrel@mail.lemote.com>
In-Reply-To: <20130622125950.GB19237@mails.so.argh.org>
References: <1366030028-5084-1-git-send-email-chenhc@lemote.com>
    <1366030028-5084-6-git-send-email-chenhc@lemote.com>
    <20130622125950.GB19237@mails.so.argh.org>
Date:   Sun, 23 Jun 2013 10:02:47 +0800
Subject: Re: [PATCH V10 05/13] MIPS: Loongson: Add UEFI-like firmware
 interface support
From:   chenhc@lemote.com
To:     "Andreas Barth" <aba@ayous.org>
Cc:     "Ralf Baechle" <ralf@linux-mips.org>,
        "John Crispin" <john@phrozen.org>, linux-mips@linux-mips.org,
        "Fuxin Zhang" <zhangfx@lemote.com>,
        "Zhangjin Wu" <wuzhangjin@gmail.com>,
        "Hongliang Tao" <taohl@lemote.com>, "Hua Yan" <yanh@lemote.com>
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
X-archive-position: 37102
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

> * Huacai Chen (chenhc@lemote.com) [130415 14:49]:
>> The new UEFI-like firmware interface has 3 advantages:
>>
>> 1, Firmware export a physical memory map which is similar to X86's
>>    E820 map, so prom_init_memory() will be more elegant that #ifdef
>>    clauses can be removed.
>> 2, Firmware export a pci irq routing table, we no longer need pci
>>    irq routing fixup in kernel's code.
>> 3, Firmware has a built-in vga bios, and its address is exported,
>>    the linux kernel no longer need an embedded blob.
>>
>> With the new interface, Loongson-3A/2G and all their successors can use
>> a unified kernel. All Loongson-based machines support this new interface
>> except 2E/2F series.
>
> Can't we auto-detect whether there is an UEFI-like interface? That
> would allow to reduce the number of #ifdefs a bit.
Cannot be detected at present. In future, all non-UEFI interface will
be replaced and non-UEFI-related code will be removed.

>
>
>> --- a/arch/mips/loongson/common/env.c
>> +++ b/arch/mips/loongson/common/env.c
>>  	while (l != 0) {
>> -		parse_even_earlier(bus_clock, "busclock", l);
>>  		parse_even_earlier(cpu_clock_freq, "cpuclock", l);
>>  		parse_even_earlier(memsize, "memsize", l);
>>  		parse_even_earlier(highmemsize, "highmemsize", l);
>> @@ -57,8 +73,32 @@ void __init prom_init_env(void)
>>  	}
>>  	if (memsize == 0)
>>  		memsize = 256;
>> -	if (bus_clock == 0)
>> -		bus_clock = 66000000;
>> +#else
>
> why are we not interested anymore in busclock in non-UEFI-like
> machines (and shouldn't this be documented in the summary)?
busclock are not used in any place in the kernel, so remove it.

>
>
>
> Andi
>>
>
