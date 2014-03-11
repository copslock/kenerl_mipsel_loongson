Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 11 Mar 2014 22:34:54 +0100 (CET)
Received: from mx1.redhat.com ([209.132.183.28]:21557 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6869246AbaCKVdUdeSMX (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 11 Mar 2014 22:33:20 +0100
Received: from int-mx12.intmail.prod.int.phx2.redhat.com (int-mx12.intmail.prod.int.phx2.redhat.com [10.5.11.25])
        by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id s2BLXCU1010063
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK);
        Tue, 11 Mar 2014 17:33:12 -0400
Received: from paris.rdu.redhat.com (paris.rdu.redhat.com [10.13.136.28])
        by int-mx12.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id s2BLX6dk027123;
        Tue, 11 Mar 2014 17:33:11 -0400
From:   Eric Paris <eparis@redhat.com>
To:     linux-audit@redhat.com
Cc:     Eric Paris <eparis@redhat.com>,
        linux-arm-kernel@lists.infradead.org, linux-mips@linux-mips.org,
        linux-s390@vger.kernel.org, x86@kernel.org
Subject: [PATCH 2/2] audit: use uapi/linux/audit.h for AUDIT_ARCH declarations
Date:   Tue, 11 Mar 2014 17:32:58 -0400
Message-Id: <1394573578-2558-2-git-send-email-eparis@redhat.com>
In-Reply-To: <1394573578-2558-1-git-send-email-eparis@redhat.com>
References: <1394573578-2558-1-git-send-email-eparis@redhat.com>
X-Scanned-By: MIMEDefang 2.68 on 10.5.11.25
Return-Path: <eparis@redhat.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 39452
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

The syscall.h headers were including linux/audit.h but really only
needed the uapi/linux/audit.h to get the requisite defines.  Switch to
the uapi headers.

Signed-off-by: Eric Paris <eparis@redhat.com>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-mips@linux-mips.org
Cc: linux-s390@vger.kernel.org
Cc: x86@kernel.org
---
 arch/arm/include/asm/syscall.h  | 2 +-
 arch/mips/include/asm/syscall.h | 2 +-
 arch/s390/include/asm/syscall.h | 2 +-
 arch/x86/include/asm/syscall.h  | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/include/asm/syscall.h b/arch/arm/include/asm/syscall.h
index ed805f1..4651f69 100644
--- a/arch/arm/include/asm/syscall.h
+++ b/arch/arm/include/asm/syscall.h
@@ -7,7 +7,7 @@
 #ifndef _ASM_ARM_SYSCALL_H
 #define _ASM_ARM_SYSCALL_H
 
-#include <linux/audit.h> /* for AUDIT_ARCH_* */
+#include <uapi/linux/audit.h> /* for AUDIT_ARCH_* */
 #include <linux/elf.h> /* for ELF_EM */
 #include <linux/err.h>
 #include <linux/sched.h>
diff --git a/arch/mips/include/asm/syscall.h b/arch/mips/include/asm/syscall.h
index 625e709..fc556d8 100644
--- a/arch/mips/include/asm/syscall.h
+++ b/arch/mips/include/asm/syscall.h
@@ -13,7 +13,7 @@
 #ifndef __ASM_MIPS_SYSCALL_H
 #define __ASM_MIPS_SYSCALL_H
 
-#include <linux/audit.h>
+#include <uapi/linux/audit.h>
 #include <linux/elf-em.h>
 #include <linux/kernel.h>
 #include <linux/sched.h>
diff --git a/arch/s390/include/asm/syscall.h b/arch/s390/include/asm/syscall.h
index bebc0bd..7776870 100644
--- a/arch/s390/include/asm/syscall.h
+++ b/arch/s390/include/asm/syscall.h
@@ -12,7 +12,7 @@
 #ifndef _ASM_SYSCALL_H
 #define _ASM_SYSCALL_H	1
 
-#include <linux/audit.h>
+#include <uapi/linux/audit.h>
 #include <linux/sched.h>
 #include <linux/err.h>
 #include <asm/ptrace.h>
diff --git a/arch/x86/include/asm/syscall.h b/arch/x86/include/asm/syscall.h
index 7e6d0c4..d6a756a 100644
--- a/arch/x86/include/asm/syscall.h
+++ b/arch/x86/include/asm/syscall.h
@@ -13,7 +13,7 @@
 #ifndef _ASM_X86_SYSCALL_H
 #define _ASM_X86_SYSCALL_H
 
-#include <linux/audit.h>
+#include <uapi/linux/audit.h>
 #include <linux/sched.h>
 #include <linux/err.h>
 #include <asm/asm-offsets.h>	/* For NR_syscalls */
-- 
1.8.5.3
