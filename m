Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 13 May 2014 11:18:51 +0200 (CEST)
Received: from ip4-83-240-18-248.cust.nbox.cz ([83.240.18.248]:37663 "EHLO
        ip4-83-240-18-248.cust.nbox.cz" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6831251AbaEMJRXbxgB0 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 13 May 2014 11:17:23 +0200
Received: from ku by ip4-83-240-18-248.cust.nbox.cz with local (Exim 4.80.1)
        (envelope-from <jslaby@suse.cz>)
        id 1Wk8pQ-0002Uv-4A; Tue, 13 May 2014 11:16:52 +0200
From:   Jiri Slaby <jslaby@suse.cz>
To:     stable@vger.kernel.org
Cc:     Huacai Chen <chenhc@lemote.com>, John Crispin <john@phrozen.org>,
        "Steven J. Hill" <Steven.Hill@imgtec.com>,
        Aurelien Jarno <aurelien@aurel32.net>,
        linux-mips@linux-mips.org, Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>,
        Ralf Baechle <ralf@linux-mips.org>, Jiri Slaby <jslaby@suse.cz>
Subject: [patch added to the 3.12 stable tree] MIPS: Hibernate: Flush TLB entries in swsusp_arch_resume()
Date:   Tue, 13 May 2014 11:16:02 +0200
Message-Id: <1399972612-9510-3-git-send-email-jslaby@suse.cz>
X-Mailer: git-send-email 1.9.3
In-Reply-To: <1399972612-9510-1-git-send-email-jslaby@suse.cz>
References: <1399972612-9510-1-git-send-email-jslaby@suse.cz>
Return-Path: <jslaby@suse.cz>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 40091
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

commit c14af233fbe279d0e561ecf84f1208b1bae087ef upstream.

The original MIPS hibernate code flushes cache and TLB entries in
swsusp_arch_resume(). But they are removed in Commit 44eeab67416711
(MIPS: Hibernation: Remove SMP TLB and cacheflushing code.). A cross-
CPU flush is surely unnecessary because all but the local CPU have
already been disabled. But a local flush (at least the TLB flush) is
needed. When we do hibernation on Loongson-3 with an E1000E NIC, it is
very easy to produce a kernel panic (kernel page fault, or unaligned
access). The root cause is E1000E driver use vzalloc_node() to allocate
pages, the stale TLB entries of the booting kernel will be misused by
the resumed target kernel.

Signed-off-by: Huacai Chen <chenhc@lemote.com>
Cc: John Crispin <john@phrozen.org>
Cc: Steven J. Hill <Steven.Hill@imgtec.com>
Cc: Aurelien Jarno <aurelien@aurel32.net>
Cc: linux-mips@linux-mips.org
Cc: Fuxin Zhang <zhangfx@lemote.com>
Cc: Zhangjin Wu <wuzhangjin@gmail.com>
Patchwork: https://patchwork.linux-mips.org/patch/6643/
Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
Signed-off-by: Jiri Slaby <jslaby@suse.cz>
---
 arch/mips/power/hibernate.S | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/mips/power/hibernate.S b/arch/mips/power/hibernate.S
index 7e0277a1048f..32a7c828f073 100644
--- a/arch/mips/power/hibernate.S
+++ b/arch/mips/power/hibernate.S
@@ -43,6 +43,7 @@ LEAF(swsusp_arch_resume)
 	bne t1, t3, 1b
 	PTR_L t0, PBE_NEXT(t0)
 	bnez t0, 0b
+	jal local_flush_tlb_all /* Avoid TLB mismatch after kernel resume */
 	PTR_LA t0, saved_regs
 	PTR_L ra, PT_R31(t0)
 	PTR_L sp, PT_R29(t0)
-- 
1.9.3
