Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 23 Nov 2004 00:26:48 +0000 (GMT)
Received: from gateway-1237.mvista.com ([IPv6:::ffff:12.44.186.158]:3834 "EHLO
	hermes.mvista.com") by linux-mips.org with ESMTP
	id <S8224941AbUKWA0k>; Tue, 23 Nov 2004 00:26:40 +0000
Received: from mvista.com (prometheus.mvista.com [10.0.0.139])
	by hermes.mvista.com (Postfix) with ESMTP
	id 30D48186A3; Mon, 22 Nov 2004 16:26:38 -0800 (PST)
Message-ID: <41A283BD.3080300@mvista.com>
Date: Mon, 22 Nov 2004 16:26:37 -0800
From: Manish Lachwani <mlachwani@mvista.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4.2) Gecko/20040308
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ralf Baechle <ralf@linux-mips.org>
Cc: Thiemo Seufer <ica2_ts@csv.ica.uni-stuttgart.de>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Linux/MIPS Development <linux-mips@linux-mips.org>
Subject: Re: [PATCH] Synthesize TLB refill handler at runtime
References: <20041121170242.GR20986@rembrandt.csv.ica.uni-stuttgart.de> <Pine.GSO.4.61.0411212048520.26374@waterleaf.sonytel.be> <20041121203757.GS20986@rembrandt.csv.ica.uni-stuttgart.de> <20041122070117.GB25433@linux-mips.org>
In-Reply-To: <20041122070117.GB25433@linux-mips.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <mlachwani@mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6409
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mlachwani@mvista.com
Precedence: bulk
X-list: linux-mips

Ralf Baechle wrote:
> On Sun, Nov 21, 2004 at 09:37:57PM +0100, Thiemo Seufer wrote:
> 
> 
>>Aww, fatal error in the spelling module. :-)
>>Updated.
> 
> 
> The patch was looking good, so I gave it a shot on one of my machines also
> and it was working fine, applied.
> 
> Thanks!
> 
>   Ralf
> 
Hello !

I tried out the patch on a MIPS Malta board (24Kc core). Compiled fine 
and booted fine as well. On bootup, I see:

...
Synthesized TLB handler (26 instructions).
...

However, when running a native kernel make (some test, I guess), I ran 
into the following:

gcc -D__KERNEL__ -I/root/2.4.19/include -Wall -Wstrict-prototypes 
-Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -fomit-frame-pointer 
-DGEMDEBUG_TRACEBUFFER -I /root/2.4.19/include/asm/gcc -G 0 
-mno-abicalls -fno-pic -pipe -mips2 -Wa,--trap   -DKBUILD_BASENAME=main 
-c -o init/main.o init/main.c
Data bus error, epc == 801f8ab8, ra == 80324be4
Oops in arch/mips/kernel/traps.c::do_be, line 330[#1]:
Cpu 0
$ 0   : 00000000 80000000 83fffb24 00000000
$ 4   : 83ffff04 8123e414 000000dc 00000000
$ 8   : 642e6261 00000000 7470672e 622e6261
$12   : 00007373 8117dd60 0000000a 7470672e
$16   : 8123e034 83fffb24 000004dc 0000a8f4
$20   : 81170060 00000000 83fffb24 00ff00ff
$24   : 0000001c 00000001
$28   : 83c58000 83c597f0 00000000 80324be4
Hi    : 106210ce
Lo    : d70a080d
epc   : 801f8ab8 both_aligned+0x40/0x74     Not tainted
ra    : 80324be4 csum_partial_copy_nocheck+0x44/0x64
Status: 1000fc03    KERNEL EXL IE
Cause : 0080001c
PrId  : 00019360
Modules linked in:
Process as (pid: 120, threadinfo=83c58000, task=83f47850)
Stack : 00000001 a1121000 80258ee0 80258df0 000004dc 000004dc 000004dc 
00000000
         802a82e4 80383a14 50808000 801f9198 8114d5c8 00000000 a1121000 
00000000
         000004f3 810da000 000004dc 000004dc 0000106c 00000b90 81170060 
0001090e
         83fffb24 00ff00ff 00000b24 802a8498 81170060 00000000 8114d5c8 
00000000
         00000000 00000000 83c59910 0000000a 0000006c 00001000 83c59918 
00001000
         ...
Call Trace:
[<80258ee0>] pcnet32_rx+0x38c/0x4b4
  [<80258df0>] pcnet32_rx+0x29c/0x4b4
  [<802a82e4>] skb_copy_and_csum_bits+0x78/0x2bc
  [<801f9198>] move_128bytes+0x90/0x214
  [<802a8498>] skb_copy_and_csum_bits+0x22c/0x2bc
  [<80312dc4>] skb_read_and_csum_bits+0x0/0xb4
  [<80312e08>] skb_read_and_csum_bits+0x44/0xb4
  [<8014328c>] __do_IRQ+0x170/0x184
  [<8031f494>] xdr_partial_copy_from_skb+0x190/0x1dc
  [<80312eec>] csum_partial_copy_to_xdr+0x74/0x134
  [<801026bc>] mipsIRQ+0x11c/0x180
  [<803130d4>] udp_data_ready+0x128/0x230
  [<802eb968>] udp_queue_rcv_skb+0x1e4/0x318
  [<802c4e68>] ipq_kill+0x18/0xcc
  [<802c513c>] ip_frag_intern+0x3c/0xe8
  [<802ec054>] udp_rcv+0x158/0x418
  [<802c4de4>] ip_frag_destroy+0xf8/0x164
  [<802c5c98>] ip_defrag+0x140/0x214
  [<802c5b80>] ip_defrag+0x28/0x214
  [<802c3eac>] ip_local_deliver+0x150/0x2dc
  [<802c4498>] ip_rcv+0x460/0x5cc
  [<802ae0e4>] process_backlog+0xcc/0x1d0
  [<802adf28>] netif_receive_skb+0x16c/0x25c
  [<802a697c>] skb_release_data+0xe0/0x124
  [<80313920>] xprt_write_space+0xc/0xf0
  [<802ae0e4>] process_backlog+0xcc/0x1d0
  [<802ae2ac>] net_rx_action+0xc4/0x1d8
  [<8012aea8>] __do_softirq+0x108/0x11c
  [<8012af48>] do_softirq+0x8c/0x94
  [<801431bc>] __do_IRQ+0xa0/0x184
  [<8014328c>] __do_IRQ+0x170/0x184
  [<80143028>] irq_exit+0x4c/0x54
  [<80102c84>] malta_hw0_irqdispatch+0x104/0x204
  [<80102c7c>] malta_hw0_irqdispatch+0xfc/0x204
  [<8013d030>] autoremove_wake_function+0x0/0x44
  [<801026bc>] mipsIRQ+0x11c/0x180
  [<803113fc>] call_transmit+0x68/0xd4
  [<80311444>] call_transmit+0xb0/0xd4
  [<801be7b4>] nfs_execute_read+0x3c/0x5c
  [<801be7b4>] nfs_execute_read+0x3c/0x5c
  [<801beb20>] nfs_pagein_one+0x138/0x164
  [<801beb18>] nfs_pagein_one+0x130/0x164
  [<801bebd0>] nfs_pagein_list+0x84/0xb0
  [<801bebb4>] nfs_pagein_list+0x68/0xb0
  [<801bf38c>] nfs_readpages+0xe8/0x124
  [<8014e25c>] read_pages+0x1c8/0x1d0
  [<8014a304>] buffered_rmqueue+0x198/0x288
  [<80102b20>] mips_timer_interrupt+0x60/0xc0
  [<8014a7b4>] __alloc_pages+0x3c0/0x3d0
  [<8014e600>] do_page_cache_readahead+0x16c/0x204
  [<8014a304>] buffered_rmqueue+0x198/0x288
  [<80146564>] filemap_nopage+0x480/0x50c
[<801115e8>] r4k_flush_cache_page+0x224/0x238
  [<80112408>] blast_icache32+0x6c/0xf0
  [<801588a0>] do_no_page+0xe0/0x4b4
  [<801579ec>] do_wp_page+0x264/0x544
  [<80158ecc>] handle_mm_fault+0x148/0x20c
  [<80143028>] irq_exit+0x4c/0x54
  [<801083d8>] ll_timer_interrupt+0x48/0x54
  [<80110774>] do_page_fault+0x1d4/0x360
  [<8012fa74>] run_timer_softirq+0x10c/0x214
  [<801026a4>] mipsIRQ+0x104/0x180
  [<8012aea8>] __do_softirq+0x108/0x11c
  [<8012af48>] do_softirq+0x8c/0x94
  [<8010829c>] timer_interrupt+0x178/0x26c
  [<80143028>] irq_exit+0x4c/0x54
  [<801083d8>] ll_timer_interrupt+0x48/0x54
  [<801138d0>] nopage_tlbl+0xf0/0x100
  [<801026a4>] mipsIRQ+0x104/0x180
 

 

Code: ac880000  ac890004  8ca80018 <8ca9001c> 24a50020  24840020 
ac8affe8  ac8bffec  ac8cfff0
Kernel panic - not syncing: Aiee, killing interrupt handler!


I have not got a chance to look deeper into it, but just wanted to let 
you folks know

Thanks
Manish Lachwani
