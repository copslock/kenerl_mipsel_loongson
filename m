Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 08 Jun 2007 08:53:58 +0100 (BST)
Received: from [222.92.8.141] ([222.92.8.141]:22168 "HELO lemote.com")
	by ftp.linux-mips.org with SMTP id S20021814AbXFHHx4 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 8 Jun 2007 08:53:56 +0100
Received: (qmail 17551 invoked by uid 511); 8 Jun 2007 08:00:30 -0000
Received: from unknown (HELO ?192.168.2.233?) (192.168.2.233)
  by lemote.com with SMTP; 8 Jun 2007 08:00:30 -0000
Message-ID: <46690AC3.8000805@lemote.com>
Date:	Fri, 08 Jun 2007 15:52:35 +0800
From:	Tian <tiansm@lemote.com>
User-Agent: Icedove 1.5.0.8 (X11/20061116)
MIME-Version: 1.0
To:	Tian <tiansm@lemote.com>
CC:	Ralf Baechle <ralf@linux-mips.org>,
	Franck Bui-Huu <vagabon.xyz@gmail.com>,
	linux-mips@linux-mips.org, Fuxin Zhang <zhangfx@lemote.com>
Subject: Re: [PATCH] cheat for support of more than 256MB memory
References: <11811049622818-git-send-email-tiansm@lemote.com> <11811049643791-git-send-email-tiansm@lemote.com> <cda58cb80706052338y461f707fq790e204f55a23cc0@mail.gmail.com> <20070606164018.GA30017@linux-mips.org> <4668DF7A.6040807@lemote.com>
In-Reply-To: <4668DF7A.6040807@lemote.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-Path: <tiansm@lemote.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15353
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tiansm@lemote.com
Precedence: bulk
X-list: linux-mips

Tian wrote:
> Ralf Baechle wrote:
>> On Wed, Jun 06, 2007 at 08:38:18AM +0200, Franck Bui-Huu wrote:
>>
>>  
>>>> diff --git a/arch/mips/kernel/setup.c b/arch/mips/kernel/setup.c
>>>> index 4975da0..62ef100 100644
>>>> --- a/arch/mips/kernel/setup.c
>>>> +++ b/arch/mips/kernel/setup.c
>>>> @@ -509,6 +509,14 @@ static void __init resource_init(void)
>>>>                res->end = end;
>>>>
>>>>                res->flags = IORESOURCE_MEM | IORESOURCE_BUSY;
>>>> +#if defined(CONFIG_LEMOTE_FULONG) && defined(CONFIG_64BIT)
>>>> +               /* to keep memory continous, we tell system 
>>>> 0x10000000 - 0x20000000 is reserved
>>>> +                * for memory, in fact it is io region, don't 
>>>> occupy it
>>>> +                *
>>>> +                * SPARSEMEM?
>>>>       
>>> Definetly yes ! It has been designed for such issue and it should save
>>> you some memory.
>>>     
>>
>> A hole of 256MB size in the memory address map will cost 3.5MB with a 
>> 64-bit
>> kernel.  The other reason why I don't like this patch is that it drags
>> platform specific code into the generic MIPS code.
>>
>>   Ralf
>>
>>
>>   
> we use 16k page，so it's cheaper than that:)
>
> Before I work out sparse memory solution, I think I can drop this 
> patch and make some trivial fix of the first patch.
>
> Subject: [PATCH] simply ignore the memory hole
>
> Signed-off-by: Songmao Tian <tiansm@lemote.com>
> ---
> arch/mips/lemote/lm2e/setup.c |    1 -
> 1 files changed, 0 insertions(+), 1 deletions(-)
>
> diff --git a/arch/mips/lemote/lm2e/setup.c 
> b/arch/mips/lemote/lm2e/setup.c
> index 3030518..2498bbf 100644
> --- a/arch/mips/lemote/lm2e/setup.c
> +++ b/arch/mips/lemote/lm2e/setup.c
> @@ -112,7 +112,6 @@ void __init plat_mem_setup(void)
>     add_memory_region(0x0, (memsize << 20), BOOT_MEM_RAM);
> #ifdef CONFIG_64BIT
>     if (highmemsize > 0) {
> -        add_memory_region(0x10000000, 0x10000000, BOOT_MEM_RESERVED);
>         add_memory_region(0x20000000, highmemsize << 20, BOOT_MEM_RAM);
>     }
> #endif
>
>
>
It seems it's no need to modify code, just config to use
sparse memory will be ok, paging_init can handle the
non-flat-memory situatioins, and i notify the pages drop down as expected.


Subject: [PATCH] use SPARSEMEM to deal with the memory hole of peripheral IO

Signed-off-by: Songmao Tian <tiansm@lemote.com>
---
 arch/mips/Kconfig                  |    1 +
 arch/mips/configs/fulong_defconfig |   13 +++++++------
 2 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 16f1861..376cbd6 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -957,6 +957,7 @@ config CPU_LOONGSON2
     depends on SYS_HAS_CPU_LOONGSON2
     select CPU_SUPPORTS_32BIT_KERNEL
     select CPU_SUPPORTS_64BIT_KERNEL
+    select ARCH_SPARSEMEM_ENABLE
     select CPU_SUPPORTS_HIGHMEM
 
 config CPU_MIPS32_R1
diff --git a/arch/mips/configs/fulong_defconfig 
b/arch/mips/configs/fulong_defconfig
index cd6563a..92d9772 100644
--- a/arch/mips/configs/fulong_defconfig
+++ b/arch/mips/configs/fulong_defconfig
@@ -1,7 +1,7 @@
 #
 # Automatically generated make config: don't edit
 # Linux kernel version: 2.6.22-rc3
-# Wed Jun  6 11:42:13 2007
+# Fri Jun  8 15:09:24 2007
 #
 CONFIG_MIPS=y
 
@@ -118,13 +118,14 @@ CONFIG_GENERIC_IRQ_PROBE=y
 CONFIG_CPU_SUPPORTS_HIGHMEM=y
 CONFIG_SYS_SUPPORTS_HIGHMEM=y
 CONFIG_ARCH_FLATMEM_ENABLE=y
+CONFIG_ARCH_SPARSEMEM_ENABLE=y
 CONFIG_SELECT_MEMORY_MODEL=y
-CONFIG_FLATMEM_MANUAL=y
+# CONFIG_FLATMEM_MANUAL is not set
 # CONFIG_DISCONTIGMEM_MANUAL is not set
-# CONFIG_SPARSEMEM_MANUAL is not set
-CONFIG_FLATMEM=y
-CONFIG_FLAT_NODE_MEM_MAP=y
-# CONFIG_SPARSEMEM_STATIC is not set
+CONFIG_SPARSEMEM_MANUAL=y
+CONFIG_SPARSEMEM=y
+CONFIG_HAVE_MEMORY_PRESENT=y
+CONFIG_SPARSEMEM_STATIC=y
 CONFIG_SPLIT_PTLOCK_CPUS=4
 CONFIG_RESOURCES_64BIT=y
 CONFIG_ZONE_DMA_FLAG=0
