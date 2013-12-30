Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 31 Dec 2013 00:26:57 +0100 (CET)
Received: from filtteri1.pp.htv.fi ([213.243.153.184]:50491 "EHLO
        filtteri1.pp.htv.fi" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6825378Ab3L3X0zTu4-- (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 31 Dec 2013 00:26:55 +0100
Received: from localhost (localhost [127.0.0.1])
        by filtteri1.pp.htv.fi (Postfix) with ESMTP id 0220C21B8B1;
        Tue, 31 Dec 2013 01:26:52 +0200 (EET)
X-Virus-Scanned: Debian amavisd-new at pp.htv.fi
Received: from smtp5.welho.com ([213.243.153.39])
        by localhost (filtteri1.pp.htv.fi [213.243.153.184]) (amavisd-new, port 10024)
        with ESMTP id EVhEMzEmBhzh; Tue, 31 Dec 2013 01:26:47 +0200 (EET)
Received: from blackmetal.bb.dnainternet.fi (91-145-91-118.bb.dnainternet.fi [91.145.91.118])
        by smtp5.welho.com (Postfix) with ESMTP id 085065BC002;
        Tue, 31 Dec 2013 01:26:47 +0200 (EET)
From:   Aaro Koskinen <aaro.koskinen@iki.fi>
To:     Ralf Baechle <ralf@linux-mips.org>,
        "Steven J. Hill" <Steven.Hill@imgtec.com>,
        linux-mips@linux-mips.org
Cc:     Aaro Koskinen <aaro.koskinen@iki.fi>
Subject: [PATCH] MIPS: /proc/cpuinfo: always print the supported ISA
Date:   Tue, 31 Dec 2013 01:26:31 +0200
Message-Id: <1388445992-7486-1-git-send-email-aaro.koskinen@iki.fi>
X-Mailer: git-send-email 1.8.5.2
Return-Path: <aaro.koskinen@iki.fi>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 38818
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

Currently the supported ISA is only printed on the latest architectures.
Print it also on legacy platforms.

Signed-off-by: Aaro Koskinen <aaro.koskinen@iki.fi>
---
 arch/mips/kernel/proc.c | 39 +++++++++++++++++++--------------------
 1 file changed, 19 insertions(+), 20 deletions(-)

diff --git a/arch/mips/kernel/proc.c b/arch/mips/kernel/proc.c
index 8c58d8a84bf3..71236709f3f5 100644
--- a/arch/mips/kernel/proc.c
+++ b/arch/mips/kernel/proc.c
@@ -65,26 +65,25 @@ static int show_cpuinfo(struct seq_file *m, void *v)
 				cpu_data[n].watch_reg_masks[i]);
 		seq_printf(m, "]\n");
 	}
-	if (cpu_has_mips_r) {
-		seq_printf(m, "isa\t\t\t: mips1");
-		if (cpu_has_mips_2)
-			seq_printf(m, "%s", " mips2");
-		if (cpu_has_mips_3)
-			seq_printf(m, "%s", " mips3");
-		if (cpu_has_mips_4)
-			seq_printf(m, "%s", " mips4");
-		if (cpu_has_mips_5)
-			seq_printf(m, "%s", " mips5");
-		if (cpu_has_mips32r1)
-			seq_printf(m, "%s", " mips32r1");
-		if (cpu_has_mips32r2)
-			seq_printf(m, "%s", " mips32r2");
-		if (cpu_has_mips64r1)
-			seq_printf(m, "%s", " mips64r1");
-		if (cpu_has_mips64r2)
-			seq_printf(m, "%s", " mips64r2");
-		seq_printf(m, "\n");
-	}
+
+	seq_printf(m, "isa\t\t\t: mips1");
+	if (cpu_has_mips_2)
+		seq_printf(m, "%s", " mips2");
+	if (cpu_has_mips_3)
+		seq_printf(m, "%s", " mips3");
+	if (cpu_has_mips_4)
+		seq_printf(m, "%s", " mips4");
+	if (cpu_has_mips_5)
+		seq_printf(m, "%s", " mips5");
+	if (cpu_has_mips32r1)
+		seq_printf(m, "%s", " mips32r1");
+	if (cpu_has_mips32r2)
+		seq_printf(m, "%s", " mips32r2");
+	if (cpu_has_mips64r1)
+		seq_printf(m, "%s", " mips64r1");
+	if (cpu_has_mips64r2)
+		seq_printf(m, "%s", " mips64r2");
+	seq_printf(m, "\n");
 
 	seq_printf(m, "ASEs implemented\t:");
 	if (cpu_has_mips16)	seq_printf(m, "%s", " mips16");
-- 
1.8.5.2
