Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 11 Apr 2014 04:25:51 +0200 (CEST)
Received: from mx1.redhat.com ([209.132.183.28]:39755 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6816288AbaDKCZptAO2j (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 11 Apr 2014 04:25:45 +0200
Received: from int-mx13.intmail.prod.int.phx2.redhat.com (int-mx13.intmail.prod.int.phx2.redhat.com [10.5.11.26])
        by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id s3B2Pa5L024737
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 10 Apr 2014 22:25:37 -0400
Received: from paris.rdu.redhat.com (paris.rdu.redhat.com [10.13.136.28])
        by int-mx13.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id s3B2PZ8C018479;
        Thu, 10 Apr 2014 22:25:35 -0400
From:   Eric Paris <eparis@redhat.com>
To:     linux-audit@redhat.com
Cc:     Eric Paris <eparis@redhat.com>, markos.chandras@imgtec.com,
        Paul Burton <paul.burton@imgtec.com>,
        James Hogan <james.hogan@imgtec.com>, linux-mips@linux-mips.org
Subject: [PATCH] MIPS: use current instead of task in syscall_get_arch
Date:   Thu, 10 Apr 2014 22:25:32 -0400
Message-Id: <1397183132-16528-1-git-send-email-eparis@redhat.com>
X-Scanned-By: MIMEDefang 2.68 on 10.5.11.26
Return-Path: <eparis@redhat.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 39771
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: eparis@redhat.com
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

In commit 6e345746 Markos started using task to determine 64bit vs
32bit instead of it being completely CONFIG based.

In commit 5e937a9a we dropped the 'task' argument to syscall_get_arch()
across the entire system.

This obviously results in a build failure when Linus's and the audit
tree were merged.  This patch should be applied as part of the merge
conflict, as both sides of the merge are correct and the failure happens
AT the merge.

The fix is simple.  The task is always current.  Use current.

Signed-off-by: Eric Paris <eparis@redhat.com>
Cc: markos.chandras@imgtec.com
Cc: Paul Burton <paul.burton@imgtec.com>
Cc: James Hogan <james.hogan@imgtec.com>
Cc: linux-mips@linux-mips.org
---
 arch/mips/include/asm/syscall.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/mips/include/asm/syscall.h b/arch/mips/include/asm/syscall.h
index d79cded..1258884 100644
--- a/arch/mips/include/asm/syscall.h
+++ b/arch/mips/include/asm/syscall.h
@@ -131,7 +131,7 @@ static inline int syscall_get_arch(void)
 {
 	int arch = EM_MIPS;
 #ifdef CONFIG_64BIT
-	if (!test_tsk_thread_flag(task, TIF_32BIT_REGS))
+	if (!test_tsk_thread_flag(current, TIF_32BIT_REGS))
 		arch |= __AUDIT_ARCH_64BIT;
 #endif
 #if defined(__LITTLE_ENDIAN)
-- 
1.9.0
