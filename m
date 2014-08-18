Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 18 Aug 2014 16:04:50 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:17473 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6855225AbaHROE3L8oNB (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 18 Aug 2014 16:04:29 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id BC8059EF55A59;
        Mon, 18 Aug 2014 15:04:18 +0100 (IST)
Received: from KLMAIL02.kl.imgtec.org (10.40.60.222) by KLMAIL01.kl.imgtec.org
 (192.168.5.35) with Microsoft SMTP Server (TLS) id 14.3.195.1; Mon, 18 Aug
 2014 15:04:20 +0100
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 klmail02.kl.imgtec.org (10.40.60.222) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Mon, 18 Aug 2014 15:04:20 +0100
Received: from mchandras-linux.le.imgtec.org (192.168.154.158) by
 LEMAIL01.le.imgtec.org (192.168.152.62) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Mon, 18 Aug 2014 15:04:20 +0100
From:   Markos Chandras <markos.chandras@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Markos Chandras <markos.chandras@imgtec.com>,
        <stable@vger.kernel.org>
Subject: [PATCH] MIPS: Malta: memory: Improve system memory detection for '{e,}memsize' >= 2G
Date:   Mon, 18 Aug 2014 15:04:11 +0100
Message-ID: <1408370651-1505-1-git-send-email-markos.chandras@imgtec.com>
X-Mailer: git-send-email 2.0.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.154.158]
Return-Path: <Markos.Chandras@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 42132
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: markos.chandras@imgtec.com
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

Using kstrtol to parse the "{e,}memsize" variables was wrong because this
parses signed long numbers. In case of '{e,}memsize' >= 2G, the top bit
is set, resulting to -ERANGE errors and possibly random system memory
boundaries. We fix this by replacing "kstrtol" with "kstrtoul".
We also improve the code to check the kstrtoul return value and
print a warning if an error was returned.

Cc: <stable@vger.kernel.org> # v3.15+
Signed-off-by: Markos Chandras <markos.chandras@imgtec.com>
---
 arch/mips/mti-malta/malta-memory.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/arch/mips/mti-malta/malta-memory.c b/arch/mips/mti-malta/malta-memory.c
index 0c35dee0a215..8fddd2cdbff7 100644
--- a/arch/mips/mti-malta/malta-memory.c
+++ b/arch/mips/mti-malta/malta-memory.c
@@ -35,13 +35,19 @@ fw_memblock_t * __init fw_getmdesc(int eva)
 	/* otherwise look in the environment */
 
 	memsize_str = fw_getenv("memsize");
-	if (memsize_str)
-		tmp = kstrtol(memsize_str, 0, &memsize);
+	if (memsize_str) {
+		tmp = kstrtoul(memsize_str, 0, &memsize);
+		if (tmp)
+			pr_warn("Failed to read the 'memsize' env variable.\n");
+	}
 	if (eva) {
 	/* Look for ememsize for EVA */
 		ememsize_str = fw_getenv("ememsize");
-		if (ememsize_str)
-			tmp = kstrtol(ememsize_str, 0, &ememsize);
+		if (ememsize_str) {
+			tmp = kstrtoul(ememsize_str, 0, &ememsize);
+			if (tmp)
+				pr_warn("Failed to read the 'ememsize' env variable.\n");
+		}
 	}
 	if (!memsize && !ememsize) {
 		pr_warn("memsize not set in YAMON, set to default (32Mb)\n");
-- 
2.0.4
