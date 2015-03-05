Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 05 Mar 2015 17:09:19 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:38405 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27007066AbbCEQJRzEY00 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 5 Mar 2015 17:09:17 +0100
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id BAC6A327870;
        Thu,  5 Mar 2015 16:09:09 +0000 (GMT)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Thu, 5 Mar 2015 16:09:12 +0000
Received: from jhogan-linux.le.imgtec.org (192.168.154.110) by
 LEMAIL01.le.imgtec.org (192.168.152.62) with Microsoft SMTP Server (TLS) id
 14.3.210.2; Thu, 5 Mar 2015 16:09:11 +0000
From:   James Hogan <james.hogan@imgtec.com>
To:     Guenter Roeck <linux@roeck-us.net>
CC:     <linux-kernel@vger.kernel.org>, <torvalds@linux-foundation.org>,
        <akpm@linux-foundation.org>, <satoru.takeuchi@gmail.com>,
        <shuah.kh@samsung.com>, <stable@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <linux-mips@linux-mips.org>, James Hogan <james.hogan@imgtec.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@imgtec.com>,
        Gleb Natapov <gleb@kernel.org>, <kvm@vger.kernel.org>
Subject: [PATCH stable 3.10, 3.12, 3.14] MIPS: Export FP functions used by lose_fpu(1) for KVM
Date:   Thu, 5 Mar 2015 16:08:44 +0000
Message-ID: <1425571724-9480-1-git-send-email-james.hogan@imgtec.com>
X-Mailer: git-send-email 2.0.5
In-Reply-To: <54F7BE2E.8070708@roeck-us.net>
References: <54F7BE2E.8070708@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.154.110]
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 46215
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: james.hogan@imgtec.com
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

[ Upstream commit 3ce465e04bfd8de9956d515d6e9587faac3375dc ]

Export the _save_fp asm function used by the lose_fpu(1) macro to GPL
modules so that KVM can make use of it when it is built as a module.

This fixes the following build error when CONFIG_KVM=m due to commit
f798217dfd03 ("KVM: MIPS: Don't leak FPU/DSP to guest"):

ERROR: "_save_fp" [arch/mips/kvm/kvm.ko] undefined!

Signed-off-by: James Hogan <james.hogan@imgtec.com>
Fixes: f798217dfd03 (KVM: MIPS: Don't leak FPU/DSP to guest)
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: Paul Burton <paul.burton@imgtec.com>
Cc: Gleb Natapov <gleb@kernel.org>
Cc: kvm@vger.kernel.org
Cc: linux-mips@linux-mips.org
Cc: <stable@vger.kernel.org> # 3.10...3.15
Patchwork: https://patchwork.linux-mips.org/patch/9260/
Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
[james.hogan@imgtec.com: Only export when CPU_R4K_FPU=y prior to v3.16,
 so as not to break the Octeon build which excludes FPU support. KVM
 depends on MIPS32r2 anyway.]
Signed-off-by: James Hogan <james.hogan@imgtec.com>
---
Appologies for the previous cavium_octeon_defconfig link breakage.
Octeon has the symbol since 3.16, but not before. This backport should
do the trick for stable 3.10, 3.12, and 3.14. Build tested with
cavium_octeon_defconfig and malta_kvm_defconfig on those stable
branches.
---
 arch/mips/kernel/mips_ksyms.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/mips/kernel/mips_ksyms.c b/arch/mips/kernel/mips_ksyms.c
index 6e58e97fcd39..cedeb5686eb5 100644
--- a/arch/mips/kernel/mips_ksyms.c
+++ b/arch/mips/kernel/mips_ksyms.c
@@ -14,6 +14,7 @@
 #include <linux/mm.h>
 #include <asm/uaccess.h>
 #include <asm/ftrace.h>
+#include <asm/fpu.h>
 
 extern void *__bzero(void *__s, size_t __count);
 extern long __strncpy_from_user_nocheck_asm(char *__to,
@@ -26,6 +27,13 @@ extern long __strnlen_user_nocheck_asm(const char *s);
 extern long __strnlen_user_asm(const char *s);
 
 /*
+ * Core architecture code
+ */
+#ifdef CONFIG_CPU_R4K_FPU
+EXPORT_SYMBOL_GPL(_save_fp);
+#endif
+
+/*
  * String functions
  */
 EXPORT_SYMBOL(memset);
-- 
2.0.5
