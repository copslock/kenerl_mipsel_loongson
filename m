Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 10 Jan 2005 18:32:59 +0000 (GMT)
Received: from coderock.org ([IPv6:::ffff:193.77.147.115]:33468 "EHLO
	trashy.coderock.org") by linux-mips.org with ESMTP
	id <S8225534AbVAJScv>; Mon, 10 Jan 2005 18:32:51 +0000
Received: by trashy.coderock.org (Postfix, from userid 780)
	id B37C31F20A; Mon, 10 Jan 2005 19:32:47 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by trashy.coderock.org (Postfix) with ESMTP id 77B6B1F206;
	Mon, 10 Jan 2005 19:32:46 +0100 (CET)
Received: from localhost.localdomain (localhost [127.0.0.1])
	by trashy.coderock.org (Postfix) with ESMTP id 486E71F1ED;
	Mon, 10 Jan 2005 19:32:38 +0100 (CET)
Subject: [patch 1/1] __FUNCTION__ string concatenation deprecated
To: ralf@linux-mips.org
Cc: linux-mips@linux-mips.org, domen@coderock.org, drizzd@aon.at,
	janitor@sternwelten.at
From: domen@coderock.org
Date: Mon, 10 Jan 2005 19:32:36 +0100
Message-Id: <20050110183238.486E71F1ED@trashy.coderock.org>
Return-Path: <domen@coderock.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6873
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: domen@coderock.org
Precedence: bulk
X-list: linux-mips




Description: __FUNCTION__ string concatenation is deprecated

Diff against linux-2.6 up to ChangeSet@1.1938 (04/09/18 20:30:01)

Status: untested

Signed-off-by: Clemens Buchacher <drizzd@aon.at>
Signed-off-by: Maximilian Attems <janitor@sternwelten.at>

# sound/oss/ite8172.c
#   2004/09/20 14:52:26+02:00 drizzd@aon.at +1 -1
#   __FUNCTION__ string concatenation is deprecated
# 
# sound/oss/au1000.c
#   2004/09/20 14:52:26+02:00 drizzd@aon.at +1 -1
#   __FUNCTION__ string concatenation is deprecated
# 
# drivers/net/gt96100eth.c
#   2004/09/20 14:52:26+02:00 drizzd@aon.at +5 -5
#   __FUNCTION__ string concatenation is deprecated
# 
# arch/mips/au1000/common/usbdev.c
#   2004/09/20 14:52:26+02:00 drizzd@aon.at +2 -2
#   __FUNCTION__ string concatenation is deprecated
# 
Signed-off-by: Domen Puncer <domen@coderock.org>
---


 kj-domen/arch/mips/au1000/common/usbdev.c |    4 ++--
 kj-domen/drivers/net/gt96100eth.c         |   10 +++++-----
 kj-domen/sound/oss/au1000.c               |    2 +-
 kj-domen/sound/oss/ite8172.c              |    2 +-
 4 files changed, 9 insertions(+), 9 deletions(-)

diff -puN arch/mips/au1000/common/usbdev.c~function-string-arch-mips arch/mips/au1000/common/usbdev.c
--- kj/arch/mips/au1000/common/usbdev.c~function-string-arch-mips	2005-01-10 17:59:57.000000000 +0100
+++ kj-domen/arch/mips/au1000/common/usbdev.c	2005-01-10 17:59:57.000000000 +0100
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
diff -puN drivers/net/gt96100eth.c~function-string-arch-mips drivers/net/gt96100eth.c
--- kj/drivers/net/gt96100eth.c~function-string-arch-mips	2005-01-10 17:59:57.000000000 +0100
+++ kj-domen/drivers/net/gt96100eth.c	2005-01-10 17:59:57.000000000 +0100
@@ -73,7 +73,7 @@ static void dump_rx_desc(int dbg_lvl, st
 static void dump_skb(int dbg_lvl, struct net_device *dev,
 		     struct sk_buff *skb);
 static void dump_hw_addr(int dbg_lvl, struct net_device *dev,
-			 const char* pfx, unsigned char* addr_str);
+			 const char* pfx, const char* func, unsigned char* addr_str);
 static void update_stats(struct gt96100_private *gp);
 static void abort(struct net_device *dev, u32 abort_bits);
 static void hard_stop(struct net_device *dev);
@@ -334,13 +334,13 @@ dump_MII(int dbg_lvl, struct net_device 
 
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
@@ -708,7 +708,7 @@ static int __init gt96100_probe1(struct 
 
 	info("%s found at 0x%x, irq %d\n",
 	     chip_name(gp->chip_rev), gtif->iobase, gtif->irq);
-	dump_hw_addr(0, dev, "HW Address ", dev->dev_addr);
+	dump_hw_addr(0, dev, "%s: HW Address ", __FUNCTION__, dev->dev_addr);
 	info("%s chip revision=%d\n", chip_name(gp->chip_rev), gp->chip_rev);
 	info("%s ethernet port %d\n", chip_name(gp->chip_rev), gp->port_num);
 	info("external PHY ID1=0x%04x, ID2=0x%04x\n", phy_id1, phy_id2);
@@ -1488,7 +1488,7 @@ gt96100_set_rx_mode(struct net_device *d
 		gt96100_add_hash_entry(dev, dev->dev_addr);
 
 		for (mcptr = dev->mc_list; mcptr; mcptr = mcptr->next) {
-			dump_hw_addr(2, dev, __FUNCTION__ ": addr=",
+			dump_hw_addr(2, dev, "%s: addr=", __FUNCTION__,
 				     mcptr->dmi_addr);
 			gt96100_add_hash_entry(dev, mcptr->dmi_addr);
 		}
diff -puN sound/oss/au1000.c~function-string-arch-mips sound/oss/au1000.c
--- kj/sound/oss/au1000.c~function-string-arch-mips	2005-01-10 17:59:57.000000000 +0100
+++ kj-domen/sound/oss/au1000.c	2005-01-10 17:59:57.000000000 +0100
@@ -1317,7 +1317,7 @@ static int au1000_mmap(struct file *file
 	unsigned long   size;
 	int ret = 0;
 
-	dbg(__FUNCTION__);
+	dbg("%s", __FUNCTION__);
     
 	lock_kernel();
 	down(&s->sem);
diff -puN sound/oss/ite8172.c~function-string-arch-mips sound/oss/ite8172.c
--- kj/sound/oss/ite8172.c~function-string-arch-mips	2005-01-10 17:59:57.000000000 +0100
+++ kj-domen/sound/oss/ite8172.c	2005-01-10 17:59:57.000000000 +0100
@@ -1848,7 +1848,7 @@ static int it8172_release(struct inode *
 	struct it8172_state *s = (struct it8172_state *)file->private_data;
 
 #ifdef IT8172_VERBOSE_DEBUG
-	dbg(__FUNCTION__);
+	dbg("%s", __FUNCTION__);
 #endif
 	lock_kernel();
 	if (file->f_mode & FMODE_WRITE)
_
