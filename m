Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 10 Feb 2015 11:03:59 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:2259 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27013125AbbBJKDZ2ugIN (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 10 Feb 2015 11:03:25 +0100
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 99CAFF26E65E2;
        Tue, 10 Feb 2015 10:03:17 +0000 (GMT)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Tue, 10 Feb 2015 10:03:19 +0000
Received: from jhogan-linux.le.imgtec.org (192.168.154.110) by
 LEMAIL01.le.imgtec.org (192.168.152.62) with Microsoft SMTP Server (TLS) id
 14.3.210.2; Tue, 10 Feb 2015 10:03:19 +0000
From:   James Hogan <james.hogan@imgtec.com>
To:     Paolo Bonzini <pbonzini@redhat.com>,
        Ralf Baechle <ralf@linux-mips.org>
CC:     James Hogan <james.hogan@imgtec.com>,
        Paul Burton <paul.burton@imgtec.com>,
        Gleb Natapov <gleb@kernel.org>, <kvm@vger.kernel.org>,
        <linux-mips@linux-mips.org>, <stable@vger.kernel.org>
Subject: [PATCH 2/2] MIPS: Export MSA functions used by lose_fpu(1) for KVM
Date:   Tue, 10 Feb 2015 10:03:00 +0000
Message-ID: <1423562580-23254-3-git-send-email-james.hogan@imgtec.com>
X-Mailer: git-send-email 2.0.5
In-Reply-To: <1423562580-23254-1-git-send-email-james.hogan@imgtec.com>
References: <1423562580-23254-1-git-send-email-james.hogan@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.154.110]
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 45795
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

Export the _save_msa asm function used by the lose_fpu(1) macro to GPL
modules so that KVM can make use of it when it is built as a module.

This fixes the following build error when CONFIG_KVM=m and
CONFIG_CPU_HAS_MSA=y due to commit f798217dfd03 ("KVM: MIPS: Don't leak
FPU/DSP to guest"):

ERROR: "_save_msa" [arch/mips/kvm/kvm.ko] undefined!

Fixes: f798217dfd03 (KVM: MIPS: Don't leak FPU/DSP to guest)
Signed-off-by: James Hogan <james.hogan@imgtec.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: Paul Burton <paul.burton@imgtec.com>
Cc: Gleb Natapov <gleb@kernel.org>
Cc: kvm@vger.kernel.org
Cc: linux-mips@linux-mips.org
Cc: <stable@vger.kernel.org> # 3.15+
---
Separated from the _save_fp patch so they can be applied separately to
stable, since this one only applies since v3.15.
---
 arch/mips/kernel/mips_ksyms.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/mips/kernel/mips_ksyms.c b/arch/mips/kernel/mips_ksyms.c
index 167ce3fae398..1a73c6c9e4b7 100644
--- a/arch/mips/kernel/mips_ksyms.c
+++ b/arch/mips/kernel/mips_ksyms.c
@@ -15,6 +15,7 @@
 #include <asm/uaccess.h>
 #include <asm/ftrace.h>
 #include <asm/fpu.h>
+#include <asm/msa.h>
 
 extern void *__bzero(void *__s, size_t __count);
 extern long __strncpy_from_kernel_nocheck_asm(char *__to,
@@ -36,6 +37,9 @@ extern long __strnlen_user_asm(const char *s);
  * Core architecture code
  */
 EXPORT_SYMBOL_GPL(_save_fp);
+#ifdef CONFIG_CPU_HAS_MSA
+EXPORT_SYMBOL_GPL(_save_msa);
+#endif
 
 /*
  * String functions
-- 
2.0.5
