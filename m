Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 18 May 2013 15:55:19 +0200 (CEST)
Received: from kymasys.com ([64.62.140.43]:52008 "HELO kymasys.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with SMTP
        id S6822996Ab3ERNyiIIZ0l (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sat, 18 May 2013 15:54:38 +0200
Received: from agni.kymasys.com ([75.40.23.192]) by kymasys.com for <linux-mips@linux-mips.org>; Sat, 18 May 2013 06:54:28 -0700
Received: by agni.kymasys.com (Postfix, from userid 500)
        id 4E37363003E; Sat, 18 May 2013 06:54:28 -0700 (PDT)
From:   Sanjay Lal <sanjayl@kymasys.com>
To:     linux-mips@linux-mips.org
Cc:     kvm@vger.kernel.org, ralf@linux-mips.org, gleb@redhat.com,
        mtosatti@redhat.com, Sanjay Lal <sanjayl@kymasys.com>
Subject: [PATCH 1/4] KVM/MIPS32: Move include/asm/kvm.h => include/uapi/asm/kvm.h since it is a user visible API.
Date:   Sat, 18 May 2013 06:54:23 -0700
Message-Id: <1368885266-8619-2-git-send-email-sanjayl@kymasys.com>
X-Mailer: git-send-email 1.7.11.3
In-Reply-To: <1368885266-8619-1-git-send-email-sanjayl@kymasys.com>
References: <n>
 <1368885266-8619-1-git-send-email-sanjayl@kymasys.com>
Return-Path: <sanjayl@kymasys.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36449
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sanjayl@kymasys.com
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


Signed-off-by: Sanjay Lal <sanjayl@kymasys.com>
---
 arch/mips/include/asm/kvm.h      | 55 ----------------------------------------
 arch/mips/include/uapi/asm/kvm.h | 55 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 55 insertions(+), 55 deletions(-)
 delete mode 100644 arch/mips/include/asm/kvm.h
 create mode 100644 arch/mips/include/uapi/asm/kvm.h

diff --git a/arch/mips/include/asm/kvm.h b/arch/mips/include/asm/kvm.h
deleted file mode 100644
index 85789ea..0000000
--- a/arch/mips/include/asm/kvm.h
+++ /dev/null
@@ -1,55 +0,0 @@
-/*
-* This file is subject to the terms and conditions of the GNU General Public
-* License.  See the file "COPYING" in the main directory of this archive
-* for more details.
-*
-* Copyright (C) 2012  MIPS Technologies, Inc.  All rights reserved.
-* Authors: Sanjay Lal <sanjayl@kymasys.com>
-*/
-
-#ifndef __LINUX_KVM_MIPS_H
-#define __LINUX_KVM_MIPS_H
-
-#include <linux/types.h>
-
-#define __KVM_MIPS
-
-#define N_MIPS_COPROC_REGS      32
-#define N_MIPS_COPROC_SEL   	8
-
-/* for KVM_GET_REGS and KVM_SET_REGS */
-struct kvm_regs {
-	__u32 gprs[32];
-	__u32 hi;
-	__u32 lo;
-	__u32 pc;
-
-	__u32 cp0reg[N_MIPS_COPROC_REGS][N_MIPS_COPROC_SEL];
-};
-
-/* for KVM_GET_SREGS and KVM_SET_SREGS */
-struct kvm_sregs {
-};
-
-/* for KVM_GET_FPU and KVM_SET_FPU */
-struct kvm_fpu {
-};
-
-struct kvm_debug_exit_arch {
-};
-
-/* for KVM_SET_GUEST_DEBUG */
-struct kvm_guest_debug_arch {
-};
-
-struct kvm_mips_interrupt {
-	/* in */
-	__u32 cpu;
-	__u32 irq;
-};
-
-/* definition of registers in kvm_run */
-struct kvm_sync_regs {
-};
-
-#endif /* __LINUX_KVM_MIPS_H */
diff --git a/arch/mips/include/uapi/asm/kvm.h b/arch/mips/include/uapi/asm/kvm.h
new file mode 100644
index 0000000..85789ea
--- /dev/null
+++ b/arch/mips/include/uapi/asm/kvm.h
@@ -0,0 +1,55 @@
+/*
+* This file is subject to the terms and conditions of the GNU General Public
+* License.  See the file "COPYING" in the main directory of this archive
+* for more details.
+*
+* Copyright (C) 2012  MIPS Technologies, Inc.  All rights reserved.
+* Authors: Sanjay Lal <sanjayl@kymasys.com>
+*/
+
+#ifndef __LINUX_KVM_MIPS_H
+#define __LINUX_KVM_MIPS_H
+
+#include <linux/types.h>
+
+#define __KVM_MIPS
+
+#define N_MIPS_COPROC_REGS      32
+#define N_MIPS_COPROC_SEL   	8
+
+/* for KVM_GET_REGS and KVM_SET_REGS */
+struct kvm_regs {
+	__u32 gprs[32];
+	__u32 hi;
+	__u32 lo;
+	__u32 pc;
+
+	__u32 cp0reg[N_MIPS_COPROC_REGS][N_MIPS_COPROC_SEL];
+};
+
+/* for KVM_GET_SREGS and KVM_SET_SREGS */
+struct kvm_sregs {
+};
+
+/* for KVM_GET_FPU and KVM_SET_FPU */
+struct kvm_fpu {
+};
+
+struct kvm_debug_exit_arch {
+};
+
+/* for KVM_SET_GUEST_DEBUG */
+struct kvm_guest_debug_arch {
+};
+
+struct kvm_mips_interrupt {
+	/* in */
+	__u32 cpu;
+	__u32 irq;
+};
+
+/* definition of registers in kvm_run */
+struct kvm_sync_regs {
+};
+
+#endif /* __LINUX_KVM_MIPS_H */
-- 
1.7.11.3
