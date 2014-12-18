Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 18 Dec 2014 12:02:38 +0100 (CET)
Received: from nivc-ms1.auriga.com ([80.240.102.146]:59084 "EHLO
        nivc-ms1.auriga.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27009089AbaLRLChBa3lg (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 18 Dec 2014 12:02:37 +0100
Received: from localhost (80.240.102.213) by NIVC-MS1.auriga.ru
 (80.240.102.146) with Microsoft SMTP Server (TLS) id 14.3.210.2; Thu, 18 Dec
 2014 14:02:31 +0300
From:   Aleksey Makarov <aleksey.makarov@auriga.com>
To:     <linux-mips@linux-mips.org>
CC:     <linux-kernel@vger.kernel.org>,
        David Daney <david.daney@cavium.com>,
        Aleksey Makarov <aleksey.makarov@auriga.com>,
        Ralf Baechle <ralf@linux-mips.org>
Subject: [PATCH] MIPS: Remove unneeded #ifdef __KERNEL__ from asm/processor.h
Date:   Thu, 18 Dec 2014 13:59:53 +0300
Message-ID: <1418900405-18900-1-git-send-email-aleksey.makarov@auriga.com>
X-Mailer: git-send-email 2.1.3
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [80.240.102.213]
Return-Path: <aleksey.makarov@auriga.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 44731
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: aleksey.makarov@auriga.com
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

From: David Daney <david.daney@cavium.com>

Signed-off-by: David Daney <david.daney@cavium.com>
Signed-off-by: Aleksey Makarov <aleksey.makarov@auriga.com>
---
 arch/mips/include/asm/processor.h | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/arch/mips/include/asm/processor.h b/arch/mips/include/asm/processor.h
index f1df4cb..6c10e94 100644
--- a/arch/mips/include/asm/processor.h
+++ b/arch/mips/include/asm/processor.h
@@ -54,9 +54,7 @@ extern unsigned int vced_count, vcei_count;
 #define TASK_SIZE	0x7fff8000UL
 #endif
 
-#ifdef __KERNEL__
 #define STACK_TOP_MAX	TASK_SIZE
-#endif
 
 #define TASK_IS_32BIT_ADDR 1
 
@@ -73,11 +71,7 @@ extern unsigned int vced_count, vcei_count;
 #define TASK_SIZE32	0x7fff8000UL
 #define TASK_SIZE64	0x10000000000UL
 #define TASK_SIZE (test_thread_flag(TIF_32BIT_ADDR) ? TASK_SIZE32 : TASK_SIZE64)
-
-#ifdef __KERNEL__
 #define STACK_TOP_MAX	TASK_SIZE64
-#endif
-
 
 #define TASK_SIZE_OF(tsk)						\
 	(test_tsk_thread_flag(tsk, TIF_32BIT_ADDR) ? TASK_SIZE32 : TASK_SIZE64)
-- 
2.1.3
