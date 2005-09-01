Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 01 Sep 2005 06:17:05 +0100 (BST)
Received: from smtpr4.tom.com ([IPv6:::ffff:202.108.252.134]:23952 "HELO
	tom.com") by linux-mips.org with SMTP id <S8225377AbVIAFQm>;
	Thu, 1 Sep 2005 06:16:42 +0100
Received: from [192.168.10.105] (unknown [218.94.38.156])
	by bjapp14 (Coremail) with SMTP id JAD1ViWQFkNKACac.1
	for <yyuasa@gmail.com>; Thu, 01 Sep 2005 13:22:49 +0800 (CST)
X-Originating-IP: [218.94.38.156]
Message-ID: <43169027.8060102@tom.com>
Date:	Thu, 01 Sep 2005 13:22:47 +0800
From:	Zhuang Yuyao <ihollo@tom.com>
User-Agent: Mozilla Thunderbird 1.0.6 (Windows/20050716)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To:	Yoichi Yuasa <yyuasa@gmail.com>, linux-mips@linux-mips.org
Subject: Re: [ADMtek 5120] 64M sdram on board but only 16M is deteted and
 usable
References: <431671CF.8070906@tom.com> <4955666b050831203143785a7f@mail.gmail.com>
In-Reply-To: <4955666b050831203143785a7f@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <ihollo@tom.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8851
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ihollo@tom.com
Precedence: bulk
X-list: linux-mips

Hi,

No, I am not using fixed memory size.

The original source code (part) in arch/mips/adm5120/memory.c is:
......
#define ADM5120_MEMCTRL                 0x1200001c
#define ADM5120_MEMCTRL_SDRAM_MASK      0x7

static const unsigned long adm_sdramsize[] __initdata = {
        0x0,            /* Reserved */
        0x0400000,      /* 4Mb */
        0x0800000,      /* 8Mb */
        0x1000000,      /* 16Mb */
        0x4000000,      /* 64Mb */
        0x8000000,      /* 128Mb */
};

void __init prom_meminit(void)
{
        unsigned long base=CPHYSADDR(PFN_ALIGN(&_end));
        unsigned long size;

        u32 memctrl = *(u32*)KSEG1ADDR(ADM5120_MEMCTRL);
        size = adm_sdramsize[memctrl & ADM5120_MEMCTRL_SDRAM_MASK];
         add_memory_region(base, size-base, BOOT_MEM_RAM);
}
......

memctrl value returns 0x50403 even though the actual memory size is 64M.

Then I tried to manually set KSEG1ADDR(ADM5120_MEMCTRL) to 0x50404 by 
inserting the following lines into prom_meminit(void).

        unsigned long size;

+      u32* pm = (u32*)KSEG1ADDR(ADM5120_MEMCTRL);
+      *pm = (*pm & ~ADM5120_MEMCTRL_SDRAM_MASK) + 0x4;

        u32 memctrl = *(u32*)KSEG1ADDR(ADM5120_MEMCTRL);

memctrl value returns 0x50404, the boot is failed but many messages 
printed to the console:

**********************************************************************
                            Linux Boot Loader


Copyright 2002-2003  ADMtek, Inc.



CPU: ADM5120 Home Gateway Processor
Boot Loader Version: 2.00.0125
Creation Date: 2003.07.09

Linux version 2.6.12 (root@debian) (gcc version 3.4.2) #36 Wed Aug 31 
22:52:06 MDT 2005
memctrl: 50404
CPU revision is: 0001800b
ADM5120 board setup
Determined physical RAM map:
 memory: 03b0b000 @ 004f5000 (usable)
Built 1 zonelists
Kernel command line:
Primary instruction cache 8kB, physically tagged, 2-way, linesize 16 bytes.
Primary data cache 8kB, 2-way, linesize 16 bytes.
Synthesized TLB refill handler (19 instructions).
Synthesized TLB load handler fastpath (31 instructions).
Synthesized TLB store handler fastpath (31 instructions).
Synthesized TLB modify handler fastpath (30 instructions).
PID hash table entries: 512 (order: 9, 8192 bytes)
CPU clock: 175MHz
Dentry cache hash table entries: 16384 (order: 4, 65536 bytes)
Inode-cache hash table entries: 8192 (order: 3, 32768 bytes)
Memory: 59776k/60460k available (2369k kernel code, 624k reserved, 375k 
data, 2004k init, 0k highmem)
Mount-cache hash table entries: 512
Data bus error, epc == 80108e50, ra == 8005c21c
Oops in arch/mips/kernel/traps.c::do_be, line 354[#1]:
Cpu 0
$ 0   : 00000000 10008c00 804fb410 8c8506e4
$ 4   : 804fb410 b31e0620 00000040 ffffffff
$ 8   : 00000002 00000000 00000000 804b0000
$12   : 80288214 00100100 00200200 804fc8f4
$16   : 804fb400 804fc960 804fc96c 8109eac0
$20   : 804b0000 00000000 000000d0 11110017
$24   : 00000000 80283de2                 
$28   : 80282000 80283e28 80ee1da0 8005c21c
Hi    : 00000000
Lo    : 00000ea0
epc   : 80108e50 both_aligned+0x10/0x64     Not tainted
ra    : 8005c21c cache_alloc_refill+0x254/0x690
Status: 10008c02    KERNEL EXL
Cause : 3080001c
PrId  : 0001800b
Modules linked in:
Process swapper (pid: 0, threadinfo=80282000, task=80284000)
Stack : 0000000d 804b0000 10008c01 000041ed 804fb000 800c2130 10008c01 
804f7ed4
        00000000 80255da0 804b0000 00000000 11110016 11110017 80ee1da0 
8005bc60
        804fb000 8009fffc 804fc86c 00000000 00000000 8009e67c 804fb000 
000041ed
        00000000 800a0814 00000000 804f7ed4 80000000 800c2130 00000000 
8009e924
        00000000 800849d4 8028994c 8025e89c 804f7ed4 804fb000 800c21a8 
800c2190
        ...
Call Trace:
 [<800c2130>] ramfs_fill_super+0x0/0xac
 [<8005bc60>] kmem_cache_alloc+0x94/0x9c
 [<8009fffc>] alloc_inode+0x11c/0x144
 [<8009e67c>] d_alloc+0x34/0x228
 [<800a0814>] new_inode+0x14/0x8c
 [<800c2130>] ramfs_fill_super+0x0/0xac
 [<8009e924>] d_alloc_root+0x30/0x68
 [<800849d4>] sget+0x324/0x3ac
 [<800c21a8>] ramfs_fill_super+0x78/0xac
 [<800c2190>] ramfs_fill_super+0x60/0xac
 [<800c2130>] ramfs_fill_super+0x0/0xac
 [<800859b0>] get_sb_nodev+0x84/0xdc
 [<800a31a8>] alloc_vfsmnt+0xa8/0xe8
 [<8005ddcc>] kmem_cache_create+0x770/0x7c4
 [<80085b54>] do_kern_mount+0x68/0x1b0
 [<802c58f0>] mnt_init+0xe4/0x280
 [<802c5848>] mnt_init+0x3c/0x280
 [<802c575c>] inode_init+0x4c/0xfc
 [<802c5538>] vfs_caches_init+0x100/0x1d0
 [<802c5528>] vfs_caches_init+0xf0/0x1d0
 [<800f88c0>] key_link+0x40/0x5c
 [<802b17c8>] start_kernel+0x1e8/0x260
 [<802b17c0>] start_kernel+0x1e0/0x260
 [<802b112c>] unknown_bootoption+0x0/0x310


Code: 11000017  30d8001f  00000000 <8ca80000> 8ca90004  8caa0008  
8cab000c  24c6ffe0  8cac0010
Kernel panic - not syncing: Attempted to kill the idle task!

******************************************************************

Any suggestions will be appreciated!

Yoichi Yuasa wrote:

>Hi,
>
>2005/9/1, Zhuang Yuyao <ihollo@tom.com>:
>  
>
>>Hi,
>>
>>I've just upgraded the SDRAM on my adm5120 board from 16M to 64M, but
>>while the board is booting, it still reports that only 16M sdram is
>>availible.
>>Since I do not have the source code of the bootloader, is there any way
>>to let the board to boot with 64M sdram, or should I change to another
>>bootloader?
>>    
>>
>
>If you are using add_memory_region() with fixed memory size,
>you should change the value of it.
>
>Yoichi
>
>
>  
>
