Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 01 Feb 2017 15:21:53 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:32960 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23993883AbdBAOTpCOv0g (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 1 Feb 2017 15:19:45 +0100
Received: from hhmail02.hh.imgtec.org (unknown [10.100.10.20])
        by Forcepoint Email with ESMTPS id DFC42CE0F794F;
        Wed,  1 Feb 2017 14:19:33 +0000 (GMT)
Received: from jhogan-linux.le.imgtec.org (192.168.154.110) by
 hhmail02.hh.imgtec.org (10.100.10.21) with Microsoft SMTP Server (TLS) id
 14.3.294.0; Wed, 1 Feb 2017 14:19:37 +0000
From:   James Hogan <james.hogan@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     James Hogan <james.hogan@imgtec.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        Ralf Baechle <ralf@linux-mips.org>, <kvm@vger.kernel.org>
Subject: [PATCH 5/5] KVM: MIPS/T&E: Expose read-only CP0_IntCtl register
Date:   Wed, 1 Feb 2017 14:19:27 +0000
Message-ID: <2f4690ae54de604a13aa4dba691960672f8ed52d.1485958267.git-series.james.hogan@imgtec.com>
X-Mailer: git-send-email 2.11.0
MIME-Version: 1.0
In-Reply-To: <cover.7aeb0f08d03b5d18b5332cdb1b38a8f057d310ac.1485958267.git-series.james.hogan@imgtec.com>
References: <cover.7aeb0f08d03b5d18b5332cdb1b38a8f057d310ac.1485958267.git-series.james.hogan@imgtec.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [192.168.154.110]
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56578
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

Expose the CP0_IntCtl register through the KVM register access API,
which is a required register since MIPS32r2. It is currently read-only
since the VS field isn't implemented due to lack of Config3.VInt or
Config3.VEIC.

It is implemented in trap_emul.c so that a VZ implementation can allow
writes.

Signed-off-by: James Hogan <james.hogan@imgtec.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: "Radim Krčmář" <rkrcmar@redhat.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
Cc: kvm@vger.kernel.org
---
 Documentation/virtual/kvm/api.txt | 1 +
 arch/mips/include/asm/kvm_host.h  | 1 +
 arch/mips/kvm/trap_emul.c         | 7 +++++++
 3 files changed, 9 insertions(+), 0 deletions(-)

diff --git a/Documentation/virtual/kvm/api.txt b/Documentation/virtual/kvm/api.txt
index df4a309ba56e..d34b03c99233 100644
--- a/Documentation/virtual/kvm/api.txt
+++ b/Documentation/virtual/kvm/api.txt
@@ -2073,6 +2073,7 @@ registers, find a list below:
   MIPS  | KVM_REG_MIPS_CP0_ENTRYHI      | 64
   MIPS  | KVM_REG_MIPS_CP0_COMPARE      | 32
   MIPS  | KVM_REG_MIPS_CP0_STATUS       | 32
+  MIPS  | KVM_REG_MIPS_CP0_INTCTL       | 32
   MIPS  | KVM_REG_MIPS_CP0_CAUSE        | 32
   MIPS  | KVM_REG_MIPS_CP0_EPC          | 64
   MIPS  | KVM_REG_MIPS_CP0_PRID         | 32
diff --git a/arch/mips/include/asm/kvm_host.h b/arch/mips/include/asm/kvm_host.h
index f0113ea18989..7ce72284aff8 100644
--- a/arch/mips/include/asm/kvm_host.h
+++ b/arch/mips/include/asm/kvm_host.h
@@ -43,6 +43,7 @@
 #define KVM_REG_MIPS_CP0_ENTRYHI	MIPS_CP0_64(10, 0)
 #define KVM_REG_MIPS_CP0_COMPARE	MIPS_CP0_32(11, 0)
 #define KVM_REG_MIPS_CP0_STATUS		MIPS_CP0_32(12, 0)
+#define KVM_REG_MIPS_CP0_INTCTL		MIPS_CP0_32(12, 1)
 #define KVM_REG_MIPS_CP0_CAUSE		MIPS_CP0_32(13, 0)
 #define KVM_REG_MIPS_CP0_EPC		MIPS_CP0_64(14, 0)
 #define KVM_REG_MIPS_CP0_PRID		MIPS_CP0_32(15, 0)
diff --git a/arch/mips/kvm/trap_emul.c b/arch/mips/kvm/trap_emul.c
index 9abde8ef5f26..92dd0a7ac69f 100644
--- a/arch/mips/kvm/trap_emul.c
+++ b/arch/mips/kvm/trap_emul.c
@@ -658,6 +658,7 @@ static u64 kvm_trap_emul_get_one_regs[] = {
 	KVM_REG_MIPS_CP0_ENTRYHI,
 	KVM_REG_MIPS_CP0_COMPARE,
 	KVM_REG_MIPS_CP0_STATUS,
+	KVM_REG_MIPS_CP0_INTCTL,
 	KVM_REG_MIPS_CP0_CAUSE,
 	KVM_REG_MIPS_CP0_EPC,
 	KVM_REG_MIPS_CP0_PRID,
@@ -741,6 +742,9 @@ static int kvm_trap_emul_get_one_reg(struct kvm_vcpu *vcpu,
 	case KVM_REG_MIPS_CP0_STATUS:
 		*v = (long)kvm_read_c0_guest_status(cop0);
 		break;
+	case KVM_REG_MIPS_CP0_INTCTL:
+		*v = (long)kvm_read_c0_guest_intctl(cop0);
+		break;
 	case KVM_REG_MIPS_CP0_CAUSE:
 		*v = (long)kvm_read_c0_guest_cause(cop0);
 		break;
@@ -855,6 +859,9 @@ static int kvm_trap_emul_set_one_reg(struct kvm_vcpu *vcpu,
 	case KVM_REG_MIPS_CP0_STATUS:
 		kvm_write_c0_guest_status(cop0, v);
 		break;
+	case KVM_REG_MIPS_CP0_INTCTL:
+		/* No VInt, so no VS, read-only for now */
+		break;
 	case KVM_REG_MIPS_CP0_EPC:
 		kvm_write_c0_guest_epc(cop0, v);
 		break;
-- 
git-series 0.8.10
