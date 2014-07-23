Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 23 Jul 2014 16:42:42 +0200 (CEST)
Received: from mail-wi0-f181.google.com ([209.85.212.181]:56795 "EHLO
        mail-wi0-f181.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6842533AbaGWOhavbvro (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 23 Jul 2014 16:37:30 +0200
Received: by mail-wi0-f181.google.com with SMTP id bs8so2366538wib.8
        for <linux-mips@linux-mips.org>; Wed, 23 Jul 2014 07:37:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=AVBQnUklZuov2vo32Bhi2SUhfoSBFaxihfUhIUAxpVQ=;
        b=h3U62pb2Gj8s1qffG8dv8kG2oB+kCPDnmCT+kWYc15sILwe4GfmQryn5MUqY/FcAT6
         MiyoS9QZo4pf2LCp9Y4dpKFdeg++SBiEY8O1UyhJsJgS55p9x5Lc0mAc7uNF596K7OMC
         mKlqeC2bHoznm2pIKV9JwXSezPnYWqulupq94OCOMSLyOiEB2HUnpsvjoMHv9sWmJmRA
         PY0PEMf9SfnPsnR1NZBP+yDuvdHf+r1Q0XITuxkjqtAuRZveAnv6kLQ+GQ4LlZVvCKR8
         i/zv/5M3sWFAzB1CHPGCy1Zjogjm/f/uFaMCsrvZwScZtenCZ2Es2Ihs29DnMI3LNkln
         bzqQ==
X-Received: by 10.194.92.115 with SMTP id cl19mr2435090wjb.29.1406126240943;
        Wed, 23 Jul 2014 07:37:20 -0700 (PDT)
Received: from localhost.localdomain (p57A349C7.dip0.t-ipconnect.de. [87.163.73.199])
        by mx.google.com with ESMTPSA id ex4sm10196560wic.2.2014.07.23.07.37.19
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 23 Jul 2014 07:37:20 -0700 (PDT)
From:   Manuel Lauss <manuel.lauss@gmail.com>
To:     Linux-MIPS <linux-mips@linux-mips.org>
Cc:     Manuel Lauss <manuel.lauss@gmail.com>
Subject: [PATCH 06/10] MIPS: Alchemy: irda: use clk framework
Date:   Wed, 23 Jul 2014 16:36:53 +0200
Message-Id: <1406126217-471265-7-git-send-email-manuel.lauss@gmail.com>
X-Mailer: git-send-email 2.0.1
In-Reply-To: <1406126217-471265-1-git-send-email-manuel.lauss@gmail.com>
References: <1406126217-471265-1-git-send-email-manuel.lauss@gmail.com>
Return-Path: <manuel.lauss@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 41541
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: manuel.lauss@gmail.com
Precedence: bulk
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-Id: linux-mips <linux-mips.eddie.linux-mips.org>
X-List-ID: linux-mips <linux-mips.eddie.linux-mips.org>
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
X-list: linux-mips

Test the existence of the irda_clk clock object, use it to en/dis-
able it when date is being transferred.

Signed-off-by: Manuel Lauss <manuel.lauss@gmail.com>
---
 drivers/net/irda/au1k_ir.c | 48 ++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 46 insertions(+), 2 deletions(-)

diff --git a/drivers/net/irda/au1k_ir.c b/drivers/net/irda/au1k_ir.c
index 5f91e3e..aab2cf7 100644
--- a/drivers/net/irda/au1k_ir.c
+++ b/drivers/net/irda/au1k_ir.c
@@ -18,6 +18,7 @@
  *  with this program; if not, see <http://www.gnu.org/licenses/>.
  */
 
+#include <linux/clk.h>
 #include <linux/module.h>
 #include <linux/netdevice.h>
 #include <linux/interrupt.h>
@@ -175,6 +176,7 @@ struct au1k_private {
 
 	struct resource *ioarea;
 	struct au1k_irda_platform_data *platdata;
+	struct clk *irda_clk;
 };
 
 static int qos_mtt_bits = 0x07;  /* 1 ms or more */
@@ -514,9 +516,39 @@ static irqreturn_t au1k_irda_interrupt(int dummy, void *dev_id)
 static int au1k_init(struct net_device *dev)
 {
 	struct au1k_private *aup = netdev_priv(dev);
-	u32 enable, ring_address;
+	u32 enable, ring_address, phyck;
+	struct clk *c;
 	int i;
 
+	c = clk_get(NULL, "irda_clk");
+	if (IS_ERR(c))
+		return PTR_ERR(c);
+	i = clk_prepare_enable(c);
+	if (i) {
+		clk_put(c);
+		return i;
+	}
+
+	switch (clk_get_rate(c)) {
+	case 40000000:
+		phyck = IR_PHYCLK_40MHZ;
+		break;
+	case 48000000:
+		phyck = IR_PHYCLK_48MHZ;
+		break;
+	case 56000000:
+		phyck = IR_PHYCLK_56MHZ;
+		break;
+	case 64000000:
+		phyck = IR_PHYCLK_64MHZ;
+		break;
+	default:
+		clk_disable_unprepare(c);
+		clk_put(c);
+		return -EINVAL;
+	}
+	aup->irda_clk = c;
+
 	enable = IR_HC | IR_CE | IR_C;
 #ifndef CONFIG_CPU_LITTLE_ENDIAN
 	enable |= IR_BE;
@@ -545,7 +577,7 @@ static int au1k_init(struct net_device *dev)
 	irda_write(aup, IR_RING_SIZE,
 				(RING_SIZE_64 << 8) | (RING_SIZE_64 << 12));
 
-	irda_write(aup, IR_CONFIG_2, IR_PHYCLK_48MHZ | IR_ONE_PIN);
+	irda_write(aup, IR_CONFIG_2, phyck | IR_ONE_PIN);
 	irda_write(aup, IR_RING_ADDR_CMPR, 0);
 
 	au1k_irda_set_speed(dev, 9600);
@@ -619,6 +651,9 @@ static int au1k_irda_stop(struct net_device *dev)
 	free_irq(aup->irq_tx, dev);
 	free_irq(aup->irq_rx, dev);
 
+	clk_disable_unprepare(aup->irda_clk);
+	clk_put(aup->irda_clk);
+
 	return 0;
 }
 
@@ -853,6 +888,7 @@ static int au1k_irda_probe(struct platform_device *pdev)
 	struct au1k_private *aup;
 	struct net_device *dev;
 	struct resource *r;
+	struct clk *c;
 	int err;
 
 	dev = alloc_irdadev(sizeof(struct au1k_private));
@@ -886,6 +922,14 @@ static int au1k_irda_probe(struct platform_device *pdev)
 	if (!aup->ioarea)
 		goto out;
 
+	/* bail out early if clock doesn't exist */
+	c = clk_get(NULL, "irda_clk");
+	if (IS_ERR(c)) {
+		err = PTR_ERR(c);
+		goto out;
+	}
+	clk_put(c);
+
 	aup->iobase = ioremap_nocache(r->start, resource_size(r));
 	if (!aup->iobase)
 		goto out2;
-- 
2.0.1
