Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 27 Mar 2009 11:39:33 +0000 (GMT)
Received: from gw03.mail.saunalahti.fi ([195.197.172.111]:43915 "EHLO
	gw03.mail.saunalahti.fi") by ftp.linux-mips.org with ESMTP
	id S20021288AbZC0Lj0 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 27 Mar 2009 11:39:26 +0000
Received: from localhost.localdomain (a88-114-245-69.elisa-laajakaista.fi [88.114.245.69])
	by gw03.mail.saunalahti.fi (Postfix) with ESMTP id 8DE65216792;
	Fri, 27 Mar 2009 13:39:20 +0200 (EET)
From:	Dmitri Vorobiev <dmitri.vorobiev@movial.com>
To:	ralf@linux-mips.org, linux-mips@linux-mips.org,
	linux-kernel@vger.kernel.org
Cc:	Dmitri Vorobiev <dmitri.vorobiev@movial.com>
Subject: [PATCH 1/1] [MIPS] ip22: use a generic method for irq statistics
Date:	Fri, 27 Mar 2009 13:39:11 +0200
Message-Id: <1238153951-18307-1-git-send-email-dmitri.vorobiev@movial.com>
X-Mailer: git-send-email 1.5.6.3
Return-Path: <dmitri.vorobiev@movial.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22158
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dmitri.vorobiev@movial.com
Precedence: bulk
X-list: linux-mips

The structure 'struct kernel_stat' defines the 'irqs' array as its
field only when CONFIG_GENERIC_HARDIRQS is not set. However, the ip22
code makes use of this field unconditionally. As the result, the
following build error is produced:

  CC      arch/mips/sgi-ip22/ip22-int.o
arch/mips/sgi-ip22/ip22-int.c: In function 'indy_buserror_irq':
arch/mips/sgi-ip22/ip22-int.c:158: error: 'struct kernel_stat' has no
member named 'irqs'
make[1]: *** [arch/mips/sgi-ip22/ip22-int.o] Error 1
make: *** [arch/mips/sgi-ip22] Error 2

This patch fixes the build error by using the generic method for the irq
statistics.

Signed-off-by: Dmitri Vorobiev <dmitri.vorobiev@movial.com>
---
 arch/mips/sgi-ip22/ip22-int.c  |    3 ++-
 arch/mips/sgi-ip22/ip22-time.c |    3 ++-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/mips/sgi-ip22/ip22-int.c b/arch/mips/sgi-ip22/ip22-int.c
index f8b18af..e359ee8 100644
--- a/arch/mips/sgi-ip22/ip22-int.c
+++ b/arch/mips/sgi-ip22/ip22-int.c
@@ -153,9 +153,10 @@ extern void ip22_be_interrupt(int irq);
 static void indy_buserror_irq(void)
 {
 	int irq = SGI_BUSERR_IRQ;
+	struct irq_desc *desc = irq_to_desc(irq);
 
 	irq_enter();
-	kstat_this_cpu.irqs[irq]++;
+	kstat_incr_irqs_this_cpu(irq, desc);
 	ip22_be_interrupt(irq);
 	irq_exit();
 }
diff --git a/arch/mips/sgi-ip22/ip22-time.c b/arch/mips/sgi-ip22/ip22-time.c
index 3dcb27e..2536d78 100644
--- a/arch/mips/sgi-ip22/ip22-time.c
+++ b/arch/mips/sgi-ip22/ip22-time.c
@@ -118,11 +118,12 @@ __init void plat_time_init(void)
 void indy_8254timer_irq(void)
 {
 	int irq = SGI_8254_0_IRQ;
+	struct irq_desc *desc = irq_to_desc(irq);
 	ULONG cnt;
 	char c;
 
 	irq_enter();
-	kstat_this_cpu.irqs[irq]++;
+	kstat_incr_irqs_this_cpu(irq, desc);
 	printk(KERN_ALERT "Oops, got 8254 interrupt.\n");
 	ArcRead(0, &c, 1, &cnt);
 	ArcEnterInteractiveMode();
-- 
1.5.6.3
