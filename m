Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 20 Mar 2004 10:06:22 +0000 (GMT)
Received: from mail001.syd.optusnet.com.au ([IPv6:::ffff:211.29.132.142]:23511
	"EHLO mail001.syd.optusnet.com.au") by linux-mips.org with ESMTP
	id <S8225482AbUCTKGV>; Sat, 20 Mar 2004 10:06:21 +0000
Received: from colombia (c211-30-22-201.thorn1.nsw.optusnet.com.au [211.30.22.201])
	by mail001.syd.optusnet.com.au (8.11.6p2/8.11.6) with ESMTP id i2KA69o15818
	for <linux-mips@linux-mips.org>; Sat, 20 Mar 2004 21:06:09 +1100
From: "Martin C. Barlow" <mips@martin.barlow.name>
To: <linux-mips@linux-mips.org>
Subject: hwclock and df seg fault
Date: Sat, 20 Mar 2004 21:05:40 +1100
Message-ID: <000201c40e62$e9d104f0$6500a8c0@colombia>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.2627
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
Return-Path: <mips@martin.barlow.name>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4597
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mips@martin.barlow.name
Precedence: bulk
X-list: linux-mips

Hey guys

I have an old SGI indy R4600 and have installed debian testing with
latest linux-mips cvs kernel. I found two problems with the programs
hwclock and df. Apart from that appears to work fine. I have included
their output. I don't know if it is a kernel or package problem. I don't
know if it as something to do with preemtible kernel which I enabled in
kernel. If anyone is interested and wants to see kernel .config, fstab
or anything else I'm happy to oblidge.

Barcelona:/var/log# hwclock
Mar 21 19:11:20 Barcelona kernel: bad: scheduling while atomic!
Mar 21 19:11:20 Barcelona kernel: Call Trace:
Mar 21 19:11:20 Barcelona kernel:  [<88030498>] schedule+0xb10/0xb18
Mar 21 19:11:20 Barcelona kernel:  [<88030490>] schedule+0xb08/0xb18
Mar 21 19:11:20 Barcelona kernel:  [<88031ef0>]
sys_sched_yield+0x154/0x1b4
Mar 21 19:11:20 Barcelona kernel:  [<88031fac>] yield+0x24/0x38
Mar 21 19:11:20 Barcelona kernel:  [<8808a2fc>] coredump_wait+0x3c/0xa4
Mar 21 19:11:20 Barcelona kernel:  [<8805d8e0>] cache_grow+0x274/0x4c0
Mar 21 19:11:20 Barcelona kernel:  [<8808a4b8>] do_coredump+0x154/0x26c
Mar 21 19:11:20 Barcelona kernel:  [<8805dd34>]
cache_alloc_refill+0x208/0x2b8
Mar 21 19:11:20 Barcelona kernel:  [<88007e14>]
indy_r4k_timer_interrupt+0x90/0x98
Mar 21 19:11:20 Barcelona kernel:  [<8801ec14>]
r4k_flush_icache_page+0xf4/0x124
Mar 21 19:11:20 Barcelona kernel:  [<882412f0>] change_floppy+0x94/0x180
Mar 21 19:11:20 Barcelona kernel:  [<88041380>]
__dequeue_signal+0x16c/0x2a0
Mar 21 19:11:20 Barcelona kernel:  [<880413b4>]
__dequeue_signal+0x1a0/0x2a0
Mar 21 19:11:20 Barcelona kernel:  [<8805e0ec>]
kmem_cache_alloc+0x94/0x9c
Mar 21 19:11:20 Barcelona kernel:  [<880414e0>] dequeue_signal+0x2c/0xa8
Mar 21 19:11:20 Barcelona kernel:  [<8802e9b8>] wake_up_state+0x18/0x2c
Mar 21 19:11:20 Barcelona kernel:  [<8804468c>]
get_signal_to_deliver+0x394/0x524
Mar 21 19:11:20 Barcelona kernel:  [<8800cf08>] do_signal+0x44/0xd74
Mar 21 19:11:20 Barcelona kernel:  [<8801dd20>]
do_page_fault+0x280/0x380
Mar 21 19:11:20 Barcelona kernel:  [<88086938>] chrdev_open+0x150/0x2cc
Mar 21 19:11:20 Barcelona kernel:  [<88079108>] dentry_open+0x1a4/0x2d0
Mar 21 19:11:20 Barcelona kernel:  [<88078f90>] dentry_open+0x2c/0x2d0
Mar 21 19:11:20 Barcelona kernel:  [<88079108>] dentry_open+0x1a4/0x2d0
Mar 21 19:11:20 Barcelona kernel:  [<88078f90>] dentry_open+0x2c/0x2d0
Mar 21 19:11:20 Barcelona kernel:  [<8807b554>] __fput+0x118/0x1c0
Mar 21 19:11:20 Barcelona kernel:  [<8807b434>] fput+0x40/0x48
Mar 21 19:11:20 Barcelona kernel:  [<8807972c>] filp_close+0x6c/0xb4
Mar 21 19:11:20 Barcelona kernel:  [<88079718>] filp_close+0x58/0xb4
Mar 21 19:11:20 Barcelona kernel:  [<8800dc70>]
do_notify_resume+0x38/0x54
Mar 21 19:11:20 Barcelona kernel:  [<88008be0>] work_notifysig+0xc/0x14
Mar 21 19:11:20 Barcelona kernel:  [<88011828>] stack_done+0x20/0x3c
Mar 21 19:11:20 Barcelona kernel:  [<88079774>] sys_close+0x0/0x12c
Mar 21 19:11:20 Barcelona kernel:
Mar 21 19:11:20 Barcelona kernel: note: hwclock[369] exited with
preempt_count 2

Barcelona:/var/log# df
Filesystem           1K-blocks      Used Available Use% Mounted on
df: `/': Invalid argument
df: `/proc': Invalid argument
df: `/dev/pts': Invalid argument
df: `/dev/shm': Invalid argument
df: `/sys': Invalid argument
Barcelona:/var/log#

P.S. feel free to ignore me. It does not really worry me that they don't
work, but I thought maybe someone would want to know.
