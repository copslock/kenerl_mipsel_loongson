Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 26 Mar 2016 18:30:44 +0100 (CET)
Received: from userp1040.oracle.com ([156.151.31.81]:40375 "EHLO
        userp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27025240AbcCZR3qLZK6u (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 26 Mar 2016 18:29:46 +0100
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
        by userp1040.oracle.com (Sentrion-MTA-4.3.2/Sentrion-MTA-4.3.2) with ESMTP id u2QHTWHN016336
        (version=TLSv1 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK);
        Sat, 26 Mar 2016 17:29:32 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userv0021.oracle.com (8.13.8/8.13.8) with ESMTP id u2QHTW9x011203
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK);
        Sat, 26 Mar 2016 17:29:32 GMT
Received: from abhmp0014.oracle.com (abhmp0014.oracle.com [141.146.116.20])
        by userv0121.oracle.com (8.13.8/8.13.8) with ESMTP id u2QHTULq012062;
        Sat, 26 Mar 2016 17:29:31 GMT
Received: from localhost.localdomain (/73.159.178.34)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Sat, 26 Mar 2016 10:29:30 -0700
From:   Sasha Levin <sasha.levin@oracle.com>
To:     stable@vger.kernel.org, stable-commits@vger.kernel.org
Cc:     Hauke Mehrtens <hauke@hauke-m.de>,
        Paul Burton <paul.burton@imgtec.com>,
        linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sasha Levin <sasha.levin@oracle.com>
Subject: [added to the 4.1 stable tree] MIPS: Fix build error when SMP is used without GIC
Date:   Sat, 26 Mar 2016 13:28:41 -0400
Message-Id: <1459013330-15318-37-git-send-email-sasha.levin@oracle.com>
X-Mailer: git-send-email 2.5.0
In-Reply-To: <1459013330-15318-1-git-send-email-sasha.levin@oracle.com>
References: <1459013330-15318-1-git-send-email-sasha.levin@oracle.com>
X-Source-IP: userv0021.oracle.com [156.151.31.71]
Return-Path: <sasha.levin@oracle.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 52706
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

From: Hauke Mehrtens <hauke@hauke-m.de>

This patch has been added to the 4.1 stable tree. If you have any
objections, please let us know.

===============

[ Upstream commit 588bad2ef32cae7abad24d5ca2f4611a7a7fb2a2 ]

commit 7a50e4688dabb8005df39b2b992d76629b8af8aa upstream.

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
Cc: linux-mips@linux-mips.org
Patchwork: https://patchwork.linux-mips.org/patch/12774/
Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sasha.levin@oracle.com>
---
 arch/mips/Kconfig | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 8901acf..c99e8a3 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -2107,7 +2107,7 @@ config MIPS_MT_SMP
 	select CPU_MIPSR2_IRQ_VI
 	select CPU_MIPSR2_IRQ_EI
 	select SYNC_R4K
-	select MIPS_GIC_IPI
+	select MIPS_GIC_IPI if MIPS_GIC
 	select MIPS_MT
 	select SMP
 	select SMP_UP
@@ -2205,7 +2205,7 @@ config MIPS_VPE_APSP_API_MT
 config MIPS_CMP
 	bool "MIPS CMP framework support (DEPRECATED)"
 	depends on SYS_SUPPORTS_MIPS_CMP && !CPU_MIPSR6
-	select MIPS_GIC_IPI
+	select MIPS_GIC_IPI if MIPS_GIC
 	select SMP
 	select SYNC_R4K
 	select SYS_SUPPORTS_SMP
@@ -2225,7 +2225,7 @@ config MIPS_CPS
 	select MIPS_CM
 	select MIPS_CPC
 	select MIPS_CPS_PM if HOTPLUG_CPU
-	select MIPS_GIC_IPI
+	select MIPS_GIC_IPI if MIPS_GIC
 	select SMP
 	select SYNC_R4K if (CEVT_R4K || CSRC_R4K)
 	select SYS_SUPPORTS_HOTPLUG_CPU
@@ -2244,6 +2244,7 @@ config MIPS_CPS_PM
 	bool
 
 config MIPS_GIC_IPI
+	depends on MIPS_GIC
 	bool
 
 config MIPS_CM
-- 
2.5.0
