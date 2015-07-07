Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 07 Jul 2015 20:24:42 +0200 (CEST)
Received: from youngberry.canonical.com ([91.189.89.112]:51695 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27013455AbbGGSYWX8FEp (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 7 Jul 2015 20:24:22 +0200
Received: from 1.general.kamal.us.vpn ([10.172.68.52] helo=fourier)
        by youngberry.canonical.com with esmtpsa (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
        (Exim 4.76)
        (envelope-from <kamal@canonical.com>)
        id 1ZCXXZ-0001w2-5H; Tue, 07 Jul 2015 18:24:21 +0000
Received: from kamal by fourier with local (Exim 4.82)
        (envelope-from <kamal@whence.com>)
        id 1ZCXXW-0002TF-Tt; Tue, 07 Jul 2015 11:24:18 -0700
From:   Kamal Mostafa <kamal@canonical.com>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        kernel-team@lists.ubuntu.com
Cc:     James Hogan <james.hogan@imgtec.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Adam Jiang <jiang.adam@gmail.com>, linux-mips@linux-mips.org,
        Kamal Mostafa <kamal@canonical.com>
Subject: [PATCH 3.19.y-ckt 065/102] MIPS: Fix enabling of DEBUG_STACKOVERFLOW
Date:   Tue,  7 Jul 2015 11:22:55 -0700
Message-Id: <1436293412-9033-66-git-send-email-kamal@canonical.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1436293412-9033-1-git-send-email-kamal@canonical.com>
References: <1436293412-9033-1-git-send-email-kamal@canonical.com>
X-Extended-Stable: 3.19
Return-Path: <kamal@canonical.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 48102
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kamal@canonical.com
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

3.19.8-ckt3 -stable review patch.  If anyone has any objections, please let me know.

------------------

From: James Hogan <james.hogan@imgtec.com>

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
Signed-off-by: Kamal Mostafa <kamal@canonical.com>
---
 arch/mips/kernel/irq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/mips/kernel/irq.c b/arch/mips/kernel/irq.c
index d2bfbc2..be15e52 100644
--- a/arch/mips/kernel/irq.c
+++ b/arch/mips/kernel/irq.c
@@ -109,7 +109,7 @@ void __init init_IRQ(void)
 #endif
 }
 
-#ifdef DEBUG_STACKOVERFLOW
+#ifdef CONFIG_DEBUG_STACKOVERFLOW
 static inline void check_stack_overflow(void)
 {
 	unsigned long sp;
-- 
1.9.1
