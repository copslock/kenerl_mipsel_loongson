Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 25 Apr 2018 09:39:30 +0200 (CEST)
Received: from mail.visionsystems.de ([213.209.99.202]:56327 "EHLO
        mail.visionsystems.de" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990405AbeDYHjYCj7QB (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 25 Apr 2018 09:39:24 +0200
Received: from localhost (localhost [127.0.0.1])
        by mail.visionsystems.de (Postfix) with ESMTP id 3F862363F53;
        Wed, 25 Apr 2018 09:39:17 +0200 (CEST)
Received: from mail.visionsystems.de ([127.0.0.1])
 by localhost (mail.visionsystems.de [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 15778-05; Wed, 25 Apr 2018 09:39:17 +0200 (CEST)
Received: from visionsystems.de (kallisto.visionsystems.local [192.168.1.3])
        by mail.visionsystems.de (Postfix) with ESMTP id 1FE473639CA;
        Wed, 25 Apr 2018 09:39:17 +0200 (CEST)
Received: from development1.visionsystems.de ([192.168.1.36]) by visionsystems.de with Microsoft SMTPSVC(6.0.3790.4675);
         Wed, 25 Apr 2018 09:39:16 +0200
From:   yegorslists@googlemail.com
To:     linux-mips@linux-mips.org
Cc:     ralf@linux-mips.org, jhogan@kernel.org, linux@rempel-privat.de,
        Yegor Yefremov <yegorslists@googlemail.com>
Subject: [PATCH] MIPS: kexec: fix typos
Date:   Wed, 25 Apr 2018 09:39:06 +0200
Message-Id: <20180425073906.26700-1-yegorslists@googlemail.com>
X-Mailer: git-send-email 2.17.0
X-OriginalArrivalTime: 25 Apr 2018 07:39:16.0728 (UTC) FILETIME=[83A5FF80:01D3DC68]
X-Virus-Scanned: amavisd-new at visionsystems.de
Return-Path: <Yegor.Yefremov@visionsystems.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 63755
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yegorslists@googlemail.com
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

From: Yegor Yefremov <yegorslists@googlemail.com>

Signed-off-by: Yegor Yefremov <yegorslists@googlemail.com>
---
 arch/mips/kernel/relocate_kernel.S | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/mips/kernel/relocate_kernel.S b/arch/mips/kernel/relocate_kernel.S
index c6bbf2165051..419c92197b2f 100644
--- a/arch/mips/kernel/relocate_kernel.S
+++ b/arch/mips/kernel/relocate_kernel.S
@@ -85,7 +85,7 @@ done:
 
 #ifdef CONFIG_CPU_CAVIUM_OCTEON
 	/* We need to flush I-cache before jumping to new kernel.
-	 * Unfortunatelly, this code is cpu-specific.
+	 * Unfortunately, this code is cpu-specific.
 	 */
 	.set push
 	.set noreorder
@@ -145,7 +145,7 @@ LEAF(kexec_smp_wait)
 #endif
 
 /* All parameters to new kernel are passed in registers a0-a3.
- * kexec_args[0..3] are uses to prepare register values.
+ * kexec_args[0..3] are used to prepare register values.
  */
 
 kexec_args:
-- 
2.17.0
