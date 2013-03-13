Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 13 Mar 2013 20:58:10 +0100 (CET)
Received: from nbd.name ([46.4.11.11]:41432 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6823112Ab3CMT6IFz68h (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 13 Mar 2013 20:58:08 +0100
From:   John Crispin <blogic@openwrt.org>
To:     ralf@linux-mips.org
Cc:     linux-mips@linux-mips.org, John Crispin <blogic@openwrt.org>
Subject: [PATCH] MIPS: fix inconsistent formatting inside /proc/cpuinfo
Date:   Wed, 13 Mar 2013 20:54:34 +0100
Message-Id: <1363204474-20924-1-git-send-email-blogic@openwrt.org>
X-Mailer: git-send-email 1.7.10.4
X-archive-position: 35885
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: blogic@openwrt.org
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

There is a missing " " inside /proc/cpuinfo.

The bad commit was:
commit a96102be700f87283f168942cd09a2b30f86f324
Author: Steven J. Hill <sjhill@mips.com>
Date:   Fri Dec 7 04:31:36 2012 +0000
MIPS: Add printing of ISA version in cpuinfo.

Signed-off-by: John Crispin <blogic@openwrt.org>
---
 arch/mips/kernel/proc.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/mips/kernel/proc.c b/arch/mips/kernel/proc.c
index 135c4aa..7a54f74 100644
--- a/arch/mips/kernel/proc.c
+++ b/arch/mips/kernel/proc.c
@@ -67,7 +67,7 @@ static int show_cpuinfo(struct seq_file *m, void *v)
 	if (cpu_has_mips_r) {
 		seq_printf(m, "isa\t\t\t:");
 		if (cpu_has_mips_1)
-			seq_printf(m, "%s", "mips1");
+			seq_printf(m, "%s", " mips1");
 		if (cpu_has_mips_2)
 			seq_printf(m, "%s", " mips2");
 		if (cpu_has_mips_3)
-- 
1.7.10.4
