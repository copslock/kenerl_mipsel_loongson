Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 01 Nov 2014 02:59:36 +0100 (CET)
Received: from smtp.gentoo.org ([140.211.166.183]:33673 "EHLO smtp.gentoo.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27012346AbaKAB7fJX3hI (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sat, 1 Nov 2014 02:59:35 +0100
Received: from vapier.wh0rd.info (localhost [127.0.0.1])
        by smtp.gentoo.org (Postfix) with ESMTP id 3E78F340494;
        Sat,  1 Nov 2014 01:59:20 +0000 (UTC)
From:   Mike Frysinger <vapier@gentoo.org>
To:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Subject: [PATCH] MIPS: asm/ptrace.h: include linux/types.h
Date:   Fri, 31 Oct 2014 21:59:19 -0400
Message-Id: <1414807159-6036-1-git-send-email-vapier@gentoo.org>
X-Mailer: git-send-email 2.1.2
Return-Path: <vapier@gentoo.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 43815
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: vapier@gentoo.org
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

The header uses __u64 but doesn't include linux/types.h which breaks
userspace apps that try to use asm/ptrace.h.  Like gdb:

In file included from mips-linux-nat.c:37:0:
/usr/include/asm/ptrace.h:32:2: error: unknown type name '__u64'
  __u64 regs[32];

Signed-off-by: Mike Frysinger <vapier@gentoo.org>
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
