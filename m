Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 29 Oct 2012 21:51:48 +0100 (CET)
Received: from smtp157.iad.emailsrvr.com ([207.97.245.157]:50614 "EHLO
        smtp157.iad.emailsrvr.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6824766Ab2J2UvlfNLpu convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 29 Oct 2012 21:51:41 +0100
Received: from smtp55.relay.iad1a.emailsrvr.com (localhost.localdomain [127.0.0.1])
        by smtp55.relay.iad1a.emailsrvr.com (SMTP Server) with ESMTP id 5F3462E0374
        for <linux-mips@linux-mips.org>; Mon, 29 Oct 2012 16:51:34 -0400 (EDT)
X-SMTPDoctor-Processed: csmtpprox 2.7.4
Received: from localhost (localhost.localdomain [127.0.0.1])
        by smtp55.relay.iad1a.emailsrvr.com (SMTP Server) with ESMTP id 5A6EF2E01AE
        for <linux-mips@linux-mips.org>; Mon, 29 Oct 2012 16:51:34 -0400 (EDT)
X-Virus-Scanned: OK
Received: from smtp192.mex02.mlsrvr.com (smtp192.mex02.mlsrvr.com [204.232.137.43])
        by smtp55.relay.iad1a.emailsrvr.com (SMTP Server) with ESMTPS id F318E2E0374
        for <linux-mips@linux-mips.org>; Mon, 29 Oct 2012 16:51:33 -0400 (EDT)
Received: from IAD2MBX02.mex02.mlsrvr.com ([172.23.11.10]) by
 IAD2HUB04.mex02.mlsrvr.com ([172.23.10.68]) with mapi; Mon, 29 Oct 2012
 16:51:31 -0400
From:   Jacob Burkholder <jacob.burkholder@blinqnetworks.com>
To:     "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>
Date:   Mon, 29 Oct 2012 16:51:30 -0400
Subject: linux 3.6.3 mips64 mtd jffs2 unmount issue
Thread-Topic: linux 3.6.3 mips64 mtd jffs2 unmount issue
Thread-Index: Ac22C//7wJhoNVMMTKqdBRvfAoFIUQ==
Message-ID: <14A0B61B8C8EFA4A9F40381A10D219104EEB0F5226@IAD2MBX02.mex02.mlsrvr.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
acceptlanguage: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-archive-position: 34790
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jacob.burkholder@blinqnetworks.com
Precedence: bulk
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-Id: linux-mips <linux-mips.eddie.linux-mips.org>
X-List-ID: linux-mips <linux-mips.eddie.linux-mips.org>
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

Greetings!

We are having an issue with linux 3.6.3 on mips64 with mtd and jffs2.
The platform is a custom Broadcom XLS board.  The issue occurs when a
jffs2 is unmounted.  It does not occur with ubifs for what its worth.

What happens is the bdi-default thread gets an unaligned kernel access
exception.  The unaligned exception is a red herring, the address is
aligned but it is a bad address.  A boot log and stack trace from the
bdi-default thread is included below as well as some gdb debugging
output.  I tracked this down to the backing_dev_info structures that
are used with mtd devices, mtd_bdi_unmappable, mtd_bdi_ro_mappable,
mtd_bdi_rw_mappable, in mtdcore.c around line 338.  The mtd device in
question is nand so uses the mtd_bdi_unmappable backing_dev_info is
used.  When the jffs2 is unmounted the the bdi_forker_thread gets a
KILL_THREAD signal and calls bdi_clear_pending on the backing_dev_info
structure mentioned above.  This is turn calls
wake_up_bit(&bdi->state, BDI_pending);, wake_up_bit looks up the zone
for the page that the passed address is in and this seems to be the
problem.  The backing_dev_info structures are statically allocated in
the kernel data section and these addresses don't seem to have a vm
zone structure.  I set a breakpoint in wake_up_bit and can that it gets
called on other addresses which all start with 0xa8000000, finally it
gets passed the address in the mtd_bdi_unmappable structure and then
crashes.  I changed the backing_dev_info structures to be allocated
with kzalloc and the problem goes away and jffs2 generally works.
We link our kernel at address 0xffffffff80100000 and this is what our
bootloader expects.  I tried to change this to link at 0xa800000001000000,
which would seem to put the kernel data section where the bdi thread
expects its backing_dev_info structures to be allocated, but our
bootloader won't boot the image and I don't know if its the correct way
to deal with the problem.  I don't think this is an mtd problem since
other platforms use these files unmodified, so not sure where to start.

Thanks for any hints.

Regards,

[   77.778000] Unhandled kernel unaligned access[#1]:
[   77.778000] Cpu 0
[   77.778000] $ 0   : 0000000000000000 fffffffffffffffe 0000000000000000 0000000000000000
[   77.778000] $ 4   : a800000043c93c80 a933ffffff411b48 ffffffff8014d3f8 a933ffffff411b48
[   77.778000] $ 8   : fffffffffffffffe ffffffffffffffff 0000000000000001 0000000000000000
[   77.778000] $12   : 000000001000c0e1 000000001000001e 0000000000000000 0000000000000000
[   77.778000] $16   : a800000043c93c80 a933ffffff411b48 ffffffffdc420000 ffffffff8050f960
[   77.778000] $20   : ffffffff80502f28 ffffffff80500000 ffffffff80500000 0000000000000001
[   77.778000] $24   : 0000000000000000 ffffffff8015b6b8
[   77.778000] $28   : a800000043c90000 a800000043c939c0 0000000000000001 ffffffff80109a1c
[   77.778000] Hi    : 0000000000000000
[   77.778000] Lo    : 0000000000000000
[   77.778000] epc   : ffffffff80109830 emulate_load_store_insn+0x340/0x468
[   77.778000]     Not tainted
[   77.778000] ra    : ffffffff80109a1c do_ade+0xc4/0x168
[   77.778000] Status: 1000c0e3    KX SX UX KERNEL EXL IE
[   77.778000] Cause : 00800010
[   77.778000] BadVA : a933ffffff411b48
[   77.778000] PrId  : 000cce01 (Netlogic XLS)
[   77.778000] Modules linked in:
[   77.778000] Process bdi-default (pid: 12, threadinfo=a800000043c90000, task=a800000043c350c8, tls=0000000000000000)
[   77.778000] Stack : 0000000000000000 0000000000000000 0000000000000000 0000000000000000
        0000000000000000 0000000000000000 0000000000000000 0000000000000000
        0000000000000000 0000000000000000 0000000000000000 0000000000000000
        0000000000000000 0000000000000000 0000000000000000 0000000000000000
        0000000000000000 0000000000000000 0000000000000000 0000000000000000
        0000000000000000 0000000000000000 0000000000000000 0000000000000000
        a800000043c35100 a800000043c30790 ffffffff804fb5f0 a800000043c307a0
        ffffffff80500000 ffffffff8015b238 ffffffff804fb580 a800000043c350c8
        a800000043c350c8 ffffffff804fb580 a800000043c30758 ffffffff804320f8
        0000000000000000 0000000000000000 0000000000000000 a800000043c93c80
        ...
[   77.778000] Call Trace:
[   77.778000] [<ffffffff80109830>] emulate_load_store_insn+0x340/0x468
[   77.778000] [<ffffffff80109a1c>] do_ade+0xc4/0x168
[   77.778000] [<ffffffff801036a0>] ret_from_exception+0x0/0x20
[   77.778000] [<ffffffff8014d3f8>] bit_waitqueue+0x28/0xb0
[   77.778000] [<ffffffff8014d4d0>] wake_up_bit+0x18/0x38
[   77.778000] [<ffffffff801b54f4>] bdi_forker_thread+0x27c/0x3b8
[   77.778000] [<ffffffff8014cda8>] kthread+0x90/0x98
[   77.778000] [<ffffffff80105450>] kernel_thread_helper+0x10/0x18
[   77.778000]
[   77.778000]
Code: 00431024  1440ff5d  00000000 <6a330000> 6e330007  24110000  1620ff94  00000000  08042580
[   78.528000] ---[ end trace 6cfe7eb411516337 ]---

(gdb) target remote 192.168.1.3:2001
Remote debugging using 192.168.1.3:2001
cpu_idle () at arch/mips/kernel/process.c:60
60                      while (!need_resched() && cpu_online(cpu)) {
(gdb) b *bit_waitqueue+0x28
Breakpoint 1 at 0xffffffff8014d3f8: file include/linux/mm.h, line 660.
(gdb) c
Continuing.

Breakpoint 1, page_zonenum (word=0xa8000000438129b0, bit=3)
    at include/linux/mm.h:660
660             return (page->flags >> ZONES_PGSHIFT) & ZONES_MASK;
(gdb) where
#0  page_zonenum (word=0xa8000000438129b0, bit=3) at include/linux/mm.h:660
#1  page_zone (word=0xa8000000438129b0, bit=3) at include/linux/mm.h:696
#2  bit_waitqueue (word=0xa8000000438129b0, bit=3) at kernel/wait.c:284
#3  0xffffffff8014d4d0 in wake_up_bit (word=0xa8000000438129b0,
    bit=<value optimized out>) at kernel/wait.c:277
#4  0xffffffff80234dfc in proc_get_inode (sb=<value optimized out>,
    de=0xa800000043c07c00) at fs/proc/inode.c:480
#5  0xffffffff8023b278 in proc_lookup_de (de=0xa800000043c07c00,
    dir=0xa800000043812040, dentry=0xa800000043897c00) at fs/proc/generic.c:431
#6  0xffffffff8023502c in proc_root_lookup (dir=0xa800000043812040,
    dentry=0xa800000043897c00, flags=<value optimized out>)
    at fs/proc/root.c:204
#7  0xffffffff801edd7c in lookup_real (dir=<value optimized out>,
    dentry=0xa800000043897c00, flags=<value optimized out>) at fs/namei.c:1266
#8  0xffffffff801f2620 in lookup_open (nd=0xa800000041c87da0,
    path=0xa800000041c87d20, file=0xa800000041c5c840, op=0xa800000041c87e60,
    opened=0xa800000041c87d10, pathname=<value optimized out>)
    at fs/namei.c:2587
#9  do_last (nd=0xa800000041c87da0, path=0xa800000041c87d20,
    file=0xa800000041c5c840, op=0xa800000041c87e60, opened=0xa800000041c87d10,
    pathname=<value optimized out>) at fs/namei.c:2717
#10 0xffffffff801f2b20 in path_openat (dfd=<value optimized out>,
    pathname=0xa800000041c55000 "/proc/mounts", nd=0xa800000041c87da0,
    op=0xa800000041c87e60, flags=<value optimized out>) at fs/namei.c:2902
#11 0xffffffff801f32e8 in do_filp_open (dfd=<value optimized out>,
    pathname=0xa800000041c55000 "/proc/mounts", op=0xa800000041c87e60,
    flags=<value optimized out>) at fs/namei.c:2950
#12 0xffffffff801e2a60 in do_sys_open (dfd=<value optimized out>,
    filename=<value optimized out>, flags=<value optimized out>,
    mode=<value optimized out>) at fs/open.c:954
#13 0xffffffff80110ba4 in handle_sysn32 () at arch/mips/kernel/scall64-n32.S:61
Backtrace stopped: frame did not save the PC
(gdb) x/x 0xa8000000438129b0
0xa8000000438129b0:     0x00000000
(gdb) c
Continuing.

Breakpoint 1, page_zonenum (word=0xa8000000438129b0, bit=7)
    at include/linux/mm.h:660
660             return (page->flags >> ZONES_PGSHIFT) & ZONES_MASK;
(gdb) where
#0  page_zonenum (word=0xa8000000438129b0, bit=7) at include/linux/mm.h:660
#1  page_zone (word=0xa8000000438129b0, bit=7) at include/linux/mm.h:696
#2  bit_waitqueue (word=0xa8000000438129b0, bit=7) at kernel/wait.c:284
#3  0xffffffff80207a2c in __inode_wait_for_writeback (inode=0xa800000043812920)
    at fs/fs-writeback.c:335
#4  0xffffffff801fcb7c in evict (inode=0xa800000043812920) at fs/inode.c:539
#5  0xffffffff801f95f8 in dentry_iput (dentry=0xa800000043897c00,
    parent=0xa800000043801240) at fs/dcache.c:278
#6  d_kill (dentry=0xa800000043897c00, parent=0xa800000043801240)
    at fs/dcache.c:395
#7  0xffffffff801f9be4 in dentry_kill (dentry=0xa800000043897c00)
    at fs/dcache.c:514
#8  dput (dentry=0xa800000043897c00) at fs/dcache.c:582
#9  0xffffffff801edf60 in path_put (path=0xa800000041c87d30) at fs/namei.c:415
#10 0xffffffff801f2dd0 in put_link (dfd=<value optimized out>,
    pathname=<value optimized out>, nd=0xa800000041c87da0,
    op=0xa800000041c87e60, flags=<value optimized out>) at fs/namei.c:651
#11 path_openat (dfd=<value optimized out>, pathname=<value optimized out>,
    nd=0xa800000041c87da0, op=0xa800000041c87e60, flags=<value optimized out>)
    at fs/namei.c:2921
#12 0xffffffff801f32e8 in do_filp_open (dfd=<value optimized out>,
    pathname=0xa800000041c55000 "/proc/mounts", op=0xa800000041c87e60,
    flags=<value optimized out>) at fs/namei.c:2950
#13 0xffffffff801e2a60 in do_sys_open (dfd=<value optimized out>,
    filename=<value optimized out>, flags=<value optimized out>,
    mode=<value optimized out>) at fs/open.c:954
#14 0xffffffff80110ba4 in handle_sysn32 () at arch/mips/kernel/scall64-n32.S:61
Backtrace stopped: frame did not save the PC
(gdb) c
Continuing.

Breakpoint 1, page_zonenum (word=0xa8000000438129b0, bit=3)
    at include/linux/mm.h:660
660             return (page->flags >> ZONES_PGSHIFT) & ZONES_MASK;
(gdb) where
#0  page_zonenum (word=0xa8000000438129b0, bit=3) at include/linux/mm.h:660
#1  page_zone (word=0xa8000000438129b0, bit=3) at include/linux/mm.h:696
#2  bit_waitqueue (word=0xa8000000438129b0, bit=3) at kernel/wait.c:284
#3  0xffffffff8014d4d0 in wake_up_bit (word=0xa8000000438129b0,
    bit=<value optimized out>) at kernel/wait.c:277
#4  0xffffffff801fcbe0 in evict (inode=0xa800000043812920) at fs/inode.c:556
#5  0xffffffff801f95f8 in dentry_iput (dentry=0xa800000043897c00,
    parent=0xa800000043801240) at fs/dcache.c:278
#6  d_kill (dentry=0xa800000043897c00, parent=0xa800000043801240)
    at fs/dcache.c:395
#7  0xffffffff801f9be4 in dentry_kill (dentry=0xa800000043897c00)
    at fs/dcache.c:514
#8  dput (dentry=0xa800000043897c00) at fs/dcache.c:582
#9  0xffffffff801edf60 in path_put (path=0xa800000041c87d30) at fs/namei.c:415
#10 0xffffffff801f2dd0 in put_link (dfd=<value optimized out>,
    pathname=<value optimized out>, nd=0xa800000041c87da0,
    op=0xa800000041c87e60, flags=<value optimized out>) at fs/namei.c:651
#11 path_openat (dfd=<value optimized out>, pathname=<value optimized out>,
    nd=0xa800000041c87da0, op=0xa800000041c87e60, flags=<value optimized out>)
    at fs/namei.c:2921
#12 0xffffffff801f32e8 in do_filp_open (dfd=<value optimized out>,
    pathname=0xa800000041c55000 "/proc/mounts", op=0xa800000041c87e60,
    flags=<value optimized out>) at fs/namei.c:2950
#13 0xffffffff801e2a60 in do_sys_open (dfd=<value optimized out>,
    filename=<value optimized out>, flags=<value optimized out>,
    mode=<value optimized out>) at fs/open.c:954
#14 0xffffffff80110ba4 in handle_sysn32 () at arch/mips/kernel/scall64-n32.S:61
Backtrace stopped: frame did not save the PC
(gdb) c
Continuing.

Breakpoint 1, page_zonenum (word=0xffffffff8050f8c0, bit=0)
    at include/linux/mm.h:660
660             return (page->flags >> ZONES_PGSHIFT) & ZONES_MASK;
(gdb) where
#0  page_zonenum (word=0xffffffff8050f8c0, bit=0) at include/linux/mm.h:660
#1  page_zone (word=0xffffffff8050f8c0, bit=0) at include/linux/mm.h:696
#2  bit_waitqueue (word=0xffffffff8050f8c0, bit=0) at kernel/wait.c:284
#3  0xffffffff8014d4d0 in wake_up_bit (word=0xffffffff8050f8c0,
    bit=<value optimized out>) at kernel/wait.c:277
#4  0xffffffff801b54f4 in bdi_forker_thread (ptr=0xffffffff80502f28)
    at mm/backing-dev.c:446
#5  0xffffffff8014cda8 in kthread (_create=0xa800000043c3bd28)
    at kernel/kthread.c:121
#6  0xffffffff80105450 in kernel_thread_helper (arg=<value optimized out>,
    fn=<value optimized out>) at arch/mips/kernel/process.c:229
#7  0x0000000000000000 in ?? ()
(gdb) x/x 0xffffffff8050f8c0
0xffffffff8050f8c0 <mtd_bdi_unmappable+24>:     0x00000000
(gdb) clear *bit_waitqueue+0x28
Deleted breakpoint 1
(gdb) c
Continuing.

[    0.000000] Initializing cgroup subsys cpuset
[    0.000000] Initializing cgroup subsys cpu
[    0.000000] Linux version 3.6.3 (root@169.254.1.3) (gcc version 4.5.1 (GCC) ) #1 Mon Oct 29 16:35:16 EDT 2012
[    0.000000] Credit distribution complete.
[    0.000000] bootconsole [early0] enabled
[    0.000000] CPU revision is: 000cce01 (Netlogic XLS)
[    0.000000] Checking for the multiply/shift bug... no.
[    0.000000] Checking for the daddiu bug... no.
[    0.000000] Determined physical RAM map:
[    0.000000]  memory: 000000000bf00000 @ 0000000000100000 (usable)
[    0.000000]  memory: 0000000004000000 @ 0000000040000000 (usable)
[    0.000000] Wasting 14336 bytes for tracking 256 unused pages
[    0.000000] Initrd not found or empty - disabling initrd
[    0.000000] Zone ranges:
[    0.000000]   DMA      [mem 0x00100000-0x00ffffff]
[    0.000000]   Normal   [mem 0x01000000-0x43ffffff]
[    0.000000] Movable zone start for each node
[    0.000000] Early memory node ranges
[    0.000000]   node   0: [mem 0x00100000-0x0bffffff]
[    0.000000]   node   0: [mem 0x40000000-0x43ffffff]
[    0.000000] Primary instruction cache 32kB, VIPT, 8-way, linesize 32 bytes.
[    0.000000] Primary data cache 32kB, 8-way, PIPT, no aliases, linesize 32 bytes
[    0.000000] Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 61475
[    0.000000] Kernel command line: run nowait console=ttyS0,38400
[    0.000000] PID hash table entries: 1024 (order: 1, 8192 bytes)
[    0.000000] Dentry cache hash table entries: 32768 (order: 6, 262144 bytes)
[    0.000000] Inode-cache hash table entries: 16384 (order: 5, 131072 bytes)
[    0.000000] __ex_table already sorted, skipping sort
[    0.000000] Wait instruction disabled.
[    0.000000] Memory: 233260k/261120k available (3286k kernel code, 27860k reserved, 923k data, 7384k init, 0k highmem)
[    0.000000] SLUB: Genslabs=15, HWalign=32, Order=0-3, MinObjects=0, CPUs=1, Nodes=1
[    0.000000] NR_IRQS:64
[    0.000000] MIPS counter frequency [500000000]
[    0.000000] Console: colour dummy device 80x25
[    0.000000] console [ttyS0] enabled, bootconsole disabled
[    0.000000] console [ttyS0] enabled, bootconsole disabled
[    0.002000] Calibrating delay loop... 331.77 BogoMIPS (lpj=165888)
[    0.014000] pid_max: default: 32768 minimum: 301
[    0.015000] Mount-cache hash table entries: 256
[    0.016000] Initializing cgroup subsys cpuacct
[    0.017000] Initializing cgroup subsys devices
[    0.018000] Initializing cgroup subsys freezer
[    0.019000] Initializing cgroup subsys blkio
[    0.020000] Initializing cgroup subsys perf_event
[    0.021000] Checking for the daddi bug... no.
[    0.024000] devtmpfs: initialized
[    0.026000] atomic64 test passed
[    0.027000] NET: Registered protocol family 16
[    0.028000] ChipSelect 1: NAND Flash [mem 0x1c800000-0x1c810000]
[    0.032000] bio: create slab <bio-0> at 0
[    0.034000] Switching to clocksource MIPS
[    0.052000] NET: Registered protocol family 2
[    0.066000] TCP established hash table entries: 8192 (order: 5, 131072 bytes)
[    0.088000] TCP bind hash table entries: 8192 (order: 4, 65536 bytes)
[    0.107000] TCP: Hash tables configured (established 8192 bind 8192)
[    0.127000] TCP: reno registered
[    0.136000] UDP hash table entries: 256 (order: 1, 8192 bytes)
[    0.154000] UDP-Lite hash table entries: 256 (order: 1, 8192 bytes)
[    0.173000] NET: Registered protocol family 1
[    1.446000] audit: initializing netlink socket (disabled)
[    1.462000] type=2000 audit(1.461:1): initialized
[    1.478000] HugeTLB registered 2 MB page size, pre-allocated 0 pages
[    1.510000] jffs2: version 2.2. (NAND) © 2001-2006 Red Hat, Inc.
[    1.530000] msgmni has been set to 455
[    1.556000] Block layer SCSI generic (bsg) driver version 0.4 loaded (major 253)
[    1.579000] io scheduler noop registered
[    1.591000] io scheduler deadline registered
[    1.604000] io scheduler cfq registered (default)
[    1.619000] XLR/XLS GPIO Driver
[    1.629000] Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled
[    1.650000] serial8250.0: ttyS0 at MMIO 0x1ef14000 (irq = 17) is a 16550A
[    1.671000] serial8250.0: ttyS1 at MMIO 0x1ef15100 (irq = 18) is a 16550A
[    1.698000] loop: module loaded
[    1.709000] ONFI param page 0 valid
[    1.720000] ONFI flash detected
[    1.729000] NAND device: Manufacturer ID: 0x2c, Chip ID: 0xda (Micron MT29F2G08ABAEAH4), page size: 2048, OOB size: 64
[    1.761000] Scanning device for bad blocks
[    2.154000] Creating 4 MTD partitions on "gen_nand":
[    2.169000] 0x000000000000-0x000004000000 : "Root Filesystem"
[    2.187000] 0x000004000000-0x000007200000 : "Bank1 Filesystem"
[    2.205000] 0x000007200000-0x00000a400000 : "Bank2 Filesystem"
[    2.223000] 0x00000a400000-0x000010000000 : "Stortage Filesystem"
[    2.243000] XLR/XLS Ethernet Driver
[    2.254000] Using class-based distribution
[    2.266000] Initializing the gmac0
[    2.284000] libphy: xlr-mdio: probed
[    2.295000] Registerd mdio bus id : xlr-mdio-0
[    2.308000] attached PHY driver [Generic PHY] (mii_bus:phy_addr=xlr-mdio-0:00
[    2.338000] Initializing the gmac1
[    2.362000] libphy: xlr-mdio: probed
[    2.373000] Registerd mdio bus id : xlr-mdio-1
[    2.387000] attached PHY driver [Fixed PHY] (mii_bus:phy_addr=xlr-mdio-1:1c
[    2.411000] mousedev: PS/2 mouse device common for all mice
[    2.428000] softdog: Software Watchdog Timer: 0.08 initialized. soft_noboot=0 soft_margin=60 sec soft_panic=0 (nowayout=0)
[    2.462000] TCP: cubic registered
[    2.472000] NET: Registered protocol family 17
[    2.486000] 8021q: 802.1Q VLAN Support v1.8
[    2.500000] registered taskstats version 1
[    2.514000] Warning: unable to open an initial console.
[    2.541000] Freeing unused kernel memory: 7384k freed
Starting klogd...
Starting syslog...
Exporting GPIOs...
Configuring interfaces...
[    2.797000] device eth0 entered promiscuous mode
[    2.818000] device eth1 entered promiscuous mode
[    2.842000] br0: port 2(eth1) entered forwarding state
[    2.858000] br0: port 2(eth1) entered forwarding state
[    2.873000] br0: port 1(eth0) entered forwarding state
[    2.889000] br0: port 1(eth0) entered forwarding state
Starting inetd...
Starting sshd...

Please press Enter to activate this console. [    3.812000] br0: port 1(eth0) entered disabled state

[    5.314000] br0: port 1(eth0) entered forwarding state
[    5.329000] br0: port 1(eth0) entered forwarding state
sh-4.2# flash_erase -j /dev/mtd3 0 0

Erasing 128 Kibyte @ 0 --  0 % complete flash_erase:  Cleanmarker written at 0

Erasing 128 Kibyte @ 20000 --  0 % complete flash_erase:  Cleanmarker written at 20000

Erasing 128 Kibyte @ 40000 --  0 % complete flash_erase:  Cleanmarker written at 40000

Erasing 128 Kibyte @ 60000 --  0 % complete flash_erase:  Cleanmarker written at 60000

Erasing 128 Kibyte @ 80000 --  0 % complete flash_erase:  Cleanmarker written at 80000

Erasing 128 Kibyte @ a0000 --  0 % complete flash_erase:  Cleanmarker written at a0000

Erasing 128 Kibyte @ c0000 --  0 % complete flash_erase:  Cleanmarker written at c0000

Erasing 128 Kibyte @ e0000 --  0 % complete flash_erase:  Cleanmarker written at e0000

Erasing 128 Kibyte @ 100000 --  1 % complete flash_erase:  Cleanmarker written at 100000

Erasing 128 Kibyte @ 120000 --  1 % complete flash_erase:  Cleanmarker written at 120000

Erasing 128 Kibyte @ 140000 --  1 % complete flash_erase:  Cleanmarker written at 140000

Erasing 128 Kibyte @ 160000 --  1 % complete flash_erase:  Cleanmarker written at 160000

Erasing 128 Kibyte @ 180000 --  1 % complete flash_erase:  Cleanmarker written at 180000

Erasing 128 Kibyte @ 1a0000 --  1 % complete flash_erase:  Cleanmarker written at 1a0000

Erasing 128 Kibyte @ 1c0000 --  1 % complete flash_erase:  Cleanmarker written at 1c0000

Erasing 128 Kibyte @ 1e0000 --  2 % complete flash_erase:  Cleanmarker written at 1e0000

Erasing 128 Kibyte @ 200000 --  2 % complete flash_erase:  Cleanmarker written at 200000

Erasing 128 Kibyte @ 220000 --  2 % complete flash_erase:  Cleanmarker written at 220000

Erasing 128 Kibyte @ 240000 --  2 % complete flash_erase:  Cleanmarker written at 240000

Erasing 128 Kibyte @ 260000 --  2 % complete flash_erase:  Cleanmarker written at 260000

Erasing 128 Kibyte @ 280000 --  2 % complete flash_erase:  Cleanmarker written at 280000

Erasing 128 Kibyte @ 2a0000 --  2 % complete flash_erase:  Cleanmarker written at 2a0000

Erasing 128 Kibyte @ 2c0000 --  2 % complete flash_erase:  Cleanmarker written at 2c0000

Erasing 128 Kibyte @ 2e0000 --  3 % complete flash_erase:  Cleanmarker written at 2e0000

Erasing 128 Kibyte @ 300000 --  3 % complete flash_erase:  Cleanmarker written at 300000

Erasing 128 Kibyte @ 320000 --  3 % complete flash_erase:  Cleanmarker written at 320000

Erasing 128 Kibyte @ 340000 --  3 % complete flash_erase:  Cleanmarker written at 340000

Erasing 128 Kibyte @ 360000 --  3 % complete flash_erase:  Cleanmarker written at 360000

Erasing 128 Kibyte @ 380000 --  3 % complete flash_erase:  Cleanmarker written at 380000

Erasing 128 Kibyte @ 3a0000 --  3 % complete flash_erase:  Cleanmarker written at 3a0000

Erasing 128 Kibyte @ 3c0000 --  4 % complete flash_erase:  Cleanmarker written at 3c0000

Erasing 128 Kibyte @ 3e0000 --  4 % complete flash_erase:  Cleanmarker written at 3e0000

Erasing 128 Kibyte @ 400000 --  4 % complete flash_erase:  Cleanmarker written at 400000

Erasing 128 Kibyte @ 420000 --  4 % complete flash_erase:  Cleanmarker written at 420000

Erasing 128 Kibyte @ 440000 --  4 % complete flash_erase:  Cleanmarker written at 440000

Erasing 128 Kibyte @ 460000 --  4 % complete flash_erase:  Cleanmarker written at 460000

Erasing 128 Kibyte @ 480000 --  4 % complete flash_erase:  Cleanmarker written at 480000

Erasing 128 Kibyte @ 4a0000 --  5 % complete flash_erase:  Cleanmarker written at 4a0000

Erasing 128 Kibyte @ 4c0000 --  5 % complete flash_erase:  Cleanmarker written at 4c0000

Erasing 128 Kibyte @ 4e0000 --  5 % complete flash_erase:  Cleanmarker written at 4e0000

Erasing 128 Kibyte @ 500000 --  5 % complete flash_erase:  Cleanmarker written at 500000

Erasing 128 Kibyte @ 520000 --  5 % complete flash_erase:  Cleanmarker written at 520000

Erasing 128 Kibyte @ 540000 --  5 % complete flash_erase:  Cleanmarker written at 540000

Erasing 128 Kibyte @ 560000 --  5 % complete flash_erase:  Cleanmarker written at 560000

Erasing 128 Kibyte @ 580000 --  5 % complete flash_erase:  Cleanmarker written at 580000

Erasing 128 Kibyte @ 5a0000 --  6 % complete flash_erase:  Cleanmarker written at 5a0000

Erasing 128 Kibyte @ 5c0000 --  6 % complete flash_erase:  Cleanmarker written at 5c0000

Erasing 128 Kibyte @ 5e0000 --  6 % complete flash_erase:  Cleanmarker written at 5e0000

Erasing 128 Kibyte @ 600000 --  6 % complete flash_erase:  Cleanmarker written at 600000

Erasing 128 Kibyte @ 620000 --  6 % complete flash_erase:  Cleanmarker written at 620000

Erasing 128 Kibyte @ 640000 --  6 % complete flash_erase:  Cleanmarker written at 640000

Erasing 128 Kibyte @ 660000 --  6 % complete flash_erase:  Cleanmarker written at 660000

Erasing 128 Kibyte @ 680000 --  7 % complete flash_erase:  Cleanmarker written at 680000

Erasing 128 Kibyte @ 6a0000 --  7 % complete flash_erase:  Cleanmarker written at 6a0000

Erasing 128 Kibyte @ 6c0000 --  7 % complete flash_erase:  Cleanmarker written at 6c0000

Erasing 128 Kibyte @ 6e0000 --  7 % complete flash_erase:  Cleanmarker written at 6e0000

Erasing 128 Kibyte @ 700000 --  7 % complete flash_erase:  Cleanmarker written at 700000

Erasing 128 Kibyte @ 720000 --  7 % complete flash_erase:  Cleanmarker written at 720000

Erasing 128 Kibyte @ 740000 --  7 % complete flash_erase:  Cleanmarker written at 740000

Erasing 128 Kibyte @ 760000 --  8 % complete flash_erase:  Cleanmarker written at 760000

Erasing 128 Kibyte @ 780000 --  8 % complete flash_erase:  Cleanmarker written at 780000

Erasing 128 Kibyte @ 7a0000 --  8 % complete flash_erase:  Cleanmarker written at 7a0000

Erasing 128 Kibyte @ 7c0000 --  8 % complete flash_erase:  Cleanmarker written at 7c0000

Erasing 128 Kibyte @ 7e0000 --  8 % complete flash_erase:  Cleanmarker written at 7e0000

Erasing 128 Kibyte @ 800000 --  8 % complete flash_erase:  Cleanmarker written at 800000

Erasing 128 Kibyte @ 820000 --  8 % complete flash_erase:  Cleanmarker written at 820000

Erasing 128 Kibyte @ 840000 --  8 % complete flash_erase:  Cleanmarker written at 840000

Erasing 128 Kibyte @ 860000 --  9 % complete flash_erase:  Cleanmarker written at 860000

Erasing 128 Kibyte @ 880000 --  9 % complete flash_erase:  Cleanmarker written at 880000

Erasing 128 Kibyte @ 8a0000 --  9 % complete flash_erase:  Cleanmarker written at 8a0000

Erasing 128 Kibyte @ 8c0000 --  9 % complete flash_erase:  Cleanmarker written at 8c0000

Erasing 128 Kibyte @ 8e0000 --  9 % complete flash_erase:  Cleanmarker written at 8e0000

Erasing 128 Kibyte @ 900000 --  9 % complete flash_erase:  Cleanmarker written at 900000

Erasing 128 Kibyte @ 920000 --  9 % complete flash_erase:  Cleanmarker written at 920000

Erasing 128 Kibyte @ 940000 -- 10 % complete flash_erase:  Cleanmarker written at 940000

Erasing 128 Kibyte @ 960000 -- 10 % complete flash_erase:  Cleanmarker written at 960000

Erasing 128 Kibyte @ 980000 -- 10 % complete flash_erase:  Cleanmarker written at 980000

Erasing 128 Kibyte @ 9a0000 -- 10 % complete flash_erase:  Cleanmarker written at 9a0000

Erasing 128 Kibyte @ 9c0000 -- 10 % complete flash_erase:  Cleanmarker written at 9c0000

Erasing 128 Kibyte @ 9e0000 -- 10 % complete flash_erase:  Cleanmarker written at 9e0000

Erasing 128 Kibyte @ a00000 -- 10 % complete flash_erase:  Cleanmarker written at a00000

Erasing 128 Kibyte @ a20000 -- 11 % complete flash_erase:  Cleanmarker written at a20000

Erasing 128 Kibyte @ a40000 -- 11 % complete flash_erase:  Cleanmarker written at a40000

Erasing 128 Kibyte @ a60000 -- 11 % complete flash_erase:  Cleanmarker written at a60000

Erasing 128 Kibyte @ a80000 -- 11 % complete flash_erase:  Cleanmarker written at a80000

Erasing 128 Kibyte @ aa0000 -- 11 % complete flash_erase:  Cleanmarker written at aa0000

Erasing 128 Kibyte @ ac0000 -- 11 % complete flash_erase:  Cleanmarker written at ac0000

Erasing 128 Kibyte @ ae0000 -- 11 % complete flash_erase:  Cleanmarker written at ae0000

Erasing 128 Kibyte @ b00000 -- 11 % complete flash_erase:  Cleanmarker written at b00000

Erasing 128 Kibyte @ b20000 -- 12 % complete flash_erase:  Cleanmarker written at b20000

Erasing 128 Kibyte @ b40000 -- 12 % complete flash_erase:  Cleanmarker written at b40000

Erasing 128 Kibyte @ b60000 -- 12 % complete flash_erase:  Cleanmarker written at b60000

Erasing 128 Kibyte @ b80000 -- 12 % complete flash_erase:  Cleanmarker written at b80000

Erasing 128 Kibyte @ ba0000 -- 12 % complete flash_erase:  Cleanmarker written at ba0000

Erasing 128 Kibyte @ bc0000 -- 12 % complete flash_erase:  Cleanmarker written at bc0000

Erasing 128 Kibyte @ be0000 -- 12 % complete flash_erase:  Cleanmarker written at be0000

Erasing 128 Kibyte @ c00000 -- 13 % complete flash_erase:  Cleanmarker written at c00000

Erasing 128 Kibyte @ c20000 -- 13 % complete flash_erase:  Cleanmarker written at c20000

Erasing 128 Kibyte @ c40000 -- 13 % complete flash_erase:  Cleanmarker written at c40000

Erasing 128 Kibyte @ c60000 -- 13 % complete flash_erase:  Cleanmarker written at c60000

Erasing 128 Kibyte @ c80000 -- 13 % complete flash_erase:  Cleanmarker written at c80000

Erasing 128 Kibyte @ ca0000 -- 13 % complete flash_erase:  Cleanmarker written at ca0000

Erasing 128 Kibyte @ cc0000 -- 13 % complete flash_erase:  Cleanmarker written at cc0000

Erasing 128 Kibyte @ ce0000 -- 13 % complete flash_erase:  Cleanmarker written at ce0000

Erasing 128 Kibyte @ d00000 -- 14 % complete flash_erase:  Cleanmarker written at d00000

Erasing 128 Kibyte @ d20000 -- 14 % complete flash_erase:  Cleanmarker written at d20000

Erasing 128 Kibyte @ d40000 -- 14 % complete flash_erase:  Cleanmarker written at d40000

Erasing 128 Kibyte @ d60000 -- 14 % complete flash_erase:  Cleanmarker written at d60000

Erasing 128 Kibyte @ d80000 -- 14 % complete flash_erase:  Cleanmarker written at d80000

Erasing 128 Kibyte @ da0000 -- 14 % complete flash_erase:  Cleanmarker written at da0000

Erasing 128 Kibyte @ dc0000 -- 14 % complete flash_erase:  Cleanmarker written at dc0000

Erasing 128 Kibyte @ de0000 -- 15 % complete flash_erase:  Cleanmarker written at de0000

Erasing 128 Kibyte @ e00000 -- 15 % complete flash_erase:  Cleanmarker written at e00000

Erasing 128 Kibyte @ e20000 -- 15 % complete flash_erase:  Cleanmarker written at e20000

Erasing 128 Kibyte @ e40000 -- 15 % complete flash_erase:  Cleanmarker written at e40000

Erasing 128 Kibyte @ e60000 -- 15 % complete flash_erase:  Cleanmarker written at e60000

Erasing 128 Kibyte @ e80000 -- 15 % complete flash_erase:  Cleanmarker written at e80000

Erasing 128 Kibyte @ ea0000 -- 15 % complete flash_erase:  Cleanmarker written at ea0000

Erasing 128 Kibyte @ ec0000 -- 16 % complete flash_erase:  Cleanmarker written at ec0000

Erasing 128 Kibyte @ ee0000 -- 16 % complete flash_erase:  Cleanmarker written at ee0000

Erasing 128 Kibyte @ f00000 -- 16 % complete flash_erase:  Cleanmarker written at f00000

Erasing 128 Kibyte @ f20000 -- 16 % complete flash_erase:  Cleanmarker written at f20000

Erasing 128 Kibyte @ f40000 -- 16 % complete flash_erase:  Cleanmarker written at f40000

Erasing 128 Kibyte @ f60000 -- 16 % complete flash_erase:  Cleanmarker written at f60000

Erasing 128 Kibyte @ f80000 -- 16 % complete flash_erase:  Cleanmarker written at f80000

Erasing 128 Kibyte @ fa0000 -- 16 % complete flash_erase:  Cleanmarker written at fa0000

Erasing 128 Kibyte @ fc0000 -- 17 % complete flash_erase:  Cleanmarker written at fc0000

Erasing 128 Kibyte @ fe0000 -- 17 % complete flash_erase:  Cleanmarker written at fe0000

Erasing 128 Kibyte @ 1000000 -- 17 % complete flash_erase:  Cleanmarker written at 1000000

Erasing 128 Kibyte @ 1020000 -- 17 % complete flash_erase:  Cleanmarker written at 1020000

Erasing 128 Kibyte @ 1040000 -- 17 % complete flash_erase:  Cleanmarker written at 1040000

Erasing 128 Kibyte @ 1060000 -- 17 % complete flash_erase:  Cleanmarker written at 1060000

Erasing 128 Kibyte @ 1080000 -- 17 % complete flash_erase:  Cleanmarker written at 1080000

Erasing 128 Kibyte @ 10a0000 -- 18 % complete flash_erase:  Cleanmarker written at 10a0000

Erasing 128 Kibyte @ 10c0000 -- 18 % complete flash_erase:  Cleanmarker written at 10c0000

Erasing 128 Kibyte @ 10e0000 -- 18 % complete flash_erase:  Cleanmarker written at 10e0000

Erasing 128 Kibyte @ 1100000 -- 18 % complete flash_erase:  Cleanmarker written at 1100000

Erasing 128 Kibyte @ 1120000 -- 18 % complete flash_erase:  Cleanmarker written at 1120000

Erasing 128 Kibyte @ 1140000 -- 18 % complete flash_erase:  Cleanmarker written at 1140000

Erasing 128 Kibyte @ 1160000 -- 18 % complete flash_erase:  Cleanmarker written at 1160000

Erasing 128 Kibyte @ 1180000 -- 19 % complete flash_erase:  Cleanmarker written at 1180000

Erasing 128 Kibyte @ 11a0000 -- 19 % complete flash_erase:  Cleanmarker written at 11a0000

Erasing 128 Kibyte @ 11c0000 -- 19 % complete flash_erase:  Cleanmarker written at 11c0000

Erasing 128 Kibyte @ 11e0000 -- 19 % complete flash_erase:  Cleanmarker written at 11e0000

Erasing 128 Kibyte @ 1200000 -- 19 % complete flash_erase:  Cleanmarker written at 1200000

Erasing 128 Kibyte @ 1220000 -- 19 % complete flash_erase:  Cleanmarker written at 1220000

Erasing 128 Kibyte @ 1240000 -- 19 % complete flash_erase:  Cleanmarker written at 1240000

Erasing 128 Kibyte @ 1260000 -- 19 % complete flash_erase:  Cleanmarker written at 1260000

Erasing 128 Kibyte @ 1280000 -- 20 % complete flash_erase:  Cleanmarker written at 1280000

Erasing 128 Kibyte @ 12a0000 -- 20 % complete flash_erase:  Cleanmarker written at 12a0000

Erasing 128 Kibyte @ 12c0000 -- 20 % complete flash_erase:  Cleanmarker written at 12c0000

Erasing 128 Kibyte @ 12e0000 -- 20 % complete flash_erase:  Cleanmarker written at 12e0000

Erasing 128 Kibyte @ 1300000 -- 20 % complete flash_erase:  Cleanmarker written at 1300000

Erasing 128 Kibyte @ 1320000 -- 20 % complete flash_erase:  Cleanmarker written at 1320000

Erasing 128 Kibyte @ 1340000 -- 20 % complete flash_erase:  Cleanmarker written at 1340000

Erasing 128 Kibyte @ 1360000 -- 21 % complete flash_erase:  Cleanmarker written at 1360000

Erasing 128 Kibyte @ 1380000 -- 21 % complete flash_erase:  Cleanmarker written at 1380000

Erasing 128 Kibyte @ 13a0000 -- 21 % complete flash_erase:  Cleanmarker written at 13a0000

Erasing 128 Kibyte @ 13c0000 -- 21 % complete flash_erase:  Cleanmarker written at 13c0000

Erasing 128 Kibyte @ 13e0000 -- 21 % complete flash_erase:  Cleanmarker written at 13e0000

Erasing 128 Kibyte @ 1400000 -- 21 % complete flash_erase:  Cleanmarker written at 1400000

Erasing 128 Kibyte @ 1420000 -- 21 % complete flash_erase:  Cleanmarker written at 1420000

Erasing 128 Kibyte @ 1440000 -- 22 % complete flash_erase:  Cleanmarker written at 1440000

Erasing 128 Kibyte @ 1460000 -- 22 % complete flash_erase:  Cleanmarker written at 1460000

Erasing 128 Kibyte @ 1480000 -- 22 % complete flash_erase:  Cleanmarker written at 1480000

Erasing 128 Kibyte @ 14a0000 -- 22 % complete flash_erase:  Cleanmarker written at 14a0000

Erasing 128 Kibyte @ 14c0000 -- 22 % complete flash_erase:  Cleanmarker written at 14c0000

Erasing 128 Kibyte @ 14e0000 -- 22 % complete flash_erase:  Cleanmarker written at 14e0000

Erasing 128 Kibyte @ 1500000 -- 22 % complete flash_erase:  Cleanmarker written at 1500000

Erasing 128 Kibyte @ 1520000 -- 22 % complete flash_erase:  Cleanmarker written at 1520000

Erasing 128 Kibyte @ 1540000 -- 23 % complete flash_erase:  Cleanmarker written at 1540000

Erasing 128 Kibyte @ 1560000 -- 23 % complete flash_erase:  Cleanmarker written at 1560000

Erasing 128 Kibyte @ 1580000 -- 23 % complete flash_erase:  Cleanmarker written at 1580000

Erasing 128 Kibyte @ 15a0000 -- 23 % complete flash_erase:  Cleanmarker written at 15a0000

Erasing 128 Kibyte @ 15c0000 -- 23 % complete flash_erase:  Cleanmarker written at 15c0000

Erasing 128 Kibyte @ 15e0000 -- 23 % complete flash_erase:  Cleanmarker written at 15e0000

Erasing 128 Kibyte @ 1600000 -- 23 % complete flash_erase:  Cleanmarker written at 1600000

Erasing 128 Kibyte @ 1620000 -- 24 % complete flash_erase:  Cleanmarker written at 1620000

Erasing 128 Kibyte @ 1640000 -- 24 % complete flash_erase:  Cleanmarker written at 1640000

Erasing 128 Kibyte @ 1660000 -- 24 % complete flash_erase:  Cleanmarker written at 1660000

Erasing 128 Kibyte @ 1680000 -- 24 % complete flash_erase:  Cleanmarker written at 1680000

Erasing 128 Kibyte @ 16a0000 -- 24 % complete flash_erase:  Cleanmarker written at 16a0000

Erasing 128 Kibyte @ 16c0000 -- 24 % complete flash_erase:  Cleanmarker written at 16c0000

Erasing 128 Kibyte @ 16e0000 -- 24 % complete flash_erase:  Cleanmarker written at 16e0000

Erasing 128 Kibyte @ 1700000 -- 25 % complete flash_erase:  Cleanmarker written at 1700000

Erasing 128 Kibyte @ 1720000 -- 25 % complete flash_erase:  Cleanmarker written at 1720000

Erasing 128 Kibyte @ 1740000 -- 25 % complete flash_erase:  Cleanmarker written at 1740000

Erasing 128 Kibyte @ 1760000 -- 25 % complete flash_erase:  Cleanmarker written at 1760000

Erasing 128 Kibyte @ 1780000 -- 25 % complete flash_erase:  Cleanmarker written at 1780000

Erasing 128 Kibyte @ 17a0000 -- 25 % complete flash_erase:  Cleanmarker written at 17a0000

Erasing 128 Kibyte @ 17c0000 -- 25 % complete flash_erase:  Cleanmarker written at 17c0000

Erasing 128 Kibyte @ 17e0000 -- 25 % complete flash_erase:  Cleanmarker written at 17e0000

Erasing 128 Kibyte @ 1800000 -- 26 % complete flash_erase:  Cleanmarker written at 1800000

Erasing 128 Kibyte @ 1820000 -- 26 % complete flash_erase:  Cleanmarker written at 1820000

Erasing 128 Kibyte @ 1840000 -- 26 % complete flash_erase:  Cleanmarker written at 1840000

Erasing 128 Kibyte @ 1860000 -- 26 % complete flash_erase:  Cleanmarker written at 1860000

Erasing 128 Kibyte @ 1880000 -- 26 % complete flash_erase:  Cleanmarker written at 1880000

Erasing 128 Kibyte @ 18a0000 -- 26 % complete flash_erase:  Cleanmarker written at 18a0000

Erasing 128 Kibyte @ 18c0000 -- 26 % complete flash_erase:  Cleanmarker written at 18c0000

Erasing 128 Kibyte @ 18e0000 -- 27 % complete flash_erase:  Cleanmarker written at 18e0000

Erasing 128 Kibyte @ 1900000 -- 27 % complete flash_erase:  Cleanmarker written at 1900000

Erasing 128 Kibyte @ 1920000 -- 27 % complete flash_erase:  Cleanmarker written at 1920000

Erasing 128 Kibyte @ 1940000 -- 27 % complete flash_erase:  Cleanmarker written at 1940000

Erasing 128 Kibyte @ 1960000 -- 27 % complete flash_erase:  Cleanmarker written at 1960000

Erasing 128 Kibyte @ 1980000 -- 27 % complete flash_erase:  Cleanmarker written at 1980000

Erasing 128 Kibyte @ 19a0000 -- 27 % complete flash_erase:  Cleanmarker written at 19a0000

Erasing 128 Kibyte @ 19c0000 -- 27 % complete flash_erase:  Cleanmarker written at 19c0000

Erasing 128 Kibyte @ 19e0000 -- 28 % complete flash_erase:  Cleanmarker written at 19e0000

Erasing 128 Kibyte @ 1a00000 -- 28 % complete flash_erase:  Cleanmarker written at 1a00000

Erasing 128 Kibyte @ 1a20000 -- 28 % complete flash_erase:  Cleanmarker written at 1a20000

Erasing 128 Kibyte @ 1a40000 -- 28 % complete flash_erase:  Cleanmarker written at 1a40000

Erasing 128 Kibyte @ 1a60000 -- 28 % complete flash_erase:  Cleanmarker written at 1a60000

Erasing 128 Kibyte @ 1a80000 -- 28 % complete flash_erase:  Cleanmarker written at 1a80000

Erasing 128 Kibyte @ 1aa0000 -- 28 % complete flash_erase:  Cleanmarker written at 1aa0000

Erasing 128 Kibyte @ 1ac0000 -- 29 % complete flash_erase:  Cleanmarker written at 1ac0000

Erasing 128 Kibyte @ 1ae0000 -- 29 % complete flash_erase:  Cleanmarker written at 1ae0000

Erasing 128 Kibyte @ 1b00000 -- 29 % complete flash_erase:  Cleanmarker written at 1b00000

Erasing 128 Kibyte @ 1b20000 -- 29 % complete flash_erase:  Cleanmarker written at 1b20000

Erasing 128 Kibyte @ 1b40000 -- 29 % complete flash_erase:  Cleanmarker written at 1b40000

Erasing 128 Kibyte @ 1b60000 -- 29 % complete flash_erase:  Cleanmarker written at 1b60000

Erasing 128 Kibyte @ 1b80000 -- 29 % complete flash_erase:  Cleanmarker written at 1b80000

Erasing 128 Kibyte @ 1ba0000 -- 30 % complete flash_erase:  Cleanmarker written at 1ba0000

Erasing 128 Kibyte @ 1bc0000 -- 30 % complete flash_erase:  Cleanmarker written at 1bc0000

Erasing 128 Kibyte @ 1be0000 -- 30 % complete flash_erase:  Cleanmarker written at 1be0000

Erasing 128 Kibyte @ 1c00000 -- 30 % complete flash_erase:  Cleanmarker written at 1c00000

Erasing 128 Kibyte @ 1c20000 -- 30 % complete flash_erase:  Cleanmarker written at 1c20000

Erasing 128 Kibyte @ 1c40000 -- 30 % complete flash_erase:  Cleanmarker written at 1c40000

Erasing 128 Kibyte @ 1c60000 -- 30 % complete flash_erase:  Cleanmarker written at 1c60000

Erasing 128 Kibyte @ 1c80000 -- 30 % complete flash_erase:  Cleanmarker written at 1c80000

Erasing 128 Kibyte @ 1ca0000 -- 31 % complete flash_erase:  Cleanmarker written at 1ca0000

Erasing 128 Kibyte @ 1cc0000 -- 31 % complete flash_erase:  Cleanmarker written at 1cc0000

Erasing 128 Kibyte @ 1ce0000 -- 31 % complete flash_erase:  Cleanmarker written at 1ce0000

Erasing 128 Kibyte @ 1d00000 -- 31 % complete flash_erase:  Cleanmarker written at 1d00000

Erasing 128 Kibyte @ 1d20000 -- 31 % complete flash_erase:  Cleanmarker written at 1d20000

Erasing 128 Kibyte @ 1d40000 -- 31 % complete flash_erase:  Cleanmarker written at 1d40000

Erasing 128 Kibyte @ 1d60000 -- 31 % complete flash_erase:  Cleanmarker written at 1d60000

Erasing 128 Kibyte @ 1d80000 -- 32 % complete flash_erase:  Cleanmarker written at 1d80000

Erasing 128 Kibyte @ 1da0000 -- 32 % complete flash_erase:  Cleanmarker written at 1da0000

Erasing 128 Kibyte @ 1dc0000 -- 32 % complete flash_erase:  Cleanmarker written at 1dc0000

Erasing 128 Kibyte @ 1de0000 -- 32 % complete flash_erase:  Cleanmarker written at 1de0000

Erasing 128 Kibyte @ 1e00000 -- 32 % complete flash_erase:  Cleanmarker written at 1e00000

Erasing 128 Kibyte @ 1e20000 -- 32 % complete flash_erase:  Cleanmarker written at 1e20000

Erasing 128 Kibyte @ 1e40000 -- 32 % complete flash_erase:  Cleanmarker written at 1e40000

Erasing 128 Kibyte @ 1e60000 -- 33 % complete flash_erase:  Cleanmarker written at 1e60000

Erasing 128 Kibyte @ 1e80000 -- 33 % complete flash_erase:  Cleanmarker written at 1e80000

Erasing 128 Kibyte @ 1ea0000 -- 33 % complete flash_erase:  Cleanmarker written at 1ea0000

Erasing 128 Kibyte @ 1ec0000 -- 33 % complete flash_erase:  Cleanmarker written at 1ec0000

Erasing 128 Kibyte @ 1ee0000 -- 33 % complete flash_erase:  Cleanmarker written at 1ee0000

Erasing 128 Kibyte @ 1f00000 -- 33 % complete flash_erase:  Cleanmarker written at 1f00000

Erasing 128 Kibyte @ 1f20000 -- 33 % complete flash_erase:  Cleanmarker written at 1f20000

Erasing 128 Kibyte @ 1f40000 -- 33 % complete flash_erase:  Cleanmarker written at 1f40000

Erasing 128 Kibyte @ 1f60000 -- 34 % complete flash_erase:  Cleanmarker written at 1f60000

Erasing 128 Kibyte @ 1f80000 -- 34 % complete flash_erase:  Cleanmarker written at 1f80000

Erasing 128 Kibyte @ 1fa0000 -- 34 % complete flash_erase:  Cleanmarker written at 1fa0000

Erasing 128 Kibyte @ 1fc0000 -- 34 % complete flash_erase:  Cleanmarker written at 1fc0000

Erasing 128 Kibyte @ 1fe0000 -- 34 % complete flash_erase:  Cleanmarker written at 1fe0000

Erasing 128 Kibyte @ 2000000 -- 34 % complete flash_erase:  Cleanmarker written at 2000000

Erasing 128 Kibyte @ 2020000 -- 34 % complete flash_erase:  Cleanmarker written at 2020000

Erasing 128 Kibyte @ 2040000 -- 35 % complete flash_erase:  Cleanmarker written at 2040000

Erasing 128 Kibyte @ 2060000 -- 35 % complete flash_erase:  Cleanmarker written at 2060000

Erasing 128 Kibyte @ 2080000 -- 35 % complete flash_erase:  Cleanmarker written at 2080000

Erasing 128 Kibyte @ 20a0000 -- 35 % complete flash_erase:  Cleanmarker written at 20a0000

Erasing 128 Kibyte @ 20c0000 -- 35 % complete flash_erase:  Cleanmarker written at 20c0000

Erasing 128 Kibyte @ 20e0000 -- 35 % complete flash_erase:  Cleanmarker written at 20e0000

Erasing 128 Kibyte @ 2100000 -- 35 % complete flash_erase:  Cleanmarker written at 2100000

Erasing 128 Kibyte @ 2120000 -- 36 % complete flash_erase:  Cleanmarker written at 2120000

Erasing 128 Kibyte @ 2140000 -- 36 % complete flash_erase:  Cleanmarker written at 2140000

Erasing 128 Kibyte @ 2160000 -- 36 % complete flash_erase:  Cleanmarker written at 2160000

Erasing 128 Kibyte @ 2180000 -- 36 % complete flash_erase:  Cleanmarker written at 2180000

Erasing 128 Kibyte @ 21a0000 -- 36 % complete flash_erase:  Cleanmarker written at 21a0000

Erasing 128 Kibyte @ 21c0000 -- 36 % complete flash_erase:  Cleanmarker written at 21c0000

Erasing 128 Kibyte @ 21e0000 -- 36 % complete flash_erase:  Cleanmarker written at 21e0000

Erasing 128 Kibyte @ 2200000 -- 36 % complete flash_erase:  Cleanmarker written at 2200000

Erasing 128 Kibyte @ 2220000 -- 37 % complete flash_erase:  Cleanmarker written at 2220000

Erasing 128 Kibyte @ 2240000 -- 37 % complete flash_erase:  Cleanmarker written at 2240000

Erasing 128 Kibyte @ 2260000 -- 37 % complete flash_erase:  Cleanmarker written at 2260000

Erasing 128 Kibyte @ 2280000 -- 37 % complete flash_erase:  Cleanmarker written at 2280000

Erasing 128 Kibyte @ 22a0000 -- 37 % complete flash_erase:  Cleanmarker written at 22a0000

Erasing 128 Kibyte @ 22c0000 -- 37 % complete flash_erase:  Cleanmarker written at 22c0000

Erasing 128 Kibyte @ 22e0000 -- 37 % complete flash_erase:  Cleanmarker written at 22e0000

Erasing 128 Kibyte @ 2300000 -- 38 % complete flash_erase:  Cleanmarker written at 2300000

Erasing 128 Kibyte @ 2320000 -- 38 % complete flash_erase:  Cleanmarker written at 2320000

Erasing 128 Kibyte @ 2340000 -- 38 % complete flash_erase:  Cleanmarker written at 2340000

Erasing 128 Kibyte @ 2360000 -- 38 % complete flash_erase:  Cleanmarker written at 2360000

Erasing 128 Kibyte @ 2380000 -- 38 % complete flash_erase:  Cleanmarker written at 2380000

Erasing 128 Kibyte @ 23a0000 -- 38 % complete flash_erase:  Cleanmarker written at 23a0000

Erasing 128 Kibyte @ 23c0000 -- 38 % complete flash_erase:  Cleanmarker written at 23c0000

Erasing 128 Kibyte @ 23e0000 -- 38 % complete flash_erase:  Cleanmarker written at 23e0000

Erasing 128 Kibyte @ 2400000 -- 39 % complete flash_erase:  Cleanmarker written at 2400000

Erasing 128 Kibyte @ 2420000 -- 39 % complete flash_erase:  Cleanmarker written at 2420000

Erasing 128 Kibyte @ 2440000 -- 39 % complete flash_erase:  Cleanmarker written at 2440000

Erasing 128 Kibyte @ 2460000 -- 39 % complete flash_erase:  Cleanmarker written at 2460000

Erasing 128 Kibyte @ 2480000 -- 39 % complete flash_erase:  Cleanmarker written at 2480000

Erasing 128 Kibyte @ 24a0000 -- 39 % complete flash_erase:  Cleanmarker written at 24a0000

Erasing 128 Kibyte @ 24c0000 -- 39 % complete flash_erase:  Cleanmarker written at 24c0000

Erasing 128 Kibyte @ 24e0000 -- 40 % complete flash_erase:  Cleanmarker written at 24e0000

Erasing 128 Kibyte @ 2500000 -- 40 % complete flash_erase:  Cleanmarker written at 2500000

Erasing 128 Kibyte @ 2520000 -- 40 % complete flash_erase:  Cleanmarker written at 2520000

Erasing 128 Kibyte @ 2540000 -- 40 % complete flash_erase:  Cleanmarker written at 2540000

Erasing 128 Kibyte @ 2560000 -- 40 % complete flash_erase:  Cleanmarker written at 2560000

Erasing 128 Kibyte @ 2580000 -- 40 % complete flash_erase:  Cleanmarker written at 2580000

Erasing 128 Kibyte @ 25a0000 -- 40 % complete flash_erase:  Cleanmarker written at 25a0000

Erasing 128 Kibyte @ 25c0000 -- 41 % complete flash_erase:  Cleanmarker written at 25c0000

Erasing 128 Kibyte @ 25e0000 -- 41 % complete flash_erase:  Cleanmarker written at 25e0000

Erasing 128 Kibyte @ 2600000 -- 41 % complete flash_erase:  Cleanmarker written at 2600000

Erasing 128 Kibyte @ 2620000 -- 41 % complete flash_erase:  Cleanmarker written at 2620000

Erasing 128 Kibyte @ 2640000 -- 41 % complete flash_erase:  Cleanmarker written at 2640000

Erasing 128 Kibyte @ 2660000 -- 41 % complete flash_erase:  Cleanmarker written at 2660000

Erasing 128 Kibyte @ 2680000 -- 41 % complete flash_erase:  Cleanmarker written at 2680000

Erasing 128 Kibyte @ 26a0000 -- 41 % complete flash_erase:  Cleanmarker written at 26a0000

Erasing 128 Kibyte @ 26c0000 -- 42 % complete flash_erase:  Cleanmarker written at 26c0000

Erasing 128 Kibyte @ 26e0000 -- 42 % complete flash_erase:  Cleanmarker written at 26e0000

Erasing 128 Kibyte @ 2700000 -- 42 % complete flash_erase:  Cleanmarker written at 2700000

Erasing 128 Kibyte @ 2720000 -- 42 % complete flash_erase:  Cleanmarker written at 2720000

Erasing 128 Kibyte @ 2740000 -- 42 % complete flash_erase:  Cleanmarker written at 2740000

Erasing 128 Kibyte @ 2760000 -- 42 % complete flash_erase:  Cleanmarker written at 2760000

Erasing 128 Kibyte @ 2780000 -- 42 % complete flash_erase:  Cleanmarker written at 2780000

Erasing 128 Kibyte @ 27a0000 -- 43 % complete flash_erase:  Cleanmarker written at 27a0000

Erasing 128 Kibyte @ 27c0000 -- 43 % complete flash_erase:  Cleanmarker written at 27c0000

Erasing 128 Kibyte @ 27e0000 -- 43 % complete flash_erase:  Cleanmarker written at 27e0000

Erasing 128 Kibyte @ 2800000 -- 43 % complete flash_erase:  Cleanmarker written at 2800000

Erasing 128 Kibyte @ 2820000 -- 43 % complete flash_erase:  Cleanmarker written at 2820000

Erasing 128 Kibyte @ 2840000 -- 43 % complete flash_erase:  Cleanmarker written at 2840000

Erasing 128 Kibyte @ 2860000 -- 43 % complete flash_erase:  Cleanmarker written at 2860000

Erasing 128 Kibyte @ 2880000 -- 44 % complete flash_erase:  Cleanmarker written at 2880000

Erasing 128 Kibyte @ 28a0000 -- 44 % complete flash_erase:  Cleanmarker written at 28a0000

Erasing 128 Kibyte @ 28c0000 -- 44 % complete flash_erase:  Cleanmarker written at 28c0000

Erasing 128 Kibyte @ 28e0000 -- 44 % complete flash_erase:  Cleanmarker written at 28e0000

Erasing 128 Kibyte @ 2900000 -- 44 % complete flash_erase:  Cleanmarker written at 2900000

Erasing 128 Kibyte @ 2920000 -- 44 % complete flash_erase:  Cleanmarker written at 2920000

Erasing 128 Kibyte @ 2940000 -- 44 % complete flash_erase:  Cleanmarker written at 2940000

Erasing 128 Kibyte @ 2960000 -- 44 % complete flash_erase:  Cleanmarker written at 2960000

Erasing 128 Kibyte @ 2980000 -- 45 % complete flash_erase:  Cleanmarker written at 2980000

Erasing 128 Kibyte @ 29a0000 -- 45 % complete flash_erase:  Cleanmarker written at 29a0000

Erasing 128 Kibyte @ 29c0000 -- 45 % complete flash_erase:  Cleanmarker written at 29c0000

Erasing 128 Kibyte @ 29e0000 -- 45 % complete flash_erase:  Cleanmarker written at 29e0000

Erasing 128 Kibyte @ 2a00000 -- 45 % complete flash_erase:  Cleanmarker written at 2a00000

Erasing 128 Kibyte @ 2a20000 -- 45 % complete flash_erase:  Cleanmarker written at 2a20000

Erasing 128 Kibyte @ 2a40000 -- 45 % complete flash_erase:  Cleanmarker written at 2a40000

Erasing 128 Kibyte @ 2a60000 -- 46 % complete flash_erase:  Cleanmarker written at 2a60000

Erasing 128 Kibyte @ 2a80000 -- 46 % complete flash_erase:  Cleanmarker written at 2a80000

Erasing 128 Kibyte @ 2aa0000 -- 46 % complete flash_erase:  Cleanmarker written at 2aa0000

Erasing 128 Kibyte @ 2ac0000 -- 46 % complete flash_erase:  Cleanmarker written at 2ac0000

Erasing 128 Kibyte @ 2ae0000 -- 46 % complete flash_erase:  Cleanmarker written at 2ae0000

Erasing 128 Kibyte @ 2b00000 -- 46 % complete flash_erase:  Cleanmarker written at 2b00000

Erasing 128 Kibyte @ 2b20000 -- 46 % complete flash_erase:  Cleanmarker written at 2b20000

Erasing 128 Kibyte @ 2b40000 -- 47 % complete flash_erase:  Cleanmarker written at 2b40000

Erasing 128 Kibyte @ 2b60000 -- 47 % complete flash_erase:  Cleanmarker written at 2b60000

Erasing 128 Kibyte @ 2b80000 -- 47 % complete flash_erase:  Cleanmarker written at 2b80000

Erasing 128 Kibyte @ 2ba0000 -- 47 % complete flash_erase:  Cleanmarker written at 2ba0000

Erasing 128 Kibyte @ 2bc0000 -- 47 % complete flash_erase:  Cleanmarker written at 2bc0000

Erasing 128 Kibyte @ 2be0000 -- 47 % complete flash_erase:  Cleanmarker written at 2be0000

Erasing 128 Kibyte @ 2c00000 -- 47 % complete flash_erase:  Cleanmarker written at 2c00000

Erasing 128 Kibyte @ 2c20000 -- 47 % complete flash_erase:  Cleanmarker written at 2c20000

Erasing 128 Kibyte @ 2c40000 -- 48 % complete flash_erase:  Cleanmarker written at 2c40000

Erasing 128 Kibyte @ 2c60000 -- 48 % complete flash_erase:  Cleanmarker written at 2c60000

Erasing 128 Kibyte @ 2c80000 -- 48 % complete flash_erase:  Cleanmarker written at 2c80000

Erasing 128 Kibyte @ 2ca0000 -- 48 % complete flash_erase:  Cleanmarker written at 2ca0000

Erasing 128 Kibyte @ 2cc0000 -- 48 % complete flash_erase:  Cleanmarker written at 2cc0000

Erasing 128 Kibyte @ 2ce0000 -- 48 % complete flash_erase:  Cleanmarker written at 2ce0000

Erasing 128 Kibyte @ 2d00000 -- 48 % complete flash_erase:  Cleanmarker written at 2d00000

Erasing 128 Kibyte @ 2d20000 -- 49 % complete flash_erase:  Cleanmarker written at 2d20000

Erasing 128 Kibyte @ 2d40000 -- 49 % complete flash_erase:  Cleanmarker written at 2d40000

Erasing 128 Kibyte @ 2d60000 -- 49 % complete flash_erase:  Cleanmarker written at 2d60000

Erasing 128 Kibyte @ 2d80000 -- 49 % complete flash_erase:  Cleanmarker written at 2d80000

Erasing 128 Kibyte @ 2da0000 -- 49 % complete flash_erase:  Cleanmarker written at 2da0000

Erasing 128 Kibyte @ 2dc0000 -- 49 % complete flash_erase:  Cleanmarker written at 2dc0000

Erasing 128 Kibyte @ 2de0000 -- 49 % complete flash_erase:  Cleanmarker written at 2de0000

Erasing 128 Kibyte @ 2e00000 -- 50 % complete flash_erase:  Cleanmarker written at 2e00000

Erasing 128 Kibyte @ 2e20000 -- 50 % complete flash_erase:  Cleanmarker written at 2e20000

Erasing 128 Kibyte @ 2e40000 -- 50 % complete flash_erase:  Cleanmarker written at 2e40000

Erasing 128 Kibyte @ 2e60000 -- 50 % complete flash_erase:  Cleanmarker written at 2e60000

Erasing 128 Kibyte @ 2e80000 -- 50 % complete flash_erase:  Cleanmarker written at 2e80000

Erasing 128 Kibyte @ 2ea0000 -- 50 % complete flash_erase:  Cleanmarker written at 2ea0000

Erasing 128 Kibyte @ 2ec0000 -- 50 % complete flash_erase:  Cleanmarker written at 2ec0000

Erasing 128 Kibyte @ 2ee0000 -- 50 % complete flash_erase:  Cleanmarker written at 2ee0000

Erasing 128 Kibyte @ 2f00000 -- 51 % complete flash_erase:  Cleanmarker written at 2f00000

Erasing 128 Kibyte @ 2f20000 -- 51 % complete flash_erase:  Cleanmarker written at 2f20000

Erasing 128 Kibyte @ 2f40000 -- 51 % complete flash_erase:  Cleanmarker written at 2f40000

Erasing 128 Kibyte @ 2f60000 -- 51 % complete flash_erase:  Cleanmarker written at 2f60000

Erasing 128 Kibyte @ 2f80000 -- 51 % complete flash_erase:  Cleanmarker written at 2f80000

Erasing 128 Kibyte @ 2fa0000 -- 51 % complete flash_erase:  Cleanmarker written at 2fa0000

Erasing 128 Kibyte @ 2fc0000 -- 51 % complete flash_erase:  Cleanmarker written at 2fc0000

Erasing 128 Kibyte @ 2fe0000 -- 52 % complete flash_erase:  Cleanmarker written at 2fe0000

Erasing 128 Kibyte @ 3000000 -- 52 % complete flash_erase:  Cleanmarker written at 3000000

Erasing 128 Kibyte @ 3020000 -- 52 % complete flash_erase:  Cleanmarker written at 3020000

Erasing 128 Kibyte @ 3040000 -- 52 % complete flash_erase:  Cleanmarker written at 3040000

Erasing 128 Kibyte @ 3060000 -- 52 % complete flash_erase:  Cleanmarker written at 3060000

Erasing 128 Kibyte @ 3080000 -- 52 % complete flash_erase:  Cleanmarker written at 3080000

Erasing 128 Kibyte @ 30a0000 -- 52 % complete flash_erase:  Cleanmarker written at 30a0000

Erasing 128 Kibyte @ 30c0000 -- 52 % complete flash_erase:  Cleanmarker written at 30c0000

Erasing 128 Kibyte @ 30e0000 -- 53 % complete flash_erase:  Cleanmarker written at 30e0000

Erasing 128 Kibyte @ 3100000 -- 53 % complete flash_erase:  Cleanmarker written at 3100000

Erasing 128 Kibyte @ 3120000 -- 53 % complete flash_erase:  Cleanmarker written at 3120000

Erasing 128 Kibyte @ 3140000 -- 53 % complete flash_erase:  Cleanmarker written at 3140000

Erasing 128 Kibyte @ 3160000 -- 53 % complete flash_erase:  Cleanmarker written at 3160000

Erasing 128 Kibyte @ 3180000 -- 53 % complete flash_erase:  Cleanmarker written at 3180000

Erasing 128 Kibyte @ 31a0000 -- 53 % complete flash_erase:  Cleanmarker written at 31a0000

Erasing 128 Kibyte @ 31c0000 -- 54 % complete flash_erase:  Cleanmarker written at 31c0000

Erasing 128 Kibyte @ 31e0000 -- 54 % complete flash_erase:  Cleanmarker written at 31e0000

Erasing 128 Kibyte @ 3200000 -- 54 % complete flash_erase:  Cleanmarker written at 3200000

Erasing 128 Kibyte @ 3220000 -- 54 % complete flash_erase:  Cleanmarker written at 3220000

Erasing 128 Kibyte @ 3240000 -- 54 % complete flash_erase:  Cleanmarker written at 3240000

Erasing 128 Kibyte @ 3260000 -- 54 % complete flash_erase:  Cleanmarker written at 3260000

Erasing 128 Kibyte @ 3280000 -- 54 % complete flash_erase:  Cleanmarker written at 3280000

Erasing 128 Kibyte @ 32a0000 -- 55 % complete flash_erase:  Cleanmarker written at 32a0000

Erasing 128 Kibyte @ 32c0000 -- 55 % complete flash_erase:  Cleanmarker written at 32c0000

Erasing 128 Kibyte @ 32e0000 -- 55 % complete flash_erase:  Cleanmarker written at 32e0000

Erasing 128 Kibyte @ 3300000 -- 55 % complete flash_erase:  Cleanmarker written at 3300000

Erasing 128 Kibyte @ 3320000 -- 55 % complete flash_erase:  Cleanmarker written at 3320000

Erasing 128 Kibyte @ 3340000 -- 55 % complete flash_erase:  Cleanmarker written at 3340000

Erasing 128 Kibyte @ 3360000 -- 55 % complete flash_erase:  Cleanmarker written at 3360000

Erasing 128 Kibyte @ 3380000 -- 55 % complete flash_erase:  Cleanmarker written at 3380000

Erasing 128 Kibyte @ 33a0000 -- 56 % complete flash_erase:  Cleanmarker written at 33a0000

Erasing 128 Kibyte @ 33c0000 -- 56 % complete flash_erase:  Cleanmarker written at 33c0000

Erasing 128 Kibyte @ 33e0000 -- 56 % complete flash_erase:  Cleanmarker written at 33e0000

Erasing 128 Kibyte @ 3400000 -- 56 % complete flash_erase:  Cleanmarker written at 3400000

Erasing 128 Kibyte @ 3420000 -- 56 % complete flash_erase:  Cleanmarker written at 3420000

Erasing 128 Kibyte @ 3440000 -- 56 % complete flash_erase:  Cleanmarker written at 3440000

Erasing 128 Kibyte @ 3460000 -- 56 % complete flash_erase:  Cleanmarker written at 3460000

Erasing 128 Kibyte @ 3480000 -- 57 % complete flash_erase:  Cleanmarker written at 3480000

Erasing 128 Kibyte @ 34a0000 -- 57 % complete flash_erase:  Cleanmarker written at 34a0000

Erasing 128 Kibyte @ 34c0000 -- 57 % complete flash_erase:  Cleanmarker written at 34c0000

Erasing 128 Kibyte @ 34e0000 -- 57 % complete flash_erase:  Cleanmarker written at 34e0000

Erasing 128 Kibyte @ 3500000 -- 57 % complete flash_erase:  Cleanmarker written at 3500000

Erasing 128 Kibyte @ 3520000 -- 57 % complete flash_erase:  Cleanmarker written at 3520000

Erasing 128 Kibyte @ 3540000 -- 57 % complete flash_erase:  Cleanmarker written at 3540000

Erasing 128 Kibyte @ 3560000 -- 58 % complete flash_erase:  Cleanmarker written at 3560000

Erasing 128 Kibyte @ 3580000 -- 58 % complete flash_erase:  Cleanmarker written at 3580000

Erasing 128 Kibyte @ 35a0000 -- 58 % complete flash_erase:  Cleanmarker written at 35a0000

Erasing 128 Kibyte @ 35c0000 -- 58 % complete flash_erase:  Cleanmarker written at 35c0000

Erasing 128 Kibyte @ 35e0000 -- 58 % complete flash_erase:  Cleanmarker written at 35e0000

Erasing 128 Kibyte @ 3600000 -- 58 % complete flash_erase:  Cleanmarker written at 3600000

Erasing 128 Kibyte @ 3620000 -- 58 % complete flash_erase:  Cleanmarker written at 3620000

Erasing 128 Kibyte @ 3640000 -- 58 % complete flash_erase:  Cleanmarker written at 3640000

Erasing 128 Kibyte @ 3660000 -- 59 % complete flash_erase:  Cleanmarker written at 3660000

Erasing 128 Kibyte @ 3680000 -- 59 % complete flash_erase:  Cleanmarker written at 3680000

Erasing 128 Kibyte @ 36a0000 -- 59 % complete flash_erase:  Cleanmarker written at 36a0000

Erasing 128 Kibyte @ 36c0000 -- 59 % complete flash_erase:  Cleanmarker written at 36c0000

Erasing 128 Kibyte @ 36e0000 -- 59 % complete flash_erase:  Cleanmarker written at 36e0000

Erasing 128 Kibyte @ 3700000 -- 59 % complete flash_erase:  Cleanmarker written at 3700000

Erasing 128 Kibyte @ 3720000 -- 59 % complete flash_erase:  Cleanmarker written at 3720000

Erasing 128 Kibyte @ 3740000 -- 60 % complete flash_erase:  Cleanmarker written at 3740000

Erasing 128 Kibyte @ 3760000 -- 60 % complete flash_erase:  Cleanmarker written at 3760000

Erasing 128 Kibyte @ 3780000 -- 60 % complete flash_erase:  Cleanmarker written at 3780000

Erasing 128 Kibyte @ 37a0000 -- 60 % complete flash_erase:  Cleanmarker written at 37a0000

Erasing 128 Kibyte @ 37c0000 -- 60 % complete flash_erase:  Cleanmarker written at 37c0000

Erasing 128 Kibyte @ 37e0000 -- 60 % complete flash_erase:  Cleanmarker written at 37e0000

Erasing 128 Kibyte @ 3800000 -- 60 % complete flash_erase:  Cleanmarker written at 3800000

Erasing 128 Kibyte @ 3820000 -- 61 % complete flash_erase:  Cleanmarker written at 3820000

Erasing 128 Kibyte @ 3840000 -- 61 % complete flash_erase:  Cleanmarker written at 3840000

Erasing 128 Kibyte @ 3860000 -- 61 % complete flash_erase:  Cleanmarker written at 3860000

Erasing 128 Kibyte @ 3880000 -- 61 % complete flash_erase:  Cleanmarker written at 3880000

Erasing 128 Kibyte @ 38a0000 -- 61 % complete flash_erase:  Cleanmarker written at 38a0000

Erasing 128 Kibyte @ 38c0000 -- 61 % complete flash_erase:  Cleanmarker written at 38c0000

Erasing 128 Kibyte @ 38e0000 -- 61 % complete flash_erase:  Cleanmarker written at 38e0000

Erasing 128 Kibyte @ 3900000 -- 61 % complete flash_erase:  Cleanmarker written at 3900000

Erasing 128 Kibyte @ 3920000 -- 62 % complete flash_erase:  Cleanmarker written at 3920000

Erasing 128 Kibyte @ 3940000 -- 62 % complete flash_erase:  Cleanmarker written at 3940000

Erasing 128 Kibyte @ 3960000 -- 62 % complete flash_erase:  Cleanmarker written at 3960000

Erasing 128 Kibyte @ 3980000 -- 62 % complete flash_erase:  Cleanmarker written at 3980000

Erasing 128 Kibyte @ 39a0000 -- 62 % complete flash_erase:  Cleanmarker written at 39a0000

Erasing 128 Kibyte @ 39c0000 -- 62 % complete flash_erase:  Cleanmarker written at 39c0000

Erasing 128 Kibyte @ 39e0000 -- 62 % complete flash_erase:  Cleanmarker written at 39e0000

Erasing 128 Kibyte @ 3a00000 -- 63 % complete flash_erase:  Cleanmarker written at 3a00000

Erasing 128 Kibyte @ 3a20000 -- 63 % complete flash_erase:  Cleanmarker written at 3a20000

Erasing 128 Kibyte @ 3a40000 -- 63 % complete flash_erase:  Cleanmarker written at 3a40000

Erasing 128 Kibyte @ 3a60000 -- 63 % complete flash_erase:  Cleanmarker written at 3a60000

Erasing 128 Kibyte @ 3a80000 -- 63 % complete flash_erase:  Cleanmarker written at 3a80000

Erasing 128 Kibyte @ 3aa0000 -- 63 % complete flash_erase:  Cleanmarker written at 3aa0000

Erasing 128 Kibyte @ 3ac0000 -- 63 % complete flash_erase:  Cleanmarker written at 3ac0000

Erasing 128 Kibyte @ 3ae0000 -- 63 % complete flash_erase:  Cleanmarker written at 3ae0000

Erasing 128 Kibyte @ 3b00000 -- 64 % complete flash_erase:  Cleanmarker written at 3b00000

Erasing 128 Kibyte @ 3b20000 -- 64 % complete flash_erase:  Cleanmarker written at 3b20000

Erasing 128 Kibyte @ 3b40000 -- 64 % complete flash_erase:  Cleanmarker written at 3b40000

Erasing 128 Kibyte @ 3b60000 -- 64 % complete flash_erase:  Cleanmarker written at 3b60000

Erasing 128 Kibyte @ 3b80000 -- 64 % complete flash_erase:  Cleanmarker written at 3b80000

Erasing 128 Kibyte @ 3ba0000 -- 64 % complete flash_erase:  Cleanmarker written at 3ba0000

Erasing 128 Kibyte @ 3bc0000 -- 64 % complete flash_erase:  Cleanmarker written at 3bc0000

Erasing 128 Kibyte @ 3be0000 -- 65 % complete flash_erase:  Cleanmarker written at 3be0000

Erasing 128 Kibyte @ 3c00000 -- 65 % complete flash_erase:  Cleanmarker written at 3c00000

Erasing 128 Kibyte @ 3c20000 -- 65 % complete flash_erase:  Cleanmarker written at 3c20000

Erasing 128 Kibyte @ 3c40000 -- 65 % complete flash_erase:  Cleanmarker written at 3c40000

Erasing 128 Kibyte @ 3c60000 -- 65 % complete flash_erase:  Cleanmarker written at 3c60000

Erasing 128 Kibyte @ 3c80000 -- 65 % complete flash_erase:  Cleanmarker written at 3c80000

Erasing 128 Kibyte @ 3ca0000 -- 65 % complete flash_erase:  Cleanmarker written at 3ca0000

Erasing 128 Kibyte @ 3cc0000 -- 66 % complete flash_erase:  Cleanmarker written at 3cc0000

Erasing 128 Kibyte @ 3ce0000 -- 66 % complete flash_erase:  Cleanmarker written at 3ce0000

Erasing 128 Kibyte @ 3d00000 -- 66 % complete flash_erase:  Cleanmarker written at 3d00000

Erasing 128 Kibyte @ 3d20000 -- 66 % complete flash_erase:  Cleanmarker written at 3d20000

Erasing 128 Kibyte @ 3d40000 -- 66 % complete flash_erase:  Cleanmarker written at 3d40000

Erasing 128 Kibyte @ 3d60000 -- 66 % complete flash_erase:  Cleanmarker written at 3d60000

Erasing 128 Kibyte @ 3d80000 -- 66 % complete flash_erase:  Cleanmarker written at 3d80000

Erasing 128 Kibyte @ 3da0000 -- 66 % complete flash_erase:  Cleanmarker written at 3da0000

Erasing 128 Kibyte @ 3dc0000 -- 67 % complete flash_erase:  Cleanmarker written at 3dc0000

Erasing 128 Kibyte @ 3de0000 -- 67 % complete flash_erase:  Cleanmarker written at 3de0000

Erasing 128 Kibyte @ 3e00000 -- 67 % complete flash_erase:  Cleanmarker written at 3e00000

Erasing 128 Kibyte @ 3e20000 -- 67 % complete flash_erase:  Cleanmarker written at 3e20000

Erasing 128 Kibyte @ 3e40000 -- 67 % complete flash_erase:  Cleanmarker written at 3e40000

Erasing 128 Kibyte @ 3e60000 -- 67 % complete flash_erase:  Cleanmarker written at 3e60000

Erasing 128 Kibyte @ 3e80000 -- 67 % complete flash_erase:  Cleanmarker written at 3e80000

Erasing 128 Kibyte @ 3ea0000 -- 68 % complete flash_erase:  Cleanmarker written at 3ea0000

Erasing 128 Kibyte @ 3ec0000 -- 68 % complete flash_erase:  Cleanmarker written at 3ec0000

Erasing 128 Kibyte @ 3ee0000 -- 68 % complete flash_erase:  Cleanmarker written at 3ee0000

Erasing 128 Kibyte @ 3f00000 -- 68 % complete flash_erase:  Cleanmarker written at 3f00000

Erasing 128 Kibyte @ 3f20000 -- 68 % complete flash_erase:  Cleanmarker written at 3f20000

Erasing 128 Kibyte @ 3f40000 -- 68 % complete flash_erase:  Cleanmarker written at 3f40000

Erasing 128 Kibyte @ 3f60000 -- 68 % complete flash_erase:  Cleanmarker written at 3f60000

Erasing 128 Kibyte @ 3f80000 -- 69 % complete flash_erase:  Cleanmarker written at 3f80000

Erasing 128 Kibyte @ 3fa0000 -- 69 % complete flash_erase:  Cleanmarker written at 3fa0000

Erasing 128 Kibyte @ 3fc0000 -- 69 % complete flash_erase:  Cleanmarker written at 3fc0000

Erasing 128 Kibyte @ 3fe0000 -- 69 % complete flash_erase:  Cleanmarker written at 3fe0000

Erasing 128 Kibyte @ 4000000 -- 69 % complete flash_erase:  Cleanmarker written at 4000000

Erasing 128 Kibyte @ 4020000 -- 69 % complete flash_erase:  Cleanmarker written at 4020000

Erasing 128 Kibyte @ 4040000 -- 69 % complete flash_erase:  Cleanmarker written at 4040000

Erasing 128 Kibyte @ 4060000 -- 69 % complete flash_erase:  Cleanmarker written at 4060000

Erasing 128 Kibyte @ 4080000 -- 70 % complete flash_erase:  Cleanmarker written at 4080000

Erasing 128 Kibyte @ 40a0000 -- 70 % complete flash_erase:  Cleanmarker written at 40a0000

Erasing 128 Kibyte @ 40c0000 -- 70 % complete flash_erase:  Cleanmarker written at 40c0000

Erasing 128 Kibyte @ 40e0000 -- 70 % complete flash_erase:  Cleanmarker written at 40e0000

Erasing 128 Kibyte @ 4100000 -- 70 % complete flash_erase:  Cleanmarker written at 4100000

Erasing 128 Kibyte @ 4120000 -- 70 % complete flash_erase:  Cleanmarker written at 4120000

Erasing 128 Kibyte @ 4140000 -- 70 % complete flash_erase:  Cleanmarker written at 4140000

Erasing 128 Kibyte @ 4160000 -- 71 % complete flash_erase:  Cleanmarker written at 4160000

Erasing 128 Kibyte @ 4180000 -- 71 % complete flash_erase:  Cleanmarker written at 4180000

Erasing 128 Kibyte @ 41a0000 -- 71 % complete flash_erase:  Cleanmarker written at 41a0000

Erasing 128 Kibyte @ 41c0000 -- 71 % complete flash_erase:  Cleanmarker written at 41c0000

Erasing 128 Kibyte @ 41e0000 -- 71 % complete flash_erase:  Cleanmarker written at 41e0000

Erasing 128 Kibyte @ 4200000 -- 71 % complete flash_erase:  Cleanmarker written at 4200000

Erasing 128 Kibyte @ 4220000 -- 71 % complete flash_erase:  Cleanmarker written at 4220000

Erasing 128 Kibyte @ 4240000 -- 72 % complete flash_erase:  Cleanmarker written at 4240000

Erasing 128 Kibyte @ 4260000 -- 72 % complete flash_erase:  Cleanmarker written at 4260000

Erasing 128 Kibyte @ 4280000 -- 72 % complete flash_erase:  Cleanmarker written at 4280000

Erasing 128 Kibyte @ 42a0000 -- 72 % complete flash_erase:  Cleanmarker written at 42a0000

Erasing 128 Kibyte @ 42c0000 -- 72 % complete flash_erase:  Cleanmarker written at 42c0000

Erasing 128 Kibyte @ 42e0000 -- 72 % complete flash_erase:  Cleanmarker written at 42e0000

Erasing 128 Kibyte @ 4300000 -- 72 % complete flash_erase:  Cleanmarker written at 4300000

Erasing 128 Kibyte @ 4320000 -- 72 % complete flash_erase:  Cleanmarker written at 4320000

Erasing 128 Kibyte @ 4340000 -- 73 % complete flash_erase:  Cleanmarker written at 4340000

Erasing 128 Kibyte @ 4360000 -- 73 % complete flash_erase:  Cleanmarker written at 4360000

Erasing 128 Kibyte @ 4380000 -- 73 % complete flash_erase:  Cleanmarker written at 4380000

Erasing 128 Kibyte @ 43a0000 -- 73 % complete flash_erase:  Cleanmarker written at 43a0000

Erasing 128 Kibyte @ 43c0000 -- 73 % complete flash_erase:  Cleanmarker written at 43c0000

Erasing 128 Kibyte @ 43e0000 -- 73 % complete flash_erase:  Cleanmarker written at 43e0000

Erasing 128 Kibyte @ 4400000 -- 73 % complete flash_erase:  Cleanmarker written at 4400000

Erasing 128 Kibyte @ 4420000 -- 74 % complete flash_erase:  Cleanmarker written at 4420000

Erasing 128 Kibyte @ 4440000 -- 74 % complete flash_erase:  Cleanmarker written at 4440000

Erasing 128 Kibyte @ 4460000 -- 74 % complete flash_erase:  Cleanmarker written at 4460000

Erasing 128 Kibyte @ 4480000 -- 74 % complete flash_erase:  Cleanmarker written at 4480000

Erasing 128 Kibyte @ 44a0000 -- 74 % complete flash_erase:  Cleanmarker written at 44a0000

Erasing 128 Kibyte @ 44c0000 -- 74 % complete flash_erase:  Cleanmarker written at 44c0000

Erasing 128 Kibyte @ 44e0000 -- 74 % complete flash_erase:  Cleanmarker written at 44e0000

Erasing 128 Kibyte @ 4500000 -- 75 % complete flash_erase:  Cleanmarker written at 4500000

Erasing 128 Kibyte @ 4520000 -- 75 % complete flash_erase:  Cleanmarker written at 4520000

Erasing 128 Kibyte @ 4540000 -- 75 % complete flash_erase:  Cleanmarker written at 4540000

Erasing 128 Kibyte @ 4560000 -- 75 % complete flash_erase:  Cleanmarker written at 4560000

Erasing 128 Kibyte @ 4580000 -- 75 % complete flash_erase:  Cleanmarker written at 4580000

Erasing 128 Kibyte @ 45a0000 -- 75 % complete flash_erase:  Cleanmarker written at 45a0000

Erasing 128 Kibyte @ 45c0000 -- 75 % complete flash_erase:  Cleanmarker written at 45c0000

Erasing 128 Kibyte @ 45e0000 -- 75 % complete flash_erase:  Cleanmarker written at 45e0000

Erasing 128 Kibyte @ 4600000 -- 76 % complete flash_erase:  Cleanmarker written at 4600000

Erasing 128 Kibyte @ 4620000 -- 76 % complete flash_erase:  Cleanmarker written at 4620000

Erasing 128 Kibyte @ 4640000 -- 76 % complete flash_erase:  Cleanmarker written at 4640000

Erasing 128 Kibyte @ 4660000 -- 76 % complete flash_erase:  Cleanmarker written at 4660000

Erasing 128 Kibyte @ 4680000 -- 76 % complete flash_erase:  Cleanmarker written at 4680000

Erasing 128 Kibyte @ 46a0000 -- 76 % complete flash_erase:  Cleanmarker written at 46a0000

Erasing 128 Kibyte @ 46c0000 -- 76 % complete flash_erase:  Cleanmarker written at 46c0000

Erasing 128 Kibyte @ 46e0000 -- 77 % complete flash_erase:  Cleanmarker written at 46e0000

Erasing 128 Kibyte @ 4700000 -- 77 % complete flash_erase:  Cleanmarker written at 4700000

Erasing 128 Kibyte @ 4720000 -- 77 % complete flash_erase:  Cleanmarker written at 4720000

Erasing 128 Kibyte @ 4740000 -- 77 % complete flash_erase:  Cleanmarker written at 4740000

Erasing 128 Kibyte @ 4760000 -- 77 % complete flash_erase:  Cleanmarker written at 4760000

Erasing 128 Kibyte @ 4780000 -- 77 % complete flash_erase:  Cleanmarker written at 4780000

Erasing 128 Kibyte @ 47a0000 -- 77 % complete flash_erase:  Cleanmarker written at 47a0000

Erasing 128 Kibyte @ 47c0000 -- 77 % complete flash_erase:  Cleanmarker written at 47c0000

Erasing 128 Kibyte @ 47e0000 -- 78 % complete flash_erase:  Cleanmarker written at 47e0000

Erasing 128 Kibyte @ 4800000 -- 78 % complete flash_erase:  Cleanmarker written at 4800000

Erasing 128 Kibyte @ 4820000 -- 78 % complete flash_erase:  Cleanmarker written at 4820000

Erasing 128 Kibyte @ 4840000 -- 78 % complete flash_erase:  Cleanmarker written at 4840000

Erasing 128 Kibyte @ 4860000 -- 78 % complete flash_erase:  Cleanmarker written at 4860000

Erasing 128 Kibyte @ 4880000 -- 78 % complete flash_erase:  Cleanmarker written at 4880000

Erasing 128 Kibyte @ 48a0000 -- 78 % complete flash_erase:  Cleanmarker written at 48a0000

Erasing 128 Kibyte @ 48c0000 -- 79 % complete flash_erase:  Cleanmarker written at 48c0000

Erasing 128 Kibyte @ 48e0000 -- 79 % complete flash_erase:  Cleanmarker written at 48e0000

Erasing 128 Kibyte @ 4900000 -- 79 % complete flash_erase:  Cleanmarker written at 4900000

Erasing 128 Kibyte @ 4920000 -- 79 % complete flash_erase:  Cleanmarker written at 4920000

Erasing 128 Kibyte @ 4940000 -- 79 % complete flash_erase:  Cleanmarker written at 4940000

Erasing 128 Kibyte @ 4960000 -- 79 % complete flash_erase:  Cleanmarker written at 4960000

Erasing 128 Kibyte @ 4980000 -- 79 % complete flash_erase:  Cleanmarker written at 4980000

Erasing 128 Kibyte @ 49a0000 -- 80 % complete flash_erase:  Cleanmarker written at 49a0000

Erasing 128 Kibyte @ 49c0000 -- 80 % complete flash_erase:  Cleanmarker written at 49c0000

Erasing 128 Kibyte @ 49e0000 -- 80 % complete flash_erase:  Cleanmarker written at 49e0000

Erasing 128 Kibyte @ 4a00000 -- 80 % complete flash_erase:  Cleanmarker written at 4a00000

Erasing 128 Kibyte @ 4a20000 -- 80 % complete flash_erase:  Cleanmarker written at 4a20000

Erasing 128 Kibyte @ 4a40000 -- 80 % complete flash_erase:  Cleanmarker written at 4a40000

Erasing 128 Kibyte @ 4a60000 -- 80 % complete flash_erase:  Cleanmarker written at 4a60000

Erasing 128 Kibyte @ 4a80000 -- 80 % complete flash_erase:  Cleanmarker written at 4a80000

Erasing 128 Kibyte @ 4aa0000 -- 81 % complete flash_erase:  Cleanmarker written at 4aa0000

Erasing 128 Kibyte @ 4ac0000 -- 81 % complete flash_erase:  Cleanmarker written at 4ac0000

Erasing 128 Kibyte @ 4ae0000 -- 81 % complete flash_erase:  Cleanmarker written at 4ae0000

Erasing 128 Kibyte @ 4b00000 -- 81 % complete flash_erase:  Cleanmarker written at 4b00000

Erasing 128 Kibyte @ 4b20000 -- 81 % complete flash_erase:  Cleanmarker written at 4b20000

Erasing 128 Kibyte @ 4b40000 -- 81 % complete flash_erase:  Cleanmarker written at 4b40000

Erasing 128 Kibyte @ 4b60000 -- 81 % complete flash_erase:  Cleanmarker written at 4b60000

Erasing 128 Kibyte @ 4b80000 -- 82 % complete flash_erase:  Cleanmarker written at 4b80000

Erasing 128 Kibyte @ 4ba0000 -- 82 % complete flash_erase:  Cleanmarker written at 4ba0000

Erasing 128 Kibyte @ 4bc0000 -- 82 % complete flash_erase:  Cleanmarker written at 4bc0000

Erasing 128 Kibyte @ 4be0000 -- 82 % complete flash_erase:  Cleanmarker written at 4be0000

Erasing 128 Kibyte @ 4c00000 -- 82 % complete flash_erase:  Cleanmarker written at 4c00000

Erasing 128 Kibyte @ 4c20000 -- 82 % complete flash_erase:  Cleanmarker written at 4c20000

Erasing 128 Kibyte @ 4c40000 -- 82 % complete flash_erase:  Cleanmarker written at 4c40000

Erasing 128 Kibyte @ 4c60000 -- 83 % complete flash_erase:  Cleanmarker written at 4c60000

Erasing 128 Kibyte @ 4c80000 -- 83 % complete flash_erase:  Cleanmarker written at 4c80000

Erasing 128 Kibyte @ 4ca0000 -- 83 % complete flash_erase:  Cleanmarker written at 4ca0000

Erasing 128 Kibyte @ 4cc0000 -- 83 % complete flash_erase:  Cleanmarker written at 4cc0000

Erasing 128 Kibyte @ 4ce0000 -- 83 % complete flash_erase:  Cleanmarker written at 4ce0000

Erasing 128 Kibyte @ 4d00000 -- 83 % complete flash_erase:  Cleanmarker written at 4d00000

Erasing 128 Kibyte @ 4d20000 -- 83 % complete flash_erase:  Cleanmarker written at 4d20000

Erasing 128 Kibyte @ 4d40000 -- 83 % complete flash_erase:  Cleanmarker written at 4d40000

Erasing 128 Kibyte @ 4d60000 -- 84 % complete flash_erase:  Cleanmarker written at 4d60000

Erasing 128 Kibyte @ 4d80000 -- 84 % complete flash_erase:  Cleanmarker written at 4d80000

Erasing 128 Kibyte @ 4da0000 -- 84 % complete flash_erase:  Cleanmarker written at 4da0000

Erasing 128 Kibyte @ 4dc0000 -- 84 % complete flash_erase:  Cleanmarker written at 4dc0000

Erasing 128 Kibyte @ 4de0000 -- 84 % complete flash_erase:  Cleanmarker written at 4de0000

Erasing 128 Kibyte @ 4e00000 -- 84 % complete flash_erase:  Cleanmarker written at 4e00000

Erasing 128 Kibyte @ 4e20000 -- 84 % complete flash_erase:  Cleanmarker written at 4e20000

Erasing 128 Kibyte @ 4e40000 -- 85 % complete flash_erase:  Cleanmarker written at 4e40000

Erasing 128 Kibyte @ 4e60000 -- 85 % complete flash_erase:  Cleanmarker written at 4e60000

Erasing 128 Kibyte @ 4e80000 -- 85 % complete flash_erase:  Cleanmarker written at 4e80000

Erasing 128 Kibyte @ 4ea0000 -- 85 % complete flash_erase:  Cleanmarker written at 4ea0000

Erasing 128 Kibyte @ 4ec0000 -- 85 % complete flash_erase:  Cleanmarker written at 4ec0000

Erasing 128 Kibyte @ 4ee0000 -- 85 % complete flash_erase:  Cleanmarker written at 4ee0000

Erasing 128 Kibyte @ 4f00000 -- 85 % complete flash_erase:  Cleanmarker written at 4f00000

Erasing 128 Kibyte @ 4f20000 -- 86 % complete flash_erase:  Cleanmarker written at 4f20000

Erasing 128 Kibyte @ 4f40000 -- 86 % complete flash_erase:  Cleanmarker written at 4f40000

Erasing 128 Kibyte @ 4f60000 -- 86 % complete flash_erase:  Cleanmarker written at 4f60000

Erasing 128 Kibyte @ 4f80000 -- 86 % complete flash_erase:  Cleanmarker written at 4f80000

Erasing 128 Kibyte @ 4fa0000 -- 86 % complete flash_erase:  Cleanmarker written at 4fa0000

Erasing 128 Kibyte @ 4fc0000 -- 86 % complete flash_erase:  Cleanmarker written at 4fc0000

Erasing 128 Kibyte @ 4fe0000 -- 86 % complete flash_erase:  Cleanmarker written at 4fe0000

Erasing 128 Kibyte @ 5000000 -- 86 % complete flash_erase:  Cleanmarker written at 5000000

Erasing 128 Kibyte @ 5020000 -- 87 % complete flash_erase:  Cleanmarker written at 5020000

Erasing 128 Kibyte @ 5040000 -- 87 % complete flash_erase:  Cleanmarker written at 5040000

Erasing 128 Kibyte @ 5060000 -- 87 % complete flash_erase:  Cleanmarker written at 5060000

Erasing 128 Kibyte @ 5080000 -- 87 % complete flash_erase:  Cleanmarker written at 5080000

Erasing 128 Kibyte @ 50a0000 -- 87 % complete flash_erase:  Cleanmarker written at 50a0000

Erasing 128 Kibyte @ 50c0000 -- 87 % complete flash_erase:  Cleanmarker written at 50c0000

Erasing 128 Kibyte @ 50e0000 -- 87 % complete flash_erase:  Cleanmarker written at 50e0000

Erasing 128 Kibyte @ 5100000 -- 88 % complete flash_erase:  Cleanmarker written at 5100000

Erasing 128 Kibyte @ 5120000 -- 88 % complete flash_erase:  Cleanmarker written at 5120000

Erasing 128 Kibyte @ 5140000 -- 88 % complete flash_erase:  Cleanmarker written at 5140000

Erasing 128 Kibyte @ 5160000 -- 88 % complete flash_erase:  Cleanmarker written at 5160000

Erasing 128 Kibyte @ 5180000 -- 88 % complete flash_erase:  Cleanmarker written at 5180000

Erasing 128 Kibyte @ 51a0000 -- 88 % complete flash_erase:  Cleanmarker written at 51a0000

Erasing 128 Kibyte @ 51c0000 -- 88 % complete flash_erase:  Cleanmarker written at 51c0000

Erasing 128 Kibyte @ 51e0000 -- 88 % complete flash_erase:  Cleanmarker written at 51e0000

Erasing 128 Kibyte @ 5200000 -- 89 % complete flash_erase:  Cleanmarker written at 5200000

Erasing 128 Kibyte @ 5220000 -- 89 % complete flash_erase:  Cleanmarker written at 5220000

Erasing 128 Kibyte @ 5240000 -- 89 % complete flash_erase:  Cleanmarker written at 5240000

Erasing 128 Kibyte @ 5260000 -- 89 % complete flash_erase:  Cleanmarker written at 5260000

Erasing 128 Kibyte @ 5280000 -- 89 % complete flash_erase:  Cleanmarker written at 5280000

Erasing 128 Kibyte @ 52a0000 -- 89 % complete flash_erase:  Cleanmarker written at 52a0000

Erasing 128 Kibyte @ 52c0000 -- 89 % complete flash_erase:  Cleanmarker written at 52c0000

Erasing 128 Kibyte @ 52e0000 -- 90 % complete flash_erase:  Cleanmarker written at 52e0000

Erasing 128 Kibyte @ 5300000 -- 90 % complete flash_erase:  Cleanmarker written at 5300000

Erasing 128 Kibyte @ 5320000 -- 90 % complete flash_erase:  Cleanmarker written at 5320000

Erasing 128 Kibyte @ 5340000 -- 90 % complete flash_erase:  Cleanmarker written at 5340000

Erasing 128 Kibyte @ 5360000 -- 90 % complete flash_erase:  Cleanmarker written at 5360000

Erasing 128 Kibyte @ 5380000 -- 90 % complete flash_erase:  Cleanmarker written at 5380000

Erasing 128 Kibyte @ 53a0000 -- 90 % complete flash_erase:  Cleanmarker written at 53a0000

Erasing 128 Kibyte @ 53c0000 -- 91 % complete flash_erase:  Cleanmarker written at 53c0000

Erasing 128 Kibyte @ 53e0000 -- 91 % complete flash_erase:  Cleanmarker written at 53e0000

Erasing 128 Kibyte @ 5400000 -- 91 % complete flash_erase:  Cleanmarker written at 5400000

Erasing 128 Kibyte @ 5420000 -- 91 % complete flash_erase:  Cleanmarker written at 5420000

Erasing 128 Kibyte @ 5440000 -- 91 % complete flash_erase:  Cleanmarker written at 5440000

Erasing 128 Kibyte @ 5460000 -- 91 % complete flash_erase:  Cleanmarker written at 5460000

Erasing 128 Kibyte @ 5480000 -- 91 % complete flash_erase:  Cleanmarker written at 5480000

Erasing 128 Kibyte @ 54a0000 -- 91 % complete flash_erase:  Cleanmarker written at 54a0000

Erasing 128 Kibyte @ 54c0000 -- 92 % complete flash_erase:  Cleanmarker written at 54c0000

Erasing 128 Kibyte @ 54e0000 -- 92 % complete flash_erase:  Cleanmarker written at 54e0000

Erasing 128 Kibyte @ 5500000 -- 92 % complete flash_erase:  Cleanmarker written at 5500000

Erasing 128 Kibyte @ 5520000 -- 92 % complete flash_erase:  Cleanmarker written at 5520000

Erasing 128 Kibyte @ 5540000 -- 92 % complete flash_erase:  Cleanmarker written at 5540000

Erasing 128 Kibyte @ 5560000 -- 92 % complete flash_erase:  Cleanmarker written at 5560000

Erasing 128 Kibyte @ 5580000 -- 92 % complete flash_erase:  Cleanmarker written at 5580000

Erasing 128 Kibyte @ 55a0000 -- 93 % complete flash_erase:  Cleanmarker written at 55a0000

Erasing 128 Kibyte @ 55c0000 -- 93 % complete flash_erase:  Cleanmarker written at 55c0000

Erasing 128 Kibyte @ 55e0000 -- 93 % complete flash_erase:  Cleanmarker written at 55e0000

Erasing 128 Kibyte @ 5600000 -- 93 % complete flash_erase:  Cleanmarker written at 5600000

Erasing 128 Kibyte @ 5620000 -- 93 % complete flash_erase:  Cleanmarker written at 5620000

Erasing 128 Kibyte @ 5640000 -- 93 % complete flash_erase:  Cleanmarker written at 5640000

Erasing 128 Kibyte @ 5660000 -- 93 % complete flash_erase:  Cleanmarker written at 5660000

Erasing 128 Kibyte @ 5680000 -- 94 % complete flash_erase:  Cleanmarker written at 5680000

Erasing 128 Kibyte @ 56a0000 -- 94 % complete flash_erase:  Cleanmarker written at 56a0000

Erasing 128 Kibyte @ 56c0000 -- 94 % complete flash_erase:  Cleanmarker written at 56c0000

Erasing 128 Kibyte @ 56e0000 -- 94 % complete flash_erase:  Cleanmarker written at 56e0000

Erasing 128 Kibyte @ 5700000 -- 94 % complete flash_erase:  Cleanmarker written at 5700000

Erasing 128 Kibyte @ 5720000 -- 94 % complete flash_erase:  Cleanmarker written at 5720000

Erasing 128 Kibyte @ 5740000 -- 94 % complete flash_erase:  Cleanmarker written at 5740000

Erasing 128 Kibyte @ 5760000 -- 94 % complete flash_erase:  Cleanmarker written at 5760000

Erasing 128 Kibyte @ 5780000 -- 95 % complete flash_erase:  Cleanmarker written at 5780000

Erasing 128 Kibyte @ 57a0000 -- 95 % complete flash_erase:  Cleanmarker written at 57a0000

Erasing 128 Kibyte @ 57c0000 -- 95 % complete flash_erase:  Cleanmarker written at 57c0000

Erasing 128 Kibyte @ 57e0000 -- 95 % complete flash_erase:  Cleanmarker written at 57e0000

Erasing 128 Kibyte @ 5800000 -- 95 % complete flash_erase:  Cleanmarker written at 5800000

Erasing 128 Kibyte @ 5820000 -- 95 % complete flash_erase:  Cleanmarker written at 5820000

Erasing 128 Kibyte @ 5840000 -- 95 % complete flash_erase:  Cleanmarker written at 5840000

Erasing 128 Kibyte @ 5860000 -- 96 % complete flash_erase:  Cleanmarker written at 5860000

Erasing 128 Kibyte @ 5880000 -- 96 % complete flash_erase:  Cleanmarker written at 5880000

Erasing 128 Kibyte @ 58a0000 -- 96 % complete flash_erase:  Cleanmarker written at 58a0000

Erasing 128 Kibyte @ 58c0000 -- 96 % complete flash_erase:  Cleanmarker written at 58c0000

Erasing 128 Kibyte @ 58e0000 -- 96 % complete flash_erase:  Cleanmarker written at 58e0000

Erasing 128 Kibyte @ 5900000 -- 96 % complete flash_erase:  Cleanmarker written at 5900000

Erasing 128 Kibyte @ 5920000 -- 96 % complete flash_erase:  Cleanmarker written at 5920000

Erasing 128 Kibyte @ 5940000 -- 97 % complete flash_erase:  Cleanmarker written at 5940000

Erasing 128 Kibyte @ 5960000 -- 97 % complete flash_erase:  Cleanmarker written at 5960000

Erasing 128 Kibyte @ 5980000 -- 97 % complete flash_erase:  Cleanmarker written at 5980000

Erasing 128 Kibyte @ 59a0000 -- 97 % complete flash_erase:  Cleanmarker written at 59a0000

Erasing 128 Kibyte @ 59c0000 -- 97 % complete flash_erase:  Cleanmarker written at 59c0000

Erasing 128 Kibyte @ 59e0000 -- 97 % complete flash_erase:  Cleanmarker written at 59e0000

Erasing 128 Kibyte @ 5a00000 -- 97 % complete flash_erase:  Cleanmarker written at 5a00000

Erasing 128 Kibyte @ 5a20000 -- 97 % complete flash_erase:  Cleanmarker written at 5a20000

Erasing 128 Kibyte @ 5a40000 -- 98 % complete flash_erase:  Cleanmarker written at 5a40000

Erasing 128 Kibyte @ 5a60000 -- 98 % complete flash_erase:  Cleanmarker written at 5a60000

Erasing 128 Kibyte @ 5a80000 -- 98 % complete flash_erase:  Cleanmarker written at 5a80000

Erasing 128 Kibyte @ 5aa0000 -- 98 % complete flash_erase:  Cleanmarker written at 5aa0000

Erasing 128 Kibyte @ 5ac0000 -- 98 % complete flash_erase:  Cleanmarker written at 5ac0000

Erasing 128 Kibyte @ 5ae0000 -- 98 % complete flash_erase:  Cleanmarker written at 5ae0000

Erasing 128 Kibyte @ 5b00000 -- 98 % complete flash_erase:  Cleanmarker written at 5b00000

Erasing 128 Kibyte @ 5b20000 -- 99 % complete flash_erase:  Cleanmarker written at 5b20000

Erasing 128 Kibyte @ 5b40000 -- 99 % complete flash_erase:  Cleanmarker written at 5b40000

Erasing 128 Kibyte @ 5b60000 -- 99 % complete flash_erase:  Cleanmarker written at 5b60000

Erasing 128 Kibyte @ 5b80000 -- 99 % complete flash_erase:  Cleanmarker written at 5b80000

Erasing 128 Kibyte @ 5ba0000 -- 99 % complete flash_erase:  Cleanmarker written at 5ba0000

Erasing 128 Kibyte @ 5bc0000 -- 99 % complete flash_erase:  Cleanmarker written at 5bc0000

Erasing 128 Kibyte @ 5be0000 -- 99 % complete flash_erase:  Cleanmarker written at 5be0000

Erasing 128 Kibyte @ 5be0000 -- 100 % complete
sh-4.2# mount -t jffs2 mtd3 /mnt
sh-4.2# umount /mnt
[   77.778000] Unhandled kernel unaligned access[#1]:
[   77.778000] Cpu 0
[   77.778000] $ 0   : 0000000000000000 fffffffffffffffe 0000000000000000 0000000000000000
[   77.778000] $ 4   : a800000043c93c80 a933ffffff411b48 ffffffff8014d3f8 a933ffffff411b48
[   77.778000] $ 8   : fffffffffffffffe ffffffffffffffff 0000000000000001 0000000000000000
[   77.778000] $12   : 000000001000c0e1 000000001000001e 0000000000000000 0000000000000000
[   77.778000] $16   : a800000043c93c80 a933ffffff411b48 ffffffffdc420000 ffffffff8050f960
[   77.778000] $20   : ffffffff80502f28 ffffffff80500000 ffffffff80500000 0000000000000001
[   77.778000] $24   : 0000000000000000 ffffffff8015b6b8
[   77.778000] $28   : a800000043c90000 a800000043c939c0 0000000000000001 ffffffff80109a1c
[   77.778000] Hi    : 0000000000000000
[   77.778000] Lo    : 0000000000000000
[   77.778000] epc   : ffffffff80109830 emulate_load_store_insn+0x340/0x468
[   77.778000]     Not tainted
[   77.778000] ra    : ffffffff80109a1c do_ade+0xc4/0x168
[   77.778000] Status: 1000c0e3    KX SX UX KERNEL EXL IE
[   77.778000] Cause : 00800010
[   77.778000] BadVA : a933ffffff411b48
[   77.778000] PrId  : 000cce01 (Netlogic XLS)
[   77.778000] Modules linked in:
[   77.778000] Process bdi-default (pid: 12, threadinfo=a800000043c90000, task=a800000043c350c8, tls=0000000000000000)
[   77.778000] Stack : 0000000000000000 0000000000000000 0000000000000000 0000000000000000
        0000000000000000 0000000000000000 0000000000000000 0000000000000000
        0000000000000000 0000000000000000 0000000000000000 0000000000000000
        0000000000000000 0000000000000000 0000000000000000 0000000000000000
        0000000000000000 0000000000000000 0000000000000000 0000000000000000
        0000000000000000 0000000000000000 0000000000000000 0000000000000000
        a800000043c35100 a800000043c30790 ffffffff804fb5f0 a800000043c307a0
        ffffffff80500000 ffffffff8015b238 ffffffff804fb580 a800000043c350c8
        a800000043c350c8 ffffffff804fb580 a800000043c30758 ffffffff804320f8
        0000000000000000 0000000000000000 0000000000000000 a800000043c93c80
        ...
[   77.778000] Call Trace:
[   77.778000] [<ffffffff80109830>] emulate_load_store_insn+0x340/0x468
[   77.778000] [<ffffffff80109a1c>] do_ade+0xc4/0x168
[   77.778000] [<ffffffff801036a0>] ret_from_exception+0x0/0x20
[   77.778000] [<ffffffff8014d3f8>] bit_waitqueue+0x28/0xb0
[   77.778000] [<ffffffff8014d4d0>] wake_up_bit+0x18/0x38
[   77.778000] [<ffffffff801b54f4>] bdi_forker_thread+0x27c/0x3b8
[   77.778000] [<ffffffff8014cda8>] kthread+0x90/0x98
[   77.778000] [<ffffffff80105450>] kernel_thread_helper+0x10/0x18
[   77.778000]
[   77.778000]
Code: 00431024  1440ff5d  00000000 <6a330000> 6e330007  24110000  1620ff94  00000000  08042580
[   78.528000] ---[ end trace 6cfe7eb411516337 ]---
sh-4.2# reboot
sh-4.2# umount: devtmpfs busy - remounted read-only
umount: can't remount rootfs read-only

The system is going down NOW!
