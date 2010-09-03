Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 03 Sep 2010 10:16:20 +0200 (CEST)
Received: from moutng.kundenserver.de ([212.227.17.10]:62153 "EHLO
        moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491079Ab0ICIQQ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 3 Sep 2010 10:16:16 +0200
Received: from corscience.de (DSL01.212.114.252.242.ip-pool.NEFkom.net [212.114.252.242])
        by mrelayeu.kundenserver.de (node=mreu1) with ESMTP (Nemesis)
        id 0LupVN-1OioZ53QMz-010Zi7; Fri, 03 Sep 2010 10:15:34 +0200
Received: from localhost.localdomain (unknown [192.168.102.58])
        by corscience.de (Postfix) with ESMTP id 54B2651FA1;
        Fri,  3 Sep 2010 10:15:34 +0200 (CEST)
From:   Bernhard Walle <walle@corscience.de>
To:     linux-mips@linux-mips.org
Cc:     ralf@linux-mips.org, ddaney@caviumnetworks.com,
        akpm@linux-foundation.org, ebiederm@xmission.com, hch@lst.de,
        linux-kernel@vger.kernel.org
Subject: [PATCH] MIPS: N32: Fix getdents64 syscall for n32
Date:   Fri,  3 Sep 2010 10:15:34 +0200
Message-Id: <1283501734-6532-1-git-send-email-walle@corscience.de>
X-Mailer: git-send-email 1.7.0.4
X-Provags-ID: V02:K0:80V1Up6k0zdnJ31H8L7+4YcvYB5b3HphSFXeOchfLvB
 PJmxnxjDizFnOMFLZy6OrXoa52hfKBImRO3aRy97PkVqsYVHQl
 X5F+qmtAHvlY89sVlzRbTEED21n0yWVU1XEvDvUrQWjoXsSoTG
 bFGlYRWtVTMZHYxxGigMHmQfUDUn705ztv33ubL24z5IrbSNlm
 +LYQRSUBr+lwyaPK+I6jQ==
X-archive-position: 27711
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: walle@corscience.de
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                 
X-UID: 2385

Commit 31c984a5acabea5d8c7224dc226453022be46f33 introduced a new syscall
getdents64. However, in the syscall table, the new syscall still refers
to the old getdents which doesn't work.

The problem appeared with a system that uses the eglibc 2.12-r11187
(that utilizes that new syscall) is very confused. The fix has been
tested with that eglibc version.

Signed-off-by: Bernhard Walle <walle@corscience.de>
---
 arch/mips/kernel/scall64-n32.S |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/mips/kernel/scall64-n32.S b/arch/mips/kernel/scall64-n32.S
index a3d6613..dfa8cbc 100644
--- a/arch/mips/kernel/scall64-n32.S
+++ b/arch/mips/kernel/scall64-n32.S
@@ -419,5 +419,5 @@ EXPORT(sysn32_call_table)
 	PTR	sys_perf_event_open
 	PTR	sys_accept4
 	PTR     compat_sys_recvmmsg
-	PTR     sys_getdents
+	PTR     sys_getdents64
 	.size	sysn32_call_table,.-sysn32_call_table
-- 
1.7.0.4
