Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 18 Jul 2014 11:52:40 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:47215 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6861343AbaGRJwBTmUUs (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 18 Jul 2014 11:52:01 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 1F68526265F3C
        for <linux-mips@linux-mips.org>; Fri, 18 Jul 2014 10:51:52 +0100 (IST)
Received: from KLMAIL02.kl.imgtec.org (10.40.60.222) by KLMAIL01.kl.imgtec.org
 (192.168.5.35) with Microsoft SMTP Server (TLS) id 14.3.195.1; Fri, 18 Jul
 2014 10:51:54 +0100
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 klmail02.kl.imgtec.org (10.40.60.222) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Fri, 18 Jul 2014 10:51:54 +0100
Received: from mchandras-linux.le.imgtec.org (192.168.154.100) by
 LEMAIL01.le.imgtec.org (192.168.152.62) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Fri, 18 Jul 2014 10:51:53 +0100
From:   Markos Chandras <markos.chandras@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Markos Chandras <markos.chandras@imgtec.com>
Subject: [PATCH 2/4] MIPS: pgtable-bits: Define the CCA bit for WC writes on Ingenic cores
Date:   Fri, 18 Jul 2014 10:51:31 +0100
Message-ID: <1405677093-22591-3-git-send-email-markos.chandras@imgtec.com>
X-Mailer: git-send-email 2.0.0
In-Reply-To: <1405677093-22591-1-git-send-email-markos.chandras@imgtec.com>
References: <1405677093-22591-1-git-send-email-markos.chandras@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.154.100]
Return-Path: <Markos.Chandras@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 41308
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

Ingenic uses the CCA:1 bit to achieve write-combine memory writes.

Signed-off-by: Markos Chandras <markos.chandras@imgtec.com>
---
As found in the following git repository
https://github.com/IngenicSemiconductor/KERNEL-WARRIOR/blob/master/arch/mips/include/asm/pgtable.h#L342
---
 arch/mips/include/asm/pgtable-bits.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/mips/include/asm/pgtable-bits.h b/arch/mips/include/asm/pgtable-bits.h
index 011b0dcf306e..e747bfa0be7e 100644
--- a/arch/mips/include/asm/pgtable-bits.h
+++ b/arch/mips/include/asm/pgtable-bits.h
@@ -240,6 +240,11 @@ static inline uint64_t pte_to_entrylo(unsigned long pte_val)
 #define _CACHE_CACHABLE_NONCOHERENT (3<<_CACHE_SHIFT)  /* LOONGSON       */
 #define _CACHE_CACHABLE_COHERENT    (3<<_CACHE_SHIFT)  /* LOONGSON-3     */
 
+#elif defined(CONFIG_MACH_JZ4740)
+
+/* Ingenic uses the WA bit to achieve write-combine memory writes */
+#define _CACHE_UNCACHED_ACCELERATED (1<<_CACHE_SHIFT)
+
 #endif
 
 #ifndef _CACHE_CACHABLE_NO_WA
-- 
2.0.0
