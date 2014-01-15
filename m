Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 15 Jan 2014 11:38:50 +0100 (CET)
Received: from multi.imgtec.com ([194.200.65.239]:9590 "EHLO multi.imgtec.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6827313AbaAOKhuos2Nx (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 15 Jan 2014 11:37:50 +0100
From:   Paul Burton <paul.burton@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Paul Burton <paul.burton@imgtec.com>
Subject: [PATCH 14/15] MIPS: MIPS_CMP should depend upon !SMTC, not upon SMVP
Date:   Wed, 15 Jan 2014 10:31:59 +0000
Message-ID: <1389781920-31151-15-git-send-email-paul.burton@imgtec.com>
X-Mailer: git-send-email 1.7.12.4
In-Reply-To: <1389781920-31151-1-git-send-email-paul.burton@imgtec.com>
References: <1389781920-31151-1-git-send-email-paul.burton@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.152.22]
X-SEF-Processed: 7_3_0_01192__2014_01_15_10_37_45
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 38998
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

Commit f55afb0969cc "MIPS: Clean up MIPS MT and CMP configuration
options." introduced a dependency upon MIPS_MT_SMP (ie. SMVP) for the
MIPS_CMP (ie. CMP framework support) Kconfig option. It did not specify
why, and that dependency is bogus. It is perfectly valid to have a
multi-core system with the YAMON bootloader but without MT support -
an example of this would be any multi-core proAptiv bitstream running on
a Malta. Forcing MT support to be enabled in a kernel for such a system
is incorrect. I suspect that the dependency was actually meant to
reflect the fact that YAMON will only bind 1 TC per VPE on an MT system,
and only describe those 1:1 TC:VPE pairs as CPUs through the AMON
interface. Thus an SMTC kernel makes little sense on a system using
MIPS_CMP, and the Kconfig dependencies should reflect that rather than
introducing the bogus SMVP dependency.

Signed-off-by: Paul Burton <paul.burton@imgtec.com>
---
 arch/mips/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 1cd7148..bdf4012 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -1981,7 +1981,7 @@ config MIPS_VPE_APSP_API_MT
 
 config MIPS_CMP
 	bool "MIPS CMP framework support"
-	depends on SYS_SUPPORTS_MIPS_CMP && MIPS_MT_SMP
+	depends on SYS_SUPPORTS_MIPS_CMP && !MIPS_MT_SMTC
 	select MIPS_GIC_IPI
 	select SYNC_R4K
 	select WEAK_ORDERING
-- 
1.8.4.2
