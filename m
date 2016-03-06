Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 06 Mar 2016 22:29:06 +0100 (CET)
Received: from hauke-m.de ([5.39.93.123]:37383 "EHLO hauke-m.de"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27006677AbcCFV3FFHltB (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sun, 6 Mar 2016 22:29:05 +0100
Received: from hauke-desktop.fritz.box (p5DE968F0.dip0.t-ipconnect.de [93.233.104.240])
        by hauke-m.de (Postfix) with ESMTPSA id 1983E1001AD;
        Sun,  6 Mar 2016 22:29:02 +0100 (CET)
From:   Hauke Mehrtens <hauke@hauke-m.de>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org
Cc:     Hauke Mehrtens <hauke@hauke-m.de>,
        Paul Burton <paul.burton@imgtec.com>,
        "# v3 . 15+" <stable@vger.kernel.org>
Subject: [PATCH v2] MIPS: fix build error when SMP is used without GIC
Date:   Sun,  6 Mar 2016 22:28:56 +0100
Message-Id: <1457299736-24669-1-git-send-email-hauke@hauke-m.de>
X-Mailer: git-send-email 2.7.0
Return-Path: <hauke@hauke-m.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 52482
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: hauke@hauke-m.de
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

The MIPS_GIC_IPI should only be selected when MIPS_GIC is also
selected, otherwise it results in a compile error. smp-gic.c uses some
functions from include/linux/irqchip/mips-gic.h like
plat_ipi_call_int_xlate() which are only added to the header file when
MIPS_GIC is set. The Lantiq SoC does not use the GIC, but supports SMP.
The calls top the functions from smp-gic.c are already protected by
some #ifdefs

The first part of this was introduced in commit 72e20142b2bf ("MIPS:
Move GIC IPI functions out of smp-cmp.c")

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
Cc: Paul Burton <paul.burton@imgtec.com>
Cc: <stable@vger.kernel.org> # v3.15+
---

Changes since v1:
 * Fix commit message based on Sergei's comments.

 arch/mips/Kconfig | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 74a3db9..d3da79d 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -2169,7 +2169,7 @@ config MIPS_MT_SMP
 	select CPU_MIPSR2_IRQ_VI
 	select CPU_MIPSR2_IRQ_EI
 	select SYNC_R4K
-	select MIPS_GIC_IPI
+	select MIPS_GIC_IPI if MIPS_GIC
 	select MIPS_MT
 	select SMP
 	select SMP_UP
@@ -2267,7 +2267,7 @@ config MIPS_VPE_APSP_API_MT
 config MIPS_CMP
 	bool "MIPS CMP framework support (DEPRECATED)"
 	depends on SYS_SUPPORTS_MIPS_CMP && !CPU_MIPSR6
-	select MIPS_GIC_IPI
+	select MIPS_GIC_IPI if MIPS_GIC
 	select SMP
 	select SYNC_R4K
 	select SYS_SUPPORTS_SMP
@@ -2287,7 +2287,7 @@ config MIPS_CPS
 	select MIPS_CM
 	select MIPS_CPC
 	select MIPS_CPS_PM if HOTPLUG_CPU
-	select MIPS_GIC_IPI
+	select MIPS_GIC_IPI if MIPS_GIC
 	select SMP
 	select SYNC_R4K if (CEVT_R4K || CSRC_R4K)
 	select SYS_SUPPORTS_HOTPLUG_CPU
@@ -2306,6 +2306,7 @@ config MIPS_CPS_PM
 	bool
 
 config MIPS_GIC_IPI
+	depends on MIPS_GIC
 	bool
 
 config MIPS_CM
-- 
2.7.0
