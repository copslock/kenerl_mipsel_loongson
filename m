Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 27 Jan 2014 21:36:07 +0100 (CET)
Received: from multi.imgtec.com ([194.200.65.239]:44790 "EHLO multi.imgtec.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6831298AbaA0U0FT-nOy (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 27 Jan 2014 21:26:05 +0100
From:   Markos Chandras <markos.chandras@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Markos Chandras <markos.chandras@imgtec.com>
Subject: [PATCH 46/58] MIPS: kernel: proc: Add EVA to the list of CPU features
Date:   Mon, 27 Jan 2014 20:19:33 +0000
Message-ID: <1390853985-14246-47-git-send-email-markos.chandras@imgtec.com>
X-Mailer: git-send-email 1.8.5.3
In-Reply-To: <1390853985-14246-1-git-send-email-markos.chandras@imgtec.com>
References: <1390853985-14246-1-git-send-email-markos.chandras@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.154.47]
X-SEF-Processed: 7_3_0_01192__2014_01_27_20_26_00
Return-Path: <Markos.Chandras@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 39166
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

Signed-off-by: Markos Chandras <markos.chandras@imgtec.com>
---
 arch/mips/kernel/proc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/mips/kernel/proc.c b/arch/mips/kernel/proc.c
index 00d2097..ead0e47 100644
--- a/arch/mips/kernel/proc.c
+++ b/arch/mips/kernel/proc.c
@@ -95,6 +95,7 @@ static int show_cpuinfo(struct seq_file *m, void *v)
 	if (cpu_has_mipsmt)	seq_printf(m, "%s", " mt");
 	if (cpu_has_mmips)	seq_printf(m, "%s", " micromips");
 	if (cpu_has_vz)		seq_printf(m, "%s", " vz");
+	if (cpu_has_eva)	seq_printf(m, "%s", " eva");
 	seq_printf(m, "\n");
 
 	if (cpu_has_mmips) {
-- 
1.8.5.3
