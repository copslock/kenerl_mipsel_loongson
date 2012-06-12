Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 12 Jun 2012 10:27:10 +0200 (CEST)
Received: from mail-bk0-f49.google.com ([209.85.214.49]:48595 "EHLO
        mail-bk0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903635Ab2FLIYj (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 12 Jun 2012 10:24:39 +0200
Received: by bkwj4 with SMTP id j4so5334495bkw.36
        for <multiple recipients>; Tue, 12 Jun 2012 01:24:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=vupu2FZxLDm4rhVdSmp5mi/PDBSRcOe/7O25ZCPMV2I=;
        b=mUCpSCROt1ulkyYcmIpktKRldmpkkQW0igL9yxJLkFSOob6vy4TTSH7UXgctxKj/U3
         NFReT0ZQSsFGcRMTKi1KuPBjoAeV6ANSAYIj/1d0QFPuAxDHSUiOYu6PuknQQ+pxHPtc
         7EUcfLEEDs0EFjaJx5PdKrqjQ5McWQnJ8AP4xKyWaiWpbQzV1GWJiHLr8tKCUrRLZmaJ
         jTJzgZAXkAvrui/iff7jZBh/+67SyH9c442bOal6gUcyhgzqRa6W+FyWoP3X/WiMS/xu
         a9mAJkCxEOPW5975tRNN3fPMROlsxWqun7vHXnGXbEQ++4nPTXgm5YXl1hNcicAnqcoK
         6p6Q==
Received: by 10.205.133.6 with SMTP id hw6mr10908733bkc.93.1339489474207;
        Tue, 12 Jun 2012 01:24:34 -0700 (PDT)
Received: from shaker64.lan (dslb-088-073-055-195.pools.arcor-ip.net. [88.73.55.195])
        by mx.google.com with ESMTPS id h18sm19177912bkh.8.2012.06.12.01.24.32
        (version=SSLv3 cipher=OTHER);
        Tue, 12 Jun 2012 01:24:33 -0700 (PDT)
From:   Jonas Gorski <jonas.gorski@gmail.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org, Maxime Bizon <mbizon@freebox.fr>,
        Florian Fainelli <florian@openwrt.org>,
        Kevin Cernekee <cernekee@gmail.com>
Subject: [PATCH 3/8] MIPS: BCM63XX: use the Chip ID register for identifying the SoC
Date:   Tue, 12 Jun 2012 10:23:40 +0200
Message-Id: <1339489425-19037-4-git-send-email-jonas.gorski@gmail.com>
X-Mailer: git-send-email 1.7.2.5
In-Reply-To: <1339489425-19037-1-git-send-email-jonas.gorski@gmail.com>
References: <1339489425-19037-1-git-send-email-jonas.gorski@gmail.com>
X-archive-position: 33615
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

Newer BCM63XX SoCs use virtually the same CPU ID, differing only in the
revision bits. But since they all have the Chip ID register at the same
location, we can use that to identify the SoC we are running on.

Signed-off-by: Jonas Gorski <jonas.gorski@gmail.com>
---
 arch/mips/bcm63xx/cpu.c |   20 ++++++++++++--------
 1 files changed, 12 insertions(+), 8 deletions(-)

diff --git a/arch/mips/bcm63xx/cpu.c b/arch/mips/bcm63xx/cpu.c
index 8f0d6c7..e3c1da5 100644
--- a/arch/mips/bcm63xx/cpu.c
+++ b/arch/mips/bcm63xx/cpu.c
@@ -228,17 +228,21 @@ void __init bcm63xx_cpu_init(void)
 		bcm63xx_irqs = bcm6345_irqs;
 		break;
 	case CPU_BMIPS4350:
-		switch (read_c0_prid() & 0xf0) {
-		case 0x10:
+		if ((read_c0_prid() & 0xf0) == 0x10) {
 			expected_cpu_id = BCM6358_CPU_ID;
 			bcm63xx_regs_base = bcm6358_regs_base;
 			bcm63xx_irqs = bcm6358_irqs;
-			break;
-		case 0x30:
-			expected_cpu_id = BCM6368_CPU_ID;
-			bcm63xx_regs_base = bcm6368_regs_base;
-			bcm63xx_irqs = bcm6368_irqs;
-			break;
+		} else {
+			/* all newer chips have the same chip id location */
+			u16 chip_id = bcm_readw(BCM_6368_PERF_BASE);
+
+			switch (chip_id) {
+			case BCM6368_CPU_ID:
+				expected_cpu_id = BCM6368_CPU_ID;
+				bcm63xx_regs_base = bcm6368_regs_base;
+				bcm63xx_irqs = bcm6368_irqs;
+				break;
+			}
 		}
 		break;
 	}
-- 
1.7.2.5
