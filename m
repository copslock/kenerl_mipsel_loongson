Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 26 Mar 2016 18:30:04 +0100 (CET)
Received: from userp1040.oracle.com ([156.151.31.81]:40369 "EHLO
        userp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27025236AbcCZR3okAO0u (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 26 Mar 2016 18:29:44 +0100
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
        by userp1040.oracle.com (Sentrion-MTA-4.3.2/Sentrion-MTA-4.3.2) with ESMTP id u2QHTVqs016332
        (version=TLSv1 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK);
        Sat, 26 Mar 2016 17:29:32 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userv0021.oracle.com (8.13.8/8.13.8) with ESMTP id u2QHTVof011192
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK);
        Sat, 26 Mar 2016 17:29:31 GMT
Received: from abhmp0014.oracle.com (abhmp0014.oracle.com [141.146.116.20])
        by userv0121.oracle.com (8.13.8/8.13.8) with ESMTP id u2QHTUeN012061;
        Sat, 26 Mar 2016 17:29:31 GMT
Received: from localhost.localdomain (/73.159.178.34)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Sat, 26 Mar 2016 10:29:29 -0700
From:   Sasha Levin <sasha.levin@oracle.com>
To:     stable@vger.kernel.org, stable-commits@vger.kernel.org
Cc:     Markos Chandras <markos.chandras@imgtec.com>,
        linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>,
        Sasha Levin <sasha.levin@oracle.com>
Subject: [added to the 4.1 stable tree] MIPS: Kconfig: Disable MIPS MT and SMP implementations for R6
Date:   Sat, 26 Mar 2016 13:28:40 -0400
Message-Id: <1459013330-15318-36-git-send-email-sasha.levin@oracle.com>
X-Mailer: git-send-email 2.5.0
In-Reply-To: <1459013330-15318-1-git-send-email-sasha.levin@oracle.com>
References: <1459013330-15318-1-git-send-email-sasha.levin@oracle.com>
X-Source-IP: userv0021.oracle.com [156.151.31.71]
Return-Path: <sasha.levin@oracle.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 52704
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sasha.levin@oracle.com
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

From: Markos Chandras <markos.chandras@imgtec.com>

This patch has been added to the 4.1 stable tree. If you have any
objections, please let us know.

===============

[ Upstream commit 5676319c91c8d668635ac0b9b6d9145c4fa418ac ]

R6 does not support the MIPS MT ASE and the CMP/SMP options so
restrict them in order to prevent users from selecting incompatible
SMP configuration for R6 cores. We also disable the CPS/SMP option
because its support hasn't been added to the CPS code yet.

Signed-off-by: Markos Chandras <markos.chandras@imgtec.com>
Cc: linux-mips@linux-mips.org
Patchwork: https://patchwork.linux-mips.org/patch/10637/
Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
Signed-off-by: Sasha Levin <sasha.levin@oracle.com>
---
 arch/mips/Kconfig | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index d9f4612..8901acf 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -2103,7 +2103,7 @@ config CPU_R4K_CACHE_TLB
 
 config MIPS_MT_SMP
 	bool "MIPS MT SMP support (1 TC on each available VPE)"
-	depends on SYS_SUPPORTS_MULTITHREADING
+	depends on SYS_SUPPORTS_MULTITHREADING && !CPU_MIPSR6
 	select CPU_MIPSR2_IRQ_VI
 	select CPU_MIPSR2_IRQ_EI
 	select SYNC_R4K
@@ -2204,7 +2204,7 @@ config MIPS_VPE_APSP_API_MT
 
 config MIPS_CMP
 	bool "MIPS CMP framework support (DEPRECATED)"
-	depends on SYS_SUPPORTS_MIPS_CMP
+	depends on SYS_SUPPORTS_MIPS_CMP && !CPU_MIPSR6
 	select MIPS_GIC_IPI
 	select SMP
 	select SYNC_R4K
@@ -2221,7 +2221,7 @@ config MIPS_CMP
 
 config MIPS_CPS
 	bool "MIPS Coherent Processing System support"
-	depends on SYS_SUPPORTS_MIPS_CPS
+	depends on SYS_SUPPORTS_MIPS_CPS && !CPU_MIPSR6
 	select MIPS_CM
 	select MIPS_CPC
 	select MIPS_CPS_PM if HOTPLUG_CPU
-- 
2.5.0
