Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 17 Dec 2015 00:54:25 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:57518 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27014067AbbLPXuScBwo0 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 17 Dec 2015 00:50:18 +0100
Received: from hhmail02.hh.imgtec.org (unknown [10.100.10.20])
        by Websense Email Security Gateway with ESMTPS id 831CF2D0A32D;
        Wed, 16 Dec 2015 23:50:08 +0000 (GMT)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 hhmail02.hh.imgtec.org (10.100.10.20) with Microsoft SMTP Server (TLS) id
 14.3.235.1; Wed, 16 Dec 2015 23:50:12 +0000
Received: from jhogan-linux.le.imgtec.org (192.168.154.110) by
 LEMAIL01.le.imgtec.org (192.168.152.62) with Microsoft SMTP Server (TLS) id
 14.3.210.2; Wed, 16 Dec 2015 23:50:11 +0000
From:   James Hogan <james.hogan@imgtec.com>
To:     Ralf Baechle <ralf@linux-mips.org>,
        Paolo Bonzini <pbonzini@redhat.com>
CC:     Gleb Natapov <gleb@kernel.org>, <linux-mips@linux-mips.org>,
        <kvm@vger.kernel.org>, James Hogan <james.hogan@imgtec.com>
Subject: [PATCH 13/16] MIPS: Move KVM specific opcodes into asm/inst.h
Date:   Wed, 16 Dec 2015 23:49:38 +0000
Message-ID: <1450309781-28030-14-git-send-email-james.hogan@imgtec.com>
X-Mailer: git-send-email 2.4.10
In-Reply-To: <1450309781-28030-1-git-send-email-james.hogan@imgtec.com>
References: <1450309781-28030-1-git-send-email-james.hogan@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.154.110]
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 50661
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

The header arch/mips/kvm/opcode.h defines a few extra opcodes which
aren't in arch/mips/include/uapi/asm/inst.h. There's nothing KVM
specific about them, so lets move them into inst.h where they belong and
delete the header.

Note that mfmcz_op is renamed to mfmc0_op to match the instruction set
manual, and wait_op was already added to inst.h in commit b0a3eae2b943
("MIPS: inst.h: define COP0 wait op"), merged in v3.16-rc1.

Signed-off-by: James Hogan <james.hogan@imgtec.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Gleb Natapov <gleb@kernel.org>
Cc: linux-mips@linux-mips.org
Cc: kvm@vger.kernel.org
---
 arch/mips/include/uapi/asm/inst.h |  3 ++-
 arch/mips/kvm/emulate.c           |  7 +++----
 arch/mips/kvm/opcode.h            | 22 ----------------------
 arch/mips/kvm/trap_emul.c         |  1 -
 4 files changed, 5 insertions(+), 28 deletions(-)
 delete mode 100644 arch/mips/kvm/opcode.h

diff --git a/arch/mips/include/uapi/asm/inst.h b/arch/mips/include/uapi/asm/inst.h
index 9b44d5a816fa..b5e36a5d9e17 100644
--- a/arch/mips/include/uapi/asm/inst.h
+++ b/arch/mips/include/uapi/asm/inst.h
@@ -116,7 +116,8 @@ enum cop_op {
 	dmtc_op	      = 0x05, ctc_op	    = 0x06,
 	mthc0_op      = 0x06, mthc_op	    = 0x07,
 	bc_op	      = 0x08, bc1eqz_op     = 0x09,
-	bc1nez_op     = 0x0d, cop_op	    = 0x10,
+	mfmc0_op      = 0x0b, bc1nez_op     = 0x0d,
+	wrpgpr_op     = 0x0e, cop_op	    = 0x10,
 	copm_op	      = 0x18
 };
 
diff --git a/arch/mips/kvm/emulate.c b/arch/mips/kvm/emulate.c
index 0eb65668d2ab..845fd0d91040 100644
--- a/arch/mips/kvm/emulate.c
+++ b/arch/mips/kvm/emulate.c
@@ -30,7 +30,6 @@
 #include <asm/r4kcache.h>
 #define CONFIG_MIPS_MT
 
-#include "opcode.h"
 #include "interrupt.h"
 #include "commpage.h"
 
@@ -1240,7 +1239,7 @@ enum emulation_result kvm_mips_emulate_CP0(uint32_t inst, uint32_t *opc,
 			er = EMULATE_FAIL;
 			break;
 
-		case mfmcz_op:
+		case mfmc0_op:
 #ifdef KVM_MIPS_DEBUG_COP0_COUNTERS
 			cop0->stat[MIPS_CP0_STATUS][0]++;
 #endif
@@ -1249,11 +1248,11 @@ enum emulation_result kvm_mips_emulate_CP0(uint32_t inst, uint32_t *opc,
 				    kvm_read_c0_guest_status(cop0);
 			/* EI */
 			if (inst & 0x20) {
-				kvm_debug("[%#lx] mfmcz_op: EI\n",
+				kvm_debug("[%#lx] mfmc0_op: EI\n",
 					  vcpu->arch.pc);
 				kvm_set_c0_guest_status(cop0, ST0_IE);
 			} else {
-				kvm_debug("[%#lx] mfmcz_op: DI\n",
+				kvm_debug("[%#lx] mfmc0_op: DI\n",
 					  vcpu->arch.pc);
 				kvm_clear_c0_guest_status(cop0, ST0_IE);
 			}
diff --git a/arch/mips/kvm/opcode.h b/arch/mips/kvm/opcode.h
deleted file mode 100644
index 03a6ae84c7df..000000000000
--- a/arch/mips/kvm/opcode.h
+++ /dev/null
@@ -1,22 +0,0 @@
-/*
- * This file is subject to the terms and conditions of the GNU General Public
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
- *
- * Copyright (C) 2012  MIPS Technologies, Inc.  All rights reserved.
- * Authors: Sanjay Lal <sanjayl@kymasys.com>
- */
-
-/* Define opcode values not defined in <asm/isnt.h> */
-
-#ifndef __KVM_MIPS_OPCODE_H__
-#define __KVM_MIPS_OPCODE_H__
-
-/* COP0 Ops */
-#define mfmcz_op	0x0b	/* 01011 */
-#define wrpgpr_op	0x0e	/* 01110 */
-
-/* COP0 opcodes (only if COP0 and CO=1): */
-#define wait_op		0x20	/* 100000 */
-
-#endif /* __KVM_MIPS_OPCODE_H__ */
diff --git a/arch/mips/kvm/trap_emul.c b/arch/mips/kvm/trap_emul.c
index d836ed5b0bc7..ad988000563f 100644
--- a/arch/mips/kvm/trap_emul.c
+++ b/arch/mips/kvm/trap_emul.c
@@ -16,7 +16,6 @@
 
 #include <linux/kvm_host.h>
 
-#include "opcode.h"
 #include "interrupt.h"
 
 static gpa_t kvm_trap_emul_gva_to_gpa_cb(gva_t gva)
-- 
2.4.10
