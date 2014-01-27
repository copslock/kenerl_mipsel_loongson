Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 27 Jan 2014 21:21:10 +0100 (CET)
Received: from multi.imgtec.com ([194.200.65.239]:43558 "EHLO multi.imgtec.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6825759AbaA0UU2lYvee (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 27 Jan 2014 21:20:28 +0100
From:   Markos Chandras <markos.chandras@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>,
        Markos Chandras <markos.chandras@imgtec.com>
Subject: [PATCH 02/58] MIPS: asm: Add prefetch instruction for EVA
Date:   Mon, 27 Jan 2014 20:18:49 +0000
Message-ID: <1390853985-14246-3-git-send-email-markos.chandras@imgtec.com>
X-Mailer: git-send-email 1.8.5.3
In-Reply-To: <1390853985-14246-1-git-send-email-markos.chandras@imgtec.com>
References: <1390853985-14246-1-git-send-email-markos.chandras@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.154.47]
X-SEF-Processed: 7_3_0_01192__2014_01_27_20_20_23
Return-Path: <Markos.Chandras@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 39120
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

From: Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>

EVA can use the PREFE instruction to perform the virtual address
translation using the user mapping of the address rather than the
kernel mapping.

Signed-off-by: Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>
Signed-off-by: Markos Chandras <markos.chandras@imgtec.com>
---
 arch/mips/include/asm/asm.h | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/mips/include/asm/asm.h b/arch/mips/include/asm/asm.h
index 879691d..b79be18a 100644
--- a/arch/mips/include/asm/asm.h
+++ b/arch/mips/include/asm/asm.h
@@ -149,6 +149,13 @@ symbol		=	value
 		pref	hint, addr;			\
 		.set	pop
 
+#define PREFE(hint, addr)				\
+		.set	push;				\
+		.set	mips0;				\
+		.set	eva;				\
+		prefe	hint, addr;			\
+		.set	pop
+
 #define PREFX(hint,addr)				\
 		.set	push;				\
 		.set	mips4;				\
@@ -158,6 +165,7 @@ symbol		=	value
 #else /* !CONFIG_CPU_HAS_PREFETCH */
 
 #define PREF(hint, addr)
+#define PREFE(hint, addr)
 #define PREFX(hint, addr)
 
 #endif /* !CONFIG_CPU_HAS_PREFETCH */
-- 
1.8.5.3
