Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 10 Apr 2014 21:06:39 +0200 (CEST)
Received: from home.bethel-hill.org ([63.228.164.32]:40794 "EHLO
        home.bethel-hill.org" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6823925AbaDJTGbgtVHZ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 10 Apr 2014 21:06:31 +0200
Received: by home.bethel-hill.org with esmtpsa (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
        (Exim 4.72)
        (envelope-from <Steven.Hill@imgtec.com>)
        id 1WYKIq-0007Sd-TA; Thu, 10 Apr 2014 14:06:24 -0500
From:   "Steven J. Hill" <Steven.Hill@imgtec.com>
To:     linux-mips@linux-mips.org
Cc:     ralf@linux-mips.org
Subject: [PATCH] MIPS: mm: Fix broken microMIPS kernel regression.
Date:   Thu, 10 Apr 2014 14:06:17 -0500
Message-Id: <1397156777-18759-1-git-send-email-Steven.Hill@imgtec.com>
X-Mailer: git-send-email 1.7.10.4
Return-Path: <Steven.Hill@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 39768
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Steven.Hill@imgtec.com
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

From: "Steven J. Hill" <Steven.Hill@imgtec.com>

Commit f4ae17aa0f2122b52f642985b46210a1f2eceb0a broke microMIPS
kernel builds. This patch refactors that code similar to what
was done for the 'clear_page' and 'copy_page' functions.

Signed-off-by: Steven J. Hill <Steven.Hill@imgtec.com>
---
 arch/mips/mm/tlb-funcs.S |    4 +++-
 arch/mips/mm/tlbex.c     |    7 ++++---
 2 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/arch/mips/mm/tlb-funcs.S b/arch/mips/mm/tlb-funcs.S
index 30a494d..a5427c6 100644
--- a/arch/mips/mm/tlb-funcs.S
+++ b/arch/mips/mm/tlb-funcs.S
@@ -16,8 +16,10 @@
 
 #define FASTPATH_SIZE	128
 
+EXPORT(tlbmiss_handler_setup_pgd_start)
 LEAF(tlbmiss_handler_setup_pgd)
-	.space		16 * 4
+1:	j	1b		/* Dummy, will be replaced. */
+	.space	64
 END(tlbmiss_handler_setup_pgd)
 EXPORT(tlbmiss_handler_setup_pgd_end)
 
diff --git a/arch/mips/mm/tlbex.c b/arch/mips/mm/tlbex.c
index ee88367..f99ec587 100644
--- a/arch/mips/mm/tlbex.c
+++ b/arch/mips/mm/tlbex.c
@@ -1422,16 +1422,17 @@ static void build_r4000_tlb_refill_handler(void)
 extern u32 handle_tlbl[], handle_tlbl_end[];
 extern u32 handle_tlbs[], handle_tlbs_end[];
 extern u32 handle_tlbm[], handle_tlbm_end[];
-extern u32 tlbmiss_handler_setup_pgd[], tlbmiss_handler_setup_pgd_end[];
+extern u32 tlbmiss_handler_setup_pgd_start[], tlbmiss_handler_setup_pgd[];
+extern u32 tlbmiss_handler_setup_pgd_end[];
 
 static void build_setup_pgd(void)
 {
 	const int a0 = 4;
 	const int __maybe_unused a1 = 5;
 	const int __maybe_unused a2 = 6;
-	u32 *p = tlbmiss_handler_setup_pgd;
+	u32 *p = tlbmiss_handler_setup_pgd_start;
 	const int tlbmiss_handler_setup_pgd_size =
-		tlbmiss_handler_setup_pgd_end - tlbmiss_handler_setup_pgd;
+		tlbmiss_handler_setup_pgd_end - tlbmiss_handler_setup_pgd_start;
 #ifndef CONFIG_MIPS_PGD_C0_CONTEXT
 	long pgdc = (long)pgd_current;
 #endif
-- 
1.7.10.4
