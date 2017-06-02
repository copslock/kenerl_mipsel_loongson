Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 03 Jun 2017 00:39:53 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:52366 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23993914AbdFBWjfq8x23 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 3 Jun 2017 00:39:35 +0200
Received: from hhmail02.hh.imgtec.org (unknown [10.100.10.20])
        by Forcepoint Email with ESMTPS id 59F80E33C359;
        Fri,  2 Jun 2017 23:39:25 +0100 (IST)
Received: from localhost (10.20.1.33) by hhmail02.hh.imgtec.org (10.100.10.21)
 with Microsoft SMTP Server (TLS) id 14.3.294.0; Fri, 2 Jun 2017 23:39:29
 +0100
From:   Paul Burton <paul.burton@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Paul Burton <paul.burton@imgtec.com>,
        Ralf Baechle <ralf@linux-mips.org>
Subject: [PATCH 3/6] MIPS: Allow storing pgd in C0_CONTEXT for MIPSr6
Date:   Fri, 2 Jun 2017 15:38:03 -0700
Message-ID: <20170602223806.5078-4-paul.burton@imgtec.com>
X-Mailer: git-send-email 2.13.0
In-Reply-To: <20170602223806.5078-1-paul.burton@imgtec.com>
References: <20170602223806.5078-1-paul.burton@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.20.1.33]
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 58167
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

CONFIG_MIPS_PGD_C0_CONTEXT, which allows a pointer to the page directory
to be stored in the cop0 Context register when enabled, was previously
only allowed for MIPSr2. MIPSr6 is just as able to make use of it, so
allow it there too.

Signed-off-by: Paul Burton <paul.burton@imgtec.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
---

 arch/mips/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 2828ecde133d..bcfd4c30ea2a 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -2061,7 +2061,7 @@ config CPU_SUPPORTS_UNCACHED_ACCELERATED
 	bool
 config MIPS_PGD_C0_CONTEXT
 	bool
-	default y if 64BIT && CPU_MIPSR2 && !CPU_XLP
+	default y if 64BIT && (CPU_MIPSR2 || CPU_MIPSR6) && !CPU_XLP
 
 #
 # Set to y for ptrace access to watch registers.
-- 
2.13.0
