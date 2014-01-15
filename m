Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 15 Jan 2014 11:37:53 +0100 (CET)
Received: from multi.imgtec.com ([194.200.65.239]:9565 "EHLO multi.imgtec.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6827536AbaAOKhO4eYy2 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 15 Jan 2014 11:37:14 +0100
From:   Paul Burton <paul.burton@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Paul Burton <paul.burton@imgtec.com>
Subject: [PATCH 11/15] MIPS: Malta: allow use of MIPS CPS SMP implementation
Date:   Wed, 15 Jan 2014 10:31:56 +0000
Message-ID: <1389781920-31151-12-git-send-email-paul.burton@imgtec.com>
X-Mailer: git-send-email 1.7.12.4
In-Reply-To: <1389781920-31151-1-git-send-email-paul.burton@imgtec.com>
References: <1389781920-31151-1-git-send-email-paul.burton@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.152.22]
X-SEF-Processed: 7_3_0_01192__2014_01_15_10_37_09
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 38995
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

This patch simply attempts to register the MIPS Coherent Processing
System SMP implementation when it is enabled. If registering that fails
for some reason (like the Kconfig option being disabled or a lack of
hardware support) then we fall back to the same SMP implementations as
before.

Signed-off-by: Paul Burton <paul.burton@imgtec.com>
---
 arch/mips/Kconfig                | 1 +
 arch/mips/mti-malta/malta-init.c | 2 ++
 2 files changed, 3 insertions(+)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index ba5d8ac..868226e 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -325,6 +325,7 @@ config MIPS_MALTA
 	select SYS_SUPPORTS_BIG_ENDIAN
 	select SYS_SUPPORTS_LITTLE_ENDIAN
 	select SYS_SUPPORTS_MIPS_CMP
+	select SYS_SUPPORTS_MIPS_CPS
 	select SYS_SUPPORTS_MULTITHREADING
 	select SYS_SUPPORTS_SMARTMIPS
 	select SYS_SUPPORTS_ZBOOT
diff --git a/arch/mips/mti-malta/malta-init.c b/arch/mips/mti-malta/malta-init.c
index 1381365..eebb2d15 100644
--- a/arch/mips/mti-malta/malta-init.c
+++ b/arch/mips/mti-malta/malta-init.c
@@ -285,6 +285,8 @@ mips_pci_controller:
 	mips_cm_probe();
 	mips_cpc_probe();
 
+	if (!register_cps_smp_ops())
+		return;
 	if (!register_cmp_smp_ops())
 		return;
 	if (!register_vsmp_smp_ops())
-- 
1.8.4.2
