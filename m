Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 14 Mar 2017 11:27:47 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:14493 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23994818AbdCNKS227LVU (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 14 Mar 2017 11:18:28 +0100
Received: from hhmail02.hh.imgtec.org (unknown [10.100.10.20])
        by Forcepoint Email with ESMTPS id 93EE0DA8844B4;
        Tue, 14 Mar 2017 10:18:16 +0000 (GMT)
Received: from jhogan-linux.le.imgtec.org (192.168.154.110) by
 hhmail02.hh.imgtec.org (10.100.10.21) with Microsoft SMTP Server (TLS) id
 14.3.294.0; Tue, 14 Mar 2017 10:18:19 +0000
From:   James Hogan <james.hogan@imgtec.com>
To:     <linux-mips@linux-mips.org>, <kvm@vger.kernel.org>
CC:     James Hogan <james.hogan@imgtec.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        Ralf Baechle <ralf@linux-mips.org>
Subject: [PATCH v2 22/33] KVM: MIPS/Emulate: Drop CACHE emulation for VZ
Date:   Tue, 14 Mar 2017 10:15:29 +0000
Message-ID: <c916890e0543cb63ca5935e91d309335cf4b27d6.1489485940.git-series.james.hogan@imgtec.com>
X-Mailer: git-send-email 2.11.1
MIME-Version: 1.0
In-Reply-To: <cover.26e10ec77a4ed0d3177ccf4fabf57bc95ea030f8.1489485940.git-series.james.hogan@imgtec.com>
References: <cover.26e10ec77a4ed0d3177ccf4fabf57bc95ea030f8.1489485940.git-series.james.hogan@imgtec.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [192.168.154.110]
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 57223
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

Ifdef out the trap & emulate CACHE instruction emulation functions for
VZ. We will provide separate CACHE instruction emulation in vz.c, and we
need to avoid linker errors due to the use of T&E specific MMU helpers.

Signed-off-by: James Hogan <james.hogan@imgtec.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: "Radim Krčmář" <rkrcmar@redhat.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
Cc: kvm@vger.kernel.org
---
 arch/mips/kvm/emulate.c | 2 ++
 1 file changed, 2 insertions(+), 0 deletions(-)

diff --git a/arch/mips/kvm/emulate.c b/arch/mips/kvm/emulate.c
index 42424822898c..bb0449296cd6 100644
--- a/arch/mips/kvm/emulate.c
+++ b/arch/mips/kvm/emulate.c
@@ -1665,6 +1665,7 @@ enum emulation_result kvm_mips_emulate_load(union mips_instruction inst,
 	return EMULATE_DO_MMIO;
 }
 
+#ifndef CONFIG_KVM_MIPS_VZ
 static enum emulation_result kvm_mips_guest_cache_op(int (*fn)(unsigned long),
 						     unsigned long curr_pc,
 						     unsigned long addr,
@@ -1872,6 +1873,7 @@ enum emulation_result kvm_mips_emulate_inst(u32 cause, u32 *opc,
 
 	return er;
 }
+#endif /* CONFIG_KVM_MIPS_VZ */
 
 /**
  * kvm_mips_guest_exception_base() - Find guest exception vector base address.
-- 
git-series 0.8.10
