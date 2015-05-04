Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 04 May 2015 14:38:24 +0200 (CEST)
Received: from ip4-83-240-67-251.cust.nbox.cz ([83.240.67.251]:53290 "EHLO
        ip4-83-240-18-248.cust.nbox.cz" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S27011279AbbEDMiXBxTyk (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 4 May 2015 14:38:23 +0200
Received: from ku by ip4-83-240-18-248.cust.nbox.cz with local (Exim 4.85)
        (envelope-from <jslaby@suse.cz>)
        id 1YpFdK-0001qM-QC; Mon, 04 May 2015 14:38:02 +0200
From:   Jiri Slaby <jslaby@suse.cz>
To:     stable@vger.kernel.org
Cc:     Huacai Chen <chenhc@lemote.com>,
        "Steven J. Hill" <Steven.Hill@imgtec.com>,
        linux-mips@linux-mips.org, Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>,
        Ralf Baechle <ralf@linux-mips.org>, Jiri Slaby <jslaby@suse.cz>
Subject: [patch added to the 3.12 stable tree] MIPS: Hibernate: flush TLB entries earlier
Date:   Mon,  4 May 2015 14:36:58 +0200
Message-Id: <1430743082-6957-7-git-send-email-jslaby@suse.cz>
X-Mailer: git-send-email 2.3.5
In-Reply-To: <1430743082-6957-1-git-send-email-jslaby@suse.cz>
References: <1430743082-6957-1-git-send-email-jslaby@suse.cz>
Return-Path: <jslaby@suse.cz>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 47229
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

This patch has been added to the 3.12 stable tree. If you have any
objections, please let us know.

===============

commit a843d00d038b11267279e3b5388222320f9ddc1d upstream.

We found that TLB mismatch not only happens after kernel resume, but
also happens during snapshot restore. So move it to the beginning of
swsusp_arch_suspend().

Signed-off-by: Huacai Chen <chenhc@lemote.com>
Cc: Steven J. Hill <Steven.Hill@imgtec.com>
Cc: linux-mips@linux-mips.org
Cc: Fuxin Zhang <zhangfx@lemote.com>
Cc: Zhangjin Wu <wuzhangjin@gmail.com>
Patchwork: https://patchwork.linux-mips.org/patch/9621/
Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
Signed-off-by: Jiri Slaby <jslaby@suse.cz>
---
 arch/mips/power/hibernate.S | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/mips/power/hibernate.S b/arch/mips/power/hibernate.S
index 32a7c828f073..e7567c8a9e79 100644
--- a/arch/mips/power/hibernate.S
+++ b/arch/mips/power/hibernate.S
@@ -30,6 +30,8 @@ LEAF(swsusp_arch_suspend)
 END(swsusp_arch_suspend)
 
 LEAF(swsusp_arch_resume)
+	/* Avoid TLB mismatch during and after kernel resume */
+	jal local_flush_tlb_all
 	PTR_L t0, restore_pblist
 0:
 	PTR_L t1, PBE_ADDRESS(t0)   /* source */
@@ -43,7 +45,6 @@ LEAF(swsusp_arch_resume)
 	bne t1, t3, 1b
 	PTR_L t0, PBE_NEXT(t0)
 	bnez t0, 0b
-	jal local_flush_tlb_all /* Avoid TLB mismatch after kernel resume */
 	PTR_LA t0, saved_regs
 	PTR_L ra, PT_R31(t0)
 	PTR_L sp, PT_R29(t0)
-- 
2.3.5
