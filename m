Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 26 Aug 2004 16:30:30 +0100 (BST)
Received: from web13301.mail.yahoo.com ([IPv6:::ffff:216.136.175.37]:57175
	"HELO web13301.mail.yahoo.com") by linux-mips.org with SMTP
	id <S8225196AbUHZPaY>; Thu, 26 Aug 2004 16:30:24 +0100
Message-ID: <20040826153021.108.qmail@web13301.mail.yahoo.com>
Received: from [12.33.232.234] by web13301.mail.yahoo.com via HTTP; Thu, 26 Aug 2004 08:30:21 PDT
Date: Thu, 26 Aug 2004 08:30:21 -0700 (PDT)
From: Ken Giusti <manwithastinkydog@yahoo.com>
Subject: bcm1250 crash in eth rx in an -old- kernel
To: linux-mips <linux-mips@linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-Path: <manwithastinkydog@yahoo.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5741
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: manwithastinkydog@yahoo.com
Precedence: bulk
X-list: linux-mips

Hi,

I'm maintaining a bcm1250-based system that's running
an old kernel based on a 2.4 release provided by
sibyte
_way_ back - around 2/6/02.

The system is stable, but we do experience a very
rare kernel oops (on the order of perhaps 1 a month).
I've monitored these crashes for awhile now, and the
stackdumps are all similar in that they appear to 
involve the bcm5682 ethernet receive path.  Not exact,
but very similar, and always involving a socket
operation (allocation, wakeup, put).

I've eyeballed the codepath, no obvious error.  The
box is constantly sending/rcving enet traffic, so this
path is taken often with no ill affects (at least,
not immediately obvious ill affects :)

Our long-term goal is to move to a newer, 2.6-based
kernel, but that won't happen for awhile.  In the
meantime I'll need to maintain this kernel.  :(

It's a longshot, but I'm hoping that these crashes 
may jog somebody's long term memory...  

thanx in advance -K

Data bus error, epc == a02a9054, ra == a0114800
Unable to handle kernel paging request at virtual
address 00000004, epc == 8022c1c4, ra == 801e0c40
$0 : 00000000 10001f00 00000006 00000000 8058db54
8f48e140 10001f01 00000000
$8 : 40000000 00000000 b0020028 10001f00 00000000
8f22a000 10001f00 00000100
$16: 00000000 00000020 00000851 8ffd88a0 8ffde180
8f22bd70 803dd290 00000400
$24: ffffffff 00000001                   8f22a000
8f22bc80 2acfd008 801e0c40
epc  : 8022c1c4    Not tainted
Status: 10001f02
Cause : 1080000c
Process mem01 (pid: 6993, stackpage=8f22a000)
Stack: 00000000 8f22bcd0 80108200 00000000 00000000
8ffdf4b0 8ffd8890 801e0c40
       00800800 8f5389c0 8f5389c0 00000002 8f4af200
00000076 8ffd88b0 8ffdf4b0
       801e11c8 8f4233a0 802acf24 10001f01 8f22bd48
ffffffff 00000000 00000006
       8ffde180 8ffde000 00000001 801e31b0 00000000
8f57d0e0 8f57d0e0 8f5389c0
       8ffd0d20 02000001 00000013 00000000 8f22bd70
80109180 8f22bd20 8010f6d0
       00000000 ...
Call Trace: [<80108200>] [<801e0c40>] [<801e11c8>]
[<802acf24>] [<801e31b0>] [<80109180>]
 [<8010f6d0>] [<80109568>] [<802acf5c>] [<802777c0>]
[<80120988>] [<8010add8>]
 [<8011ac90>] [<8010aba8>] [<8010add8>] [<802ad758>]
[<802acf08>] [<80121ca0>]
 [<802b07c0>] [<802b07b8>] [<8010369c>] [<801031fc>]
[<802d5210>]
Code: 8ca30000  2442ffff  ac820008 <ac640004> ac830000
 aca00000  aca00004  aca00008  40016000

>>RA;  a0114800 <END_OF_CODE+1fb55800/????>
>>RA;  801e0c40 <sbdma_add_rcvbuffer+110/1b0>
>>$1; 10001f00 Before first symbol
>>$4; 8058db54 <rt_cache_stat+714/800>
>>$5; 8f48e140 <END_OF_CODE+eecf140/????>
>>$6; 10001f01 Before first symbol
>>$8; 40000000 Before first symbol
>>$10; b0020028 <END_OF_CODE+2fa61028/????>
>>$11; 10001f00 Before first symbol
>>$13; 8f22a000 <END_OF_CODE+ec6b000/????>
>>$14; 10001f00 Before first symbol
>>$18; 00000851 Before first symbol
>>$19; 8ffd88a0 <END_OF_CODE+fa198a0/????>
>>$20; 8ffde180 <END_OF_CODE+fa1f180/????>
>>$21; 8f22bd70 <END_OF_CODE+ec6cd70/????>
>>$22; 803dd290 <log_buf+1bf8/8000>
>>$24; ffffffff <END_OF_CODE+7fa40fff/????>
>>$26; 8f22a000 <END_OF_CODE+ec6b000/????>
>>$27; 8f22bc80 <END_OF_CODE+ec6cc80/????>
>>$28; 2acfd008 Before first symbol
>>$29; 801e0c40 <sbdma_add_rcvbuffer+110/1b0>

>>???; 8022c1c4 <alloc_skb+244/2c0>   <=====

Trace; 80108200 <smp_call_function_interrupt+d0/148>
Trace; 801e0c40 <sbdma_add_rcvbuffer+110/1b0>
Trace; 801e11c8 <sbdma_rx_process+180/310>
Trace; 802acf24 <sb1250_spc_irq_handler+e4/220>
Trace; 801e31b0 <sbmac_intr+268/318>
Trace; 80109180 <handle_IRQ_event+98/150>
Trace; 8010f6d0 <__wake_up+150/218>
Trace; 80109568 <do_IRQ+e0/198>
Trace; 802acf5c <sb1250_spc_irq_handler+11c/220>
Trace; 802777c0 <udp_v4_mcast_deliver+110/2c0>
Trace; 80120988 <do_timer+60/c0>
Trace; 8010add8 <ll_timer_interrupt+b8/c8>
Trace; 8011ac90 <do_softirq+c0/1d0>
Trace; 8010aba8 <timer_interrupt+70/1e8>
Trace; 8010add8 <ll_timer_interrupt+b8/c8>
Trace; 802ad758 <sb1250_gettimeoffset+c8/218>
Trace; 802acf08 <sb1250_spc_irq_handler+c8/220>
Trace; 80121ca0 <deliver_signal+28/100>
Trace; 802b07c0 <spc_rtc_get_time+cf8/11e8>
Trace; 802b07b8 <spc_rtc_get_time+cf0/11e8>
Trace; 8010369c <handle_dbe_int+20/44>
Trace; 801031fc <signal_return+14/38>
Trace; 802d5210 <mask_72_64+1748/2178>

-----------------------------------

Unable to handle kernel paging request at virtual
address fffffffc, epc == 8010f618, ra == 8022bb88
$0 : 00000000 10001f00 00000001 8f552390 8f55238c
00000001 00000001 000070d9
$8 : 00007532 000070d9 00000000 10001f00 b0020028
10001f00 00000000 00080000
$16: 8f56d0e0 00000000 00000000 8f55238c 00000001
8f552390 10001f01 80306bc4
$24: 0000000e 2ac1adc8                   8f24c000
8f24db80 8f24db80 8022bb88
epc  : 8010f618    Not tainted
Status: 10001f02
Cause : 00800008
Process ps (pid: 3312, stackpage=8f24c000)
Stack: 7661722f 000001b6 00000002 726f6f74 8f56d0e0
87ed9920 00000000 00000002
       87ead044 ac103fff ac100101 00000800 802f8e40
8022bb88 8f50bae0 00000001
       8f24c000 8f24dbe8 8f2d7320 8012c678 00000000
00000000 8f56d0e0 80277690
       00000000 8012c548 8f50bae0 00000001 00000000
8f56d0e0 87ed9920 802777d8
       00000000 cf08fb17 00000000 cf08fa13 0000005c
8f515740 87ed9920 0000005c
       87ead044 ...
Call Trace: [<8022bb88>] [<8012c678>] [<80277690>]
[<8012c548>] [<802777d8>] [<80277c38>]
 [<8012cad0>] [<8013cff0>] [<8024b650>] [<8024bcc0>]
[<80232580>] [<801e0c70>]
 [<80232d40>] [<8011acb8>] [<80108470>] [<801095e8>]
[<802ace1c>] [<80168300>]
 [<8013d788>] [<8010e5c0>] [<80172110>] [<8011f350>]
[<802a6ac8>] [<80171060>]
 [<8012db78>] [<8012d778>] [<80171460>] [<80147890>]
[<801069e0>] [<801537e0>]
 [<80107510>] [<80107510>]
Code: 00c0a021  3c178030  26f76bc4 <8e23fffc> 8fc4003c
 00003021  8c620000  00441024  00000000


>>RA;  8022bb88 <sock_def_readable+58/f0>
>>$1; 10001f00 Before first symbol
>>$3; 8f552390 <END_OF_CODE+ef93390/????>
>>$4; 8f55238c <END_OF_CODE+ef9338c/????>
>>$7; 000070d9 Before first symbol
>>$8; 00007532 Before first symbol
>>$9; 000070d9 Before first symbol
>>$11; 10001f00 Before first symbol
>>$12; b0020028 <END_OF_CODE+2fa61028/????>
>>$13; 10001f00 Before first symbol
>>$15; 00080000 Before first symbol
>>$16; 8f56d0e0 <END_OF_CODE+efae0e0/????>
>>$19; 8f55238c <END_OF_CODE+ef9338c/????>
>>$21; 8f552390 <END_OF_CODE+ef93390/????>
>>$22; 10001f01 Before first symbol
>>$23; 80306bc4 <write_fifo_fops+2c/48>
>>$25; 2ac1adc8 Before first symbol
>>$26; 8f24c000 <END_OF_CODE+ec8d000/????>
>>$27; 8f24db80 <END_OF_CODE+ec8eb80/????>
>>$28; 8f24db80 <END_OF_CODE+ec8eb80/????>
>>$29; 8022bb88 <sock_def_readable+58/f0>

>>???; 8010f618 <__wake_up+98/218>   <=====

Trace; 8022bb88 <sock_def_readable+58/f0>
Trace; 8012c678 <do_anonymous_page+388/398>
Trace; 80277690 <udp_queue_rcv_skb+338/358>
Trace; 8012c548 <do_anonymous_page+258/398>
Trace; 802777d8 <udp_v4_mcast_deliver+128/2c0>
Trace; 80277c38 <udp_rcv+1b8/3b8>
Trace; 8012cad0 <do_no_page+448/450>
Trace; 8013cff0 <_alloc_pages+28/38>
Trace; 8024b650 <ip_local_deliver+2c8/370>
Trace; 8024bcc0 <ip_rcv+5c8/770>
Trace; 80232580 <netif_rx+198/230>
Trace; 801e0c70 <sbdma_add_rcvbuffer+140/1b0>
Trace; 80232d40 <net_rx_action+280/590>
Trace; 8011acb8 <do_softirq+e8/1d0>
Trace; 80108470 <flush_tlb_range_ipi+20/30>
Trace; 801095e8 <do_IRQ+160/198>
Trace; 802ace1c <sb1250_irq_handler+15c/180>
Trace; 80168300 <get_empty_inode+d8/f0>
Trace; 8013d788 <free_pages+30/40>
Trace; 8010e5c0 <nopage_tlbs+104/124>
Trace; 80172110 <proc_pid_make_inode+28/128>
Trace; 8011f350 <access_process_vm+240/2b0>
Trace; 802a6ac8 <src_unaligned_dst_aligned+28/50>
Trace; 80171060 <proc_pid_cmdline+b0/170>
Trace; 8012db78 <do_mmap_pgoff+4e8/608>
Trace; 8012d778 <do_mmap_pgoff+e8/608>
Trace; 80171460 <proc_info_read+70/1a8>
Trace; 80147890 <sys_read+128/150>
Trace; 801069e0 <old_mmap+c8/100>
Trace; 801537e0 <sys_fstat64+78/a8>
Trace; 80107510 <stack_done+1c/38>
Trace; 80107510 <stack_done+1c/38>


------------------------------------


skput:over: 801ea5e8:118 put:118 dev:kernel BUG at
skbuff.c:100!
Unable to handle kernel paging request at virtual
address 00000000, epc == 802365ac, ra == 801ea600
Oops (core 0) in fault.c:do_page_fault, line 232:
$0 : 00000000 10001f00 0000001c 87e70000 8f413c5c
00000001 00000000 00001598
$8 : 00001598 fffffeff 00000000 0000000d b0020028
10001f00 00000000 00000100
$16: 8f4b8940 00000076 87fd3f00 87fd94b0 87fd8180
8f413d90 7fff7f22 00000000
$24: ffffffff 00000002                   8f412000
8f413cc8 8f38f750 801ea600
Hi : 00196604
Lo : 000cb302
epc  : 802365ac    Not tainted
Status: 10001f03
Cause : 1080000c
Process ps (pid: 31029, stackpage=8f412000)
Stack: 802d8e10 802d8e28 00000064 ffffffff 802d8e34
87fd94b0 801ea600 840e9538
       8023d4e0 841105e4 8023d4e0 00000001 00000000
00000006 87fd8180 87fd8000
       00000001 801ec570 00000000 80306890 fffffffb
00000000 8ffd0a14 02000001
       00000013 00000000 8f413d90 80109220 8010ac88
8010ad08 00000000 8f413d90
       80305280 8ffd0a14 00000000 00000013 fffffffb
80109608 00800800 00000f22
       00000002 ...
Call Trace: [<802d8e10>] [<802d8e28>] [<802d8e34>]
[<801ea600>] [<8023d4e0>] [<8023d4e0>]
 [<801ec570>] [<80109220>] [<8010ac88>] [<8010ad08>]
[<80109608>] [<802baa18>]
 [<802ba23c>] [<8010e590>] [<80177f10>] [<80178850>]
[<80120280>] [<802b3fac>]
 [<80176e60>] [<8012ed68>] [<8012e968>] [<80177260>]
[<8014ad50>] [<80106a80>]
 [<80157670>] [<801075b0>] [<801075b0>]
Code: 0c045546  24060064  8fbf0018  03e00008  27bd0020
 3c02802e  24428e34  0808d962 
In interrupt handler - not syncing

>>RA;  801ea600 <sbdma_rx_process+228/310>
>>$1; 10001f00 Before first symbol
>>$3; 87e70000 <END_OF_CODE+789f000/????>
>>$4; 8f413c5c <END_OF_CODE+ee42c5c/????>
>>$7; 00001598 Before first symbol
>>$8; 00001598 Before first symbol
>>$9; fffffeff <END_OF_CODE+7fa2eeff/????>
>>$12; b0020028 <END_OF_CODE+2fa4f028/????>
>>$13; 10001f00 Before first symbol
>>$16; 8f4b8940 <END_OF_CODE+eee7940/????>
>>$18; 87fd3f00 <END_OF_CODE+7a02f00/????>
>>$19; 87fd94b0 <END_OF_CODE+7a084b0/????>
>>$20; 87fd8180 <END_OF_CODE+7a07180/????>
>>$21; 8f413d90 <END_OF_CODE+ee42d90/????>
>>$22; 7fff7f22 Before first symbol
>>$24; ffffffff <END_OF_CODE+7fa2efff/????>
>>$26; 8f412000 <END_OF_CODE+ee41000/????>
>>$27; 8f413cc8 <END_OF_CODE+ee42cc8/????>
>>$28; 8f38f750 <END_OF_CODE+edbe750/????>
>>$29; 801ea600 <sbdma_rx_process+228/310>

>>???; 802365ac <skb_over_panic+4c/68>   

Trace; 802d8e10 <midplane_to_slot_c_table+3160/474c>
Trace; 802d8e28 <midplane_to_slot_c_table+3178/474c>
Trace; 802d8e34 <midplane_to_slot_c_table+3184/474c>
Trace; 801ea600 <sbdma_rx_process+228/310>
Trace; 8023d4e0 <net_rx_action+280/590>
Trace; 8023d4e0 <net_rx_action+280/590>
Trace; 801ec570 <sbmac_intr+298/318>
Trace; 80109220 <handle_IRQ_event+98/150>
Trace; 8010ac88 <local_timer_interrupt+b0/c0>
Trace; 8010ad08 <timer_interrupt+70/1e8>
Trace; 80109608 <do_IRQ+e0/198>
Trace; 802baa18 <sb1250_timer_interrupt+b8/e0>
Trace; 802ba23c <sb1250_irq_handler+15c/180>
Trace; 8010e590 <nopage_tlbl+104/114>
Trace; 80177f10 <proc_pid_make_inode+28/130>
Trace; 80178850 <proc_pid_lookup+1f8/2d8>
Trace; 80120280 <access_process_vm+240/2b0>
Trace; 802b3fac <l_exc+1c/34>
Trace; 80176e60 <proc_pid_cmdline+b0/170>
Trace; 8012ed68 <do_mmap_pgoff+4e8/608>
Trace; 8012e968 <do_mmap_pgoff+e8/608>
Trace; 80177260 <proc_info_read+70/1a8>
Trace; 8014ad50 <sys_read+128/150>
Trace; 80106a80 <old_mmap+c8/100>
Trace; 80157670 <sys_fstat64+78/a8>
Trace; 801075b0 <stack_done+1c/38>
Trace; 801075b0 <stack_done+1c/38>




		
__________________________________
Do you Yahoo!?
New and Improved Yahoo! Mail - Send 10MB messages!
http://promotions.yahoo.com/new_mail 
