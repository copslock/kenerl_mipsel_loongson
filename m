Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 09 Oct 2004 09:34:13 +0100 (BST)
Received: from adsl-68-124-224-226.dsl.snfc21.pacbell.net ([IPv6:::ffff:68.124.224.226]:8708
	"EHLO goobz.com") by linux-mips.org with ESMTP id <S8224990AbUJIIeG>;
	Sat, 9 Oct 2004 09:34:06 +0100
Received: from [10.2.2.70] (adsl-63-194-214-47.dsl.snfc21.pacbell.net [63.194.214.47])
	by goobz.com (8.10.1/8.10.1) with ESMTP id i998Xvu19241;
	Sat, 9 Oct 2004 01:33:58 -0700
Message-ID: <4167A26B.4050706@embeddedalley.com>
Date: Sat, 09 Oct 2004 01:33:47 -0700
From: Pete Popov <ppopov@embeddedalley.com>
User-Agent: Mozilla Thunderbird 0.7.3 (X11/20040803)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Christian Hecimovic <checimovic@sutus.com>
CC: linux-mips@linux-mips.org
Subject: Re: Building 2.6 cvs head on db1550
References: <200410011054.39764.checimovic@sutus.com>
In-Reply-To: <200410011054.39764.checimovic@sutus.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <ppopov@embeddedalley.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5990
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ppopov@embeddedalley.com
Precedence: bulk
X-list: linux-mips

Christian Hecimovic wrote:

>I'm having problems building 2.6 head from the linux-mips cvs. There were a 
>number of build errors with the /arch/mips/config/db1550-defconfig file. 
>Eventually, it built with a number of fixes. Here's the diff:
>  
>
I have fixes for all these problems and will push them this coming week.

<snip>

>After building and loading the kernel, it panics:
>
>YAMON> go . idebus=50 root=/dev/hdg1
>Linux version 2.6.9-rc2 (ajain@debianFAI) (gcc version 3.3.2) #3 Thu Sep 30
>16:4
>CPU revision is: 03030200
>AMD Alchemy Au1550/Db1550 Board
>(PRId 03030200) @ 396MHZ
>BCLK switching enabled!
>Determined physical RAM map: memory: 0c000000 @ 00000000 (usable)
>Built 1 zonelists
>Kernel command line: idebus=50 root=/dev/hdg1 console=ttyS0,115200
>ide_setup: idebus=50
>Primary instruction cache 16kB, physically tagged, 4-way, linesize 32 bytes.
>Primary data cache 16kB 4-way, linesize 32 bytes.
>PID hash table entries: 1024 (order: 10, 16384 bytes)
>calculating r4koff... 00060ae0(396000)
>CPU frequency 396.00 MHz
>Dentry cache hash table entries: 32768 (order: 5, 131072 bytes)
>Inode-cache hash table entries: 16384 (order: 4, 65536 bytes)
>Memory: 189952k/196608k available (2771k kernel code, 6524k reserved, 668k
>data)
>Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
>Checking for 'wait' instruction...  unavailable.
>NET: Registered protocol family 16
>Non-coherent PCI accesses enabled
>Can't analyze prologue code at 803b373c
>Linux Kernel Card Services
>  options:  [pci]
>Reserved instruction in kernel code in arch/mips/kernel/traps.c::do_ri, line 
>61:
>Cpu 0
>$ 0   : 00000000 80490000 fffffffa c000305c
>$ 4   : 8048bad0 0000000f 803ca06c 00000030
>$ 8   : 00000000 812c9078 00000001 00000001
>$12   : 00000003 ffffffff 0000000a 00000000
>$16   : 8048baf0 8048bad0 804766d0 00000000
>$20   : 00000000 00000000 00000000 00000000
>$24   : 00000010 812bf2c9
>$28   : 811fe000 811fff10 00000000 80289ba4
>Hi    : 08366dd9
>Lo    : 1db6cb20
>epc   : 80289adc zlib_inflateInit2_+0x60/0xf0     Not tainted
>ra    : 80289ba4 zlib_inflateInit_+0x18/0x24
>Status: 1000fc03    KERNEL EXL IE
>Cause : 00800028
>PrId  : 03030200
>Process swapper (pid: 1, threadinfo=811fe000, task=811fd8b8)
>Stack : 8048baf0 00000000 804766d0 00000000 8048baf0 00000000 80289ba4
>8016766c
>        00000000 00000000 00000000 80221f50 80228a88 8046b7cc 8046ad54
>8046ad2c
>        00000000 00000000 804765d4 8046b9f0 00000000 00000000 00000000
>00000000
>        8045d7c8 8045d7c8 80470e30 80467a54 00000000 00000000 803b6c7c
>00000000
>        00000000 8045d8b8 00000000 00000000 00000000 00000000 801006dc
>00000000
>        ...
>Call Trace:
> [<80289ba4>] zlib_inflateInit_+0x18/0x24
> [<8016766c>] vmalloc+0x14/0x20
> [<80221f50>] init_inodecache+0x30/0x50
> [<80228a88>] cramfs_uncompress_init+0x84/0x9c
> [<8046b7cc>] journal_init_caches+0x2c/0x44
> [<8046ad54>] eventpoll_init+0xac/0xdc
> [<8046ad2c>] eventpoll_init+0x84/0xdc
> [<8046b9f0>] init_cramfs_fs+0x10/0x28
> [<8045d7c8>] do_initcalls+0x50/0x108
> [<8045d7c8>] do_initcalls+0x50/0x108
> [<80470e30>] sock_init+0x54/0x6c
> [<80467a54>] sysctl_init+0x28/0x34
> [<8045d8b8>] do_basic_setup+0x38/0x44
> [<801006dc>] init+0x3c/0x118
> [<80107cd4>] kernel_thread_helper+0x10/0x18
> [<80107cc4>] kernel_thread_helper+0x0/0x18
>Code: 2463005c  ac83001c  ac800018 <ac600014> 8c82001c  04a0001c  ac40000c
>24a
>Kernel panic - not syncing: Attempted to kill init!
>
>
>
>After fooling with make menuconfig (turned off 64 bit support, PCMCIA, NFS, 
>etc.) I got it to the point where it would load, but then couldn't mount root 
>from hdg1. It cannot seem to find the hard drive at all.
>
>2.4.25 correctly boots and mounts root from the ide drive.
>
>Has anyone gotten the 2.6 kernel from cvs head to boot on a db1550, and 
>successfully mount root from an ide hard drive? If so, how?
>  
>
I recently replied to a similar email, right before I left for vacation.

The 2.6 kernel right now is missing the 36 bit support, and pcmcia, pci, 
and lcd chip select won't work. I'll send the patch next week.  The rest 
of the problems you reported have been fixed in patches that are in my 
queue.

Pete
