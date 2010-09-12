Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 12 Sep 2010 07:11:17 +0200 (CEST)
Received: from mail.perches.com ([173.55.12.10]:1757 "EHLO mail.perches.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1490984Ab0ILFLO (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sun, 12 Sep 2010 07:11:14 +0200
Received: from Joe-Laptop.home (unknown [192.168.1.162])
        by mail.perches.com (Postfix) with ESMTP id 260D42436E;
        Sat, 11 Sep 2010 22:10:56 -0700 (PDT)
From:   Joe Perches <joe@perches.com>
To:     Jiri Kosina <trivial@kernel.org>
Cc:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 04/11] arch/mips: Remove pr_<level> uses of KERN_<level>
Date:   Sat, 11 Sep 2010 22:10:52 -0700
Message-Id: <c3b4d799ec7338f31638d90bef10d3d89208ae89.1284267142.git.joe@perches.com>
X-Mailer: git-send-email 1.7.3.rc1
In-Reply-To: <cover.1284267142.git.joe@perches.com>
References: <cover.1284267142.git.joe@perches.com>
X-archive-position: 27746
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: joe@perches.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                 
X-UID: 9211

Signed-off-by: Joe Perches <joe@perches.com>
---
 arch/mips/kernel/irq-gic.c  |    2 +-
 arch/mips/pci/pci-rc32434.c |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/mips/kernel/irq-gic.c b/arch/mips/kernel/irq-gic.c
index b181f2f..8d8a6ba 100644
--- a/arch/mips/kernel/irq-gic.c
+++ b/arch/mips/kernel/irq-gic.c
@@ -131,7 +131,7 @@ static int gic_set_affinity(unsigned int irq, const struct cpumask *cpumask)
 	int		i;
 
 	irq -= _irqbase;
-	pr_debug(KERN_DEBUG "%s(%d) called\n", __func__, irq);
+	pr_debug("%s(%d) called\n", __func__, irq);
 	cpumask_and(&tmp, cpumask, cpu_online_mask);
 	if (cpus_empty(tmp))
 		return -1;
diff --git a/arch/mips/pci/pci-rc32434.c b/arch/mips/pci/pci-rc32434.c
index 71f7d27..f31218e 100644
--- a/arch/mips/pci/pci-rc32434.c
+++ b/arch/mips/pci/pci-rc32434.c
@@ -118,7 +118,7 @@ static int __init rc32434_pcibridge_init(void)
 	if (!((pcicvalue == PCIM_H_EA) ||
 	      (pcicvalue == PCIM_H_IA_FIX) ||
 	      (pcicvalue == PCIM_H_IA_RR))) {
-		pr_err(KERN_ERR "PCI init error!!!\n");
+		pr_err("PCI init error!!!\n");
 		/* Not in Host Mode, return ERROR */
 		return -1;
 	}
-- 
1.7.3.rc1
