Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 05 Aug 2008 21:28:33 +0100 (BST)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:4164 "EHLO
	mail3.caviumnetworks.com") by ftp.linux-mips.org with ESMTP
	id S20043313AbYHEU2Z (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 5 Aug 2008 21:28:25 +0100
Received: from exch4.caveonetworks.com (Not Verified[192.168.16.23]) by mail3.caviumnetworks.com with MailMarshal (v6,2,2,3503)
	id <B4898b7e10000>; Tue, 05 Aug 2008 16:28:17 -0400
Received: from exch4.caveonetworks.com ([192.168.16.23]) by exch4.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Tue, 5 Aug 2008 13:28:13 -0700
Received: from [192.168.162.106] ([64.169.86.201]) by exch4.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Tue, 5 Aug 2008 13:28:13 -0700
Message-ID: <4898B7DD.6090402@caviumnetworks.com>
Date:	Tue, 05 Aug 2008 13:28:13 -0700
From:	Chad Reese <kreese@caviumnetworks.com>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.8.0.14eol) Gecko/20070505 Iceape/1.0.9 (Debian-1.0.13~pre080323b-0etch3)
MIME-Version: 1.0
To:	Chris Friesen <cfriesen@nortel.com>
CC:	linux-mips@linux-mips.org, ralf@linux-mips.org
Subject: Re: looking for help interpreting softlockup/stack trace
References: <48989AFE.5000500@nortel.com>
In-Reply-To: <48989AFE.5000500@nortel.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 05 Aug 2008 20:28:13.0852 (UTC) FILETIME=[C90FEDC0:01C8F739]
Return-Path: <Kenneth.Reese@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20119
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kreese@caviumnetworks.com
Precedence: bulk
X-list: linux-mips

I assume this is happening under high network load. Some early Octeon
ethernet drivers had a problem where they could starve the rest of the
system processing incoming packets. The message you are getting is the
kernel warning you that userspace hasn't been given any processing time.
What is probably happening is the cavium_ethernet driver is spending all
its time in a receive tasklet getting packets and then dropping them.
This has been fixed in a later cavium SDK, but it looks like you are
running an ancient kernel. A newer kernel is available on the cavium
support site.

The cavium ethernet driver doesn't use the standard NAPI interface since
it doesn't support multicore receive for a single port.

Chad

Chris Friesen wrote:
> I've run into an interesting issue with an Octeon-based board, where it 
> just seems to hang.  I suspect we're hitting some kind of locking bug, 
> and I'm trying to track it down.  If it matters, the kernel is quite old 
> (heavily patched 2.6.14) and I've got no chance of upgrading it.  (The 
> usual embedded scenario.)
> 
> I've added some scheduler instrumentation, as well as adding a stack 
> dump to the output of the softlockup code.
> 
> In the trace below, is "epc" the program counter at the time of the 
> timer interrupt?  How does "ra" fit into this, given that the function 
> whose address it contains isn't seen in the stack trace until quite a 
> ways down?
> 
> Any insights are greatly appreciated...
> 
> Chris
> 
> cpu9: jiffies: 4295366417, hrtime: 552015654907, 500 ms without calling 
> schedule() since scheduler requested
> cpu1: jiffies: 4295366418, hrtime: 552016450325, 500 ms without calling 
> schedule() since scheduler requested
> cpu3: jiffies: 4295366442, hrtime: 552034584838, 500 ms without calling 
> schedule() since scheduler requested
> cpu9: jiffies: 4295367258, hrtime: 552646827014, 841 ms between 
> scheduler_tick() calls
> BUG: soft lockup detected on CPU#0!
> Cpu 0
> $ 0   : 0000000000000000 0000000000000000 ffffffff80000000 ffffffff00000000
> $ 4   : a8000000db3ce808 0000000000000084 a8000000d34cb1ea a8000000d34cb1ea
> $ 8   : 0000000045000084 0000000000000002 0000000000000001 ffffffff8165e1e0
> $12   : 0000000000000000 ffffffff812dedac 0000500000008000 0000100000000000
> $16   : a8000000d3a40b68 a8000000db3ce580 a8000000d3a40b00 ffffffff8151e448
> $20   : a8000000db3ce808 ffffffff81593808 a8000000d3a40b00 0000000000000000
> $24   : 0000000000000030 c000000001ae1820
> $28   : ffffffff81590000 ffffffff81593680 ffffffff81593810 c000000001b4ab9c
> Hi    : 0000000000000000
> Lo    : 0000000000000000
> epc   : ffffffff8151e44c _read_lock+0x4/0x20     Tainted: P
> ra    : c000000001b4ab9c $LBB378+0x0/0x18 [vnb]
> Status: 1000ffe3    KX SX UX KERNEL EXL IE
> Cause : 40808000
> PrId  : 000d0301
> Call Trace:
>   [<ffffffff811a251c>] softlockup_tick+0x12c/0x158
>   [<ffffffff811126dc>] timer_interrupt+0xd4/0x4c8
>   [<ffffffff81112890>] timer_interrupt+0x288/0x4c8
>   [<ffffffff81101d50>] octeon_main_timer_interrupt+0x78/0x90
>   [<ffffffff811a2c24>] handle_IRQ_event+0x45c/0x1528
>   [<ffffffff811a3dc4>] __do_IRQ+0xd4/0x230
>   [<ffffffff8151e448>] _read_lock+0x0/0x20
>   [<ffffffff8110c4a8>] do_IRQ+0x440/0x1520
>   [<ffffffff8139263c>] neigh_lookup+0xb4/0x128
>   [<ffffffff8151e448>] _read_lock+0x0/0x20
>   [<ffffffff8110a430>] ret_from_irq+0x0/0x10
>   [<ffffffff8114fbdc>] __wake_up_common+0x6c/0xb8
>   [<ffffffff812dedac>] memset_partial+0x48/0x60
>   [<ffffffff8151e448>] _read_lock+0x0/0x20
>   [<c000000001ae1820>] $Ltext0+0x0/0x4 [vnb]
>   [<ffffffff8151e618>] _read_unlock+0x0/0x20
>   [<c000000001b4ab9c>] $LBB378+0x0/0x18 [vnb]
>   [<ffffffff8151e44c>] _read_lock+0x4/0x20
>   [<ffffffff81407fcc>] arp_rcv+0x18c/0x258
>   [<ffffffff8138b84c>] netif_dispatch_skb+0x18c/0x2d0
>   [<c000000000861208>] $LBE370+0x0/0x10 [cavium_ethernet]
>   [<c000000001ae2acc>] $L396+0x0/0x1c [vnb]
>   [<c000000001b47ba8>] $LCFI35+0x8c/0x9c [vnb]
>   [<c000000001adb36c>] $L1193+0x2c/0x48 [vnb]
>   [<c000000001b3dc5c>] $L1047+0x28/0xd0 [vnb]
>   [<c000000001b3d6f0>] $LBB344+0x2c/0x34 [vnb]
>   [<ffffffff811476a8>] activate_task+0x98/0x108
>   [<c000000001adb4cc>] $L1215+0x2c/0x30 [vnb]
>   [<c000000001adb7c0>] $L1273+0x0/0x18 [vnb]
>   [<c000000001ae18a8>] $L28+0x24/0x4c [vnb]
>   [<ffffffff8138bc90>] netif_receive_skb+0x300/0x730
>   [<ffffffff8138130c>] __alloc_skb+0x84/0x1a8
>   [<c000000000861970>] $L620+0x20/0x28 [cavium_ethernet]
>   [<ffffffff811734e8>] process_timeout+0x0/0xb08
>   [<ffffffff81111cc0>] do_gettimeofday+0xa8/0x220
>   [<ffffffff81169b2c>] tasklet_action+0x684/0x1950
>   [<ffffffff81187b9c>] hrtimer_run_queues+0x84/0x1a0
>   [<c0000000008613d8>] cvm_oct_tasklet_rx+0x0/0x4 [cavium_ethernet]
>   [<ffffffff81171ce4>] run_timer_softirq+0x20c/0xce0
>   [<c0000000008613d8>] cvm_oct_tasklet_rx+0x0/0x4 [cavium_ethernet]
>   [<ffffffff81112890>] timer_interrupt+0x288/0x4c8
>   [<ffffffff81167afc>] __do_softirq+0x56c/0x1818
>   [<ffffffff81168e40>] do_softirq+0x98/0xb8
>   [<ffffffff8110c874>] do_IRQ+0x80c/0x1520
>   [<ffffffff8110dd98>] kernel_thread+0xa0/0xbf8
>   [<ffffffff8110a430>] ret_from_irq+0x0/0x10
>   [<ffffffff8151bef4>] schedule+0xd4c/0x1a98
>   [<ffffffff81109ec0>] r4k_wait+0x0/0x10
>   [<ffffffff813859b0>] datagram_poll+0x0/0x140
>   [<ffffffff8110d974>] cpu_idle+0x44/0x60
>   [<ffffffff81109ec8>] r4k_wait+0x8/0x10
>   [<ffffffff81611e70>] start_kernel+0x460/0x4f8
>   [<ffffffff81611e68>] start_kernel+0x458/0x4f8
>   [<ffffffff81611000>] kernel_entry+0x0/0x4c
> 

-- 

Chad Reese <kreese@caviumnetworks.com>
Cavium Networks
