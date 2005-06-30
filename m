Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 30 Jun 2005 16:51:36 +0100 (BST)
Received: from pasta.sw.starentnetworks.com ([IPv6:::ffff:12.33.234.10]:18909
	"EHLO pasta.sw.starentnetworks.com") by linux-mips.org with ESMTP
	id <S8226092AbVF3PvS>; Thu, 30 Jun 2005 16:51:18 +0100
Received: from cortez.sw.starentnetworks.com (cortez.sw.starentnetworks.com [12.33.233.12])
	by pasta.sw.starentnetworks.com (Postfix) with ESMTP id 6B1D714B6F3
	for <linux-mips@linux-mips.org>; Thu, 30 Jun 2005 11:50:57 -0400 (EDT)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17092.5345.75666.403044@cortez.sw.starentnetworks.com>
Date:	Thu, 30 Jun 2005 11:50:57 -0400
From:	Dave Johnson <djohnson+linuxmips@sw.starentnetworks.com>
To:	linux-mips@linux-mips.org
Subject: preempt_schedule_irq missing from mfinfo[]?
X-Mailer: VM 7.07 under 21.4 (patch 6) "Common Lisp" XEmacs Lucid
Return-Path: <djohnson@sw.starentnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8263
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: djohnson+linuxmips@sw.starentnetworks.com
Precedence: bulk
X-list: linux-mips


Got this crash with recent 2.6 CVS version.

CONFIG_SMP and CONFIG_PREEMPT are both on.  This in on a sb1250 rev
B2.

The PC it was trying to lookup is in preempt_schedule_irq().  Without
preempt_schedule_irq in mfinfo[] it ended up with the wrong function
and then dereferenced a NULL FP.

Should this be in mfinfo or am I on the wrong track here?

#ifdef CONFIG_PREEMPT
	{ preempt_schedule_irq, 1 },
#endif


Also, __preempt_spin_lock and __preempt_write_lock are nowhere to be
found so I had to remove those from the table.



CPU 0 Unable to handle kernel paging request at virtual address 0000000000000018, epc == ffffffff801055ac, ra == ffffffff80105500
Oops in arch/mips/mm/fault.c::do_page_fault, line 167[#2]:
Cpu 0
$ 0   : 0000000000000000 0000000010001fe1 0000000000000018 0000000000000020
$ 4   : ffffffff80372708 0000000000000003 0000000000000000 0000000000000000
$ 8   : a80000013e69f6a0 0000000000000081 0000000000000001 ffffffffffffffff
$12   : 00000000000055e3 ffffffff80000010 ffffffff8018ffd0 0000000000000000
$16   : ffffffff803726b0 ffffffff8031f940 0000000000000000 ffffffff803726b8
$20   : ffffffff803726c0 0000000000102798 0000000000114d02 0000000000000000
$24   : 0000000000000000 000000002ac1adc8                                  
$28   : a800000000784000 a800000000787ba0 0000000000000000 ffffffff80105500
Hi    : 000000000037f629
Lo    : 000000000012a763
epc   : ffffffff801055ac get_wchan+0x144/0x168     Not tainted
ra    : ffffffff80105500 get_wchan+0x98/0x168
Status: 10001fe3    KX SX UX KERNEL EXL IE 
Cause : 00808008
BadVA : 0000000000000018
PrId  : 01040102
Modules linked in:
Process top (pid: 142, threadinfo=a800000000784000, task=a8000000007799a0)
Stack : 0000000000000001 a80000012a763000 a80000013d59e660 a8000000007786f8
        a8000000cfd15200 ffffffff801d3648 000000007fb8b4f0 a8000000062f3810
        000000007fb8b4f0 a8000000007786f8 ffffffff801cfee0 a800000000787e00
        a80000013d59e680 a8000000007786f8 a80000013d59fed8 a800000000787e00
        a800000000787c70 a8000000004be108 a800000000787c70 a80000013ed0a620
        ffffffff801b0a00 0000000000000000 a800000000787c70 0000000000000000
        a80000013d59e680 ffffffff801a4cb8 a8000000004be108 a80000013d59fed8
        01c5a71f00000004 a80000011e84400a a800000000787e00 a800000000787e00
        0000000000000000 a80000013fe86430 ffffffff801b0a00 00000000000001b6
        0000000000000000 a800000000787e00 0000000000000000 a800000000721b48
        ...
Call Trace:
 [<ffffffff801d3648>] do_task_stat+0x558/0x5f0
 [<ffffffff801cfee0>] task_dumpable+0x48/0x68
 [<ffffffff801b0a00>] dput+0x38/0x2f0
 [<ffffffff801a4cb8>] __link_path_walk+0x1048/0x1480
 [<ffffffff801b0a00>] dput+0x38/0x2f0
 [<ffffffff80182c58>] vma_adjust+0x220/0x410
 [<ffffffff801d3710>] proc_tgid_stat+0x10/0x20
 [<ffffffff801cf1a8>] proc_info_read+0xa0/0xe0
 [<ffffffff8018fd88>] vfs_read+0xf0/0x138
 [<ffffffff80190028>] sys_read+0x58/0xa0
 [<ffffffff80190000>] sys_read+0x30/0xa0
 [<ffffffff8011b3c0>] handle_sys+0x120/0x13c
 [<ffffffff8011b3c0>] handle_sys+0x120/0x13c
 [<ffffffff801c7e48>] compat_sys_fcntl64+0x0/0x1f0


Code: 000318f8  0052102d  0072182d <dc520000> dc710000  00000000  0c04ce78  0220
202d  1440ffdd 






-- 
Dave Johnson
Starent Networks
