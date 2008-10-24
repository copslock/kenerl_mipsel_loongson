Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 24 Oct 2008 10:39:26 +0100 (BST)
Received: from vervifontaine.sonytel.be ([80.88.33.193]:28039 "EHLO
	vervifontaine.sonycom.com") by ftp.linux-mips.org with ESMTP
	id S22278467AbYJXJjR (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 24 Oct 2008 10:39:17 +0100
Received: from vixen.sonytel.be (piraat.sonytel.be [43.221.60.197])
	by vervifontaine.sonycom.com (Postfix) with ESMTP id 5FF7F58ABD;
	Fri, 24 Oct 2008 11:39:07 +0200 (MEST)
Date:	Fri, 24 Oct 2008 11:39:07 +0200 (CEST)
From:	Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
cc:	Linux/MIPS Development <linux-mips@linux-mips.org>
Subject: RBTX4927 with VxWorks boot loader crashes in prom_getenv()
Message-ID: <Pine.LNX.4.64.0810241118120.27263@vixen.sonytel.be>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-584349381-1487516042-1224841147=:27263"
Return-Path: <Geert.Uytterhoeven@sonycom.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20919
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Geert.Uytterhoeven@sonycom.com
Precedence: bulk
X-list: linux-mips

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---584349381-1487516042-1224841147=:27263
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: 8BIT

	Hi Nemoto-san,

My RBTX4927 with VxWorks boot loader crashes in prom_getenv() since commit
860e546c19d88c21819c7f0861c505debd2d6eed ("MIPS: TXx9: Early command-line
preprocessing"):

| Tlb Load Exception
| Exception Program Counter: 0x80324e60
| Status Register: 0x36008700
| Cause Register: 0x00000008
| Access Address : 0x00002000
| Task: 0x87fe7fc0 ""
| 8031e714: 80328cc0 (0, 1, 0, 0)
| 80328ce4: 80325238 (80126350, 0, 80340000, 0)
| 8032550c: 80324e0c (0, 0, 0, 736e6f63)
| 
| $0    =                0   t0    = ffffffff8030fc40   s0    = ffffffff80340000
| at    =               6d   t1    = ffffffff80310000   s1    = ffffffff80310000
| v0    =             2000   t2    = ffffffff80350000   s2    = ffffffff802e0000
| v1    = ffffffff8030f7c7   t3    = ffffffff80350000   s3    = ffffffff80002000
| a0    = ffffffff802dfe1c   t4    = ffffffff80350000   s4    =                1
| a1    =             2000   t5    =                0   s5    = ffffffff802e0000
| a2    = ffffffff802dfe1c   t6    =                0   s6    = ffffffff80789384
| a3    =                0   t7    = ffffffffbc020280   s7    =              1e0
| s8    = ffffffff80104430   k0    =                0                           
| gp    = ffffffff8030c000   k1    =                0   t8    =                0
| ra    = ffffffff80325514   sp    = ffffffff8030de38   t9    = ffffffffffffffff
| divlo =                2   divhi =                4   sr    = 36008700        
| pc    = 80324e60        

After making the following change:

diff --git a/arch/mips/txx9/generic/setup.c b/arch/mips/txx9/generic/setup.c
index 5526375..96692b6 100644
--- a/arch/mips/txx9/generic/setup.c
+++ b/arch/mips/txx9/generic/setup.c
@@ -416,6 +416,11 @@ const char *__init prom_getenv(const char *name)
 {
 	const s32 *str = (const s32 *)fw_arg2;
 
+printk("fw_arg0 = 0x%lx\n", fw_arg0);
+printk("fw_arg1 = 0x%lx\n", fw_arg1);
+printk("fw_arg2 = 0x%lx\n", fw_arg2);
+printk("fw_arg3 = 0x%lx\n", fw_arg3);
+return NULL;
 	if (!str)
 		return NULL;
 	/* YAMON style ("name", "value" pairs) */

it boots again and prints:

| fw_arg0 = 0x80002000
| fw_arg1 = 0x80001fe0
| fw_arg2 = 0x2000
| fw_arg3 = 0x20

So your assumption that bootloaders other than YAMON pass NULL for fw_arg2 is
apparently wrong.

BTW, after making this change, I still have another issue with the network.
I get

| ne.c:v1.10 9/23/94 Donald Becker (becker@scyld.com)
| Last modified Nov 1, 2000 by Paul Gortmaker
| NE*000 ethercard probe at 0x6020280:<4>eth%d: interrupt from stopped card
| irq 13: nobody cared (try booting with the "irqpoll" option)
| Call Trace:
| [<8010cd90>] dump_stack+0x8/0x34
| [<8014d944>] __report_bad_irq+0x4c/0xb0
| [<8014db28>] note_interrupt+0x180/0x200
| [<8014ebbc>] handle_level_irq+0xc4/0x114
| [<80107cb4>] plat_irq_dispatch+0x74/0x94
| [<80100424>] ret_from_irq+0x0/0x4
| [<8012bab0>] __do_softirq+0x54/0x140
| [<8012bbf8>] do_softirq+0x5c/0x90
| [<8012c094>] irq_exit+0x40/0x90
| [<80100424>] ret_from_irq+0x0/0x4
| [<8014d0a0>] __setup_irq+0x214/0x2a4
| [<8014d210>] request_irq+0xe0/0x128
| [<80340e50>] ne_probe1+0x4c8/0x660
| [<80341234>] ne_drv_probe+0xd4/0x170
| [<80229214>] driver_probe_device+0xf0/0x1a8
| [<8022933c>] __driver_attach+0x70/0xa8
| [<80228700>] bus_for_each_dev+0x54/0xa0
| [<80228bb4>] bus_add_driver+0xc4/0x1e8
| [<80229594>] driver_register+0xb4/0x15c
| [<8022a330>] platform_driver_probe+0x18/0x74
| [<80340968>] ne_init+0x20/0x40
| [<8010759c>] __kprobes_text_end+0x64/0x1c4
| [<8032a5fc>] kernel_init+0x8c/0xfc
| [<80109124>] kernel_thread_helper+0x10/0x18
| 
| handlers:
| [<802348b8>] (eip_interrupt+0x0/0x360)
| Disabling IRQ #13
| 00:60:0a:00:45:33
| eth0: RBHMA4X00/RTL8019 found at 0x6020280, using IRQ 13.

and

| WARNING: at net/sched/sch_generic.c:226 dev_watchdog+0x168/0x25c()
| NETDEV WATCHDOG: eth0 (): transmit timed out
| Modules linked in:
| Call Trace:
| [<8010cd90>] dump_stack+0x8/0x34
| [<801262f8>] warn_slowpath+0x80/0xac
| [<80259ab4>] dev_watchdog+0x168/0x25c
| [<80130ab0>] run_timer_softirq+0x168/0x20c
| [<8012bae0>] __do_softirq+0x84/0x140
| [<8012bbf8>] do_softirq+0x5c/0x90
| [<8012c094>] irq_exit+0x40/0x90
| [<80100424>] ret_from_irq+0x0/0x4
| [<80108620>] r4k_wait_irqoff+0x4c/0x54
| [<80109300>] cpu_idle+0x2c/0x54
| [<8032aa1c>] start_kernel+0x3b0/0x3e4
| 
| ---[ end trace ecf0edc63f731c6d ]---
| ..<7>eth0: Tx timed out, lost interrupt? TSR=0x3, ISR=0x3, t=1873.
| ..<7>eth0: Tx timed out, lost interrupt? TSR=0x3, ISR=0x3, t=5533.
|  timed out!
| IP-Config: Reopening network devices...
| Sending DHCP requests ..<7>eth0: Tx timed out, lost interrupt? TSR=0x3, ISR=0x3, t=733.
| ..<7>eth0: Tx timed out, lost interrupt? TSR=0x3, ISR=0x3, t=2319.
| ..<7>eth0: Tx timed out, lost interrupt? TSR=0x3, ISR=0x3, t=6709.
|  timed out!
| IP-Config: Reopening network devices...

This is plain 2.6.27+ as of yesterday. I'll see if it goes away with today's
linux-mips git tree.

With kind regards,

Geert Uytterhoeven
Software Architect

Sony Techsoft Centre Europe
The Corporate Village · Da Vincilaan 7-D1 · B-1935 Zaventem · Belgium

Phone:    +32 (0)2 700 8453
Fax:      +32 (0)2 700 8622
E-mail:   Geert.Uytterhoeven@sonycom.com
Internet: http://www.sony-europe.com/

A division of Sony Europe (Belgium) N.V.
VAT BE 0413.825.160 · RPR Brussels
Fortis · BIC GEBABEBB · IBAN BE41293037680010
---584349381-1487516042-1224841147=:27263--
