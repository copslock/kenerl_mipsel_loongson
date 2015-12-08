Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 08 Dec 2015 14:26:53 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:6885 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27013396AbbLHNVu0H20Z (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 8 Dec 2015 14:21:50 +0100
Received: from hhmail02.hh.imgtec.org (unknown [10.100.10.20])
        by Websense Email Security Gateway with ESMTPS id 54E912C63BA71;
        Tue,  8 Dec 2015 13:21:42 +0000 (GMT)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 hhmail02.hh.imgtec.org (10.100.10.20) with Microsoft SMTP Server (TLS) id
 14.3.235.1; Tue, 8 Dec 2015 13:21:44 +0000
Received: from qyousef-linux.le.imgtec.org (192.168.154.94) by
 LEMAIL01.le.imgtec.org (192.168.152.62) with Microsoft SMTP Server (TLS) id
 14.3.210.2; Tue, 8 Dec 2015 13:21:44 +0000
From:   Qais Yousef <qais.yousef@imgtec.com>
To:     <linux-kernel@vger.kernel.org>
CC:     <tglx@linutronix.de>, <jason@lakedaemon.net>,
        <marc.zyngier@arm.com>, <jiang.liu@linux.intel.com>,
        <ralf@linux-mips.org>, <linux-mips@linux-mips.org>,
        <lisa.parratt@imgtec.com>, Qais Yousef <qais.yousef@imgtec.com>
Subject: [PATCH v4 18/19] MIPS: Delete smp-gic.c
Date:   Tue, 8 Dec 2015 13:20:29 +0000
Message-ID: <1449580830-23652-19-git-send-email-qais.yousef@imgtec.com>
X-Mailer: git-send-email 2.1.0
In-Reply-To: <1449580830-23652-1-git-send-email-qais.yousef@imgtec.com>
References: <1449580830-23652-1-git-send-email-qais.yousef@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.154.94]
Return-Path: <Qais.Yousef@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 50442
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: qais.yousef@imgtec.com
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

We now have a generic IPI layer that will use GIC automatically
if it's compiled in.

Signed-off-by: Qais Yousef <qais.yousef@imgtec.com>
---
 arch/mips/Kconfig         | 6 ------
 arch/mips/kernel/Makefile | 1 -
 2 files changed, 7 deletions(-)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 71683a853372..ff13d823fe95 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -2155,7 +2155,6 @@ config MIPS_MT_SMP
 	select CPU_MIPSR2_IRQ_VI
 	select CPU_MIPSR2_IRQ_EI
 	select SYNC_R4K
-	select MIPS_GIC_IPI
 	select MIPS_MT
 	select SMP
 	select SMP_UP
@@ -2253,7 +2252,6 @@ config MIPS_VPE_APSP_API_MT
 config MIPS_CMP
 	bool "MIPS CMP framework support (DEPRECATED)"
 	depends on SYS_SUPPORTS_MIPS_CMP && !CPU_MIPSR6
-	select MIPS_GIC_IPI
 	select SMP
 	select SYNC_R4K
 	select SYS_SUPPORTS_SMP
@@ -2273,7 +2271,6 @@ config MIPS_CPS
 	select MIPS_CM
 	select MIPS_CPC
 	select MIPS_CPS_PM if HOTPLUG_CPU
-	select MIPS_GIC_IPI
 	select SMP
 	select SYNC_R4K if (CEVT_R4K || CSRC_R4K)
 	select SYS_SUPPORTS_HOTPLUG_CPU
@@ -2291,9 +2288,6 @@ config MIPS_CPS_PM
 	select MIPS_CPC
 	bool
 
-config MIPS_GIC_IPI
-	bool
-
 config MIPS_CM
 	bool
 
diff --git a/arch/mips/kernel/Makefile b/arch/mips/kernel/Makefile
index 68e2b7db9348..b0988fd62fcc 100644
--- a/arch/mips/kernel/Makefile
+++ b/arch/mips/kernel/Makefile
@@ -52,7 +52,6 @@ obj-$(CONFIG_MIPS_MT_SMP)	+= smp-mt.o
 obj-$(CONFIG_MIPS_CMP)		+= smp-cmp.o
 obj-$(CONFIG_MIPS_CPS)		+= smp-cps.o cps-vec.o
 obj-$(CONFIG_MIPS_CPS_NS16550)	+= cps-vec-ns16550.o
-obj-$(CONFIG_MIPS_GIC_IPI)	+= smp-gic.o
 obj-$(CONFIG_MIPS_SPRAM)	+= spram.o
 
 obj-$(CONFIG_MIPS_VPE_LOADER)	+= vpe.o
-- 
2.1.0
