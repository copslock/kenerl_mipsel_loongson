Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 07 Feb 2013 20:43:53 +0100 (CET)
Received: from mail-pa0-f41.google.com ([209.85.220.41]:33613 "EHLO
        mail-pa0-f41.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6827530Ab3BGTnvFdrNP (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 7 Feb 2013 20:43:51 +0100
Received: by mail-pa0-f41.google.com with SMTP id fb11so1594058pad.14
        for <multiple recipients>; Thu, 07 Feb 2013 11:43:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer;
        bh=x/ZEH/QZO8THtPcAQNJlgcCSEWTEdzjh18h0FVER7So=;
        b=PkmI8ONiG8NntCHM031cdTV2G1DqZDhhdfWEunihpvo1VH/6jORYr3fAPdHMXhZ5vE
         KePfeEHivt1ngo77spePpzBVlPuEH726tsW3dsNID23AEITE0BfOyvvQwmYJa6/1/20L
         NoVjYs21ThGojbk3zvHwUBadr2eSGUP5NdATVwZUO8OJu+7rI2S7eo8ttAuPdusOLWEM
         X9XXS5WrrzahUBik34sP0+sPS/hIpRuwCNTY7LaWLI6xbD4FZF4KDQfqI2G2uQfcBBtD
         g7BUfkyAImCBBZMuJ5j6HxZzBOR6io9XJLevd4vhFtIVzPv3TVUDFdgftF4a+Gx86oC2
         yX4A==
X-Received: by 10.66.83.165 with SMTP id r5mr9095407pay.3.1360266224039;
        Thu, 07 Feb 2013 11:43:44 -0800 (PST)
Received: from dl.caveonetworks.com (64.2.3.195.ptr.us.xo.net. [64.2.3.195])
        by mx.google.com with ESMTPS id o5sm48216756pay.5.2013.02.07.11.43.42
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Thu, 07 Feb 2013 11:43:43 -0800 (PST)
Received: from dl.caveonetworks.com (localhost.localdomain [127.0.0.1])
        by dl.caveonetworks.com (8.14.5/8.14.5) with ESMTP id r17JgfFS017797;
        Thu, 7 Feb 2013 11:42:41 -0800
Received: (from ddaney@localhost)
        by dl.caveonetworks.com (8.14.5/8.14.5/Submit) id r17JgcfJ017795;
        Thu, 7 Feb 2013 11:42:38 -0800
From:   David Daney <ddaney.cavm@gmail.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org
Cc:     David Daney <david.daney@cavium.com>,
        Sanjay Lal <sanjayl@kymasys.com>, kvm@vger.kernel.org
Subject: [RFC PATCH] MIPS/kvm: Add asm/kvm.h
Date:   Thu,  7 Feb 2013 11:42:34 -0800
Message-Id: <1360266154-17761-1-git-send-email-ddaney.cavm@gmail.com>
X-Mailer: git-send-email 1.7.11.7
X-archive-position: 35720
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney.cavm@gmail.com
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
Return-Path: <linux-mips-bounce@linux-mips.org>

From: David Daney <david.daney@cavium.com>

Uniform definitions for both 32-bit and 64-bit MIPS machines.

Signed-off-by: David Daney <david.daney@cavium.com>
Cc: Sanjay Lal <sanjayl@kymasys.com>
Cc: kvm@vger.kernel.org
---

Previously Sanjay posted a version of asm/kvm.h that worked only for
32-bit MIPS machines.  Since the MIPS kernel port also supports 64-bit
CPUs, we need a virtual machine interface that can handle both 32 and
64 bit environments.

Surly we will need to extend this, but I thought it may be a good
starting point for future enhancements.

Please comment.

 arch/mips/include/uapi/asm/kvm.h | 94 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 94 insertions(+)
 create mode 100644 arch/mips/include/uapi/asm/kvm.h

diff --git a/arch/mips/include/uapi/asm/kvm.h b/arch/mips/include/uapi/asm/kvm.h
new file mode 100644
index 0000000..caca51d
--- /dev/null
+++ b/arch/mips/include/uapi/asm/kvm.h
@@ -0,0 +1,94 @@
+#ifndef _ASM_MIPS_KVM_H
+#define _ASM_MIPS_KVM_H
+/*
+ * KVM MIPS specific structures and definitions.
+ *
+ * Some parts derived from the x86 version of this file.
+ */
+
+/* for KVM_GET_REGS and KVM_SET_REGS */
+/*
+ * If Config[AT] is zero (32-bit CPU), the register contents are
+ * stored in the lower 32-bits of the struct kvm_regs fields and sign
+ * extended to 64-bits.
+ */
+struct kvm_regs {
+	/* out (KVM_GET_REGS) / in (KVM_SET_REGS) */
+	__u64 gpr[32];
+	__u64 hi, lo;
+	__u64 pc;
+};
+
+/* for KVM_GET_FPU and KVM_SET_FPU */
+/*
+ * If Status[FR] is zero (32-bit FPU), the upper 32-bits of the FPRs
+ * are zero filled.
+ */
+struct kvm_fpu {
+	__u64 fpr[32];
+	__u32 fir;
+	__u32 fccr;
+	__u32 fexr;
+	__u32 fenr;
+	__u32 fcsr;
+	__u32 pad;
+};
+
+
+/*
+ * For MIPS, we use the same APIs as x86, where 'msr' corresponds to a
+ * CP0 register.  The index field is broken down as follows:
+ *
+ *  bits[2..0]   - Register 'sel' index.
+ *  bits[7..3]   - Register 'rd'  index.
+ *  bits[15..8]  - Must be zero.
+ *  bits[31..16] - 0 -> CP0 registers.
+ *
+ * Other sets registers may be added in the future.  Each set would
+ * have its own identifier in bits[31..16].
+ *
+ * For MSRs that are narrower than 64-bits, the value is stored in the
+ * low order bits of the data field, and sign extended to 64-bits.
+ */
+#define KVM_MIPS_MSR_CP0 0
+struct kvm_msr_entry {
+	__u32 index;
+	__u32 reserved;
+	__u64 data;
+};
+
+/* for KVM_GET_MSRS and KVM_SET_MSRS */
+struct kvm_msrs {
+	__u32 nmsrs; /* number of msrs in entries */
+	__u32 pad;
+
+	struct kvm_msr_entry entries[0];
+};
+
+/* for KVM_GET_MSR_INDEX_LIST */
+struct kvm_msr_list {
+	__u32 nmsrs; /* number of msrs in entries */
+	__u32 indices[0];
+};
+
+/*
+ * KVM MIPS specific structures and definitions
+ *
+ */
+struct kvm_debug_exit_arch {
+	__u64 epc;
+};
+
+/* for KVM_SET_GUEST_DEBUG */
+struct kvm_guest_debug_arch {
+};
+
+/* definition of registers in kvm_run */
+struct kvm_sync_regs {
+};
+
+/* dummy definition */
+struct kvm_sregs {
+};
+
+#endif /* _ASM_MIPS_KVM_H */
-- 
1.7.11.7
