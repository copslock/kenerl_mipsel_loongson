Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 28 Mar 2015 19:06:36 +0100 (CET)
Received: from filtteri5.pp.htv.fi ([213.243.153.188]:48458 "EHLO
        filtteri5.pp.htv.fi" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27014160AbbC1SGC6to0P (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 28 Mar 2015 19:06:02 +0100
Received: from localhost (localhost [127.0.0.1])
        by filtteri5.pp.htv.fi (Postfix) with ESMTP id 4BC8D5A7020;
        Sat, 28 Mar 2015 20:05:51 +0200 (EET)
X-Virus-Scanned: Debian amavisd-new at pp.htv.fi
Received: from smtp4.welho.com ([213.243.153.38])
        by localhost (filtteri5.pp.htv.fi [213.243.153.188]) (amavisd-new, port 10024)
        with ESMTP id D-NLg23yYaBZ; Sat, 28 Mar 2015 20:05:46 +0200 (EET)
Received: from amd-fx-6350.bb.dnainternet.fi (91-145-91-118.bb.dnainternet.fi [91.145.91.118])
        by smtp4.welho.com (Postfix) with ESMTP id 22AE95BC019;
        Sat, 28 Mar 2015 20:05:57 +0200 (EET)
From:   Aaro Koskinen <aaro.koskinen@iki.fi>
To:     Wim Van Sebroeck <wim@iguana.be>,
        David Daney <david.daney@cavium.com>,
        linux-watchdog@vger.kernel.org
Cc:     linux-mips@linux-mips.org, Aaro Koskinen <aaro.koskinen@iki.fi>
Subject: [PATCH 3/3] watchdog: octeon: use fixed length string for register names
Date:   Sat, 28 Mar 2015 20:05:40 +0200
Message-Id: <1427565940-22951-3-git-send-email-aaro.koskinen@iki.fi>
X-Mailer: git-send-email 2.2.0
In-Reply-To: <1427565940-22951-1-git-send-email-aaro.koskinen@iki.fi>
References: <1427565940-22951-1-git-send-email-aaro.koskinen@iki.fi>
Return-Path: <aaro.koskinen@iki.fi>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 46576
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

Use fixed length string for register names. This saves 416 bytes
in text size.

Signed-off-by: Aaro Koskinen <aaro.koskinen@iki.fi>
---
 drivers/watchdog/octeon-wdt-main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/watchdog/octeon-wdt-main.c b/drivers/watchdog/octeon-wdt-main.c
index 728840c..14521c8 100644
--- a/drivers/watchdog/octeon-wdt-main.c
+++ b/drivers/watchdog/octeon-wdt-main.c
@@ -304,7 +304,7 @@ static void octeon_wdt_write_hex(u64 value, int digits)
 	}
 }
 
-static const char *reg_name[] = {
+static const char reg_name[][3] = {
 	"$0", "at", "v0", "v1", "a0", "a1", "a2", "a3",
 	"a4", "a5", "a6", "a7", "t0", "t1", "t2", "t3",
 	"s0", "s1", "s2", "s3", "s4", "s5", "s6", "s7",
-- 
2.2.0
