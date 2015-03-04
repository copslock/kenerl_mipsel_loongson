Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 04 Mar 2015 07:22:31 +0100 (CET)
Received: from mail.linuxfoundation.org ([140.211.169.12]:50061 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27006966AbbCDGUuSCXRv (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 4 Mar 2015 07:20:50 +0100
Received: from localhost (unknown [166.170.43.162])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id ACCB0A73;
        Wed,  4 Mar 2015 06:20:44 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, James Hogan <james.hogan@imgtec.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@imgtec.com>,
        Gleb Natapov <gleb@kernel.org>, kvm@vger.kernel.org,
        linux-mips@linux-mips.org
Subject: [PATCH 3.19 084/175] MIPS: Export MSA functions used by lose_fpu(1) for KVM
Date:   Tue,  3 Mar 2015 22:14:22 -0800
Message-Id: <20150304061040.188488069@linuxfoundation.org>
X-Mailer: git-send-email 2.3.1
In-Reply-To: <20150304061026.134125919@linuxfoundation.org>
References: <20150304061026.134125919@linuxfoundation.org>
User-Agent: quilt/0.64
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Return-Path: <gregkh@linuxfoundation.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 46144
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: gregkh@linuxfoundation.org
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

3.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: James Hogan <james.hogan@imgtec.com>

commit ca5d25642e212f73492d332d95dc90ef46a0e8dc upstream.

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
Patchwork: https://patchwork.linux-mips.org/patch/9261/
Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/mips/kernel/mips_ksyms.c |    4 ++++
 1 file changed, 4 insertions(+)

--- a/arch/mips/kernel/mips_ksyms.c
+++ b/arch/mips/kernel/mips_ksyms.c
@@ -15,6 +15,7 @@
 #include <asm/uaccess.h>
 #include <asm/ftrace.h>
 #include <asm/fpu.h>
+#include <asm/msa.h>
 
 extern void *__bzero(void *__s, size_t __count);
 extern long __strncpy_from_kernel_nocheck_asm(char *__to,
@@ -36,6 +37,9 @@ extern long __strnlen_user_asm(const cha
  * Core architecture code
  */
 EXPORT_SYMBOL_GPL(_save_fp);
+#ifdef CONFIG_CPU_HAS_MSA
+EXPORT_SYMBOL_GPL(_save_msa);
+#endif
 
 /*
  * String functions
