Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 07 Mar 2015 19:32:53 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:61488 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27007561AbbCGSbzBlH3S (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 7 Mar 2015 19:31:55 +0100
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 5A261E7BC1FC0;
        Sat,  7 Mar 2015 18:31:46 +0000 (GMT)
Received: from BAMAIL02.ba.imgtec.org (10.20.40.28) by KLMAIL01.kl.imgtec.org
 (192.168.5.35) with Microsoft SMTP Server (TLS) id 14.3.195.1; Sat, 7 Mar
 2015 18:31:49 +0000
Received: from fun-lab.mips.com (10.20.2.221) by bamail02.ba.imgtec.org
 (10.20.40.28) with Microsoft SMTP Server (TLS) id 14.3.174.1; Sat, 7 Mar 2015
 10:31:47 -0800
From:   Deng-Cheng Zhu <dengcheng.zhu@imgtec.com>
To:     <linux-mips@linux-mips.org>, <ralf@linux-mips.org>
CC:     <macro@linux-mips.org>, Deng-Cheng Zhu <dengcheng.zhu@imgtec.com>,
        "Russell King" <linux@arm.linux.org.uk>,
        LKML <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH v2 04/17] clocksource: versatile: Add PLAT_VERSATILE dependency
Date:   Sat, 7 Mar 2015 10:30:22 -0800
Message-ID: <1425753035-17087-5-git-send-email-dengcheng.zhu@imgtec.com>
X-Mailer: git-send-email 2.3.2
In-Reply-To: <1425753035-17087-1-git-send-email-dengcheng.zhu@imgtec.com>
References: <1425753035-17087-1-git-send-email-dengcheng.zhu@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.20.2.221]
Return-Path: <DengCheng.Zhu@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 46254
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dengcheng.zhu@imgtec.com
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

GENERIC_SCHED_CLOCK can be selected by architectures other than ARM. The
current dependencies of CLKSRC_VERSATILE make it possible that other
architectures will have CLKSRC_VERSATILE available in configuration once
they select GENERIC_SCHED_CLOCK, whereas this clock source should be solely
available to ARM in reality.

This patch adds one more dependency to CLKSRC_VERSATILE to fix the issue.

Cc: Russell King <linux@arm.linux.org.uk>
Cc: LKML <linux-kernel@vger.kernel.org>
Cc: linux-arm-kernel@lists.infradead.org
Reported-by: Maciej W. Rozycki <macro@linux-mips.org>
Signed-off-by: Deng-Cheng Zhu <dengcheng.zhu@imgtec.com>
---
 drivers/clocksource/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfig
index 1c2506f..22e0ee1 100644
--- a/drivers/clocksource/Kconfig
+++ b/drivers/clocksource/Kconfig
@@ -225,7 +225,7 @@ config CLKSRC_QCOM
 
 config CLKSRC_VERSATILE
 	bool "ARM Versatile (Express) reference platforms clock source"
-	depends on GENERIC_SCHED_CLOCK && !ARCH_USES_GETTIMEOFFSET
+	depends on PLAT_VERSATILE && GENERIC_SCHED_CLOCK && !ARCH_USES_GETTIMEOFFSET
 	select CLKSRC_OF
 	default y if MFD_VEXPRESS_SYSREG
 	help
-- 
2.3.2
