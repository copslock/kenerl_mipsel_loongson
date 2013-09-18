Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 18 Sep 2013 15:28:46 +0200 (CEST)
Received: from mail-bk0-f43.google.com ([209.85.214.43]:56389 "EHLO
        mail-bk0-f43.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6860908Ab3IRN0eLdCwf (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 18 Sep 2013 15:26:34 +0200
Received: by mail-bk0-f43.google.com with SMTP id mz13so2876070bkb.30
        for <multiple recipients>; Wed, 18 Sep 2013 06:26:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=roErhqjyuKZG51q3QNRf29gDF/GEW6RKpdhfYGEJUKc=;
        b=FEryFd9IwNHvZk9gHVX7NYWl5GZTa2yv6MBr06bp4ElAzjcM51Mn7Pgli4bMKgTJal
         ixHHSksihFdx6hvcHYE3Z3j0xulu6J1BFC3if+NxR7pbgYWMIK088qj75Y9fSM2BeJbf
         ERekz96uwhO2Hr2v+5TKolGeoKWF7lsLMADkhhYfBAKBRDwdcpLdQtAIoYsQn2AWm2eR
         c6bSzmhHysGn9X8bfhoPp/T+lPAPsAYyfUxIBAWytSYHmVumOCGOrJHKxWsPl4eTbRzo
         x9VaVoSvQF1IXQRqx70sytgExIXOM89aZwFu4smEAeylMUJxwdyW1Y/U84z489Vf/pJ+
         aYRg==
X-Received: by 10.204.111.196 with SMTP id t4mr1424660bkp.38.1379510788809;
        Wed, 18 Sep 2013 06:26:28 -0700 (PDT)
Received: from localhost (port-55509.pppoe.wtnet.de. [46.59.217.135])
        by mx.google.com with ESMTPSA id pk7sm904986bkb.2.1969.12.31.16.00.00
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 18 Sep 2013 06:26:28 -0700 (PDT)
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
Subject: [PATCH v2 07/10] of/irq: Propagate errors in of_irq_to_resource_table()
Date:   Wed, 18 Sep 2013 15:24:49 +0200
Message-Id: <1379510692-32435-8-git-send-email-treding@nvidia.com>
X-Mailer: git-send-email 1.8.4
In-Reply-To: <1379510692-32435-1-git-send-email-treding@nvidia.com>
References: <1379510692-32435-1-git-send-email-treding@nvidia.com>
Return-Path: <thierry.reding@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37861
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

Now that all helpers return precise error codes, this function can
propagate these errors to the caller properly.

Signed-off-by: Thierry Reding <treding@nvidia.com>
---
Changes in v2:
- return 0 on success or a negative error code on failure
- convert callers to new calling convention

 arch/mips/lantiq/irq.c       |  2 +-
 arch/mips/lantiq/xway/gptu.c |  6 ++++--
 drivers/of/irq.c             | 14 ++++++++------
 drivers/tty/serial/lantiq.c  |  2 +-
 4 files changed, 14 insertions(+), 10 deletions(-)

diff --git a/arch/mips/lantiq/irq.c b/arch/mips/lantiq/irq.c
index eb3e186..5bb7ee6 100644
--- a/arch/mips/lantiq/irq.c
+++ b/arch/mips/lantiq/irq.c
@@ -389,7 +389,7 @@ int __init icu_of_init(struct device_node *node, struct device_node *parent)
 
 		ret = of_irq_to_resource_table(eiu_node,
 						ltq_eiu_irq, exin_avail);
-		if (ret != exin_avail)
+		if (ret < 0)
 			panic("failed to load external irq resources\n");
 
 		if (request_mem_region(res.start, resource_size(&res),
diff --git a/arch/mips/lantiq/xway/gptu.c b/arch/mips/lantiq/xway/gptu.c
index 850821d..0c4b134 100644
--- a/arch/mips/lantiq/xway/gptu.c
+++ b/arch/mips/lantiq/xway/gptu.c
@@ -137,10 +137,12 @@ static int gptu_probe(struct platform_device *pdev)
 {
 	struct clk *clk;
 	struct resource *res;
+	int ret;
 
-	if (of_irq_to_resource_table(pdev->dev.of_node, irqres, 6) != 6) {
+	ret = of_irq_to_resource_table(pdev->dev.of_node, irqres, 6);
+	if (ret < 0) {
 		dev_err(&pdev->dev, "Failed to get IRQ list\n");
-		return -EINVAL;
+		return ret;
 	}
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
diff --git a/drivers/of/irq.c b/drivers/of/irq.c
index e4f38c0..6d7f824 100644
--- a/drivers/of/irq.c
+++ b/drivers/of/irq.c
@@ -397,18 +397,20 @@ int of_irq_count(struct device_node *dev)
  * @res: array of resources to fill in
  * @nr_irqs: the number of IRQs (and upper bound for num of @res elements)
  *
- * Returns the size of the filled in table (up to @nr_irqs).
+ * Returns 0 on success or a negative error code on failure.
  */
 int of_irq_to_resource_table(struct device_node *dev, struct resource *res,
 		int nr_irqs)
 {
-	int i;
+	int i, ret;
 
-	for (i = 0; i < nr_irqs; i++, res++)
-		if (!of_irq_to_resource(dev, i, res))
-			break;
+	for (i = 0; i < nr_irqs; i++, res++) {
+		ret = of_irq_to_resource(dev, i, res);
+		if (ret < 0)
+			return ret;
+	}
 
-	return i;
+	return 0;
 }
 EXPORT_SYMBOL_GPL(of_irq_to_resource_table);
 
diff --git a/drivers/tty/serial/lantiq.c b/drivers/tty/serial/lantiq.c
index 88d01e0..e59efdc 100644
--- a/drivers/tty/serial/lantiq.c
+++ b/drivers/tty/serial/lantiq.c
@@ -686,7 +686,7 @@ lqasc_probe(struct platform_device *pdev)
 
 	mmres = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	ret = of_irq_to_resource_table(node, irqres, 3);
-	if (!mmres || (ret != 3)) {
+	if (!mmres || (ret < 0)) {
 		dev_err(&pdev->dev,
 			"failed to get memory/irq for serial port\n");
 		return -ENODEV;
-- 
1.8.4
