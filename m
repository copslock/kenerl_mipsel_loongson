Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 19 Nov 2007 21:43:00 +0000 (GMT)
Received: from mail.zeugmasystems.com ([70.79.96.174]:7851 "EHLO
	zeugmasystems.com") by ftp.linux-mips.org with ESMTP
	id S20034829AbXKSVmv convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 19 Nov 2007 21:42:51 +0000
x-mimeole: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: futex_wake_op deadlock?
Date:	Mon, 19 Nov 2007 13:42:23 -0800
Message-ID: <DDFD17CC94A9BD49A82147DDF7D545C54DCDF6@exchange.ZeugmaSystems.local>
In-Reply-To: <DDFD17CC94A9BD49A82147DDF7D545C54DCDE2@exchange.ZeugmaSystems.local>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: futex_wake_op deadlock?
Thread-Index: Acgq3M3SscB26V6iT9WqOzIqyKCfJAAFKJyAAACnbWA=
From:	"Kaz Kylheku" <kaz@zeugmasystems.com>
To:	"Ralf Baechle" <ralf@linux-mips.org>
Cc:	<linux-mips@linux-mips.org>
Return-Path: <kaz@zeugmasystems.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17535
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kaz@zeugmasystems.com
Precedence: bulk
X-list: linux-mips

Earlier, I wrote:
> I have hacked up little a test program which hosed my board within
> seconds. The system is not completely hung. However:
> 
> - I can't kill the test program with Ctrl-C.
> - I can log into the box with telnet.
> - If I run "ps aux" to see all processes, the ps command hangs partway
> through the table, and cannot be killed with Ctrl-C.
> - System hangs on soft reboot attempt; requires hard reset.

Furthermore: my console loglevel was too high to see the crash on the
serial console, but, surely enough, the syslog has this:

Nov 19 14:19:57 [kernel] [14:19:57.846017] BUG: soft lockup detected on
CPU#1!
Nov 19 14:19:57 [kernel] [14:19:57.846051] Call Trace:
Nov 19 14:19:58 [kernel] [14:19:57.846069]  [<ffffffff8016de8c>]
softlockup_tick+0x1bc/0x208
Nov 19 14:19:58 [kernel] [14:19:57.846112]  [<ffffffff8014cc54>]
update_process_times+0x9c/0xe8
Nov 19 14:19:58 [kernel] [14:19:57.846147]  [<ffffffff801098bc>]
ll_local_timer_interrupt+0x94/0xa8
Nov 19 14:19:58 [kernel] [14:19:57.846180]  [<ffffffff801098bc>]
ll_local_timer_interrupt+0x94/0xa8
Nov 19 14:19:58 [kernel] [14:19:57.846205]  [<ffffffff801026a0>]
plat_irq_dispatch+0x120/0x1a0
Nov 19 14:19:58 [kernel] [14:19:57.846232]  [<ffffffff80163f28>]
compat_sys_futex+0x0/0x188
Nov 19 14:19:58 [kernel] [14:19:57.846258]  [<ffffffff801637e0>]
do_futex+0x8f8/0xb58
Nov 19 14:19:58 [kernel] [14:19:57.846281]  [<ffffffff8011db28>]
tlb_do_page_fault_1+0x110/0x128
Nov 19 14:19:58 [kernel] [14:19:57.846317]  [<ffffffff80163758>]
do_futex+0x870/0xb58
Nov 19 14:19:58 [kernel] [14:19:57.846339]  [<ffffffff80163f28>]
compat_sys_futex+0x0/0x188
Nov 19 14:19:58 [kernel] [14:19:57.846364]  [<ffffffff80163170>]
do_futex+0x288/0xb58
Nov 19 14:19:58 [kernel] [14:19:57.846385]  [<ffffffff801637e0>]
do_futex+0x8f8/0xb58
Nov 19 14:19:58 [kernel] [14:19:57.846407]  [<ffffffff80163764>]
do_futex+0x87c/0xb58
Nov 19 14:19:58 [kernel] [14:19:57.846430]  [<ffffffff80177500>]
__alloc_pages+0x70/0x398
Nov 19 14:19:58 [kernel] [14:19:57.846456]  [<ffffffff80130d1c>]
try_to_wake_up+0x3c4/0x4f8
Nov 19 14:19:58 [kernel] [14:19:57.846489]  [<ffffffff802f3c28>]
__up_read+0xe8/0x130
Nov 19 14:19:58 [kernel] [14:19:57.846528]  [<ffffffff80163fac>]
compat_sys_futex+0x84/0x188
Nov 19 14:19:58 [kernel] [14:19:57.846552]  [<ffffffff80116314>]
handle_sysn32+0x54/0xb0
Nov 19 14:19:58 [kernel] [14:19:57.846578]  [<ffffffff80163f28>]
compat_sys_futex+0x0/0x188
