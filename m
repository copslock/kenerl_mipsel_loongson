Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 20 Mar 2006 04:35:02 +0000 (GMT)
Received: from sorrow.cyrius.com ([65.19.161.204]:53007 "EHLO
	sorrow.cyrius.com") by ftp.linux-mips.org with ESMTP
	id S8133781AbWCTEas (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 20 Mar 2006 04:30:48 +0000
Received: by sorrow.cyrius.com (Postfix, from userid 10)
	id A842A64D3D; Mon, 20 Mar 2006 04:40:25 +0000 (UTC)
Received: by deprecation.cyrius.com (Postfix, from userid 1000)
	id 7F3B466ED7; Mon, 20 Mar 2006 04:39:53 +0000 (GMT)
Date:	Mon, 20 Mar 2006 04:39:53 +0000
From:	Martin Michlmayr <tbm@cyrius.com>
To:	akpm@osdl.org
Cc:	linux-kernel@vger.kernel.org, linux-mips@linux-mips.org,
	netdev@vger.kernel.org
Subject: [PATCH 5/12] [NET] Bring declance.c in sync with linux-mips tree
Message-ID: <20060320043953.GE20416@deprecation.cyrius.com>
References: <20060320043802.GA20389@deprecation.cyrius.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060320043802.GA20389@deprecation.cyrius.com>
User-Agent: Mutt/1.5.11+cvs20060126
Return-Path: <tbm@cyrius.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10863
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tbm@cyrius.com
Precedence: bulk
X-list: linux-mips

There are three changes between the Linus' and linux-mips git trees
regarding the declaner driver.  Two are cosmetic and one fixes a
call to the wrong function.

Signed-off-by: Martin Michlmayr <tbm@cyrius.com>
Acked-by: Maciej W. Rozycki <macro@linux-mips.org>


--- linux-2.6/drivers/net/declance.c	2006-03-05 19:35:04.000000000 +0000
+++ mips.git/drivers/net/declance.c	2006-03-05 18:51:15.000000000 +0000
@@ -704,8 +704,8 @@
 	return IRQ_HANDLED;
 }
 
-static irqreturn_t
-lance_interrupt(const int irq, void *dev_id, struct pt_regs *regs)
+static irqreturn_t lance_interrupt(const int irq, void *dev_id,
+				   struct pt_regs *regs)
 {
 	struct net_device *dev = (struct net_device *) dev_id;
 	struct lance_private *lp = netdev_priv(dev);
@@ -1255,7 +1255,7 @@
 	return 0;
 
 err_out_free_dev:
-	kfree(dev);
+	free_netdev(dev);
 
 err_out:
 	return ret;
@@ -1301,6 +1301,7 @@
 	while (root_lance_dev) {
 		struct net_device *dev = root_lance_dev;
 		struct lance_private *lp = netdev_priv(dev);
+
 		unregister_netdev(dev);
 #ifdef CONFIG_TC
 		if (lp->slot >= 0)

-- 
Martin Michlmayr
http://www.cyrius.com/
