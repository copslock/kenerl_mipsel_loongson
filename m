Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 18 Sep 2013 15:26:34 +0200 (CEST)
Received: from mail-bk0-f49.google.com ([209.85.214.49]:47030 "EHLO
        mail-bk0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6825727Ab3IRN0Jo4OIC (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 18 Sep 2013 15:26:09 +0200
Received: by mail-bk0-f49.google.com with SMTP id r7so2755943bkg.8
        for <multiple recipients>; Wed, 18 Sep 2013 06:26:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=5Q0KmXVxA3axiF1QfSfX9nR5UTPk40ySv/j033sM998=;
        b=ONESxbL7wVzylxPvIN2ACHOosYmqtfIV5bTG4iMTW1xUQWxhEEz98/P9G2asjy77+1
         VC2wyRBVLvqsOE88+TVGuoSIOwY7wDyUOpwlMJXi0x3iGzT4BxHIuLSk+vwnq9YpoAqD
         gZ4IMfTEsSg+0gdblWXY9ChPYKdGd8i2R0by05gsUIo6v2iaChQmw2+EYBoxEyBdZLYp
         R7Wa6ooNFtjT2bNV/6D9X6H9ZypqYLqNdlZx65CV5xTTtl4HIGbHh3EuVWB4JggY95gP
         /oos7xvP4bCkrcX5P8+8ik/mPrwFF4J6pD8CItaTLpfdxY02etofFNOhLFSZHMU617Cb
         7UAw==
X-Received: by 10.205.105.73 with SMTP id dp9mr2002034bkc.33.1379510764437;
        Wed, 18 Sep 2013 06:26:04 -0700 (PDT)
Received: from localhost (port-55509.pppoe.wtnet.de. [46.59.217.135])
        by mx.google.com with ESMTPSA id qe6sm901789bkb.5.1969.12.31.16.00.00
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 18 Sep 2013 06:26:03 -0700 (PDT)
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
Subject: [PATCH v2 01/10] of/irq: Rework of_irq_count()
Date:   Wed, 18 Sep 2013 15:24:43 +0200
Message-Id: <1379510692-32435-2-git-send-email-treding@nvidia.com>
X-Mailer: git-send-email 1.8.4
In-Reply-To: <1379510692-32435-1-git-send-email-treding@nvidia.com>
References: <1379510692-32435-1-git-send-email-treding@nvidia.com>
Return-Path: <thierry.reding@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37855
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

The of_irq_to_resource() helper that is used to implement of_irq_count()
tries to resolve interrupts and in fact creates a mapping for resolved
interrupts. That's pretty heavy lifting for something that claims to
just return the number of interrupts requested by a given device node.

Instead, use the more lightweight of_irq_map_one(), which, despite the
name, doesn't create an actual mapping. Perhaps a better name would be
of_irq_translate_one().

Signed-off-by: Thierry Reding <treding@nvidia.com>
---
 drivers/of/irq.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/of/irq.c b/drivers/of/irq.c
index 1752988..5f44388 100644
--- a/drivers/of/irq.c
+++ b/drivers/of/irq.c
@@ -368,9 +368,10 @@ EXPORT_SYMBOL_GPL(of_irq_to_resource);
  */
 int of_irq_count(struct device_node *dev)
 {
+	struct of_irq irq;
 	int nr = 0;
 
-	while (of_irq_to_resource(dev, nr, NULL))
+	while (of_irq_map_one(dev, nr, &irq) == 0)
 		nr++;
 
 	return nr;
-- 
1.8.4
