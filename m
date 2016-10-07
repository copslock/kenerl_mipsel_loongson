Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 07 Oct 2016 11:24:16 +0200 (CEST)
Received: from mailapp02.imgtec.com ([217.156.133.132]:11771 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S23991759AbcJGJYJfdoAY (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 7 Oct 2016 11:24:09 +0200
Received: from HHMAIL03.hh.imgtec.org (unknown [10.44.0.21])
        by Forcepoint Email with ESMTPS id E398095F443E3;
        Fri,  7 Oct 2016 10:23:55 +0100 (IST)
Received: from HHMAIL01.hh.imgtec.org (10.100.10.19) by HHMAIL03.hh.imgtec.org
 (10.44.0.21) with Microsoft SMTP Server (TLS) id 14.3.294.0; Fri, 7 Oct 2016
 10:23:58 +0100
Received: from jhogan-linux.le.imgtec.org (192.168.154.110) by
 HHMAIL01.hh.imgtec.org (10.100.10.21) with Microsoft SMTP Server (TLS) id
 14.3.294.0; Fri, 7 Oct 2016 10:23:57 +0100
From:   James Hogan <james.hogan@imgtec.com>
To:     Ralf Baechle <ralf@linux-mips.org>
CC:     "Maciej W . Rozycki" <macro@imgtec.com>,
        James Hogan <james.hogan@imgtec.com>,
        <linux-mips@linux-mips.org>
Subject: [PATCH] MIPS: VDSO: Drop duplicated -I*/-E* aflags
Date:   Fri, 7 Oct 2016 10:23:46 +0100
Message-ID: <21016db2fc628c73bc6efa1530ebeb866a30d6ae.1475832139.git-series.james.hogan@imgtec.com>
X-Mailer: git-send-email 2.7.3
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.154.110]
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 55366
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: james.hogan@imgtec.com
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

The aflags-vdso is based on ccflags-vdso, which already contains the -I*
and -EL/-EB flags from KBUILD_CFLAGS, but those flags are needlessly
added again to aflags-vdso.

Drop the duplication.

Reported-by: Maciej W. Rozycki <macro@imgtec.com>
Signed-off-by: James Hogan <james.hogan@imgtec.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
---
 arch/mips/vdso/Makefile | 2 --
 1 file changed, 0 insertions(+), 2 deletions(-)

diff --git a/arch/mips/vdso/Makefile b/arch/mips/vdso/Makefile
index de9e8836d248..c3dc12a8b7d9 100644
--- a/arch/mips/vdso/Makefile
+++ b/arch/mips/vdso/Makefile
@@ -13,8 +13,6 @@ cflags-vdso := $(ccflags-vdso) \
 	-DDISABLE_BRANCH_PROFILING \
 	$(call cc-option, -fno-stack-protector)
 aflags-vdso := $(ccflags-vdso) \
-	$(filter -I%,$(KBUILD_CFLAGS)) \
-	$(filter -E%,$(KBUILD_CFLAGS)) \
 	-D__ASSEMBLY__ -Wa,-gdwarf-2
 
 #
-- 
git-series 0.8.10
