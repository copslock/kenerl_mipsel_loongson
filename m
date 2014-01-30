Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 30 Jan 2014 18:22:57 +0100 (CET)
Received: from multi.imgtec.com ([194.200.65.239]:31681 "EHLO multi.imgtec.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6823073AbaA3RWyvudK9 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 30 Jan 2014 18:22:54 +0100
From:   Markos Chandras <markos.chandras@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Markos Chandras <markos.chandras@imgtec.com>
Subject: [PATCH v2] MIPS: mm: c-r4k: Detect instruction cache aliases
Date:   Thu, 30 Jan 2014 17:21:29 +0000
Message-ID: <1391102489-1403-1-git-send-email-markos.chandras@imgtec.com>
X-Mailer: git-send-email 1.8.5.3
In-Reply-To: <52E93795.8000205@imgtec.com>
References: <52E93795.8000205@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.154.47]
X-SEF-Processed: 7_3_0_01192__2014_01_30_17_22_48
Return-Path: <Markos.Chandras@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 39195
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: markos.chandras@imgtec.com
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

The *Aptiv cores can use the CONF7/IAR bit to detect if the core
has hardware support to remove instruction cache aliasing.

This also defines the CONF7/AR bit in order to avoid using
the '16' magic number.

Signed-off-by: Markos Chandras <markos.chandras@imgtec.com>
---
Changes since v1:
- Merge conditionals thanks to Sergei Shtylyov
- Improve commit message to mention that CONF7/AR has also been defined
thanks to Sergei Shtylyov

 arch/mips/include/asm/mipsregs.h | 3 +++
 arch/mips/mm/c-r4k.c             | 5 ++++-
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/arch/mips/include/asm/mipsregs.h b/arch/mips/include/asm/mipsregs.h
index bbc3dd4..0c74617 100644
--- a/arch/mips/include/asm/mipsregs.h
+++ b/arch/mips/include/asm/mipsregs.h
@@ -653,6 +653,9 @@
 
 #define MIPS_CONF7_RPS		(_ULCAST_(1) << 2)
 
+#define MIPS_CONF7_IAR		(_ULCAST_(1) << 10)
+#define MIPS_CONF7_AR		(_ULCAST_(1) << 16)
+
 /*  EntryHI bit definition */
 #define MIPS_ENTRYHI_EHINV	(_ULCAST_(1) << 10)
 
diff --git a/arch/mips/mm/c-r4k.c b/arch/mips/mm/c-r4k.c
index 13b549a..8017f6e 100644
--- a/arch/mips/mm/c-r4k.c
+++ b/arch/mips/mm/c-r4k.c
@@ -1110,7 +1110,10 @@ static void probe_pcache(void)
 	case CPU_PROAPTIV:
 		if (current_cpu_type() == CPU_74K)
 			alias_74k_erratum(c);
-		if ((read_c0_config7() & (1 << 16))) {
+		if (!(read_c0_config7() & MIPS_CONF7_IAR) &&
+		    (c->icache.waysize > PAGE_SIZE))
+				c->icache.flags |= MIPS_CACHE_ALIASES;
+		if (read_c0_config7() & MIPS_CONF7_AR) {
 			/* effectively physically indexed dcache,
 			   thus no virtual aliases. */
 			c->dcache.flags |= MIPS_CACHE_PINDEX;
-- 
1.8.5.3
