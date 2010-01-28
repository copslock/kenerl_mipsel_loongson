Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 28 Jan 2010 16:53:44 +0100 (CET)
Received: from imr1.ericy.com ([198.24.6.9]:44123 "EHLO imr1.ericy.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1492378Ab0A1Pxk (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 28 Jan 2010 16:53:40 +0100
Received: from eusaamw0707.eamcs.ericsson.se ([147.117.20.32])
        by imr1.ericy.com (8.13.1/8.13.1) with ESMTP id o0SFsR6l018902
        for <linux-mips@linux-mips.org>; Thu, 28 Jan 2010 09:54:27 -0600
Received: from localhost (147.117.20.212) by eusaamw0707.eamcs.ericsson.se
 (147.117.20.92) with Microsoft SMTP Server id 8.1.375.2; Thu, 28 Jan 2010
 10:53:32 -0500
Date:   Thu, 28 Jan 2010 07:55:14 -0800
From:   Guenter Roeck <guenter.roeck@ericsson.com>
To:     linux-mips@linux-mips.org
Subject: Kernel crash in 2.6.32.6 / bcm1480 with 16k page size
Message-ID: <20100128155514.GA31611@ericsson.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
User-Agent: Mutt/1.5.18 (2008-05-17)
X-archive-position: 25720
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: guenter.roeck@ericsson.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                 
X-UID: 18273

Hi,

I get the following kernel crash when running a 2.6.32.6 kernel on a bcm1480 cpu.
It only happens if I configure a page size of 16k or 64k; 4k page size is fine.

A similar problem was recently fixed for ppc. It turned out to be a problem in ppc
specific memory management code, so that fix won't help here.

Has anyone else seen this before ? Any idea where to start looking for the problem ?

Thanks,
Guenter

--------------------------------------

[instrumentation]
pcpu_get_vm_areas: VMALLOC_START: 0xc000000000000000 VMALLOC_END: 0xc0007fff00000000 PTRS_PER_PGD: 2048 PTRS_PER_PMD: 2048 PTRS_PER_PTE: 2048 PAGE_SIZE: 0x4000
emulate_load_store_insn: Attempted access to supervisor address space: opcode=0x2c addr=0xc0007ffefffc0000
[/instrumentation]

Unhandled kernel unaligned access[#1]:
Cpu 2
$ 0   : 0000000000000000 0000000014001fe0 a8000002fe067b68 0000000000000000
$ 4   : ffffffff80116f10 0000000014001fe3 000000000000003f c0007ffefffc0000
$ 8   : ffffffff807e9998 a8000002fe716228 0000000000000000 fffffffffe000000
$12   : 0000000014001fe1 000000001000001e 6db6db6db6db6db7 0000000000000001
$16   : fffffffffc85ffc0 a8000002fe067b40 ffffffff80810000 0000000000000000
$20   : a8000002fe7161e0 ffffffff80810000 ffffffff80730000 ffffffff80810000
$24   : 0000000000000000 ffffffff8f1bbcdc
$28   : a8000002fe064000 a8000002fe067b10 a8000002fe2e53c0 ffffffff801004e0
Hi    : 000000000023d1ad
Lo    : 00000000000bf08f
epc   : ffffffff80116f38 do_ade+0x248/0x468
    Not tainted
ra    : ffffffff801004e0 ret_from_exception+0x0/0x20
Status: 14001fe3    KX SX UX KERNEL EXL IE
Cause : 00808014
BadVA : c0007ffefffc0000
PrId  : 05041100 (SiByte SB1A)
Modules linked in:
Process swapper (pid: 1, threadinfo=a8000002fe064000, task=a8000002fe063658, tls=0000000000000000)
Stack : 0000000000000100 0000000000000000 ffffffff807e9998 ffffffff80810000
        0000000000000000 ffffffff801004e0 0000000000000000 0000000014001fe0
        c0007ffefffc0000 a800000003a5c060 c0007ffefffc0040 0000000000000000
        0000000000001000 0000000000000000 ffffffff807e9998 a8000002fe716228
        0000000000000000 fffffffffe000000 0000000000000000 c0007ffefffc1000
        6db6db6db6db6db7 0000000000000001 0000000000000000 ffffffff807e9998
        ffffffff80810000 0000000000000000 a8000002fe7161e0 ffffffff80810000
        ffffffff80730000 ffffffff80810000 0000000000000000 ffffffff8f1bbcdc
        6db6db6db6db6db7 a8000002fe7161e0 a8000002fe064000 a8000002fe067c70
        a8000002fe2e53c0 ffffffff801f0d04 0000000014001fe3 000000000023d1ad
        ...
Call Trace:
[<ffffffff80116f38>] do_ade+0x248/0x468
[<ffffffff801004e0>] ret_from_exception+0x0/0x20
[<ffffffff8010585c>] __bzero+0x38/0x11c
[<ffffffff801f0d04>] pcpu_alloc+0x9b4/0xba0
[<ffffffff804b1460>] snmp_mib_init+0x40/0x80
[<ffffffff804fa6e8>] ipv6_add_dev+0x170/0x3c0
[<ffffffff80797178>] addrconf_init+0x44/0x17c
[<ffffffff8079705c>] inet6_init+0x29c/0x368
[<ffffffff8010fa88>] do_one_initcall+0x38/0x198
[<ffffffff80778350>] kernel_init+0x1ec/0x26c
[<ffffffff80112780>] kernel_thread_helper+0x10/0x18


Code: 000210f8  0222102d  dc430000 <b0e30000> b4e30007  24030000  1060ffe7  00000000  00000000
Disabling lock debugging due to kernel taint
Kernel panic - not syncing: Attempted to kill init!
Rebooting in 5 seconds..
