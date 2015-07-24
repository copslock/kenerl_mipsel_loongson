Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 24 Jul 2015 17:17:06 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:1965 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27010539AbbGXPQfxyTJG (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 24 Jul 2015 17:16:35 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 34FEAA19DD271
        for <linux-mips@linux-mips.org>; Fri, 24 Jul 2015 16:16:27 +0100 (IST)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Fri, 24 Jul 2015 16:16:30 +0100
Received: from asmith-linux.le.imgtec.org (192.168.154.115) by
 LEMAIL01.le.imgtec.org (192.168.152.62) with Microsoft SMTP Server (TLS) id
 14.3.210.2; Fri, 24 Jul 2015 16:16:29 +0100
From:   Alex Smith <alex.smith@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Alex Smith <alex.smith@imgtec.com>
Subject: [PATCH 3/3] MIPS: Use Ingenic-specific write combine attribute on all Ingenic platforms
Date:   Fri, 24 Jul 2015 16:16:12 +0100
Message-ID: <1437750972-3659-3-git-send-email-alex.smith@imgtec.com>
X-Mailer: git-send-email 2.4.6
In-Reply-To: <1437750972-3659-1-git-send-email-alex.smith@imgtec.com>
References: <1437750972-3659-1-git-send-email-alex.smith@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.154.115]
Return-Path: <Alex.Smith@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 48414
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: alex.smith@imgtec.com
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

The Ingenic-specific write combining cache attribute was defined based
on CONFIG_MACH_JZ4740 and therefore not used on JZ4780. Change this to
CONFIG_MACH_INGENIC so that it gets used on all Ingenic platforms.

Signed-off-by: Alex Smith <alex.smith@imgtec.com>
---
 arch/mips/include/asm/pgtable-bits.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/mips/include/asm/pgtable-bits.h b/arch/mips/include/asm/pgtable-bits.h
index c28a8499aec7..002eeb224733 100644
--- a/arch/mips/include/asm/pgtable-bits.h
+++ b/arch/mips/include/asm/pgtable-bits.h
@@ -249,7 +249,7 @@ static inline uint64_t pte_to_entrylo(unsigned long pte_val)
 #define _CACHE_CACHABLE_NONCOHERENT (3<<_CACHE_SHIFT)  /* LOONGSON       */
 #define _CACHE_CACHABLE_COHERENT    (3<<_CACHE_SHIFT)  /* LOONGSON-3     */
 
-#elif defined(CONFIG_MACH_JZ4740)
+#elif defined(CONFIG_MACH_INGENIC)
 
 /* Ingenic uses the WA bit to achieve write-combine memory writes */
 #define _CACHE_UNCACHED_ACCELERATED (1<<_CACHE_SHIFT)
-- 
2.4.6
