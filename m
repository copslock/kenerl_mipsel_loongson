Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 19 Nov 2014 22:54:22 +0100 (CET)
Received: from filtteri5.pp.htv.fi ([213.243.153.188]:35248 "EHLO
        filtteri5.pp.htv.fi" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27014060AbaKSVxBFVuSK (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 19 Nov 2014 22:53:01 +0100
Received: from localhost (localhost [127.0.0.1])
        by filtteri5.pp.htv.fi (Postfix) with ESMTP id 4A3495A75DE;
        Wed, 19 Nov 2014 23:52:50 +0200 (EET)
X-Virus-Scanned: Debian amavisd-new at pp.htv.fi
Received: from smtp5.welho.com ([213.243.153.39])
        by localhost (filtteri5.pp.htv.fi [213.243.153.188]) (amavisd-new, port 10024)
        with ESMTP id HVGTI8TICvPN; Wed, 19 Nov 2014 23:52:43 +0200 (EET)
Received: from amd-fx-6350.bb.dnainternet.fi (91-145-91-118.bb.dnainternet.fi [91.145.91.118])
        by smtp5.welho.com (Postfix) with ESMTP id 190125BC00E;
        Wed, 19 Nov 2014 23:52:52 +0200 (EET)
From:   Aaro Koskinen <aaro.koskinen@iki.fi>
To:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Subject: [PATCH 7/7] MIPS: loongson: common: rtc: make loongson_rtc_resources static
Date:   Wed, 19 Nov 2014 23:52:51 +0200
Message-Id: <1416433971-18604-8-git-send-email-aaro.koskinen@iki.fi>
X-Mailer: git-send-email 2.1.2
In-Reply-To: <1416433971-18604-1-git-send-email-aaro.koskinen@iki.fi>
References: <1416433971-18604-1-git-send-email-aaro.koskinen@iki.fi>
Return-Path: <aaro.koskinen@iki.fi>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 44307
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

Make loongson_rtc_resources static to eliminate the following
sparse warning:
warning: symbol 'loongson_rtc_resources' was not declared. Should it be static?

Signed-off-by: Aaro Koskinen <aaro.koskinen@iki.fi>
---
 arch/mips/loongson/common/rtc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/mips/loongson/common/rtc.c b/arch/mips/loongson/common/rtc.c
index a90d87c..b5709af 100644
--- a/arch/mips/loongson/common/rtc.c
+++ b/arch/mips/loongson/common/rtc.c
@@ -14,7 +14,7 @@
 #include <linux/platform_device.h>
 #include <linux/mc146818rtc.h>
 
-struct resource loongson_rtc_resources[] = {
+static struct resource loongson_rtc_resources[] = {
 	{
 		.start	= RTC_PORT(0),
 		.end	= RTC_PORT(1),
-- 
2.1.2
