Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 21 Sep 2009 23:13:42 +0200 (CEST)
Received: from mail.upwardaccess.com ([70.89.180.121]:1807 "EHLO
	upwardaccess.com" rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org
	with ESMTP id S1493265AbZIUVNe (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 21 Sep 2009 23:13:34 +0200
Received: from hawaii.upwardaccess.com (unverified [10.61.7.126]) 
	by upwardaccess.com (SurgeMail 3.9e) with ESMTP id 895964-1847469 
	for <linux-mips@linux-mips.org>; Mon, 21 Sep 2009 14:12:58 -0700
Received: by hawaii.upwardaccess.com (Postfix, from userid 500)
	id 047F335425B; Mon, 21 Sep 2009 14:13:24 -0700 (PDT)
From:	Mark Mason <mmason@upwardaccess.com>
To:	linux-mips@linux-mips.org
Cc:	Mark Mason <mmason@upwardaccess.com>
Subject: [PATCH] When complaining about attempting to set the irq affinity to multiple cpus,
Date:	Mon, 21 Sep 2009 14:13:24 -0700
Message-Id: <1253567604-6734-1-git-send-email-mmason@upwardaccess.com>
X-Mailer: git-send-email 1.6.0.2
X-Originating-IP: 10.61.7.126
X-Authenticated-User: mmason@upwardaccess.com 
Return-Path: <mason@upwardaccess.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24065
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mmason@upwardaccess.com
Precedence: bulk
X-list: linux-mips

---
 arch/mips/sibyte/bcm1480/irq.c |    6 +++++-
 1 files changed, 5 insertions(+), 1 deletions(-)

diff --git a/arch/mips/sibyte/bcm1480/irq.c b/arch/mips/sibyte/bcm1480/irq.c
index ba59839..fc87ea4 100644
--- a/arch/mips/sibyte/bcm1480/irq.c
+++ b/arch/mips/sibyte/bcm1480/irq.c
@@ -118,7 +118,11 @@ static int bcm1480_set_affinity(unsigned int irq, const struct cpumask *mask)
 	unsigned int irq_dirty;
 
 	if (cpumask_weight(mask) != 1) {
-		printk("attempted to set irq affinity for irq %d to multiple CPUs\n", irq);
+		printk("attempted to set irq affinity for irq %d to multiple CPUs:", irq);
+		/* Print the mask */
+		for_each_cpu(i, mask)
+			printk(" %d", i);
+		printk("\n");
 		return -1;
 	}
 	i = cpumask_first(mask);
-- 
1.6.0.2
