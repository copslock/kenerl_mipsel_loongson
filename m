Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 02 Feb 2017 13:15:58 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:8230 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23993936AbdBBMFQEyJqv (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 2 Feb 2017 13:05:16 +0100
Received: from hhmail02.hh.imgtec.org (unknown [10.100.10.20])
        by Forcepoint Email with ESMTPS id 1C135A84527B7;
        Thu,  2 Feb 2017 12:05:12 +0000 (GMT)
Received: from jhogan-linux.le.imgtec.org (192.168.154.110) by
 hhmail02.hh.imgtec.org (10.100.10.21) with Microsoft SMTP Server (TLS) id
 14.3.294.0; Thu, 2 Feb 2017 12:05:15 +0000
From:   James Hogan <james.hogan@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     James Hogan <james.hogan@imgtec.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        Ralf Baechle <ralf@linux-mips.org>, <kvm@vger.kernel.org>
Subject: [PATCH v2 27/30] KVM: MIPS/Emulate: Fix CACHE emulation for EVA hosts
Date:   Thu, 2 Feb 2017 12:04:40 +0000
Message-ID: <c385db5b00ed2223c500271231626c4d5be84598.1486036366.git-series.james.hogan@imgtec.com>
X-Mailer: git-send-email 2.11.0
MIME-Version: 1.0
In-Reply-To: <cover.e37f86dece46fc3ed00a075d68119cab361cda8e.1486036366.git-series.james.hogan@imgtec.com>
References: <cover.e37f86dece46fc3ed00a075d68119cab361cda8e.1486036366.git-series.james.hogan@imgtec.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [192.168.154.110]
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56614
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

Use protected_writeback_dcache_line() instead of flush_dcache_line(),
and protected_flush_icache_line() instead of flush_icache_line(), so
that CACHEE (the EVA variant) is used on EVA host kernels.

Without this, guest floating point branch delay slot emulation via a
trampoline on the user stack fails on EVA host kernels due to failure of
the icache sync, resulting in the break instruction getting skipped and
execution from the stack.

Signed-off-by: James Hogan <james.hogan@imgtec.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: "Radim Krčmář" <rkrcmar@redhat.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
Cc: kvm@vger.kernel.org
---
 arch/mips/kvm/emulate.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/mips/kvm/emulate.c b/arch/mips/kvm/emulate.c
index 3ced662e012e..9ac8e45017ce 100644
--- a/arch/mips/kvm/emulate.c
+++ b/arch/mips/kvm/emulate.c
@@ -1792,7 +1792,7 @@ enum emulation_result kvm_mips_emulate_cache(union mips_instruction inst,
 skip_fault:
 	/* XXXKYMA: Only a subset of cache ops are supported, used by Linux */
 	if (op_inst == Hit_Writeback_Inv_D || op_inst == Hit_Invalidate_D) {
-		flush_dcache_line(va);
+		protected_writeback_dcache_line(va);
 
 #ifdef CONFIG_KVM_MIPS_DYN_TRANS
 		/*
@@ -1802,8 +1802,8 @@ enum emulation_result kvm_mips_emulate_cache(union mips_instruction inst,
 		kvm_mips_trans_cache_va(inst, opc, vcpu);
 #endif
 	} else if (op_inst == Hit_Invalidate_I) {
-		flush_dcache_line(va);
-		flush_icache_line(va);
+		protected_writeback_dcache_line(va);
+		protected_flush_icache_line(va);
 
 #ifdef CONFIG_KVM_MIPS_DYN_TRANS
 		/* Replace the CACHE instruction, with a SYNCI */
-- 
git-series 0.8.10
