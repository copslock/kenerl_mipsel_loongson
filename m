Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 18 Sep 2013 15:28:26 +0200 (CEST)
Received: from mail-bk0-f49.google.com ([209.85.214.49]:53957 "EHLO
        mail-bk0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6827309Ab3IRN0dXylrb (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 18 Sep 2013 15:26:33 +0200
Received: by mail-bk0-f49.google.com with SMTP id r7so2756186bkg.8
        for <multiple recipients>; Wed, 18 Sep 2013 06:26:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=jik3sAsp1sMyKr3OxWe14XQ2Dm5HZIE3JMP7NpjBhLI=;
        b=W/WisCu4T5NtBPDQrI3Iqeyi+Spye8x+eOOSWwpwF0H8oC+6GjWT/efJFBAV/lEtHF
         8qJCFgcO5Jsb08hVuC9tcLFPWFAoU0Jm+ii8nNzICBt7Sov9f5/EQLS6rKwnYWhy4IsY
         Z3y8UgZDR0eokNEAF4tie7rV2d0haLvwjPz9sXgzbb/eynNybJZsC/mPg2dqvs1Gh5Ys
         Li0/Yk3mhRxAVAijK2SUWtTzOmGAXvB5BvkwaFTtltfdoay6PnEtajFprErLqHpmM+0t
         SX/V/aPhXzLFx0b1tv561A0RZ+SZJiJz5eW6UcnoPRLZ8VgtX99923VBAfpkjO8RIrfR
         N6pA==
X-Received: by 10.204.60.66 with SMTP id o2mr34703161bkh.22.1379510786987;
        Wed, 18 Sep 2013 06:26:26 -0700 (PDT)
Received: from localhost (port-55509.pppoe.wtnet.de. [46.59.217.135])
        by mx.google.com with ESMTPSA id kk2sm899764bkb.10.1969.12.31.16.00.00
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 18 Sep 2013 06:26:26 -0700 (PDT)
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Rob Herring <rob.herring@calxeda.com>,
        Grant Likely <grant.likely@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Russell King <linux@arm.linux.org.uk>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mips@linux-mips.org, linuxppc-dev@lists.ozlabs.org,
        sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 06/10] of/irq: Return errors from of_irq_to_resource()
Date:   Wed, 18 Sep 2013 15:24:48 +0200
Message-Id: <1379510692-32435-7-git-send-email-treding@nvidia.com>
X-Mailer: git-send-email 1.8.4
In-Reply-To: <1379510692-32435-1-git-send-email-treding@nvidia.com>
References: <1379510692-32435-1-git-send-email-treding@nvidia.com>
Return-Path: <thierry.reding@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37860
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: thierry.reding@gmail.com
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

Update of_irq_to_resource() to return 0 on success and a negative error
code on failure. This allows the precise nature of the failure to be
determined in the caller and errors to be propagated appropriately.

While at it, make the index parameter unsigned. Accessing negative
indices is invalid, so we might as well enforce that by using the right
data type.

Signed-off-by: Thierry Reding <treding@nvidia.com>
---
Changes in v2:
- convert existing callers instead of using compatible wrapper

 arch/powerpc/platforms/83xx/mpc832x_rdb.c  |  2 +-
 drivers/net/ethernet/marvell/mv643xx_eth.c |  5 +++--
 drivers/of/irq.c                           | 14 +++++++++++---
 include/linux/of_irq.h                     |  2 +-
 4 files changed, 16 insertions(+), 7 deletions(-)

diff --git a/arch/powerpc/platforms/83xx/mpc832x_rdb.c b/arch/powerpc/platforms/83xx/mpc832x_rdb.c
index eff5baa..b198e73 100644
--- a/arch/powerpc/platforms/83xx/mpc832x_rdb.c
+++ b/arch/powerpc/platforms/83xx/mpc832x_rdb.c
@@ -89,7 +89,7 @@ static int __init of_fsl_spi_probe(char *type, char *compatible, u32 sysclk,
 			goto err;
 
 		ret = of_irq_to_resource(np, 0, &res[1]);
-		if (ret == NO_IRQ)
+		if (ret)
 			goto err;
 
 		pdev = platform_device_alloc("mpc83xx_spi", i);
diff --git a/drivers/net/ethernet/marvell/mv643xx_eth.c b/drivers/net/ethernet/marvell/mv643xx_eth.c
index 7fb5677..bd713bd 100644
--- a/drivers/net/ethernet/marvell/mv643xx_eth.c
+++ b/drivers/net/ethernet/marvell/mv643xx_eth.c
@@ -2489,9 +2489,10 @@ static int mv643xx_eth_shared_of_add_port(struct platform_device *pdev,
 	ppd.shared = pdev;
 
 	memset(&res, 0, sizeof(res));
-	if (!of_irq_to_resource(pnp, 0, &res)) {
+	ret = of_irq_to_resource(pnp, 0, &res);
+	if (ret) {
 		dev_err(&pdev->dev, "missing interrupt on %s\n", pnp->name);
-		return -EINVAL;
+		return ret;
 	}
 
 	if (of_property_read_u32(pnp, "reg", &ppd.port_number)) {
diff --git a/drivers/of/irq.c b/drivers/of/irq.c
index 6ad46fd..e4f38c0 100644
--- a/drivers/of/irq.c
+++ b/drivers/of/irq.c
@@ -341,10 +341,18 @@ EXPORT_SYMBOL_GPL(of_irq_map_one);
  * @dev: pointer to device tree node
  * @index: zero-based index of the irq
  * @r: pointer to resource structure to return result into.
+ *
+ * Returns zero on success or a negative error code on failure.
  */
-int of_irq_to_resource(struct device_node *dev, int index, struct resource *r)
+int of_irq_to_resource(struct device_node *dev, unsigned int index,
+		       struct resource *r)
 {
-	int irq = irq_of_parse_and_map(dev, index);
+	unsigned int irq;
+	int ret;
+
+	ret = __irq_of_parse_and_map(dev, index, &irq);
+	if (ret)
+		return ret;
 
 	/* Only dereference the resource if both the
 	 * resource and the irq are valid. */
@@ -364,7 +372,7 @@ int of_irq_to_resource(struct device_node *dev, int index, struct resource *r)
 		r->name = name ? name : dev->full_name;
 	}
 
-	return irq;
+	return 0;
 }
 EXPORT_SYMBOL_GPL(of_irq_to_resource);
 
diff --git a/include/linux/of_irq.h b/include/linux/of_irq.h
index 11da949..6d62b73 100644
--- a/include/linux/of_irq.h
+++ b/include/linux/of_irq.h
@@ -67,7 +67,7 @@ extern int of_irq_map_one(struct device_node *device, int index,
 extern int irq_create_of_mapping(struct device_node *controller,
 				 const u32 *intspec, unsigned int intsize,
 				 unsigned int *virqp);
-extern int of_irq_to_resource(struct device_node *dev, int index,
+extern int of_irq_to_resource(struct device_node *dev, unsigned int index,
 			      struct resource *r);
 extern int of_irq_count(struct device_node *dev);
 extern int of_irq_to_resource_table(struct device_node *dev,
-- 
1.8.4
