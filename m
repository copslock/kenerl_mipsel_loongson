Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 13 Oct 2014 23:42:17 +0200 (CEST)
Received: from filtteri5.pp.htv.fi ([213.243.153.188]:38564 "EHLO
        filtteri5.pp.htv.fi" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27011312AbaJMVmPsB8YQ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 13 Oct 2014 23:42:15 +0200
Received: from localhost (localhost [127.0.0.1])
        by filtteri5.pp.htv.fi (Postfix) with ESMTP id A11085A6F1D;
        Tue, 14 Oct 2014 00:42:07 +0300 (EEST)
X-Virus-Scanned: Debian amavisd-new at pp.htv.fi
Received: from smtp6.welho.com ([213.243.153.40])
        by localhost (filtteri5.pp.htv.fi [213.243.153.188]) (amavisd-new, port 10024)
        with ESMTP id F86Z-xEnlK3B; Tue, 14 Oct 2014 00:42:01 +0300 (EEST)
Received: from cooljazz.bb.dnainternet.fi (91-145-91-118.bb.dnainternet.fi [91.145.91.118])
        by smtp6.welho.com (Postfix) with ESMTP id C4FD05BC003;
        Tue, 14 Oct 2014 00:42:08 +0300 (EEST)
From:   Aaro Koskinen <aaro.koskinen@iki.fi>
To:     Ralf Baechle <ralf@linux-mips.org>,
        Alex Smith <alex@alex-smith.me.uk>, linux-mips@linux-mips.org
Cc:     stable@vger.kernel.org
Subject: [PATCH] MIPS: uapi/asm/ptrace.h: add a missing include
Date:   Tue, 14 Oct 2014 00:42:08 +0300
Message-Id: <1413236528-1427-1-git-send-email-aaro.koskinen@iki.fi>
X-Mailer: git-send-email 2.1.2
Return-Path: <aaro.koskinen@iki.fi>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 43256
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: aaro.koskinen@iki.fi
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

Commit a79ebea62010 (MIPS: ptrace: Fix user pt_regs definition,
use in ptrace_{get, set}regs()) converted struct pt_regs to use __u64.
Some userspace applications (e.g. GDB) include this file directly,
and fail to see this type. Fix by including <linux/types.h>.

The patch fixes the following build failure with GDB 7.8 when using
GLIBC headers created against Linux 3.17:

In file included from /home/aaro/los/work/shared/gdb-7.8/gdb/mips-linux-nat.c:37:0:
/home/aaro/los/work/mips/rootfs/mips-linux-gnu/usr/include/asm/ptrace.h:32:2: error: unknown type name '__u64'
  __u64 regs[32];
  ^
/home/aaro/los/work/mips/rootfs/mips-linux-gnu/usr/include/asm/ptrace.h:35:2: error: unknown type name '__u64'
  __u64 lo;
  ^
/home/aaro/los/work/mips/rootfs/mips-linux-gnu/usr/include/asm/ptrace.h:36:2: error: unknown type name '__u64'
  __u64 hi;
  ^

Fixes: a79ebea62010 ("MIPS: ptrace: Fix user pt_regs definition, use in ptrace_{get, set}regs()")
Cc: stable@vger.kernel.org # 3.17
Signed-off-by: Aaro Koskinen <aaro.koskinen@iki.fi>
---
 arch/mips/include/uapi/asm/ptrace.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/mips/include/uapi/asm/ptrace.h b/arch/mips/include/uapi/asm/ptrace.h
index bbcfb8b..91a3d19 100644
--- a/arch/mips/include/uapi/asm/ptrace.h
+++ b/arch/mips/include/uapi/asm/ptrace.h
@@ -9,6 +9,8 @@
 #ifndef _UAPI_ASM_PTRACE_H
 #define _UAPI_ASM_PTRACE_H
 
+#include <linux/types.h>
+
 /* 0 - 31 are integer registers, 32 - 63 are fp registers.  */
 #define FPR_BASE	32
 #define PC		64
-- 
2.1.2
