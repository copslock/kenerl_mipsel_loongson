Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 12 Jun 2012 10:26:18 +0200 (CEST)
Received: from mail-bk0-f49.google.com ([209.85.214.49]:54586 "EHLO
        mail-bk0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903630Ab2FLIYh (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 12 Jun 2012 10:24:37 +0200
Received: by mail-bk0-f49.google.com with SMTP id j4so5334449bkw.36
        for <multiple recipients>; Tue, 12 Jun 2012 01:24:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=qq4OWip0gRX3wTKaP4KZm0q8silPzXYKYdvv6vtW/oI=;
        b=0nq9RUD6CKx9BEaPjV177V8Tvn45E6jvwzKp/g+d/I8aP48AK8bf2UfmURM0rF07uR
         vU9LLP4/5SrVaRDAAlFSRPx9aQnCxfWm8B20hk/7QMQ/q525JlQ4nrOYQVDBE6lNj+pq
         7kyKXm3qiRRTpCHS2Hett3I+QzlIaRHrtKH5z8rgQCcXEskVBUCPUhQySUIqCUxJ56dZ
         b1IgWoJUKx41sa+rVoGPAsY0XRiPRQAJMsyAewQxRMzF+tDPkjjVGbFmJ+YOaodQvhqF
         45oRicR6/HidNBIuCYbijmuD5BUjL0W7fBBnwPEICCuuxJ79mlikv2RsEZpz8yJHOUez
         bA5Q==
Received: by 10.204.129.87 with SMTP id n23mr11326826bks.19.1339489477667;
        Tue, 12 Jun 2012 01:24:37 -0700 (PDT)
Received: from shaker64.lan (dslb-088-073-055-195.pools.arcor-ip.net. [88.73.55.195])
        by mx.google.com with ESMTPS id h18sm19177912bkh.8.2012.06.12.01.24.36
        (version=SSLv3 cipher=OTHER);
        Tue, 12 Jun 2012 01:24:36 -0700 (PDT)
From:   Jonas Gorski <jonas.gorski@gmail.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org, Maxime Bizon <mbizon@freebox.fr>,
        Florian Fainelli <florian@openwrt.org>,
        Kevin Cernekee <cernekee@gmail.com>
Subject: [PATCH 5/8] MIPS: BCM63XX: Move the PCI initialization into its own function
Date:   Tue, 12 Jun 2012 10:23:42 +0200
Message-Id: <1339489425-19037-6-git-send-email-jonas.gorski@gmail.com>
X-Mailer: git-send-email 1.7.2.5
In-Reply-To: <1339489425-19037-1-git-send-email-jonas.gorski@gmail.com>
References: <1339489425-19037-1-git-send-email-jonas.gorski@gmail.com>
X-archive-position: 33613
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

Also make the cpu check a bit more explicit.

Signed-off-by: Jonas Gorski <jonas.gorski@gmail.com>
---
 arch/mips/pci/pci-bcm63xx.c |   25 +++++++++++++++++--------
 1 files changed, 17 insertions(+), 8 deletions(-)

diff --git a/arch/mips/pci/pci-bcm63xx.c b/arch/mips/pci/pci-bcm63xx.c
index 39eb7c4..a2b6d55 100644
--- a/arch/mips/pci/pci-bcm63xx.c
+++ b/arch/mips/pci/pci-bcm63xx.c
@@ -94,17 +94,10 @@ static void bcm63xx_int_cfg_writel(u32 val, u32 reg)
 
 void __iomem *pci_iospace_start;
 
-static int __init bcm63xx_pci_init(void)
+static int __init bcm63xx_register_pci(void)
 {
 	unsigned int mem_size;
 	u32 val;
-
-	if (!BCMCPU_IS_6348() && !BCMCPU_IS_6358() && !BCMCPU_IS_6368())
-		return -ENODEV;
-
-	if (!bcm63xx_pci_enabled)
-		return -ENODEV;
-
 	/*
 	 * configuration  access are  done through  IO space,  remap 4
 	 * first bytes to access it from CPU.
@@ -221,4 +214,20 @@ static int __init bcm63xx_pci_init(void)
 	return 0;
 }
 
+
+static int __init bcm63xx_pci_init(void)
+{
+	if (!bcm63xx_pci_enabled)
+		return -ENODEV;
+
+	switch (bcm63xx_get_cpu_id()) {
+	case BCM6348_CPU_ID:
+	case BCM6358_CPU_ID:
+	case BCM6368_CPU_ID:
+		return bcm63xx_register_pci();
+	default:
+		return -ENODEV;
+	}
+}
+
 arch_initcall(bcm63xx_pci_init);
-- 
1.7.2.5
