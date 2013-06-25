Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 25 Jun 2013 13:29:36 +0200 (CEST)
Received: from multi.imgtec.com ([194.200.65.239]:8207 "EHLO multi.imgtec.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6816521Ab3FYL3erJ3P4 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 25 Jun 2013 13:29:34 +0200
From:   Markos Chandras <markos.chandras@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Markos Chandras <markos.chandras@imgtec.com>,
        <sibyte-users@bitmover.com>
Subject: [PATCH] MIPS: sibyte: Platform: Add load address for CONFIG_SIBYTE_LITTLESUR
Date:   Tue, 25 Jun 2013 12:29:27 +0100
Message-ID: <1372159767-27554-1-git-send-email-markos.chandras@imgtec.com>
X-Mailer: git-send-email 1.8.2.1
MIME-Version: 1.0
Content-Type: text/plain
X-SEF-Processed: 7_3_0_01192__2013_06_25_12_29_28
Return-Path: <Markos.Chandras@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37127
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

Fixes the following build problem:
mips-linux-gnu-ld:arch/mips/kernel/vmlinux.lds:253: syntax error

because VMLINUX_LOAD_ADDRESS was an empty string for that platform
so the vmlinux.lds.S created an invalid section entry on line 50.

Signed-off-by: Markos Chandras <markos.chandras@imgtec.com>
Acked-by: Steven J. Hill <Steven.Hill@imgtec.com> 
Cc: sibyte-users@bitmover.com
---
This patch is for the upstream-sfr/mips-for-linux-next tree
---
 arch/mips/sibyte/Platform | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/mips/sibyte/Platform b/arch/mips/sibyte/Platform
index d03a075..1bf90dc 100644
--- a/arch/mips/sibyte/Platform
+++ b/arch/mips/sibyte/Platform
@@ -41,3 +41,4 @@ load-$(CONFIG_SIBYTE_RHONE)	:= 0xffffffff80100000
 load-$(CONFIG_SIBYTE_SENTOSA)	:= 0xffffffff80100000
 load-$(CONFIG_SIBYTE_SWARM)	:= 0xffffffff80100000
 load-$(CONFIG_SIBYTE_BIGSUR)	:= 0xffffffff80100000
+load-$(CONFIG_SIBYTE_LITTLESUR) := 0xffffffff80100000
-- 
1.8.2.1
