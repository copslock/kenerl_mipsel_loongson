Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 26 Sep 2014 11:46:51 +0200 (CEST)
Received: from cantor2.suse.de ([195.135.220.15]:54404 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27009897AbaIZJpzWug2K (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 26 Sep 2014 11:45:55 +0200
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id A3066ADDB;
        Fri, 26 Sep 2014 09:45:54 +0000 (UTC)
Received: from ku by ip4-83-240-18-248.cust.nbox.cz with local (Exim 4.83)
        (envelope-from <jslaby@suse.cz>)
        id 1XXS65-0008QH-SA; Fri, 26 Sep 2014 11:45:53 +0200
From:   Jiri Slaby <jslaby@suse.cz>
To:     stable@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Huacai Chen <chenhc@lemote.com>,
        Binbin Zhou <zhoubb@lemote.com>,
        John Crispin <john@phrozen.org>,
        "Steven J. Hill" <Steven.Hill@imgtec.com>,
        linux-mips@linux-mips.org, Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>,
        Ralf Baechle <ralf@linux-mips.org>, Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH 3.12 070/142] MIPS: tlbex: Fix a missing statement for HUGETLB
Date:   Fri, 26 Sep 2014 11:44:41 +0200
Message-Id: <ac9c2b5ec9758352df308886f87363cdbb3929d7.1411724724.git.jslaby@suse.cz>
X-Mailer: git-send-email 2.1.0
In-Reply-To: <406eb8e630446eff74211cba53a536f232bbefd1.1411724723.git.jslaby@suse.cz>
References: <406eb8e630446eff74211cba53a536f232bbefd1.1411724723.git.jslaby@suse.cz>
In-Reply-To: <cover.1411724723.git.jslaby@suse.cz>
References: <cover.1411724723.git.jslaby@suse.cz>
Return-Path: <jslaby@suse.cz>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 42842
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jslaby@suse.cz
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

From: Huacai Chen <chenhc@lemote.com>

3.12-stable review patch.  If anyone has any objections, please let me know.

===============

commit 8393c524a25609a30129e4a8975cf3b91f6c16a5 upstream.

In commit 2c8c53e28f1 (MIPS: Optimize TLB handlers for Octeon CPUs)
build_r4000_tlb_refill_handler() is modified. But it doesn't compatible
with the original code in HUGETLB case. Because there is a copy & paste
error and one line of code is missing. It is very easy to produce a bug
with LTP's hugemmap05 test.

Signed-off-by: Huacai Chen <chenhc@lemote.com>
Signed-off-by: Binbin Zhou <zhoubb@lemote.com>
Cc: John Crispin <john@phrozen.org>
Cc: Steven J. Hill <Steven.Hill@imgtec.com>
Cc: linux-mips@linux-mips.org
Cc: Fuxin Zhang <zhangfx@lemote.com>
Cc: Zhangjin Wu <wuzhangjin@gmail.com>
Patchwork: https://patchwork.linux-mips.org/patch/7496/
Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
Signed-off-by: Jiri Slaby <jslaby@suse.cz>
---
 arch/mips/mm/tlbex.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/mips/mm/tlbex.c b/arch/mips/mm/tlbex.c
index 9bb3a9363b06..db7a050f5c2c 100644
--- a/arch/mips/mm/tlbex.c
+++ b/arch/mips/mm/tlbex.c
@@ -1333,6 +1333,7 @@ static void build_r4000_tlb_refill_handler(void)
 	}
 #ifdef CONFIG_MIPS_HUGE_TLB_SUPPORT
 	uasm_l_tlb_huge_update(&l, p);
+	UASM_i_LW(&p, K0, 0, K1);
 	build_huge_update_entries(&p, htlb_info.huge_pte, K1);
 	build_huge_tlb_write_entry(&p, &l, &r, K0, tlb_random,
 				   htlb_info.restore_scratch);
-- 
2.1.0
