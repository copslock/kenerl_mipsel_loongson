Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 14 Apr 2011 22:02:36 +0200 (CEST)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:6067 "EHLO
        mail3.caviumnetworks.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491768Ab1DNUCc (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 14 Apr 2011 22:02:32 +0200
Received: from caexch01.caveonetworks.com (Not Verified[192.168.16.9]) by mail3.caviumnetworks.com with MailMarshal (v6,7,2,8378)
        id <B4da7530f0001>; Thu, 14 Apr 2011 13:03:27 -0700
Received: from caexch01.caveonetworks.com ([192.168.16.9]) by caexch01.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.4675);
         Thu, 14 Apr 2011 13:02:28 -0700
Received: from dd1.caveonetworks.com ([12.108.191.236]) by caexch01.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.4675);
         Thu, 14 Apr 2011 13:02:28 -0700
Message-ID: <4DA752CE.3010009@caviumnetworks.com>
Date:   Thu, 14 Apr 2011 13:02:22 -0700
From:   David Daney <ddaney@caviumnetworks.com>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.15) Gecko/20101027 Fedora/3.0.10-1.fc12 Thunderbird/3.0.10
MIME-Version: 1.0
To:     Philby John <pjohn@mvista.com>
CC:     linux-mips@linux-mips.org
Subject: Re: [PATCH] MIPS: Octeon: add option to ignore PT_NOTE section
References: <1302710833.14458.1.camel@localhost.localdomain>     <4DA5DF7A.1030207@caviumnetworks.com> <1302803815.3322.4.camel@localhost.localdomain> <4DA74DFE.7030905@mvista.com>
In-Reply-To: <4DA74DFE.7030905@mvista.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 14 Apr 2011 20:02:28.0152 (UTC) FILETIME=[E1675380:01CBFADE]
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 29759
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips

On 04/14/2011 12:41 PM, Philby John wrote:
> Another finding to be noted about this approach is that, booting works
> fine with just these lines of code
>
> +#ifndef CONFIG_DISABLE_ELF_NOTE_HEADER
>   	NOTES :text :note
> +#else
> +	NOTES :text
> +#endif
>
> And IMHO we should be just using this, which is what you get if one were
> to use the command
> $mips-gnu-strip -R .notes vmlinux -o fixed-vmlinux
>
> So with just the above lines of code or with the strip command above
> readelf shows this output
>
> Elf file type is EXEC (Executable file)
> Entry point 0xffffffff81105d10
> There are 2 program headers, starting at offset 64
>
> Program Headers:
>    Type           Offset             VirtAddr           PhysAddr
>                   FileSiz            MemSiz              Flags  Align
>    LOAD           0x0000000000010000 0xffffffff81100000 0xffffffff81100000
>                   0x000000000098be00 0x0000000000a00000  RWE    10000
>    NOTE           0x0000000000000000 0x0000000000000000 0x0000000000000000
>                   0x0000000000000000 0x0000000000000000  R      8
>

Can someone with a defective bootloader verify that a zero size PT_NOTE 
header is as good as *no* PT_NOTE header?

If so, we should just omit the patch all together and tell people who 
are interested to use the strip command instead.

David Daney






>   Section to Segment mapping:
>    Segment Sections...
>     00     .text __ex_table .notes .rodata .pci_fixup __ksymtab
> __ksymtab_gpl __ksymtab_strings __init_rodata __param .data .init.text
> .init.data .exit.text .data.percpu .bss .bss.superpage_aligned
>     01
>
> Where as if one were to remove the PT_NOTE section readelf would show ...
>
> Elf file type is EXEC (Executable file)
> Entry point 0xffffffff81105d10
> There are 1 program headers, starting at offset 64
>
> Program Headers:
>    Type           Offset             VirtAddr           PhysAddr
>                   FileSiz            MemSiz              Flags  Align
>    LOAD           0x0000000000010000 0xffffffff81100000 0xffffffff81100000
>                   0x000000000098be00 0x0000000000a00000  RWE    10000
>
>   Section to Segment mapping:
>    Segment Sections...
>     00     .text __ex_table .notes .rodata .pci_fixup __ksymtab
> __ksymtab_gpl __ksymtab_strings __init_rodata __param .data .init.text
> .init.data .exit.text .data.percpu .bss .bss.superpage_aligned
>
>
> Shouldn't we just follow what strip does?
>
> Regards,
> Philby
>
> On 04/14/2011 11:26 PM, philby john wrote:
>> From: David Daney<ddaney@caviumnetworks.com>
>> Date: Wed, 13 Apr 2011 20:46:32 +0530
>> Subject: [PATCH] MIPS: Octeon: add option to ignore PT_NOTE section
>>
>> Some early Octeon bootloaders cannot process PT_NOTE program
>> headers as reported in numerous sections of the web, here is
>> an example http://www.spinics.net/lists/mips/msg37799.html
>> Loading usually fails with such an error ...
>> Error allocating memory for elf image!
>>
>> The work around usually is to strip the .notes section by using
>> such a command $mips-gnu-strip -R .notes vmlinux -o fixed-vmlinux
>> It is expected that the vmlinux image got after compilation be
>> bootable. Add a Kconfig option to ignore the PT_NOTE section.
>>
>> Signed-off-by: David Daney<ddaney@caviumnetworks.com>
>> Signed-off-by: Philby John<pjohn@mvista.com>
>> ---
>>   arch/mips/cavium-octeon/Kconfig |    8 ++++++++
>>   arch/mips/kernel/vmlinux.lds.S  |    6 ++++++
>>   2 files changed, 14 insertions(+), 0 deletions(-)
>>
>> diff --git a/arch/mips/cavium-octeon/Kconfig b/arch/mips/cavium-octeon/Kconfig
>> index caae228..ddecee3 100644
>> --- a/arch/mips/cavium-octeon/Kconfig
>> +++ b/arch/mips/cavium-octeon/Kconfig
>> @@ -90,6 +90,14 @@ config CAVIUM_OCTEON_LOCK_L2_MEMCPY
>>   	help
>>   	  Lock the kernel's implementation of memcpy() into L2.
>>
>> +config DISABLE_ELF_NOTE_HEADER
>> +       bool "Disable the creation of the ELF PT_NOTE program header in vmlinux"
>> +       depends on CPU_CAVIUM_OCTEON
>> +       help
>> +         Some early Octeon bootloaders cannot process PT_NOTE program
>> +         headers.  Select y to omit these headers so that the kernel
>> +         can be loaded with older bootloaders.
>> +
>>   config ARCH_SPARSEMEM_ENABLE
>>   	def_bool y
>>   	select SPARSEMEM_STATIC
>> diff --git a/arch/mips/kernel/vmlinux.lds.S b/arch/mips/kernel/vmlinux.lds.S
>> index 832afbb..0536910 100644
>> --- a/arch/mips/kernel/vmlinux.lds.S
>> +++ b/arch/mips/kernel/vmlinux.lds.S
>> @@ -8,7 +8,9 @@ OUTPUT_ARCH(mips)
>>   ENTRY(kernel_entry)
>>   PHDRS {
>>   	text PT_LOAD FLAGS(7);	/* RWX */
>> +#ifndef CONFIG_DISABLE_ELF_NOTE_HEADER
>>   	note PT_NOTE FLAGS(4);	/* R__ */
>> +#endif
>>   }
>>
>>   #ifdef CONFIG_32BIT
>> @@ -62,7 +64,11 @@ SECTIONS
>>   		__stop___dbe_table = .;
>>   	}
>>
>> +#ifndef CONFIG_DISABLE_ELF_NOTE_HEADER
>>   	NOTES :text :note
>> +#else
>> +	NOTES :text
>> +#endif
>>   	.dummy : { *(.dummy) } :text
>>
>>   	RODATA
>
>
