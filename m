Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 16 Mar 2016 00:33:37 +0100 (CET)
Received: from youngberry.canonical.com ([91.189.89.112]:41785 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27006686AbcCOXdfyb5ow (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 16 Mar 2016 00:33:35 +0100
Received: from 1.general.kamal.us.vpn ([10.172.68.52] helo=fourier)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_128_CBC_SHA1:16)
        (Exim 4.76)
        (envelope-from <kamal@canonical.com>)
        id 1afyT0-0001c0-P0; Tue, 15 Mar 2016 23:33:34 +0000
Received: from kamal by fourier with local (Exim 4.86)
        (envelope-from <kamal@whence.com>)
        id 1afySy-0006A5-34; Tue, 15 Mar 2016 16:33:32 -0700
From:   Kamal Mostafa <kamal@canonical.com>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        kernel-team@lists.ubuntu.com
Cc:     Hauke Mehrtens <hauke@hauke-m.de>,
        Paul Burton <paul.burton@imgtec.com>,
        linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>,
        Kamal Mostafa <kamal@canonical.com>
Subject: [PATCH 4.2.y-ckt 83/98] MIPS: Fix build error when SMP is used without GIC
Date:   Tue, 15 Mar 2016 16:31:17 -0700
Message-Id: <1458084692-23100-84-git-send-email-kamal@canonical.com>
X-Mailer: git-send-email 2.7.0
In-Reply-To: <1458084692-23100-1-git-send-email-kamal@canonical.com>
References: <1458084692-23100-1-git-send-email-kamal@canonical.com>
X-Extended-Stable: 4.2
Return-Path: <kamal@canonical.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 52601
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kamal@canonical.com
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

4.2.8-ckt6 -stable review patch.  If anyone has any objections, please let me know.

---8<------------------------------------------------------------

From: Hauke Mehrtens <hauke@hauke-m.de>

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
Signed-off-by: Kamal Mostafa <kamal@canonical.com>
---
 arch/mips/Kconfig | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 199a835..dbf9fa3 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -2117,7 +2117,7 @@ config MIPS_MT_SMP
 	select CPU_MIPSR2_IRQ_VI
 	select CPU_MIPSR2_IRQ_EI
 	select SYNC_R4K
-	select MIPS_GIC_IPI
+	select MIPS_GIC_IPI if MIPS_GIC
 	select MIPS_MT
 	select SMP
 	select SMP_UP
@@ -2215,7 +2215,7 @@ config MIPS_VPE_APSP_API_MT
 config MIPS_CMP
 	bool "MIPS CMP framework support (DEPRECATED)"
 	depends on SYS_SUPPORTS_MIPS_CMP
-	select MIPS_GIC_IPI
+	select MIPS_GIC_IPI if MIPS_GIC
 	select SMP
 	select SYNC_R4K
 	select SYS_SUPPORTS_SMP
@@ -2235,7 +2235,7 @@ config MIPS_CPS
 	select MIPS_CM
 	select MIPS_CPC
 	select MIPS_CPS_PM if HOTPLUG_CPU
-	select MIPS_GIC_IPI
+	select MIPS_GIC_IPI if MIPS_GIC
 	select SMP
 	select SYNC_R4K if (CEVT_R4K || CSRC_R4K)
 	select SYS_SUPPORTS_HOTPLUG_CPU
@@ -2254,6 +2254,7 @@ config MIPS_CPS_PM
 	bool
 
 config MIPS_GIC_IPI
+	depends on MIPS_GIC
 	bool
 
 config MIPS_CM
-- 
2.7.0
