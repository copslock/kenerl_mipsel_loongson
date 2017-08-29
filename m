Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 29 Aug 2017 22:08:36 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:37651 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23995081AbdH2UI0FwXT0 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 29 Aug 2017 22:08:26 +0200
Received: from hhmail02.hh.imgtec.org (unknown [10.100.10.20])
        by Forcepoint Email with ESMTPS id 56328E4AE77E8;
        Tue, 29 Aug 2017 21:08:15 +0100 (IST)
Received: from localhost (10.20.1.88) by hhmail02.hh.imgtec.org (10.100.10.21)
 with Microsoft SMTP Server (TLS) id 14.3.294.0; Tue, 29 Aug 2017 21:08:18
 +0100
From:   Paul Burton <paul.burton@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Paul Burton <paul.burton@imgtec.com>,
        Ralf Baechle <ralf@linux-mips.org>
Subject: [PATCH] fixup: MIPS: CPS: Cluster support for topology functions
Date:   Tue, 29 Aug 2017 13:08:03 -0700
Message-ID: <20170829200803.856-1-paul.burton@imgtec.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20170813024943.14989-19-paul.burton@imgtec.com>
References: <20170813024943.14989-19-paul.burton@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.20.1.88]
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 59885
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

From CM 3.5 onwards we might read information that has typically come
from the CM using registers which mirror that information in the CPC.
This requires that we include support for the CPC.

Ensure that CONFIG_MIPS_CPC is enabled along with CONFIG_MIPS_CM so that
we always include that support. Otherwise we fail to link due to the
missing mips_cpc_base symbol when the topology functions call CPC
register accessors.

Signed-off-by: Paul Burton <paul.burton@imgtec.com>
Fixes: 20fb90f7620d ("MIPS: CPS: Cluster support for topology functions")
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
---

 arch/mips/Kconfig | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 2d1651797651..5284dfc38e78 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -2385,7 +2385,6 @@ config MIPS_CPS
 	bool "MIPS Coherent Processing System support"
 	depends on SYS_SUPPORTS_MIPS_CPS
 	select MIPS_CM
-	select MIPS_CPC
 	select MIPS_CPS_PM if HOTPLUG_CPU
 	select SMP
 	select SYNC_R4K if (CEVT_R4K || CSRC_R4K)
@@ -2402,11 +2401,11 @@ config MIPS_CPS
 
 config MIPS_CPS_PM
 	depends on MIPS_CPS
-	select MIPS_CPC
 	bool
 
 config MIPS_CM
 	bool
+	select MIPS_CPC
 
 config MIPS_CPC
 	bool
-- 
2.14.1
