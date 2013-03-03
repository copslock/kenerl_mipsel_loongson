Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 03 Mar 2013 13:40:48 +0100 (CET)
Received: from arrakis.dune.hu ([78.24.191.176]:48802 "EHLO arrakis.dune.hu"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6817528Ab3CCMkrglx6D (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sun, 3 Mar 2013 13:40:47 +0100
Received: from arrakis.dune.hu ([127.0.0.1])
        by localhost (arrakis.dune.hu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id u43Dulfi1Hao; Sun,  3 Mar 2013 13:40:25 +0100 (CET)
Received: from localhost.localdomain (catvpool-576570d8.szarvasnet.hu [87.101.112.216])
        by arrakis.dune.hu (Postfix) with ESMTPSA id 676A5280956;
        Sun,  3 Mar 2013 13:40:22 +0100 (CET)
From:   Gabor Juhos <juhosg@openwrt.org>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org, Gabor Juhos <juhosg@openwrt.org>
Subject: [PATCH] MIPS: use CONFIG_CPU_MIPSR2 in csum_partial.S
Date:   Sun,  3 Mar 2013 13:39:35 +0100
Message-Id: <1362314375-25925-1-git-send-email-juhosg@openwrt.org>
X-Mailer: git-send-email 1.7.10
X-archive-position: 35838
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: juhosg@openwrt.org
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

The csum_partial implementation contain optimalizations
for the MIPS R2 instruction set. This optimalization
is never enabled however because the if directive uses
the CPU_MIPSR2 constant which is not defined anywhere.

Use the CONFIG_CPU_MIPSR2 constant instead.

Signed-off-by: Gabor Juhos <juhosg@openwrt.org>
---
 arch/mips/lib/csum_partial.S |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/mips/lib/csum_partial.S b/arch/mips/lib/csum_partial.S
index 507147a..a6adffb 100644
--- a/arch/mips/lib/csum_partial.S
+++ b/arch/mips/lib/csum_partial.S
@@ -270,7 +270,7 @@ LEAF(csum_partial)
 #endif
 
 	/* odd buffer alignment? */
-#ifdef CPU_MIPSR2
+#ifdef CONFIG_CPU_MIPSR2
 	wsbh	v1, sum
 	movn	sum, v1, t7
 #else
@@ -670,7 +670,7 @@ EXC(	sb	t0, NBYTES-2(dst), .Ls_exc)
 	addu	sum, v1
 #endif
 
-#ifdef CPU_MIPSR2
+#ifdef CONFIG_CPU_MIPSR2
 	wsbh	v1, sum
 	movn	sum, v1, odd
 #else
-- 
1.7.10
