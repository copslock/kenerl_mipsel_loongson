Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 10 Feb 2006 23:12:57 +0000 (GMT)
Received: from mms3.broadcom.com ([216.31.210.19]:26117 "EHLO
	MMS3.broadcom.com") by ftp.linux-mips.org with ESMTP
	id S8133596AbWBJXMs convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 10 Feb 2006 23:12:48 +0000
Received: from 10.10.64.154 by MMS3.broadcom.com with ESMTP (Broadcom
 SMTP Relay (Email Firewall v6.2.0)); Fri, 10 Feb 2006 15:19:53 -0800
X-Server-Uuid: B238DE4C-2139-4D32-96A8-DD564EF2313E
Received: by mail-irva-10.broadcom.com (Postfix, from userid 47) id
 1DFF32AF; Fri, 10 Feb 2006 15:18:28 -0800 (PST)
Received: from mail-irva-8.broadcom.com (mail-irva-8 [10.10.64.221]) by
 mail-irva-10.broadcom.com (Postfix) with ESMTP id 09C432AE for
 <linux-mips@linux-mips.org>; Fri, 10 Feb 2006 15:18:28 -0800 (PST)
Received: from mail-sj1-12.sj.broadcom.com (mail-sj1-12.sj.broadcom.com
 [10.16.128.215]) by mail-irva-8.broadcom.com (MOS 3.7.3a-GA) with ESMTP
 id CXB42215; Fri, 10 Feb 2006 15:18:20 -0800 (PST)
Received: from NT-SJCA-0750.brcm.ad.broadcom.com (nt-sjca-0750
 [10.16.192.220]) by mail-sj1-12.sj.broadcom.com (Postfix) with ESMTP id
 E809B20502 for <linux-mips@linux-mips.org>; Fri, 10 Feb 2006 15:18:20
 -0800 (PST)
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Subject: Tracking down exception in sched.c
Date:	Fri, 10 Feb 2006 15:18:20 -0800
Message-ID: <7E000E7F06B05C49BDBB769ADAF44D0773A636@NT-SJCA-0750.brcm.ad.broadcom.com>
Thread-Topic: Tracking down exception in sched.c
Thread-Index: AcYumEe7z+axQZsxS5qat6rWn3Q4Xg==
From:	"Mark E Mason" <mark.e.mason@broadcom.com>
To:	linux-mips@linux-mips.org
X-TMWD-Spam-Summary: SEV=1.1; DFV=A2006021009; IFV=2.0.6,4.0-7;
 RPD=4.00.0004;
 RPDID=303030312E30413039303230312E34334544314436362E303038312D412D;
 ENG=IBF; TS=20060210231957; CAT=NONE; CON=NONE;
X-MMS-Spam-Filter-ID: A2006021009_4.00.0004_2.0.6,4.0-7
X-WSS-ID: 6FF3C01341W9078334-01-01
Content-Type: text/plain;
 charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-Path: <mark.e.mason@broadcom.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10399
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mark.e.mason@broadcom.com
Precedence: bulk
X-list: linux-mips

[Cross-posted from LKML]
 
Hello all,
 
Working from the linux-mip.org repository (which just recently merged
from the kernel.org repository), we've been getting exceptions on
several different processors due to NULL pointer dereferences in
sched.c.  These happen on SMP systems only (but both 32 and 64-bit
systems trigger this problem).
 
The Oops output and surrounding text (w/ backtrace) is below.  What I've
traced is down to so far is that enqueue_task() gets called with a ready
queue (rq) where (rq->active == NULL).

Backtracing a bit, the following patch triggers an earlier, slightly
more controlled failure:

[mason@hawaii linux.git]$ git diff kernel/sched.c diff --git
a/kernel/sched.c b/kernel/sched.c
--- a/kernel/sched.c
+++ b/kernel/sched.c
@@ -1264,6 +1264,7 @@ static int try_to_wake_up(task_t *p, uns  #endif

        rq = task_rq_lock(p, &flags);
+       BUG_ON(rq->active == NULL);
        old_state = p->state;
        if (!(old_state & state))
                goto out;


My question is, is the above assert valid (ie. Should rq->active always
be non-NULL at this point)?  It seems like it should be, but I'm pretty
new to this code, and thought I should double-check before going off
into the weeds.

If anyone has any ideas about where specifically to look for the
underlying problem, I'd appreciate it.

Thanks (very much) in advance,
Mark Mason
mason@broadcom.com
Newberg, Oregon
 
CPU revision is: 03040102
Primary instruction cache 32kB, 4-way, linesize 32 bytes.
Primary data cache 32kB, 4-way, linesize 32 bytes.
Synthesized TLB refill handler (40 instructions).
CPU 0 Unable to handle kernel paging request at virtual address
0000000000000028, epc == ffffffff80129840, ra == ffffffff8010Oops[#1]:
Cpu 0
$ 0   : 0000000000000000 ffffffff804202e0 0000000000000020
0000000000000000
$ 4   : a80000000fe00668 0000000000000000 0000000000000000
0000000000000001
$ 8   : ffffffff80427da0 ffffffff8fef7bc0 ffffffff803ef108
0000000000000000
$12   : ffffffffffffffff ffffffff8024e048 a80000000fe97630
ffffffffffffffff
$16   : 0000000000000000 a80000000fe00668 a800000001385ca0
0000000000000000
$20   : 0000000000000000 a800000001385ca0 0000000000000001
ffffffff804202e0
$24   : 0000000000000000 ffffffff8fe9e3cc
$28   : a80000000fe04000 a80000000fe07e20 a80000000fe07e30
ffffffff80129cc0
Hi    : 00000000000026cc
Lo    : cccccccccc6f7000
epc   : ffffffff80129840 enqueue_task+0x18/0x88     Not tainted
ra    : ffffffff80129cc0 activate_task+0xe0/0x158
Status: 14001fe2    KX SX UX KERNEL EXL
Cause : 00808008
BadVA : 0000000000000028
PrId  : 01040102
Modules linked in:
Process swapper (pid: 1, threadinfo=a80000000fe04000,
task=a80000000fe018c8) Stack : a80000000fe07e30 ffffffff80427400
a800000001385ca0 ffffffff804202e0
        a80000000fe00668 0000000000000001 a80000000fe07e60
ffffffff8012ae80
        0000000014001fe1 0000000000000000 0000000000000000
0000000000000000
        ffffffffffffffff 000000000000000f 0000000000000000
ffffffffffffffff
        ffffffff803a6dc8 0000000000000001 0000000000000001
ffffffff80427d78
        0000000000000000 0000000000000000 0000000000000000
0000000000000000
        a80000000fe07ef0 ffffffff80130dd0 a80000000fe24000
a80000000fe27fe0
        ffffffff803a6dc8 0000000000000001 0000000000000002
ffffffff80427d78
        0000000000000000 0000000000000000 0000000000000000
0000000000000000
        0000000000000000 ffffffff8014c768 0000000000000001
0000000000000001
        ...
Call Trace:
 [<ffffffff8012ae80>] try_to_wake_up+0x530/0x600  [<ffffffff80130dd0>]
migration_call+0x210/0x228  [<ffffffff8014c768>]
notifier_call_chain+0x38/0x78  [<ffffffff8015c404>] cpu_up+0x13c/0x1c8
[<ffffffff80100cf0>] init+0x810/0xb20  [<ffffffff80100568>]
init+0x88/0xb20  [<ffffffff80104c40>] kernel_thread_helper+0x10/0x18
[<ffffffff80104c30>] kernel_thread_helper+0x0/0x18
 

 
