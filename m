Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 13 Nov 2008 11:27:01 +0000 (GMT)
Received: from kuber.nabble.com ([216.139.236.158]:60843 "EHLO
	kuber.nabble.com") by ftp.linux-mips.org with ESMTP
	id S23654793AbYKML07 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 13 Nov 2008 11:26:59 +0000
Received: from isper.nabble.com ([192.168.236.156])
	by kuber.nabble.com with esmtp (Exim 4.63)
	(envelope-from <lists@nabble.com>)
	id 1L0aLf-0006co-V1
	for linux-mips@linux-mips.org; Thu, 13 Nov 2008 03:26:55 -0800
Message-ID: <20478996.post@talk.nabble.com>
Date:	Thu, 13 Nov 2008 03:26:55 -0800 (PST)
From:	krispa <krishnapavan@gmail.com>
To:	linux-mips@linux-mips.org
Subject: kernel dump in dev_change_flags
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Nabble-From: krishnapavan@gmail.com
Return-Path: <lists@nabble.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21276
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: krishnapavan@gmail.com
Precedence: bulk
X-list: linux-mips


Hello all

I am porting a virtual interface driver from 2.4 to 2.6 .

i was able to create a virtual interface successfully
using ioctl command i was able to create the interface. and was able to set
various parameters of
the interface , but when i try to bring up the interface i get the following
dump.

i tried locking using rtnl_lock and spin_lock_irqsave ...during that time
the system got hung ...
as of now i am using spin_lock for the critical region and get the following
dump.
can any one please suggest me how do i go about to resolve the issue.


Jan  1 00:02:57 localhost kernel: BUG: soft lockup detected on CPU#1!
Jan  1 00:02:57 localhost kernel: Call Trace:
Jan  1 00:02:57 localhost kernel: [<ffffffff81123570>] dump_stack+0x8/0x48
Jan  1 00:02:57 localhost kernel: [<ffffffff81187864>]
softlockup_tick+0x1c4/0x238
Jan  1 00:02:57 localhost kernel: [<ffffffff8115d6ac>]
update_process_times+0x44/0x98
Jan  1 00:02:57 localhost kernel: [<ffffffff81101644>]
octeon_main_timer_interrupt+0x194/0x1a0
Jan  1 00:02:57 localhost kernel: [<ffffffff81187fa0>]
handle_IRQ_event+0xf0/0x490
Jan  1 00:02:57 localhost kernel: [<ffffffff8118a430>]
handle_percpu_irq+0x98/0x118
Jan  1 00:02:57 localhost kernel: [<ffffffff81105550>]
plat_irq_dispatch+0x100/0x270
Jan  1 00:02:57 localhost kernel: [<ffffffff8111c3c0>] ret_from_irq+0x0/0x4
Jan  1 00:02:57 localhost kernel: [<ffffffff8143febc>] _spin_lock+0x6c/0xc0
Jan  1 00:02:57 localhost kernel: [<c0000000000b0cbc>] vif_open+0x84/0x3e8
[cavium_vidd]
Jan  1 00:02:57 localhost kernel: [<ffffffff81385b50>] dev_open+0x68/0xd8
Jan  1 00:02:57 localhost kernel: [<ffffffff813817cc>]
dev_change_flags+0x144/0x188
Jan  1 00:02:57 localhost kernel: [<c0000000000af774>]
vif_devinet_ioctl+0x2fc/0x8b8 [cavium_vidd]
Jan  1 00:02:57 localhost kernel: [<c0000000000aeb94>]
VIDD_ioctl+0x824/0xf70 [cavium_vidd]
Jan  1 00:02:57 localhost kernel: [<ffffffff813848e0>] dev_ioctl+0x320/0x560
Jan  1 00:02:57 localhost kernel: [<ffffffff8137221c>]
sock_ioctl+0x1bc/0x3f8
Jan  1 00:02:57 localhost kernel: [<ffffffff811cfbe0>] do_ioctl+0x40/0xd0
Jan  1 00:02:57 localhost kernel: [<ffffffff811cfcf0>] vfs_ioctl+0x80/0x3e8
Jan  1 00:02:57 localhost kernel: [<ffffffff811d012c>] sys_ioctl+0xd4/0x1b8
Jan  1 00:02:57 localhost kernel: [<ffffffff811277b4>]
syscall_trace_entry+0x78/0x98
Jan  1 00:02:57 localhost kernel:


-Thanks in advance
Krishna 
-- 
View this message in context: http://www.nabble.com/kernel-dump-in-dev_change_flags-tp20478996p20478996.html
Sent from the linux-mips main mailing list archive at Nabble.com.
