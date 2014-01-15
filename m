Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 15 Jan 2014 11:33:42 +0100 (CET)
Received: from multi.imgtec.com ([194.200.65.239]:10809 "EHLO multi.imgtec.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6827345AbaAOKcXfJKBm (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 15 Jan 2014 11:32:23 +0100
From:   Paul Burton <paul.burton@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Paul Burton <paul.burton@imgtec.com>
Subject: [PATCH 03/15] MIPS: add missing includes to gic.h
Date:   Wed, 15 Jan 2014 10:31:48 +0000
Message-ID: <1389781920-31151-4-git-send-email-paul.burton@imgtec.com>
X-Mailer: git-send-email 1.7.12.4
In-Reply-To: <1389781920-31151-1-git-send-email-paul.burton@imgtec.com>
References: <1389781920-31151-1-git-send-email-paul.burton@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.152.22]
X-SEF-Processed: 7_3_0_01192__2014_01_15_10_32_22
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 38987
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: paul.burton@imgtec.com
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

The gic.h header uses bitmaps and NR_CPUS, and should therefore include
linux/bitmap.h and linux/threads.h. This is in preparation for use of
this header in a subsequent commit from a C file which doesn't already
include those headers.

Signed-off-by: Paul Burton <paul.burton@imgtec.com>
---
 arch/mips/include/asm/gic.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/mips/include/asm/gic.h b/arch/mips/include/asm/gic.h
index b2e3e93..0827166 100644
--- a/arch/mips/include/asm/gic.h
+++ b/arch/mips/include/asm/gic.h
@@ -11,6 +11,9 @@
 #ifndef _ASM_GICREGS_H
 #define _ASM_GICREGS_H
 
+#include <linux/bitmap.h>
+#include <linux/threads.h>
+
 #undef	GICISBYTELITTLEENDIAN
 
 /* Constants */
-- 
1.8.4.2
