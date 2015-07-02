Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 02 Jul 2015 23:43:04 +0200 (CEST)
Received: from aserp1040.oracle.com ([141.146.126.69]:19546 "EHLO
        aserp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27010475AbbGBVnDWGOj8 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 2 Jul 2015 23:43:03 +0200
Received: from aserv0021.oracle.com (aserv0021.oracle.com [141.146.126.233])
        by aserp1040.oracle.com (Sentrion-MTA-4.3.2/Sentrion-MTA-4.3.2) with ESMTP id t62Lgn37003501
        (version=TLSv1 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK);
        Thu, 2 Jul 2015 21:42:51 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserv0021.oracle.com (8.13.8/8.13.8) with ESMTP id t62LgmH2012756
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=FAIL);
        Thu, 2 Jul 2015 21:42:48 GMT
Received: from abhmp0018.oracle.com (abhmp0018.oracle.com [141.146.116.24])
        by userv0122.oracle.com (8.13.8/8.13.8) with ESMTP id t62Lgmv9026838;
        Thu, 2 Jul 2015 21:42:48 GMT
Received: from lappy.hsd1.nh.comcast.net (/10.154.135.107)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 02 Jul 2015 14:42:47 -0700
From:   Sasha Levin <sasha.levin@oracle.com>
To:     stable@vger.kernel.org, stable-commits@vger.kernel.org
Cc:     James Hogan <james.hogan@imgtec.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Adam Jiang <jiang.adam@gmail.com>, linux-mips@linux-mips.org,
        Sasha Levin <sasha.levin@oracle.com>
Subject: [added to the 3.18 stable tree] MIPS: Fix enabling of DEBUG_STACKOVERFLOW
Date:   Thu,  2 Jul 2015 17:41:11 -0400
Message-Id: <1435873285-7148-28-git-send-email-sasha.levin@oracle.com>
X-Mailer: git-send-email 2.1.0
In-Reply-To: <1435873285-7148-1-git-send-email-sasha.levin@oracle.com>
References: <1435873285-7148-1-git-send-email-sasha.levin@oracle.com>
X-Source-IP: aserv0021.oracle.com [141.146.126.233]
Return-Path: <sasha.levin@oracle.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 48058
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sasha.levin@oracle.com
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

This patch has been added to the 3.18 stable tree. If you have any
objections, please let us know.

===============

This patch has been added to the 3.18 stable tree. If you have any
objections, please let us know.

===============

[ Upstream commit 5f35b9cd553fd64415b563497d05a563c988dbd6 ]

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
Patchwork: http://patchwork.linux-mips.org/patch/10531/
Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
Signed-off-by: Sasha Levin <sasha.levin@oracle.com>
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
2.1.0
