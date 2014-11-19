Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 19 Nov 2014 22:54:40 +0100 (CET)
Received: from filtteri6.pp.htv.fi ([213.243.153.189]:56915 "EHLO
        filtteri6.pp.htv.fi" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27014061AbaKSVxBFdOoQ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 19 Nov 2014 22:53:01 +0100
Received: from localhost (localhost [127.0.0.1])
        by filtteri6.pp.htv.fi (Postfix) with ESMTP id 3F1D456F85E;
        Wed, 19 Nov 2014 23:52:58 +0200 (EET)
X-Virus-Scanned: Debian amavisd-new at pp.htv.fi
Received: from smtp5.welho.com ([213.243.153.39])
        by localhost (filtteri6.pp.htv.fi [213.243.153.189]) (amavisd-new, port 10024)
        with ESMTP id sdPJ8b-t15nJ; Wed, 19 Nov 2014 23:52:51 +0200 (EET)
Received: from amd-fx-6350.bb.dnainternet.fi (91-145-91-118.bb.dnainternet.fi [91.145.91.118])
        by smtp5.welho.com (Postfix) with ESMTP id A179B5BC009;
        Wed, 19 Nov 2014 23:52:51 +0200 (EET)
From:   Aaro Koskinen <aaro.koskinen@iki.fi>
To:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Subject: [PATCH 3/7] MIPS: loongson: common: setup: add a missing include
Date:   Wed, 19 Nov 2014 23:52:47 +0200
Message-Id: <1416433971-18604-4-git-send-email-aaro.koskinen@iki.fi>
X-Mailer: git-send-email 2.1.2
In-Reply-To: <1416433971-18604-1-git-send-email-aaro.koskinen@iki.fi>
References: <1416433971-18604-1-git-send-email-aaro.koskinen@iki.fi>
Return-Path: <aaro.koskinen@iki.fi>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 44308
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: aaro.koskinen@iki.fi
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

Add a missing include to get rid of the following sparse warning:
warning: symbol 'plat_mem_setup' was not declared. Should it be static?

Signed-off-by: Aaro Koskinen <aaro.koskinen@iki.fi>
---
 arch/mips/loongson/common/setup.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/mips/loongson/common/setup.c b/arch/mips/loongson/common/setup.c
index bb4ac92..d477dd6 100644
--- a/arch/mips/loongson/common/setup.c
+++ b/arch/mips/loongson/common/setup.c
@@ -10,6 +10,7 @@
 #include <linux/module.h>
 
 #include <asm/wbflush.h>
+#include <asm/bootinfo.h>
 
 #include <loongson.h>
 
-- 
2.1.2
