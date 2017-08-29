Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 29 Aug 2017 22:07:41 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:35019 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23995073AbdH2UHeRvHg0 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 29 Aug 2017 22:07:34 +0200
Received: from hhmail02.hh.imgtec.org (unknown [10.100.10.20])
        by Forcepoint Email with ESMTPS id 58ACB80DA01E5;
        Tue, 29 Aug 2017 21:07:24 +0100 (IST)
Received: from localhost (10.20.1.88) by hhmail02.hh.imgtec.org (10.100.10.21)
 with Microsoft SMTP Server (TLS) id 14.3.294.0; Tue, 29 Aug 2017 21:07:28
 +0100
From:   Paul Burton <paul.burton@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Paul Burton <paul.burton@imgtec.com>,
        Ralf Baechle <ralf@linux-mips.org>
Subject: [PATCH] fixup: MIPS: CPS: Have asm/mips-cps.h include CM & CPC headers
Date:   Tue, 29 Aug 2017 13:07:11 -0700
Message-ID: <20170829200711.598-1-paul.burton@imgtec.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20170813024943.14989-18-paul.burton@imgtec.com>
References: <20170813024943.14989-18-paul.burton@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.20.1.88]
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 59884
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

Fix a missed inclusion of asm/mips-cpc.h to include asm/mips-cps.h
instead.

Signed-off-by: Paul Burton <paul.burton@imgtec.com>
Fixes: bd819d76de64 ("MIPS: CPS: Have asm/mips-cps.h include CM & CPC headers")
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
---

 arch/mips/mti-malta/malta-dtshim.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/mips/mti-malta/malta-dtshim.c b/arch/mips/mti-malta/malta-dtshim.c
index 361f7c146b75..a6699c15277d 100644
--- a/arch/mips/mti-malta/malta-dtshim.c
+++ b/arch/mips/mti-malta/malta-dtshim.c
@@ -18,7 +18,7 @@
 #include <asm/fw/fw.h>
 #include <asm/mips-boards/generic.h>
 #include <asm/mips-boards/malta.h>
-#include <asm/mips-cpc.h>
+#include <asm/mips-cps.h>
 #include <asm/page.h>
 
 #define ROCIT_REG_BASE			0x1f403000
-- 
2.14.1
