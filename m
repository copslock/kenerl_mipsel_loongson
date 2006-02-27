Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 27 Feb 2006 22:57:15 +0000 (GMT)
Received: from w099.z064220152.sjc-ca.dsl.cnc.net ([64.220.152.99]:27860 "EHLO
	duck.specifix.com") by ftp.linux-mips.org with ESMTP
	id S8133513AbWB0W5F (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 27 Feb 2006 22:57:05 +0000
Received: from [127.0.0.1] (duck.corp.specifix.com [192.168.1.1])
	by duck.specifix.com (Postfix) with ESMTP id 93D5CFC77
	for <linux-mips@linux-mips.org>; Mon, 27 Feb 2006 15:04:38 -0800 (PST)
Subject: bcm1480 doubled process accounting times
From:	James E Wilson <wilson@specifix.com>
To:	linux-mips@linux-mips.org
Content-Type: multipart/mixed; boundary="=-e+AEUvUxNwuRV6Csdt8I"
Message-Id: <1141081478.9097.42.camel@aretha.corp.specifix.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date:	Mon, 27 Feb 2006 15:04:38 -0800
Return-Path: <wilson@specifix.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10667
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wilson@specifix.com
Precedence: bulk
X-list: linux-mips


--=-e+AEUvUxNwuRV6Csdt8I
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Running a UP kernel on a bcm1480 board, I get nonsensical timing
results, like this:
release@unknown:~/tmp$ time ./a.out
real    0m22.906s
user    0m45.792s
sys     0m0.010s
According to my watch, this program took 23 seconds to run, so the real
time clock is OK.  It is process accounting that is broken.

I tracked this down to a problem with the function
bcm1480_timer_interrupt in the file sibyte/bcm1480/time.c.  This
function calls ll_timer_interrupt for cpu0, and ll_local_timer_interrupt
for all cpus.  However, both of these functions do process accounting. 
Thus processes running on cpu0 end up with doubled times.  This is very
obvious in a UP kernel where all processes run on cpu0.

The correct way to do this is to only call ll_local_timer interrupt if
this is not cpu0.  This can be seen in the mips-board/generic/time.c
file, and also in the sibyte/sb1250/time.c file, both of which handle
this correctly.  I fixed the bcm1480/time.c file by copying over the
correct code from the sb1250/time.c file.

With this fix, I now get sensible results.
release@unknown:~/tmp$ time ./a.out
real    0m22.903s
user    0m22.894s
sys     0m0.006s
-- 
Jim Wilson, GNU Tools Support, http://www.specifix.com

--=-e+AEUvUxNwuRV6Csdt8I
Content-Disposition: attachment; filename=patch.double.time
Content-Type: text/x-patch; name=patch.double.time; charset=UTF-8
Content-Transfer-Encoding: 7bit

diff --git a/arch/mips/sibyte/bcm1480/setup.c b/arch/mips/sibyte/bcm1480/setup.c
diff --git a/arch/mips/sibyte/bcm1480/time.c b/arch/mips/sibyte/bcm1480/time.c
index e545752..efaf83e 100644
--- a/arch/mips/sibyte/bcm1480/time.c
+++ b/arch/mips/sibyte/bcm1480/time.c
@@ -110,17 +110,18 @@ void bcm1480_timer_interrupt(struct pt_r
 	__raw_writeq(M_SCD_TIMER_ENABLE|M_SCD_TIMER_MODE_CONTINUOUS,
 	      IOADDR(A_SCD_TIMER_REGISTER(cpu, R_SCD_TIMER_CFG)));
 
-	/*
-	 * CPU 0 handles the global timer interrupt job
-	 */
 	if (cpu == 0) {
+		/*
+		 * CPU 0 handles the global timer interrupt job
+		 */
 		ll_timer_interrupt(irq, regs);
 	}
-
-	/*
-	 * every CPU should do profiling and process accouting
-	 */
-	ll_local_timer_interrupt(irq, regs);
+	else {
+		/*
+		 * other CPUs should just do profiling and process accounting
+		 */
+		ll_local_timer_interrupt(irq, regs);
+	}
 }
 
 /*

--=-e+AEUvUxNwuRV6Csdt8I--
