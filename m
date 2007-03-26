Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 26 Mar 2007 21:29:00 +0100 (BST)
Received: from 70-89-178-179-BusName-Oregon.hfc.comcastbusiness.net ([70.89.178.179]:42136
	"EHLO hawaii.site") by ftp.linux-mips.org with ESMTP
	id S20022591AbXCZU26 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 26 Mar 2007 21:28:58 +0100
Received: by hawaii.site (Postfix, from userid 500)
	id 1A8745484C7; Mon, 26 Mar 2007 13:28:26 -0700 (PDT)
Date:	Mon, 26 Mar 2007 13:28:26 -0700
From:	Mark Mason <mmason@upwardaccess.com>
To:	linux-mips@linux-mips.org
Subject: [PATCH] fix irq affinity for bcm1480
Message-ID: <20070326202825.GA12250@upwardaccess.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Return-Path: <mmason@upwardaccess.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14703
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mmason@upwardaccess.com
Precedence: bulk
X-list: linux-mips

Fix irq affinity setting for bcm1480.

Signed-off-by: Mark Mason (mason@broadcom.com)

diff --git a/arch/mips/sibyte/bcm1480/irq.c b/arch/mips/sibyte/bcm1480/irq.c
index 20af0f1..ba0c4b7 100644
--- a/arch/mips/sibyte/bcm1480/irq.c
+++ b/arch/mips/sibyte/bcm1480/irq.c
@@ -141,11 +141,11 @@ static void bcm1480_set_affinity(unsigne
 	unsigned long flags;
 	unsigned int irq_dirty;
 
-	i = first_cpu(mask);
-	if (next_cpu(i, mask) <= NR_CPUS) {
+	if (cpus_weight(mask) != 1) {
 		printk("attempted to set irq affinity for irq %d to multiple CPUs\n", irq);
 		return;
 	}
+	i = first_cpu(mask);
 
 	/* Convert logical CPU to physical CPU */
 	cpu = cpu_logical_map(i);
