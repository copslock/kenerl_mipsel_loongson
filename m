Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 13 Jul 2012 10:48:43 +0200 (CEST)
Received: from mail-bk0-f49.google.com ([209.85.214.49]:50181 "EHLO
        mail-bk0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903610Ab2GMIrd (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 13 Jul 2012 10:47:33 +0200
Received: by bkcji2 with SMTP id ji2so2825853bkc.36
        for <multiple recipients>; Fri, 13 Jul 2012 01:47:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=7fIoExIxF/X7rOHeZHnEdPF7vheRp9RUMIDq1RTSBCE=;
        b=y7jmscREAE0x05/QSKOoRJnmDIRL4FA8lco3i6LZygxW2OEDkoZWb/UeAtkPpo/Izh
         aUXzYl59H9TJ2qHi1UxI3Pjo/mGbUoDuEo7UAxTeHCVly6GfmEPTZCc3zHDEaBz8V9zv
         HJXcqSoY8kmQhGvmxGFV3bVS0OKN5LdU6pMZ05H4RrBImsqEvzd228M2HrBV5WfoT346
         cEbf4ShCokoGYoRfSin0Bw+t8hYOF7kaczeIjylfUoY94hy8enGnvZA+gL7OaljAxy/q
         GlSXSQ4YTeZT2Ym5XBRP45MyeNaqHlm+2GYmslrD/mJ5znbH3r+06uFweSySaU6OTPX/
         wqWA==
Received: by 10.204.152.152 with SMTP id g24mr146323bkw.104.1342169247988;
        Fri, 13 Jul 2012 01:47:27 -0700 (PDT)
Received: from shaker64.lan (dslb-088-073-145-009.pools.arcor-ip.net. [88.73.145.9])
        by mx.google.com with ESMTPS id hg13sm4243506bkc.7.2012.07.13.01.47.26
        (version=SSLv3 cipher=OTHER);
        Fri, 13 Jul 2012 01:47:27 -0700 (PDT)
From:   Jonas Gorski <jonas.gorski@gmail.com>
To:     linux-mips@linux-mips.org
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Florian Fainelli <florian@openwrt.org>,
        Maxime Bizon <mbizon@freebox.fr>,
        Kevin Cernekee <cernekee@gmail.com>
Subject: [PATCH 3/3] MIPS: BCM63XX: use a switch for external irq config
Date:   Fri, 13 Jul 2012 10:46:05 +0200
Message-Id: <1342169165-18382-4-git-send-email-jonas.gorski@gmail.com>
X-Mailer: git-send-email 1.7.2.5
In-Reply-To: <1342169165-18382-1-git-send-email-jonas.gorski@gmail.com>
References: <1342169165-18382-1-git-send-email-jonas.gorski@gmail.com>
X-archive-position: 33906
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jonas.gorski@gmail.com
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
Return-Path: <linux-mips-bounce@linux-mips.org>

From: Maxime Bizon <mbizon@freebox.fr>

Makes the code a bit more readable and easier to add support for
new chips.

Signed-off-by: Maxime Bizon <mbizon@freebox.fr>
Signed-off-by: Jonas Gorski <jonas.gorski@gmail.com>
---
 arch/mips/bcm63xx/irq.c |   14 +++++++++++---
 1 files changed, 11 insertions(+), 3 deletions(-)

diff --git a/arch/mips/bcm63xx/irq.c b/arch/mips/bcm63xx/irq.c
index d40169f..da24c2b 100644
--- a/arch/mips/bcm63xx/irq.c
+++ b/arch/mips/bcm63xx/irq.c
@@ -438,7 +438,8 @@ static int bcm63xx_external_irq_set_type(struct irq_data *d,
 	reg = bcm_perf_readl(regaddr);
 	irq %= 4;
 
-	if (BCMCPU_IS_6348()) {
+	switch (bcm63xx_get_cpu_id()) {
+	case BCM6348_CPU_ID:
 		if (levelsense)
 			reg |= EXTIRQ_CFG_LEVELSENSE_6348(irq);
 		else
@@ -451,9 +452,13 @@ static int bcm63xx_external_irq_set_type(struct irq_data *d,
 			reg |= EXTIRQ_CFG_BOTHEDGE_6348(irq);
 		else
 			reg &= ~EXTIRQ_CFG_BOTHEDGE_6348(irq);
-	}
+		break;
 
-	if (BCMCPU_IS_6338() || BCMCPU_IS_6358() || BCMCPU_IS_6368()) {
+	case BCM6328_CPU_ID:
+	case BCM6338_CPU_ID:
+	case BCM6345_CPU_ID:
+	case BCM6358_CPU_ID:
+	case BCM6368_CPU_ID:
 		if (levelsense)
 			reg |= EXTIRQ_CFG_LEVELSENSE(irq);
 		else
@@ -466,6 +471,9 @@ static int bcm63xx_external_irq_set_type(struct irq_data *d,
 			reg |= EXTIRQ_CFG_BOTHEDGE(irq);
 		else
 			reg &= ~EXTIRQ_CFG_BOTHEDGE(irq);
+		break;
+	default:
+		BUG();
 	}
 
 	bcm_perf_writel(reg, regaddr);
-- 
1.7.2.5
