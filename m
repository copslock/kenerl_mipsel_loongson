Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 30 Mar 2017 22:52:31 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:35231 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23992366AbdC3UwYkbDqH (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 30 Mar 2017 22:52:24 +0200
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id 9C9A0F2C3BA22;
        Thu, 30 Mar 2017 21:52:13 +0100 (IST)
Received: from localhost (10.20.1.33) by HHMAIL01.hh.imgtec.org (10.100.10.21)
 with Microsoft SMTP Server (TLS) id 14.3.294.0; Thu, 30 Mar 2017 21:52:17
 +0100
From:   Paul Burton <paul.burton@imgtec.com>
To:     Ralf Baechle <ralf@linux-mips.org>, <linux-mips@linux-mips.org>
CC:     Paul Burton <paul.burton@imgtec.com>, <trivial@kernel.org>
Subject: [PATCH] MIPS: Remove CONFIG_ARCH_HAS_ILOG2_U{32,64}
Date:   Thu, 30 Mar 2017 13:51:59 -0700
Message-ID: <20170330205200.25635-1-paul.burton@imgtec.com>
X-Mailer: git-send-email 2.12.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.20.1.33]
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 57493
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: paul.burton@imgtec.com
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

We declare CONFIG_ARCH_HAS_ILOG2_U32 & CONFIG_ARCH_HAS_ILOG2_U64 in
Kconfig, but they are always false since nothing ever selects them. The
generic fls-based implementation is efficient for MIPS anyway. Remove
the redundant Kconfig entries.

Signed-off-by: Paul Burton <paul.burton@imgtec.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
Cc: trivial@kernel.org

---

 arch/mips/Kconfig | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index a008a9f03072..33bc84ffd6b2 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -1040,14 +1040,6 @@ config RWSEM_GENERIC_SPINLOCK
 config RWSEM_XCHGADD_ALGORITHM
 	bool
 
-config ARCH_HAS_ILOG2_U32
-	bool
-	default n
-
-config ARCH_HAS_ILOG2_U64
-	bool
-	default n
-
 config GENERIC_HWEIGHT
 	bool
 	default y
-- 
2.12.1
