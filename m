Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 03 Mar 2007 18:22:18 +0000 (GMT)
Received: from newmail.sw.starentnetworks.com ([12.33.234.78]:6790 "EHLO
	mail.sw.starentnetworks.com") by ftp.linux-mips.org with ESMTP
	id S20037592AbXCCSWN (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sat, 3 Mar 2007 18:22:13 +0000
Received: from zeus.sw.starentnetworks.com (zeus.sw.starentnetworks.com [12.33.233.46])
	by mail.sw.starentnetworks.com (Postfix) with ESMTP id 7A5543E38E
	for <linux-mips@linux-mips.org>; Sat,  3 Mar 2007 13:20:31 -0500 (EST)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17897.48239.366047.442797@zeus.sw.starentnetworks.com>
Date:	Sat, 3 Mar 2007 13:20:31 -0500
From:	Dave Johnson <djohnson+linux-mips@sw.starentnetworks.com>
To:	linux-mips@linux-mips.org
Subject: SMP+PREEMPT causes NULL dereference in khelper on startup
X-Mailer: VM 7.17 under 21.4 (patch 17) "Jumbo Shrimp" XEmacs Lucid
Return-Path: <djohnson@sw.starentnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14335
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: djohnson+linux-mips@sw.starentnetworks.com
Precedence: bulk
X-list: linux-mips


Sibyte 1250, tested on both A8 and B2 steppings.

Code is from linux-mips.org's git tree at 2.6.18 plus some patches
from 2.6.18.7.

I can boot fine with SMP, and I can boot fine with PREEMPT, but if I
turn on both, I get this crash during kernel startup every time.

For another datapoint, I changed plat_smp_setup() to only bring online
1 core.  Just building with SMP+PREEMPT (running on a single core) is
enough to cause the problem.


CPU 0 Unable to handle kernel paging request at virtual address 0000000000000000, epc == ffffffff80154fa8, ra == ffffffff8013d508
Oops[#1]:
Cpu 0
$ 0   : 0000000000000000 0000000014001fe0 0000000000000000 0000000000000000
$ 4   : 0000000000000000 a8000000cffd3688 0000000000000001 000000000000000c
$ 8   : a8000000007b1f88 0000000000000000 0000000000000000 0000000000000000
$12   : 0000000000000008 ffffffff80284188 0000000000000000 0000000000000000
$16   : a80000000fea0cc0 ffffffff80154f78 ffffffff80586618 a800000007fee1a0
$20   : ffffffff8054f000 ffffffff80131b30 0000000000000000 ffffffff80285210
$24   : 0000000000000000 0000000000000000 a80000000fea0cc0 a80000000fea2160
$28   : a800000008990000 a800000008993ea0 ffffffff80269c70 ffffffff8013d508
Hi    : 0000000000000000
Lo    : 0000000000000000
epc   : ffffffff80154fa8 detach_pid+0x30/0x90     Not tainted
ra    : ffffffff8013d508 __unhash_process+0xf8/0x158
Status: 14001fe2    KX SX UX KERNEL EXL 
Cause : 9080800c
BadVA : 0000000000000000
PrId  : 01040102
Modules linked in:
Process khelper (pid: 12, threadinfo=a800000008990000, task=a80000000fea0cc0)
Stack : ffffffff8013d508 ffffffff803d24c8 a8000000007b1d20 a80000000fea0cc0
        a800000007fef1a8 ffffffff8013d690 a80000000fea0cc0 a80000000fea1980
        0000000000000000 0000000000000020 ffffffff8013d8a8 a80000000fea1980
        a800000008993f20 a80000000fea1980 a80000000fea0cc0 ffffffff8013ef58
        a800000008993f20 a800000008993f20 0000000000000000 a80000000fea0cc0
        ffffffff80131c68 ffffffff803cfd40 ffffffff8012ecd8 ffffffff8013f6c0
        0000000000000000 0000000000000000 a800000083a23d68 0000000000000000
        0000000000000000 0000000000000000 0000000000000000 0000000000000000
        0000000000000000 0000000000000000 0000000000000000 ffffffff80153058
        0000000000000000 ffffffff80106448 0000000000000000 ffffffff80106438
        ...
Call Trace:
[<ffffffff80154fa8>] detach_pid+0x30/0x90
[<ffffffff8013d508>] __unhash_process+0xf8/0x158
[<ffffffff8013d690>] __exit_signal+0x128/0x228
[<ffffffff8013d8a8>] release_task+0xb8/0x1a8
[<ffffffff8013ef58>] exit_notify+0x220/0x408
[<ffffffff8013f6c0>] do_exit+0x580/0x8c8
[<ffffffff80153058>] wait_for_helper+0x0/0xb0
Code: dc820178  dca30008  dca40010 <10400002> fc620000  fc430008  3c020020  34420200  fca00010 
Kernel panic - not syncing: Fatal exception


Disassembly shows:

ffffffff80154f78 <detach_pid>:
ffffffff80154f78:       0005283c        dsll32  a1,a1,0x0
ffffffff80154f7c:       67bdfff0        daddiu  sp,sp,-16

ffffffff80154f80 <$LCFI28>:
ffffffff80154f80:       0005283e        dsrl32  a1,a1,0x0
ffffffff80154f84:       ffbf0000        sd      ra,0(sp)

ffffffff80154f88 <$LCFI29>:
ffffffff80154f88:       00051078        dsll    v0,a1,0x1
ffffffff80154f8c:       0045102d        daddu   v0,v0,a1
ffffffff80154f90:       000210f8        dsll    v0,v0,0x3
ffffffff80154f94:       0082202d        daddu   a0,a0,v0
ffffffff80154f98:       64850178        daddiu  a1,a0,376      <<< a1 = a8000000cffd3688 => link

ffffffff80154f9c <$LBB73>:
ffffffff80154f9c:       dc820178        ld      v0,376(a0)     <<< v0 = 0000000000000000 => link->node->next
ffffffff80154fa0:       dca30008        ld      v1,8(a1)       <<< v1 = 0000000000000000 => link->node->ppriv

ffffffff80154fa4 <$LBE73>:
ffffffff80154fa4:       dca40010        ld      a0,16(a1)      <<< a0 = 0000000000000000 => pid

ffffffff80154fa8 <$LBB76>:
ffffffff80154fa8:       10400002        beqz    v0,ffffffff80154fb4 <$L166>
ffffffff80154fac:       fc620000        sd      v0,0(v1)       <<< '*pprev = next' => BOOM!
ffffffff80154fb0:       fc430008        sd      v1,8(v0)
[...]

It appears a0 to detach_pid (*task) points to somewhere wrong as
'link' (now in a1) is a valid pointer, but points to a bunch of
zeros.


-- 
Dave Johnson
Starent Networks
