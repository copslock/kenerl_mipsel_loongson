Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 17 Jul 2007 13:27:14 +0100 (BST)
Received: from localhost.localdomain ([127.0.0.1]:9888 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20021479AbXGQM1M (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 17 Jul 2007 13:27:12 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.14.1/8.13.8) with ESMTP id l6HCRCft020428;
	Tue, 17 Jul 2007 13:27:12 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id l6HCRBgh020427;
	Tue, 17 Jul 2007 13:27:11 +0100
Date:	Tue, 17 Jul 2007 13:27:11 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Sergey Rogozhkin <rogozhkin@niisi.msk.ru>
Cc:	Linux MIPS List <linux-mips@linux-mips.org>,
	"Gleb O. Raiko" <raiko@niisi.msk.ru>, Kumba <kumba@gentoo.org>
Subject: Re: O2 RM7000 Issues
Message-ID: <20070717122711.GA19977@linux-mips.org>
References: <4687DCE2.8070302@gentoo.org> <468825BE.6090001@gmx.net> <50451.70.107.91.207.1183381723.squirrel@webmail.wesleyan.edu> <20070704152729.GA2925@linux-mips.org> <20070704192208.GA7873@linux-mips.org> <469C8600.7090208@niisi.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <469C8600.7090208@niisi.msk.ru>
User-Agent: Mutt/1.5.14 (2007-02-12)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15791
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, Jul 17, 2007 at 01:04:00PM +0400, Sergey Rogozhkin wrote:

> >for E9000 platforms.
> 
> Are you really sure RM7000 has this bug? Workaround mentioned above 
> breaks gcc signal frame unwinding mechanism: it search for sigcontext 
> struct at fixed offset from signal trampoline.
> 
> And one another known RM7000 bug, maybe not taken into account by linux: 
> errata 38. r4k_wait is not suitable for RM7000 on some systems. I don't 
> know if "O2" is affected.

The fingerprint of this bug would be write data getting corrupted to
contain its physical address instead.  I haven't seen such bug reports
ever but a hand full cycles of latency to the idle loop sounds like the
safe thing.  Untested fix below.

What's really astonishing about this is that affects basically the entire
QED family of processors - R4600, R4700, R4640, R5000, RM52xx and RM7000.

Which also is yet again empirical proof for the WAIT instruction being
hard to get right ...

  Ralf

Signed-off-by: Ralf Baechle <ralf@linux-mips.org>

diff --git a/arch/mips/kernel/cpu-probe.c b/arch/mips/kernel/cpu-probe.c
index f599e79..7ee0cb0 100644
--- a/arch/mips/kernel/cpu-probe.c
+++ b/arch/mips/kernel/cpu-probe.c
@@ -75,6 +75,26 @@ static void r4k_wait_irqoff(void)
 	local_irq_enable();
 }
 
+/*
+ * The RM7000 variant has to handle erratum 38.  The workaround is to not
+ * have any pending stores when the WAIT instruction is executed.
+ */
+static void rm7k_wait_irqoff(void)
+{
+	local_irq_disable();
+	if (!need_resched())
+		__asm__(
+		"	.set	push		\n"
+		"	.set	mips3		\n"
+		"	.set	noat		\n"
+		"	mfc0	$1, $12		\n"
+		"	sync			\n"
+		"	mtc0	$1, $12		\n"
+		"	wait			\n"
+		"	.set	pop		\n");
+	local_irq_enable();
+}
+
 /* The Au1xxx wait is available only if using 32khz counter or
  * external timer source, but specifically not CP0 Counter. */
 int allow_au1k_wait;
@@ -132,7 +152,6 @@ static inline void check_wait(void)
 	case CPU_R4700:
 	case CPU_R5000:
 	case CPU_NEVADA:
-	case CPU_RM7000:
 	case CPU_4KC:
 	case CPU_4KEC:
 	case CPU_4KSC:
@@ -142,6 +161,10 @@ static inline void check_wait(void)
 		cpu_wait = r4k_wait;
 		break;
 
+	case CPU_RM7000:
+		cpu_wait = rm7k_wait_irqoff;
+		break;
+
 	case CPU_24K:
 	case CPU_34K:
 		cpu_wait = r4k_wait;
