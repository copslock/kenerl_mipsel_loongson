Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 29 May 2014 11:19:25 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:23973 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6823925AbaE2JRGaO3zE (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 29 May 2014 11:17:06 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 5D0697F0AE0B4;
        Thu, 29 May 2014 10:16:57 +0100 (IST)
Received: from KLMAIL02.kl.imgtec.org (192.168.5.97) by KLMAIL01.kl.imgtec.org
 (192.168.5.35) with Microsoft SMTP Server (TLS) id 14.3.181.6; Thu, 29 May
 2014 10:16:59 +0100
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 klmail02.kl.imgtec.org (192.168.5.97) with Microsoft SMTP Server (TLS) id
 14.3.181.6; Thu, 29 May 2014 10:16:59 +0100
Received: from jhogan-linux.le.imgtec.org (192.168.154.101) by
 LEMAIL01.le.imgtec.org (192.168.152.62) with Microsoft SMTP Server (TLS) id
 14.3.174.1; Thu, 29 May 2014 10:16:58 +0100
From:   James Hogan <james.hogan@imgtec.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
CC:     Andreas Herrmann <andreas.herrmann@caviumnetworks.com>,
        James Hogan <james.hogan@imgtec.com>,
        Gleb Natapov <gleb@kernel.org>, <kvm@vger.kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        <linux-mips@linux-mips.org>, David Daney <david.daney@cavium.com>,
        Sanjay Lal <sanjayl@kymasys.com>
Subject: [PATCH v2 06/23] MIPS: KVM: Move KVM_{GET,SET}_ONE_REG definitions into kvm_host.h
Date:   Thu, 29 May 2014 10:16:28 +0100
Message-ID: <1401355005-20370-7-git-send-email-james.hogan@imgtec.com>
X-Mailer: git-send-email 1.9.3
In-Reply-To: <1401355005-20370-1-git-send-email-james.hogan@imgtec.com>
References: <1401355005-20370-1-git-send-email-james.hogan@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.154.101]
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 40327
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

Move the KVM_{GET,SET}_ONE_REG MIPS register id definitions out of
kvm_mips.c to kvm_host.h so that they can be shared between multiple
source files. This allows register access to be indirected depending on
the underlying implementation (trap & emulate or VZ).

Signed-off-by: James Hogan <james.hogan@imgtec.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Gleb Natapov <gleb@kernel.org>
Cc: kvm@vger.kernel.org
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
Cc: David Daney <david.daney@cavium.com>
Cc: Sanjay Lal <sanjayl@kymasys.com>
---
 arch/mips/include/asm/kvm_host.h | 32 ++++++++++++++++++++++++++++++++
 arch/mips/kvm/kvm_mips.c         | 31 -------------------------------
 2 files changed, 32 insertions(+), 31 deletions(-)

diff --git a/arch/mips/include/asm/kvm_host.h b/arch/mips/include/asm/kvm_host.h
index f0e25c6d10b2..9f6bfc963a5b 100644
--- a/arch/mips/include/asm/kvm_host.h
+++ b/arch/mips/include/asm/kvm_host.h
@@ -19,6 +19,38 @@
 #include <linux/threads.h>
 #include <linux/spinlock.h>
 
+/* MIPS KVM register ids */
+#define MIPS_CP0_32(_R, _S)					\
+	(KVM_REG_MIPS | KVM_REG_SIZE_U32 | 0x10000 | (8 * (_R) + (_S)))
+
+#define MIPS_CP0_64(_R, _S)					\
+	(KVM_REG_MIPS | KVM_REG_SIZE_U64 | 0x10000 | (8 * (_R) + (_S)))
+
+#define KVM_REG_MIPS_CP0_INDEX		MIPS_CP0_32(0, 0)
+#define KVM_REG_MIPS_CP0_ENTRYLO0	MIPS_CP0_64(2, 0)
+#define KVM_REG_MIPS_CP0_ENTRYLO1	MIPS_CP0_64(3, 0)
+#define KVM_REG_MIPS_CP0_CONTEXT	MIPS_CP0_64(4, 0)
+#define KVM_REG_MIPS_CP0_USERLOCAL	MIPS_CP0_64(4, 2)
+#define KVM_REG_MIPS_CP0_PAGEMASK	MIPS_CP0_32(5, 0)
+#define KVM_REG_MIPS_CP0_PAGEGRAIN	MIPS_CP0_32(5, 1)
+#define KVM_REG_MIPS_CP0_WIRED		MIPS_CP0_32(6, 0)
+#define KVM_REG_MIPS_CP0_HWRENA		MIPS_CP0_32(7, 0)
+#define KVM_REG_MIPS_CP0_BADVADDR	MIPS_CP0_64(8, 0)
+#define KVM_REG_MIPS_CP0_COUNT		MIPS_CP0_32(9, 0)
+#define KVM_REG_MIPS_CP0_ENTRYHI	MIPS_CP0_64(10, 0)
+#define KVM_REG_MIPS_CP0_COMPARE	MIPS_CP0_32(11, 0)
+#define KVM_REG_MIPS_CP0_STATUS		MIPS_CP0_32(12, 0)
+#define KVM_REG_MIPS_CP0_CAUSE		MIPS_CP0_32(13, 0)
+#define KVM_REG_MIPS_CP0_EPC		MIPS_CP0_64(14, 0)
+#define KVM_REG_MIPS_CP0_EBASE		MIPS_CP0_64(15, 1)
+#define KVM_REG_MIPS_CP0_CONFIG		MIPS_CP0_32(16, 0)
+#define KVM_REG_MIPS_CP0_CONFIG1	MIPS_CP0_32(16, 1)
+#define KVM_REG_MIPS_CP0_CONFIG2	MIPS_CP0_32(16, 2)
+#define KVM_REG_MIPS_CP0_CONFIG3	MIPS_CP0_32(16, 3)
+#define KVM_REG_MIPS_CP0_CONFIG7	MIPS_CP0_32(16, 7)
+#define KVM_REG_MIPS_CP0_XCONTEXT	MIPS_CP0_64(20, 0)
+#define KVM_REG_MIPS_CP0_ERROREPC	MIPS_CP0_64(30, 0)
+
 
 #define KVM_MAX_VCPUS		1
 #define KVM_USER_MEM_SLOTS	8
diff --git a/arch/mips/kvm/kvm_mips.c b/arch/mips/kvm/kvm_mips.c
index 85d5552f0a47..a4dd796dfa67 100644
--- a/arch/mips/kvm/kvm_mips.c
+++ b/arch/mips/kvm/kvm_mips.c
@@ -491,37 +491,6 @@ kvm_arch_vcpu_ioctl_set_mpstate(struct kvm_vcpu *vcpu,
 	return -ENOIOCTLCMD;
 }
 
-#define MIPS_CP0_32(_R, _S)					\
-	(KVM_REG_MIPS | KVM_REG_SIZE_U32 | 0x10000 | (8 * (_R) + (_S)))
-
-#define MIPS_CP0_64(_R, _S)					\
-	(KVM_REG_MIPS | KVM_REG_SIZE_U64 | 0x10000 | (8 * (_R) + (_S)))
-
-#define KVM_REG_MIPS_CP0_INDEX		MIPS_CP0_32(0, 0)
-#define KVM_REG_MIPS_CP0_ENTRYLO0	MIPS_CP0_64(2, 0)
-#define KVM_REG_MIPS_CP0_ENTRYLO1	MIPS_CP0_64(3, 0)
-#define KVM_REG_MIPS_CP0_CONTEXT	MIPS_CP0_64(4, 0)
-#define KVM_REG_MIPS_CP0_USERLOCAL	MIPS_CP0_64(4, 2)
-#define KVM_REG_MIPS_CP0_PAGEMASK	MIPS_CP0_32(5, 0)
-#define KVM_REG_MIPS_CP0_PAGEGRAIN	MIPS_CP0_32(5, 1)
-#define KVM_REG_MIPS_CP0_WIRED		MIPS_CP0_32(6, 0)
-#define KVM_REG_MIPS_CP0_HWRENA		MIPS_CP0_32(7, 0)
-#define KVM_REG_MIPS_CP0_BADVADDR	MIPS_CP0_64(8, 0)
-#define KVM_REG_MIPS_CP0_COUNT		MIPS_CP0_32(9, 0)
-#define KVM_REG_MIPS_CP0_ENTRYHI	MIPS_CP0_64(10, 0)
-#define KVM_REG_MIPS_CP0_COMPARE	MIPS_CP0_32(11, 0)
-#define KVM_REG_MIPS_CP0_STATUS		MIPS_CP0_32(12, 0)
-#define KVM_REG_MIPS_CP0_CAUSE		MIPS_CP0_32(13, 0)
-#define KVM_REG_MIPS_CP0_EPC		MIPS_CP0_64(14, 0)
-#define KVM_REG_MIPS_CP0_EBASE		MIPS_CP0_64(15, 1)
-#define KVM_REG_MIPS_CP0_CONFIG		MIPS_CP0_32(16, 0)
-#define KVM_REG_MIPS_CP0_CONFIG1	MIPS_CP0_32(16, 1)
-#define KVM_REG_MIPS_CP0_CONFIG2	MIPS_CP0_32(16, 2)
-#define KVM_REG_MIPS_CP0_CONFIG3	MIPS_CP0_32(16, 3)
-#define KVM_REG_MIPS_CP0_CONFIG7	MIPS_CP0_32(16, 7)
-#define KVM_REG_MIPS_CP0_XCONTEXT	MIPS_CP0_64(20, 0)
-#define KVM_REG_MIPS_CP0_ERROREPC	MIPS_CP0_64(30, 0)
-
 static u64 kvm_mips_get_one_regs[] = {
 	KVM_REG_MIPS_R0,
 	KVM_REG_MIPS_R1,
-- 
1.9.3
