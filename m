Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 10 Sep 2010 08:11:26 +0200 (CEST)
Received: from dalsmrelay2.nai.com ([205.227.136.216]:53123 "HELO
        dalsmrelay2.nai.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with SMTP id S1491013Ab0IJGLW (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 10 Sep 2010 08:11:22 +0200
Received: from (unknown [10.64.5.51]) by dalsmrelay2.nai.com with smtp
         id 2782_191d_37f50286_bca2_11df_b885_00219b929abd;
        Fri, 10 Sep 2010 06:11:15 +0000
Received: from dalexbr1.corp.nai.org (161.69.111.81) by DALEXHT1.corp.nai.org
 (10.64.5.51) with Microsoft SMTP Server id 8.2.254.0; Fri, 10 Sep 2010
 01:11:08 -0500
Received: from STPSMTP01.scur.com ([10.96.96.163]) by dalexbr1.corp.nai.org
 with Microsoft SMTPSVC(6.0.3790.3959);  Fri, 10 Sep 2010 01:11:06 -0500
Received: from cyberguard.com.au ([10.46.129.16]) by STPSMTP01.scur.com with
 Microsoft SMTPSVC(6.0.3790.4675);       Fri, 10 Sep 2010 01:11:06 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])    by
 bne.snapgear.com (Postfix) with ESMTP id EA254EBAD0;   Fri, 10 Sep 2010
 16:11:04 +1000 (EST)
X-Virus-Scanned: amavisd-new at snapgear.com
Received: from bne.snapgear.com ([127.0.0.1])   by localhost (bne.snapgear.com
 [127.0.0.1]) (amavisd-new, port 10024) with ESMTP id A1O6MaRU5aYu; Fri, 10
 Sep 2010 16:10:55 +1000 (EST)
Received: from [172.22.196.222] (bnelabfw.scur.com [10.46.129.16])      by
 bne.snapgear.com (Postfix) with ESMTP; Fri, 10 Sep 2010 16:10:55 +1000 (EST)
Message-ID: <4C89CBDA.1030309@snapgear.com>
Date:   Fri, 10 Sep 2010 16:10:34 +1000
From:   Greg Ungerer <gerg@snapgear.com>
User-Agent: Thunderbird 2.0.0.24 (X11/20100411)
MIME-Version: 1.0
To:     David Daney <ddaney@caviumnetworks.com>
CC:     linux-mips@linux-mips.org
Subject: Re: [PATCH] mips: fix start of free memory when using initrd
References: <201009080550.o885ohjD014188@goober.internal.moreton.com.au> <4C891863.1080602@caviumnetworks.com>
In-Reply-To: <4C891863.1080602@caviumnetworks.com>
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 10 Sep 2010 06:11:06.0620 (UTC) FILETIME=[F47793C0:01CB50AE]
X-archive-position: 27743
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: gerg@snapgear.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                 
X-UID: 8081


Hi David,

David Daney wrote:
> On 09/07/2010 10:50 PM, Greg Ungerer wrote:
>> I have a typical Cavium/Octeon (5010) based system, that I sometimes
>> use a kernel and traditional initrd setup on. In a typical layout the
>> kernel is loaded into low physical RAM (via boot loader) and the initrd
>> is loaded somewhere above it. Everything runs fine, but the region
>> occupied by the initrd is effectively lost from usable RAM.
>>
>> For example, with these boot args "rd_start=0x84000000 
>> rd_size=0x00206000"
>> where the initrd is loaded at 64MB (and is just over 2MB in size) I end
>> up with:
>>
>> Memory: 59620k/127152k available (2193k kernel code, 67532k reserved, 
>> 563k data, 192k init, 0k highmem)
>>
>> Ouch!  A lot of RAM not usable.
>>
>> It looks to me that the logic of setting the bootmem is not quite right
>> for the initrd case. If I patch arch/mips/kernel/setup.c with the patch
>> below I get all that memory back, and everything seems to work:
>>
>> Memory: 121044k/127152k available (2193k kernel code, 6108k reserved, 
>> 563k data, 192k init, 0k highmem)
>>
>> The patch just sets the bootmem map to always be the end of the kernel.
>> Then the bootmem reserve initrd logic does its work as expected.
>> (A little more cleaning up could be done I guess, but I want to know
>> the approach is correct first :-)
>>
>> Am I mis-understanding how this is supposed to work?
>> Other architectures seem to set the bootmem to the end of the kernel.
>> Sparc has some extra checks to make sure that the bootmem setup data
>> doesn't overwrite the initrd, but otherwise is similar.
>>
>> Regards
>> Greg
>>
>>
>>
>> mips: fix start of free memory when using initrd
>>
>> Currently when using an initrd on a MIPS system the start of the bootmem
>> region of memory is set to the larger of the end of the kernel bss region
>> (_end) or the end of the initrd. In a typical memory layout where the
>> initrd is at some address above the kernel image this means that the
>> start of the bootmem region will be the end of the initrd. But when
>> we are done processing/loading the initrd we have no way to reclaim the
>> memory region it occupied, and we lose a large chunk of now otherwise
>> empty RAM from our final running system.
>>
>> The bootmem code is designed to allow this initrd to be reserved (and
>> the code in finalize_initrd() currently does this). When the initrd is
>> finally processed/loaded its reserved memory is freed.
>>
>> Fix the setting of the start of the bootmem map to be the end of the
>> kernel.
>>
>> Signed-off-by: Greg Ungerer<gerg@uclinux.org>
>> ---
>>   arch/mips/kernel/setup.c |   11 ++++++-----
>>   1 files changed, 6 insertions(+), 5 deletions(-)
>>
>> diff --git a/arch/mips/kernel/setup.c b/arch/mips/kernel/setup.c
>> index 85aef3f..df8ed83 100644
>> --- a/arch/mips/kernel/setup.c
>> +++ b/arch/mips/kernel/setup.c
>> @@ -259,12 +259,13 @@ static void __init bootmem_init(void)
>>       int i;
>>
>>       /*
>> -     * Init any data related to initrd. It's a nop if INITRD is
>> -     * not selected. Once that done we can determine the low bound
>> -     * of usable memory.
>> +     * Sanity check any INITRD first. We don't take it into account
>> +     * for bootmem setup initially, rely on the end-of-kernel-code
>> +     * as our memory range starting point. Once bootmem is inited we
>> +     * will reserve the area used for the initrd.
>>        */
>> -    reserved_end = max(init_initrd(),
>> -               (unsigned long) PFN_UP(__pa_symbol(&_end)));
>> +    init_initrd();
>> +    reserved_end = (unsigned long) PFN_UP(__pa_symbol(&_end));
>>
>>       /*
>>        * max_low_pfn is not a number of pages. The number of pages
>>
>>
> 
> We have the attached patch (plus a few more hacks), I don't think it is 
> universally safe to change the calculation of reserved_end.  Although 
> the patch has some code formatting problems you might consider using it 
> as a starting point.

I don't use the Cavium u-boot boot loader on this. (And don't use any
of the named blocks, or other data struct passing from the boot loader
to the kernel). So the patch is not really useful for me.

But I am interested, why do you think it is not safe to change
reserved_end?

There is the possible overlap of the kernels bootmem setup data
that is not checked (which sparc does for example). But otherwise
what problems do you see here?

Regards
Greg



------------------------------------------------------------------------
Greg Ungerer  --  Principal Engineer        EMAIL:     gerg@snapgear.com
SnapGear Group, McAfee                      PHONE:       +61 7 3435 2888
8 Gardner Close                             FAX:         +61 7 3217 5323
Milton, QLD, 4064, Australia                WEB: http://www.SnapGear.com
