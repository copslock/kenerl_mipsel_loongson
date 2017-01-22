Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 23 Jan 2017 00:28:58 +0100 (CET)
Received: from resqmta-ch2-05v.sys.comcast.net ([IPv6:2001:558:fe21:29:69:252:207:37]:57107
        "EHLO resqmta-ch2-05v.sys.comcast.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992029AbdAVX2vit-sE (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 23 Jan 2017 00:28:51 +0100
Received: from resomta-ch2-02v.sys.comcast.net ([69.252.207.98])
        by resqmta-ch2-05v.sys.comcast.net with SMTP
        id VRYscBmMEGIG7VRZ3cm6NK; Sun, 22 Jan 2017 23:28:49 +0000
Received: from [192.168.1.13] ([73.201.78.97])
        by resomta-ch2-02v.sys.comcast.net with SMTP
        id VRZ1clq33xPkAVRZ2csMoL; Sun, 22 Jan 2017 23:28:49 +0000
To:     Linux/MIPS <linux-mips@linux-mips.org>
From:   Joshua Kinard <kumba@gentoo.org>
Subject: gcc-6.3.x miscompiling code for IP27?
Message-ID: <ee417407-6877-f49c-5893-f3b3dbc2d103@gentoo.org>
Date:   Sun, 22 Jan 2017 18:28:44 -0500
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.5.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfN6yHsYzCbKnHyuyLegV5ZWrwaTR/BHdbpnyaQSU5/M15KmDh50uduUMWONXqk0XB8YTW3/uh4Eu5rRPKSKN8pNXnwp/e2nP5pjsq+c9D74JraFzgTUG
 7Y0R4Q9Lbj9YI60qgGKvZr1frYhUSwrZYTmLoE2/qzTmKXbMZuQDS0dJ
Return-Path: <kumba@gentoo.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56459
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kumba@gentoo.org
Precedence: bulk
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-Id: linux-mips <linux-mips.eddie.linux-mips.org>
X-List-ID: linux-mips <linux-mips.eddie.linux-mips.org>
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
X-list: linux-mips

I think I've run into a really odd gcc-6.3.x miscompile bug here on IP27.
But I'm not sure.  I've reproduced the issue on 4.9.5, 4.8.17, and now
4.7.10 (which I KNOW should boot).  If I recompile the same 4.7.10 kernel
with gcc-5.4.0, though, it boots as expected.  The fault appears to be in
the assembly for _raw_spin_lock_irq.

This is the Oops message that I get:

[    0.918286] Checking for the daddi bug... no.
[    0.973207] CPU 0 Unable to handle kernel paging request at virtual address 0000000000000000, epc == a8000000006b4eb4, ra == a8000000006b4eac
[    1.124206] Oops[#1]:
[    1.151460] CPU: 0 PID: 4 Comm: kworker/0:0 Not tainted 4.7.10-mipsgit-20160806 #1
[    1.242577] task: a8000000fe694a80 ti: a8000000fe6b8000 task.ti: a8000000fe6b8000
[    1.332616] $ 0   : 0000000000000000 ffffffff94005ce0 0000000000010000 0000000000000001
[    1.428969] $ 4   : 0000000000000000 a8000000fe694a80 ffffffff94005ce0 ffffffffffff00fe
[    1.525323] $ 8   : 0000000000000000 000000003a00da40 0000000000000000 00000000002f4a24
[    1.621677] $12   : a8000000fe6bbfe0 0000000000005c00 a8000000006c5cc8 0000000000000001
[    1.718032] $16   : 0000000000000000 a80000000201c300 0000000000000000 a80000000201c320
[    1.814388] $20   : 0000000000000000 a800000000841690 0000000000000000 a8000000fe010100
[    1.910742] $24   : 00000000fa83b2da a8000000000895c0
[    2.007098] $28   : a8000000fe6b8000 a8000000fe6bbda0 0000000000000000 a8000000006b4eac
[    2.103455] Hi    : 0000000000000000
[    2.146395] Lo    : 00103a8f6265ed12
[    2.189417] epc   : a8000000006b4eb4 _raw_spin_lock_irq+0x24/0x58
[    2.262660] ra    : a8000000006b4eac _raw_spin_lock_irq+0x1c/0x58
[    2.335962] Status: 94005ce2 KX SX UX KERNEL EXL
[    2.392521] Cause : 00008008 (ExcCode 02)
[    2.440698] BadVA : 0000000000000000
[    2.483640] PrId  : 00000f14 (R14000)
[    2.527636] Process kworker/0:0 (pid: 4, threadinfo=a8000000fe6b8000, task=a8000000fe694a80, tls=0000000000000000)
[    2.652258] Stack : 0000000000000000 a8000000000676b0 a800000000870000 a800000000870000
          0000000000000000 a8000000007de7f0 a8000001fc669e00 a8000000007e0000
          a8000000008e0000 a8000000fe047300 0000000000000000 a800000000841690
          0000000000000000 a8000000fe010100 0000000000000000 a80000000006ff00
          0000000000000000 0000000000000000 a8000000fe047300 0000000000000000
          0000000000000000 a8000000fe6bbe48 a8000000fe6bbe48 0000000000000000
          0000000000000000 a8000000fe6bbe68 a8000000fe6bbe68 a8000000fe696880
          a80000000006fdf0 a8000001fc669e00 a8000000fe696880 a8000000fe695480
          0000000000000000 a800000000024c08 0000000000000000 0000000000000000
          0000000000000000 0000000000000000 0000000000000000 0000000000000000
          ...
[    3.435669] Call Trace:
[    3.465003] [<a8000000006b4eb4>] _raw_spin_lock_irq+0x24/0x58
[    3.534172] [<a8000000000676b0>] worker_thread+0x2e8/0x760
[    3.600120] [<a80000000006ff00>] kthread+0x110/0x128
[    3.659827] [<a800000000024c08>] ret_from_kernel_thread+0x14/0x1c
[    3.733110]
[    3.750915]
Code: 00808025  bfb40000  3c020001 <c2030000> 00622021  e2040000  1080fffc  00032402  3063ffff
[    3.870390] ---[ end trace e2bb2e115aef4a1e ]---
[    3.925864] Kernel panic - not syncing: Fatal exception
[    3.988706] Reboot started from CPU 0


Here's the disassembled code for a 4.7.10 kernel built with gcc-6.3.0 for
IP27:
    a8000000006b4e90 <_raw_spin_lock_irq>:
    a8000000006b4e90:	bfb40000 	cache	0x14,0(sp)
    a8000000006b4e94:	ffa0bff0 	sd	zero,-16400(sp)
    a8000000006b4e98:	67bdfff0 	daddiu	sp,sp,-16
    a8000000006b4e9c:	ffb00000 	sd	s0,0(sp)
    a8000000006b4ea0:	ffbf0008 	sd	ra,8(sp)
    a8000000006b4ea4:	0c0eca58 	jal	a8000000003b2960 <arch_local_irq_disable>
    a8000000006b4ea8:	00808025 	move	s0,a0
    a8000000006b4eac:	bfb40000 	cache	0x14,0(sp)
    a8000000006b4eb0:	3c020001 	lui	v0,0x1
    a8000000006b4eb4:	c2030000 	ll	v1,0(s0)
    a8000000006b4eb8:	00622021 	addu	a0,v1,v0
    a8000000006b4ebc:	e2040000 	sc	a0,0(s0)
    a8000000006b4ec0:	1080fffc 	beqz	a0,a8000000006b4eb4 <_raw_spin_lock_irq+0x24>
    a8000000006b4ec4:	00032402 	srl	a0,v1,0x10
    a8000000006b4ec8:	3063ffff 	andi	v1,v1,0xffff
    a8000000006b4ecc:	14640161 	bne	v1,a0,a8000000006b5454 <_raw_write_unlock_irqrestore+0x7c>
    a8000000006b4ed0:	00831823 	subu	v1,a0,v1
    a8000000006b4ed4:	dfbf0008 	ld	ra,8(sp)
    a8000000006b4ed8:	dfb00000 	ld	s0,0(sp)
    a8000000006b4edc:	03e00008 	jr	ra
    a8000000006b4ee0:	67bd0010 	daddiu	sp,sp,16
    a8000000006b4ee4:	00000000 	nop


And here's the same kernel tree rebuilt with gcc-5.4.0 for IP27:
    a8000000006a7198 <_raw_spin_lock_irq>:
    a8000000006a7198:	67bdfff0 	daddiu	sp,sp,-16
    a8000000006a719c:	ffb00000 	sd	s0,0(sp)
    a8000000006a71a0:	ffbf0008 	sd	ra,8(sp)
    a8000000006a71a4:	0c0eac00 	jal	a8000000003ab000 <arch_local_irq_disable>
    a8000000006a71a8:	00808025 	move	s0,a0
    a8000000006a71ac:	bfb40000 	cache	0x14,0(sp)
    a8000000006a71b0:	3c020001 	lui	v0,0x1
    a8000000006a71b4:	c2030000 	ll	v1,0(s0)
    a8000000006a71b8:	00622021 	addu	a0,v1,v0
    a8000000006a71bc:	e2040000 	sc	a0,0(s0)
    a8000000006a71c0:	1080fffc 	beqz	a0,a8000000006a71b4 <_raw_spin_lock_irq+0x1c>
    a8000000006a71c4:	00032402 	srl	a0,v1,0x10
    a8000000006a71c8:	3063ffff 	andi	v1,v1,0xffff
    a8000000006a71cc:	14640156 	bne	v1,a0,a8000000006a7728 <_raw_write_unlock_irqrestore+0x78>
    a8000000006a71d0:	00831823 	subu	v1,a0,v1
    a8000000006a71d4:	dfbf0008 	ld	ra,8(sp)
    a8000000006a71d8:	dfb00000 	ld	s0,0(sp)
    a8000000006a71dc:	03e00008 	jr	ra
    a8000000006a71e0:	67bd0010 	daddiu	sp,sp,16
    a8000000006a71e4:	00000000 	nop


The failing instruction is the "ll v1,0(s0)" bit, so it looks like register
s0 is getting clobbered.  The only visible differences between these two
assembly fragments is the addition of these two assembler instructions at
the very top:
    cache  0x14,0(sp)
    sd     zero,-16400(sp)

Looking at the git source for arch/mips/include/asm/spinlock.h, nothing has
changed for this region of code recently, so this looks very much like an
issue in gcc-6.3 itself.  I cannot reproduce this problem on my SGI Octane.
It's been running a 4.8-series kernel for over a month now compiling new
Gentoo stages.  So I can't rule out a bug in the new IP27 code I'm using,
but I am kinda doubting that.

Does anyone have any ideas I can look into?  I'll start digging through
gcc-6.3's source to see if I can figure out why these two extra
instructions are being generated for hard-coded assembly.  I suspect that's
the fault here.  Although why it only seems to affect IP27 is unknown to me
at the moment.

-- 
Joshua Kinard
Gentoo/MIPS
kumba@gentoo.org
6144R/F5C6C943 2015-04-27
177C 1972 1FB8 F254 BAD0 3E72 5C63 F4E3 F5C6 C943

"The past tempts us, the present confuses us, the future frightens us.  And
our lives slip away, moment by moment, lost in that vast, terrible in-between."

--Emperor Turhan, Centauri Republic
