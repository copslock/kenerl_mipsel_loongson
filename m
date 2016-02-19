Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 20 Feb 2016 01:05:15 +0100 (CET)
Received: from mail.windriver.com ([147.11.1.11]:38933 "EHLO
        mail.windriver.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27012263AbcBTAFNiHsoD (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 20 Feb 2016 01:05:13 +0100
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com [147.11.189.40])
        by mail.windriver.com (8.15.2/8.15.1) with ESMTPS id u1K056Pf017149
        (version=TLSv1 cipher=AES128-SHA bits=128 verify=FAIL);
        Fri, 19 Feb 2016 16:05:06 -0800 (PST)
Received: from yshi-Precision-T5600.corp.ad.wrs.com (147.11.216.82) by
 ALA-HCA.corp.ad.wrs.com (147.11.189.40) with Microsoft SMTP Server id
 14.3.248.2; Fri, 19 Feb 2016 16:05:05 -0800
From:   Yang Shi <yang.shi@windriver.com>
To:     <ralf@linux-mips.org>
CC:     <linux-kernel@vger.kernel.org>, <linux-mips@linux-mips.org>
Subject: [PATCH] mips: Kconfig: replace OPROFILE=n to !OPROFILE
Date:   Fri, 19 Feb 2016 15:42:11 -0800
Message-ID: <1455925331-9662-1-git-send-email-yang.shi@windriver.com>
X-Mailer: git-send-email 2.0.2
MIME-Version: 1.0
Content-Type: text/plain
Return-Path: <Yang.Shi@windriver.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 52136
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yang.shi@windriver.com
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

In Kconfig "=n" is not correct syntax, "!" is the preferred way for
false-positive expression.

Signed-off-by: Yang Shi <yang.shi@windriver.com>
---
 arch/mips/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 74a3db9..ab433d3 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -2484,7 +2484,7 @@ config NODES_SHIFT
 
 config HW_PERF_EVENTS
 	bool "Enable hardware performance counter support for perf events"
-	depends on PERF_EVENTS && OPROFILE=n && (CPU_MIPS32 || CPU_MIPS64 || CPU_R10000 || CPU_SB1 || CPU_CAVIUM_OCTEON || CPU_XLP || CPU_LOONGSON3)
+	depends on PERF_EVENTS && !OPROFILE && (CPU_MIPS32 || CPU_MIPS64 || CPU_R10000 || CPU_SB1 || CPU_CAVIUM_OCTEON || CPU_XLP || CPU_LOONGSON3)
 	default y
 	help
 	  Enable hardware performance counter support for perf events. If
-- 
2.0.2
