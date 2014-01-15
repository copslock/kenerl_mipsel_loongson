Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 15 Jan 2014 11:38:31 +0100 (CET)
Received: from multi.imgtec.com ([194.200.65.239]:9581 "EHLO multi.imgtec.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6828766AbaAOKh2vmHMX (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 15 Jan 2014 11:37:28 +0100
From:   Paul Burton <paul.burton@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Paul Burton <paul.burton@imgtec.com>
Subject: [PATCH 13/15] MIPS: more helpful CONFIG_MIPS_CMP label, help text
Date:   Wed, 15 Jan 2014 10:31:58 +0000
Message-ID: <1389781920-31151-14-git-send-email-paul.burton@imgtec.com>
X-Mailer: git-send-email 1.7.12.4
In-Reply-To: <1389781920-31151-1-git-send-email-paul.burton@imgtec.com>
References: <1389781920-31151-1-git-send-email-paul.burton@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.152.22]
X-SEF-Processed: 7_3_0_01192__2014_01_15_10_37_23
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 38997
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: paul.burton@imgtec.com
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

The prior help text introduced in commit f55afb0969cc "MIPS: Clean up
MIPS MT and CMP configuration options." reads as though this option
enables the kernel to make use of the CM hardware, which is not true.
What it actually does is allow the kernel to interact with the YAMON
bootloader which actually interacts with the CM hardware to bring up
secondary cores. Re-introduce the word "framework" which that commit
removed to avoid misleading people.

Signed-off-by: Paul Burton <paul.burton@imgtec.com>
---
 arch/mips/Kconfig | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 868226e..1cd7148 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -1980,14 +1980,16 @@ config MIPS_VPE_APSP_API_MT
 	depends on MIPS_VPE_APSP_API && !MIPS_CMP
 
 config MIPS_CMP
-	bool "MIPS CMP support"
+	bool "MIPS CMP framework support"
 	depends on SYS_SUPPORTS_MIPS_CMP && MIPS_MT_SMP
 	select MIPS_GIC_IPI
 	select SYNC_R4K
 	select WEAK_ORDERING
 	default n
 	help
-	  Enable Coherency Manager processor (CMP) support.
+	  Select this if you are using a bootloader which implements the "CMP
+	  framework" protocol (ie. YAMON) and want your kernel to make use of
+	  its ability to start secondary CPUs.
 
 config MIPS_CPS
 	bool "MIPS Coherent Processing System support"
-- 
1.8.4.2
