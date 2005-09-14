Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 14 Sep 2005 19:18:00 +0100 (BST)
Received: from zproxy.gmail.com ([IPv6:::ffff:64.233.162.205]:49210 "EHLO
	zproxy.gmail.com") by linux-mips.org with ESMTP id <S8224992AbVINSRn>;
	Wed, 14 Sep 2005 19:17:43 +0100
Received: by zproxy.gmail.com with SMTP id j2so7596nzf
        for <linux-mips@linux-mips.org>; Wed, 14 Sep 2005 11:17:36 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:mime-version:content-type:content-disposition:user-agent;
        b=WdAjxnM9aL3rNzifE6F8gKEn2DZh/xIyCn5g38RyNY8JG067/6Llk6U9fPMFz6jRUa3rGAonSxAvzWMv3dKHl5ybjSFw7pR/yXKU8XXEOxPThKD4jG3hD5TKZE6+lK1Fo+1LPzF2e/ahbBLJelgtq6oalX5EIAhrU+cQfXPN9LU=
Received: by 10.36.96.5 with SMTP id t5mr1879361nzb;
        Wed, 14 Sep 2005 11:17:31 -0700 (PDT)
Received: from gmail.com ( [217.10.38.130])
        by mx.gmail.com with ESMTP id r15sm40027nza.2005.09.14.11.17.28;
        Wed, 14 Sep 2005 11:17:30 -0700 (PDT)
Received: by gmail.com (nbSMTP-1.00) for uid 1000
	(using TLSv1/SSLv3 with cipher DES-CBC3-SHA (168/168 bits))
	adobriyan@gmail.com; Wed, 14 Sep 2005 22:27:48 +0400 (MSD)
Date:	Wed, 14 Sep 2005 22:27:45 +0400
From:	Alexey Dobriyan <adobriyan@gmail.com>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	Clemens Buchacher <drizzd@aon.at>, linux-mips@linux-mips.org
Subject: [PATCH] mips: don't concatenate __FUNCTION__ with strings
Message-ID: <20050914182745.GC19491@mipter.zuzino.mipt.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.8i
Return-Path: <adobriyan@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8952
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: adobriyan@gmail.com
Precedence: bulk
X-list: linux-mips

From: Clemens Buchacher <drizzd@aon.at>

It's deprecated. Use "%s", __FUNCTION__ instead.

Signed-off-by: Clemens Buchacher <drizzd@aon.at>
Signed-off-by: Maximilian Attems <janitor@sternwelten.at>
Signed-off-by: Domen Puncer <domen@coderock.org>
Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>

--- a/arch/mips/au1000/common/usbdev.c
+++ b/arch/mips/au1000/common/usbdev.c
@@ -348,7 +348,7 @@ endpoint_stall(endpoint_t * ep)
 {
 	u32 cs;
 
-	warn(__FUNCTION__);
+	warn("%s", __FUNCTION__);
 
 	cs = au_readl(ep->reg->ctrl_stat) | USBDEV_CS_STALL;
 	au_writel(cs, ep->reg->ctrl_stat);
@@ -360,7 +360,7 @@ endpoint_unstall(endpoint_t * ep)
 {
 	u32 cs;
 
-	warn(__FUNCTION__);
+	warn("%s", __FUNCTION__);
 
 	cs = au_readl(ep->reg->ctrl_stat) & ~USBDEV_CS_STALL;
 	au_writel(cs, ep->reg->ctrl_stat);
--- a/drivers/net/gt96100eth.c
+++ b/drivers/net/gt96100eth.c
@@ -72,8 +72,6 @@ static void dump_tx_desc(int dbg_lvl, st
 static void dump_rx_desc(int dbg_lvl, struct net_device *dev, int i);
 static void dump_skb(int dbg_lvl, struct net_device *dev,
 		     struct sk_buff *skb);
-static void dump_hw_addr(int dbg_lvl, struct net_device *dev,
-			 const char* pfx, unsigned char* addr_str);
 static void update_stats(struct gt96100_private *gp);
 static void abort(struct net_device *dev, u32 abort_bits);
 static void hard_stop(struct net_device *dev);
@@ -334,13 +332,13 @@ dump_MII(int dbg_lvl, struct net_device 
 
 static void
 dump_hw_addr(int dbg_lvl, struct net_device *dev, const char* pfx,
-	     unsigned char* addr_str)
+	     const char* func, unsigned char* addr_str)
 {
 	int i;
 	char buf[100], octet[5];
     
 	if (dbg_lvl <= GT96100_DEBUG) {
-		strcpy(buf, pfx);
+		sprintf(buf, pfx, func);
 		for (i = 0; i < 6; i++) {
 			sprintf(octet, "%2.2x%s",
 				addr_str[i], i<5 ? ":" : "\n");
@@ -708,7 +706,7 @@ static int __init gt96100_probe1(struct 
 
 	info("%s found at 0x%x, irq %d\n",
 	     chip_name(gp->chip_rev), gtif->iobase, gtif->irq);
-	dump_hw_addr(0, dev, "HW Address ", dev->dev_addr);
+	dump_hw_addr(0, dev, "%s: HW Address ", __FUNCTION__, dev->dev_addr);
 	info("%s chip revision=%d\n", chip_name(gp->chip_rev), gp->chip_rev);
 	info("%s ethernet port %d\n", chip_name(gp->chip_rev), gp->port_num);
 	info("external PHY ID1=0x%04x, ID2=0x%04x\n", phy_id1, phy_id2);
@@ -1488,7 +1486,7 @@ gt96100_set_rx_mode(struct net_device *d
 		gt96100_add_hash_entry(dev, dev->dev_addr);
 
 		for (mcptr = dev->mc_list; mcptr; mcptr = mcptr->next) {
-			dump_hw_addr(2, dev, __FUNCTION__ ": addr=",
+			dump_hw_addr(2, dev, "%s: addr=", __FUNCTION__,
 				     mcptr->dmi_addr);
 			gt96100_add_hash_entry(dev, mcptr->dmi_addr);
 		}
