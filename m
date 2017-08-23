Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 23 Aug 2017 20:19:46 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:32925 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23993921AbdHWSTT1fFxI (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 23 Aug 2017 20:19:19 +0200
Received: from hhmail02.hh.imgtec.org (unknown [10.100.10.20])
        by Forcepoint Email with ESMTPS id 7B72973888207;
        Wed, 23 Aug 2017 19:19:09 +0100 (IST)
Received: from localhost (10.20.1.88) by hhmail02.hh.imgtec.org (10.100.10.21)
 with Microsoft SMTP Server (TLS) id 14.3.294.0; Wed, 23 Aug 2017 19:19:13
 +0100
From:   Paul Burton <paul.burton@imgtec.com>
To:     <linux-mips@linux-mips.org>, Ralf Baechle <ralf@linux-mips.org>,
        <trivial@kernel.org>
CC:     Paul Burton <paul.burton@imgtec.com>
Subject: [PATCH 03/11] MIPS: Include asm/setup.h for cpu_cache_init()
Date:   Wed, 23 Aug 2017 11:17:46 -0700
Message-ID: <20170823181754.24044-4-paul.burton@imgtec.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20170823181754.24044-1-paul.burton@imgtec.com>
References: <20170823181754.24044-1-paul.burton@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.20.1.88]
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 59779
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

arch/mips/mm/cache.c provides our implementation of the cpu_cache_init()
function, but doesn't include the asm/setup.h header which declares it.
This leads to a warning from sparse:

  arch/mips/mm/cache.c:274:6: warning: symbol 'cpu_cache_init' was not
    declared. Should it be static?

Fix this by including asm/setup.h to get the declaration of
cpu_cache_init().

Signed-off-by: Paul Burton <paul.burton@imgtec.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
---

 arch/mips/mm/cache.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/mips/mm/cache.c b/arch/mips/mm/cache.c
index 899e46279902..0324e1085b16 100644
--- a/arch/mips/mm/cache.c
+++ b/arch/mips/mm/cache.c
@@ -20,6 +20,7 @@
 #include <asm/processor.h>
 #include <asm/cpu.h>
 #include <asm/cpu-features.h>
+#include <asm/setup.h>
 
 /* Cache operations. */
 void (*flush_cache_all)(void);
-- 
2.14.1
