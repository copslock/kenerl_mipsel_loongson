Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 12 Nov 2010 19:46:58 +0100 (CET)
Received: from mxout1.idt.com ([157.165.5.25]:40499 "EHLO mxout1.idt.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1492152Ab0KLSqy convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 12 Nov 2010 19:46:54 +0100
Received: from mail.idt.com (localhost [127.0.0.1])
        by mxout1.idt.com (8.13.1/8.13.1) with ESMTP id oACIklvK005657
        for <linux-mips@linux-mips.org>; Fri, 12 Nov 2010 10:46:47 -0800
Received: from corpml1.corp.idt.com (corpml1.corp.idt.com [157.165.140.20])
        by mail.idt.com (8.13.8/8.13.8) with ESMTP id oACIkjmj003169
        for <linux-mips@linux-mips.org>; Fri, 12 Nov 2010 10:46:46 -0800 (PST)
Received: from CORPEXCH1.na.ads.idt.com (localhost [127.0.0.1])
        by corpml1.corp.idt.com (8.11.7p1+Sun/8.11.7) with ESMTP id oACIkjr22167
        for <linux-mips@linux-mips.org>; Fri, 12 Nov 2010 10:46:45 -0800 (PST)
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: Kernel crash when loading initramfs
Date:   Fri, 12 Nov 2010 10:46:42 -0800
Message-ID: <AEA634773855ED4CAD999FBB1A66D0760132C232@CORPEXCH1.na.ads.idt.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Kernel crash when loading initramfs
Thread-Index: AcuCmfLUb2iexdpqT2+/GkNIYZZQ3Q==
From:   "Ardelean, Andrei" <Andrei.Ardelean@idt.com>
To:     <linux-mips@linux-mips.org>
X-Scanned-By: MIMEDefang 2.43
Return-Path: <Andrei.Ardelean@idt.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 28362
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Andrei.Ardelean@idt.com
Precedence: bulk
X-list: linux-mips

Hi,

I am trying to bring-up MIPS Linux on our FPGA board with initramfs
inside the kernel (cpio) and I have the bellow messages.

Any idea/advice how to proceed?

Thanks,
Andrei


Linux version 2.6.29-ts-mipsisa32r2elup (aardelea@tor-aardelea-cos54)
(gcc versi
on 4.3.2 (GCC) ) #139 Fri Nov 12 10:25:30 EST 2010



LINUX started...

console [early0] enabled

CPU revision is: 00019750 (MIPS 74Kc)

FPU revision is: 01739700

Determined physical RAM map:

 memory: 00001000 @ 00000000 (reserved)

 memory: 000ef000 @ 00001000 (ROM data)

 memory: 00914000 @ 000f0000 (reserved)

 memory: 0f5fc000 @ 00a04000 (usable)

Wasting 82048 bytes for tracking 2564 unused pages

Initrd not found or empty - disabling initrd

Zone PFN ranges:

  Normal   0x00000000 -> 0x00010000

Movable zone start PFN for each node

early_node_map[1] active PFN ranges

    0: 0x00000000 -> 0x00010000

Built 1 zonelists in Zone order, mobility grouping on.  Total pages:
65024

Kernel command line: console=ttyS0,38400

Primary instruction cache 32kB, VIPT, 4-way, linesize 32 bytes.

Primary data cache 32kB, 4-way, VIPT, cache aliases, linesize 32 bytes

Writing ErrCtl register=00000000

Readback ErrCtl register=00000000

PID hash table entries: 1024 (order: 10, 4096 bytes)

CPU frequency 50.00 MHz

Console: colour dummy device 80x25

Dentry cache hash table entries: 32768 (order: 5, 131072 bytes)

Inode-cache hash table entries: 16384 (order: 4, 65536 bytes)

Memory: 249284k/251888k available (1644k kernel code, 2280k reserved,
461k data,
 7016k init, 0k highmem)

Calibrating delay loop... 1.35 BogoMIPS (lpj=6784)

Mount-cache hash table entries: 512

net_namespace: 296 bytes

NET: Registered protocol family 16

bio: create slab <bio-0> at 0

CPU 0 Unable to handle kernel paging request at virtual address
01108f84, epc ==
 8031382c, ra == 80313834

Oops[#1]:

Cpu 0

$ 0   : 00000000 00000000 00000001 0000000d

$ 4   : 01108f80 00000001 8f8010c0 000016a6

$ 8   : 0000000f 006b7649 809f0000 8f85fc90

$12   : 809f0000 006b7649 809f0000 8029d338

$16   : 01108f86 8f839000 00000081 809f0000

$20   : 809f0000 0000011e 0000001c 809f0000

$24   : 00000000 8f8616dc

$28   : 8f820000 8f821e38 809f0000 80313834

Hi    : 00000000

Lo    : 00000000

epc   : 8031382c huft_free+0x14/0x38

    Not tainted

ra    : 80313834 huft_free+0x1c/0x38

Status: 11008003    KERNEL EXL IE

Cause : 80000008

BadVA : 01108f84

PrId  : 00019750 (MIPS 74Kc)

Modules linked in:

Process swapper (pid: 1, threadinfo=8f820000, task=8f81fa18,
tls=00000000)

Stack : 809f0000 0000011e 0000001c 809f0000 00000000 803155e8 8f86e008
8f857408

        00000009 00000006 8029d418 8f85fc04 8f821e7c 00000000 8f86e008
8f857408

        00000009 00000006 809f0000 80186e58 00000000 006b7649 80331000
803163f8

        80330000 00000000 00000000 80330000 00000000 80316268 00000000
8012fbcc

        00000000 00000000 00000009 802f94c0 80300d40 8f802e80 00000000
80a02b70

        ...

Call Trace:

[<8031382c>] huft_free+0x14/0x38

[<803155e8>] inflate_dynamic+0x628/0x644

[<80316268>] unpack_to_rootfs+0xaa0/0xc30

[<80316428>] populate_rootfs+0x30/0x134

[<80107e44>] __kprobes_text_end+0x3c/0x1dc

[<8030f30c>] kernel_init+0xc0/0x130

[<80109868>] kernel_thread_helper+0x10/0x18





Code: 10800006  afb00010  2484fffa <0c0619a5> 8c900004  1600fffc
02002021  8fbf
0014  00001021

Kernel panic - not syncing: Attempted to kill init!
