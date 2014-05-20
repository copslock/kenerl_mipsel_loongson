Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 20 May 2014 13:21:59 +0200 (CEST)
Received: from cpsmtpb-ews09.kpnxchange.com ([213.75.39.14]:57703 "EHLO
        cpsmtpb-ews09.kpnxchange.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6822184AbaETLV4Dp6et (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 20 May 2014 13:21:56 +0200
Received: from cpsps-ews26.kpnxchange.com ([10.94.84.192]) by cpsmtpb-ews09.kpnxchange.com with Microsoft SMTPSVC(7.5.7601.17514);
         Tue, 20 May 2014 13:21:50 +0200
Received: from CPSMTPM-TLF104.kpnxchange.com ([195.121.3.7]) by cpsps-ews26.kpnxchange.com with Microsoft SMTPSVC(7.5.7601.17514);
         Tue, 20 May 2014 13:21:50 +0200
Received: from [192.168.10.106] ([195.240.213.44]) by CPSMTPM-TLF104.kpnxchange.com with Microsoft SMTPSVC(7.5.7601.17514);
         Tue, 20 May 2014 13:21:49 +0200
Message-ID: <1400584909.4912.35.camel@x220>
Subject: [PATCH] MIPS: remove checks for CONFIG_SGI_IP35
From:   Paul Bolle <pebolle@tiscali.nl>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
Date:   Tue, 20 May 2014 13:21:49 +0200
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4 (3.10.4-2.fc20) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 20 May 2014 11:21:49.0476 (UTC) FILETIME=[B150A640:01CF741D]
X-RcptDomain: linux-mips.org
Return-Path: <pebolle@tiscali.nl>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 40164
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: pebolle@tiscali.nl
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

Ever since (shortly before) v2.4.0 there have been checks for
CONFIG_SGI_IP35. But a Kconfig symbol SGI_IP35 was never added to the
tree. Remove these checks.

Signed-off-by: Paul Bolle <pebolle@tiscali.nl>
---
Untested.

For some reason CONFIG_SGI_IP35 was heavily used in arch/ia64 too.
Anyhow, IA64 has dropped that macro years ago.

 arch/mips/include/asm/sn/addrs.h    |  2 --
 arch/mips/include/asm/sn/agent.h    |  4 +---
 arch/mips/include/asm/sn/klconfig.h | 18 +-----------------
 3 files changed, 2 insertions(+), 22 deletions(-)

diff --git a/arch/mips/include/asm/sn/addrs.h b/arch/mips/include/asm/sn/addrs.h
index 66814f8ba8e8..b18772778a79 100644
--- a/arch/mips/include/asm/sn/addrs.h
+++ b/arch/mips/include/asm/sn/addrs.h
@@ -20,8 +20,6 @@
 
 #if defined(CONFIG_SGI_IP27)
 #include <asm/sn/sn0/addrs.h>
-#elif defined(CONFIG_SGI_IP35)
-#include <asm/sn/sn1/addrs.h>
 #endif
 

diff --git a/arch/mips/include/asm/sn/agent.h b/arch/mips/include/asm/sn/agent.h
index e33d09293019..fe84c1fc8551 100644
--- a/arch/mips/include/asm/sn/agent.h
+++ b/arch/mips/include/asm/sn/agent.h
@@ -16,9 +16,7 @@
 
 #if defined(CONFIG_SGI_IP27)
 #include <asm/sn/sn0/hub.h>
-#elif defined(CONFIG_SGI_IP35)
-#include <asm/sn/sn1/hub.h>
-#endif	/* !CONFIG_SGI_IP27 && !CONFIG_SGI_IP35 */
+#endif
 
 /*
  * NIC register macros
diff --git a/arch/mips/include/asm/sn/klconfig.h b/arch/mips/include/asm/sn/klconfig.h
index 467c313d5767..f0ec614afa92 100644
--- a/arch/mips/include/asm/sn/klconfig.h
+++ b/arch/mips/include/asm/sn/klconfig.h
@@ -40,26 +40,10 @@
 //#include <sys/graph.h>
 //#include <sys/xtalk/xbow.h>
 
-#elif defined(CONFIG_SGI_IP35)
-
-#include <asm/sn/sn1/addrs.h>
-#include <sys/sn/router.h>
-#include <sys/graph.h>
-#include <asm/xtalk/xbow.h>
-
-#endif /* !CONFIG_SGI_IP27 && !CONFIG_SGI_IP35 */
-
-#if defined(CONFIG_SGI_IP27) || defined(CONFIG_SGI_IP35)
 #include <asm/sn/agent.h>
 #include <asm/fw/arc/types.h>
 #include <asm/fw/arc/hinv.h>
-#if defined(CONFIG_SGI_IP35)
-// The hack file has to be before vector and after sn0_fru....
-#include <asm/hack.h>
-#include <asm/sn/vector.h>
-#include <asm/xtalk/xtalk.h>
-#endif /* CONFIG_SGI_IP35 */
-#endif /* CONFIG_SGI_IP27 || CONFIG_SGI_IP35 */
+#endif
 
 typedef u64  nic_t;
 
-- 
1.9.0
