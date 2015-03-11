Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 11 Mar 2015 15:49:25 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:17009 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27013353AbbCKOsMBIOKw (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 11 Mar 2015 15:48:12 +0100
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 7417696CE9B33;
        Wed, 11 Mar 2015 14:48:04 +0000 (GMT)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Wed, 11 Mar 2015 14:48:06 +0000
Received: from jhogan-linux.le.imgtec.org (192.168.154.110) by
 LEMAIL01.le.imgtec.org (192.168.152.62) with Microsoft SMTP Server (TLS) id
 14.3.210.2; Wed, 11 Mar 2015 14:48:05 +0000
From:   James Hogan <james.hogan@imgtec.com>
To:     Paolo Bonzini <pbonzini@redhat.com>, <kvm@vger.kernel.org>,
        <linux-mips@linux-mips.org>
CC:     James Hogan <james.hogan@imgtec.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Gleb Natapov <gleb@kernel.org>
Subject: [PATCH 04/20] MIPS: KVM: Implement PRid CP0 register access
Date:   Wed, 11 Mar 2015 14:44:40 +0000
Message-ID: <1426085096-12932-5-git-send-email-james.hogan@imgtec.com>
X-Mailer: git-send-email 2.0.5
In-Reply-To: <1426085096-12932-1-git-send-email-james.hogan@imgtec.com>
References: <1426085096-12932-1-git-send-email-james.hogan@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.154.110]
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 46319
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

Implement access to the guest Processor Identification CP0 register
using the KVM_GET_ONE_REG and KVM_SET_ONE_REG ioctls. This allows the
owning process to modify and read back the value that is exposed to the
guest in this register.

Signed-off-by: James Hogan <james.hogan@imgtec.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: Gleb Natapov <gleb@kernel.org>
Cc: linux-mips@linux-mips.org
Cc: kvm@vger.kernel.org
---
 Documentation/virtual/kvm/api.txt | 1 +
 arch/mips/include/asm/kvm_host.h  | 1 +
 arch/mips/kvm/mips.c              | 7 +++++++
 3 files changed, 9 insertions(+)

diff --git a/Documentation/virtual/kvm/api.txt b/Documentation/virtual/kvm/api.txt
index b112efc816f1..22dfaa31ed86 100644
--- a/Documentation/virtual/kvm/api.txt
+++ b/Documentation/virtual/kvm/api.txt
@@ -1967,6 +1967,7 @@ registers, find a list below:
   MIPS  | KVM_REG_MIPS_CP0_STATUS       | 32
   MIPS  | KVM_REG_MIPS_CP0_CAUSE        | 32
   MIPS  | KVM_REG_MIPS_CP0_EPC          | 64
+  MIPS  | KVM_REG_MIPS_CP0_PRID         | 32
   MIPS  | KVM_REG_MIPS_CP0_CONFIG       | 32
   MIPS  | KVM_REG_MIPS_CP0_CONFIG1      | 32
   MIPS  | KVM_REG_MIPS_CP0_CONFIG2      | 32
diff --git a/arch/mips/include/asm/kvm_host.h b/arch/mips/include/asm/kvm_host.h
index 8fc3ba2872f0..26d91b0f3c3c 100644
--- a/arch/mips/include/asm/kvm_host.h
+++ b/arch/mips/include/asm/kvm_host.h
@@ -42,6 +42,7 @@
 #define KVM_REG_MIPS_CP0_STATUS		MIPS_CP0_32(12, 0)
 #define KVM_REG_MIPS_CP0_CAUSE		MIPS_CP0_32(13, 0)
 #define KVM_REG_MIPS_CP0_EPC		MIPS_CP0_64(14, 0)
+#define KVM_REG_MIPS_CP0_PRID		MIPS_CP0_32(15, 0)
 #define KVM_REG_MIPS_CP0_EBASE		MIPS_CP0_64(15, 1)
 #define KVM_REG_MIPS_CP0_CONFIG		MIPS_CP0_32(16, 0)
 #define KVM_REG_MIPS_CP0_CONFIG1	MIPS_CP0_32(16, 1)
diff --git a/arch/mips/kvm/mips.c b/arch/mips/kvm/mips.c
index 399b5517ecb8..fd620cc8a44c 100644
--- a/arch/mips/kvm/mips.c
+++ b/arch/mips/kvm/mips.c
@@ -505,6 +505,7 @@ static u64 kvm_mips_get_one_regs[] = {
 	KVM_REG_MIPS_CP0_STATUS,
 	KVM_REG_MIPS_CP0_CAUSE,
 	KVM_REG_MIPS_CP0_EPC,
+	KVM_REG_MIPS_CP0_PRID,
 	KVM_REG_MIPS_CP0_CONFIG,
 	KVM_REG_MIPS_CP0_CONFIG1,
 	KVM_REG_MIPS_CP0_CONFIG2,
@@ -574,6 +575,9 @@ static int kvm_mips_get_reg(struct kvm_vcpu *vcpu,
 	case KVM_REG_MIPS_CP0_EPC:
 		v = (long)kvm_read_c0_guest_epc(cop0);
 		break;
+	case KVM_REG_MIPS_CP0_PRID:
+		v = (long)kvm_read_c0_guest_prid(cop0);
+		break;
 	case KVM_REG_MIPS_CP0_ERROREPC:
 		v = (long)kvm_read_c0_guest_errorepc(cop0);
 		break;
@@ -687,6 +691,9 @@ static int kvm_mips_set_reg(struct kvm_vcpu *vcpu,
 	case KVM_REG_MIPS_CP0_EPC:
 		kvm_write_c0_guest_epc(cop0, v);
 		break;
+	case KVM_REG_MIPS_CP0_PRID:
+		kvm_write_c0_guest_prid(cop0, v);
+		break;
 	case KVM_REG_MIPS_CP0_ERROREPC:
 		kvm_write_c0_guest_errorepc(cop0, v);
 		break;
-- 
2.0.5
