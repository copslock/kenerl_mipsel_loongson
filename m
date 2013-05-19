Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 19 May 2013 07:53:22 +0200 (CEST)
Received: from kymasys.com ([64.62.140.43]:55916 "HELO kymasys.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with SMTP
        id S6835039Ab3ESFtLfHXOS (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sun, 19 May 2013 07:49:11 +0200
Received: from agni.kymasys.com ([75.40.23.192]) by kymasys.com for <linux-mips@linux-mips.org>; Sat, 18 May 2013 22:49:03 -0700
Received: by agni.kymasys.com (Postfix, from userid 500)
        id 4907863005D; Sat, 18 May 2013 22:47:43 -0700 (PDT)
From:   Sanjay Lal <sanjayl@kymasys.com>
To:     kvm@vger.kernel.org
Cc:     linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>,
        Gleb Natapov <gleb@redhat.com>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        Sanjay Lal <sanjayl@kymasys.com>
Subject: [PATCH 12/18] KVM/MIPS32-VZ: VM Exit Stats, add VZ exit reasons.
Date:   Sat, 18 May 2013 22:47:34 -0700
Message-Id: <1368942460-15577-13-git-send-email-sanjayl@kymasys.com>
X-Mailer: git-send-email 1.7.11.3
In-Reply-To: <1368942460-15577-1-git-send-email-sanjayl@kymasys.com>
References: <n>
 <1368942460-15577-1-git-send-email-sanjayl@kymasys.com>
Return-Path: <sanjayl@kymasys.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36469
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

- Additional VZ related exit reasons, used in the trace logs.

Signed-off-by: Sanjay Lal <sanjayl@kymasys.com>
---
 arch/mips/kvm/kvm_mips_stats.c | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/arch/mips/kvm/kvm_mips_stats.c b/arch/mips/kvm/kvm_mips_stats.c
index 075904b..c0d0c0f 100644
--- a/arch/mips/kvm/kvm_mips_stats.c
+++ b/arch/mips/kvm/kvm_mips_stats.c
@@ -3,7 +3,7 @@
 * License.  See the file "COPYING" in the main directory of this archive
 * for more details.
 *
-* KVM/MIPS: COP0 access histogram
+* KVM/MIPS: VM Exit stats, COP0 access histogram
 *
 * Copyright (C) 2012  MIPS Technologies, Inc.  All rights reserved.
 * Authors: Sanjay Lal <sanjayl@kymasys.com>
@@ -26,6 +26,21 @@ char *kvm_mips_exit_types_str[MAX_KVM_MIPS_EXIT_TYPES] = {
 	"Reserved Inst",
 	"Break Inst",
 	"D-Cache Flushes",
+#ifdef CONFIG_KVM_MIPS_VZ
+	"Hypervisor GPSI",
+	"Hypervisor GPSI [CP0]",
+	"Hypervisor GPSI [CACHE]",
+	"Hypervisor GSFC",
+	"Hypervisor GSFC [STATUS]",
+	"Hypervisor GSFC [CAUSE]",
+	"Hypervisor GSFC [INTCTL]",
+	"Hypervisor HC",
+	"Hypervisor GRR",
+	"Hypervisor GVA",
+	"Hypervisor GHFC",
+	"Hypervisor GPA",
+	"Hypervisor RESV",
+#endif
 };
 
 char *kvm_cop0_str[N_MIPS_COPROC_REGS] = {
-- 
1.7.11.3
