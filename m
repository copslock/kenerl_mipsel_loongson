Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 09 Jul 2015 11:42:26 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:58766 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27009907AbbGIJlgPqanh (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 9 Jul 2015 11:41:36 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id C360F2F58C21E
        for <linux-mips@linux-mips.org>; Thu,  9 Jul 2015 10:41:28 +0100 (IST)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Thu, 9 Jul 2015 10:41:30 +0100
Received: from mchandras-linux.le.imgtec.org (192.168.154.48) by
 LEMAIL01.le.imgtec.org (192.168.152.62) with Microsoft SMTP Server (TLS) id
 14.3.210.2; Thu, 9 Jul 2015 10:41:30 +0100
From:   Markos Chandras <markos.chandras@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Markos Chandras <markos.chandras@imgtec.com>
Subject: [PATCH 04/19] MIPS: Kconfig: Disable MIPS MT and SMP implementations for R6
Date:   Thu, 9 Jul 2015 10:40:38 +0100
Message-ID: <1436434853-30001-5-git-send-email-markos.chandras@imgtec.com>
X-Mailer: git-send-email 2.4.5
In-Reply-To: <1436434853-30001-1-git-send-email-markos.chandras@imgtec.com>
References: <1436434853-30001-1-git-send-email-markos.chandras@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.154.48]
Return-Path: <Markos.Chandras@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 48141
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: markos.chandras@imgtec.com
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

R6 does not support the MIPS MT ASE and the CMP/SMP options so
restrict them in order to prevent users from selecting incompatible
SMP configuration for R6 cores. We also disable the CPS/SMP option
because its support hasn't been added to the CPS code yet.

Signed-off-by: Markos Chandras <markos.chandras@imgtec.com>
---
 arch/mips/Kconfig | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 2a14585c90d2..51bc4873e7e8 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -2113,7 +2113,7 @@ config CPU_R4K_CACHE_TLB
 
 config MIPS_MT_SMP
 	bool "MIPS MT SMP support (1 TC on each available VPE)"
-	depends on SYS_SUPPORTS_MULTITHREADING
+	depends on SYS_SUPPORTS_MULTITHREADING && !CPU_MIPSR6
 	select CPU_MIPSR2_IRQ_VI
 	select CPU_MIPSR2_IRQ_EI
 	select SYNC_R4K
@@ -2214,7 +2214,7 @@ config MIPS_VPE_APSP_API_MT
 
 config MIPS_CMP
 	bool "MIPS CMP framework support (DEPRECATED)"
-	depends on SYS_SUPPORTS_MIPS_CMP
+	depends on SYS_SUPPORTS_MIPS_CMP && !CPU_MIPSR6
 	select MIPS_GIC_IPI
 	select SMP
 	select SYNC_R4K
@@ -2231,7 +2231,7 @@ config MIPS_CMP
 
 config MIPS_CPS
 	bool "MIPS Coherent Processing System support"
-	depends on SYS_SUPPORTS_MIPS_CPS && !64BIT
+	depends on SYS_SUPPORTS_MIPS_CPS && !64BIT && !CPU_MIPSR6
 	select MIPS_CM
 	select MIPS_CPC
 	select MIPS_CPS_PM if HOTPLUG_CPU
-- 
2.4.5
