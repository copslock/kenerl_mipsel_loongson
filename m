Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 09 Dec 2013 10:49:58 +0100 (CET)
Received: from multi.imgtec.com ([194.200.65.239]:41712 "EHLO multi.imgtec.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6821408Ab3LIJt4BfHjB (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 9 Dec 2013 10:49:56 +0100
From:   Qais Yousef <qais.yousef@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Qais Yousef <qais.yousef@imgtec.com>
Subject: [PATCH v2] mips/include/asm/mipsregs.h: include linux/types.h
Date:   Mon, 9 Dec 2013 09:49:45 +0000
Message-ID: <1386582585-20867-1-git-send-email-qais.yousef@imgtec.com>
X-Mailer: git-send-email 1.7.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [192.168.154.36]
X-SEF-Processed: 7_3_0_01192__2013_12_09_09_49_50
Return-Path: <Qais.Yousef@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 38685
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: qais.yousef@imgtec.com
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

The file uses u16 type but doesn't include its definition explicitly

I was getting this error when including this header in my driver:

  arch/mips/include/asm/mipsregs.h:644:33: error: unknown type name ‘u16’

Signed-off-by: Qais Yousef <qais.yousef@imgtec.com>
Reviewed-by: Steven J. Hill <Steven.Hill@imgtec.com>
---
changes since v1:
	- include linux/types.h instead of s/u16/unsigned short/
	- amend commit message accordingly

 arch/mips/include/asm/mipsregs.h |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/mips/include/asm/mipsregs.h b/arch/mips/include/asm/mipsregs.h
index e033141..86479bb 100644
--- a/arch/mips/include/asm/mipsregs.h
+++ b/arch/mips/include/asm/mipsregs.h
@@ -14,6 +14,7 @@
 #define _ASM_MIPSREGS_H
 
 #include <linux/linkage.h>
+#include <linux/types.h>
 #include <asm/hazards.h>
 #include <asm/war.h>
 
-- 
1.7.1
