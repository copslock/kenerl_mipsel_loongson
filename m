Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 08 Jul 2009 12:38:04 +0200 (CEST)
Received: from h5.dl5rb.org.uk ([81.2.74.5]:39662 "EHLO h5.dl5rb.org.uk"
	rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org with ESMTP
	id S1493022AbZGHKh6 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 8 Jul 2009 12:37:58 +0200
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
	by h5.dl5rb.org.uk (8.14.3/8.14.3) with ESMTP id n68AbuL8025373;
	Wed, 8 Jul 2009 11:37:56 +0100
Received: (from ralf@localhost)
	by h5.dl5rb.org.uk (8.14.3/8.14.3/Submit) id n68AbuEf025371;
	Wed, 8 Jul 2009 11:37:56 +0100
Date:	Wed, 8 Jul 2009 11:37:56 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	joe seb <joe.seb8@gmail.com>
Cc:	linux-mips@linux-mips.org
Subject: Re: Linux port failing on MIPS32 24Kc
Message-ID: <20090708103756.GB22308@linux-mips.org>
References: <4f9abdc70907080107t28fdac03h86b834a60806fb10@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4f9abdc70907080107t28fdac03h86b834a60806fb10@mail.gmail.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
Return-Path: <ralf@h5.dl5rb.org.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23677
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, Jul 08, 2009 at 01:37:42PM +0530, joe seb wrote:

> We are trying to port linux 2.6.29.4 version of the kernel from
> linux-mips.org site to our MIPS 24K based platform and we see issues when we
> use the cache in write-back mode. Cache with write-through configuration
> works fine.
> We use:
> Linux kernel - 2.6.29.4
> GNU cross tools - 4.3.2
> Busybox - 1.14.1
> U-boot - 2009.03
> 
> Our platform has 256MB of RAM and its mapped to second 256 MB of the KSEG0
> (0x90000000 - 0x9FFFFFFF) and KSEG1 (0xB0000000 - 0xBFFFFFFF), and we
> specify that "mem=16M@256M" as boot parameter (we just want to use the first
> 16MB by the kernel). The cache initialization for the KSEG0 is done in
> u-boot.
> 
> The error we get when cache is configured as write-back is given below:
> 
> --------------------
> Linux version 2.6.29.4 (gcc version 4.3.2 (Sourcery G
> ++ Lite 4.3-51) ) #11 PREEMPT Tue Jul 7 21:16:00 IST 2009
> CPU revision is: 0101937c (MIPS 24Kc)
> Determined physical RAM map:
> User-defined physical RAM map:
>  memory: 01000000 @ 10000000 (usable)
> Wasting 2097152 bytes for tracking 65536 unused pages
> Initrd not found or empty - disabling initrd
> Zone PFN ranges:
>   Normal   0x00010000 -> 0x00011000
> Movable zone start PFN for each node
> early_node_map[1] active PFN ranges
>     0: 0x00010000 -> 0x00011000
> Built 1 zonelists in Zone order, mobility grouping off.  Total pages: 4064
> Kernel command line: mem=16M@256M console=ttyS0,9600 cca=3
> Primary instruction cache 32kB, VIPT, 4-way, linesize 32 bytes.
> Primary data cache 32kB, 4-way, PIPT, no aliases, linesize 32 bytes
> Using cache attribute 3
> Writing ErrCtl register=00000000
> Readback ErrCtl register=00000000
> PID hash table entries: 64 (order: 6, 256 bytes)
> CPU frequency 50.00 MHz
> console [ttyS0] enabled
> Dentry cache hash table entries: 2048 (order: 1, 8192 bytes)
> Inode-cache hash table entries: 1024 (order: 0, 4096 bytes)
> Memory: 13776k/16384k available (1210k kernel code, 2608k reserved, 234k
> data, 6
> 76k init, 0k highmem)
> Calibrating delay loop... 33.17 BogoMIPS (lpj=165888)
> Mount-cache hash table entries: 512
> VFS: Disk quotas dquot_6.5.2
> Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
> msgmni has been set to 26
> Serial: 8250/16550 driver, 2 ports, IRQ sharing enabled
> serial8250: ttyS0 at MMIO 0xa1a30000 (irq = 188) is a 16550A
> serial8250: ttyS1 at MMIO 0xa1a40000 (irq = 189) is a 16550A
> Freeing unused kernel memory: 676k freed
> Algorithmics/MIPS FPU Emulator v1.5
> CPU 0 Unable to handle kernel paging request at virtual address cccccccc,
> epc ==
>  cccccccc, ra == cccccccc
> Oops[#1]:
> Cpu 0
> $ 0   : 00000000 0053934a 00000000 00000001
> $ 4   : 00000001 00000000 00000000 0000009a
> $ 8   : 00000010 900038c0 00532730 00532730
> $12   : 00000018 90284880 00020000 00000034
> $16   : cccccccc 9016c320 9016aae0 90213520
> $20   : 00000000 9016a960 00000001 90fa9680
> $24   : 00000000 9009a414
> $28   : 90176000 90177d58 9016aae0 cccccccc
> Hi    : 0000000d
> Lo    : 0000004a
> epc   : cccccccc 0xcccccccc
>     Not tainted
> ra    : cccccccc 0xcccccccc
> Status: 10004403    KERNEL EXL IE
> Cause : 10800008
> BadVA : cccccccc
> PrId  : 0101937c (MIPS 24Kc)
> Process rcS (pid: 11, threadinfo=90176000, task=90200500, tls=0053f470)
> Stack : cccccccc cccccccc 90200500 9016aae0 90213520 00000000 90213520
> 00000000
>         9016aae0 90213520 00000000 90025c28 90200500 90faf9c0 90200500
> 00000107
>         9016aae0 00000107 9016aae0 900a04c8 00000003 902a4a40 902a4a48
> 00000000
>         902a4a44 900b3ad8 90fb1880 90fa9680 00000000 00000003 90fb1880
> 90fa9680
>         90177f30 90da7b20 cccccccc cccccccc cccccccc cccccccc cccccccc
> cccccccc
>         ...
> Call Trace:
> [<90025c28>] mmput+0x9c/0x194
> [<900a04c8>] flush_old_exec+0x47c/0x988
> [<900b3ad8>] alloc_fd+0x9c/0x1a4
> [<90086c88>] handle_mm_fault+0x9a8/0x107c
> [<9002f7c4>] do_softirq+0xc8/0xd0
> [<900cc60c>] load_elf_binary+0x0/0x1410
> [<9009fd9c>] search_binary_handler+0xa0/0x2bc
> [<900a138c>] do_execve+0x298/0x300
> [<900a4c60>] getname+0x28/0xc8
> [<9000c714>] sys_execve+0x4c/0x78
> [<90002398>] stack_done+0x20/0x3c
> 
> Code: (Bad address in epc)
> do_cpu invoked from kernel context![#2]:
> Cpu 0
> $ 0   : 00000000 90210000 9016a98c 00000001
> $ 4   : 00000002 00000003 90168468 00000000
> $ 8   : 000007c4 00000004 9016846c 00000001
> $12   : ffffff80 00000000 90136f7c 00000010
> $16   : 00000000 00000000 90200500 90213520
> $20   : 9016a994 90177ca8 00000000 90fa9680
> $24   : 00000000 90121648
> $28   : 90176000 90177b48 9016aae0 90fa9680
> Hi    : 0098963b
> Lo    : 38c9b600
> epc   : 90fa9680 0x90fa9680
>     Tainted: G      D
> ra    : 90fa9680 0x90fa9680
> Status: 10004403    KERNEL EXL IE
> Cause : 1080002c
> PrId  : 0101937c (MIPS 24Kc)
> Process rcS (pid: 11, threadinfo=90176000, task=90200500, tls=0053f470)
> Stack : 9016aae0 900041c4 00000000 00000000 90177ca8 90177ca8 0000000b
> 90200500
>         90200500 cccccccc 00000000 9002cc78 90200658 9016a960 9020065c
> 90213520
>         90152d44 90177ca8 00000001 cccccccc 00000000 90177ca8 90152d44
> 90177ca8
>         90200500 cccccccc 00000000 90177ca8 00000000 90fa9680 9016aae0
> 9000e0d4
>         cccccccc 90220000 ffffffff 00000e89 90177bec cccccccc 9016a960
> 90010f58
>         ...
> Call Trace:
> [<900041c4>] printk+0x24/0x30
> [<9002cc78>] do_exit+0xf4/0x88c
> [<9000e0d4>] nmi_exception_handler+0x0/0x34
> [<90010f58>] do_page_fault+0x2e0/0x350
> [<90070234>] rmqueue_bulk+0x54/0xd8
> [<900b0d48>] touch_atime+0xf8/0x174
> [<9006c7e8>] generic_file_aio_read+0x4d8/0x8d8
> [<90000404>] ret_from_exception+0x0/0x10
> [<900038c0>] __bzero+0xc4/0x164
> [<9009a414>] do_sync_read+0x0/0x168
> [<90025c28>] mmput+0x9c/0x194
> [<900a04c8>] flush_old_exec+0x47c/0x988
> [<900b3ad8>] alloc_fd+0x9c/0x1a4
> [<90086c88>] handle_mm_fault+0x9a8/0x107c
> [<9002f7c4>] do_softirq+0xc8/0xd0
> [<900cc60c>] load_elf_binary+0x0/0x1410
> [<9009fd9c>] search_binary_handler+0xa0/0x2bc
> [<900a138c>] do_execve+0x298/0x300
> [<900a4c60>] getname+0x28/0xc8
> [<9000c714>] sys_execve+0x4c/0x78
> [<90002398>] stack_done+0x20/0x3c
> 
> Code: 040a001a  e5a8b400  4018e618 <464c457f> 00010101  00000000  00000000
> 0008
> 0002  00000001
> Fixing recursive fault but reboot is needed!
> -------------------------------
> 
> We get crashes at different places and the above crash is one of them.
> Do you think this failure is due to the wrong cache configuration or related
> to the d-cache aliasing problem?
> 
> The cache details of our platform:
> D-cache: 32KB, 4-way, 32B line size, virtually indexed and physically
> tagged, Config7[AR] bit is set (alias is removed by the hardware).

Aliases disabled in hardware, yet you suspect aliases?  Doesn't make sense.

> I-cache:  32KB, 4-way, 32B line size,virtually indexed and physically tagged
> 
> 
> Is there any similar 24k platform supported in linux kernel which we are
> refer for the configurations?

There has been a kernel bug for a while which on platforms with a non-zero
memory start address would effectively disable part of of the cache code.
Your description above, including the changed behaviour between write-though
and write-back caches is consistent with that bug.  Commit
67227819d6dd07f6ec225ea59c67aff3ba936e25 fixes this issue.  For your
convenience I append it below.

I'd appreciate feedback on your test results with this patch.

(Why do people use non-zero starting addresses for memory?  Handling of
cache error exceptions is hard enough as it is but with no memory in the
low 32k the design idea of the cache architecture that stores relative to
$zero can be used goes down the drain and (not considering platform-specific
solutions here) only be handled by burning the scarce resource of a TLB
entry for an extremly rare event ...)

  Ralf
