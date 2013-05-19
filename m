Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 19 May 2013 07:49:21 +0200 (CEST)
Received: from kymasys.com ([64.62.140.43]:42249 "HELO kymasys.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with SMTP
        id S6832029Ab3ESFsI0vVe0 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sun, 19 May 2013 07:48:08 +0200
Received: from agni.kymasys.com ([75.40.23.192]) by kymasys.com for <linux-mips@linux-mips.org>; Sat, 18 May 2013 22:47:59 -0700
Received: by agni.kymasys.com (Postfix, from userid 500)
        id 2B58E630053; Sat, 18 May 2013 22:47:43 -0700 (PDT)
From:   Sanjay Lal <sanjayl@kymasys.com>
To:     kvm@vger.kernel.org
Cc:     linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>,
        Gleb Natapov <gleb@redhat.com>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        Sanjay Lal <sanjayl@kymasys.com>
Subject: [PATCH 05/18] KVM/MIPS32-VZ: VZ-ASE assembler wrapper functions to set GuestIDs
Date:   Sat, 18 May 2013 22:47:27 -0700
Message-Id: <1368942460-15577-6-git-send-email-sanjayl@kymasys.com>
X-Mailer: git-send-email 1.7.11.3
In-Reply-To: <1368942460-15577-1-git-send-email-sanjayl@kymasys.com>
References: <n>
 <1368942460-15577-1-git-send-email-sanjayl@kymasys.com>
Return-Path: <sanjayl@kymasys.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36459
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
 arch/mips/kvm/kvm_vz_locore.S | 74 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 74 insertions(+)
 create mode 100644 arch/mips/kvm/kvm_vz_locore.S

diff --git a/arch/mips/kvm/kvm_vz_locore.S b/arch/mips/kvm/kvm_vz_locore.S
new file mode 100644
index 0000000..6d037d7
--- /dev/null
+++ b/arch/mips/kvm/kvm_vz_locore.S
@@ -0,0 +1,74 @@
+/*
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ *
+ * KVM/MIPS: Assembler support for hardware virtualization extensions
+ *
+ * Copyright (C) 2012  MIPS Technologies, Inc.  All rights reserved.
+ * Authors: Yann Le Du <ledu@kymasys.com>
+ */
+
+#include <asm/asm.h>
+#include <asm/asmmacro.h>
+#include <asm/regdef.h>
+#include <asm/mipsregs.h>
+#include <asm/asm-offsets.h>
+#include <asm/mipsvzregs.h>
+
+#define MIPSX(name)	mips32_ ## name
+
+/* 
+ * This routine sets GuestCtl1.RID to GUESTCTL1_VZ_ROOT_GUESTID
+ * Inputs: none
+ */
+LEAF(MIPSX(ClearGuestRID))
+	.set	push
+	.set	mips32r2
+	.set	noreorder
+	mfc0	t0, CP0_GUESTCTL1
+	addiu	t1, zero, GUESTCTL1_VZ_ROOT_GUESTID
+	ins	t0, t1, GUESTCTL1_RID_SHIFT, GUESTCTL1_RID_WIDTH
+	mtc0	t0, CP0_GUESTCTL1 # Set GuestCtl1.RID = GUESTCTL1_VZ_ROOT_GUESTID
+	ehb
+	j	ra
+	nop					# BD Slot
+	.set    pop
+END(MIPSX(ClearGuestRID))
+
+
+/* 
+ * This routine sets GuestCtl1.RID to a new value
+ * Inputs: a0 = new GuestRID value (right aligned)
+ */
+LEAF(MIPSX(SetGuestRID))
+	.set	push
+	.set	mips32r2
+	.set	noreorder
+	mfc0	t0, CP0_GUESTCTL1
+	ins 	t0, a0, GUESTCTL1_RID_SHIFT, GUESTCTL1_RID_WIDTH
+	mtc0	t0, CP0_GUESTCTL1		# Set GuestCtl1.RID
+	ehb
+	j	ra
+	nop					# BD Slot
+	.set	pop
+END(MIPSX(SetGuestRID))
+
+
+	/*
+	 * This routine sets GuestCtl1.RID to GuestCtl1.ID
+	 * Inputs: none
+	 */
+LEAF(MIPSX(SetGuestRIDtoGuestID))
+	.set	push
+	.set	mips32r2
+	.set	noreorder
+	mfc0	t0, CP0_GUESTCTL1		# Get current GuestID
+	ext 	t1, t0, GUESTCTL1_ID_SHIFT, GUESTCTL1_ID_WIDTH
+	ins 	t0, t1, GUESTCTL1_RID_SHIFT, GUESTCTL1_RID_WIDTH
+	mtc0	t0, CP0_GUESTCTL1		# Set GuestCtl1.RID = GuestCtl1.ID
+	ehb
+	j	ra
+	nop 					# BD Slot
+	.set	pop
+END(MIPSX(SetGuestRIDtoGuestID))
-- 
1.7.11.3
