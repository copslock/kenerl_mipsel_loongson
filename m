Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 04 Jun 2015 14:25:45 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:19821 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27008201AbbFDMZnnq2Bc (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 4 Jun 2015 14:25:43 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 357D9F10C235A;
        Thu,  4 Jun 2015 13:25:35 +0100 (IST)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Thu, 4 Jun 2015 13:25:37 +0100
Received: from jhogan-linux.le.imgtec.org (192.168.154.110) by
 LEMAIL01.le.imgtec.org (192.168.152.62) with Microsoft SMTP Server (TLS) id
 14.3.210.2; Thu, 4 Jun 2015 13:25:37 +0100
From:   James Hogan <james.hogan@imgtec.com>
To:     Ralf Baechle <ralf@linux-mips.org>, <linux-mips@linux-mips.org>
CC:     James Hogan <james.hogan@imgtec.com>,
        Adam Jiang <jiang.adam@gmail.com>, <stable@vger.kernel.org>
Subject: [PATCH] MIPS: Fix enabling of DEBUG_STACKOVERFLOW
Date:   Thu, 4 Jun 2015 13:25:27 +0100
Message-ID: <1433420727-19484-1-git-send-email-james.hogan@imgtec.com>
X-Mailer: git-send-email 2.3.6
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.154.110]
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 47859
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: james.hogan@imgtec.com
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
Cc: <stable@vger.kernel.org> # 2.6.37+
---
 arch/mips/kernel/irq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/mips/kernel/irq.c b/arch/mips/kernel/irq.c
index 51f57d841662..3c8a18a00a65 100644
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
2.3.6
