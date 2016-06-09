Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 09 Jun 2016 15:20:00 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:39237 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27034773AbcFINTjDL0Zi (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 9 Jun 2016 15:19:39 +0200
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id C989B6A674AD9;
        Thu,  9 Jun 2016 14:19:29 +0100 (IST)
Received: from jhogan-linux.le.imgtec.org (192.168.154.110) by
 HHMAIL01.hh.imgtec.org (10.100.10.21) with Microsoft SMTP Server (TLS) id
 14.3.294.0; Thu, 9 Jun 2016 14:19:32 +0100
From:   James Hogan <james.hogan@imgtec.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
CC:     James Hogan <james.hogan@imgtec.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        <linux-mips@linux-mips.org>, <kvm@vger.kernel.org>
Subject: [PATCH 01/18] MIPS: KVM: Drop unused guest_inst from kvm_vcpu_arch
Date:   Thu, 9 Jun 2016 14:19:04 +0100
Message-ID: <1465478361-7431-2-git-send-email-james.hogan@imgtec.com>
X-Mailer: git-send-email 2.4.10
In-Reply-To: <1465478361-7431-1-git-send-email-james.hogan@imgtec.com>
References: <1465478361-7431-1-git-send-email-james.hogan@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [192.168.154.110]
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 53915
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

The MIPS kvm_vcpu_arch::guest_inst isn't used, so drop it from the
struct and drop its asm-offsets definition.

Signed-off-by: James Hogan <james.hogan@imgtec.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Radim Krčmář <rkrcmar@redhat.com>
Cc: linux-mips@linux-mips.org
Cc: kvm@vger.kernel.org
---
 arch/mips/include/asm/kvm_host.h | 1 -
 arch/mips/kernel/asm-offsets.c   | 2 --
 2 files changed, 3 deletions(-)

diff --git a/arch/mips/include/asm/kvm_host.h b/arch/mips/include/asm/kvm_host.h
index 36a391d289aa..b310bb348443 100644
--- a/arch/mips/include/asm/kvm_host.h
+++ b/arch/mips/include/asm/kvm_host.h
@@ -347,7 +347,6 @@ struct kvm_vcpu_arch {
 	unsigned long host_cp0_cause;
 	unsigned long host_cp0_epc;
 	unsigned long host_cp0_entryhi;
-	uint32_t guest_inst;
 
 	/* GPRS */
 	unsigned long gprs[32];
diff --git a/arch/mips/kernel/asm-offsets.c b/arch/mips/kernel/asm-offsets.c
index 1ea973b2abb1..4d96a9033f46 100644
--- a/arch/mips/kernel/asm-offsets.c
+++ b/arch/mips/kernel/asm-offsets.c
@@ -366,8 +366,6 @@ void output_kvm_defines(void)
 	OFFSET(VCPU_HOST_EPC, kvm_vcpu_arch, host_cp0_epc);
 	OFFSET(VCPU_HOST_ENTRYHI, kvm_vcpu_arch, host_cp0_entryhi);
 
-	OFFSET(VCPU_GUEST_INST, kvm_vcpu_arch, guest_inst);
-
 	OFFSET(VCPU_R0, kvm_vcpu_arch, gprs[0]);
 	OFFSET(VCPU_R1, kvm_vcpu_arch, gprs[1]);
 	OFFSET(VCPU_R2, kvm_vcpu_arch, gprs[2]);
-- 
2.4.10
