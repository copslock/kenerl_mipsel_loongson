Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 23 Aug 2017 20:20:40 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:36851 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23993963AbdHWST7KNA6I (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 23 Aug 2017 20:19:59 +0200
Received: from hhmail02.hh.imgtec.org (unknown [10.100.10.20])
        by Forcepoint Email with ESMTPS id 2B56C6BDBFDBF;
        Wed, 23 Aug 2017 19:19:49 +0100 (IST)
Received: from localhost (10.20.1.88) by hhmail02.hh.imgtec.org (10.100.10.21)
 with Microsoft SMTP Server (TLS) id 14.3.294.0; Wed, 23 Aug 2017 19:19:52
 +0100
From:   Paul Burton <paul.burton@imgtec.com>
To:     <linux-mips@linux-mips.org>, Ralf Baechle <ralf@linux-mips.org>,
        <trivial@kernel.org>
CC:     Paul Burton <paul.burton@imgtec.com>
Subject: [PATCH 05/11] MIPS: Include asm/delay.h for __{,n,u}delay()
Date:   Wed, 23 Aug 2017 11:17:48 -0700
Message-ID: <20170823181754.24044-6-paul.burton@imgtec.com>
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
X-archive-position: 59781
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

arch/mips/lib/delay.c provides our implementations of the __delay(),
__ndelay() & __udelay() functions, but doesn't include the asm/delay.h
header which declares them. This leads to warnings from sparse:

  arch/mips/lib/delay.c:26:6: warning: symbol '__delay' was not
    declared. Should it be static?
  arch/mips/lib/delay.c:50:6: warning: symbol '__udelay' was not
    declared. Should it be static?
  arch/mips/lib/delay.c:58:6: warning: symbol '__ndelay' was not
    declared. Should it be static?

Fix this by including asm/delay.h to get the declarations of __delay(),
__ndelay() & __udelay().

Signed-off-by: Paul Burton <paul.burton@imgtec.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
---

 arch/mips/lib/delay.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/mips/lib/delay.c b/arch/mips/lib/delay.c
index 2307a3cb2714..0025438957be 100644
--- a/arch/mips/lib/delay.c
+++ b/arch/mips/lib/delay.c
@@ -15,6 +15,7 @@
 
 #include <asm/asm.h>
 #include <asm/compiler.h>
+#include <asm/delay.h>
 #include <asm/war.h>
 
 #ifndef CONFIG_CPU_DADDI_WORKAROUNDS
-- 
2.14.1
