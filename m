Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 19 Nov 2014 22:54:55 +0100 (CET)
Received: from filtteri1.pp.htv.fi ([213.243.153.184]:52859 "EHLO
        filtteri1.pp.htv.fi" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27014063AbaKSVxCYWg4e (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 19 Nov 2014 22:53:02 +0100
Received: from localhost (localhost [127.0.0.1])
        by filtteri1.pp.htv.fi (Postfix) with ESMTP id 8F4F221BA68;
        Wed, 19 Nov 2014 23:52:58 +0200 (EET)
X-Virus-Scanned: Debian amavisd-new at pp.htv.fi
Received: from smtp5.welho.com ([213.243.153.39])
        by localhost (filtteri1.pp.htv.fi [213.243.153.184]) (amavisd-new, port 10024)
        with ESMTP id asEOhll42cPB; Wed, 19 Nov 2014 23:52:52 +0200 (EET)
Received: from amd-fx-6350.bb.dnainternet.fi (91-145-91-118.bb.dnainternet.fi [91.145.91.118])
        by smtp5.welho.com (Postfix) with ESMTP id F098E5BC00C;
        Wed, 19 Nov 2014 23:52:51 +0200 (EET)
From:   Aaro Koskinen <aaro.koskinen@iki.fi>
To:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Subject: [PATCH 6/7] MIPS: loongson: common: init: add a missing include
Date:   Wed, 19 Nov 2014 23:52:50 +0200
Message-Id: <1416433971-18604-7-git-send-email-aaro.koskinen@iki.fi>
X-Mailer: git-send-email 2.1.2
In-Reply-To: <1416433971-18604-1-git-send-email-aaro.koskinen@iki.fi>
References: <1416433971-18604-1-git-send-email-aaro.koskinen@iki.fi>
Return-Path: <aaro.koskinen@iki.fi>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 44309
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

Add a missing include to eliminate the following sparse warnings:
warning: symbol 'prom_init' was not declared. Should it be static?
warning: symbol 'prom_free_prom_memory' was not declared. Should it be static?

Signed-off-by: Aaro Koskinen <aaro.koskinen@iki.fi>
---
 arch/mips/loongson/common/init.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/mips/loongson/common/init.c b/arch/mips/loongson/common/init.c
index f6af3ab..9b987fe 100644
--- a/arch/mips/loongson/common/init.c
+++ b/arch/mips/loongson/common/init.c
@@ -9,6 +9,7 @@
  */
 
 #include <linux/bootmem.h>
+#include <asm/bootinfo.h>
 #include <asm/smp-ops.h>
 
 #include <loongson.h>
-- 
2.1.2
