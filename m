Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 13 Mar 2017 14:33:59 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:34080 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23993933AbdCMNdwT1OKT (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 13 Mar 2017 14:33:52 +0100
Received: from hhmail02.hh.imgtec.org (unknown [10.100.10.20])
        by Forcepoint Email with ESMTPS id 3F522D1091964;
        Mon, 13 Mar 2017 13:33:40 +0000 (GMT)
Received: from WR-NOWAKOWSKI.kl.imgtec.org (10.80.2.5) by
 hhmail02.hh.imgtec.org (10.100.10.21) with Microsoft SMTP Server (TLS) id
 14.3.294.0; Mon, 13 Mar 2017 13:33:43 +0000
From:   Marcin Nowakowski <marcin.nowakowski@imgtec.com>
To:     <ralf@linux-mips.org>
CC:     <linux-mips@linux-mips.org>,
        Marcin Nowakowski <marcin.nowakowski@imgtec.com>
Subject: [PATCH 1/2] MIPS: mach-rm: Remove recursive include of cpu-feature-overrides.h
Date:   Mon, 13 Mar 2017 14:33:37 +0100
Message-ID: <1489412018-30387-2-git-send-email-marcin.nowakowski@imgtec.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1489412018-30387-1-git-send-email-marcin.nowakowski@imgtec.com>
References: <1489412018-30387-1-git-send-email-marcin.nowakowski@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.2.5]
Return-Path: <Marcin.Nowakowski@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 57150
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: marcin.nowakowski@imgtec.com
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

cpu-feautre-overrides.h in mach-rm unnecessarily includes itself, so
drop the pointless include

Signed-off-by: Marcin Nowakowski <marcin.nowakowski@imgtec.com>
---
 arch/mips/include/asm/mach-rm/cpu-feature-overrides.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/mips/include/asm/mach-rm/cpu-feature-overrides.h b/arch/mips/include/asm/mach-rm/cpu-feature-overrides.h
index 98cf404..d38be66 100644
--- a/arch/mips/include/asm/mach-rm/cpu-feature-overrides.h
+++ b/arch/mips/include/asm/mach-rm/cpu-feature-overrides.h
@@ -10,8 +10,6 @@
 #ifndef __ASM_MACH_RM200_CPU_FEATURE_OVERRIDES_H
 #define __ASM_MACH_RM200_CPU_FEATURE_OVERRIDES_H
 
-#include <cpu-feature-overrides.h>
-
 #define cpu_has_tlb		1
 #define cpu_has_4kex		1
 #define cpu_has_4k_cache	1
-- 
2.7.4
