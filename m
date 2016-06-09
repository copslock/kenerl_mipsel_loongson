Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 09 Jun 2016 23:25:25 +0200 (CEST)
Received: from youngberry.canonical.com ([91.189.89.112]:35342 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27041422AbcFIVU2AubNE (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 9 Jun 2016 23:20:28 +0200
Received: from 1.general.kamal.us.vpn ([10.172.68.52] helo=fourier)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_128_CBC_SHA1:16)
        (Exim 4.76)
        (envelope-from <kamal@canonical.com>)
        id 1bB7NL-0005YI-93; Thu, 09 Jun 2016 21:20:27 +0000
Received: from kamal by fourier with local (Exim 4.86_2)
        (envelope-from <kamal@whence.com>)
        id 1bB7NI-0006Ks-Je; Thu, 09 Jun 2016 14:20:24 -0700
From:   Kamal Mostafa <kamal@canonical.com>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        kernel-team@lists.ubuntu.com
Cc:     Florian Fainelli <f.fainelli@gmail.com>, linux-mips@linux-mips.org,
        Ralf Baechle <ralf@linux-mips.org>,
        Kamal Mostafa <kamal@canonical.com>
Subject: [PATCH 4.2.y-ckt 185/206] MIPS: BMIPS: Clear MIPS_CACHE_ALIASES earlier
Date:   Thu,  9 Jun 2016 14:16:34 -0700
Message-Id: <1465507015-23052-186-git-send-email-kamal@canonical.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1465507015-23052-1-git-send-email-kamal@canonical.com>
References: <1465507015-23052-1-git-send-email-kamal@canonical.com>
X-Extended-Stable: 4.2
Return-Path: <kamal@canonical.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 54000
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

4.2.8-ckt12 -stable review patch.  If anyone has any objections, please let me know.

---8<------------------------------------------------------------

From: Florian Fainelli <f.fainelli@gmail.com>

commit 73c4ca047f440c79f545bc6133e3033f754cd239 upstream.

BMIPS5000 and BMIPS5200 processor have no D cache aliases, and this is
properly handled by the per-CPU override added at the end of
r4k_cache_init(), the problem is that the output of probe_pcache()
disagrees with that, since this is too late:

Primary instruction cache 32kB, VIPT, 4-way, linesize 64 bytes.
Primary data cache 32kB, 4-way, VIPT, cache aliases, linesize 32 bytes

With the change moved earlier, we now have a consistent output with the
settings we are intending to have:

Primary instruction cache 32kB, VIPT, 4-way, linesize 64 bytes.
Primary data cache 32kB, 4-way, VIPT, no aliases, linesize 32 bytes

Fixes: d74b0172e4e2c ("MIPS: BMIPS: Add special cache handling in c-r4k.c")
Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
Cc: linux-mips@linux-mips.org
Patchwork: https://patchwork.linux-mips.org/patch/13011/
Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
Signed-off-by: Kamal Mostafa <kamal@canonical.com>
---
 arch/mips/mm/c-r4k.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/mips/mm/c-r4k.c b/arch/mips/mm/c-r4k.c
index b2c1685..f22809f 100644
--- a/arch/mips/mm/c-r4k.c
+++ b/arch/mips/mm/c-r4k.c
@@ -1307,6 +1307,8 @@ static void probe_pcache(void)
 
 	case CPU_BMIPS5000:
 		c->icache.flags |= MIPS_CACHE_IC_F_DC;
+		/* Cache aliases are handled in hardware; allow HIGHMEM */
+		c->dcache.flags &= ~MIPS_CACHE_ALIASES;
 		break;
 
 	case CPU_LOONGSON2:
@@ -1746,8 +1748,6 @@ void r4k_cache_init(void)
 		flush_icache_range = (void *)b5k_instruction_hazard;
 		local_flush_icache_range = (void *)b5k_instruction_hazard;
 
-		/* Cache aliases are handled in hardware; allow HIGHMEM */
-		current_cpu_data.dcache.flags &= ~MIPS_CACHE_ALIASES;
 
 		/* Optimization: an L2 flush implicitly flushes the L1 */
 		current_cpu_data.options |= MIPS_CPU_INCLUSIVE_CACHES;
-- 
2.7.4
