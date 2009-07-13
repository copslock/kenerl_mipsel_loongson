Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 13 Jul 2009 16:47:58 +0200 (CEST)
Received: from wa-out-1112.google.com ([209.85.146.179]:53134 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org
	with ESMTP id S1492664AbZGMOrx (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 13 Jul 2009 16:47:53 +0200
Received: by wa-out-1112.google.com with SMTP id n4so339313wag.0
        for <multiple recipients>; Mon, 13 Jul 2009 07:47:48 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type;
        bh=jwePPwk81ggQtmcLGnd+TNVHHEv/ReAWFxtMPPX7+xk=;
        b=krz3kzTigoaxfjXb4QOEeXlQVnT9L3aSJmp9y/0Cv6EhUX5n2MnpcDNANuy2NF/ptA
         xWiT94YRpNplDVLk4C0pKr3MZ2XPb6MJQ7bMliqYsNlP8hZwO2t2TpbK/0dgxhzrGbWQ
         ZHbNm4ewC/7jtV0+96ddvRh16DTJ67sIFeTYw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=BWlFpDtus4i3ilSi//kRy1EW/P5uw21i4/ojJuxWITEyra7JTLG7lrTNSf9I/J2KDo
         caR9fc+XScyA7Xzv04YnXqrofteU9BGHiQ3IsXzocU0Dw1KyxlXJfK1GerUXAXC1Cme8
         z5rbYwcuDaPLXg6OY1hbqZ90iq/o4zhDKzE1o=
MIME-Version: 1.0
Received: by 10.114.110.20 with SMTP id i20mr2177wac.221.1247496468386; Mon, 
	13 Jul 2009 07:47:48 -0700 (PDT)
In-Reply-To: <20090708103756.GB22308@linux-mips.org>
References: <4f9abdc70907080107t28fdac03h86b834a60806fb10@mail.gmail.com>
	 <20090708103756.GB22308@linux-mips.org>
Date:	Mon, 13 Jul 2009 20:17:48 +0530
Message-ID: <4f9abdc70907130747s1f920008ycdbce135507e2ca9@mail.gmail.com>
Subject: Re: Linux port failing on MIPS32 24Kc
From:	joe seb <joe.seb8@gmail.com>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	linux-mips@linux-mips.org
Content-Type: multipart/alternative; boundary=0016364174e3db55aa046e9767fc
Return-Path: <joe.seb8@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23734
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: joe.seb8@gmail.com
Precedence: bulk
X-list: linux-mips

--0016364174e3db55aa046e9767fc
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Ralf,

We made changes to our MIPS FPGA to map the RAM to KSEG0 (0x80000000) start
address. We still see the issue with the write-back. Write-through is
working fine.

The failure log we got this time is given below:

Linux version 2.6.29.4 () (gcc version 4.3.2 (Sourcery G
++ Lite 4.3-51) ) #15 PREEMPT Mon Jul 13 13:22:21 IST 2009
CPU revision is: 0101937c (MIPS 24Kc)
Determined physical RAM map:
User-defined physical RAM map:
 memory: 10000000 @ 00000000 (usable)
Initrd not found or empty - disabling initrd
Zone PFN ranges:
  Normal   0x00000000 -> 0x00010000
Movable zone start PFN for each node
early_node_map[1] active PFN ranges
    0: 0x00000000 -> 0x00010000
Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 65024
Kernel command line: mem=256M console=ttyS0,9600 cca=3
Primary instruction cache 32kB, VIPT, 4-way, linesize 32 bytes.
Primary data cache 32kB, 4-way, PIPT, no aliases, linesize 32 bytes
Using cache attribute 3
Writing ErrCtl register=00000000
Readback ErrCtl register=00000000
PID hash table entries: 1024 (order: 10, 4096 bytes)
CPU frequency 50.00 MHz
console [ttyS0] enabled
Dentry cache hash table entries: 32768 (order: 5, 131072 bytes)
Inode-cache hash table entries: 16384 (order: 4, 65536 bytes)
Memory: 257092k/262144k available (1211k kernel code, 4728k reserved, 234k
data,
 692k init, 0k highmem)
Calibrating delay loop... 33.17 BogoMIPS (lpj=165888)
Mount-cache hash table entries: 512
VFS: Disk quotas dquot_6.5.2
Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
msgmni has been set to 502
Serial: 8250/16550 driver, 2 ports, IRQ sharing enabled
serial8250: ttyS0 at MMIO 0xb1a30000 (irq = 188) is a 16550A
serial8250: ttyS1 at MMIO 0xb1a40000 (irq = 189) is a 16550A
Freeing unused kernel memory: 692k freed
Algorithmics/MIPS FPU Emulator v1.5
CPU 0 Unable to handle kernel paging request at virtual address ffffb32c,
epc ==
 8f15b32c, ra == 8f15b32c
CPU 0 Unable to handle kernel paging request at virtual address 0000001c,
epc ==
 800210e4, ra == 8002120c
Oops[#1]:
Cpu 0
$ 0   : 00000000 7fccc8e8 fffffff8 00000000
$ 4   : 8021dbf0 00000000 8f81fc60 80220000
$ 8   : 00000000 9b915d6d 8021dbc0 fffffffc
$12   : 0000000f 00000002 80136f7c 00000010
$16   : 00000000 00000000 8021dbc0 8f821eb0
$20   : 00000000 00000000 00000003 ffffffff
$24   : 00000000 0043e4b0
$28   : 8f820000 8f821e00 8021dbc0 8002120c
Hi    : 0098963a
Lo    : ebe5df80
epc   : 800210e4 set_next_entity+0x14/0x8c
    Not tainted
ra    : 8002120c pick_next_task_fair+0x90/0xe4
Status: 10004402    KERNEL EXL
Cause : 00800008
BadVA : 0000001c
PrId  : 0101937c (MIPS 24Kc)
Process init (pid: 1, threadinfo=8f820000, task=8f81fb08, tls=0053f470)
Stack : 00000000 800221a8 00000000 80021550 00000000 00000000 8021dbc0
8002120c
        8f81fb08 80020a90 8f81fb00 8f81fb08 80130000 8f81fb08 8f81fb08
80004924
        7fcccc04 800051a8 8f81fc60 8f168de0 8f81fc60 8f821eb4 8f81fc60
00000001
        8f81fb00 8f81fb08 8f81fbfc 8f821eb0 00000000 00000000 00000003
ffffffff
        00000006 8002c95c 8021dbc0 8f15b238 00000001 8f81fb08 00000003
00000000
        ...
Call Trace:
[<800210e4>] set_next_entity+0x14/0x8c
[<8002120c>] pick_next_task_fair+0x90/0xe4
[<80004924>] schedule+0x5e4/0x72c
[<8002c95c>] do_wait+0x31c/0x4a0
[<8002cbe0>] sys_wait4+0x100/0x174
[<80002398>] stack_done+0x20/0x3c

Code: afb10014  afbf001c  afb00010 <8ca2001c> 00a08821  10400008  00809021
8c82
0024  24b00008
note: init[1] exited with preempt_count 2
BUG: scheduling while atomic: init/1/0x10000003
Call Trace:
[<80003fd0>] dump_stack+0x8/0x38
[<800048a0>] schedule+0x560/0x72c
[<80021774>] __cond_resched+0x18/0x38
[<80004c20>] _cond_resched+0x50/0x58
[<80085874>] unmap_vmas+0x614/0x6d4
[<8008b260>] exit_mmap+0xe8/0x1f8
[<80025dd8>] mmput+0x9c/0x194
[<8002aa40>] exit_mm+0x15c/0x268
[<8002ce28>] do_exit+0xf4/0x88c
[<8000e110>] nmi_exception_handler+0x0/0x34
CPU 0 Unable to handle kernel paging request at virtual address 0000001c,
epc ==
 800210e4, ra == 8002120c
Oops[#2]:
Cpu 0
$ 0   : 00000000 00000001 fffffff8 00000000
$ 4   : 8021dbf0 00000000 8f81eef8 80220000
$ 8   : 00000000 9b915d6d 8021dbc0 ffff8db3
$12   : 00001b5c 80138ef0 80136f7c 00000010
$16   : 00000000 00000000 8021dbc0 00000000
$20   : 00000000 00000000 00000000 00000000
$24   : 00000019 80121a84
$28   : 8fb08000 8fb09ee8 8021dbc0 8002120c
Hi    : 0098963b
Lo    : 67e02780
epc   : 800210e4 set_next_entity+0x14/0x8c
    Tainted: G      D
ra    : 8002120c pick_next_task_fair+0x90/0xe4
Status: 10004402    KERNEL EXL
Cause : 00800008
BadVA : 0000001c
PrId  : 0101937c (MIPS 24Kc)
Process events/0 (pid: 4, threadinfo=8fb08000, task=8f81eda0, tls=00000000)
Stack : 00000000 800221a8 80160000 802637b4 00000000 00000000 8021dbc0
8002120c
        8f81eda0 80020a90 8faf4a88 8faf4a80 80130000 8faf4a80 8f81eda0
80004924
        8faf4a80 800959b0 8fb09f80 8fb09f80 8f81eef8 8faf4a88 8f81eef8
800436a0
        8faf4a88 8faf4a80 8fb09f80 00000000 00000000 00000000 00000000
00000000
        00000000 8003e4f8 8f81eef8 8015e000 8f81eef8 80217540 00000000
8f81eda0
        ...
Call Trace:
[<800210e4>] set_next_entity+0x14/0x8c
[<8002120c>] pick_next_task_fair+0x90/0xe4
[<80004924>] schedule+0x5e4/0x72c
[<8003e4f8>] worker_thread+0xc4/0xcc
[<80042d14>] kthread+0x58/0xa4
[<800095ec>] kernel_thread_helper+0x10/0x18

Code: afb10014  afbf001c  afb00010 <8ca2001c> 00a08821  10400008  00809021
8c82
0024  24b00008
note: events/0[4] exited with preempt_count 2
Any suggestions on debugging this?

Thanks and Regards,
Joe

On Wed, Jul 8, 2009 at 4:07 PM, Ralf Baechle <ralf@linux-mips.org> wrote:

>  On Wed, Jul 08, 2009 at 01:37:42PM +0530, joe seb wrote:
>
> > We are trying to port linux 2.6.29.4 version of the kernel from
> > linux-mips.org site to our MIPS 24K based platform and we see issues
> when we
> > use the cache in write-back mode. Cache with write-through configuration
> > works fine.
> > We use:
> > Linux kernel - 2.6.29.4
> > GNU cross tools - 4.3.2
> > Busybox - 1.14.1
> > U-boot - 2009.03
> >
> > Our platform has 256MB of RAM and its mapped to second 256 MB of the
> KSEG0
> > (0x90000000 - 0x9FFFFFFF) and KSEG1 (0xB0000000 - 0xBFFFFFFF), and we
> > specify that "mem=16M@256M" as boot parameter (we just want to use the
> first
> > 16MB by the kernel). The cache initialization for the KSEG0 is done in
> > u-boot.
> >
> > The error we get when cache is configured as write-back is given below:
> >
> > --------------------
> > Linux version 2.6.29.4 (gcc version 4.3.2 (Sourcery G
> > ++ Lite 4.3-51) ) #11 PREEMPT Tue Jul 7 21:16:00 IST 2009
> > CPU revision is: 0101937c (MIPS 24Kc)
> > Determined physical RAM map:
> > User-defined physical RAM map:
> >  memory: 01000000 @ 10000000 (usable)
> > Wasting 2097152 bytes for tracking 65536 unused pages
> > Initrd not found or empty - disabling initrd
> > Zone PFN ranges:
> >   Normal   0x00010000 -> 0x00011000
> > Movable zone start PFN for each node
> > early_node_map[1] active PFN ranges
> >     0: 0x00010000 -> 0x00011000
> > Built 1 zonelists in Zone order, mobility grouping off.  Total pages:
> 4064
> > Kernel command line: mem=16M@256M console=ttyS0,9600 cca=3
> > Primary instruction cache 32kB, VIPT, 4-way, linesize 32 bytes.
> > Primary data cache 32kB, 4-way, PIPT, no aliases, linesize 32 bytes
> > Using cache attribute 3
> > Writing ErrCtl register=00000000
> > Readback ErrCtl register=00000000
> > PID hash table entries: 64 (order: 6, 256 bytes)
> > CPU frequency 50.00 MHz
> > console [ttyS0] enabled
> > Dentry cache hash table entries: 2048 (order: 1, 8192 bytes)
> > Inode-cache hash table entries: 1024 (order: 0, 4096 bytes)
> > Memory: 13776k/16384k available (1210k kernel code, 2608k reserved, 234k
> > data, 6
> > 76k init, 0k highmem)
> > Calibrating delay loop... 33.17 BogoMIPS (lpj=165888)
> > Mount-cache hash table entries: 512
> > VFS: Disk quotas dquot_6.5.2
> > Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
> > msgmni has been set to 26
> > Serial: 8250/16550 driver, 2 ports, IRQ sharing enabled
> > serial8250: ttyS0 at MMIO 0xa1a30000 (irq = 188) is a 16550A
> > serial8250: ttyS1 at MMIO 0xa1a40000 (irq = 189) is a 16550A
> > Freeing unused kernel memory: 676k freed
> > Algorithmics/MIPS FPU Emulator v1.5
> > CPU 0 Unable to handle kernel paging request at virtual address cccccccc,
> > epc ==
> >  cccccccc, ra == cccccccc
> > Oops[#1]:
> > Cpu 0
> > $ 0   : 00000000 0053934a 00000000 00000001
> > $ 4   : 00000001 00000000 00000000 0000009a
> > $ 8   : 00000010 900038c0 00532730 00532730
> > $12   : 00000018 90284880 00020000 00000034
> > $16   : cccccccc 9016c320 9016aae0 90213520
> > $20   : 00000000 9016a960 00000001 90fa9680
> > $24   : 00000000 9009a414
> > $28   : 90176000 90177d58 9016aae0 cccccccc
> > Hi    : 0000000d
> > Lo    : 0000004a
> > epc   : cccccccc 0xcccccccc
> >     Not tainted
> > ra    : cccccccc 0xcccccccc
> > Status: 10004403    KERNEL EXL IE
> > Cause : 10800008
> > BadVA : cccccccc
> > PrId  : 0101937c (MIPS 24Kc)
> > Process rcS (pid: 11, threadinfo=90176000, task=90200500, tls=0053f470)
> > Stack : cccccccc cccccccc 90200500 9016aae0 90213520 00000000 90213520
> > 00000000
> >         9016aae0 90213520 00000000 90025c28 90200500 90faf9c0 90200500
> > 00000107
> >         9016aae0 00000107 9016aae0 900a04c8 00000003 902a4a40 902a4a48
> > 00000000
> >         902a4a44 900b3ad8 90fb1880 90fa9680 00000000 00000003 90fb1880
> > 90fa9680
> >         90177f30 90da7b20 cccccccc cccccccc cccccccc cccccccc cccccccc
> > cccccccc
> >         ...
> > Call Trace:
> > [<90025c28>] mmput+0x9c/0x194
> > [<900a04c8>] flush_old_exec+0x47c/0x988
> > [<900b3ad8>] alloc_fd+0x9c/0x1a4
> > [<90086c88>] handle_mm_fault+0x9a8/0x107c
> > [<9002f7c4>] do_softirq+0xc8/0xd0
> > [<900cc60c>] load_elf_binary+0x0/0x1410
> > [<9009fd9c>] search_binary_handler+0xa0/0x2bc
> > [<900a138c>] do_execve+0x298/0x300
> > [<900a4c60>] getname+0x28/0xc8
> > [<9000c714>] sys_execve+0x4c/0x78
> > [<90002398>] stack_done+0x20/0x3c
> >
> > Code: (Bad address in epc)
> > do_cpu invoked from kernel context![#2]:
> > Cpu 0
> > $ 0   : 00000000 90210000 9016a98c 00000001
> > $ 4   : 00000002 00000003 90168468 00000000
> > $ 8   : 000007c4 00000004 9016846c 00000001
> > $12   : ffffff80 00000000 90136f7c 00000010
> > $16   : 00000000 00000000 90200500 90213520
> > $20   : 9016a994 90177ca8 00000000 90fa9680
> > $24   : 00000000 90121648
> > $28   : 90176000 90177b48 9016aae0 90fa9680
> > Hi    : 0098963b
> > Lo    : 38c9b600
> > epc   : 90fa9680 0x90fa9680
> >     Tainted: G      D
> > ra    : 90fa9680 0x90fa9680
> > Status: 10004403    KERNEL EXL IE
> > Cause : 1080002c
> > PrId  : 0101937c (MIPS 24Kc)
> > Process rcS (pid: 11, threadinfo=90176000, task=90200500, tls=0053f470)
> > Stack : 9016aae0 900041c4 00000000 00000000 90177ca8 90177ca8 0000000b
> > 90200500
> >         90200500 cccccccc 00000000 9002cc78 90200658 9016a960 9020065c
> > 90213520
> >         90152d44 90177ca8 00000001 cccccccc 00000000 90177ca8 90152d44
> > 90177ca8
> >         90200500 cccccccc 00000000 90177ca8 00000000 90fa9680 9016aae0
> > 9000e0d4
> >         cccccccc 90220000 ffffffff 00000e89 90177bec cccccccc 9016a960
> > 90010f58
> >         ...
> > Call Trace:
> > [<900041c4>] printk+0x24/0x30
> > [<9002cc78>] do_exit+0xf4/0x88c
> > [<9000e0d4>] nmi_exception_handler+0x0/0x34
> > [<90010f58>] do_page_fault+0x2e0/0x350
> > [<90070234>] rmqueue_bulk+0x54/0xd8
> > [<900b0d48>] touch_atime+0xf8/0x174
> > [<9006c7e8>] generic_file_aio_read+0x4d8/0x8d8
> > [<90000404>] ret_from_exception+0x0/0x10
> > [<900038c0>] __bzero+0xc4/0x164
> > [<9009a414>] do_sync_read+0x0/0x168
> > [<90025c28>] mmput+0x9c/0x194
> > [<900a04c8>] flush_old_exec+0x47c/0x988
> > [<900b3ad8>] alloc_fd+0x9c/0x1a4
> > [<90086c88>] handle_mm_fault+0x9a8/0x107c
> > [<9002f7c4>] do_softirq+0xc8/0xd0
> > [<900cc60c>] load_elf_binary+0x0/0x1410
> > [<9009fd9c>] search_binary_handler+0xa0/0x2bc
> > [<900a138c>] do_execve+0x298/0x300
> > [<900a4c60>] getname+0x28/0xc8
> > [<9000c714>] sys_execve+0x4c/0x78
> > [<90002398>] stack_done+0x20/0x3c
> >
> > Code: 040a001a  e5a8b400  4018e618 <464c457f> 00010101  00000000
>  00000000
> > 0008
> > 0002  00000001
> > Fixing recursive fault but reboot is needed!
> > -------------------------------
> >
> > We get crashes at different places and the above crash is one of them.
> > Do you think this failure is due to the wrong cache configuration or
> related
> > to the d-cache aliasing problem?
> >
> > The cache details of our platform:
> > D-cache: 32KB, 4-way, 32B line size, virtually indexed and physically
> > tagged, Config7[AR] bit is set (alias is removed by the hardware).
>
> Aliases disabled in hardware, yet you suspect aliases?  Doesn't make sense.
>
> > I-cache:  32KB, 4-way, 32B line size,virtually indexed and physically
> tagged
> >
> >
> > Is there any similar 24k platform supported in linux kernel which we are
> > refer for the configurations?
>
> There has been a kernel bug for a while which on platforms with a non-zero
> memory start address would effectively disable part of of the cache code.
> Your description above, including the changed behaviour between
> write-though
> and write-back caches is consistent with that bug.  Commit
> 67227819d6dd07f6ec225ea59c67aff3ba936e25 fixes this issue.  For your
> convenience I append it below.
>
> I'd appreciate feedback on your test results with this patch.
>
> (Why do people use non-zero starting addresses for memory?  Handling of
> cache error exceptions is hard enough as it is but with no memory in the
> low 32k the design idea of the cache architecture that stores relative to
> $zero can be used goes down the drain and (not considering
> platform-specific
> solutions here) only be handled by burning the scarce resource of a TLB
> entry for an extremly rare event ...)
>
>  Ralf
>
> From 67227819d6dd07f6ec225ea59c67aff3ba936e25 Mon Sep 17 00:00:00 2001
> From: Ralf Baechle <ralf@linux-mips.org>
> Date: Fri, 3 Jul 2009 07:11:15 +0100
> Subject: [PATCH] MIPS: Fix pfn_valid()
>
> For systems which do not define PHYS_OFFSET as 0 pfn_valid() may falsely
> have returned 0 on most configurations.  Bug introduced by commit
> 752fbeb2e3555c0d236e992f1195fd7ce30e728d (linux-mips.org) rsp.
> 6f284a2ce7b8bc49cb8455b1763357897a899abb (kernel.org) titled "[MIPS]
> FLATMEM: introduce PHYS_OFFSET."
>
> Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
>
> diff --git a/arch/mips/include/asm/page.h b/arch/mips/include/asm/page.h
> index dc0eaa7..96a14a4 100644
> --- a/arch/mips/include/asm/page.h
> +++ b/arch/mips/include/asm/page.h
> @@ -165,7 +165,14 @@ typedef struct { unsigned long pgprot; } pgprot_t;
>
>  #ifdef CONFIG_FLATMEM
>
> -#define pfn_valid(pfn)         ((pfn) >= ARCH_PFN_OFFSET && (pfn) <
> max_mapnr)
> +#define pfn_valid(pfn)                                                 \
> +({                                                                     \
> +       unsigned long __pfn = (pfn);                                    \
> +       /* avoid <linux/bootmem.h> include hell */                      \
> +       extern unsigned long min_low_pfn;                               \
> +                                                                       \
> +       __pfn >= min_low_pfn && __pfn < max_mapnr;                      \
> +})
>
>  #elif defined(CONFIG_SPARSEMEM)
>
>

--0016364174e3db55aa046e9767fc
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div>Ralf,</div>
<div>=A0</div>
<div>We made changes to our MIPS FPGA to map the RAM to KSEG0 (0x80000000) =
start address. We still see the issue with the write-back. Write-through is=
 working fine. </div>
<div>=A0</div>
<div>The failure log we got this time is given below:</div>
<div>=A0</div>
<div>Linux version 2.6.29.4 () (gcc version 4.3.2 (Sourcery G<br>++ Lite 4.=
3-51) ) #15 PREEMPT Mon Jul 13 13:22:21 IST 2009<br>CPU revision is: 010193=
7c (MIPS 24Kc)<br>Determined physical RAM map:<br>User-defined physical RAM=
 map:<br>
=A0memory: 10000000 @ 00000000 (usable)<br>Initrd not found or empty - disa=
bling initrd<br>Zone PFN ranges:<br>=A0 Normal=A0=A0 0x00000000 -&gt; 0x000=
10000<br>Movable zone start PFN for each node<br>early_node_map[1] active P=
FN ranges<br>
=A0=A0=A0 0: 0x00000000 -&gt; 0x00010000<br>Built 1 zonelists in Zone order=
, mobility grouping on.=A0 Total pages: 65024<br>Kernel command line: mem=
=3D256M console=3DttyS0,9600 cca=3D3<br>Primary instruction cache 32kB, VIP=
T, 4-way, linesize 32 bytes.<br>
Primary data cache 32kB, 4-way, PIPT, no aliases, linesize 32 bytes<br>Usin=
g cache attribute 3<br>Writing ErrCtl register=3D00000000<br>Readback ErrCt=
l register=3D00000000<br>PID hash table entries: 1024 (order: 10, 4096 byte=
s)<br>
CPU frequency 50.00 MHz<br>console [ttyS0] enabled<br>Dentry cache hash tab=
le entries: 32768 (order: 5, 131072 bytes)<br>Inode-cache hash table entrie=
s: 16384 (order: 4, 65536 bytes)<br>Memory: 257092k/262144k available (1211=
k kernel code, 4728k reserved, 234k data,<br>
=A0692k init, 0k highmem)<br>Calibrating delay loop... 33.17 BogoMIPS (lpj=
=3D165888)<br>Mount-cache hash table entries: 512<br>VFS: Disk quotas dquot=
_6.5.2<br>Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)<br>msg=
mni has been set to 502<br>
Serial: 8250/16550 driver, 2 ports, IRQ sharing enabled<br>serial8250: ttyS=
0 at MMIO 0xb1a30000 (irq =3D 188) is a 16550A<br>serial8250: ttyS1 at MMIO=
 0xb1a40000 (irq =3D 189) is a 16550A<br>Freeing unused kernel memory: 692k=
 freed<br>
Algorithmics/MIPS FPU Emulator v1.5<br>CPU 0 Unable to handle kernel paging=
 request at virtual address ffffb32c, epc =3D=3D<br>=A08f15b32c, ra =3D=3D =
8f15b32c<br>CPU 0 Unable to handle kernel paging request at virtual address=
 0000001c, epc =3D=3D<br>
=A0800210e4, ra =3D=3D 8002120c<br>Oops[#1]:<br>Cpu 0<br>$ 0=A0=A0 : 000000=
00 7fccc8e8 fffffff8 00000000<br>$ 4=A0=A0 : 8021dbf0 00000000 8f81fc60 802=
20000<br>$ 8=A0=A0 : 00000000 9b915d6d 8021dbc0 fffffffc<br>$12=A0=A0 : 000=
0000f 00000002 80136f7c 00000010<br>
$16=A0=A0 : 00000000 00000000 8021dbc0 8f821eb0<br>$20=A0=A0 : 00000000 000=
00000 00000003 ffffffff<br>$24=A0=A0 : 00000000 0043e4b0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 <br>$28=A0=A0 : 8f820000 8f821e00 8021dbc=
0 8002120c<br>Hi=A0=A0=A0 : 0098963a<br>Lo=A0=A0=A0 : ebe5df80<br>
epc=A0=A0 : 800210e4 set_next_entity+0x14/0x8c<br>=A0=A0=A0 Not tainted<br>=
ra=A0=A0=A0 : 8002120c pick_next_task_fair+0x90/0xe4<br>Status: 10004402=A0=
=A0=A0 KERNEL EXL <br>Cause : 00800008<br>BadVA : 0000001c<br>PrId=A0 : 010=
1937c (MIPS 24Kc)<br>
Process init (pid: 1, threadinfo=3D8f820000, task=3D8f81fb08, tls=3D0053f47=
0)<br>Stack : 00000000 800221a8 00000000 80021550 00000000 00000000 8021dbc=
0 8002120c<br>=A0=A0=A0=A0=A0=A0=A0 8f81fb08 80020a90 8f81fb00 8f81fb08 801=
30000 8f81fb08 8f81fb08 80004924<br>
=A0=A0=A0=A0=A0=A0=A0 7fcccc04 800051a8 8f81fc60 8f168de0 8f81fc60 8f821eb4=
 8f81fc60 00000001<br>=A0=A0=A0=A0=A0=A0=A0 8f81fb00 8f81fb08 8f81fbfc 8f82=
1eb0 00000000 00000000 00000003 ffffffff<br>=A0=A0=A0=A0=A0=A0=A0 00000006 =
8002c95c 8021dbc0 8f15b238 00000001 8f81fb08 00000003 00000000<br>
=A0=A0=A0=A0=A0=A0=A0 ...<br>Call Trace:<br>[&lt;800210e4&gt;] set_next_ent=
ity+0x14/0x8c<br>[&lt;8002120c&gt;] pick_next_task_fair+0x90/0xe4<br>[&lt;8=
0004924&gt;] schedule+0x5e4/0x72c<br>[&lt;8002c95c&gt;] do_wait+0x31c/0x4a0=
<br>[&lt;8002cbe0&gt;] sys_wait4+0x100/0x174<br>
[&lt;80002398&gt;] stack_done+0x20/0x3c</div>
<div><br>Code: afb10014=A0 afbf001c=A0 afb00010 &lt;8ca2001c&gt; 00a08821=
=A0 10400008=A0 00809021=A0 8c82<br>0024=A0 24b00008 <br>note: init[1] exit=
ed with preempt_count 2<br>BUG: scheduling while atomic: init/1/0x10000003<=
br>Call Trace:<br>
[&lt;80003fd0&gt;] dump_stack+0x8/0x38<br>[&lt;800048a0&gt;] schedule+0x560=
/0x72c<br>[&lt;80021774&gt;] __cond_resched+0x18/0x38<br>[&lt;80004c20&gt;]=
 _cond_resched+0x50/0x58<br>[&lt;80085874&gt;] unmap_vmas+0x614/0x6d4<br>
[&lt;8008b260&gt;] exit_mmap+0xe8/0x1f8<br>[&lt;80025dd8&gt;] mmput+0x9c/0x=
194<br>[&lt;8002aa40&gt;] exit_mm+0x15c/0x268<br>[&lt;8002ce28&gt;] do_exit=
+0xf4/0x88c<br>[&lt;8000e110&gt;] nmi_exception_handler+0x0/0x34</div>
<div>CPU 0 Unable to handle kernel paging request at virtual address 000000=
1c, epc =3D=3D<br>=A0800210e4, ra =3D=3D 8002120c<br>Oops[#2]:<br>Cpu 0<br>=
$ 0=A0=A0 : 00000000 00000001 fffffff8 00000000<br>$ 4=A0=A0 : 8021dbf0 000=
00000 8f81eef8 80220000<br>
$ 8=A0=A0 : 00000000 9b915d6d 8021dbc0 ffff8db3<br>$12=A0=A0 : 00001b5c 801=
38ef0 80136f7c 00000010<br>$16=A0=A0 : 00000000 00000000 8021dbc0 00000000<=
br>$20=A0=A0 : 00000000 00000000 00000000 00000000<br>$24=A0=A0 : 00000019 =
80121a84=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 <br>
$28=A0=A0 : 8fb08000 8fb09ee8 8021dbc0 8002120c<br>Hi=A0=A0=A0 : 0098963b<b=
r>Lo=A0=A0=A0 : 67e02780<br>epc=A0=A0 : 800210e4 set_next_entity+0x14/0x8c<=
br>=A0=A0=A0 Tainted: G=A0=A0=A0=A0=A0 D=A0=A0 <br>ra=A0=A0=A0 : 8002120c p=
ick_next_task_fair+0x90/0xe4<br>Status: 10004402=A0=A0=A0 KERNEL EXL <br>
Cause : 00800008<br>BadVA : 0000001c<br>PrId=A0 : 0101937c (MIPS 24Kc)<br>P=
rocess events/0 (pid: 4, threadinfo=3D8fb08000, task=3D8f81eda0, tls=3D0000=
0000)<br>Stack : 00000000 800221a8 80160000 802637b4 00000000 00000000 8021=
dbc0 8002120c<br>
=A0=A0=A0=A0=A0=A0=A0 8f81eda0 80020a90 8faf4a88 8faf4a80 80130000 8faf4a80=
 8f81eda0 80004924<br>=A0=A0=A0=A0=A0=A0=A0 8faf4a80 800959b0 8fb09f80 8fb0=
9f80 8f81eef8 8faf4a88 8f81eef8 800436a0<br>=A0=A0=A0=A0=A0=A0=A0 8faf4a88 =
8faf4a80 8fb09f80 00000000 00000000 00000000 00000000 00000000<br>
=A0=A0=A0=A0=A0=A0=A0 00000000 8003e4f8 8f81eef8 8015e000 8f81eef8 80217540=
 00000000 8f81eda0<br>=A0=A0=A0=A0=A0=A0=A0 ...<br>Call Trace:<br>[&lt;8002=
10e4&gt;] set_next_entity+0x14/0x8c<br>[&lt;8002120c&gt;] pick_next_task_fa=
ir+0x90/0xe4<br>[&lt;80004924&gt;] schedule+0x5e4/0x72c<br>
[&lt;8003e4f8&gt;] worker_thread+0xc4/0xcc<br>[&lt;80042d14&gt;] kthread+0x=
58/0xa4<br>[&lt;800095ec&gt;] kernel_thread_helper+0x10/0x18</div>
<div><br>Code: afb10014=A0 afbf001c=A0 afb00010 &lt;8ca2001c&gt; 00a08821=
=A0 10400008=A0 00809021=A0 8c82<br>0024=A0 24b00008 <br>note: events/0[4] =
exited with preempt_count 2<br></div>
<div>Any suggestions on debugging this?</div>
<div>=A0</div>
<div>Thanks and Regards,</div>
<div>Joe<br><br></div>
<div class=3D"gmail_quote">On Wed, Jul 8, 2009 at 4:07 PM, Ralf Baechle <sp=
an dir=3D"ltr">&lt;<a href=3D"mailto:ralf@linux-mips.org">ralf@linux-mips.o=
rg</a>&gt;</span> wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"PADDING-LEFT: 1ex; MARGIN: 0px 0=
px 0px 0.8ex; BORDER-LEFT: #ccc 1px solid">
<div>
<div></div>
<div class=3D"h5">On Wed, Jul 08, 2009 at 01:37:42PM +0530, joe seb wrote:<=
br><br>&gt; We are trying to port linux 2.6.29.4 version of the kernel from=
<br>&gt; <a href=3D"http://linux-mips.org/" target=3D"_blank">linux-mips.or=
g</a> site to our MIPS 24K based platform and we see issues when we<br>
&gt; use the cache in write-back mode. Cache with write-through configurati=
on<br>&gt; works fine.<br>&gt; We use:<br>&gt; Linux kernel - 2.6.29.4<br>&=
gt; GNU cross tools - 4.3.2<br>&gt; Busybox - 1.14.1<br>&gt; U-boot - 2009.=
03<br>
&gt;<br>&gt; Our platform has 256MB of RAM and its mapped to second 256 MB =
of the KSEG0<br>&gt; (0x90000000 - 0x9FFFFFFF) and KSEG1 (0xB0000000 - 0xBF=
FFFFFF), and we<br>&gt; specify that &quot;mem=3D16M@256M&quot; as boot par=
ameter (we just want to use the first<br>
&gt; 16MB by the kernel). The cache initialization for the KSEG0 is done in=
<br>&gt; u-boot.<br>&gt;<br>&gt; The error we get when cache is configured =
as write-back is given below:<br>&gt;<br>&gt; --------------------<br>&gt; =
Linux version 2.6.29.4 (gcc version 4.3.2 (Sourcery G<br>
&gt; ++ Lite 4.3-51) ) #11 PREEMPT Tue Jul 7 21:16:00 IST 2009<br>&gt; CPU =
revision is: 0101937c (MIPS 24Kc)<br>&gt; Determined physical RAM map:<br>&=
gt; User-defined physical RAM map:<br>&gt; =A0memory: 01000000 @ 10000000 (=
usable)<br>
&gt; Wasting 2097152 bytes for tracking 65536 unused pages<br>&gt; Initrd n=
ot found or empty - disabling initrd<br>&gt; Zone PFN ranges:<br>&gt; =A0 N=
ormal =A0 0x00010000 -&gt; 0x00011000<br>&gt; Movable zone start PFN for ea=
ch node<br>
&gt; early_node_map[1] active PFN ranges<br>&gt; =A0 =A0 0: 0x00010000 -&gt=
; 0x00011000<br>&gt; Built 1 zonelists in Zone order, mobility grouping off=
. =A0Total pages: 4064<br>&gt; Kernel command line: mem=3D16M@256M console=
=3DttyS0,9600 cca=3D3<br>
&gt; Primary instruction cache 32kB, VIPT, 4-way, linesize 32 bytes.<br>&gt=
; Primary data cache 32kB, 4-way, PIPT, no aliases, linesize 32 bytes<br>&g=
t; Using cache attribute 3<br>&gt; Writing ErrCtl register=3D00000000<br>
&gt; Readback ErrCtl register=3D00000000<br>&gt; PID hash table entries: 64=
 (order: 6, 256 bytes)<br>&gt; CPU frequency 50.00 MHz<br>&gt; console [tty=
S0] enabled<br>&gt; Dentry cache hash table entries: 2048 (order: 1, 8192 b=
ytes)<br>
&gt; Inode-cache hash table entries: 1024 (order: 0, 4096 bytes)<br>&gt; Me=
mory: 13776k/16384k available (1210k kernel code, 2608k reserved, 234k<br>&=
gt; data, 6<br>&gt; 76k init, 0k highmem)<br>&gt; Calibrating delay loop...=
 33.17 BogoMIPS (lpj=3D165888)<br>
&gt; Mount-cache hash table entries: 512<br>&gt; VFS: Disk quotas dquot_6.5=
.2<br>&gt; Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)<br>&g=
t; msgmni has been set to 26<br>&gt; Serial: 8250/16550 driver, 2 ports, IR=
Q sharing enabled<br>
&gt; serial8250: ttyS0 at MMIO 0xa1a30000 (irq =3D 188) is a 16550A<br>&gt;=
 serial8250: ttyS1 at MMIO 0xa1a40000 (irq =3D 189) is a 16550A<br>&gt; Fre=
eing unused kernel memory: 676k freed<br>&gt; Algorithmics/MIPS FPU Emulato=
r v1.5<br>
&gt; CPU 0 Unable to handle kernel paging request at virtual address cccccc=
cc,<br>&gt; epc =3D=3D<br>&gt; =A0cccccccc, ra =3D=3D cccccccc<br>&gt; Oops=
[#1]:<br>&gt; Cpu 0<br>&gt; $ 0 =A0 : 00000000 0053934a 00000000 00000001<b=
r>&gt; $ 4 =A0 : 00000001 00000000 00000000 0000009a<br>
&gt; $ 8 =A0 : 00000010 900038c0 00532730 00532730<br>&gt; $12 =A0 : 000000=
18 90284880 00020000 00000034<br>&gt; $16 =A0 : cccccccc 9016c320 9016aae0 =
90213520<br>&gt; $20 =A0 : 00000000 9016a960 00000001 90fa9680<br>&gt; $24 =
=A0 : 00000000 9009a414<br>
&gt; $28 =A0 : 90176000 90177d58 9016aae0 cccccccc<br>&gt; Hi =A0 =A0: 0000=
000d<br>&gt; Lo =A0 =A0: 0000004a<br>&gt; epc =A0 : cccccccc 0xcccccccc<br>=
&gt; =A0 =A0 Not tainted<br>&gt; ra =A0 =A0: cccccccc 0xcccccccc<br>&gt; St=
atus: 10004403 =A0 =A0KERNEL EXL IE<br>
&gt; Cause : 10800008<br>&gt; BadVA : cccccccc<br>&gt; PrId =A0: 0101937c (=
MIPS 24Kc)<br>&gt; Process rcS (pid: 11, threadinfo=3D90176000, task=3D9020=
0500, tls=3D0053f470)<br>&gt; Stack : cccccccc cccccccc 90200500 9016aae0 9=
0213520 00000000 90213520<br>
&gt; 00000000<br>&gt; =A0 =A0 =A0 =A0 9016aae0 90213520 00000000 90025c28 9=
0200500 90faf9c0 90200500<br>&gt; 00000107<br>&gt; =A0 =A0 =A0 =A0 9016aae0=
 00000107 9016aae0 900a04c8 00000003 902a4a40 902a4a48<br>&gt; 00000000<br>=
&gt; =A0 =A0 =A0 =A0 902a4a44 900b3ad8 90fb1880 90fa9680 00000000 00000003 =
90fb1880<br>
&gt; 90fa9680<br>&gt; =A0 =A0 =A0 =A0 90177f30 90da7b20 cccccccc cccccccc c=
ccccccc cccccccc cccccccc<br>&gt; cccccccc<br>&gt; =A0 =A0 =A0 =A0 ...<br>&=
gt; Call Trace:<br>&gt; [&lt;90025c28&gt;] mmput+0x9c/0x194<br>&gt; [&lt;90=
0a04c8&gt;] flush_old_exec+0x47c/0x988<br>
&gt; [&lt;900b3ad8&gt;] alloc_fd+0x9c/0x1a4<br>&gt; [&lt;90086c88&gt;] hand=
le_mm_fault+0x9a8/0x107c<br>&gt; [&lt;9002f7c4&gt;] do_softirq+0xc8/0xd0<br=
>&gt; [&lt;900cc60c&gt;] load_elf_binary+0x0/0x1410<br>&gt; [&lt;9009fd9c&g=
t;] search_binary_handler+0xa0/0x2bc<br>
&gt; [&lt;900a138c&gt;] do_execve+0x298/0x300<br>&gt; [&lt;900a4c60&gt;] ge=
tname+0x28/0xc8<br>&gt; [&lt;9000c714&gt;] sys_execve+0x4c/0x78<br>&gt; [&l=
t;90002398&gt;] stack_done+0x20/0x3c<br>&gt;<br>&gt; Code: (Bad address in =
epc)<br>
&gt; do_cpu invoked from kernel context![#2]:<br>&gt; Cpu 0<br>&gt; $ 0 =A0=
 : 00000000 90210000 9016a98c 00000001<br>&gt; $ 4 =A0 : 00000002 00000003 =
90168468 00000000<br>&gt; $ 8 =A0 : 000007c4 00000004 9016846c 00000001<br>=
&gt; $12 =A0 : ffffff80 00000000 90136f7c 00000010<br>
&gt; $16 =A0 : 00000000 00000000 90200500 90213520<br>&gt; $20 =A0 : 9016a9=
94 90177ca8 00000000 90fa9680<br>&gt; $24 =A0 : 00000000 90121648<br>&gt; $=
28 =A0 : 90176000 90177b48 9016aae0 90fa9680<br>&gt; Hi =A0 =A0: 0098963b<b=
r>&gt; Lo =A0 =A0: 38c9b600<br>
&gt; epc =A0 : 90fa9680 0x90fa9680<br>&gt; =A0 =A0 Tainted: G =A0 =A0 =A0D<=
br>&gt; ra =A0 =A0: 90fa9680 0x90fa9680<br>&gt; Status: 10004403 =A0 =A0KER=
NEL EXL IE<br>&gt; Cause : 1080002c<br>&gt; PrId =A0: 0101937c (MIPS 24Kc)<=
br>&gt; Process rcS (pid: 11, threadinfo=3D90176000, task=3D90200500, tls=
=3D0053f470)<br>
&gt; Stack : 9016aae0 900041c4 00000000 00000000 90177ca8 90177ca8 0000000b=
<br>&gt; 90200500<br>&gt; =A0 =A0 =A0 =A0 90200500 cccccccc 00000000 9002cc=
78 90200658 9016a960 9020065c<br>&gt; 90213520<br>&gt; =A0 =A0 =A0 =A0 9015=
2d44 90177ca8 00000001 cccccccc 00000000 90177ca8 90152d44<br>
&gt; 90177ca8<br>&gt; =A0 =A0 =A0 =A0 90200500 cccccccc 00000000 90177ca8 0=
0000000 90fa9680 9016aae0<br>&gt; 9000e0d4<br>&gt; =A0 =A0 =A0 =A0 cccccccc=
 90220000 ffffffff 00000e89 90177bec cccccccc 9016a960<br>&gt; 90010f58<br>=
&gt; =A0 =A0 =A0 =A0 ...<br>
&gt; Call Trace:<br>&gt; [&lt;900041c4&gt;] printk+0x24/0x30<br>&gt; [&lt;9=
002cc78&gt;] do_exit+0xf4/0x88c<br>&gt; [&lt;9000e0d4&gt;] nmi_exception_ha=
ndler+0x0/0x34<br>&gt; [&lt;90010f58&gt;] do_page_fault+0x2e0/0x350<br>
&gt; [&lt;90070234&gt;] rmqueue_bulk+0x54/0xd8<br>&gt; [&lt;900b0d48&gt;] t=
ouch_atime+0xf8/0x174<br>&gt; [&lt;9006c7e8&gt;] generic_file_aio_read+0x4d=
8/0x8d8<br>&gt; [&lt;90000404&gt;] ret_from_exception+0x0/0x10<br>&gt; [&lt=
;900038c0&gt;] __bzero+0xc4/0x164<br>
&gt; [&lt;9009a414&gt;] do_sync_read+0x0/0x168<br>&gt; [&lt;90025c28&gt;] m=
mput+0x9c/0x194<br>&gt; [&lt;900a04c8&gt;] flush_old_exec+0x47c/0x988<br>&g=
t; [&lt;900b3ad8&gt;] alloc_fd+0x9c/0x1a4<br>&gt; [&lt;90086c88&gt;] handle=
_mm_fault+0x9a8/0x107c<br>
&gt; [&lt;9002f7c4&gt;] do_softirq+0xc8/0xd0<br>&gt; [&lt;900cc60c&gt;] loa=
d_elf_binary+0x0/0x1410<br>&gt; [&lt;9009fd9c&gt;] search_binary_handler+0x=
a0/0x2bc<br>&gt; [&lt;900a138c&gt;] do_execve+0x298/0x300<br>&gt; [&lt;900a=
4c60&gt;] getname+0x28/0xc8<br>
&gt; [&lt;9000c714&gt;] sys_execve+0x4c/0x78<br>&gt; [&lt;90002398&gt;] sta=
ck_done+0x20/0x3c<br>&gt;<br>&gt; Code: 040a001a =A0e5a8b400 =A04018e618 &l=
t;464c457f&gt; 00010101 =A000000000 =A000000000<br>&gt; 0008<br>&gt; 0002 =
=A000000001<br>
&gt; Fixing recursive fault but reboot is needed!<br>&gt; -----------------=
--------------<br>&gt;<br>&gt; We get crashes at different places and the a=
bove crash is one of them.<br>&gt; Do you think this failure is due to the =
wrong cache configuration or related<br>
&gt; to the d-cache aliasing problem?<br>&gt;<br>&gt; The cache details of =
our platform:<br>&gt; D-cache: 32KB, 4-way, 32B line size, virtually indexe=
d and physically<br>&gt; tagged, Config7[AR] bit is set (alias is removed b=
y the hardware).<br>
<br></div></div>Aliases disabled in hardware, yet you suspect aliases? =A0D=
oesn&#39;t make sense.<br>
<div class=3D"im"><br>&gt; I-cache: =A032KB, 4-way, 32B line size,virtually=
 indexed and physically tagged<br>&gt;<br>&gt;<br>&gt; Is there any similar=
 24k platform supported in linux kernel which we are<br>&gt; refer for the =
configurations?<br>
<br></div>There has been a kernel bug for a while which on platforms with a=
 non-zero<br>memory start address would effectively disable part of of the =
cache code.<br>Your description above, including the changed behaviour betw=
een write-though<br>
and write-back caches is consistent with that bug. =A0Commit<br>67227819d6d=
d07f6ec225ea59c67aff3ba936e25 fixes this issue. =A0For your<br>convenience =
I append it below.<br><br>I&#39;d appreciate feedback on your test results =
with this patch.<br>
<br>(Why do people use non-zero starting addresses for memory? =A0Handling =
of<br>cache error exceptions is hard enough as it is but with no memory in =
the<br>low 32k the design idea of the cache architecture that stores relati=
ve to<br>
$zero can be used goes down the drain and (not considering platform-specifi=
c<br>solutions here) only be handled by burning the scarce resource of a TL=
B<br>entry for an extremly rare event ...)<br><br>=A0Ralf<br><br>From 67227=
819d6dd07f6ec225ea59c67aff3ba936e25 Mon Sep 17 00:00:00 2001<br>
From: Ralf Baechle &lt;<a href=3D"mailto:ralf@linux-mips.org">ralf@linux-mi=
ps.org</a>&gt;<br>Date: Fri, 3 Jul 2009 07:11:15 +0100<br>Subject: [PATCH] =
MIPS: Fix pfn_valid()<br><br>For systems which do not define PHYS_OFFSET as=
 0 pfn_valid() may falsely<br>
have returned 0 on most configurations. =A0Bug introduced by commit<br>752f=
beb2e3555c0d236e992f1195fd7ce30e728d (<a href=3D"http://linux-mips.org/" ta=
rget=3D"_blank">linux-mips.org</a>) rsp.<br>6f284a2ce7b8bc49cb8455b17633578=
97a899abb (<a href=3D"http://kernel.org/" target=3D"_blank">kernel.org</a>)=
 titled &quot;[MIPS]<br>
FLATMEM: introduce PHYS_OFFSET.&quot;<br><br>Signed-off-by: Ralf Baechle &l=
t;<a href=3D"mailto:ralf@linux-mips.org">ralf@linux-mips.org</a>&gt;<br><br=
>diff --git a/arch/mips/include/asm/page.h b/arch/mips/include/asm/page.h<b=
r>
index dc0eaa7..96a14a4 100644<br>--- a/arch/mips/include/asm/page.h<br>+++ =
b/arch/mips/include/asm/page.h<br>@@ -165,7 +165,14 @@ typedef struct { uns=
igned long pgprot; } pgprot_t;<br><br>=A0#ifdef CONFIG_FLATMEM<br><br>-#def=
ine pfn_valid(pfn) =A0 =A0 =A0 =A0 ((pfn) &gt;=3D ARCH_PFN_OFFSET &amp;&amp=
; (pfn) &lt; max_mapnr)<br>
+#define pfn_valid(pfn) =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 \<br>+({ =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 \<br>+ =A0 =A0 =A0 unsigned long _=
_pfn =3D (pfn); =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0\<br>
+ =A0 =A0 =A0 /* avoid &lt;linux/bootmem.h&gt; include hell */ =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0\<br>+ =A0 =A0 =A0 extern unsigned long min_=
low_pfn; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 \<br>+=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 \<br>
+ =A0 =A0 =A0 __pfn &gt;=3D min_low_pfn &amp;&amp; __pfn &lt; max_mapnr; =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0\<br>+})<br><br>=A0#elif defined=
(CONFIG_SPARSEMEM)<br><br></blockquote></div><br>

--0016364174e3db55aa046e9767fc--
