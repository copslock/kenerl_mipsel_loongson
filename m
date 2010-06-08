Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 08 Jun 2010 23:58:24 +0200 (CEST)
Received: from mail.windriver.com ([147.11.1.11]:34713 "EHLO
        mail.windriver.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S1491123Ab0FHV6U (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 8 Jun 2010 23:58:20 +0200
Received: from ALA-MAIL03.corp.ad.wrs.com (ala-mail03 [147.11.57.144])
        by mail.windriver.com (8.14.3/8.14.3) with ESMTP id o58Lw5O7024068;
        Tue, 8 Jun 2010 14:58:05 -0700 (PDT)
Received: from ala-mail06.corp.ad.wrs.com ([147.11.57.147]) by ALA-MAIL03.corp.ad.wrs.com with Microsoft SMTPSVC(6.0.3790.1830);
         Tue, 8 Jun 2010 14:57:48 -0700
Received: from poker ([172.25.35.76]) by ala-mail06.corp.ad.wrs.com with Microsoft SMTPSVC(6.0.3790.1830);
         Tue, 8 Jun 2010 14:57:48 -0700
Content-Type: text/plain; charset=utf-8; format=flowed; delsp=yes
To:     "David Daney" <david.s.daney@gmail.com>,
        "octane indice" <octane@alinto.com>
Cc:     "Dmitri Vorobiev" <dmitri.vorobiev@gmail.com>,
        linux-mips@linux-mips.org
Subject: Re: Cross compiling MIPS kernel under x86
Reply-To: phils@windriver.com
References: <1274711094.4bfa8c3675983@www.inmano.com>
 <AANLkTinOaPkOXm128trTQ39jNGWMcvPhVUGWSQz6hLjR@mail.gmail.com>
 <20100525131341.GA26500@linux-mips.org>
 <1274795905.4bfbd781a17fa@www.inmano.com>
 <20100525144400.GA30900@linux-mips.org>
 <1274879482.4bfd1dfa91e70@www.inmano.com>
 <AANLkTikbZmTWh8X4KOKLAUaJxKS5-PO39hmiTVICB5Zm@mail.gmail.com>
 <1274977788.4bfe9dfc7680f@www.inmano.com> <4BFEE551.8000306@gmail.com>
Date:   Tue, 08 Jun 2010 14:57:48 -0700
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
From:   "Phil Staub" <phils@windriver.com>
Organization: Wind River Systems
Message-ID: <op.vdz4mmlornd9a3@poker>
In-Reply-To: <4BFEE551.8000306@gmail.com>
User-Agent: Opera Mail/10.10 (Linux)
X-OriginalArrivalTime: 08 Jun 2010 21:57:48.0908 (UTC) FILETIME=[A27062C0:01CB0755]
X-archive-position: 27091
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: phils@windriver.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                 
X-UID: 5952

On Thu, 27 May 2010 14:34:09 -0700, David Daney <david.s.daney@gmail.com>  
wrote:

> On 05/27/2010 09:29 AM, octane indice wrote:
>> Response to Dmitri Vorobiev<dmitri.vorobiev@gmail.com>  :
>>> Just checked that the following steps result in a successful
>>> build of a vanilla 2.6.34 vmlinux:
>>>
>> Thanks for taking the time to do it.
>>
>>> http://ftp.gnu.org/gnu/gcc/gcc-4.4.4/gcc-core-4.4.4.tar.bz2
>>> tar jxf gcc-core-4.4.4.tar.bz2
>>> cd ../build
>>> ../src/gcc-4.4.4/configure --target=mips64-unknown-linux-gnu
>>> --prefix=/work/tmp/zoo --disable-threads --disable-shared
>>> --disable-multilib --disable-libgcc --disable-libmudflap
>>> --disable-libssp --disable-libgomp
>>> make
>>
>> It fails here with something related to stdc++. With adding a
>> --enable-language=c it works. So the configure line I used is:
>> ../gcc-4.4.4/configure --target=mips64-unknown-linux-gnu
>> --prefix=/var/samba/mips --disable-threads --disable-shared
>> --disable-multilib --disable-libgcc --disable-libmudflap  
>> --disable-libssp
>> --disable-libgomp --enable-languages=c
>>
>>> make ARCH=mips cavium-octeon_defconfig
>>> make ARCH=mips
>>> CROSS_COMPILE=/work/tmp/zoo/bin/mips64-unknown-linux-gnu- vmlinux
>>>
>>> Hope that helps.
>>>
>> It helped me a lot, thank you. The kernel compiles fine.
>> The kernel is very huge: 39MBytes (!).
>> After a mips64-unknown-linux-gnu-strip, it downsized to 3.3MBytes.
>> But that kernel doesn't boot.
>>
>> The system in the board I have uses in U-boot:
>> ext2load ide 0 4000000 vmlinux
>> bootoctlinux 4000000 (other args..)
>>
>> But when I replace the vmlinux file with mine called 'mips', it says:
>> RSEC-K1# ext2load ide 0 4000000 mips
>>
>> 3362840 bytes read
>> WARNING: Data loaded outside of the reserved load area, memory  
>> corruption
>> may occur.
>> WARNING: Please refer to the bootloader memory map documentation for  
>> more
>> information.
>> RSEC-K1# bootoctlinux 4000000
>> ELF file is 64 bit
>> Attempting to allocate memory for ELF segment: addr: 0xffffffff81100000
>> (adjusted to: 0x0000000001100000), size 0x355c00
>> Allocated memory for ELF segment: addr: 0xffffffff81100000, size  
>> 0x355c00
>> Attempting to allocate memory for ELF segment: addr: 0xffffffff81343da0
>> (adjusted to: 0x0000000001343da0), size 0x24
>> Error allocating memory for elf image!
>> ## ERROR loading File!
>> RSEC-K1#
>>
>
> Early Octeon bootloaders cannot handle PT_NOTE program headers, I think
> that is what is biting you here.
>
> If you can upgrade to an SDK-1.9 or later bootloader, I would recommend
> that.  Otherwise remove the PT_NOTE from your kernel image (the
> technique for doing this is left as an excise for the reader, but I have
> found that emacs hexl mode works well).

In the top level Makefile, you'll find this:


# Use --build-id when available.
LDFLAGS_BUILD_ID = $(patsubst -Wl$(comma)%,%,\
			      $(call cc-ldoption, -Wl$(comma)--build-id,))

Comment that out and it should fix you up.

Phil

>
> David Daney
>


-- 
Phil Staub, Senior Member of Technical Staff, Wind River
Direct: 702.290.0470 Fax: 702.982.0085
