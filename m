Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 15 Sep 2015 11:12:32 +0200 (CEST)
Received: from mail.kernel.org ([198.145.29.136]:40741 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27007812AbbIOJMapx3GN (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 15 Sep 2015 11:12:30 +0200
Received: from mail.kernel.org (localhost [127.0.0.1])
        by mail.kernel.org (Postfix) with ESMTP id A6F67207D3;
        Tue, 15 Sep 2015 09:12:27 +0000 (UTC)
Received: from localhost.localdomain (unknown [183.247.163.231])
        (using TLSv1.2 with cipher AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 95345207DB;
        Tue, 15 Sep 2015 09:12:24 +0000 (UTC)
From:   lizf@kernel.org
To:     stable@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, James Hogan <james.hogan@imgtec.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Adam Jiang <jiang.adam@gmail.com>, linux-mips@linux-mips.org,
        Zefan Li <lizefan@huawei.com>
Subject: [PATCH 3.4 127/146] MIPS: Fix enabling of DEBUG_STACKOVERFLOW
Date:   Tue, 15 Sep 2015 17:04:02 +0800
Message-Id: <1442307861-32031-127-git-send-email-lizf@kernel.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1442307787-31952-1-git-send-email-lizf@kernel.org>
References: <1442307787-31952-1-git-send-email-lizf@kernel.org>
X-Virus-Scanned: ClamAV using ClamSMTP
Return-Path: <lizf@kernel.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 49202
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: lizf@kernel.org
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

From: James Hogan <james.hogan@imgtec.com>

3.4.109-rc1 review patch.  If anyone has any objections, please let me know.

------------------


commit 5f35b9cd553fd64415b563497d05a563c988dbd6 upstream.

Commit 334c86c494b9 ("MIPS: IRQ: Add stackoverflow detection") added
kernel stack overflow detection, however it only enabled it conditional
upon the preprocessor definition DEBUG_STACKOVERFLOW, which is never
actually defined. The Kconfig option is called DEBUG_STACKOVERFLOW,
which manifests to the preprocessor as CONFIG_DEBUG_STACKOVERFLOW, so
switch it to using that definition instead.

Fixes: 334c86c494b9 ("MIPS: IRQ: Add stackoverflow detection")
Signed-off-by: James Hogan <james.hogan@imgtec.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: Adam Jiang <jiang.adam@gmail.com>
Cc: linux-mips@linux-mips.org
Patchwork: http://patchwork.linux-mips.org/patch/10531/
Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
Signed-off-by: Zefan Li <lizefan@huawei.com>
---
 arch/mips/kernel/irq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/mips/kernel/irq.c b/arch/mips/kernel/irq.c
index a5aa43d..9cd8cbf 100644
--- a/arch/mips/kernel/irq.c
+++ b/arch/mips/kernel/irq.c
@@ -110,7 +110,7 @@ void __init init_IRQ(void)
 #endif
 }
 
-#ifdef DEBUG_STACKOVERFLOW
+#ifdef CONFIG_DEBUG_STACKOVERFLOW
 static inline void check_stack_overflow(void)
 {
 	unsigned long sp;
-- 
1.9.1
