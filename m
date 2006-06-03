Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 03 Jun 2006 02:23:50 +0200 (CEST)
Received: from [220.76.242.187] ([220.76.242.187]:33666 "EHLO
	localhost.localdomain") by ftp.linux-mips.org with ESMTP
	id S8133809AbWFCAXk (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sat, 3 Jun 2006 02:23:40 +0200
Received: from mrv ([192.168.11.157])
	by localhost.localdomain (8.12.8/8.12.8) with SMTP id k530PZEE026645;
	Sat, 3 Jun 2006 09:25:41 +0900
Message-ID: <000101c686a3$a9764710$9d0ba8c0@mrv>
From:	"Roman Mashak" <mrv@corecom.co.kr>
To:	<linux-mips@linux-mips.org>
Cc:	"Raj Palani" <Rajesh_Palani@pmc-sierra.com>
References: <478F19F21671F04298A2116393EEC3D5274123@sjc1exm08.pmc_nt.nt.pmc-sierra.bc.ca>
Subject: Re: booting 64bit kernel on RM9150
Date:	Sat, 3 Jun 2006 09:21:29 +0900
MIME-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="koi8-r";
	reply-type=original
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.2869
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2869
FL-Build: Fidolook 2002 (SL) 6.0.2800.86 - 14/6/2003 22:16:25
Return-Path: <mrv@corecom.co.kr>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11654
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mrv@corecom.co.kr
Precedence: bulk
X-list: linux-mips

Hello, Raj!
You wrote to "Roman Mashak" <mrv@corecom.co.kr>; <linux-mips@linux-mips.org> 
on Fri, 2 Jun 2006 16:28:17 -0700 :

 RP>    The patch for 64-bit support for Sequoia would follow the patch for
 RP> the base support for Sequoia in the Linux/MIPS tree.
Are you saying the kernel 2.6.12-rc3_L002 located on ftp.pmc-sierra.com 
doesn't support 64bit properly? I used for experiments that kernel and 
default config file for 64bit support provided with the kernel. It boots up 
eventually and crashes:

TCP established hash table entries: 16384 (order: 5, 131072 bytes)
TCP bind hash table entries: 16384 (order: 5, 131072 bytes)
TCP: Hash tables configured (established 16384 bind 16384)
NET: Registered protocol family 1
CPU 0 Unable to handle kernel paging request at virtual address 
00000000ff048060, epc == ffffffff802332f8, ra == ffffffff80159eb4
Oops in arch/mips/mm/fault.c::do_page_fault, line 167[#1]:
Cpu 0
$ 0   : 0000000000000000 ffffffffff050000 ffffffff802332a8 00000000ff050000
$ 4   : 0000000000000005 980000000178c000 9800000001487d50 000000000000002c
$ 8   : 980000000178c000 9800000001461800 0000000000100000 000000000023fc00
$12   : 0000000000002000 0000000000000000 ffffffff9400a0e0 98000000003e8e00
$16   : 980000000178c000 0000000000000000 9800000001487d50 0000000000000000
$20   : ffffffff940080e0 0000000000000000 0000000000000000 0000000000000000
$24   : 98000000003e8e10 0000000000000001
$28   : 9800000001484000 9800000001487c90 0000000000000000 ffffffff80159eb4
Hi    : 000000000000348f
Lo    : 5c28f5c28fab0000
epc   : ffffffff802332f8 msp85x0_ge_sequoia_int_handler+0x50/0x2e0     Not 
tainted
ra    : ffffffff80159eb4 handle_IRQ_event+0x6c/0xe8
Status: 940080e2    KX SX UX KERNEL EXL
Cause : 00002008
BadVA : 00000000ff048060
PrId  : 000034c1
Modules linked in:
Process swapper (pid: 1, threadinfo=9800000001484000, task=98000000014816b8)
Stack : 980000000fddc940 0000000000000000 9800000001487d50 0000000000000005
        0000000000000001 0000000000000000 ffffffff80159eb4 0000000000000001
        ffffffff80345140 0000000000000005 980000000fddc940 9800000001487d50
        fffffffffffffffb 980000000178c000 ffffffff8015a094 ffffffff80107098
        ffffffff80345140 980000000fddc940 0000000000000005 ffffffff9400a0e1
        0000000000000000 ffffffff801036bc ffffffff80100e70 ffffffff803c5ae0
        0000000000000000 ffffffff9400a0e0 0000000000000000 0000000000002000
        0000000000000005 ffffffff9400a0e0 0000000000000000 000000000000002c
        980000000178c000 9800000001461800 0000000000100000 000000000023fc00
        0000000000000020 ffffffff801f911c 0000000000100100 98000000003e8e00
        ...
Call Trace:
 [<ffffffff80159eb4>] handle_IRQ_event+0x6c/0xe8
 [<ffffffff8015a094>] __do_IRQ+0x164/0x1d0
 [<ffffffff80107098>] timer_interrupt+0x298/0x470
 [<ffffffff801036bc>] do_IRQ+0x1c/0x38
 [<ffffffff80100e70>] ll_xdma_irq+0xc/0x14
 [<ffffffff801f911c>] memset_partial+0x38/0x60
 [<ffffffff801f912c>] memset_partial+0x48/0x60
 [<ffffffff8015a4a0>] setup_irq+0x108/0x1a8
 [<ffffffff8015a4b8>] setup_irq+0x120/0x1a8
 [<ffffffff802332a8>] msp85x0_ge_sequoia_int_handler+0x0/0x2e0
 [<ffffffff8015a734>] request_irq+0xac/0xf8
 [<ffffffff80233758>] msp85x0_ge_open+0x78/0x130
 [<ffffffff8023372c>] msp85x0_ge_open+0x4c/0x130
 [<ffffffff80244018>] dev_open+0x68/0xf0
 [<ffffffff80246720>] dev_change_flags+0x90/0x188
 [<ffffffff8036f7b0>] ic_open_devs+0x328/0x558
 [<ffffffff801c0fb8>] create_proc_entry+0x58/0xf8
 [<ffffffff803715a8>] ip_auto_config+0xa8/0x598
 [<ffffffff80348c10>] do_initcalls+0x90/0x198
 [<ffffffff80348c10>] do_initcalls+0x90/0x198
 [<ffffffff8010051c>] init+0x5c/0x1e0
 [<ffffffff80103da0>] kernel_thread_helper+0x10/0x18
 [<ffffffff80103d90>] kernel_thread_helper+0x0/0x18


Code: 64630001  0003183c  0061182d <8c638060> 3c040000  3c01803c  64840000 
0004203c  0081202d
Kernel panic - not syncing: Aiee, killing interrupt handler!

With best regards, Roman Mashak.  E-mail: mrv@corecom.co.kr 
