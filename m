Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 10 Jul 2015 17:04:48 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:20194 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27010212AbbGJPERfHGPp (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 10 Jul 2015 17:04:17 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id E5B9B8488D4CC;
        Fri, 10 Jul 2015 16:04:08 +0100 (IST)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Fri, 10 Jul 2015 16:04:11 +0100
Received: from localhost (10.100.200.2) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.210.2; Fri, 10 Jul
 2015 16:04:10 +0100
From:   Paul Burton <paul.burton@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Matthew Fortune <matthew.fortune@imgtec.com>,
        Paul Burton <paul.burton@imgtec.com>,
        Kees Cook <keescook@chromium.org>,
        Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>,
        "Maciej W. Rozycki" <macro@linux-mips.org>,
        Alex Smith <alex@alex-smith.me.uk>,
        <linux-kernel@vger.kernel.org>, "Huacai Chen" <chenhc@lemote.com>,
        Markos Chandras <markos.chandras@imgtec.com>,
        "Ralf Baechle" <ralf@linux-mips.org>
Subject: [PATCH 12/16] MIPS: AT_HWCAP aux vector infrastructure
Date:   Fri, 10 Jul 2015 16:00:21 +0100
Message-ID: <1436540426-10021-13-git-send-email-paul.burton@imgtec.com>
X-Mailer: git-send-email 2.4.4
In-Reply-To: <1436540426-10021-1-git-send-email-paul.burton@imgtec.com>
References: <1436540426-10021-1-git-send-email-paul.burton@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.100.200.2]
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 48188
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

In order for userland to determine whether various features are safe to
use, it will need to know both that the hardware supports those features
and that the kernel is recent enough & configured appropriately to
support them. For example under the O32 modeless FP proposal the dynamic
linker & ifunc resolvers will need this information.  The kernel is the
only thing in a position to know availability accurately, so the kernel
needs to provide the information to userland. This patch introduces the
infrastructure to provide the AT_HWCAP aux vector to userland in order
to provide that information. It also defines the 2 currently specified
flags, which indicate MIPSr6 & MSA support.

Signed-off-by: Paul Burton <paul.burton@imgtec.com>
---

 arch/mips/include/asm/elf.h        | 4 +++-
 arch/mips/include/uapi/asm/hwcap.h | 8 ++++++++
 arch/mips/kernel/cpu-probe.c       | 3 +++
 3 files changed, 14 insertions(+), 1 deletion(-)
 create mode 100644 arch/mips/include/uapi/asm/hwcap.h

diff --git a/arch/mips/include/asm/elf.h b/arch/mips/include/asm/elf.h
index f19e890..53b2693 100644
--- a/arch/mips/include/asm/elf.h
+++ b/arch/mips/include/asm/elf.h
@@ -382,7 +382,9 @@ do {									\
    instruction set this cpu supports.  This could be done in userspace,
    but it's not easy, and we've already done it here.  */
 
-#define ELF_HWCAP	(0)
+#define ELF_HWCAP	(elf_hwcap)
+extern unsigned int elf_hwcap;
+#include <asm/hwcap.h>
 
 /*
  * This yields a string that ld.so will use to load implementation
diff --git a/arch/mips/include/uapi/asm/hwcap.h b/arch/mips/include/uapi/asm/hwcap.h
new file mode 100644
index 0000000..c7484a7
--- /dev/null
+++ b/arch/mips/include/uapi/asm/hwcap.h
@@ -0,0 +1,8 @@
+#ifndef _UAPI_ASM_HWCAP_H
+#define _UAPI_ASM_HWCAP_H
+
+/* HWCAP flags */
+#define HWCAP_MIPS_R6		(1 << 0)
+#define HWCAP_MIPS_MSA		(1 << 1)
+
+#endif /* _UAPI_ASM_HWCAP_H */
diff --git a/arch/mips/kernel/cpu-probe.c b/arch/mips/kernel/cpu-probe.c
index 209e5b76..e184921 100644
--- a/arch/mips/kernel/cpu-probe.c
+++ b/arch/mips/kernel/cpu-probe.c
@@ -32,6 +32,9 @@
 #include <asm/spram.h>
 #include <asm/uaccess.h>
 
+/* Hardware capabilities */
+unsigned int elf_hwcap __read_mostly;
+
 /*
  * Get the FPU Implementation/Revision.
  */
-- 
2.4.4
