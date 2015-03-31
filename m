Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 31 Mar 2015 21:50:11 +0200 (CEST)
Received: from youngberry.canonical.com ([91.189.89.112]:51249 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27014846AbbCaTuJayzPy (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 31 Mar 2015 21:50:09 +0200
Received: from [10.172.68.52] (helo=fourier)
        by youngberry.canonical.com with esmtpsa (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
        (Exim 4.71)
        (envelope-from <kamal@canonical.com>)
        id 1Yd2Ao-0000yI-4S; Tue, 31 Mar 2015 19:50:06 +0000
Received: from kamal by fourier with local (Exim 4.82)
        (envelope-from <kamal@whence.com>)
        id 1Yd2Al-0000h9-M4; Tue, 31 Mar 2015 12:50:03 -0700
From:   Kamal Mostafa <kamal@canonical.com>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        kernel-team@lists.ubuntu.com
Cc:     James Hogan <james.hogan@imgtec.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@imgtec.com>,
        Gleb Natapov <gleb@kernel.org>, kvm@vger.kernel.org,
        linux-mips@linux-mips.org, Kamal Mostafa <kamal@canonical.com>
Subject: [PATCH 3.13.y-ckt 119/143] MIPS: Export FP functions used by lose_fpu(1) for KVM
Date:   Tue, 31 Mar 2015 12:48:04 -0700
Message-Id: <1427831308-1854-120-git-send-email-kamal@canonical.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1427831308-1854-1-git-send-email-kamal@canonical.com>
References: <1427831308-1854-1-git-send-email-kamal@canonical.com>
X-Extended-Stable: 3.13
Return-Path: <kamal@canonical.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 46671
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kamal@canonical.com
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

3.13.11-ckt18 -stable review patch.  If anyone has any objections, please let me know.

------------------

From: James Hogan <james.hogan@imgtec.com>

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
Patchwork: https://patchwork.linux-mips.org/patch/9260/
Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
[james.hogan@imgtec.com: Only export when CPU_R4K_FPU=y prior to v3.16,
 so as not to break the Octeon build which excludes FPU support. KVM
 depends on MIPS32r2 anyway.]
Signed-off-by: James Hogan <james.hogan@imgtec.com>
Signed-off-by: Kamal Mostafa <kamal@canonical.com>
---
 arch/mips/kernel/mips_ksyms.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/mips/kernel/mips_ksyms.c b/arch/mips/kernel/mips_ksyms.c
index 6e58e97..cedeb56 100644
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
1.9.1
