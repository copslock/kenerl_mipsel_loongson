Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 05 Jul 2017 22:03:06 +0200 (CEST)
Received: from smtprelay0081.hostedemail.com ([216.40.44.81]:47655 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S23993894AbdGEUC5iKDws (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 5 Jul 2017 22:02:57 +0200
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay05.hostedemail.com (Postfix) with ESMTP id 1DB8F1808D232;
        Wed,  5 Jul 2017 20:02:56 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: fork56_8de97f0eb1214
X-Filterd-Recvd-Size: 1447
Received: from joe-laptop.perches.com (unknown [47.151.132.55])
        (Authenticated sender: joe@perches.com)
        by omf07.hostedemail.com (Postfix) with ESMTPA;
        Wed,  5 Jul 2017 20:02:55 +0000 (UTC)
From:   Joe Perches <joe@perches.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Cc:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Subject: [PATCH 09/18] MIPS: SMP: Move asmlinkage before return type
Date:   Wed,  5 Jul 2017 13:02:18 -0700
Message-Id: <756d3fb543e981b9284e756fa27616725a354b28.1499284835.git.joe@perches.com>
X-Mailer: git-send-email 2.10.0.rc2.1.g053435c
In-Reply-To: <cover.1499284835.git.joe@perches.com>
References: <cover.1499284835.git.joe@perches.com>
Return-Path: <joe@perches.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 59023
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: joe@perches.com
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

Make the code like the rest of the kernel.

Signed-off-by: Joe Perches <joe@perches.com>
---
 arch/mips/include/asm/smp.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/mips/include/asm/smp.h b/arch/mips/include/asm/smp.h
index 98a117a05fbc..bab3d41e5987 100644
--- a/arch/mips/include/asm/smp.h
+++ b/arch/mips/include/asm/smp.h
@@ -47,7 +47,7 @@ extern int __cpu_logical_map[NR_CPUS];
 /* Mask of CPUs which are currently definitely operating coherently */
 extern cpumask_t cpu_coherent_mask;
 
-extern void asmlinkage smp_bootstrap(void);
+extern asmlinkage void smp_bootstrap(void);
 
 extern void calculate_cpu_foreign_map(void);
 
-- 
2.10.0.rc2.1.g053435c
