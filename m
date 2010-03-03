Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 03 Mar 2010 09:25:36 +0100 (CET)
Received: from mail.windriver.com ([147.11.1.11]:44859 "EHLO
        mail.windriver.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S1491772Ab0CCIZc (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 3 Mar 2010 09:25:32 +0100
Received: from ALA-MAIL03.corp.ad.wrs.com (ala-mail03 [147.11.57.144])
        by mail.windriver.com (8.14.3/8.14.3) with ESMTP id o238PPPB011851;
        Wed, 3 Mar 2010 00:25:25 -0800 (PST)
Received: from [128.224.161.163] ([128.224.161.163]) by ALA-MAIL03.corp.ad.wrs.com with Microsoft SMTPSVC(6.0.3790.1830);
         Wed, 3 Mar 2010 00:25:25 -0800
Message-ID: <4B8E1CF2.9070405@windriver.com>
Date:   Wed, 03 Mar 2010 16:25:22 +0800
From:   Yang Shi <yang.shi@windriver.com>
User-Agent: Thunderbird 2.0.0.23 (X11/20090817)
MIME-Version: 1.0
To:     Florian Fainelli <florian@openwrt.org>
CC:     ddaney@caviumnetworks.com, ralf@linux-mips.org,
        linux-mips@linux-mips.org
Subject: Re: [PATCH 3/3] MIPS: Octeon: Add add_wired_entry decralation in
 header file
References: <1267601172-17919-1-git-send-email-yang.shi@windriver.com> <3118b3d0f3ed042df1ee2771325c3824e6fc7ba9.1267600234.git.yang.shi@windriver.com> <9e4e80f8edd43f8a164fe618c978c1dc8cd48a69.1267600234.git.yang.shi@windriver.com> <201003030919.36006.florian@openwrt.org>
In-Reply-To: <201003030919.36006.florian@openwrt.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 03 Mar 2010 08:25:25.0349 (UTC) FILETIME=[12F1C950:01CABAAB]
Return-Path: <Yang.Shi@windriver.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26095
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yang.shi@windriver.com
Precedence: bulk
X-list: linux-mips

Florian Fainelli 写道:
> Hi Yang,
>
> On Wednesday 03 March 2010 08:26:12 Yang Shi wrote:
>   
>> Octeon's setup.c uses add_wired_entry, but it is not declared
>> anywhere. Copy add_wired_entry decralation fomr pgtable-32.h to
>> pgtable-64.h and include asm/pgtable.h into Octeon's setup.c.
>>
>> Signed-off-by: Yang Shi <yang.shi@windriver.com>
>> ---
>>  arch/mips/cavium-octeon/setup.c    |    1 +
>>  arch/mips/include/asm/pgtable-64.h |    6 ++++++
>>  2 files changed, 7 insertions(+), 0 deletions(-)
>>
>> diff --git a/arch/mips/cavium-octeon/setup.c
>>  b/arch/mips/cavium-octeon/setup.c index 8309d68..f35ba16 100644
>> --- a/arch/mips/cavium-octeon/setup.c
>> +++ b/arch/mips/cavium-octeon/setup.c
>> @@ -30,6 +30,7 @@
>>  #include <asm/bootinfo.h>
>>  #include <asm/sections.h>
>>  #include <asm/time.h>
>> +#include <asm/pagtable.h>
>>     
>
> You probably meant to include <asm/pgtable.h> instead.
>   

Yes, thanks to point out this.

V2 will be sent soon.

Regards,
Yang

>   
>>  #include <asm/octeon/octeon.h>
>>
>> diff --git a/arch/mips/include/asm/pgtable-64.h
>>  b/arch/mips/include/asm/pgtable-64.h index 26dc69d..85ee34d 100644
>> --- a/arch/mips/include/asm/pgtable-64.h
>> +++ b/arch/mips/include/asm/pgtable-64.h
>> @@ -23,6 +23,12 @@
>>  #endif
>>
>>  /*
>> + * - add_wired_entry() add a fixed TLB entry, and move wired register
>> + */
>> +extern void add_wired_entry(unsigned long entrylo0, unsigned long
>>  entrylo1, +			       unsigned long entryhi, unsigned long pagemask);
>> +
>> +/*
>>   * Each address space has 2 4K pages as its page directory, giving 1024
>>   * (== PTRS_PER_PGD) 8 byte pointers to pmd tables. Each pmd table is a
>>   * single 4K page, giving 512 (== PTRS_PER_PMD) 8 byte pointers to page
>>
>>     
>
>   
