Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f9SKmOa05631
	for linux-mips-outgoing; Sun, 28 Oct 2001 12:48:24 -0800
Received: from ns1.ltc.com (ns1.ltc.com [38.149.17.165])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f9SKmI005628;
	Sun, 28 Oct 2001 12:48:18 -0800
Received: from dev1 (gw1.ltc.com [38.149.17.163])
	by ns1.ltc.com (Postfix) with ESMTP
	id 15636590B4; Sun, 28 Oct 2001 11:45:15 -0500 (EST)
Received: from brad by dev1 with local (Exim 3.32 #1 (Debian))
	id 15xwqQ-0002ne-00; Sun, 28 Oct 2001 15:47:46 -0500
Date: Sun, 28 Oct 2001 15:47:46 -0500
To: ralf@oss.sgi.com
Cc: linux-mips@oss.sgi.com
Subject: PATCH: require dev_id for shared irq
Message-ID: <20011028154746.A10762@dev1.ltc.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.20i
From: "Bradley D. LaRonde" <brad@ltc.com>
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

2001-10-28  Bradley D. LaRonde <brad@ltc.com>

- Require a dev_id for shared interrupts.

--- arch/mips/kernel/irq.c	2001/10/12 01:41:17	1.36
+++ arch/mips/kernel/irq.c	2001/10/28 20:43:19
@@ -350,18 +350,12 @@
 	int retval;
 	struct irqaction * action;
 
-#if 1
 	/*
-	 * Sanity-check: shared interrupts should REALLY pass in
-	 * a real dev-ID, otherwise we'll have trouble later trying
-	 * to figure out which interrupt is which (messes up the
-	 * interrupt freeing logic etc).
+	 * Shared interrupts require a dev_id, otherwise we can't
+	 * later figure out which interrupt to free.
 	 */
-	if (irqflags & SA_SHIRQ) {
-		if (!dev_id)
-			printk("Bad boy: %s (at 0x%x) called us without a dev_id!\n", devname, (&irq)[-1]);
-	}
-#endif
+	if ((irqflags & SA_SHIRQ) && !dev_id)
+		return -EINVAL;
 
 	if (irq >= NR_IRQS)
 		return -EINVAL;
