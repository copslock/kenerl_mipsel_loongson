Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 09 May 2013 17:22:36 +0200 (CEST)
Received: from mail.nanl.de ([217.115.11.12]:43856 "EHLO mail.nanl.de"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6824788Ab3EIPWY0A0Cs (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 9 May 2013 17:22:24 +0200
Received: from ixxyvirt.lan (dslb-088-073-012-093.pools.arcor-ip.net [88.73.12.93])
        by mail.nanl.de (Postfix) with ESMTPSA id AF0AE40158;
        Thu,  9 May 2013 15:22:02 +0000 (UTC)
From:   Jonas Gorski <jogo@openwrt.org>
To:     linux-mips@linux-mips.org
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        "Steven J. Hill" <Steven.Hill@imgtec.com>,
        David Daney <david.daney@cavium.com>,
        John Crispin <blogic@openwrt.org>
Subject: [PATCH] MIPS: tlbex: flush the correct ranges in insn_fixup
Date:   Thu,  9 May 2013 17:22:01 +0200
Message-Id: <1368112922-29253-1-git-send-email-jogo@openwrt.org>
X-Mailer: git-send-email 1.7.10.4
Return-Path: <jogo@openwrt.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36368
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jogo@openwrt.org
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

local_flush_icache_range flushed whereever *stop was pointing to, which
might not necessarily be a valid memory address. This caused TLB misses
at least on BCM63XX, failing early.

Instead move the local_flush_icache_range into the loop as it was
probably intended so it will flush each modified instruction's address.

This breakage was introduced with d532f3d26716a39dfd4b88d687bd344fbe77e390
("MIPS: Allow ASID size to be determined at boot time.").

Signed-off-by: Jonas Gorski <jogo@openwrt.org>
---
 arch/mips/mm/tlbex.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/mips/mm/tlbex.c b/arch/mips/mm/tlbex.c
index a188d42..4d46d37 100644
--- a/arch/mips/mm/tlbex.c
+++ b/arch/mips/mm/tlbex.c
@@ -332,8 +332,9 @@ static void __cpuinit insn_fixup(unsigned int **start, unsigned int **stop,
 			*ip = i_const;
 		}
 #endif
+		local_flush_icache_range((unsigned long)ip,
+					 (unsigned long)ip + sizeof(*ip));
 	}
-	local_flush_icache_range((unsigned long)*p, (unsigned long)((*p) + 1));
 }
 
 #define asid_insn_fixup(section, const)					\
-- 
1.7.10.4
