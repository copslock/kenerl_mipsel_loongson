Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 17 Mar 2010 12:30:07 +0100 (CET)
Received: from mail-qy0-f180.google.com ([209.85.221.180]:62829 "EHLO
        mail-qy0-f180.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491972Ab0CQLaD convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 17 Mar 2010 12:30:03 +0100
Received: by qyk10 with SMTP id 10so540188qyk.6
        for <linux-mips@linux-mips.org>; Wed, 17 Mar 2010 04:29:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=nda2sQZEqHrRes3iHgkimqtRd9vN6MwYSZ91qktZ0HE=;
        b=jJZaBlYwZWZ5FBh8rDkwxnqxiGgyp5puNBVVsLND5w/Iyrs6X1oZPeMefTT/VJaFF1
         MIM1Zkze7nY/ZkL0BqI/gKaf1aF1rzONBOSddqLtmMJCjGzyycOaUB8cnwg2hEb0ZMNq
         v7m5huyjsF/dfIH5LneVkx1Pkko0wQIZNZYdg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=LgBMiPVQGFYt5ZlTI3MIGpW2LuK2Zn6L/JHT3YGfAdmDTPZ6bzAV1QoVPpCu4yLEdM
         B99bdUedYi2jClFrt3s31+UQTrVD9nPgjK+zBHlaffIKlAMTHJ2tu0A9Ee0ycHP4/I9y
         Rs6ur/q38jWxnA8p83KIW2UAjD6yepGX6jY6U=
MIME-Version: 1.0
Received: by 10.224.87.159 with SMTP id w31mr210887qal.50.1268825393655; Wed, 
        17 Mar 2010 04:29:53 -0700 (PDT)
In-Reply-To: <6C370B347C3FE8438C9692873287D2E1109DDF015B@SJEXCHCCR01.corp.ad.broadcom.com>
References: <4BEA3FF3CAA35E408EA55C7BE2E61D0546AC862322@xmail3.se.axis.com>
         <6C370B347C3FE8438C9692873287D2E1109DDF0057@SJEXCHCCR01.corp.ad.broadcom.com>
         <6C370B347C3FE8438C9692873287D2E1109DDF0073@SJEXCHCCR01.corp.ad.broadcom.com>
         <1864acd31003170006q602602a9j5675964b886b0a55@mail.gmail.com>
         <6C370B347C3FE8438C9692873287D2E1109DDF015B@SJEXCHCCR01.corp.ad.broadcom.com>
Date:   Wed, 17 Mar 2010 20:29:53 +0900
Message-ID: <1864acd31003170429l7b0972fcn46a6404674ad62d9@mail.gmail.com>
Subject: Re: HIGHMEM not working.
From:   Adam Jiang <jiang.adam@gmail.com>
To:     "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>
Cc:     Ramgopal Kota <rkota@broadcom.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Return-Path: <jiang.adam@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26249
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jiang.adam@gmail.com
Precedence: bulk
X-list: linux-mips

2010/3/17 Ramgopal Kota <rkota@broadcom.com>
>
> Adam,
>
> Thanks for the response ...
>
> We enabled CONFIG_SPARSEMEM in place of CONFIG_DISCONTIGMEM .. It is specified that SPARSEMEM will eventually replaces DISCONTIGMEM
> (http://marc.info/?l=lhms-devel&m=111451976115580&w=2)

Yes. It seems a better way to do this.

> We have configured zones as below in paging_init function ..
> max_zone_pfns[ZONE_DMA] = MAX_DMA_PFN;
> max_zone_pfns[ZONE_NORMAL] = max_low_pfn;   <<  0x20000
> max_zone_pfns[ZONE_HIGHMEM] = highend_pfn;  <<  0x8FFFF
> We added 2 memory regions as below ..
> add_memory_region(0x00000000, 128MB, BOOT_MEM_RAM);
> add_memory_region(0x88000000  ,128MB, BOOT_MEM_RAM);
> Is this what you are refering as 2 memory nodes ??
>

OK. Physical memory is managed in nodes and zones. Because you have
mentioned that there would be 2 ranges of memory on your architecture
like

Node 0   [0x0000 0000, 0x0800 0000]
Node 1   [0x8000 0000, 0xcfff ffff]

I guess you can define these two nodes by add_memory_region function
but I am not sure... However, the start_addr of the second node would
be 0x8000 0000 rather than 0x8800 0000. On the other hand, I think the
following code is not correct

> max_zone_pfns[ZONE_DMA] = MAX_DMA_PFN;
> max_zone_pfns[ZONE_NORMAL] = max_low_pfn;   <<  0x20000
> max_zone_pfns[ZONE_HIGHMEM] = highend_pfn;  <<  0x8FFFF

if max_low_pfn is 0x20000, then your ZONE_NORMAL will end up at 0x2000
0000(PFN x PAGE_SIZE); but according to the information about physical
memory address you provided. 0x0800 0000 ~ 0x0fff ffff is used as PCI
device addresses. Em~, the highend_pfn is not correct either. Please
double check these address.

Bounce buffers are required for devices that cannnot access the full
range of memory available to the CPU, such as old ISA cards with only
24bit address. Is this the situation you have to face? If it is needed
you may look into function create_bounce_buffer() in the other drivers
for details, however, I still think you would not need it. By the way,
high memory just mapped to low memory by kmap() function. You don't
need to define a ZONE_HIGH in your configuration. Because 0x8000_0000
~ 0x8fff ffff is kseg0 on MIPS. You can handle them as ZONE_NORMAL in
much easier way.

Best regards,
/Adam

>
> What is the significance of MAX_PHYSMEM_BITS  & SECTION_SIZE_BITS .. Sorry for troubling with novoice questions ..
>
> Thanks & Regards,
> Ramgopal Kota
> ________________________________
> From: Adam Jiang [mailto:jiang.adam@gmail.com]
> Sent: Wednesday, March 17, 2010 12:36 PM
> To: Ramgopal Kota
> Subject: Re: HIGHMEM not working.
>
> 2010/3/17 Ramgopal Kota <rkota@broadcom.com>
>>
>>  Hi,
>>
>> I need help in running CPU with HIGH_MEM.
>> Below is the processor memory map .. It is base on MIPS64K Core.
>>
>> 0x0000_0000  -- 0x07FF_FFFF   -> RAM (Region 1)
>> 0x0800_0000  -- 0x0FFF_FFFF   -> PCI BUS 1
>> 0x2000_0000  -- 0x2FFF_FFFF   -> Flash Region
>> 0x4000_0000  -- 0x47FF_FFFF   -> PCI BUS 2
>> 0x8000_0000  -- 0xCFFF_FFFF   -> RAM (Region 2) the first 128MB is remapped into 0x8000_0000 ..
>>
>> The system has 256MB of PHYSICAL RAM ..
>>
>> I configured TLB's and added memory regions. The system boots up correctly ..
>> If I show cat /proc/meminfo it shows 256MB , it could allocate memory ( I verified with a simple program allocating the memory and writing some data)
>>
>> There is a PCI MAC device on PCI BUS 2. The CPU is not able to perform DMA to/from device.
>> The MAC driver is allocating DMA buffers using the following code ..
>> {
>>    phy = virt_to_bus(high_memory);  << Resulting in 0xa000_0000;
>>    virt = ioremap(pbase);
>> }
>> The Linux configuration has no ZONE_DMA configuration ..
>>
>>
>> Few questions ..
>>  A) HIGH_MEMORY START Address is configured to 0x2000_0000 , is it correct value.
>
> I don't think 0x2000_0000 is a correct value for HIGH_MEM in general meaning. The value depends on which architecture you're working on. And its start address could be initialed in
> LNX/arch/(arch)/kernel/setup.c
> LNX/arch/(arch)/mm/init.c
> in your case, I thing you can use all your memory as ZONE_NORMAL or ZONE_DMA but not ZONE_HIGH.
>
>>
>>  B) Are there any data which can be dumped to know more information ?
>
> Yes, of course. You could try to add some printk in the above two files in bootmem_init() function or function free_area_init_core() to see what's the memory layout exactly.
>
>>
>>  C) Do I need to enable MEMORY Discontinuous Config also ?  ( As I did not see a reason to enable this as memory in Region 2 is contiguous)
>
> Since you have two separated range fsyc memory on you board, I think you do really need CONFIG_DISCONTIGMEM_*; You may also need to define two memory nodes in bootmem.
>
>>
>>  D) I read in some articles on internet that if HIGH_MEM is used,PCI bounce buffers needs to be used ? Can some body point me how to set this up ?
>
> Usually, DMA data transferring could perform directly on fysc memory address. You may not need bounce buffer or scatter/gather operations if you can config all your memory to ZONE_NORMAL. ZONE_DMA is not necessary because this area is only required by kmalloc call with GFP_DMA flags.
> Best regards,
> /Adam
>
>>
>> Thanks & Regards,
>> Ramgopal Kota
>>
>>
>
> --
> Adam Jiang
> -----------------------------------
> e-mail:jiang.adam@gmail.com
> http://www.adamjiang.com
> -----------------------------------



--
Adam Jiang
-----------------------------------
e-mail:jiang.adam@gmail.com
http://www.adamjiang.com
-----------------------------------
