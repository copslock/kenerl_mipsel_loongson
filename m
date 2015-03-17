Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 17 Mar 2015 09:43:10 +0100 (CET)
Received: from ip4-83-240-67-251.cust.nbox.cz ([83.240.67.251]:44000 "EHLO
        ip4-83-240-18-248.cust.nbox.cz" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S27007654AbbCQImr1iTpt (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 17 Mar 2015 09:42:47 +0100
Received: from ku by ip4-83-240-18-248.cust.nbox.cz with local (Exim 4.85)
        (envelope-from <jslaby@suse.cz>)
        id 1YXn58-0005qs-8v; Tue, 17 Mar 2015 09:42:34 +0100
From:   Jiri Slaby <jslaby@suse.cz>
To:     stable@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, James Hogan <james.hogan@imgtec.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@imgtec.com>,
        Gleb Natapov <gleb@kernel.org>, kvm@vger.kernel.org,
        linux-mips@linux-mips.org, Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH 3.12 070/175] MIPS: Export FP functions used by lose_fpu(1) for KVM
Date:   Tue, 17 Mar 2015 09:40:48 +0100
Message-Id: <4f877b0c89a891eaea726b7972217c8252b250c7.1426581621.git.jslaby@suse.cz>
X-Mailer: git-send-email 2.3.0
In-Reply-To: <a48f1a6bfc3ee997dfd719eaecb44a05477b93e2.1426581620.git.jslaby@suse.cz>
References: <a48f1a6bfc3ee997dfd719eaecb44a05477b93e2.1426581620.git.jslaby@suse.cz>
In-Reply-To: <cover.1426581620.git.jslaby@suse.cz>
References: <cover.1426581620.git.jslaby@suse.cz>
Return-Path: <jslaby@suse.cz>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 46428
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jslaby@suse.cz
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

From: James Hogan <james.hogan@imgtec.com>

3.12-stable review patch.  If anyone has any objections, please let me know.

===============

commit 3ce465e04bfd8de9956d515d6e9587faac3375dc upstream.

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
Signed-off-by: Jiri Slaby <jslaby@suse.cz>
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
2.3.0
