Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 12 Oct 2004 07:25:08 +0100 (BST)
Received: from adsl-68-124-224-226.dsl.snfc21.pacbell.net ([IPv6:::ffff:68.124.224.226]:64774
	"EHLO goobz.com") by linux-mips.org with ESMTP id <S8224919AbUJLGZB>;
	Tue, 12 Oct 2004 07:25:01 +0100
Received: from [10.2.2.70] (adsl-63-194-214-47.dsl.snfc21.pacbell.net [63.194.214.47])
	by goobz.com (8.10.1/8.10.1) with ESMTP id i9C6Osu06300;
	Mon, 11 Oct 2004 23:24:57 -0700
Message-ID: <416B78AB.9090007@embeddedalley.com>
Date: Mon, 11 Oct 2004 23:24:43 -0700
From: Pete Popov <ppopov@embeddedalley.com>
User-Agent: Mozilla Thunderbird 0.7.3 (X11/20040803)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Christian Hecimovic <checimovic@sutus.com>
CC: linux-mips@linux-mips.org
Subject: Re: Building 2.6 cvs head on db1550
References: <200410011054.39764.checimovic@sutus.com>
In-Reply-To: <200410011054.39764.checimovic@sutus.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <ppopov@embeddedalley.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6019
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ppopov@embeddedalley.com
Precedence: bulk
X-list: linux-mips

Christian,

Pull the latest bits from linux-mips and try again. Make sure you apply 
the patches in my ftp.linux-mips.org directory. Unfortunately there 
appears to be a bug in the hpt driver because other ide drivers work 
fine.  I need to revisit this later. Also, the pcmcia driver for the 
db1550 isn't ready but I'll complete that shortly.

Pete

Christian Hecimovic wrote:
> I'm having problems building 2.6 head from the linux-mips cvs. There were a 
> number of build errors with the /arch/mips/config/db1550-defconfig file. 
> Eventually, it built with a number of fixes. Here's the diff:
> 
> Index: arch/mips/Kconfig
> ===================================================================
> RCS file: /home/cvs/linux/arch/mips/Kconfig,v
> retrieving revision 1.96
> diff -r1.96 Kconfig
> 583a584
> 
>>	select DMA_NONCOHERENT
> 
> Index: arch/mips/Makefile
> ===================================================================
> RCS file: /home/cvs/linux/arch/mips/Makefile,v
> retrieving revision 1.176
> diff -r1.176 Makefile
> 19c19
> < 32bit-tool-prefix	= mipsel-linux-
> ---
> 
>>32bit-tool-prefix	= mipsel-unknown-linux-gnu-
> 
> Index: arch/mips/mm/ioremap.c
> ===================================================================
> RCS file: /home/cvs/linux/arch/mips/mm/ioremap.c,v
> retrieving revision 1.19
> diff -r1.19 ioremap.c
> 99a100,110
> 
>> *  * Allow physical addresses to be fixed up to help 36 bit
>> *   * peripherals.
>> *    */
>>static phys_t def_fixup_bigphys_addr(phys_t phys_addr, phys_t size)
>>{
>>	        return phys_addr;
>>}
>>
>>phys_t (*fixup_bigphys_addr)(phys_t phys_addr, phys_t size) = 
> 
> def_fixup_bigphys_addr;
> 
>>/*
> 
> 121a133,134
> 
>>	phys_addr = fixup_bigphys_addr(phys_addr, size);
>>
> 
> Index: drivers/mtd/maps/db1550-flash.c
> ===================================================================
> RCS file: /home/cvs/linux/drivers/mtd/maps/db1550-flash.c,v
> retrieving revision 1.1
> diff -r1.1 db1550-flash.c
> 22c22
> < #include <asm/au1000.h>
> ---
> 
>>#include <asm/mach-au1x00/au1000.h>
> 
> Index: drivers/pcmcia/Makefile
> ===================================================================
> RCS file: /home/cvs/linux/drivers/pcmcia/Makefile,v
> retrieving revision 1.34
> diff -r1.34 Makefile
> 46a47
> 
>>au1x00_ss-$(CONFIG_MIPS_DB1550)			+= au1000_db1x00.o
> 
> Index: drivers/pcmcia/au1000_generic.c
> ===================================================================
> RCS file: /home/cvs/linux/drivers/pcmcia/au1000_generic.c,v
> retrieving revision 1.14
> diff -r1.14 au1000_generic.c
> 80c80
> < #elif defined(CONFIG_MIPS_DB1000) || defined(CONFIG_MIPS_DB1100) || 
> defined(CONFIG_MIPS_DB1500)
> ---
> 
>>#elif defined(CONFIG_MIPS_DB1000) || defined(CONFIG_MIPS_DB1100) || 
> 
> defined(CONFIG_MIPS_DB1500) || defined(CONFIG_MIPS_DB1550)
> 152,153d151
> < 	printk(KERN_DEBUG, "%s initializing socket %u\n", __FUNCTION__, skt->nr);
> < 
> 315,316d312
> < 		printk(KERN_ERR, "%smap (%d) out of range\n",
> < 				__FUNCTION__, map->map);
> 339,340d334
> < 		printk(KERN_ERR, "%s map (%d) out of range\n", 
> < 				__FUNCTION__, map->map);
> 353c347
> < 		map->sys_start = skt->phys_attr + map->card_start;
> ---
> 
>>		map->static_start = skt->phys_attr + map->card_start;
> 
> 356c350
> < 		map->sys_start = skt->phys_mem + map->card_start;
> ---
> 
>>		map->static_start = skt->phys_mem + map->card_start;
> 
> 359,361c353,354
> < 	map->sys_stop=map->sys_start+MAP_SIZE;
> < 	debug(4, "set_mem_map %d start %Lx stop %Lx card_start %x\n", 
> < 			map->map, map->sys_start, map->sys_stop, 
> ---
> 
>>	debug(4, "set_mem_map %d start %Lx card_start %x\n", 
>>			map->map, map->sys_static, 
> 
> Index: drivers/pcmcia/au1000_generic.h
> ===================================================================
> RCS file: /home/cvs/linux/drivers/pcmcia/au1000_generic.h,v
> retrieving revision 1.1
> diff -r1.1 au1000_generic.h
> 48c48
> < #elif defined(CONFIG_MIPS_DB1000) || defined(CONFIG_MIPS_DB1100) || 
> defined(CONFIG_MIPS_DB1500)
> ---
> 
>>#elif defined(CONFIG_MIPS_DB1000) || defined(CONFIG_MIPS_DB1100) || 
> 
> defined(CONFIG_MIPS_DB1500) || defined(CONFIG_MIPS_DB1550)
> Index: include/asm-mips/bootinfo.h
> ===================================================================
> RCS file: /home/cvs/linux/include/asm-mips/bootinfo.h,v
> retrieving revision 1.75
> diff -r1.75 bootinfo.h
> 177a178
> 
>>#define  MACH_DB1550		9       /* Au1550-based eval board */
> 
> Index: include/asm-mips/serial.h
> ===================================================================
> RCS file: /home/cvs/linux/include/asm-mips/serial.h,v
> retrieving revision 1.59
> diff -r1.59 serial.h
> 215c215
> <       .irq = AU1550_UART3_INT,  .flags = STD_COM_FLAGS \
> ---
> 
>>      .irq = AU1550_UART3_INT,  .flags = STD_COM_FLAGS, \
> 
> 
> 
> 
> After building and loading the kernel, it panics:
> 
> YAMON> go . idebus=50 root=/dev/hdg1
> Linux version 2.6.9-rc2 (ajain@debianFAI) (gcc version 3.3.2) #3 Thu Sep 30
> 16:4
> CPU revision is: 03030200
> AMD Alchemy Au1550/Db1550 Board
> (PRId 03030200) @ 396MHZ
> BCLK switching enabled!
> Determined physical RAM map: memory: 0c000000 @ 00000000 (usable)
> Built 1 zonelists
> Kernel command line: idebus=50 root=/dev/hdg1 console=ttyS0,115200
> ide_setup: idebus=50
> Primary instruction cache 16kB, physically tagged, 4-way, linesize 32 bytes.
> Primary data cache 16kB 4-way, linesize 32 bytes.
> PID hash table entries: 1024 (order: 10, 16384 bytes)
> calculating r4koff... 00060ae0(396000)
> CPU frequency 396.00 MHz
> Dentry cache hash table entries: 32768 (order: 5, 131072 bytes)
> Inode-cache hash table entries: 16384 (order: 4, 65536 bytes)
> Memory: 189952k/196608k available (2771k kernel code, 6524k reserved, 668k
> data)
> Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
> Checking for 'wait' instruction...  unavailable.
> NET: Registered protocol family 16
> Non-coherent PCI accesses enabled
> Can't analyze prologue code at 803b373c
> Linux Kernel Card Services
>   options:  [pci]
> Reserved instruction in kernel code in arch/mips/kernel/traps.c::do_ri, line 
> 61:
> Cpu 0
> $ 0   : 00000000 80490000 fffffffa c000305c
> $ 4   : 8048bad0 0000000f 803ca06c 00000030
> $ 8   : 00000000 812c9078 00000001 00000001
> $12   : 00000003 ffffffff 0000000a 00000000
> $16   : 8048baf0 8048bad0 804766d0 00000000
> $20   : 00000000 00000000 00000000 00000000
> $24   : 00000010 812bf2c9
> $28   : 811fe000 811fff10 00000000 80289ba4
> Hi    : 08366dd9
> Lo    : 1db6cb20
> epc   : 80289adc zlib_inflateInit2_+0x60/0xf0     Not tainted
> ra    : 80289ba4 zlib_inflateInit_+0x18/0x24
> Status: 1000fc03    KERNEL EXL IE
> Cause : 00800028
> PrId  : 03030200
> Process swapper (pid: 1, threadinfo=811fe000, task=811fd8b8)
> Stack : 8048baf0 00000000 804766d0 00000000 8048baf0 00000000 80289ba4
> 8016766c
>         00000000 00000000 00000000 80221f50 80228a88 8046b7cc 8046ad54
> 8046ad2c
>         00000000 00000000 804765d4 8046b9f0 00000000 00000000 00000000
> 00000000
>         8045d7c8 8045d7c8 80470e30 80467a54 00000000 00000000 803b6c7c
> 00000000
>         00000000 8045d8b8 00000000 00000000 00000000 00000000 801006dc
> 00000000
>         ...
> Call Trace:
>  [<80289ba4>] zlib_inflateInit_+0x18/0x24
>  [<8016766c>] vmalloc+0x14/0x20
>  [<80221f50>] init_inodecache+0x30/0x50
>  [<80228a88>] cramfs_uncompress_init+0x84/0x9c
>  [<8046b7cc>] journal_init_caches+0x2c/0x44
>  [<8046ad54>] eventpoll_init+0xac/0xdc
>  [<8046ad2c>] eventpoll_init+0x84/0xdc
>  [<8046b9f0>] init_cramfs_fs+0x10/0x28
>  [<8045d7c8>] do_initcalls+0x50/0x108
>  [<8045d7c8>] do_initcalls+0x50/0x108
>  [<80470e30>] sock_init+0x54/0x6c
>  [<80467a54>] sysctl_init+0x28/0x34
>  [<8045d8b8>] do_basic_setup+0x38/0x44
>  [<801006dc>] init+0x3c/0x118
>  [<80107cd4>] kernel_thread_helper+0x10/0x18
>  [<80107cc4>] kernel_thread_helper+0x0/0x18
> Code: 2463005c  ac83001c  ac800018 <ac600014> 8c82001c  04a0001c  ac40000c
> 24a
> Kernel panic - not syncing: Attempted to kill init!
> 
> 
> 
> After fooling with make menuconfig (turned off 64 bit support, PCMCIA, NFS, 
> etc.) I got it to the point where it would load, but then couldn't mount root 
> from hdg1. It cannot seem to find the hard drive at all.
> 
> 2.4.25 correctly boots and mounts root from the ide drive.
> 
> Has anyone gotten the 2.6 kernel from cvs head to boot on a db1550, and 
> successfully mount root from an ide hard drive? If so, how?
> 
> Thanks in advance,
> 
> Christian
> 
> 
