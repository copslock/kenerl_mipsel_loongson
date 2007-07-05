Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 05 Jul 2007 14:30:10 +0100 (BST)
Received: from mba.ocn.ne.jp ([122.1.175.29]:26316 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S20023017AbXGENaF (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 5 Jul 2007 14:30:05 +0100
Received: from localhost (p8154-ipad202funabasi.chiba.ocn.ne.jp [222.146.79.154])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id 08EAC81A6; Thu,  5 Jul 2007 22:30:01 +0900 (JST)
Date:	Thu, 05 Jul 2007 22:30:50 +0900 (JST)
Message-Id: <20070705.223050.65192436.anemo@mba.ocn.ne.jp>
To:	linux-mips@linux-mips.org
Cc:	ralf@linux-mips.org
Subject: diffs between lmo and mainline
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
X-Fingerprint: 6ACA 1623 39BD 9A94 9B1A  B746 CA77 FE94 2874 D52F
X-Pgp-Public-Key: http://wwwkeys.pgp.net/pks/lookup?op=get&search=0x2874D52F
X-Mailer: Mew version 5.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <anemo@mba.ocn.ne.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15607
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

There are some commits in lmo which are not mainlined yet.
IMO the commit 4ecfa04... is the most critical one.


commit 87268cc40b143bdbe35d2e8f22e1ae6c359fe368
Author: Ralf Baechle <ralf@linux-mips.org>
Date:   Mon Jan 15 14:17:19 2007 +0000

    [MIPS] Malta: Fix SMTC crash on bootup with idebus= boot argument
    
    Signed-off-by: Ralf Baechle <ralf@linux-mips.org>

commit 92444ade23a0c40bfe429f68b48d3f8728ff3db0
Author: Ralf Baechle <ralf@linux-mips.org>
Date:   Tue Mar 20 15:22:53 2007 +0000

    [CHAR] Alchemy: Remove ADS7846 driver.
    
    With the makefile bits for this driver missing the config option has only
    been a dummy since the merge with 2.5.32 on 31 October 2002.  So I can
    only assume nobody cares anymore.
    
    Signed-off-by: Ralf Baechle <ralf@linux-mips.org>

commit e19e38a0945c3a79c8cb933ea463f6761678feb0
Author: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Date:   Tue May 1 01:49:20 2007 +0900

    [MIPS] Make resources for ds1742 "static __initdata"
    
    We can make resources for platform_device_register_simple() "static
    __initdata".
    
    Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
    Signed-off-by: Ralf Baechle <ralf@linux-mips.org>

commit fe03efaa0fc61f1a3f0570206f12c13518251a5c
Author: Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
Date:   Wed May 9 00:03:02 2007 +0900

    [MIPS] separate platform_device registration for VR41xx serial interface
    
    Signed-off-by: Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
    Signed-off-by: Ralf Baechle <ralf@linux-mips.org>

commit 959367f13931b88a1bf70b892d9ebf6ca43d7356
Author: Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
Date:   Thu May 10 22:21:35 2007 +0900

    [MIPS] Separate platform_device registration for VR41xx GPIO
    
    Signed-off-by: Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
    Signed-off-by: Ralf Baechle <ralf@linux-mips.org>

commit 9bef20296e185a7dccb1a11fde3d8c2d08ab224c
Author: Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
Date:   Fri May 11 21:18:48 2007 +0900

    [MIPS] separate platform_device registration for VR41xx RTC
    
    Signed-off-by: Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
    Signed-off-by: Ralf Baechle <ralf@linux-mips.org>

commit 540c3c90766d50d39eabdb217e426230bf2c8092
Author: Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
Date:   Mon May 21 23:00:38 2007 +0900

    [MIPS] remove unused definitions for Cobalt
    
    Signed-off-by: Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
    Signed-off-by: Ralf Baechle <ralf@linux-mips.org>

commit eea79ad66a55ceb346987e8052c54c122a3ce2b5
Author: Andrew Sharp <tigerand@gmail.com>
Date:   Fri Mar 23 12:15:18 2007 -0700

    [MIPS] 64-bit TO_PHYS_MASK macro for RM9000 processors
    
    Signed-off-by: Andrew Sharp <tigerand@gmail.com>
    Signed-off-by: Ralf Baechle <ralf@linux-mips.org>

commit 609df5dadf7cdd3ce8ff3823e261c2634e80da37
Author: Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
Date:   Mon May 28 22:56:35 2007 +0900

    [MIPS] Remove unused config entries
    
    Signed-off-by: Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
    Signed-off-by: Ralf Baechle <ralf@linux-mips.org>

commit 30debda95cacfc2b8b3088dec0f6a526dc7f29f1
Author: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Date:   Wed May 30 00:38:07 2007 +0900

    [MIPS] Simplify missing-syscalls for N32 and O32
    
    Use standard missing-syscalls with EXTRA_CFLAGS instead of duplicating
    the command.  And move the archprepare rule before the archclean rule.
    Suggested by Franck Bui-Huu.  Also add "echo" to show the target ABI.
    
    Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
    Signed-off-by: Ralf Baechle <ralf@linux-mips.org>

commit 3525f1d25c2cc5d2ae3827fff3305eb0a5a4972a
Author: Ralf Baechle <ralf@linux-mips.org>
Date:   Thu Jun 7 08:44:32 2007 +0100

    [MIPS] AP/SP: Avoid triggering the 34K E125 performance issue
    
    C0_status doesn't need to be initialized at this point anyway; the register
    will be initialized later.
    
    Signed-off-by: Ralf Baechle <ralf@linux-mips.org>

commit b0e05a32a745a6e3ec5203f28a6bc044653e411a
Author: Ralf Baechle <ralf@linux-mips.org>
Date:   Thu Jun 21 00:22:34 2007 +0100

    [MIPS] Fix scheduling latency issue on 24K, 34K and 74K cores
    
    The idle loop goes to sleep using the WAIT instruction if !need_resched().
    This has is suffering from from a race condition that if if just after
    need_resched has returned 0 an interrupt might set TIF_NEED_RESCHED but
    we've just completed the test so go to sleep anyway.  This would be
    trivial to fix by just disabling interrupts during that sequence as in:
    
            local_irq_disable();
            if (!need_resched())
                    __asm__("wait");
            local_irq_enable();
    
    but the processor architecture leaves it undefined if a processor calling
    WAIT with interrupts disabled will ever restart its pipeline and indeed
    some processors have made use of the freedom provided by the architecture
    definition.  This has been resolved and the Config7.WII bit indicates that
    the use of WAIT is safe on 24K, 24KE and 34K cores.  It also is safe on
    74K EA so enable the use of WAIT with interrupts disabled for all 74K
    cores.
    
    Signed-off-by: Ralf Baechle <ralf@linux-mips.org>

commit 4ecfa04bbe2d8a9add45bb09ade69af7eb21ba5c
Author: Chris Dearman <chris@mips.com>
Date:   Thu Jun 21 12:59:57 2007 +0100

    [MIPS] Fix timer/performance interrupt detection
    
    Signed-off-by: Chris Dearman <chris@mips.com>
    Signed-off-by: Ralf Baechle <ralf@linux-mips.org>

commit d4ab609936cb2f813503b7524229620991c583e4
Author: Ralf Baechle <ralf@linux-mips.org>
Date:   Tue Jun 26 20:19:00 2007 +0200

    [MIPS] Change libgcc-style functions from lib-y to obj-y
    
    Reported by Eugene Surovegin <ebs@ebshome.net>.
    
    If only modules were users of these functions they did not get linked into
    the kernel proper, so later module loads would fail as well.
    
    Signed-off-by: Ralf Baechle <ralf@linux-mips.org>


Note:

* QEMU VGA support is not in mainline but I cannot find a
  corresponding commit.

* The commit e19e38a... has been in mm tree.

* There are some diffs in arch/mips/kernel/trace.c but it might be
  intentional.

---
Atsushi Nemoto
