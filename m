Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 20 Dec 2005 05:31:36 +0000 (GMT)
Received: from sakura.staff.proxad.net ([213.228.1.107]:33202 "EHLO
	sakura.staff.proxad.net") by ftp.linux-mips.org with ESMTP
	id S8133351AbVLTFbS (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 20 Dec 2005 05:31:18 +0000
Received: from max by sakura.staff.proxad.net with local (Exim 3.36 #1 (Debian))
	id 1Eoa6m-0001cW-00
	for <linux-mips@linux-mips.org>; Tue, 20 Dec 2005 06:32:20 +0100
Subject: [PATCH] fix local_irq_save()/local_irq_restore() when
	CONFIG_CPU_MIPSR2 & CONFIG_IRQ_CPU
From:	Maxime Bizon <mbizon@freebox.fr>
To:	linux-mips@linux-mips.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date:	Tue, 20 Dec 2005 06:32:19 +0100
Message-Id: <1135056739.9874.95.camel@sakura.staff.proxad.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Return-Path: <mbizon@freebox.fr>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9694
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mbizon@freebox.fr
Precedence: bulk
X-list: linux-mips


Hello all,

I was unable to get my R4KECr2 board working with CONFIG_CPU_MIPSR2 &
CONFIG_IRQ_CPU, irq delivery is not working.

local_irq_restore() logic is to check that "flags" is non zero, and
enable irq accordingly.

But "flags" comes directly from di, which according to mips instruction
set, saves whole status content, not just IE bit.

Attached patch to fix this.


Signed-off-by: Maxime Bizon <mbizon@freebox.fr>

--- linux.git/include/asm-mips/interrupt.h.old	2005-12-20 06:20:44.000000000 +0100
+++ linux.git/include/asm-mips/interrupt.h	2005-12-20 06:21:02.000000000 +0100
@@ -93,6 +93,7 @@
 	"	.set	noat						\n"
 #ifdef CONFIG_CPU_MIPSR2
 	"	di	\\result					\n"
+	"	andi	\\result, 1					\n"
 #else
 	"	mfc0	\\result, $12					\n"
 	"	ori	$1, \\result, 1					\n"



Thanks,

-- 
Maxime
