Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 20 Jun 2013 22:30:38 +0200 (CEST)
Received: from mail.nanl.de ([217.115.11.12]:44417 "EHLO mail.nanl.de"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6818712Ab3FTUahTZmQh (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 20 Jun 2013 22:30:37 +0200
Received: from ixxyvirt.lan (unknown [IPv6:2001:470:1f0b:1abf:a00:27ff:fe1b:780a])
        by mail.nanl.de (Postfix) with ESMTPSA id 25B3345F99;
        Thu, 20 Jun 2013 20:30:33 +0000 (UTC)
From:   Jonas Gorski <jogo@openwrt.org>
To:     linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>
Cc:     "Steven J. Hill" <Steven.Hill@imgtec.com>,
        Jayachandran C <jchandra@broadcom.com>,
        David Daney <david.daney@cavium.com>
Subject: [PATCH V2] MIPS: flush TLB handlers before calling them
Date:   Thu, 20 Jun 2013 22:29:42 +0200
Message-Id: <1371760182-637-1-git-send-email-jogo@openwrt.org>
X-Mailer: git-send-email 1.7.10.4
Return-Path: <jogo@openwrt.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37074
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

When having enabled MIPS_PGD_C0_CONTEXT, trap_init() might call the
generated tlbmiss_handler_setup_pgd before it was committed to memory,
causing boot failures:

  trap_init()
   |- per_cpu_trap_init()
   |   |- TLBMISS_HANDLER_SETUP()
   |       |- tlbmiss_handler_setup_pgd()
   |- flush_tlb_handlers()

To avoid this, move flush_tlb_handlers() into per_cpu_trap_init() to
ensure the generated handler is always committed on all cpus.

This issue was introduced in 3d8bfdd0307223de678962f1c1907a7cec549136
("MIPS: Use C0_KScratch (if present) to hold PGD pointer.").

Signed-off-by: Jonas Gorski <jogo@openwrt.org>
---

V1 -> V2:
 * Move flush_tlb_handlers into per_cpu_trap_init() to also fix it for
   !boot_cpu.

 arch/mips/kernel/traps.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/mips/kernel/traps.c b/arch/mips/kernel/traps.c
index 142d2be..b57f22b 100644
--- a/arch/mips/kernel/traps.c
+++ b/arch/mips/kernel/traps.c
@@ -1807,6 +1807,7 @@ void __cpuinit per_cpu_trap_init(bool is_boot_cpu)
 		write_c0_wired(0);
 	}
 #endif /* CONFIG_MIPS_MT_SMTC */
+	flush_tlb_handlers();
 	TLBMISS_HANDLER_SETUP();
 }
 
@@ -1997,7 +1998,6 @@ void __init trap_init(void)
 		set_handler(0x080, &except_vec3_generic, 0x80);
 
 	local_flush_icache_range(ebase, ebase + 0x400);
-	flush_tlb_handlers();
 
 	sort_extable(__start___dbe_table, __stop___dbe_table);
 
-- 
1.7.10.4
