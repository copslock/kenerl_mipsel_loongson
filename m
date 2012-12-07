Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 07 Dec 2012 06:31:51 +0100 (CET)
Received: from home.bethel-hill.org ([63.228.164.32]:60448 "EHLO
        home.bethel-hill.org" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6831907Ab2LGFbrCtBa0 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 7 Dec 2012 06:31:47 +0100
Received: by home.bethel-hill.org with esmtpsa (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
        (Exim 4.72)
        (envelope-from <sjhill@mips.com>)
        id 1TgqXE-0007RX-To; Thu, 06 Dec 2012 23:31:40 -0600
From:   "Steven J. Hill" <sjhill@mips.com>
To:     linux-mips@linux-mips.org
Cc:     "Steven J. Hill" <sjhill@mips.com>, ralf@linux-mips.org
Subject: [PATCH] MIPS: Add printing of ISA version in cpuinfo.
Date:   Thu,  6 Dec 2012 23:31:36 -0600
Message-Id: <1354858296-29620-1-git-send-email-sjhill@mips.com>
X-Mailer: git-send-email 1.7.9.5
X-archive-position: 35240
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sjhill@mips.com
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
Return-Path: <linux-mips-bounce@linux-mips.org>

From: "Steven J. Hill" <sjhill@mips.com>

Display the MIPS ISA version release in the /proc/cpuinfo file.

Signed-off-by: Steven J. Hill <sjhill@mips.com>
---
 arch/mips/kernel/proc.c |    6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/mips/kernel/proc.c b/arch/mips/kernel/proc.c
index 54ac39a..27ce57e 100644
--- a/arch/mips/kernel/proc.c
+++ b/arch/mips/kernel/proc.c
@@ -64,6 +64,12 @@ static int show_cpuinfo(struct seq_file *m, void *v)
 				cpu_data[n].watch_reg_masks[i]);
 		seq_printf(m, "]\n");
 	}
+	if (cpu_has_mips_r) {
+		seq_printf(m, "ISA version\t\t:");
+		if (cpu_has_mips_r1)	seq_printf(m, "%s", " r1");
+		if (cpu_has_mips_r2)	seq_printf(m, "%s", " r2");
+		seq_printf(m, "\n");
+	}
 
 	seq_printf(m, "ASEs implemented\t:");
 	if (cpu_has_mips16)	seq_printf(m, "%s", " mips16");
-- 
1.7.9.5
