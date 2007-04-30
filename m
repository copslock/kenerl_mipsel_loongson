Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 30 Apr 2007 16:27:44 +0100 (BST)
Received: from mba.ocn.ne.jp ([122.1.175.29]:24021 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S20022514AbXD3P1m (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 30 Apr 2007 16:27:42 +0100
Received: from localhost (p4067-ipad203funabasi.chiba.ocn.ne.jp [222.146.83.67])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id 48130B61F; Tue,  1 May 2007 00:27:36 +0900 (JST)
Date:	Tue, 01 May 2007 00:27:39 +0900 (JST)
Message-Id: <20070501.002739.21956290.anemo@mba.ocn.ne.jp>
To:	linux-mips@linux-mips.org
Cc:	netdev@vger.kernel.org, jeff@garzik.org, ralf@linux-mips.org,
	sshtylyov@ru.mvista.com, akpm@linux-foundation.org
Subject: [PATCH 2/5] ne: Misc fixes for platform driver.
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
X-Fingerprint: 6ACA 1623 39BD 9A94 9B1A  B746 CA77 FE94 2874 D52F
X-Pgp-Public-Key: http://wwwkeys.pgp.net/pks/lookup?op=get&search=0x2874D52F
X-Mailer: Mew version 5.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <anemo@mba.ocn.ne.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14949
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

Miscellaneous fixes to make ne platform driver work properly.

* Make ioaddr 'unsigned long'.
* Move a printk down to show dev->name assigned in register_netdev.

Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
---
 drivers/net/ne.c |   13 +++++++------
 1 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ne.c b/drivers/net/ne.c
index aef470d..32ae91b 100644
--- a/drivers/net/ne.c
+++ b/drivers/net/ne.c
@@ -147,7 +147,7 @@ bad_clone_list[] __initdata = {
 #  define DCR_VAL 0x49
 #endif
 
-static int ne_probe1(struct net_device *dev, int ioaddr);
+static int ne_probe1(struct net_device *dev, unsigned long ioaddr);
 static int ne_probe_isapnp(struct net_device *dev);
 
 static int ne_open(struct net_device *dev);
@@ -185,7 +185,7 @@ static void ne_block_output(struct net_device *dev, const int count,
 
 static int __init do_ne_probe(struct net_device *dev)
 {
-	unsigned int base_addr = dev->base_addr;
+	unsigned long base_addr = dev->base_addr;
 #ifndef MODULE
 	int orig_irq = dev->irq;
 #endif
@@ -286,7 +286,7 @@ static int __init ne_probe_isapnp(struct net_device *dev)
 	return -ENODEV;
 }
 
-static int __init ne_probe1(struct net_device *dev, int ioaddr)
+static int __init ne_probe1(struct net_device *dev, unsigned long ioaddr)
 {
 	int i;
 	unsigned char SA_prom[32];
@@ -325,7 +325,7 @@ static int __init ne_probe1(struct net_device *dev, int ioaddr)
 	if (ei_debug  &&  version_printed++ == 0)
 		printk(KERN_INFO "%s" KERN_INFO "%s", version1, version2);
 
-	printk(KERN_INFO "NE*000 ethercard probe at %#3x:", ioaddr);
+	printk(KERN_INFO "NE*000 ethercard probe at %#3lx:", ioaddr);
 
 	/* A user with a poor card that fails to ack the reset, or that
 	   does not have a valid 0x57,0x57 signature can still use this
@@ -517,8 +517,7 @@ static int __init ne_probe1(struct net_device *dev, int ioaddr)
 	}
 #endif
 
-	printk("\n%s: %s found at %#x, using IRQ %d.\n",
-		dev->name, name, ioaddr, dev->irq);
+	printk("\n");
 
 	ei_status.name = name;
 	ei_status.tx_start_page = start_page;
@@ -548,6 +547,8 @@ static int __init ne_probe1(struct net_device *dev, int ioaddr)
 	ret = register_netdev(dev);
 	if (ret)
 		goto out_irq;
+	printk(KERN_INFO "%s: %s found at %#lx, using IRQ %d.\n",
+	       dev->name, name, ioaddr, dev->irq);
 	return 0;
 
 out_irq:
