Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 20 Feb 2006 00:10:49 +0000 (GMT)
Received: from sorrow.cyrius.com ([65.19.161.204]:60685 "EHLO
	sorrow.cyrius.com") by ftp.linux-mips.org with ESMTP
	id S8133730AbWBTAKj (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 20 Feb 2006 00:10:39 +0000
Received: by sorrow.cyrius.com (Postfix, from userid 10)
	id CD16964D3D; Mon, 20 Feb 2006 00:17:31 +0000 (UTC)
Received: by deprecation.cyrius.com (Postfix, from userid 1000)
	id 60CBF8D5D; Mon, 20 Feb 2006 00:17:24 +0000 (GMT)
Date:	Mon, 20 Feb 2006 00:17:24 +0000
From:	Martin Michlmayr <tbm@cyrius.com>
To:	netdev@vger.kernel.org, linux-mips@linux-mips.org
Subject: Re: Diff between Linus' and linux-mips git: declance
Message-ID: <20060220001724.GB17967@deprecation.cyrius.com>
References: <20060219234318.GA16311@deprecation.cyrius.com> <20060220000141.GX10266@deprecation.cyrius.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060220000141.GX10266@deprecation.cyrius.com>
User-Agent: Mutt/1.5.11
Return-Path: <tbm@cyrius.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10534
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tbm@cyrius.com
Precedence: bulk
X-list: linux-mips

Remove delta between Linus' and linux-mips git trees in declance

There are two changes between the Linus' and linux-mips git trees
regarding the declaner driver.  The first change is certainly correct
(as it is consistent with the rest of the file) and should be applied
to mainline; the other change seems correct too.

Signed-off-by: Martin Michlmayr <tbm@cyrius.com>


--- linux-2.6.16-rc4/drivers/net/declance.c	2006-02-19 20:09:07.000000000 +0000
+++ mips-2.6.16-rc4/drivers/net/declance.c	2006-02-19 20:15:22.000000000 +0000
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

-- 
Martin Michlmayr
http://www.cyrius.com/
