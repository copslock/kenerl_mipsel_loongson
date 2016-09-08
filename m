Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 08 Sep 2016 14:14:39 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:42133 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23992481AbcIHMNq6lV7w (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 8 Sep 2016 14:13:46 +0200
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id 2A921C66DE2F1;
        Thu,  8 Sep 2016 13:13:26 +0100 (IST)
Received: from jhogan-linux.le.imgtec.org (192.168.154.110) by
 HHMAIL01.hh.imgtec.org (10.100.10.21) with Microsoft SMTP Server (TLS) id
 14.3.294.0; Thu, 8 Sep 2016 13:13:29 +0100
From:   James Hogan <james.hogan@imgtec.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
CC:     James Hogan <james.hogan@imgtec.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        <linux-mips@linux-mips.org>, <kvm@vger.kernel.org>
Subject: [PATCH 1/2] MIPS: KVM: Override HVA error values for EVA
Date:   Thu, 8 Sep 2016 13:13:02 +0100
Message-ID: <f408640681d7a90782c85a681d43a5c51fa8f7ea.1473335231.git-series.james.hogan@imgtec.com>
X-Mailer: git-send-email 2.9.2
MIME-Version: 1.0
In-Reply-To: <cover.4afb9d6281172d5a66d490da41c5ea418050dcea.1473335231.git-series.james.hogan@imgtec.com>
References: <cover.4afb9d6281172d5a66d490da41c5ea418050dcea.1473335231.git-series.james.hogan@imgtec.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [192.168.154.110]
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 55071
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

MIPS Enhanced Virtual Addressing (EVA) allows the user mode and kernel
mode address spaces to overlap, breaking the assumption that PAGE_OFFSET
is an appropriate KVM HVA error value, since PAGE_OFFSET may be as low
as zero.

Fix this in the same way that s390 does in commit bf640876e21f ("KVM:
s390: Make KVM_HVA_ERR_BAD usable on s390"), by overriding
KVM_HVA_ERR_[RO_]BAD and kvm_is_error_hva() in asm/kvm_host.h.

Signed-off-by: James Hogan <james.hogan@imgtec.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: "Radim Krčmář" <rkrcmar@redhat.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
Cc: kvm@vger.kernel.org
---
 arch/mips/include/asm/kvm_host.h | 14 ++++++++++++++
 1 file changed, 14 insertions(+), 0 deletions(-)

diff --git a/arch/mips/include/asm/kvm_host.h b/arch/mips/include/asm/kvm_host.h
index b54bcadd8aec..4d7e0e466b5a 100644
--- a/arch/mips/include/asm/kvm_host.h
+++ b/arch/mips/include/asm/kvm_host.h
@@ -107,6 +107,20 @@
 #define KVM_INVALID_INST		0xdeadbeef
 #define KVM_INVALID_ADDR		0xdeadbeef
 
+/*
+ * EVA has overlapping user & kernel address spaces, so user VAs may be >
+ * PAGE_OFFSET. For this reason we can't use the default KVM_HVA_ERR_BAD of
+ * PAGE_OFFSET.
+ */
+
+#define KVM_HVA_ERR_BAD			(-1UL)
+#define KVM_HVA_ERR_RO_BAD		(-2UL)
+
+static inline bool kvm_is_error_hva(unsigned long addr)
+{
+	return IS_ERR_VALUE(addr);
+}
+
 extern atomic_t kvm_mips_instance;
 
 struct kvm_vm_stat {
-- 
git-series 0.8.10
