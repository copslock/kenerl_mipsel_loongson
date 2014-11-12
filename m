Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 12 Nov 2014 02:28:47 +0100 (CET)
Received: from mail.linuxfoundation.org ([140.211.169.12]:53317 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27013464AbaKLB2o0Ukh4 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 12 Nov 2014 02:28:44 +0100
Received: from localhost (unknown [59.10.106.2])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 195C09AA;
        Wed, 12 Nov 2014 01:28:36 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Aaro Koskinen <aaro.koskinen@iki.fi>,
        Alex Smith <alex@alex-smith.me.uk>, linux-mips@linux-mips.org,
        Ralf Baechle <ralf@linux-mips.org>
Subject: [PATCH 3.17 144/319] MIPS: ptrace.h: Add a missing include
Date:   Wed, 12 Nov 2014 10:14:42 +0900
Message-Id: <20141112011016.330887734@linuxfoundation.org>
X-Mailer: git-send-email 2.1.3
In-Reply-To: <20141112010952.553519040@linuxfoundation.org>
References: <20141112010952.553519040@linuxfoundation.org>
User-Agent: quilt/0.63-1
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Return-Path: <gregkh@linuxfoundation.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 44018
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: gregkh@linuxfoundation.org
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

3.17-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Aaro Koskinen <aaro.koskinen@iki.fi>

commit cdb685ad44996e9a113a10002cb42d40ff29db99 upstream.

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
Signed-off-by: Aaro Koskinen <aaro.koskinen@iki.fi>
Cc: Alex Smith <alex@alex-smith.me.uk>
Cc: linux-mips@linux-mips.org
Patchwork: https://patchwork.linux-mips.org/patch/8067/
Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/mips/include/uapi/asm/ptrace.h |    2 ++
 1 file changed, 2 insertions(+)

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
