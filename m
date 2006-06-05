Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 05 Jun 2006 17:06:19 +0100 (BST)
Received: from father.pmc-sierra.com ([216.241.224.13]:49122 "HELO
	father.pmc-sierra.bc.ca") by ftp.linux-mips.org with SMTP
	id S8133862AbWFEQGK (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 5 Jun 2006 17:06:10 +0100
Received: (qmail 12820 invoked by uid 101); 5 Jun 2006 16:05:59 -0000
Received: from unknown (HELO ogyruan.pmc-sierra.bc.ca) (216.241.226.236)
  by father.pmc-sierra.com with SMTP; 5 Jun 2006 16:05:59 -0000
Received: from bby1exi01.pmc_nt.nt.pmc-sierra.bc.ca (bby1exi01.pmc-sierra.bc.ca [216.241.231.251])
	by ogyruan.pmc-sierra.bc.ca (8.13.3/8.12.7) with ESMTP id k55G5xBJ001558;
	Mon, 5 Jun 2006 09:05:59 -0700
Received: by bby1exi01.pmc-sierra.bc.ca with Internet Mail Service (5.5.2656.59)
	id <JPF6WCSK>; Mon, 5 Jun 2006 09:05:59 -0700
Message-ID: <478F19F21671F04298A2116393EEC3D5274178@sjc1exm08.pmc_nt.nt.pmc-sierra.bc.ca>
From:	Raj Palani <Rajesh_Palani@pmc-sierra.com>
To:	Roman Mashak <mrv@corecom.co.kr>, linux-mips@linux-mips.org
Subject: RE: booting 64bit kernel on RM9150
Date:	Mon, 5 Jun 2006 09:05:54 -0700 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2656.59)
Content-Type: text/plain
Return-Path: <Rajesh_Palani@pmc-sierra.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11666
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Rajesh_Palani@pmc-sierra.com
Precedence: bulk
X-list: linux-mips

Hi Roman,

   Yes.  The current kernel on the FTP site does not have 64-bit support tested.

-Raj

> -----Original Message-----
> From: Roman Mashak [mailto:mrv@corecom.co.kr] 
> Sent: Friday, June 02, 2006 5:21 PM
> To: linux-mips@linux-mips.org
> Cc: Raj Palani
> Subject: Re: booting 64bit kernel on RM9150
> 
> Hello, Raj!
> You wrote to "Roman Mashak" <mrv@corecom.co.kr>; 
> <linux-mips@linux-mips.org> on Fri, 2 Jun 2006 16:28:17 -0700 :
> 
>  RP>    The patch for 64-bit support for Sequoia would follow 
> the patch for
>  RP> the base support for Sequoia in the Linux/MIPS tree.
> Are you saying the kernel 2.6.12-rc3_L002 located on 
> ftp.pmc-sierra.com doesn't support 64bit properly? I used for 
> experiments that kernel and default config file for 64bit 
> support provided with the kernel. It boots up eventually and crashes:
> 
> TCP established hash table entries: 16384 (order: 5, 131072 
> bytes) TCP bind hash table entries: 16384 (order: 5, 131072 bytes)
> TCP: Hash tables configured (established 16384 bind 16384)
> NET: Registered protocol family 1
> CPU 0 Unable to handle kernel paging request at virtual 
> address 00000000ff048060, epc == ffffffff802332f8, ra == 
> ffffffff80159eb4 Oops in arch/mips/mm/fault.c::do_page_fault, 
> line 167[#1]:
> Cpu 0
> $ 0   : 0000000000000000 ffffffffff050000 ffffffff802332a8 
> 00000000ff050000
> $ 4   : 0000000000000005 980000000178c000 9800000001487d50 
> 000000000000002c
> $ 8   : 980000000178c000 9800000001461800 0000000000100000 
> 000000000023fc00
> $12   : 0000000000002000 0000000000000000 ffffffff9400a0e0 
> 98000000003e8e00
> $16   : 980000000178c000 0000000000000000 9800000001487d50 
> 0000000000000000
> $20   : ffffffff940080e0 0000000000000000 0000000000000000 
> 0000000000000000
> $24   : 98000000003e8e10 0000000000000001
> $28   : 9800000001484000 9800000001487c90 0000000000000000 
> ffffffff80159eb4
> Hi    : 000000000000348f
> Lo    : 5c28f5c28fab0000
> epc   : ffffffff802332f8 
> msp85x0_ge_sequoia_int_handler+0x50/0x2e0     Not 
> tainted
> ra    : ffffffff80159eb4 handle_IRQ_event+0x6c/0xe8
> Status: 940080e2    KX SX UX KERNEL EXL
> Cause : 00002008
> BadVA : 00000000ff048060
> PrId  : 000034c1
> Modules linked in:
> Process swapper (pid: 1, threadinfo=9800000001484000, 
> task=98000000014816b8) Stack : 980000000fddc940 
> 0000000000000000 9800000001487d50 0000000000000005
>         0000000000000001 0000000000000000 ffffffff80159eb4 
> 0000000000000001
>         ffffffff80345140 0000000000000005 980000000fddc940 
> 9800000001487d50
>         fffffffffffffffb 980000000178c000 ffffffff8015a094 
> ffffffff80107098
>         ffffffff80345140 980000000fddc940 0000000000000005 
> ffffffff9400a0e1
>         0000000000000000 ffffffff801036bc ffffffff80100e70 
> ffffffff803c5ae0
>         0000000000000000 ffffffff9400a0e0 0000000000000000 
> 0000000000002000
>         0000000000000005 ffffffff9400a0e0 0000000000000000 
> 000000000000002c
>         980000000178c000 9800000001461800 0000000000100000 
> 000000000023fc00
>         0000000000000020 ffffffff801f911c 0000000000100100 
> 98000000003e8e00
>         ...
> Call Trace:
>  [<ffffffff80159eb4>] handle_IRQ_event+0x6c/0xe8  
> [<ffffffff8015a094>] __do_IRQ+0x164/0x1d0  
> [<ffffffff80107098>] timer_interrupt+0x298/0x470  
> [<ffffffff801036bc>] do_IRQ+0x1c/0x38  [<ffffffff80100e70>] 
> ll_xdma_irq+0xc/0x14  [<ffffffff801f911c>] 
> memset_partial+0x38/0x60  [<ffffffff801f912c>] 
> memset_partial+0x48/0x60  [<ffffffff8015a4a0>] 
> setup_irq+0x108/0x1a8  [<ffffffff8015a4b8>] 
> setup_irq+0x120/0x1a8  [<ffffffff802332a8>] 
> msp85x0_ge_sequoia_int_handler+0x0/0x2e0
>  [<ffffffff8015a734>] request_irq+0xac/0xf8  
> [<ffffffff80233758>] msp85x0_ge_open+0x78/0x130  
> [<ffffffff8023372c>] msp85x0_ge_open+0x4c/0x130  
> [<ffffffff80244018>] dev_open+0x68/0xf0  [<ffffffff80246720>] 
> dev_change_flags+0x90/0x188  [<ffffffff8036f7b0>] 
> ic_open_devs+0x328/0x558  [<ffffffff801c0fb8>] 
> create_proc_entry+0x58/0xf8  [<ffffffff803715a8>] 
> ip_auto_config+0xa8/0x598  [<ffffffff80348c10>] 
> do_initcalls+0x90/0x198  [<ffffffff80348c10>] 
> do_initcalls+0x90/0x198  [<ffffffff8010051c>] init+0x5c/0x1e0 
>  [<ffffffff80103da0>] kernel_thread_helper+0x10/0x18  
> [<ffffffff80103d90>] kernel_thread_helper+0x0/0x18
> 
> 
> Code: 64630001  0003183c  0061182d <8c638060> 3c040000  
> 3c01803c  64840000 
> 0004203c  0081202d
> Kernel panic - not syncing: Aiee, killing interrupt handler!
> 
> With best regards, Roman Mashak.  E-mail: mrv@corecom.co.kr 
> 
> 
