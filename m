Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 23 Feb 2005 11:22:49 +0000 (GMT)
Received: from no-dns-yet.demon.co.uk ([IPv6:::ffff:83.104.11.251]:44956 "EHLO
	exterity.co.uk") by linux-mips.org with ESMTP id <S8225352AbVBWLW1>;
	Wed, 23 Feb 2005 11:22:27 +0000
Received: from [192.168.0.85] ([192.168.0.85]) by exterity.co.uk with Microsoft SMTPSVC(6.0.3790.211);
	 Wed, 23 Feb 2005 11:23:40 +0000
Subject: Big Endian au1550
From:	JP Foster <jp.foster@exterity.co.uk>
To:	linux-mips@linux-mips.org
Content-Type: text/plain
Date:	Wed, 23 Feb 2005 11:22:16 +0000
Message-Id: <1109157737.16445.6.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.1.5 
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 23 Feb 2005 11:23:40.0828 (UTC) FILETIME=[2058DDC0:01C5199A]
Return-Path: <jpfoster@exterity.co.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7317
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jp.foster@exterity.co.uk
Precedence: bulk
X-list: linux-mips

Hi all,
In the linux-mips cvs big endian operation of the au1550 is not
selectable. Is there a reason for this?
what would I need to do to get big endian support?

The chip does run big endian, as I have yamon running on it here.
And a previously the linux-mips kernel allowed this.
The kernel will compile big end but I get an oops as the kernel
starts up 

Thanks
JP


VFS: Disk quotas dquot_6.5.1
Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
Break instruction in kernel code in arch/mips/kernel/traps.c::do_bp,
line 557[#1]:
Cpu 0
$ 0   : 00000000 1000fc00 00000000 10000000
$ 4   : 00000001 00000001 fffb6ccf 00000000
$ 8   : 10000000 00000008 803c0000 00100100
$12   : 811c5edd fffffffa ffffffff 0000000a
$16   : 1000fc01 803e7bc0 803c0000 80380000
$20   : 803d0000 80380000 803d0000 00000000
$24   : 00000008 811c5df9
$28   : 811c4000 811c5e40 811c5e40 80103900
Hi    : 00000000
Lo    : 00000000
epc   : 8033f818 preempt_schedule_irq+0xcc/0xd8     Not tainted
ra    : 80103900 ret_from_fork+0x0/0x8
Status: 1000fc02    KERNEL EXL
Cause : 00800024
PrId  : 03030200
Modules linked in:
Process swapper (pid: 1, threadinfo=811c4000, task=803e7bc0)
Stack : 803fbbf4 803fbbe0 1000fc01 8012f7b8 1000fc01 80379420 803c0000
00000000
        80103900 80100c00 811c5ed8 00000000 00000000 80247490 803fbb80
813b396c
        00000000 1000fc00 00000001 811c4008 00000001 00000001 803c0028
0000000b
        002d4cae 801fc8ec 00000018 00100100 811c5edd fffffffa ffffffff
0000000a
        1000fc01 80379420 803c0000 80380000 803d0000 80380000 803d0000
00000000
        ...
Call Trace:
 [<8012f7b8>] irq_exit+0x4c/0x5c
 [<80103900>] ret_from_fork+0x0/0x8
 [<80100c00>] au1000_IRQ+0x120/0x1a0
 [<80247490>] class_device_create_file+0x20/0x34
 [<801fc8ec>] memset_partial+0x30/0x6c
 [<8012f9c8>] __tasklet_schedule+0xb8/0xec
 [<8012f9e0>] __tasklet_schedule+0xd0/0xec
 [<803b3ffc>] kbd_init+0x184/0x22c
 [<80210480>] alloc_tty_driver+0x24/0x64
 [<80247fc4>] class_simple_device_add+0xe0/0x178
 [<803b4484>] vty_init+0xf8/0x128
 [<803b3784>] tty_init+0x1d0/0x1fc
 [<803b3428>] rand_initialize+0x128/0x1f0
 [<803b33f0>] rand_initialize+0xf0/0x1f0
 [<803b1c50>] init_iso9660_fs+0x60/0x9c
 [<80100508>] init+0x9c/0x274
 [<8010541c>] kernel_thread_helper+0x10/0x18
 [<8010540c>] kernel_thread_helper+0x0/0x18
