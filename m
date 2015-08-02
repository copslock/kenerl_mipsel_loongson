Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 02 Aug 2015 02:10:07 +0200 (CEST)
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:56771 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27012007AbbHBAJwzNu8y (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 2 Aug 2015 02:09:52 +0200
Received: from deadeye.wl.decadent.org.uk ([192.168.4.249] helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.84)
        (envelope-from <ben@decadent.org.uk>)
        id 1ZLgqX-0002cf-PD; Sun, 02 Aug 2015 01:09:45 +0100
Received: from ben by deadeye with local (Exim 4.86_RC4)
        (envelope-from <ben@decadent.org.uk>)
        id 1ZLgqT-0004jD-1q; Sun, 02 Aug 2015 01:09:41 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, "Adam Jiang" <jiang.adam@gmail.com>,
        "James Hogan" <james.hogan@imgtec.com>, linux-mips@linux-mips.org,
        "Ralf Baechle" <ralf@linux-mips.org>
Date:   Sun, 02 Aug 2015 01:02:37 +0100
Message-ID: <lsq.1438473757.611382145@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.2 121/164] MIPS: Fix enabling of DEBUG_STACKOVERFLOW
In-Reply-To: <lsq.1438473757.687525882@decadent.org.uk>
X-SA-Exim-Connect-IP: 192.168.4.249
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Return-Path: <ben@decadent.org.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 48527
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ben@decadent.org.uk
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

3.2.70-rc1 review patch.  If anyone has any objections, please let me know.

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
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 arch/mips/kernel/irq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/mips/kernel/irq.c
+++ b/arch/mips/kernel/irq.c
@@ -111,7 +111,7 @@ void __init init_IRQ(void)
 #endif
 }
 
-#ifdef DEBUG_STACKOVERFLOW
+#ifdef CONFIG_DEBUG_STACKOVERFLOW
 static inline void check_stack_overflow(void)
 {
 	unsigned long sp;
