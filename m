Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 14 Mar 2017 11:35:44 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:10320 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23994916AbdCNK0HdSmrH (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 14 Mar 2017 11:26:07 +0100
Received: from hhmail02.hh.imgtec.org (unknown [10.100.10.20])
        by Forcepoint Email with ESMTPS id 0B138365506FE;
        Tue, 14 Mar 2017 10:25:58 +0000 (GMT)
Received: from jhogan-linux.le.imgtec.org (192.168.154.110) by
 hhmail02.hh.imgtec.org (10.100.10.21) with Microsoft SMTP Server (TLS) id
 14.3.294.0; Tue, 14 Mar 2017 10:26:00 +0000
From:   James Hogan <james.hogan@imgtec.com>
To:     <linux-mips@linux-mips.org>, <kvm@vger.kernel.org>
CC:     James Hogan <james.hogan@imgtec.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        David Daney <david.daney@cavium.com>,
        Andreas Herrmann <andreas.herrmann@caviumnetworks.com>
Subject: [PATCH 7/8] KVM: MIPS/VZ: Handle Octeon III guest.PRid register
Date:   Tue, 14 Mar 2017 10:25:50 +0000
Message-ID: <e4311f7327d5bf8333daa402346d262d8778da68.1489486985.git-series.james.hogan@imgtec.com>
X-Mailer: git-send-email 2.11.1
MIME-Version: 1.0
In-Reply-To: <cover.79b3feae3a98cb166c2d40a7bd4e854a5faedc89.1489486985.git-series.james.hogan@imgtec.com>
References: <cover.79b3feae3a98cb166c2d40a7bd4e854a5faedc89.1489486985.git-series.james.hogan@imgtec.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [192.168.154.110]
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 57242
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

Octeon III implements a read-only guest CP0_PRid register, so add cases
to the KVM register access API for Octeon to ensure the correct value is
read and writes are ignored.

Signed-off-by: James Hogan <james.hogan@imgtec.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: "Radim Krčmář" <rkrcmar@redhat.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: David Daney <david.daney@cavium.com>
Cc: Andreas Herrmann <andreas.herrmann@caviumnetworks.com>
Cc: linux-mips@linux-mips.org
Cc: kvm@vger.kernel.org
---
 arch/mips/include/asm/mipsregs.h |  2 ++
 arch/mips/kvm/vz.c               | 19 +++++++++++++++++--
 2 files changed, 19 insertions(+), 2 deletions(-)

diff --git a/arch/mips/include/asm/mipsregs.h b/arch/mips/include/asm/mipsregs.h
index ebe608d21d7e..6875b69f59f7 100644
--- a/arch/mips/include/asm/mipsregs.h
+++ b/arch/mips/include/asm/mipsregs.h
@@ -2025,6 +2025,8 @@ do {									\
 #define read_gc0_epc()			__read_ulong_gc0_register(14, 0)
 #define write_gc0_epc(val)		__write_ulong_gc0_register(14, 0, val)
 
+#define read_gc0_prid()			__read_32bit_gc0_register(15, 0)
+
 #define read_gc0_ebase()		__read_32bit_gc0_register(15, 1)
 #define write_gc0_ebase(val)		__write_32bit_gc0_register(15, 1, val)
 
diff --git a/arch/mips/kvm/vz.c b/arch/mips/kvm/vz.c
index 5c495277bf44..71d8856ade64 100644
--- a/arch/mips/kvm/vz.c
+++ b/arch/mips/kvm/vz.c
@@ -1938,7 +1938,15 @@ static int kvm_vz_get_one_reg(struct kvm_vcpu *vcpu,
 		*v = (long)read_gc0_epc();
 		break;
 	case KVM_REG_MIPS_CP0_PRID:
-		*v = (long)kvm_read_c0_guest_prid(cop0);
+		switch (boot_cpu_type()) {
+		case CPU_CAVIUM_OCTEON3:
+			/* Octeon III has a read-only guest.PRid */
+			*v = read_gc0_prid();
+			break;
+		default:
+			*v = (long)kvm_read_c0_guest_prid(cop0);
+			break;
+		};
 		break;
 	case KVM_REG_MIPS_CP0_EBASE:
 		*v = kvm_vz_read_gc0_ebase();
@@ -2170,7 +2178,14 @@ static int kvm_vz_set_one_reg(struct kvm_vcpu *vcpu,
 		write_gc0_epc(v);
 		break;
 	case KVM_REG_MIPS_CP0_PRID:
-		kvm_write_c0_guest_prid(cop0, v);
+		switch (boot_cpu_type()) {
+		case CPU_CAVIUM_OCTEON3:
+			/* Octeon III has a guest.PRid, but its read-only */
+			break;
+		default:
+			kvm_write_c0_guest_prid(cop0, v);
+			break;
+		};
 		break;
 	case KVM_REG_MIPS_CP0_EBASE:
 		kvm_vz_write_gc0_ebase(v);
-- 
git-series 0.8.10
