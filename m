Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 13 Oct 2004 10:21:11 +0100 (BST)
Received: from the-doors.enix.org ([IPv6:::ffff:62.210.169.120]:46568 "EHLO
	the-doors.enix.org") by linux-mips.org with ESMTP
	id <S8225218AbUJMJVE>; Wed, 13 Oct 2004 10:21:04 +0100
Received: by the-doors.enix.org (Postfix, from userid 1105)
	id 7BBF71F297; Wed, 13 Oct 2004 11:20:57 +0200 (CEST)
Date: Wed, 13 Oct 2004 11:20:57 +0200
From: Thomas Petazzoni <thomas.petazzoni@enix.org>
To: linux-mips@linux-mips.org
Cc: mentre@tcl.ite.mee.com
Subject: Compilation fails with CONFIG_DEBUG_SPINLOCK
Message-ID: <20041013092057.GQ11236@enix.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
Return-Path: <thomas@the-doors.enix.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6023
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: thomas.petazzoni@enix.org
Precedence: bulk
X-list: linux-mips

Hello,

With the last CVS, if you check CONFIG_DEBUG_SPINLOCK, the compilation
fails :

arch/mips/kernel/built-in.o(.text+0x2e84): In function `probe_irq_on':
: undefined reference to `atomic_lock'
arch/mips/kernel/built-in.o(.text+0x2e88): In function `probe_irq_on':
: undefined reference to `atomic_lock'
arch/mips/kernel/built-in.o(.text+0x2e90): In function `probe_irq_on':
: undefined reference to `atomic_lock'
arch/mips/kernel/built-in.o(.text+0x2e94): In function `probe_irq_on':
: undefined reference to `atomic_lock'
arch/mips/kernel/built-in.o(.text+0x2ebc): In function `probe_irq_on':
: undefined reference to `atomic_lock'
arch/mips/kernel/built-in.o(.text+0x2ec0): more undefined references
to `atomic_lock' follow
make: *** [.tmp_vmlinux1] Error 1

Some macros in include/asm/atomic.h uses a spinlock called
atomic_lock. An "extern" definition is made at the top of the file,
but the real spinlock is not defined anywhere.

I think this is trivial to fix, but I'm not sure what is the right
place to declare the spin lock and to initialize it.

Thomas
-- 
PETAZZONI Thomas - thomas.petazzoni@enix.org 
http://thomas.enix.org - Jabber: kos_tom@sourcecode.de
KOS: http://kos.enix.org/ - Lolut: http://lolut.utbm.info
Fingerprint : 0BE1 4CF3 CEA4 AC9D CC6E  1624 F653 CB30 98D3 F7A7
